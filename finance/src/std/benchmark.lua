watchdog = {}

function watchdog:start(main)
   self.main=main
   self.startT=timer.getMilliSecCounter()
   self.step={}
end

function watchdog:step(title)
   self.step[title]=timer.getMilliSecCounter()
end

function watchdog:stop(warn)
   self.stopT=timer.getMilliSecCounter()
   if warn<self.stopT-self.startT then
      print(tostring(self.main).." take "..tostring(self.stopT-self.startT).."ms")
      table.foreach(self.step, function(k,v) print("|->"..tostring(k).." : "..tostring(v-self.startT).."ms") end)
   end
end
