#!/bin/bash

cd /app

#generate key, executed at run time
#echo "Generating key..."
#comx key create miner_key
#echo "Key generated"

#generate the ini file
echo "Creating .ini file and placing it into env/"
python generate_ini.py
echo ".ini file created and placed"

#register the miner

#serve miner
echo "Serving the miner..."
pm2 start "python src/openscope/miner/signal_trade.py" --name serve_openscope_miner

#grab market data
echo "Pulling market data..."
pm2 start "python src/openscope/miner/event_subscription.py" --name real_time_data

#IQ50 or other trading script
echo "Starting trades..."
pm2 start "python src/openscope/miner/IQ50.py" --name iq50_script

sleep infinity