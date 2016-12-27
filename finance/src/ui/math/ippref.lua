 
--------------------------------------------------------------------------
--                            references IPP                          --
--------------------------------------------------------------------------
require("ui/math/enterFormulas")

Ipp = WScreen()
 
Ipp.font = "serif"
Ipp.h = pwh()  
Ipp.w = pww()


Ipp.enterFunction = sButton(ASTxt(ENTER_FONCTION_ID))
Ipp:appendWidget(Ipp.enterFunction, 0, 0)


function Ipp.enterFunction:action()
    enterFormulas:previousScreen(Ipp)
    push_screen(enterFormulas)
end

function Ipp:CreateBox()
	if not self.IppBox then
	   self.IppBox = D2Editor.newRichText()
	   self.IppBox:createMathBox()
	end
end
 
function Ipp:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h).." ;Ipp.enterFunction.h="..tostring(Ipp.enterFunction.h))
      self.lasth=self.h
      self.lastw=self.w
      self.enterButX=-Ipp.enterFunction.w      
      self.enterButY=self.h -Ipp.enterFunction.h -3
      self.boxX=2
      self.boxY=30
      self.boxW= self.w-14
      self.boxH=self.h-self.boxY-Ipp.enterFunction.h-6     
      print("self.enterButX="..tostring(self.enterButX)..";self.enterButY="..tostring(self.enterButY))
      return true
   end
   return false
end

function Ipp:refreshIppBox()
	--self:init(pww(), pwh())
    self.x=0
    self.y=0
	self.ww	= pww()
	self.hh	= pwh()
	if self:calculateSize() or not self.IppBox then
      self:CreateBox()
      if self.IppBox and self.x and self.y and self.w and self.h then
        self.IppBox:move(self.boxX,self.boxY)
        self.IppBox:resize(self.boxW, self.boxH)
      end
	  Ipp.enterFunction:setPos(self.enterButX, self.enterButY)
	end
end
   

function Ipp:postPaint(gc)
    -- self:refreshIppBox()
end
 
function Ipp:integr()
  Ipp.operation=ASTxt(ENTER_A_FUNC_TO_START_ID)
  if enterFormulas.formula and enterFormulas.formula:len()>1 then
    Ipp.operation=ASTxt(FUNCTION_ID).."\\0el {"..enterFormulas.formula.."}\n"
	Integration:setFunction(enterFormulas.formula)
	Ipp.operation = Ipp.operation..Integration:integrBy(enterFormulas.var,enterFormulas.borderDown,enterFormulas.borderUp)
  end
end

 
function  Ipp:pushed()
    doNotDisplayIcon = true
	
    self:refreshIppBox()
    self.IppBox:setReadOnly(true)
	self:integr()
	local form ="\\0el {∫(u*v',x,a,b)  =  [u*v]system(b,a)  -  ∫(u'*v,x,a,b)}\n"..Ipp.operation
    self.IppBox:setBorderColor(0x51cecb)
    self.IppBox:setBorder(1)
	if self.IppBox.setExpression then
        self.IppBox:setColorable(true)
        self.IppBox:setTextColor(0x215c98)
		self.IppBox:setExpression(form, 1)
        self.IppBox:setFocus(true)
    else
        self.IppBox:setText(form, 1)
    end
    
               self.IppBox:setVisible(true)
end


function Ipp:screenGetFocus()
    self:pushed()
end

function Ipp:screenLoseFocus()
    self:removed()
end


function Ipp:removed()
    if self.IppBox then
	   if self.IppBox.setVisible then
           self.IppBox:setVisible(false)
       else
           self.IppBox:setText("")
           self.IppBox:resize(1, 1)
           self.IppBox:move(-10, -10)
       end
	end
	self.IppBox = nil
    doNotDisplayIcon = false
end
 
function Ipp:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	Ipp.h = printTitle(gc,IPP_TITLE_ID,Greek.font)
end
 
function Ipp:enterKey()
    Ipp.font = Ipp.font == "serif" and "sansserif" or "serif"
    self.invalidate()
end

function Ipp:escapeKey()
	only_screen_back(Ref)
end

