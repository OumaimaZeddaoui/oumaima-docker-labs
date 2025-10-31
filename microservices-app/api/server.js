const express = require('express');
const { Pool } = require('pg');
const Redis = require('ioredis');

const app = express();
const PORT = 4000;

const db = new Pool({
  host: process.env.DB_HOST || 'postgres',
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD || 'admin123',
  database: process.env.DB_NAME || 'mydb'
});

const redis = new Redis({ host: process.env.REDIS_HOST || 'redis', port: process.env.REDIS_PORT || 6379 });

app.get('/health', async (_req, res) => {
  try {
    await db.query('SELECT 1');
    await redis.ping();
    res.json({ ok: true });
  } catch (e) {
    res.status(500).json({ ok: false, error: e.message });
  }
});

app.listen(PORT, () => console.log(`API listening on port ${PORT}`));

