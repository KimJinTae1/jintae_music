const playlist = require("../models/playlist");
const playlistSet = require("../models/playlistset");

exports.getAllPlaylist = async (req, res) => {
  try {
    const playlistInfo = await playlist.findAll();
    res.status(200).json(playlistInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.createPlaylist = async (req, res) => {
  try {
    // console.log("createPlaylist");
    // console.log(req.body);
    const playlistInfo = await playlist.create(req.body);

    // return res.redirect("/playlist");
    // res.status(201).json(playlistInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.getPlaylistByUserId = async (req, res, UID) => {
  try {
    const playlistInfo = await playlist.findAll({
      where: { maker_id: UID },
    });
    return playlistInfo;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.getPlaylistByMyId = async (res, UID) => {
  try {
    const playlistInfo = await playlist.findAll({
      where: { maker_id: UID },
    });
    return playlistInfo;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.addMusic = async (req, res) => {
  try {
    // 이미 있는지 확인
    const music_id = req.body.music_id;
    const playlist_id = req.body.playlist_id;
    const playlistSetInfo = await playlistSet.findOne({
      where: { music_id: music_id, playlist_id: playlist_id },
    });

    if (playlistSetInfo) {
      // 이미 존재하는 경우에만 응답을 보냄
      // return res.json({ message: "Music already exists" });
      return;
      // return res.json({ message: "Music already exists" });
    }

    const playlistInfo = await playlistSet.create(req.body);
    // return res.json({ message: "Music added successfully" });
    return;
  } catch (error) {
    console.error(error);
    // 에러 발생 시 한 번만 응답을 보냄
    if (!res.headersSent) {
      // 응답이 이미 전송되었는지 확인
      return res.status(500).json({ message: "Server Error" });
    }
  }
};

exports.getPlaylistByPlaylistId = async (req, res, playlist_id) => {
  try {
    const playlistInfo = await playlist.findOne({
      where: { playlist_id },
    });
    return playlistInfo;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};
