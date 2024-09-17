// index.js
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Route principale
app.get('/', (req, res) => {
  res.send('Hello, Docker Multilayer Application!');
});

// Démarrer le serveur
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
