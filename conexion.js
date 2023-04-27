const express = require('express');
const mysql = require('mysql');
const port = ;
const ipAddr = '';

const app = express();
app.use(express.static(__dirname + '/public'));
app.use(express.json());

const db = mysql.createConnection({
    host: '',
    database: '',
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD
});

db.connect(err => {
    if (err) {
        console.error('Unable to connect to the database.');
        throw err;
    } else {
        console.log('Connected to the database.');
    }
});

app.get("/home/", (req, res) => {
    db.query("SELECT nombre, contraseña FROM Cuenta WHERE adminCuenta = 'true'", (err, rows) => {
        if (err) {
            res.status(500).json(err);
        } else {
            let result = [];
            for (let row of rows) {
                result.push({
                    nombre: row.nombre,
                    contraseña: row.contraseña,
                });
            }
            res.json(result);
        }
    })
});