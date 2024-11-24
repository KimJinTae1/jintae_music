const music = require("../models/music");
const recommended = require("../models/recommended");
const Sequelize = require("sequelize");
const passport = require("passport");
const Genre = require("../models/genre");
const Music = require("../models/music");

const upload = require("../middlewares/upload"); // multer 설정 파일

exports.getAllMusic = async (req, res) => {
  try {
    const musicInfo = await music.findAll();
    res.status(200).json(musicInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.createMusic = async (req, res) => {
  try {
    const filePath = req.file ? req.file.path : "null";

    // 데이터베이스 저장
    const musicInfo = await music.create({
      ...req.body, // 폼 데이터
      file_path: filePath, // 파일 경로 추가
    });
    // res.status(201).json(musicInfo);

    if (req.body.genre) {
      // 장르 데이터를 콤마로 분리하여 배열로 만듦
      const genres = req.body.genre.split(",").map((genre) => genre.trim());

      // 장르를 Genre 테이블에 삽입
      for (let genreName of genres) {
        await Genre.create({
          music_id: musicInfo.music_id, // 방금 저장된 음악의 music_id
          genre_name: genreName, // 장르 이름
        });
      }
    }
    return res.redirect("/");
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.getAllMusicByDate = async (req, res) => {
  try {
    const musicInfo = await music.findAll({
      order: [["release_date", "DESC"]],
    });
    res.status(200).json(musicInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.getAllMusicByPlayCount = async (req, res) => {
  try {
    const musicInfo = await music.findAll({
      order: [["total_play_count", "DESC"]],
    });
    res.status(200).json(musicInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.getAllMusicByRecommendation = async (req, res) => {
  try {
    const musicInfo = await music.findAll({
      order: [["recommendation", "DESC"]],
    });
    res.status(200).json(musicInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.getMusicById = async (musicId, res) => {
  // req와 res를 받지 않도록 수정
  // console.log("id:", musicId); // 전달된 musicId를 확인
  try {
    const musicInfo = await music.findOne({
      where: { music_id: musicId }, // music_id 필드에서 해당 ID를 찾음
    });
    console.log("musicInfo:", musicInfo);
    // res.status(200).json(musicInfo); // 정상적으로 musicInfo를 JSON으로 응답
    return musicInfo;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.recommendMusic = async (req, res) => {
  const music_id = req.body.music_id;
  const UID = req.user.UID;
  if (req.user === undefined) {
    return res.status(401).json({ message: "로그인해주세용" });
  }
  //이미 추천했는지 확인
  const recommendInfo = await recommended.findOne({
    where: { music_id, UID },
  });
  if (recommendInfo) {
    return res.status(400).json({ message: "이미 추천하셨습니다." });
  }
  try {
    // await recommended.create({ music_id, UID });
    const musicInfo = await music.findOne({
      where: { music_id },
    });
    await music.update(
      { recommendation: musicInfo.recommendation + 1 },
      { where: { music_id } }
    );
    await recommended.create({ music_id, UID });
    // res.status(200).json({ message: "추천되었습니다." });
    res.redirect("/");
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.endMusic = async (req, res) => {
  //음악이 끝나면 재생수 1 증가
  const music_id = req.body.music_id;
  try {
    const musicInfo = await music.findOne({
      where: { music_id },
    });
    await music.update(
      {
        total_play_count: musicInfo.total_play_count + 1,
        monthly_play_count: musicInfo.monthly_play_count + 1,
      },
      { where: { music_id } }
    );
    console.log("재생수 증가");
    res.status(200).json({ message: "재생수 증가" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.searchMusic = async (req, res) => {
  const searchQuery = req.query.q || ""; // 검색어 가져오기

  try {
    let musicList = [];
    if (searchQuery.trim()) {
      // Sequelize로 부분 검색 수행
      musicList = await music.findAll({
        where: {
          title: {
            [Sequelize.Op.like]: `%${searchQuery}%`, // 부분 일치
          },
        },
      });
    }

    passport.session();
    const user = req.user;

    const isLoggedIn = req.isAuthenticated(); // passport의 isAuthenticated() 사용

    // 검색 결과 렌더링
    res.render("index.ejs", { musicList, searchQuery, user, isLoggedIn });
  } catch (error) {
    console.error("Error fetching search results:", error);
    res.status(500).send("Server Error");
  }
};
exports.searchMusicByGenre = async (req, res) => {
  const genre = req.query.q || ""; // 검색어 가져오기

  try {
    // 장르 검색
    let musicList = [];
    if (genre.trim()) {
      const genreData = await Genre.findAll({
        where: { genre_name: genre },
        include: [
          {
            model: Music, // Music 테이블과 연결
            as: "music", // 별칭 지정
          },
        ],
      });

      // Genre 데이터에서 Music 데이터를 추출
      musicList = genreData.map((genreItem) => genreItem.music);
    }

    console.log("genre:", genre);
    console.log("musicList:", musicList);

    // 사용자 인증 상태
    passport.session();
    const user = req.user;
    const isLoggedIn = req.isAuthenticated();

    // 검색 결과 렌더링
    res.render("index.ejs", {
      musicList, // 추출된 Music 데이터를 전달
      genre,
      user,
      isLoggedIn,
    });
  } catch (error) {
    console.error("Error fetching search results:", error);
    res.status(500).send("Server Error");
  }
};
