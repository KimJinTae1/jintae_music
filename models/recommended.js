const { Sequelize, DataTypes } = require("sequelize");
const Users = require("./user");
const Music = require("./music");

// 데이터베이스 연결 설정
const sequelize = new Sequelize("jintae_music", "root", "1234", {
  host: "localhost",
  dialect: "mysql",
});

// 사용자 모델 정의
const Recommended = sequelize.define("Recommended", {
  UID: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: Users, // Users 테이블을 참조
      key: "UID", // Users 테이블의 UID 컬럼을 참조
    },
  },
  music_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: Music, // Music 테이블을 참조
      key: "music_id", // Music 테이블의 music_id 컬럼을 참조
    },
  },
});

// 관계 설정
Recommended.belongsTo(Users, { foreignKey: "UID", onDelete: "CASCADE" });
Recommended.belongsTo(Music, { foreignKey: "music_id", onDelete: "CASCADE" });

// 모델 동기화 (테이블 생성)
(async () => {
  try {
    await sequelize.sync();
    // sequelize.sync({ force: true });
    console.log("Recommended table has been created.");
  } catch (error) {
    console.error("Error creating table:", error);
  }
})();

module.exports = Recommended;
