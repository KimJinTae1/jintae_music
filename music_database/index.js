let express = require("express");
let app = express();

const passport = require("passport");
const passportConfig = require("./passport");
const authRouter = require("./router/auth"); // 인증 라우터
const cookieParser = require("cookie-parser");
const session = require("express-session");
const Music = require("./models/music");
const admin = require("./router/admin");
const path = require("path");

//바디 잘 묶어서 보내줌
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");

passportConfig(); // 패스포트 설정
app.use(cookieParser("12"));
app.use(
  session({
    resave: false,
    saveUninitialized: false,
    secret: process.env.COOKIE_SECRET,
    cookie: {
      httpOnly: true,
      secure: false,
    },
  })
);
//! express-session에 의존하므로 뒤에 위치해야 함
app.use(passport.initialize()); // 요청 객체에 passport 설정을 심음
app.use(passport.session()); // req.session 객체에 passport정보를 추가 저장
// passport.session()이 실행되면, 세션쿠키 정보를 바탕으로 해서 passport/index.js의 deserializeUser()가 실행하게 한다.

//* 라우터
app.use("/auth", authRouter);
app.use("/static", express.static(path.join(__dirname, "uploads")));

app.listen(3000, function () {
  console.log("App is running on port 3000");
});

const post = require("./router/routs");
const auth = require("./router/auth");
const music = require("./router/music");
const playlist = require("./router/playlist");

app.use("/post_page", post);
app.use("/music", music);
app.use("/playlist", playlist);
app.use("/admin", admin);

app.use(
  "/music_file",
  express.static(path.join(__dirname, "../music_database/uploads"))
);
// console.log("Static path:", path.join(__dirname, "../music_file"));
// app.get("/", function (req, res) {
//   res.render("index.ejs");
// });

app.get("/", async (req, res) => {
  const isLoggedIn = req.isAuthenticated(); // passport의 isAuthenticated() 사용
  //디시리얼라이즈
  passport.session();
  const user = req.user;
  console.log("user:", user);
  try {
    const { order } = req.query;
    // console.log(order);
    // console.log("user", user);

    // 데이터베이스에서 음악 리스트 가져오기
    let orderby = [["release_date", "DESC"]];
    if (order == 1) orderby = [["recommendation", "DESC"]];
    if (order == 2) orderby = [["total_play_count", "DESC"]];
    if (order == 3) orderby = [["monthly_play_count", "DESC"]];

    const musicList = await Music.findAll({ order: orderby }); // 모든 음악 데이터 가져오기
    res.render("index", { user, isLoggedIn, musicList }); // index 템플릿 렌더링 시 음악 리스트 전달
  } catch (error) {
    // console.error("Error fetching music list:", error);
    res.status(500).send("Server Error");
  }
});

app.get("/login", function (req, res) {
  res.render("login.ejs");
});

app.get("/join", function (req, res) {
  res.render("join.ejs");
});

app.use("/", auth);
