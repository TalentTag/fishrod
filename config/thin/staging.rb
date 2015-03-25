---
chdir: "/var/www/fishrod/current"
environment: staging
socket: '/var/www/fishrod/shared/tmp/sockets/thin.sock'
timeout: 30
log: "/var/www/fishrod/shared/log/thin.log"
pid: '/var/www/fishrod/shared/tmp/pids/thin.pid'
max_conns: 1024
max_persistent_conns: 100
require: []
wait: 30
threadpool_size: 20
daemonize: true
user: rbdev
