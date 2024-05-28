#!/bin/bash

activate () {
  source localvenv/bin/activate
  echo "Starting the server on port ${PORT}"
  which python
  pm2 start "python src/openscope/miner/event_subscription.py" --name real_time_events
  comx module register ff_openscope-miner0 ${COMMUNE_KEY} --netuid 5
  pm2 start "comx module serve python src/openscope/miner/signal_trade.py --ip 0.0.0.0 --port ${PORT}" --name openscope_serve_miner
  pm2 start "python src/openscope/miner/IQ50.py" --name openscope_trading_miner
  pm2 logs
}

activate