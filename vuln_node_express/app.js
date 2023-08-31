const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const { exec } = require('child_process');
const fs = require('fs');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const db = new sqlite3.Database(':memory:');

db.serialize(() => {
  db.run('CREATE TABLE users (id INT, username TEXT, password TEXT)');
  db.run('INSERT INTO users VALUES (1, "admin", "password")');
});

// SQL Injection
app.get('/api/sqlinjection', (req, res) => {
  const query = req.query.query;
  db.all(query, [], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

// Command Injection
app.get('/api/commandinjection', (req, res) => {
  const cmd = req.query.cmd;
  exec(cmd, (error, stdout, stderr) => {
    if (error) {
      return res.status(500).json({ error: error.message });
    }
    res.json({ stdout, stderr });
  });
});

// Path Traversal
app.get('/api/pathtraversal', (req, res) => {
  const path = req.query.path;
  fs.readFile(path, 'utf8', (err, data) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.send(data);
  });
});

// Health Check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK' });
});

app.listen(port, () => {
  console.log(`Vulnerable app listening at http://localhost:${port}`);
});

