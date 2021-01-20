const express = require('express');
const app = express();
const port = parseInt(process.env.SERVER_PORT, 10) || 8100;

app.use(express.static('./www'));

// Health Check Endpoint
app.get('/health', (req, res) => {
    res.status(200).send('Server Running');
});

// Redirect all other requests to index.html
app.get('/*', (req, res) => {
    res.sendFile('index.html', {root: 'www/'});
});

app.listen(port, () => {
    console.log(`Express Server running on port ${port}`);
});