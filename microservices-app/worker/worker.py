import os, time, redis, psycopg2

r = redis.Redis(host=os.getenv("REDIS_HOST","redis"), port=int(os.getenv("REDIS_PORT","6379")), decode_responses=True)
db = psycopg2.connect(
    host=os.getenv("DB_HOST","postgres"),
    port=os.getenv("DB_PORT","5432"),
    user=os.getenv("DB_USER","admin"),
    password=os.getenv("DB_PASSWORD","admin123"),
    dbname=os.getenv("DB_NAME","mydb"),
)

print("Worker started. Waiting for jobs in list 'jobs'...")
while True:
    job = r.blpop("jobs", timeout=5)
    if job:
        _, payload = job
        print(f"Processing job: {payload}")
        with db:
            with db.cursor() as cur:
                cur.execute("INSERT INTO products(name, price, stock) VALUES (%s, %s, %s)", (payload, 1.00, 1))
    else:
        print("heartbeat...")
