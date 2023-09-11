const express = require('express');
const multer = require('multer');
const app = express();
const port = process.env.PORT || 3000;
const fs = require('fs');
const path = require('path');

let pictureCounter = 0;

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// Set the directory where images and descriptions will be saved
const uploadDirectory = 'ServerImages';
const uploadDirectory2 = 'ServerImages/ImagesOnly';

// Ensure the upload directory exists
// Ensure the upload directories exist
if (!fs.existsSync(uploadDirectory)) {
  fs.mkdirSync(uploadDirectory);
}

if (!fs.existsSync(uploadDirectory2)) {
  fs.mkdirSync(uploadDirectory2);
}


app.post('/upload', upload.single('image'), (req, res) => {
  try {
    const imageBuffer = req.file.buffer;
    const description = req.body.description;

    const now = new Date();
    const formattedDateTime = now.toISOString().replace(/[-T:.]/g, '');
    const fileName1 = `IMG_${formattedDateTime}_${pictureCounter}.json`;
    const fileName2 = `IMG_${formattedDateTime}_${pictureCounter}.jpg`;

    const savePath = path.join(__dirname, uploadDirectory, fileName1);
    const savePath2 = path.join(__dirname, uploadDirectory2, fileName2);

    const imageInfo = {
      fileName: fileName1,
      description,
      image: imageBuffer.toString('base64'),
    };

    fs.writeFileSync(savePath, JSON.stringify(imageInfo, null, 2));
    fs.writeFileSync(savePath2, imageBuffer);
    pictureCounter++;

    res.status(200).json({ message: 'Image and description uploaded successfully' });
  } catch (error) {
    console.error('Error handling upload:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
