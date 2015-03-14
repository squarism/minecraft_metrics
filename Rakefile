desc "push redis data to statsd"
task :monitor do
  require_relative './lib/minecraft_metrics'
  monitor = Minecraft::Monitor.new

  trap("SIGINT") { throw :ctrl_c }

  catch :ctrl_c do
    puts "Pushing redis to statsd..."
    begin
      while true do

        # TODO OMG YOU NEED EXTERNAL RULES
        monitor.find("reactor") do |hash|
          push hash[:energy], as: 'reactor.energy'
          push hash[:temp], as: 'reactor.temp'
          push hash[:fuel], as: 'reactor.fuel'
        end

        monitor.find("biogen") do |hash|
          push hash[:extra_fuel], as: 'bio_generator.extra_fuel'
          push hash[:energy_stored], as: 'bio_generator.energy_stored'
        end

        sleep 1
      end
    rescue Exception
      # this will never fire, this madness is for clean ctrl-c running
    end
  end

end

task :default => :monitor
