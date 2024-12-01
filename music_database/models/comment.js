const { Sequelize, DataTypes } = require("sequelize");
const User = require("./user");
const Music = require("./music");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});

// 사용자 모델 정의
const Comment = sequelize.define("Comment", {
  comment_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
  },
  user_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  music_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  content: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  created_at: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW,
  },
  reported: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: false,
  },
  is_blocked: {
    type: DataTypes.TINYINT,
    allowNull: false,
    defaultValue: false,
  },
});

// 관계 설정 (외래 키 관계)
Comment.belongsTo(User, {
  foreignKey: "user_id", // Comment 모델의 외래 키
  as: "user", // 관계의 별칭 (user를 호출할 때 사용)
});

Comment.belongsTo(Music, {
  foreignKey: "music_id", // Comment 모델의 외래 키
  as: "music", // 관계의 별칭 (music을 호출할 때 사용)
});

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();
    console.log("comment table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = Comment;
