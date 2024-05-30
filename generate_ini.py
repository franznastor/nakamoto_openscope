import os

# Retrieve the MINER_PORT and the MINER_KEY from environment variables
miner_port = os.getenv('MINER_PORT', default='9999')
miner_key = os.getenv('MINER_KEY_NAME', default=None)

# Check if the critical environment variable MINER_KEY is present
if miner_key is None:
    raise ValueError("The environment variable MINER_KEY is not set.")

# Define the content of the .ini file
ini_content = f"""
[miner]
keyfile = {miner_key}
url = http://0.0.0.0:{miner_port}/

[api]
url = http://8.219.104.233:8000/
"""

# Ensure the target directory exists
os.makedirs('env', exist_ok=True)

# Write the content to the env/config.ini file
with open('env/config.ini', 'w') as ini_file:
    ini_file.write(ini_content.strip())

print("env/config.ini file has been generated.")