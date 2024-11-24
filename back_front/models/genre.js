// models/user.js

const { Sequelize, DataTypes } = require("sequelize");
const Music = require("./music");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});

// sequelize.sync({ force: true });

// 사용자 모델 정의
const Genre = sequelize.define("Genre", {
  music_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    foreignKey: true,
  },
  genre_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  createdAt: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW,
  },
  updatedAt: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW,
  },
});

// 관계 설정
Genre.belongsTo(Music, {
  foreignKey: "music_id",
  as: "music",
  onDelete: "CASCADE",
});

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();
    console.log("Genre table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = Genre;
