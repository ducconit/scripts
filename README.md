## EZ Script

1. [node_exporter.sh](Cài đặt node exporter trên server ubuntu/amd64)
```bash
bash <(wget -qO- https://raw.githubusercontent.com/ducconit/scripts/main/node_exporter.sh)
sudo service node_exporter start
sudo systemctl enable node_exporter
# Port sử dụng 9100
```

2. [melisearch.sh](Cài đặt melisearch trên server ubuntu/amd64)
```bash
bash <(wget -qO- https://raw.githubusercontent.com/ducconit/scripts/main/melisearch.sh)
sudo service melisearch start
sudo systemctl enable melisearch
# Port sử dụng 7700
```
