#!/usr/bin/bash

version=1.8.2

mkdir -p temp
mkdir -p node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v$version/node_exporter-$version.linux-amd64.tar.gz -O temp/node_exporter.tar.gz

tar --strip-components=1 -zxvf temp/node_exporter.tar.gz -C node_exporter
rm -r temp

sudo mv node_exporter /opt
sudo groupadd -r node_exporter
sudo useradd -r -s /bin/false -g node_exporter node_exporter

sudo tee -a /etc/systemd/system/node_exporter.service <<EOT
[Unit]
Description=Node Exporter
Documentation=https://prometheus.io/docs/guides/node-exporter/
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
ExecStart=/opt/node_exporter/node_exporter --web.listen-address=:9100

[Install]
WantedBy=multi-user.target
EOT

sudo chown node_exporter:node_exporter -R /opt/node_exporter
