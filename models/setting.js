module.exports = (sequelize, DataTypes) => {
    const Setting = sequelize.define('Setting', {
      activeSemester: {
        type: DataTypes.STRING,
        defaultValue: "1",
        allowNull: false
      },
      activeAcadYear: {
        type: DataTypes.STRING,
        defaultValue: "2024-2025",
        allowNull: false
      }

    }, {
      tableName: 'Setting' // Explicitly specify table name if different
    });

    /**
     * Hook to check if there is an entry in the table after sync
     * Add 1 row if table is empty
     */
    Setting.afterSync(async (options) => {
      const settingCount = await Setting.count(); // Count rows in the Setting table
      
      if (settingCount === 0) {
        // If no rows exist, create a default row
        await Setting.create({
          activeSemester: "1",      // Default value
          activeAcadYear: "2024-2025"  // Default value
        });
      }
    });

    return Setting;
  };
  