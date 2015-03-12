desc "push redis data to statsd"
task :monitor do
  require_relative './lib/minecraft_metrics'
  monitor = Minecraft::Monitor.new

  trap("SIGINT") { throw :ctrl_c }

  catch :ctrl_c do
    begin
      while true do

        # TODO OMG YOU NEED EXTERNAL RULES
        monitor.find("reactor") do |hash|
          push hash[:energy], as: 'reactor.energy'
          push hash[:temp], as: 'reactor.temp'
          push hash[:fuel], as: 'reactor.fuel'
        end

        sleep 1
      end
    rescue Exception
      # this will never fire
    end
  end

end

task :default => :monitor