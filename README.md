# Minecraft Metrics

Made for monitoring minecraft.  Yes.  So the idea is something like this:

    Nuclear Reactor (in minecraft) --> OpenComputers monitoring script --> Redis
    This project --> redis --> push to statsd
    Statsd --> InfluxDB --> Grafana (actual metrics)

This is the way I decided to do it because Redis was fairly trivial to get data into from a lua shell running in Minecraft (if you haven't played with opencomputers ... wow, it's hilariously awesome).


## Setup

Within minecraft, there's a lot to say.  You might just want to find my [sister project TODO](https://github.com) that will explain how to set things up within the game.  Here's a quick rundown.

* You need a computer built
  * It needs to have an "Internet Card" installed in it so it can talk with the outside world.
  * OpenComputers.cfg needs to be modified to un-blacklist whatever Redis server you intend to push data to.
  * Whatever thing you are monitoring needs to have a connection to your (minecraft) computer.  For example, the canonical example is monitoring a nuclear reactor.  `components` should show `br_reactor`.  This is all opencomputers stuff.  They have an excellent youtube video tutorial series.
  * Then you need to fire up the reactor.lua monitoring script to push data to Redis.
  * Then you need to run this project to monitor Redis to push it to statsd.


## Questions

Perhaps pushing straight to statsd would be better.  Maybe this project will move to that.  I kind of like pushing to Redis though because then you don't have to think about time gaps (maybe).  This project could potentially just push straight to influxdb.  I'm just worried that the value of statsd will be minimal with the time averaging because noone's minecraft game is running 24/7.  So will there be massive gaps in data that cause weird averaging?