const Music = require("../models/music");
const Playlist = require("../models/playlist");
const PlaylistSet = require("../models/playlistset");
const { isLoggedIn } = require("../router/middlewares");
const playlistController = require("../controllers/playlistController");
const express = require("express");
const passport = require("passport");
const router = express.Router();

router.use(isLoggedIn);

router.get("/", async (req, res) => {
  const UID = req.query.UID; // 쿼리 파라미터에서 UID 가져오기

  const isLoggedIn = req.isAuthenticated(); // passport의 isAuthenticated() 사용
  if (!UID) {
    // UID가 없으면 모든 playlist를 가져옴
    // 단, is_open이 1인 playlist만 가져옴
    const playlistInfo = await Playlist.findAll({
      where: { is_open: 1 },
    });
    const title = "다른 사람들의 플레이리스트";

    return res.render("playlist.ejs", { isLoggedIn, playlistInfo, title });
  }
  passport.session();
  if (req.user.UID != UID) {
    return res.redirect("/");
  }
  const title = "My Playlist List";
  const playlistInfo = await playlistController.getPlaylistByUserId(
    req,
    res,
    UID
  );
  res.render("playlist.ejs", { isLoggedIn, playlistInfo, title });
});

router.get("/detail", async (req, res) => {
  const isLoggedIn = req.isAuthenticated();
  const playlist_id = req.query.playlist_id;
  const playlist = await playlistController.getPlaylistByPlaylistId(
    req,
    res,
    playlist_id
  );
  //playlistset 에서 playlist_id에 해당하는 music_id를 가져와서 music 테이블에서 가져오기
  const playlistSet = await PlaylistSet.findAll({
    where: { playlist_id: playlist_id },
  });
  const musicList = [];
  for (let i = 0; i < playlistSet.length; i++) {
    const music_id = playlistSet[i].dataValues.music_id;
    const music = await Music.findOne({ where: { music_id } });
    musicList.push(music);
  }
  res.render("playlist_detail.ejs", { isLoggedIn, playlist, musicList });
});

router.get("/make_playlist", async (req, res) => {
  console.log("make_playlist 진입 했습니다.");
  passport.session();
  console.log("user:", req.user);

  res.render("make_playlist.ejs", { user: req.user });
});

router.post("/create", async (req, res) => {
  try {
    // const playlistInfo = await Playlist.create(req.body);
    const playlistInfo = await playlistController.createPlaylist(req, res);
    return res.redirect("/");
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
});

router.post("/add_music", async (req, res) => {
  try {
    await playlistController.addMusic(req, res); // 한 번만 응답을 받기
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
  // res.redirect("/playlist/detail?playlist_id=" + req.body.playlist_id);
});

router.get("/delete_playlist", async (req, res) => {
  passport.session();
  playlistInfo = await Playlist.findAll({
    where: { maker_id: req.user.UID },
  });
  if (playlistInfo[0].maker_id != req.user.UID) {
    return res.redirect("/");
  }
  res.render("delete_playlist.ejs", {
    user: req.user,
    playlistInfo,
    isLoggedIn: req.isAuthenticated(),
  });
});

router.get("/delete", async (req, res) => {
  const playlist_id = req.query.playlist_id;
  pid = await Playlist.findOne({ where: { playlist_id } });
  if (pid.maker_id != req.user.UID) {
    return res.redirect("/");
  }
  await Playlist.destroy({ where: { playlist_id } });
  await PlaylistSet.destroy({ where: { playlist_id } });
  res.redirect("/playlist");
});

router.get("/delete_playlist_deteil", async (req, res) => {
  const isLoggedIn = req.isAuthenticated();
  const playlist_id = req.query.playlist_id;
  const playlist = await playlistController.getPlaylistByPlaylistId(
    req,
    res,
    playlist_id
  );
  if (playlist.maker_id != req.user.UID) {
    return res.redirect("/");
  }
  //playlistset 에서 playlist_id에 해당하는 music_id를 가져와서 music 테이블에서 가져오기
  const playlistSet = await PlaylistSet.findAll({
    where: { playlist_id: playlist_id },
  });
  const musicList = [];
  for (let i = 0; i < playlistSet.length; i++) {
    const music_id = playlistSet[i].dataValues.music_id;
    const music = await Music.findOne({ where: { music_id } });
    musicList.push(music);
  }
  res.render("delete_playlist_detail.ejs", {
    isLoggedIn,
    playlist,
    musicList,
  });
});

router.get("/delete_detail", async (req, res) => {
  const music_id = req.query.music_id;
  const playlist_id = req.query.playlist_id;
  await PlaylistSet.destroy({ where: { playlist_id, music_id } });
  res.redirect("/playlist/delete_playlist_deteil?playlist_id=" + playlist_id);
});

module.exports = router;
