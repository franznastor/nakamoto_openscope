import os

# Retrieve the MINER_PORT from environment variables
miner_port = os.getenv('MINER_PORT', default='9999')

# Define the content of the .ini file
ini_content = f"""
[miner]
keyfile = miner_key
url = http://0.0.0.0:{miner_port}/

[api]
url = http://8.219.104.233:8000/
"""

# Write the content to the env/config.ini file
with open('env/config.ini', 'w') as ini_file:
    ini_file.write(ini_content.strip())

print("env/config.ini file has been generated.")