worker_processes            32
user                       "ror", "ror"
working_directory          "/web/ram/V28"
listen                      8001, :tcp_nopush => true
timeout                     30
pid                        "/var/run/unicorn/unicorn.pid"

stdout_path                "/var/log/unicorn/rails_stdout.log"
stderr_path                "/var/log/unicorn/rails_stderr.log"

preload_app                 true

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
