#!/bin/bash

#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Return the exit status of the last command in the pipeline that failed

cd /app || { echo "Failed to change directory to /app"; exit 1; }

# Check for required environment variables
if [[ -z "${MINER_PORT}" || -z "${MINER_KEY_NAME}" ]]; then
  echo "MINER_PORT and MINER_KEY environment variables must be set."
  exit 1
fi

# Generate the .ini file
echo "Creating .ini file and placing it into env/"
python generate_ini.py
echo ".ini file created and placed"

# Register the miner (if any registration logic is required, add here)

# Serve the miner
echo "Serving the miner..."
pm2 start "python src/openscope/miner/signal_trade.py" --name serve_openscope_miner
if [[ $? -ne 0 ]]; then
  echo "Failed to start serve_openscope_miner"
  exit 1
fi

# Grab market data
echo "Pulling market data..."
pm2 start "python src/openscope/miner/event_subscription.py" --name real_time_data
if [[ $? -ne 0 ]]; then
  echo "Failed to start real_time_data"
  exit 1
fi

# Start trades
echo "Starting trades..."
pm2 start "python src/openscope/miner/IQ50.py" --name iq50_script
if [[ $? -ne 0 ]]; then
  echo "Failed to start iq50_script"
  exit 1
fi

# Keep the container running
echo "Startup script completed. Container will now sleep indefinitely."
exec sleep infinity


