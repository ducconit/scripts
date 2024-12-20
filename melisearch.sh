#!/usr/bin/bash

# read more: https://www.meilisearch.com/docs/guides/deployment/running_production

curl -L https://install.meilisearch.com | sh

sudo mv ./meilisearch /usr/local/bin/

sudo useradd -d /var/lib/meilisearch -s /bin/false -m -r meilisearch

sudo chown meilisearch:meilisearch /usr/local/bin/meilisearch

sudo mkdir /var/lib/meilisearch/data /var/lib/meilisearch/dumps /var/lib/meilisearch/snapshots

sudo chown -R meilisearch:meilisearch /var/lib/meilisearch

sudo chmod 750 /var/lib/meilisearch

wget https://raw.githubusercontent.com/meilisearch/meilisearch/latest/config.toml

sudo mv config.toml /etc/meilisearch.toml

sudo tee -a /etc/systemd/system/melisearch.service <<EOT
[Unit]
Description=Meilisearch
After=systemd-user-sessions.service

[Service]
Type=simple
WorkingDirectory=/var/lib/meilisearch
ExecStart=/usr/local/bin/meilisearch --config-file-path /etc/meilisearch.toml
User=meilisearch
Group=meilisearch
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOT
