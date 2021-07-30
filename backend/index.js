
const cors = require('cors');
const express = require('express');
const api = require('./src/api/index.js')
const mysql = require('mysql2');
const app = express();
const { PORT = 3000 } = process.env;

app.use(express.json());
app.use(cors());

//DB connection
require("./src/database/connection");

app.use('/', api);

app.listen(PORT, () => {
  console.log(`server started at http://localhost:${PORT}`);
});
