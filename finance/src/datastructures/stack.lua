
------------------------------------------------------------------
--                        stack  Class                         --
------------------------------------------------------------------

Stack	= class()

function Stack:init()
   self.count=0
   self.items={}
end

function Stack:push(data)
   self.count=self.count+1
   self.items[self.count]=data
end

function Stack:pop()
   if self.count==0 then
      return nil
   end
   local data = self.items[self.count]
   self.count = self.count -1
   return data
end

function Stack:top()
   if self.count==0 then
      return nil
   end
   local data = self.items[self.count]
   return data
end
