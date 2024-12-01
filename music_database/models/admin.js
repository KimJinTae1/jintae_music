// models/user.js

const { Sequelize, DataTypes } = require("sequelize");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});
 
// sequelize.sync({ force: true });

// 사용자 모델 정의
const Admin = sequelize.define("Admin", {
  admin_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
  },
  admin_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  admin_password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
});

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();
    console.log("User table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = Admin;
