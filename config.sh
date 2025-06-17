ufw enable
ufw status
ufw allow 4242/tcp

chmod +x /usr/local/libexec/monitoring.sh
chmod +x /usr/local/libexec/monitoring_broadcast.sh

systemctl daemon-reload
systemctl enable monitoring_trigger.path
