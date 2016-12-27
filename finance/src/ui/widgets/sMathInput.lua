
------------------------------------------------------------------
--                         MathInput Widget                         --
------------------------------------------------------------------

require("std/str")
require("ui/widgets/sRichInput")

sMathInput  = class(Widget)

function sMathInput:init(w,h)
    sRichInput.init(self,w,h)
    self.editor:registerFilter({
           arrowLeft = function()
              _, curpos = self.editor:getExpressionSelection()
              if curpos<7 then 
                 return true
              end
              return false
           end,
           arrowRight = function()
              currentText, curpos = self.editor:getExpressionSelection()
              if curpos>ulen(currentText)-2 then
                 return true
              end
              return false
           end,
           tabKey = function()
              on.tabKey()
              return true
           end ,
           mouseDown = function(x,y)
                                        on.mouseDown(x,y)
                                        return false
                                    end ,
                                    backspaceKey = function()
                                               self:fixCursor()
                                               _,curpos = self.editor:getExpressionSelection()
                                               if curpos <= 6 then return true end
                                               return false
                                    end ,
                                    deleteKey = function()
                                               self:fixCursor()
                                               currentText,curpos = self.editor:getExpressionSelection()
                                               if curpos >= ulen(currentText)-1 then return true end
                                               return false
                                    end ,
                                    enterKey = function()
                                           on.tabKey()
                                    end ,
                                    returnKey = function()
                                           on.tabKey()
                                    end ,
                                    charIn = function(c)
                                            self:fixCursor()
                                            return false
                                    end
                               })
      self:fixContent()
end

function sMathInput:fixContent()
                                            currentText = self.editor:getExpressionSelection()
                                            if currentText=="" or currentText==nil then
                                                self.editor:createMathBox()
                                            end
end

function sMathInput:fixCursor()
                                            currentText, curpos, selstart = self.editor:getExpressionSelection()
                                            l = ulen(currentText)
                                            if curpos<6 or selstart<6 or curpos>l-1 or selstart>l-1 then
                                                if curpos<6 then curpos=6 end
                                                if selstart<6 then selstart=6 end
                                                if curpos>l-1 then curpos=l-1 end
                                                if selstart>l-1 then selstart=l-1 end
                                                self.editor:setExpression(currentText,curpos,selstart)
                                            end
end

function sMathInput:size(n)
    sRichInput.size(self,n)
end

function sMathInput:getFocus()
    sRichInput.getFocus(self)
end

function sMathInput:loseFocus()
    sRichInput.loseFocus(self)
   -- handle(self)
end

function sMathInput:paint(gc)
  sRichInput.paint(self,gc)
end

function sMathInput:enable()
  self.disabled = false
end

function sMathInput:onErrorDispStart()
    self:setVisible(false)
end

function sMathInput:onErrorDispEnd() 
   self:setVisible(true)
end




function sMathInput:disable()
  self.disabled = true
end


function sMathInput:hasFocus()
   self.editor:hasFocus()
end

function sMathInput:setReadOnly(isReadOnly)
   self.editor:setReadOnly(isReadOnly)
end

function sMathInput:setBorderColor(borderColor)
   self.editor:setBorderColor(borderColor)
end


function sMathInput:setBorder(border)
   self.editor:setBorder(border)
end

function sMathInput:setTextColor(color)
   self.editor:setTextColor(color)
end

function sMathInput:setColorable(isColorable)
  self.editor:setColorable(isColorable)
end

function sMathInput:setVisible(isVisible)
  self.editor:setVisible(isVisible)
end

function sMathInput:getRawExpression()
   return self.editor:getExpression()
end

function sMathInput:setFocus(isFocus)
   return self.editor:setFocus(isFocus)
end

function sMathInput:setExpression(str)
     if self.editor.setExpression then
        self.editor:setExpression(str, 1)
     else
         self.editor:setText(str, 1)
     end

end

function sMathInput:getExpression()
    local rawexpr = self:getRawExpression()
    if(not rawexpr) then rawexpr="" end
    local expr = ""
    local n=string.len(rawexpr)
    local b=0
    local bs=0
    local bi=0
    local status=0
    local i=1
    local c
    while i<=n do
        c = string.sub(rawexpr,i,i)
        if c=="{" then
            b=b+1
        elseif c=="}" then
            b=b-1
        end
        if status==0 then
            if string.sub(rawexpr,i,i+5)=="\\0el {" then
                bs=i+6
                i=i+5
                status=1
                bi=b
                b=b+1
            end
        else
            if b==bi then
                status=0
                expr = expr..string.sub(rawexpr,bs,i-1)
            end
        end
        i=i+1
    end
    return expr
end
