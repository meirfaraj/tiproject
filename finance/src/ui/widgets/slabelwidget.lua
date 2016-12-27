
------------------------------------------------------------------
--                         Label Widget                         --
------------------------------------------------------------------

sLabel	=	class(Widget)

function sLabel:init(text, widget)
	self.widget	=	widget
	self.text	=	text
	self.ww		=	30
	
	self.hh		=	20
	self.lim	=	false
	self.color	=	{0,0,0}
	self.dcolor  = {120,120,120}
	self.font	=	{"sansserif", "r", 10}
	self.p		=	"top"
  self.disabled = false
	
end

function sLabel:paint(gc)
	gc:setFont(uCol(self.font))
	if self.disabled then
   	gc:setColorRGB(uCol(self.dcolor))
	else
   	gc:setColorRGB(uCol(self.color))
	end
	local text	=	""
	local ttext
	if self.lim then
		text, self.dw	= textLim(gc, self.text, self.w)
	else
		text = self.text
	end
	
	gc:drawString(text, self.x, self.y, self.p)
end

function sLabel:getFocus(n)
	if n then
		n	= n < 0 and -1 or (n > 0 and 1 or 0)
	end
	
	if self.widget and not n then
		self.widget:giveFocus()
	elseif n then
		self.parent:switchFocus(n)
	end
end



function sLabel:enable()
  self.disabled = false
end

function sLabel:disable()
  self.disabled = true
end




