require('dotenv').config();

const { Sequelize } = require('sequelize');

/**
 * Database Connection
 * Passing parameters separately (other dialects)
 */
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_HOST,
  dialect: 'postgres',
  logging: false,
});

(async () => {
  try {
    await sequelize.authenticate();
    console.log('Connection has been established successfully.');
  } catch (error) {
    console.error('Unable to connect to the database:', error);
  }
})();
  

const db = {};
db.Sequelize = Sequelize;
db.sequelize = sequelize;

/**
 * Require Models
 */
db.Student = require('./student')(sequelize, Sequelize);
db.Activity = require('./activity')(sequelize, Sequelize);
db.Attendance = require('./attendance')(sequelize, Sequelize);
db.Setting = require('./setting')(sequelize, Sequelize);
db.Enrolled = require('./enrolled')(sequelize, Sequelize);
db.users = require('./users')(sequelize, Sequelize);      // users Model
db.logs = require('./logs')(sequelize, Sequelize);        // logs Model

/**
 * Relationships
 */
db.Student.hasMany(db.Attendance, { foreignKey: 'StudentId' });
db.Activity.hasMany(db.Attendance, { foreignKey: 'ActivityId' });
db.Attendance.belongsTo(db.Student, { foreignKey: 'StudentId' });
db.Attendance.belongsTo(db.Activity, { foreignKey: 'ActivityId' });
db.Student.hasMany(db.Enrolled, { foreignKey: 'StudentId' });
db.Enrolled.belongsTo(db.Student, { foreignKey: 'StudentId' });

module.exports = db;