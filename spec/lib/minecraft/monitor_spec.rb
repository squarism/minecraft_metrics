require "spec_helper"
require "./minecraft_metrics"

describe Minecraft do
  describe Monitor do

    it "connects to redis" do
      expect(subject.redis).to_not be nil
    end

  end
end
