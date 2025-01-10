# envoy-pilot


1. **Start Envoy (epoch 0)**  
   ```bash
   RESTART_EPOCH=0 python /Users/sai/Projects/envoy-pilot/hot-restarter.py \
     /opt/homebrew/bin/envoy \
     -c /Users/sai/Projects/envoy-pilot/envoy.yaml \
     --service-cluster cluster1
   ```
   This runs Envoy under the hot-restarter script.

2. **Trigger Hot Reload**  
   ```bash
   pkill -HUP -f hot-restarter.py
   ```
   This sends a `SIGHUP` to hot-restarter, which **spawns a new Envoy process** (next epoch) with the updated config and gracefully shuts down the old one.