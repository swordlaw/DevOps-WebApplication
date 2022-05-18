// Import mysql module
var mysql = require('mysql2');
const express = require('express');
var cors = require('cors')
// Define Express App
const app = express();
app.use(cors())
const PORT = process.env.PORT || 8081;

// Make database connection to handle 10 concurrent users
let connection = mysql.createConnection({
  host: '192.168.56.105',
  port: '3306',
  user: 'vagrant',
  password: 'password',
  database: 'helloworld'
});
connection.connect(function(err) {
  if (err) {
    return console.error('error: ' + err.message);
  }

  console.log('Connected to the MySQL server.');
});
app.listen(PORT, () => {
  console.log('Server connected at:',PORT);
});
app.get('/api/questions', (req,res) => {
    connection.query('SELECT * from posts', function (error, results, fields) {
        if (error) throw res.status(500).send(error);
        res.status(200).send(results);
    });
});
app.get('/api/answers', (req,res) => {
  connection.query('SELECT * from answers', function (error, results, fields) {
      if (error) throw res.status(500).send(error);
      res.status(200).send(results);
  });
});