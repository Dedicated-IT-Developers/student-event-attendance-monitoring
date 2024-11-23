module.exports = (sequelize, DataTypes) => {
  
    const Enrolled = sequelize.define('Enrolled', {
        StudentId: {
        type: DataTypes.INTEGER,
        references: {
          model: 'Student',
          key: 'id',
        },
        allowNull: false,
      },
      yearLevel: {
        type: DataTypes.INTEGER,
        allowNull: false
      },
      section: {
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
      tableName: 'Enrolled'
    });

    /**
     * Relationship
     * @param {*} models 
     */
    Enrolled.associate = function(models) {
        Enrolled.belongsTo(models.Student, { foreignKey: 'StudentId' });
    };


    return Enrolled;
  };
  