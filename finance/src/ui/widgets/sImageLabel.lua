
------------------------------------------------------------------
--                         ImageLabel Widget                         --
------------------------------------------------------------------


sImageLabel = class(Widget)

function sImageLabel:init(img)
  self.img  = image.new(img)
    self.dw = image.width(self.img)
  self.dh = image.height(self.img)
    self.ww = image.width(self.img)
    self.hh = image.height(self.img)
  
  
  self.bgcolor  = {255,255,255}
  self.disabledcolor  = {128,128,128}
  self.font = {"sansserif", "r", 7}
  self.disabled = false
end

function sImageLabel:getFocus(n)
  if n then
    n = n < 0 and -1 or (n > 0 and 1 or 0)
  end
  
  if self.widget and not n then
--    self.widget:giveFocus()
  elseif n then
    self.parent:switchFocus(n)
  end
end

function sImageLabel:paint(gc)
  self.gc = gc
  local x = self.x
  local y =   self.y
    gc:drawImage(self.img,x,y)  
end
