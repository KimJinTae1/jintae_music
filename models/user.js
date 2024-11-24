// models/user.js

const { Sequelize, DataTypes } = require("sequelize");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});

// sequelize.sync({ force: true });

// 사용자 모델 정의
const User = sequelize.define("User", {
  UID: {
    type: DataTypes.INTEGER,
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
  },
  id: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  user_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  register_date: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW,
  },
  is_banned: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
  },
  is_admin: {
    type: DataTypes.TINYINT,
    allowNull: false,
    defaultValue: false,
  },
});

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();

    // sequelize.sync({ force: true });
    console.log("User table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = User;
