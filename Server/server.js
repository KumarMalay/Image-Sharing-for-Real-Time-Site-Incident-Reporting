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

// Ensure the upload directories exist
if (!fs.existsSync(uploadDirectory)) {
  fs.mkdirSync(uploadDirectory);
}

app.get('/images', (req, res) => {
  try {
    // Read the list of image files from the 'ServerImages' directory
    const imageFiles = fs.readdirSync(uploadDirectory);

    // Create an array to store image and description data
    const images = [];

    // Read each image file and corresponding JSON file
    for (const imageFile of imageFiles) {
      if (imageFile.endsWith('.json')) {
        const imageFilePath = path.join(uploadDirectory, imageFile);
        const jsonContent = fs.readFileSync(imageFilePath, 'utf-8');
        const imageData = JSON.parse(jsonContent);
        images.push(imageData);
      }
    }

    res.status(200).json(images);
  } catch (error) {
    console.error('Error fetching images:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/upload', upload.single('image'), (req, res) => {
  try {
    const imageBuffer = req.file.buffer;
    const description = req.body.description;

    const now = new Date();
    const formattedDateTime = now.toISOString().replace(/[-T:.]/g, '');
    const fileName1 = `IMG_${formattedDateTime}_${pictureCounter}.json`;
    const fileName2 = `IMG_${formattedDateTime}_${pictureCounter}.jpg`;

    const savePath = path.join(uploadDirectory, fileName1);
    const savePath2 = path.join(uploadDirectory, fileName2);

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
