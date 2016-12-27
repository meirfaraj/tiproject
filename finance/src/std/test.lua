a = class()

function a:init(title)
   self.title=title
   print("a:init"..title)
end

b = class(a)

function b:init(title)
   self.title=title
   print("b:init"..title)
end

 function b:new (title)
      o = {}
      setmetatable(o, self)
      self.__index = self
      self:init(title)
      return o
end

function b:init(title)
   self.title=title
   print("b:init"..title)
end


o = b("r")

o = b("title")
