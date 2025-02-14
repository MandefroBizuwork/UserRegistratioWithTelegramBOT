require("dotenv").config();
const { Telegraf, session } = require("telegraf");
const { sequelize, connectDB } = require("./database");
const User = require("./Models/User");
const Admin = require("./Models/Admin");
const { logAction } = require("./logger");

// Connect to Database
connectDB();
sequelize.sync();

const bot = new Telegraf(process.env.BOT_TOKEN);

// Add session middleware to your bot
bot.use(session());

// Ensure session is initialized
bot.use((ctx, next) => {
  if (!ctx.session) {
    ctx.session = {};
  }
  return next();
});

// Middleware to check if the user is an admin
const isAdmin = async (ctx, next) => {
  const userId = ctx.from.id;
  const admin = await Admin.findOne({ where: { telegramId: userId } });

  if (admin) {
    console.log(`User ${ctx.from.username} is an admin.`);
    return next(); // Proceed to the command
  } else {
    console.log(`User ${ctx.from.username} is not an admin.`);
    ctx.reply("❌ You do not have permission to access this command.");
    return; // Stop here
  }
};

// Admin commands
bot.command("manage_user", isAdmin, async (ctx) => {
  console.log(`User ${ctx.from.username} accessed /manage_user.`);
  ctx.reply('👥 User Management Options:\n********************************\n\n1. Show all users ==> /list_users\n2. Remove a user ==> type "/remove_user @username"\n3. Give a user admin access ==> Type /promote_admin @username\n\n********************************\n\nPlease select an option by typing the command.');
});

bot.command("help", async (ctx) => {
  console.log(`User ${ctx.from.username} accessed /help.`);
  ctx.reply('📋 Command Options:\n********************************\n\n1. Start bot ==> /start\n2. Show all users ==> /list_users\n3. Manage users ==> /manage_user\n4. View profile ==> /my_profile\n\n********************************\n\nPlease select an option by typing the command.');
});

// List users
bot.command("list_users", isAdmin, async (ctx) => {
  const users = await User.findAll();
  if (users.length === 0) return ctx.reply("No registered users yet.");

  let response = "👥 Registered Users:\n";
  users.forEach((user, index) => {
    response += `${index + 1}. ${user.fullName} (@${user.username || "N/A"})\n`;
  });

  logAction("LIST_USERS", `Admin ${ctx.from.username} requested user list.`);
  ctx.reply(response);
});

// Promote Admin
bot.command("promote_admin", isAdmin, async (ctx) => {
  try {
    const args = ctx.message.text.split(" ");
    const identifier = args[1]; // Can be @username or Telegram ID

    if (!identifier) return ctx.reply("❌ Please specify a username or Telegram ID to promote.");

    // Super Admin Check (Only Super Admins can promote others)
    const superAdmin = await Admin.findOne({ where: { telegramId: ctx.from.id, role: "superadmin" } });
    if (!superAdmin) {
      return ctx.reply("❌ Only Super Admins can promote users to Admin.");
    }

    let user;

    // Check if identifier is a numeric Telegram ID
    if (/^\d+$/.test(identifier)) {
      user = await User.findOne({ where: { telegramId: identifier } });
    } else {
      // Remove '@' from username if present
      const cleanUsername = identifier.replace("@", "");
      user = await User.findOne({ where: { username: cleanUsername } });
    }

    if (!user) {
      console.error(`❌ User not found: ${identifier}`);
      return ctx.reply("❌ User not found. Please check the username or ID and try again.");
    }

    // Check if user is already an admin
    const existingAdmin = await Admin.findOne({ where: { telegramId: user.telegramId } });
    if (existingAdmin) return ctx.reply("❌ This user is already an Admin.");

    // Promote the user to Admin
    await Admin.create({
      telegramId: user.telegramId,
      username: user.username,
      fullName: user.fullName,
      role: "admin", // Default role
    });

    logAction("PROMOTE_ADMIN", `Super Admin ${ctx.from.username} promoted ${user.fullName} (@${user.username || "N/A"}) to Admin.`);

    ctx.reply(`✅ User ${user.fullName} (@${user.username || "N/A"}) has been promoted to Admin.`);
  } catch (error) {
    console.error("❌ Error in promote_admin command:", error);
    ctx.reply("⚠️ An error occurred while promoting the user. Please try again.");
  }
});

