# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rainbows"
  s.version = "4.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rainbows! hackers"]
  s.date = "2011-09-02"
  s.description = "\\Rainbows! is an HTTP server for sleepy Rack applications.  It is based on\nUnicorn, but designed to handle applications that expect long\nrequest/response times and/or slow clients."
  s.email = "rainbows-talk@rubyforge.org"
  s.executables = ["rainbows"]
  s.extra_rdoc_files = ["ChangeLog", "DEPLOY", "FAQ", "lib/rainbows.rb", "lib/rainbows/actor_spawn.rb", "lib/rainbows/app_pool.rb", "lib/rainbows/base.rb", "lib/rainbows/configurator.rb", "lib/rainbows/coolio.rb", "lib/rainbows/coolio_thread_pool.rb", "lib/rainbows/coolio_thread_spawn.rb", "lib/rainbows/dev_fd_response.rb", "lib/rainbows/epoll.rb", "lib/rainbows/event_machine.rb", "lib/rainbows/fiber_pool.rb", "lib/rainbows/fiber_spawn.rb", "lib/rainbows/max_body.rb", "lib/rainbows/never_block.rb", "lib/rainbows/rev.rb", "lib/rainbows/rev_fiber_spawn.rb", "lib/rainbows/rev_thread_pool.rb", "lib/rainbows/rev_thread_spawn.rb", "lib/rainbows/revactor.rb", "lib/rainbows/sendfile.rb", "lib/rainbows/server_token.rb", "lib/rainbows/stream_response_epoll.rb", "lib/rainbows/thread_pool.rb", "lib/rainbows/thread_spawn.rb", "lib/rainbows/thread_timeout.rb", "lib/rainbows/worker_yield.rb", "lib/rainbows/writer_thread_pool.rb", "lib/rainbows/writer_thread_spawn.rb", "lib/rainbows/xepoll.rb", "lib/rainbows/xepoll_thread_pool.rb", "lib/rainbows/xepoll_thread_spawn.rb", "LATEST", "LICENSE", "NEWS", "README", "SIGNALS", "TODO", "TUNING", "vs_Unicorn", "Summary", "Test_Suite", "Static_Files", "Sandbox"]
  s.files = ["bin/rainbows", "ChangeLog", "DEPLOY", "FAQ", "lib/rainbows.rb", "lib/rainbows/actor_spawn.rb", "lib/rainbows/app_pool.rb", "lib/rainbows/base.rb", "lib/rainbows/configurator.rb", "lib/rainbows/coolio.rb", "lib/rainbows/coolio_thread_pool.rb", "lib/rainbows/coolio_thread_spawn.rb", "lib/rainbows/dev_fd_response.rb", "lib/rainbows/epoll.rb", "lib/rainbows/event_machine.rb", "lib/rainbows/fiber_pool.rb", "lib/rainbows/fiber_spawn.rb", "lib/rainbows/max_body.rb", "lib/rainbows/never_block.rb", "lib/rainbows/rev.rb", "lib/rainbows/rev_fiber_spawn.rb", "lib/rainbows/rev_thread_pool.rb", "lib/rainbows/rev_thread_spawn.rb", "lib/rainbows/revactor.rb", "lib/rainbows/sendfile.rb", "lib/rainbows/server_token.rb", "lib/rainbows/stream_response_epoll.rb", "lib/rainbows/thread_pool.rb", "lib/rainbows/thread_spawn.rb", "lib/rainbows/thread_timeout.rb", "lib/rainbows/worker_yield.rb", "lib/rainbows/writer_thread_pool.rb", "lib/rainbows/writer_thread_spawn.rb", "lib/rainbows/xepoll.rb", "lib/rainbows/xepoll_thread_pool.rb", "lib/rainbows/xepoll_thread_spawn.rb", "LATEST", "LICENSE", "NEWS", "README", "SIGNALS", "TODO", "TUNING", "vs_Unicorn", "Summary", "Test_Suite", "Static_Files", "Sandbox"]
  s.homepage = "http://rainbows.rubyforge.org/"
  s.rdoc_options = ["-t", "Rainbows! - Unicorn for sleepy apps and slow clients", "-W", "http://bogomips.org/rainbows.git/tree/%s"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rainbows"
  s.rubygems_version = "1.8.24"
  s.summary = "- Unicorn for sleepy apps and slow clients"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["~> 1.1"])
      s.add_runtime_dependency(%q<kgio>, ["~> 2.5"])
      s.add_runtime_dependency(%q<unicorn>, ["~> 4.1"])
      s.add_development_dependency(%q<isolate>, ["~> 3.1"])
      s.add_development_dependency(%q<wrongdoc>, ["~> 1.6"])
    else
      s.add_dependency(%q<rack>, ["~> 1.1"])
      s.add_dependency(%q<kgio>, ["~> 2.5"])
      s.add_dependency(%q<unicorn>, ["~> 4.1"])
      s.add_dependency(%q<isolate>, ["~> 3.1"])
      s.add_dependency(%q<wrongdoc>, ["~> 1.6"])
    end
  else
    s.add_dependency(%q<rack>, ["~> 1.1"])
    s.add_dependency(%q<kgio>, ["~> 2.5"])
    s.add_dependency(%q<unicorn>, ["~> 4.1"])
    s.add_dependency(%q<isolate>, ["~> 3.1"])
    s.add_dependency(%q<wrongdoc>, ["~> 1.6"])
  end
end
