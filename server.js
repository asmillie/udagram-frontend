const express = require('express');
const app = express();
const port = parseInt(process.env.SERVER_PORT, 10) || 8080;

app.use(express.static('./www'));

app.get('/*', (req, res) => {
    res.sendFile('index.html', {root: 'www/'});
});

app.listen(port, () => {
    console.log(`Express Server running on port ${port}`);
});