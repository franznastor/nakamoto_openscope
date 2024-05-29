#!/bin/bash

# activate () {
#   echo "Starting the server on port ${PORT}"
#   which python
#   pm2 start "python src/openscope/miner/event_subscription.py" --name real_time_events
#   comx module register <name-of-your-miner> ${COMMUNE_KEY} --netuid 5
# }

# activate

cd /app

pm2 start "python src/openscope/miner/signal_trade.py" --name serve_openscope_miner
pm2 start "python src/openscope/miner/event_subscription.py" --name real_time_data

sleep infinity