const express = require('express');
const mssql = require('mssql');
const port = 8080;
const ipAddr = '44.199.129.132';

const app = express();
app.use(express.static(__dirname + '/public'));
app.use(express.json());

const dbConfig = {
  user: "sa",
  password:"Gusale03_SQL",
  database: 'GAMECTC',
  server: 'localhost',
  pool: { max: 10, min: 0, idleTimeoutMillis: 30000 },
  options: { trustServerCertificate: true }
};

async function connectDb() {
    try {
      await mssql.connect(dbConfig);
      console.log('Connected to the database.');
    } catch (err) {
      console.error('Unable to connect to the database.');
      throw err;
    }
}

app.get("/home", async (req, res) => {
    try {
        await connectDb();
        const result = await mssql.query("Select nombre, contraseña From Cuenta Where adminCuenta = 'true'");
        res.type('text').json(result.recordset);
    } catch (err) {
        console.error(err);
        res.status(500).json(err);
    }
});

// custom 404 page
app.use((req, res) => {
    res.type('text/plain').status(404).send('404 - Not Found');
});

app.listen(port, () => console.log(
    `Express started on http://${ipAddr}:${port}`
    + '\nPress Ctrl-C to terminate.')); 
