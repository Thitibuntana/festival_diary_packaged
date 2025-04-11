const { PrismaClient } = require("@prisma/client");

const multer = require("multer");
const path = require("path");
const fs = require("fs");
const { Console } = require("console");

const prisma = new PrismaClient();

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "images/fests");
  },
  filename: (req, file, cb) => {
    cb(
      null,
      "fest_" +
        Math.floor(Math.random() * Date.now()) +
        path.extname(file.originalname)
    );
  },
});

exports.uploadFest = multer({
  storage: storage,
  limits: {
    fileSize: 1000000,
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
}).single("festImage");
//-------------------------------------------

exports.createFest = async (request, response) => {
  try {
    //-----
    const result = await prisma.fest_tb.create({
      data: {
        festName: request.body.festName,
        festDetail: request.body.festDetail,
        festState: request.body.festState,
        festCost: parseFloat(request.body.festCost),
        userId: parseInt(request.body.userId),
        festNumDay: parseInt(request.body.festNumDay),
        festImage: request.file
          ? request.file.path.replace("images\\fests\\", "")
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
    Console.log(`Error: ${error}`);
  }
};

exports.getAllFestByUser = async (request, response) => {
  try {
    const result = await prisma.fest_tb.findMany({
      where: {
        userId: parseInt(request.params.userId),
      },
    });

    response.status(200).json({
      message: "OK",
      info: result,
    });
  } catch (error) {
    response.status(500).json({
      message: `พบปัญหาในการทำงาน: ${error}`,
    });
    Console.log(`Error: ${error}`);
  }
};

exports.getOnlyFest = async (request, response) => {
  try {
    const result = await prisma.fest_tb.findFirst({
      where: {
        festId: parseInt(request.params.festId),
      },
    });

    response.status(200).json({
      message: "OK",
      info: result,
    });
  } catch (error) {
    response.status(500).json({
      message: `พบปัญหาในการทำงาน: ${error}`,
    });
    Console.log(`Error: ${error}`);
  }
};

exports.updateFest = async (request, response) => {
  try {
    let result = {};
    //----
    if (request.file) {
      const festResult = await prisma.fest_tb.findFirst({
        where: {
          festId: parseInt(request.params.festId),
        },
      });

      if (festResult.userImage) {
        fs.unlinkSync(path.join("images/fests", festResult.festImage));
      }

      result = await prisma.fest_tb.update({
        where: {
          festId: parseInt(request.params.festId),
        },
        data: {
          festName: request.body.festName,
          festDetail: request.body.festDetail,
          festState: request.body.festState,
          festCost: parseFloat(request.body.festCost),
          userId: parseInt(request.body.userId),
          festNumDay: parseInt(request.body.festNumDay),
          festImage: request.file.path.replace("images\\fests\\", ""),
        },
      });
    } else {
      result = await prisma.fest_tb.update({
        where: {
          festId: parseInt(request.params.festId),
        },
        data: {
          festName: request.body.festName,
          festDetail: request.body.festDetail,
          festState: request.body.festState,
          festCost: parseFloat(request.body.festCost),
          userId: parseInt(request.body.userId),
          festNumDay: parseInt(request.body.festNumDay),
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

exports.deleteFest = async (request, response) => {
  try {
    const result = await prisma.fest_tb.delete({
      where: {
        festId: parseInt(request.params.festId),
      },
    });

    response.status(200).json({
      message: "OK",
      info: result,
    });
  } catch (error) {
    response.status(500).json({
      message: `พบปัญหาในการทำงาน: ${error}`,
    });
    Console.log(`Error: ${error}`);
  }
};

//--------------------------------------------------------------------