// Remove user
bot.command("remove_user", isAdmin, async (ctx) => {
  try {
    const args = ctx.message.text.split(" ");
    const identifier = args[1]; // Username or Telegram ID

    if (!identifier) return ctx.reply("❌ Please specify a username or Telegram ID to remove.");

    let user;

    // Check if identifier is a numeric Telegram ID
    if (/^\d+$/.test(identifier)) {
      user = await User.findOne({ where: { telegramId: identifier } });
    } else {
      // Remove '@' from username if present
      const cleanUsername = identifier.replace("@", "");
      user = await User.findOne({ where: { username: cleanUsername } });
    }

    if (!user) {
      console.error(`❌ User not found: ${identifier}`);
      return ctx.reply("❌ User not found. Please check the username or ID and try again.");
    }

    // Check if the user is an admin
    const adminUser = await Admin.findOne({ where: { telegramId: user.telegramId } });
    if (adminUser) return ctx.reply("❌ Can't remove an admin user!");

    console.log(`✅ Removing user: ${user.fullName} (@${user.username || "N/A"})`);

    await User.destroy({ where: { telegramId: user.telegramId } });

    logAction("REMOVE_USER", `Admin ${ctx.from.username} removed user: ${user.fullName} (@${user.username || "N/A"}).`);

    ctx.reply(`✅ User ${user.fullName} (@${user.username || "N/A"}) has been removed.`);
  } catch (error) {
    console.error("❌ Error in remove_user command:", error);
    ctx.reply("⚠️ An error occurred while trying to remove the user. Please try again.");
  }
});

// My Profile Command
bot.command("my_profile", async (ctx) => {
  const telegramId = ctx.from.id.toString();
  const user = await User.findOne({ where: { telegramId } });

  if (!user) return ctx.reply("❌ You are not registered.");

  ctx.reply(`👤 Profile Info:
  📛 Name: ${user.fullName}
  📧 Email: ${user.email}
  📞 Phone: ${user.phone}`);
});

// Start command handler
bot.start(async (ctx) => {
  const userId = ctx.from.id;
  const user = await User.findOne({ where: { telegramId: userId } });

  if (!user) {
    ctx.session.registrationStep = "fullName";
    return ctx.reply("📝 Please provide your full name:");
  }

  // Check if the user is an admin
  const admin = await Admin.findOne({ where: { telegramId: userId } });
  ctx.state.isAdmin = !!admin; // Set isAdmin state

  if (ctx.state.isAdmin) {
    return ctx.reply('👨‍💼 Welcome, Admin! You can manage users now.\nUser Management Options:\n********************************\n\n1. Show all users ==> /list_users\n2. Remove a user ==> type "/remove_user @username"\n3. Give a user admin access ==> Type /promote_admin @username\n\n********************************\n\nPlease select an option by typing the command.');
  }

  return ctx.reply('✅ You are already registered! View your profile here\n/my_profile');
});

// Handle User Registration
bot.on("text", async (ctx) => {
  // Check if we are in a registration step
  if (ctx.session.registrationStep) {
    // Handle registration steps first (do not treat as commands)
    const userId = ctx.from.id;
    const text = ctx.message.text;

    if (ctx.session.registrationStep === "fullName") {
      ctx.session.fullName = text;
      // Ensure the name is valid (letters and spaces only)
      if (!/^[a-zA-Z\s]+$/.test(ctx.session.fullName)) {
        return ctx.reply("❌ Please enter a valid name (only letters and spaces are allowed).");
      }

      ctx.session.registrationStep = "email";
      return ctx.reply("📧 Please provide your email:");
    }

    if (ctx.session.registrationStep === "email") {
      ctx.session.email = text;
      const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

      if (!emailRegex.test(ctx.session.email)) {
        return ctx.reply("❌ Please provide a valid email address.");
      }

      ctx.session.registrationStep = "phone";
      return ctx.reply("📞 Please provide your phone number:");
    }

    if (ctx.session.registrationStep === "phone") {
      ctx.session.phone = text;
      if (!/^\d{10}$/.test(ctx.session.phone)) {
        return ctx.reply("❌ Please provide a valid phone number (10 digits).");
      }

      // Save to Database
      await User.create({
        telegramId: userId,
        fullName: ctx.session.fullName,
        email: ctx.session.email,
        phone: ctx.session.phone,
        username: ctx.from.username || null,
      });

      // Clear session
      ctx.session = null;

      return ctx.reply("✅ Registration completed! You can view your profile here\n /my_profile");
    }

    return; // Stop here if we're in a registration step
  }

  // Validate commands only if not in registration flow
  const messageText = ctx.message.text.trim();
  const command = messageText.split(' ')[0];  // Get the first word (command)

  // List of predefined commands
  const validCommands = ['/start', '/help', '/my_profile', '/manage_user', '/list_users', '/remove_user', '/promote_admin'];

  // Check if the entered message is a valid command
  if (!validCommands.includes(command)) {
    return ctx.reply("❌ Invalid command. Type /help to see the list of available commands.");
  }
});



// Start Bot


bot.launch();
console.log("🚀 Bot is running...");

// Set bot commands after launching the bot
bot.telegram.setMyCommands([
  { command: "start", description: "Start the bot" },
  { command: "help", description: "Show all commands" },
  { command: "my_profile", description: "View your profile" },
  { command: "update_profile", description: "Update your profile info" },
  { command: "manage_user", description: "Admin options" }, // Fixed name 
]).then(() => console.log("✅ Bot commands set successfully!"));



