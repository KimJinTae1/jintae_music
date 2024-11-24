const passport = require("passport");
const User = require("../models/user");

exports.isAdmin = async (req, res, next) => {
  passport.session();
  console.log("user:", req.user);
  if (!req.user) {
    return res.redirect("/login");
  }
  //user 에서 is_admin이 1인지 확인
  const user = await User.findOne({ where: { UID: req.user.UID } });
  if (user.is_admin === 0) {
    return res.redirect("/");
  }
  next();
};
