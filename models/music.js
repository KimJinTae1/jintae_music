// models/music.js

const { Sequelize, DataTypes } = require("sequelize");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});

// 사용자 모델 정의
const Music = sequelize.define("Music", {
  music_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  composer: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  albumName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  artist: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  recommendation: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: false,
  },
  total_play_count: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: false,
  },
  monthly_play_count: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: false,
  },
  release_date: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW,
  },
  lyrics: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  file_path: {
    type: DataTypes.STRING,
    allowNull: false,
    foreignKey: true,
  },
  make_admin_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    foreignKey: true,
  },
});

// 관계 설정
Music.associate = (models) => {
  Music.belongsTo(models.Admin, {
    foreignKey: "make_admin_id",
    targetKey: "admin_id", // Admin 모델의 primary key
    onDelete: "CASCADE",
  });
};

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();
    // sequelize.sync({ force: true });
    console.log("Music table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = Music;
