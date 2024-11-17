## EZ Script

1. [node_exporter.sh](Cài đặt node exporter trên server ubuntu/amd64)
```bash
bash <(wget -qO- https://raw.githubusercontent.com/ducconit/scripts/main/node_exporter.sh)
sudo service node_exporter start
sudo systemctl enable node_exporter
# Port sử dụng 9100
```
