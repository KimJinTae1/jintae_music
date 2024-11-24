// models/user.js

const { Sequelize, DataTypes } = require("sequelize");
const PlayList = require("./playlist");
const Music = require("./music");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});

// 사용자 모델 정의
const PlayListSet = sequelize.define("PlayListSet", {
  playlist_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    foreignKey: true,
  },
  music_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    foreignKey: true,
  },
});

// 관계 설정
PlayListSet.associate = (models) => {
  PlayListSet.belongsTo(models.PlayList, {
    foreignKey: "playlist_id",
    targetKey: "playlist_id", // PlayList 모델의 primary key
    onDelete: "CASCADE",
  });

  PlayListSet.belongsTo(models.Music, {
    foreignKey: "music_id",
    targetKey: "music_id", // Music 모델의 primary key
    onDelete: "CASCADE",
  });
};

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();
    // sequelize.sync({ force: true });
    console.log("PlayListSet table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = PlayListSet;
