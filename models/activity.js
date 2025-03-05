module.exports = (sequelize, DataTypes) => {
    const Activity = sequelize.define('Activity', {
      date: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
        allowNull: false
      },
      inAMStart: {
        type: DataTypes.TIME,
        allowNull: true
      },
      inAMEnd: {
        type: DataTypes.TIME,
        allowNull: true
      },
      outAMStart: {
        type: DataTypes.TIME,
        allowNull: true
      },
      outAMEnd: {
        type: DataTypes.TIME,
        allowNull: true
      },
      inPMStart: {
        type: DataTypes.TIME,
        allowNull: true
      },
      inPMEnd: {
        type: DataTypes.TIME,
        allowNull: true
      },
      outPMStart: {
        type: DataTypes.TIME,
        allowNull: true
      },
      outPMEnd: {
        type: DataTypes.TIME,
        allowNull: true
      },
      activityName: {
        type: DataTypes.STRING,
        allowNull: false
      },
      semester: {
        type: DataTypes.STRING,
        allowNull: false
      },
      acadYear: {
        type: DataTypes.STRING,
        allowNull: false
      }

    }, {
      tableName: 'Activity' // Explicitly specify table name if different
    });

    /**
     * Relationship
     * @param {*} models 
     */
    Activity.associate = function(models) {
        Activity.hasMany(models.Attendance, { foreignKey: 'ActivityId' });
    };
  
    return Activity;
  };
  