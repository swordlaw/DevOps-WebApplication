// server.js
const express = require('express');
var cors = require('cors')
// Define Express App
const app = express();
app.use(express.json());
app.use(cors())
const PORT = process.env.PORT || 8080;

// mysql connection for api
var mysql      = require('mysql2');
var connection = mysql.createConnection({
    host: '192.168.56.105',
    port: '3306',
    user: 'vagrant',
    password: 'password',
    database: 'helloworld',
});

connection.connect((err) => {
    if(err) throw err;
});


// Serve Static Assets
app.use(express.static('public'));
app.use('/static', express.static('public'));

app.get('/', (req,res) => {
    res.sendFile('index.html', { root: 'public'});
}); 
app.get('/about', (req,res) => {
    res.sendFile('about.html', { root: 'public' });
});

app.get('/questions', (req,res) => {
    res.sendFile('questions.html', { root: 'public' });
});
app.get('/user', (req,res) => {
    res.sendFile('user.html', { root: 'public' });
});

app.get('/api/questions', (req,res) => {
    connection.query('SELECT posts.*, answers.contentA AS answer FROM posts LEFT JOIN answers ON posts.PostID = answers.PostID ORDER BY posts.PostID DESC', function (error, results, fields) {
        if (error) res.status(500).send(error);
        if (!results.length) res.status(200).send([]);

        var questions = [];
        currentQuestion = {answers: [], ...results[0]};
        for(var i = 0; i < results.length; i++) {
            if(results[i].PostID != currentQuestion.PostID) {
                delete currentQuestion.answer;
                questions.push(currentQuestion);
                currentQuestion = {answers: [], ...results[i]};
            } 
            if(results[i].answer) currentQuestion.answers.push({answer: results[i].answer});
        }
        questions.push(currentQuestion);

        res.status(200).send(questions);
    });
});

app.post('/api/questions', (req,res) => {
    /*console.log(req.body);
    res.status(200).send(req.body);*/
    
    connection.query('INSERT INTO posts (Title, content) VALUES (?, ?)', [req.body.Title, req.body.content], function (error, results, fields) {
        if (error) res.status(500).send(error);
        res.status(200).send("Question successfully submitted");
    });
    
});

app.post('/api/questions/:question', (req,res) => {
    connection.query('INSERT INTO answers (PostID, TitleA, contentA) VALUES (?, ?, ?)', [req.params.question, req.body.TitleA, req.body.contentA], function (error, results, fields) {
        if (error) throw res.status(500).send(error);
        res.status(200).send("Answer successfully submitted");
    });
});

// Samples @ http://expressjs.com/en/starter/examples.html
app.listen(PORT, () => {
  console.log('Server connected at:',PORT);
});
