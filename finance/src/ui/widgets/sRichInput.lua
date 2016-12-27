
------------------------------------------------------------------
--                         RichInput Widget                         --
------------------------------------------------------------------

require("ui/widgets/widgets")

sRichInput  = class(Widget)


function sRichInput:init(w,h)
  self.dw = w
  self.dh = h
    self.ww = w
    self.hh = h
  
  self.value  = ""  
  self.bgcolor  = {255,255,255}
  self.disabledcolor  = {128,128,128}
  self.font = {"sansserif", "r", 7}
  self.disabled = false
  
  self.editor = D2Editor.newRichText()
    self.editor:setFocus(false)
    self.editor:setFontSize(8)
     
    self.editor:registerFilter({    mouseDown = function(x,y)
                                            on.mouseDown(x,y)
                                            return false
                                    end,
                                    tabKey = function()
                                        on.tabKey()
                                    end
                                    })

--     self.editor:setFontSize(fsize)
--    self.editor:setMainFont(font,style)
--    self.text = text
--     self:resize(w,h)
end

function sRichInput:size(n)
    Widget.size(self,n)
    self.editor:move(self.x+2,self.y+1)
    self.editor:resize(self.w-2,self.h-1)
end

function sRichInput:getFocus()
    self.editor:setFocus(true)
    Widget.getFocus()
end

function sRichInput:loseFocus()
    self.editor:setFocus(false)
    Widget.loseFocus()
end

function sRichInput:onErrorDispStart()
    self:setVisible(false)
end

function sRichInput:onErrorDispEnd() 
   self:setVisible(true)
end

function sRichInput:paint(gc)
  self.gc = gc
  local x = self.x
  local y =   self.y
  
--  gc:setFont(uCol(self.font))
  gc:setColorRGB(uCol(self.bgcolor))
  gc:fillRect(x, y, self.w, self.h)

  gc:setColorRGB(0,0,0)
  gc:drawRect(x, y, self.w, self.h)
  
  if self.hasFocus then
    gc:drawRect(x-1, y-1, self.w+2, self.h+2)
  end 
end

function sRichInput:charIn(char)
--  if self.disabled or (self.number and not tonumber(self.value .. char)) then --or char~="," then
--    return
--  end
  --char = (char == ",") and "." or char
--  self.value  = self.value .. char
end

function sRichInput:clearKey()
    if self:deleteInvalid() then return 0 end
    self.value  = ""
end

function sRichInput:backspaceKey()
    if self:deleteInvalid() then return 0 end
  if not self.disabled then
    self.value  = self.value:usub(1,-2)
  end
end

function sRichInput:deleteInvalid()
    local isInvalid = string.find(self.value, "Invalid input")
    if isInvalid then
        self.value = self.value:usub(1, -19)
        return true
    end
    return false
end

function sRichInput:enable()
  self.disabled = false
end

function sRichInput:disable()
  self.disabled = true
end


function sRichInput:setVisible(isVisible)
  self.editor:setVisible(isVisible)
end
