// models/user.js

const { Sequelize, DataTypes } = require("sequelize");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});

// 사용자 모델 정의
const PlayList = sequelize.define("PlayList", {
  playlist_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
  },
  playlist_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  playlist_description: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  playlist_created_at: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW,
  },
  is_open: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
  },
  maker_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    foreignKey: true,
  },
});

// 관계 설정
PlayList.associate = (models) => {
  PlayList.belongsTo(models.User, {
    foreignKey: "maker_id",
    targetKey: "UID", // User 모델의 primary key
    onDelete: "CASCADE",
  });
};

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();
    // sequelize.sync({ force: true });
    console.log("PlayList table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = PlayList;
