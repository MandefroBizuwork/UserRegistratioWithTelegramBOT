const fs = require('fs');

const logAction = (action, message) => {
  const logMessage = `${new Date().toISOString()} - ${action}: ${message}\n`;
  fs.appendFileSync('bot.log', logMessage);
};

module.exports = { logAction };