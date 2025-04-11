//จัดการ DB
const { PrismaClient } = require("@prisma/client");

//จัดการการ Upload
const multer = require("multer");
const path = require("path");
const fs = require("fs");

//สร้างตัวแปรอ้างอิงสำหรับ prisma เพื่อเอาไปงาน
const prisma = new PrismaClient();

//การอัปโหลดไฟล์----------------------------
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "images/users");
  },
  filename: (req, file, cb) => {
    cb(
      null,
      "user_" +
        Math.floor(Math.random() * Date.now()) +
        path.extname(file.originalname)
    );
  },
});

exports.uploadUser = multer({
  storage: storage,
  limits: {
    fileSize: 10000000,
  },
  fileFilter: (req, file, cb) => {
    const fileTypes = /jpeg|jpg|png/;
    const mimeType = fileTypes.test(file.mimetype);
    const extname = fileTypes.test(path.extname(file.originalname));
    if (mimeType && extname) {
      return cb(null, true);
    }
    cb("Error: Images Only");
  },
}).single("userImage");
//-------------------------------------------

exports.createUser = async (request, response) => {
  try {
    //-----
    const result = await prisma.user_tb.create({
      data: {
        userFullname: request.body.userFullname,
        userName: request.body.userName,
        userPassword: request.body.userPassword,
        userImage: request.file
          ? request.file.path.replace("images\\users\\", "")
          : "",
      },
    });
    //-----
    response.status(201).json({
      message: "OK",
      info: result,
    });
  } catch (error) {
    response.status(500).json({
      message: `พบปัญหาในการทำงาน: ${error}`,
    });
    console.log(`Error: ${error}`);
  }
};

exports.checkLogin = async (request, response) => {
  try {
    //----
    const result = await prisma.user_tb.findFirst({
      where: {
        userName: request.params.userName,
        userPassword: request.params.userPassword,
      },
    });
    //-----
    if (result) {
      response.status(200).json({
        message: "Ok",
        info: result,
      });
    } else {
      response.status(404).json({
        message: "OK",
        info: result,
      });
    }
  } catch (error) {
    response.status(500).json({
      message: `พบปัญหาในการทำงาน: ${error}`,
    });
    console.log(`Error: ${error}`);
  }
};

//แก้ไข USER (Update) ข้อมูลตารางใน DB---------
exports.updateUser = async (request, response) => {
  try {
    let result = {};
    //----
    if (request.file) {
      const userResult = await prisma.user_tb.findFirst({
        where: {
          userId: parseInt(request.params.userId),
        },
      });
      if (userResult.userImage) {
        fs.unlinkSync(path.join("images/users", userResult.userImage));
      }
      result = await prisma.user_tb.update({
        where: {
          userId: parseInt(request.params.userId),
        },
        data: {
          userFullname: request.body.userFullname,
          userName: request.body.userName,
          userPassword: request.body.userPassword,
          userImage: request.file.path.replace("images\\users\\", ""),
        },
      });
    } else {
      result = await prisma.user_tb.update({
        where: {
          userId: parseInt(request.params.userId),
        },
        data: {
          userFullname: request.body.userFullname,
          userName: request.body.userName,
          userPassword: request.body.userPassword,
        },
      });
    }
    //-----
    response.status(200).json({
      message: "Ok",
      info: result,
    });
  } catch (error) {
    response.status(500).json({
      message: `พบปัญหาในการทำงาน: ${error}`,
    });
    console.log(`Error: ${error}`);
  }
};

//--------------------------------------------------------------------
