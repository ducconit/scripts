#!/usr/bin/bash

version=v1.108.1

# https://docs.victoriametrics.com/quick-start/#starting-vm-single-from-a-binary
mkdir -p temp
wget -q https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v$version/victoria-metrics-linux-amd64-v$version.tar.gz -O temp/victoria-metrics-linux-amd64-v$version.tar.gz
sudo tar -xf temp/victoria-metrics-linux-amd64-v$version.tar.gz -C /usr/local/bin

sudo chmod +x /usr/local/bin/victoria-metrics-prod
rm -r temp

sudo useradd -s /usr/sbin/nologin victoriametrics
sudo mkdir -p /var/lib/victoria-metrics && sudo chown -R victoriametrics:victoriametrics /var/lib/victoria-metrics

sudo tee -a /etc/systemd/system/victoriametrics.service <<EOT
[Unit]
Description=VictoriaMetrics service
After=network.target

[Service]
Type=simple
User=victoriametrics
Group=victoriametrics
ExecStart=/usr/local/bin/victoria-metrics-prod -storageDataPath=/var/lib/victoria-metrics -retentionPeriod=30d -selfScrapeInterval=10s
SyslogIdentifier=victoriametrics
Restart=always

PrivateTmp=yes
ProtectHome=yes
NoNewPrivileges=yes

ProtectSystem=full

[Install]
WantedBy=multi-user.target
EOT
