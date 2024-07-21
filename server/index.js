const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const cors = require("cors");

const app = express();

app.use(express.json());
app.use(authRouter);
app.use(cors);

const listeningIP = "0.0.0.0";
const webPORT = 3001;
const emulatorPORT = 8000;

const PORT = process.env.PORT | webPORT;
const DB = "mongodb+srv://saibaddala:buntusai172@cluster0.3c73wrb.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

app.listen(PORT, listeningIP, () => {
    console.log(`Connected to port ${PORT}`);
});

mongoose
    .connect(DB)
    .then(() => {
        console.log("Database Connection succesfull");
    })
    .catch((err) => {
        console.log(err);
    });