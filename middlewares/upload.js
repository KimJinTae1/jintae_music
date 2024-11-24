const multer = require("multer");
const path = require("path");

// 저장소 설정
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    // 작업 디렉터리를 기준으로 'uploads' 폴더 사용
    const uploadPath = path.join(process.cwd(), "uploads");
    cb(null, uploadPath);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = `${Date.now()}-${file.originalname}`;
    cb(null, uniqueSuffix); // 고유 파일 이름
  },
});

// 파일 필터 (선택 사항)
const fileFilter = (req, file, cb) => {
  const allowedExtensions = /mp3|wav/;
  const ext = path.extname(file.originalname).toLowerCase();
  if (allowedExtensions.test(ext)) {
    cb(null, true);
  } else {
    cb(new Error("Only .mp3 and .wav files are allowed!"));
  }
};

// multer 미들웨어 생성
const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 10 * 1024 * 1024 }, // 최대 파일 크기: 10MB
});

module.exports = upload;
