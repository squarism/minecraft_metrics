local component = require("component")
local computer = require 'computer'
local event = require 'event'
local fs = require "filesystem"
local getopt = require 'getopt'
local shell = require 'shell'

function init()
  redis = require("redis")
  client = redis.connection('opencomputers://CHANGE_ME:6379')
  client:select(11)
end

function reactorStatus(reactor)
  status = {}
  status["energy"] = reactor.getEnergyStored()
  status["fuel"] = reactor.getFuelAmount()
  status["temp"] = reactor.getFuelTemperature()
  status["power"] = reactor.getActive()
  return status
end

function biogenStatus(generator)
  status = {}
  status["energy"] = generator.getEnergyStored()
  if generator.getStackInSlot(1) then
    status["extra_fuel"] = generator.getStackInSlot(1).size
  else
    status["extra_fuel"] = 0
  end
  return status
end



function updateRedis()
  reactor_s = reactorStatus(component.getPrimary("br_reactor"))
  biogen_s = biogenStatus(component.getPrimary("bio_generator"))

  for k,v in pairs(reactor_s) do
    client:hset("reactor", k, v)
  end

  for k,v in pairs(biogen_s) do
    client:hset("biogen", k, v)
  end


end

-------------------------------------------------------------------------------
-- Main

init()
print("[OK]  Monitoring energy things and pushing to real-world Redis.")

local running = true
while running do
  updateRedis()
  os.sleep(1)
end
