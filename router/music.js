const Music = require("../models/music");
const musicController = require("../controllers/musicController");
const { isLoggedIn } = require("../router/middlewares");
const playlistController = require("../controllers/playlistController");
const commentController = require("../controllers/commentController");
const express = require("express");
const router = express.Router();
const Comment = require("../models/comment");
const User = require("../models/user");
const upload = require("../middlewares/upload"); // multer 설정 파일
const passport = require("passport");

// router.use(isLoggedIn);

router.get("/", async (req, res) => {
  passport.session();
  console.log("user:", req.user);

  res.render("music.ejs", { user: req.user });
});

router.get("/make_playlist", async (req, res) => {
  res.render("make_playlist.ejs");
});

router.get("/playlist", async (req, res) => {
  res.render("playlist.ejs");
});

router.get("/detail", async (req, res) => {
  const isLoggedIn = req.isAuthenticated();
  // const isLoggedIn = true;
  console.log("isLoggedIn:", isLoggedIn);
  const musicId = req.query.music_id; // 쿼리 파라미터에서 music_id를 가져옵니다.
  // console.log("Requested music ID:", musicId); // 파라미터 확인용 로그

  try {
    const music = await musicController.getMusicById(musicId, req, res); // musicId를 인자로 넘깁니다.
    // console.log("music:", music);
    console.log("user:", req.user);
    const playlistInfo = await playlistController.getPlaylistByMyId(
      res,
      req.user.UID
    );
    user_id = req.user.UID;
    const comments = await Comment.findAll({
      where: { music_id: musicId },
      include: [
        {
          model: User,
          as: "user",
          attributes: ["user_name"], // 필요한 속성만 가져오기
        },
      ],
    });
    console.log("comments:", comments);
    // const commentInfo = console.log("playlistInfo:", playlistInfo);
    // console.log("comments:", comments);
    // console.log("comments[0].user : ", comments[0].user);
    res.render("music_detail.ejs", {
      isLoggedIn,
      music,
      playlistInfo,
      comments,
      user_id,
    });
  } catch (error) {
    console.error("Error fetching music by ID:", error);
    res.status(500).json({ message: "Server Error" });
  }
});

router.post("/delete_comment", async (req, res) => {
  const { comment_id } = req.body;
  try {
    await Comment.destroy({
      where: {
        comment_id,
      },
    });
    res.redirect("/music/detail?music_id=" + req.body.music_id);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
});

router.get("/search", musicController.searchMusic);
router.get("/searchByGerne", musicController.searchMusicByGenre);

router.post("/add_comment", commentController.createComment);
router.post("/report_comment", commentController.reportComment);

router.get("/getAllMusic", musicController.getAllMusic);
router.post("/create", upload.single("sing"), musicController.createMusic);
router.get("/getAllMusicByDate", musicController.getAllMusicByDate);
router.get("/getAllMusicByPlayCount", musicController.getAllMusicByPlayCount);
router.get("/getMusicById/:id", musicController.getMusicById);
router.post("/recommend", isLoggedIn, musicController.recommendMusic);

router.get("/new", musicController.getAllMusicByDate);
router.get("/recommend", musicController.getAllMusicByRecommendation);
router.get("/play", musicController.getAllMusicByPlayCount);
// router.get("/playlist", musicController.getPlaylist);

router.post("/end", musicController.endMusic);

module.exports = router;
