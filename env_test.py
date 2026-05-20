import os
from dotenv import load_dotenv

load_dotenv()

name = os.environ.get("MY_NAME")
password = os.environ.get("DB_PASSWORD")
api_key = os.environ.get("API_KEY")

print(f"Name: {name}")
print(f"Password: {password}")
print(f"API Key: {api_key}")