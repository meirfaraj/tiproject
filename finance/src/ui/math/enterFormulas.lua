
------------------------------------------------------------------
--                        Used  formula                         --
------------------------------------------------------------------

enterFormulas = WScreen()

enterFormulas.but = sButton(ASTxt(CLOSE_ID))

enterFormulas:appendWidget(enterFormulas.but, -10, -5)

enterFormulas.formula="0.8(x+3y)*"..exp_sym.."^("..neg_sym.."x-2y)"
enterFormulas.var="x"
enterFormulas.borderUp = infinit_sym
enterFormulas.borderDown = "0"

function enterFormulas:postPaint(gc)
    if self.ed then
        self.ed:move(self.x + 5, self.y + 30)
        self.ed:resize(self.w - 9, self.h - 74)
    end

    nativeBar(gc, self, self.h - 40)
end

function enterFormulas:previousScreen(scr)
   self.scr = scr
end

function enterFormulas:pushed()
    doNotDisplayIcon = true
    self.ed = D2Editor.newRichText()
    self.ed:setReadOnly(false)
    local cont = ASTxt(ENTER_FONCTION_ID).." : \\0el {"..self.formula.."} \n"..ASTxt(ENTER_VAR_ID).." : \\0el {"..self.var.."}\n"..
	ASTxt(BORDER_UP_ID).." : \\0el {"..self.borderUp.."}\n"..
	ASTxt(BORDER_DOWN_ID).." : \\0el {"..self.borderDown.."}\n"

    

    if self.ed.setExpression then
        self.ed:setColorable(true)
        self.ed:setTextColor(0x215c98)
		self.ed:setExpression(cont, 1)
		
        self.ed:registerFilter{ escapeKey = enterFormulas.closeEditor, enterKey = usedFormulas.closeEditor, tabKey = usedFormulas.leaveEditor }
        self.ed:setFocus(true)
    else
        self.ed:setText(cont, 1)
    end

    self.but:giveFocus()
end


function enterFormulas.leaveEditor()
    platform.window:setFocus(true)
    enterFormulas.but:giveFocus()
    return true
end

function enterFormulas.closeEditor()
    platform.window:setFocus(true)
    if current_screen() == enterFormulas then
        remove_screen()
    end
    doNotDisplayIcon = false
    return true
end

function enterFormulas:screenLoseFocus()
    self:removed()
end

function enterFormulas:screenGetFocus()
    self:pushed()
end

function enterFormulas:extractTxt(typeTxt)
    local expression=self.ed:getExpression()
    for word in expression:gmatch(typeTxt.." : \\0el {[^{]*}") do
    	print("found : "..word)
	    for wordRes in word:gmatch("{[^{}]*") do
    	   local result = wordRes:sub(2,wordRes:len())
    	   print("extracted : "..result)
		   return result
		end
	end
	return ""
end

function enterFormulas:removed()

    enterFormulas.formula = self:extractTxt(ASTxt(ENTER_FONCTION_ID))
	if enterFormulas.formula and enterFormulas.formula:len()>1 then
	   formula = enterFormulas.formula
	end
	print(formula)
	enterFormulas.var = self:extractTxt(ASTxt(ENTER_VAR_ID))
	enterFormulas.borderUp = self:extractTxt(ASTxt(BORDER_UP_ID))
	enterFormulas.borderDown = self:extractTxt(ASTxt(BORDER_DOWN_ID))
	if enterFormulas.ed.setVisible then
        enterFormulas.ed:setVisible(false)
    else
        enterFormulas.ed:setText("")
        enterFormulas.ed:resize(1, 1)
        enterFormulas.ed:move(-10, -10)
    end
    enterFormulas.ed = nil
    doNotDisplayIcon = false
end

function enterFormulas.but.action(self)
    remove_screen()
	push_screen(enterFormulas.scr)
end	
