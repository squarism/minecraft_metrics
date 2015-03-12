require "spec_helper"
require "./lib/minecraft_metrics"


# preferring integration testing here ... vs unit tests
# since this project is all about talking to external services

module Minecraft
  describe Monitor do

    it "connects to a redis host" do
      ENV['redis_host'] = "foo"
      monitor = Monitor.new
      expect(monitor.redis.client.host).to eq "foo"
    end

    it "finds reactor data and pushes it with a DSL" do
      subject.find("reactor") do |hash|
        push hash[:energy], as: 'reactor.energy'
      end
    end

    it "finds whatever data in a namespace and just pushes it" do
      subject.find("reactor") do |data|
        push data
      end
    end

  end
end
