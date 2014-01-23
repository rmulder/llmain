use Rack::ContentLength
use Rack::ContentType
run lambda { |env|
  if env['rack.multithread'] && env['rainbows.model'] == :ActorSpawn
    [ 200, {}, [ Actor.current.inspect << "\n" ] ]
  else
    raise "rack.multithread is not true"
  end
}
