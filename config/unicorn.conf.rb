pid "/var/tmp/unicorn.pid"
# listen 8080
listen "/var/tmp/.unicorn.sock"
worker_processes 2
timeout 20
stdout_path "log/unicorn-out.log"
stderr_path "log/unicorn-err.log"
preload_app true
