module.exports = (sequelize, DataTypes) => {
  
  const Student = sequelize.define('Student', {
    firstName: {
      type: DataTypes.STRING,
      allowNull: false
    },
    middleName: {
      type: DataTypes.STRING,
      allowNull: true
    },
    lastName: {
      type: DataTypes.STRING
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    idNumber: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    rfId: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    photoUrl: {
      type: DataTypes.STRING,
      allowNull: true
    },
    yearLevel: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    section: {
      type: DataTypes.STRING,
      allowNull: true
    }
  }, {
    tableName: 'Student' // Explicitly specify table name if different
  });

  /**
   * Relationships
   * @param {*} models 
   */
  Student.associate = function(models) {
    Student.hasMany(models.Attendance, { foreignKey: 'StudentId' });
    Student.hasMany(models.Enrolled, { foreignKey: 'StudentId' });
  };

  /**
   * Hook to automatically create an enrolled record after a student is created or updated
   */
  Student.afterCreate(async (student, options) => {
    const setting = await sequelize.models.Setting.findOne(); // Assuming there's a Setting model

    const enrolled = await sequelize.models.Enrolled.findOne({
      where: { 
        StudentId: student.id, 
        semester: setting.activeSemester, 
        acadYear: setting.activeAcadYear}, 
    });
    
    if (enrolled) {
      // Update the yearLevel and section if the enrolled record exists
      await enrolled.update({
        yearLevel: student.yearLevel,
        section: student.section
      });
    }else{
      // Create a new enrolled record if it doesn't exist
      await sequelize.models.Enrolled.create({
        StudentId: student.id,
        yearLevel: student.yearLevel,
        section: student.section,
        semester: setting.activeSemester, // From Setting model
        acadYear: setting.activeAcadYear  // From Setting model
      });

    }

  });

  /**
   * Optional: AfterUpdate Hook to update the enrolled record after a student is updated
   */
  Student.afterUpdate(async (student, options) => {
    const setting = await sequelize.models.Setting.findOne();

    const enrolled = await sequelize.models.Enrolled.findOne({
      where: { 
        StudentId: student.id, 
        semester: setting.activeSemester, 
        acadYear: setting.activeAcadYear 
      }
    });

    if (enrolled) {
      // Update yearLevel and section if the enrolled record exists
      await enrolled.update({
        yearLevel: student.yearLevel,
        section: student.section
      });
    } else {
      // If no enrollment record exists for this semester/year, create a new one
      await sequelize.models.Enrolled.create({
        StudentId: student.id,
        yearLevel: student.yearLevel,
        section: student.section,
        semester: setting.activeSemester,
        acadYear: setting.activeAcadYear
      });
    }
  });


  return Student;
};

