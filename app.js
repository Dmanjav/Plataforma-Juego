const express = require('express');
const mssql = require('mssql');
const port = 8080;
const ipAddr = '44.199.129.132';

const app = express();
app.use(express.static(__dirname + '/public'));
app.use(express.json());

const dbConfig = {
  user: process.env.MSSQL_USER,
  password: process.env.MSSQL_PASSWORD,
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

connectDb();


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

app.get('/cuenta', async (req, res) => {
  try {
    const rows = (await mssql.query`
      SELECT emailTutor, nombre, contraseña, fechaNacimiento, telefono, pais, adminCuenta FROM Cuenta
    `).recordset;
    const result = [];
    for (let row of rows) {
      result.push({
        emailTutor: row.emailTutor,
        nombre: row.nombre,
        contraseña: row.contraseña,
        fechaNacimiento: row.fechaNacimiento,
        telefono: row.telefono,
        pais: row.pais,
        adminCuenta: row.adminCuenta,
        url: `http://${ipAddr}:${port}/cuenta/${row.emailTutor}`
      });
    }
    res.json(result);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.get('/cuenta/:emailTutor', async (req, res) => {
  try {
    const emailTutor = req.params.emailTutor;
    const rows = (await mssql.query`
        SELECT emailTutor, nombre, contraseña, fechaNacimiento, telefono, pais, adminCuenta FROM Cuenta 
        WHERE emailTutor=${emailTutor}
    `).recordset;
    const row = rows[0];
    if (row) {
      res.json({
        emailTutor: row.emailTutor,
        nombre: row.nombre,
        contraseña: row.contraseña,
        fechaNacimiento: row.fechaNacimiento,
        telefono: row.telefono,
        pais: row.pais,
        adminCuenta: row.adminCuenta,
      });
    } else {
      res.type('text').status(404).send(
        `Resource with ID = ${emailTutor} not found.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.post('/cuenta', async (req, res) => {
  try {
    const { emailTutor, nombre, contraseña, fechaNacimiento, telefono, pais, adminCuenta } = req.body;
    const result = await mssql.query`
      INSERT INTO Cuenta (emailTutor, nombre, contraseña, fechaNacimiento, telefono, pais, adminCuenta) 
      VALUES (${emailTutor}, ${nombre},${contraseña},${fechaNacimiento},${telefono},${pais},${adminCuenta}); 
      SELECT SCOPE_IDENTITY() AS [newEmailTutor]
    `;
    const newEmailTutor = result.recordset[0]['newEmailTutor'];
    res.type('text').status(201).send(
      `Resource created with ID = ${newEmailTutor}.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/cuenta/:emailTutor', async (req, res) => {
  try {
    const emailTutor = req.params.emailTutor;
    const result = await mssql.query`
      DELETE FROM Cuenta 
      WHERE emailTutor=${emailTutor}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(`Resource with emailTutor = ${emailTutor} deleted.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with emailTutor = ${emailTutor} not found. No resources deleted.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/cuenta', async (req, res) => {
  try {
    const result = await mssql.query`
      DELETE FROM Cuenta
    `;
    res.type('text').send(`${result.rowsAffected[0]} resource(s) deleted.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.put('/cuenta/:emailTutor', async (req, res) => {
  try {
    const emailTutor = req.params.emailTutor;
    const {nombre, contraseña, fechaNacimiento, telefono, pais, adminCuenta} = req.body;
    const result = await mssql.query`
        UPDATE Cuenta
        SET nombre=${nombre}, contraseña=${contraseña}, fechaNacimiento=${fechaNacimiento}, telefono=${telefono}, pais=${pais}, adminCuenta=${adminCuenta} 
        WHERE emailTutor=${emailTutor}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(
        `Resource with emailTutor = ${emailTutor} updated.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with emailTutor = ${emailTutor} not found. No resources updated.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


app.get('/jugador', async (req, res) => {
  try {
    const rows = (await mssql.query`
      SELECT IDJugador, emailTutor, nivelesJugados, horasJugadas, gamerTag, nivelInvolucramiento FROM Jugador
    `).recordset;
    const result = [];
    for (let row of rows) {
      result.push({
        IDJugador: row.IDJugador,
        emailTutor: row.emailTutor,
        nivelesJugados: row.nivelesJugados,
        horasJugadas: row.horasJugadas,
        gamerTag: row.gamerTag,
        nivelInvolucramiento: row.nivelInvolucramiento,
        url: `http://${ipAddr}:${port}/cuenta/${row.IDJugador}`
      });
    }
    res.json(result);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.get('/jugador/:IDJugador', async (req, res) => {
  try {
    const IDJugador = req.params.IDJugador;
    const rows = (await mssql.query`
        SELECT IDJugador, emailTutor, nivelesJugados, horasJugadas, gamerTag, nivelInvolucramiento FROM Jugador
        WHERE IDJugador=${IDJugador}
    `).recordset;
    const row = rows[0];
    if (row) {
      res.json({
        IDJugador: row.IDJugador,
        emailTutor: row.emailTutor,
        nivelesJugados: row.nivelesJugados,
        horasJugadas: row.horasJugadas,
        gamerTag: row.gamerTag,
        nivelInvolucramiento: row.nivelInvolucramiento,
      });
    } else {
      res.type('text').status(404).send(
        `Resource with IDJugador = ${IDJugador} not found.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.post('/jugador', async (req, res) => {
  try {
    const { IDJugador, emailTutor, nivelesJugados, horasJugadas, gamerTag, nivelInvolucramiento} = req.body;
    const result = await mssql.query`
      INSERT INTO Jugador (IDJugador, emailTutor, nivelesJugados, horasJugadas, gamerTag, nivelInvolucramiento) 
      VALUES (${IDJugador}, ${emailTutor},${nivelesJugados},${horasJugadas},${gamerTag},${nivelInvolucramiento}); 
      SELECT SCOPE_IDENTITY() AS [newIDJugador]
    `;
    const newIDJugador = result.recordset[0]['newIDJugador'];
    res.type('text').status(201).send(
      `Resource created with ID = ${newIDJugador}.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/jugador/:IDJugador', async (req, res) => {
  try {
    const IDJugador = req.params.IDJugador;
    const result = await mssql.query`
      DELETE FROM Jugador 
      WHERE IDJugador=${IDJugador}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(`Resource with IDJugador = ${IDJugador} deleted.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with IDJugador = ${IDJugador} not found. No resources deleted.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/jugador', async (req, res) => {
  try {
    const result = await mssql.query`
      DELETE FROM Jugador
    `;
    res.type('text').send(`${result.rowsAffected[0]} resource(s) deleted.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.put('/jugador/:IDJugador', async (req, res) => {
  try {
    const IDJugador = req.params.IDJugador;
    const {emailTutor, nivelesJugados, horasJugadas, gamerTag, nivelInvolucramiento} = req.body;
    const result = await mssql.query`
        UPDATE Cuenta
        SET emailTutor=${emailTutor}, nivelesJugados=${nivelesJugados}, horasJugadas=${horasJugadas}, gamerTag=${gamerTag}, nivelInvolucramiento=${nivelInvolucramiento} 
        WHERE IDJugador=${IDJugador}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(
        `Resource with IDJugador = ${IDJugador} updated.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with IDJugador = ${IDJugador} not found. No resources updated.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

app.get('/nivel', async (req, res) => {
  try {
    const rows = (await mssql.query`
      SELECT IDNivel, Nombre, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5 FROM Nivel
    `).recordset;
    const result = [];
    for (let row of rows) {
      result.push({
        IDNivel: row.IDNivel,
        Nombre: row.Nombre,
        Coleccionable1: row.Coleccionable1,
        Coleccionable2: row.Coleccionable2,
        Coleccionable3: row.Coleccionable3,
        Coleccionable4: row.Coleccionable4,
        Coleccionable5: row.Coleccionable5,
        url: `http://${ipAddr}:${port}/nivel/${row.IDNivel}`
      });
    }
    res.json(result);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.get('/nivel/:IDNivel', async (req, res) => {
  try {
    const IDNivel = req.params.IDNivel;
    const rows = (await mssql.query`
        SELECT IDNivel, Nombre, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5 FROM Nivel
        WHERE IDNivel=${IDNivel}
    `).recordset;
    const row = rows[0];
    if (row) {
      res.json({
        IDNivel: row.IDNivel,
        Nombre: row.Nombre,
        Coleccionable1: row.Coleccionable1,
        Coleccionable2: row.Coleccionable2,
        Coleccionable3: row.Coleccionable3,
        Coleccionable4: row.Coleccionable4,
        Coleccionable5: row.Coleccionable5,
   
      });
    } else {
      res.type('text').status(404).send(
        `Resource with ID = ${IDNivel} not found.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.post('/nivel', async (req, res) => {
  try {
    const { IDNivel, Nombre, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5} = req.body;
    const result = await mssql.query`
      INSERT INTO Nivel(IDNivel, Nombre, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5) 
      VALUES (${IDNivel}, ${Nombre},${Coleccionable1},${Coleccionable2},${Coleccionable3},${Coleccionable4},${Coleccionable5}); 
      SELECT SCOPE_IDENTITY() AS [newIDNivel]
    `;
    const newIDNivel = result.recordset[0]['newIDNivel'];
    res.type('text').status(201).send(
      `Resource created with ID = ${newIDNivel}.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/nivel/:IDNivel', async (req, res) => {
  try {
    const IDNivel = req.params.IDNivel;
    const result = await mssql.query`
      DELETE FROM Nivel 
      WHERE IDNivel=${IDNivel}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(`Resource with IDNivel = ${IDNivel} deleted.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with IDNivel = ${IDNivel} not found. No resources deleted.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/nivel', async (req, res) => {
  try {
    const result = await mssql.query`
      DELETE FROM Nivel
    `;
    res.type('text').send(`${result.rowsAffected[0]} resource(s) deleted.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.put('/nivel/:IDNivel', async (req, res) => {
  try {
    const IDNivel = req.params.IDNivel;
    const {Nombre, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5} = req.body;
    const result = await mssql.query`
        UPDATE Nivel
        SET IDNivel=${IDNivel}, Nombre=${Nombre}, Coleccionable1=${Coleccionable1}, Coleccionable2=${Coleccionable2}, Coleccionable3=${Coleccionable3}, Coleccionable4=${Coleccionable4}, Coleccionable5=${Coleccionable5} 
        WHERE IDNivel=${IDNivel}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(
        `Resource with IDNivel = ${IDNivel} updated.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with IDNivel = ${IDNivel} not found. No resources updated.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

app.get('/jugador_partida', async (req, res) => {
  try {
    const rows = (await mssql.query`
      SELECT IDPartida, IDNivel, puntuacion, fechaJuego, cronometro, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5 FROM Jugador_partida
    `).recordset;
    const result = [];
    for (let row of rows) {
      result.push({
        IDPartida: row.IDPartida,
        IDNivel: row.IDNivel,
      	IDJugador: row.IDJugador,
      	puntuacion: row.puntuacion,
      	fechaJuego: row.fechaJuego,
      	cronometro: row.cronometro,
        Coleccionable1: row.Coleccionable1,
        Coleccionable2: row.Coleccionable2,
        Coleccionable3: row.Coleccionable3,
        Coleccionable4: row.Coleccionable4,
        Coleccionable5: row.Coleccionable5,
        url: `http://${ipAddr}:${port}/ jugador_partida/${row.IDPartida}`
      });
    }
    res.json(result);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.get('/jugador_partida/:IDPartida', async (req, res) => {
  try {
    const IDPartida = req.params.IDPartida;
    const rows = (await mssql.query`
        SELECT IDPartida, IDNivel, puntuacion, fechaJuego, cronometro, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5 FROM jugador_partida
        WHERE IDPartida=${IDPartida}
    `).recordset;
    const row = rows[0];
    if (row) {
      res.json({
        IDPartida: row.IDPartida,
        IDNivel: row.IDNivel,
	      IDJugador: row.IDJugador,
      	puntuacion: row.puntuacion,
      	fechaJuego: row.fechaJuego,
      	cronometro: row.cronometro,
        Coleccionable1: row.Coleccionable1,
        Coleccionable2: row.Coleccionable2,
        Coleccionable3: row.Coleccionable3,
        Coleccionable4: row.Coleccionable4,
        Coleccionable5: row.Coleccionable5,
   
      });
    } else {
      res.type('text').status(404).send(
        `Resource with ID = ${IDPartida} not found.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.post('/jugador_partida', async (req, res) => {
  try {
    const { IDPartida, IDNivel, IDJugador, puntuacion, fechaJuego, cronometro, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5} = req.body;
    const result = await mssql.query`
      INSERT INTO Jugador_partida (IDPartida, IDNivel, IDJugador, puntuacion, fechaJuego, cronometro, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5) 
      VALUES (${IDPartida}, ${IDNivel}, ${puntuacion}, ${fechaJuego}, ${cronometro}, ${Coleccionable1},${Coleccionable2},${Coleccionable3},${Coleccionable4},${Coleccionable5}); 
      SELECT SCOPE_IDENTITY() AS [newIDPartida]
    `;
    const newIDPartida = result.recordset[0]['newIDPartida'];
    res.type('text').status(201).send(
      `Resource created with ID = ${newIDPartida}.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/jugador_partida/:IDPartida', async (req, res) => {
  try {
    const IDPartida = req.params.IDPartida;
    const result = await mssql.query`
      DELETE FROM jugador_partida
      WHERE IDPartida=${IDPartida}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(`Resource with IDPartida = ${IDPartida} deleted.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with IDPartida = ${IDPartida} not found. No resources deleted.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

app.delete('/jugador_partida', async (req, res) => {
  try {
    const result = await mssql.query`
      DELETE FROM jugador_partida
    `;
    res.type('text').send(`${result.rowsAffected[0]} resource(s) deleted.\n`);
  } catch (err) {
    res.status(500).json(err);
  }
});

app.put('/jugador_partida/:IDPartida', async (req, res) => {
  try {
    const IDPartida = req.params.IDPartida;
    const {IDNivel, IDJugador, puntuacion, fechaJuego, cronometro, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5} = req.body;
    const result = await mssql.query`
        UPDATE jugador_partida
        SET IDNivel=${IDNivel}, puntuacion=${puntuacion}, fechaJuego=${fechaJuego}, cronometro=${cronometro}, Coleccionable1=${Coleccionable1}, Coleccionable2=${Coleccionable2}, Coleccionable3=${Coleccionable3}, Coleccionable4=${Coleccionable4}, Coleccionable5=${Coleccionable5} 
        WHERE IDPartida=${IDPartida}
    `;
    if (result.rowsAffected[0] === 1) {
      res.type('text').send(
        `Resource with IDPartida = ${IDPartida} updated.\n`);
    } else {
      res.type('text').status(404).send(
        `Resource with IDPartida = ${IDPartida} not found. No resources updated.\n`);
    }
  } catch (err) {
    res.status(500).json(err);
  }
});

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// custom 404 page
app.use((req, res) => {
  res.type('text/plain').status(404).send('404 - Not Found');
});

app.listen(port, () => console.log(
  `Express started on http://${ipAddr}:${port}`
  + '\nPress Ctrl-C to terminate.'));