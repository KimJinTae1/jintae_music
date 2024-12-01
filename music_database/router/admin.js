const Music = require("../models/music");
const Playlist = require("../models/playlist");
const PlaylistSet = require("../models/playlistset");
const { isLoggedIn } = require("../router/middlewares");
const playlistController = require("../controllers/playlistController");
const express = require("express");
const router = express.Router();
const commentController = require("../controllers/commentController");
const User = require("../models/user");
const is_admin = require("../middlewares/isAdmin");
const passport = require("passport");
// const fs = require("fs");
// const path = require("path");

router.use(is_admin.isAdmin);

router.get("/", async (req, res) => {
  res.render("admin.ejs");
});

router.get("/manage_comments", async (req, res) => {
  // getAllComments 함수 호출 시 orderby를 올바르게 전달
  const comments = await commentController.getAllComments([
    ["reported", "DESC"],
  ]);

  // "manage_comments"로만 뷰 이름을 전달
  res.render("manage_comments", { comments });
});

router.get("/manage_users", async (req, res) => {
  // getAllComments 함수 호출 시 orderby를 올바르게 전달

  const users = await User.findAll({
    order: [["createdAt", "DESC"]],
  });

  // "manage_comments"로만 뷰 이름을 전달
  res.render("manage_users", { users });
});

router.post("/blockComments", async (req, res) => {
  const { comment_id } = req.body;
  await commentController.blockComment(comment_id);
  res.redirect("/admin/manage_comments");
});

router.post("/blockUser", async (req, res) => {
  const user_id = req.body.user_id;
  console.log("유저아이디 : ", user_id);
  console.log("왜안뜨는거야!!!!!!!!!!!!!!!!!!!!");

  await User.update(
    { is_banned: 1 },
    {
      where: {
        UID: user_id,
      },
    }
  );
  res.redirect("/admin/manage_users");
});

router.get("/update_pc", async (req, res) => {
  const musicList = await Music.findAll();
  //musicList 의 모든 monthly_play_count를 0으로 초기화
  musicList.forEach(async (music) => {
    await Music.update(
      {
        monthly_play_count: 0,
      },
      { where: { music_id: music.music_id } }
    );
  });
  res.redirect("/");
});

const fs = require("fs");
const path = require("path");

router.get("/delete_music", async (req, res) => {
  const music_id = req.query.music_id;

  if (!music_id) {
    const musicList = await Music.findAll();
    const user = req.user;
    const isLoggedIn = req.isAuthenticated();
    res.render("delete_music.ejs", { musicList, user, isLoggedIn });
    return;
  }

  try {
    // 1. 데이터베이스에서 음악 정보 조회
    const music = await Music.findOne({
      where: { music_id },
    });

    if (!music) {
      return res.status(404).send("Music not found");
    }

    // 절대경로에서 'uploads/' 부분을 잘라내어 상대경로를 사용
    const filePath = music.file_path; // file_path가 절대경로라고 가정
    //filePath 에서 마지막 파일이름만 추출
    filePath.split("/");
    const fileName = filePath.split("/").pop();

    // const relativePath = filePath.replace(
    //   path.join(process.cwd(), "uploads"),
    //   ""
    // ); // 'uploads' 폴더를 제외한 부분 추출

    console.log("음악 파일 상대경로:", fileName);

    // 파일 시스템에서 파일 삭제
    const fullFilePath = path.join(process.cwd(), "uploads", fileName); // 절대경로로 결합
    fs.unlink(fullFilePath, (err) => {
      if (err) {
        console.error("파일 삭제 중 오류 발생:", err);
        return res.status(500).json({ message: "Error deleting the file" });
      }

      console.log("파일 삭제 완료:", fullFilePath);
    });
    await Music.destroy({ where: { music_id } });
    res.redirect("/admin/delete_music");
  } catch (error) {
    res.status(500).send("삭제 중 오류 발생");
  }
});

module.exports = router;
