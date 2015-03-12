require 'redis'
require 'statsd-ruby'
require_relative './environment'

module Minecraft
  class Monitor
    attr_reader :redis, :statsd

    def initialize
      @redis = Redis.new host:ENV['redis_host'], db:ENV['redis_db']
      @statsd = Statsd.new(ENV['statsd_host'], ENV['statsd_port'].to_i)
    end

    def find(namespace, &block)
      keys = @redis.hkeys namespace
      if keys.length == 0
        puts "Warning: There's no hash key for #{key} in Redis."
        return false
      end

      metrics = {}
      keys.each do |k|
        metrics[k.to_sym] = @redis.hget(namespace, k)
      end

      # yield(metrics)
      instance_exec(metrics, &block) if block_given?
    end

    def push(data, mapping={})
      # just push everything
      if data.respond_to? :each
        data.each do |metric|
          @statsd.gauge metric[0], metric[1]
        end
      else
        @statsd.gauge mapping[:as], data
      end
    end

  end
end
