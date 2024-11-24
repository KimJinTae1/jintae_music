const comment = require("../models/comment");

exports.getAllComments = async (orderby) => {
  try {
    const commentInfo = await comment.findAll({ order: orderby });
    return commentInfo;
  } catch (error) {
    console.error(error);
    throw new Error("Server Error");
  }
};

exports.getCommentByMusicId = async (musicId, req, res) => {
  try {
    const commentInfo = await comment.findAll({
      where: { music_id: musicId },
    });
    return commentInfo;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.getCommentByUserId = async (req, res) => {
  try {
    const commentInfo = await comment.findAll({
      where: { user_id: req.params.user_id },
    });
    return commentInfo;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.createComment = async (req, res) => {
  try {
    const { music_id } = req.body; // 댓글을 달 때 music_id는 req.body에서 가져옵니다.
    await comment.create(req.body);

    // 댓글 생성 후, music_id를 쿼리 파라미터로 전달하여 리디렉션
    res.redirect(`/music/detail?music_id=${music_id}`);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.reportComment = async (req, res) => {
  try {
    // comment_id를 req.body에서 받아옵니다
    const { comment_id } = req.body;
    console.log("comment_id:", comment_id);

    // 해당 comment_id에 대한 댓글을 찾습니다
    const commentInfo = await comment.findOne({ where: { comment_id } });

    if (!commentInfo) {
      // 댓글이 존재하지 않으면 404 응답을 보냅니다
      return res.status(404).json({ message: "Comment not found" });
    }

    // 기존 report_count 값을 가져와서 1 증가시킵니다
    const updatedReportCount = commentInfo.reported + 1;
    console.log("commentInfo.report_count:", commentInfo.reported);
    // 댓글의 report_count를 업데이트합니다
    await comment.update(
      { reported: updatedReportCount },
      { where: { comment_id } }
    );
    console.log("commentInfo.report_count:", commentInfo.reported);

    // 성공적인 응답
    res.status(200).json({ message: "Comment reported successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

exports.blockComment = async (comment_id, req, res) => {
  try {
    // console.log("comment_id:", comment_id);

    const commentInfo = await comment.findOne({ where: { comment_id } });
    console.log("commentInfo:", commentInfo);
    console.log("is_blocked : ", commentInfo.is_blocked);

    if (!commentInfo) {
      return res.status(404).json({ message: "Comment not found" });
    }

    await comment.update({ is_blocked: true }, { where: { comment_id } });

    return;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};
