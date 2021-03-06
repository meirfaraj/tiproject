 
--------------------------------------------------------------------------
--                            Combinatoire                              --
--------------------------------------------------------------------------
require("std/utils")
require("std/array")

require("ui/widgets/widgets")
require("ui/widgets/sinputwidget")
require("ui/widgets/slabelwidget")
require("ui/widgets/sdropdownwidget")
require("ui/widgets/sMathInput")
require("std/benchmark")

varValue = {}

Tmv = addExtension(Screen,WidgetManager)
 

function Tmv:init(titleId,headerId)
  print("init Tmv")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 8}
  self.operation = ""
  self.widgets  = {}
  self.lastInput=""
  self.lasth = 0
  self.space = 7
  self.spaceh = 23
  self.htitle=self.spaceh   
  self.r=0
  self.focus  = 0
  self.boxX=0
  self.boxY=0
  self.boxW=10
  self.boxH=10
  self.lastRow=0
  self.curx=0
  self.varTxt=""
  self.cury=0
  self:size()
  self.lastVarValue = {}
  self.viewTitle=true
  self.boxOnly=false
  print("end Tmv num of widget="..tostring(table.getn(self.widgets)))
end

function Tmv:widgetsInit()
  print("Tmv:widgetsInit")
  self.cury=0
  self.boxX=self.space
  self.boxY=self.spaceh+self.cury
  self.boxW= self.w-14
  self.boxH=self.h-self.boxY-6
  self.modification=true
  self.viewTitle=false
  self.boxOnly=true
  self:refreshBox()
  self:perform()
  self.Box:setFocus(true)
  self.Box:setVisible(true)
  self:invalidate()  
end


function Tmv:CreateBox()
  if not self.Box then
     --self.Box = D2Editor.newRichText()
     self.Box = sMathInput(self.boxW,self.boxH)
     self.Box.editor:setFontSize(6)
     --self.Box:createMathBox()
     self.lastInput=""
--self.Box:registerFilter {
--            tabKey = function()
--                 if not self.Box:hasFocus() then
--                      Tmv:tabKey() 
--                 end
--              return true end,
--            charIn = function(ch)
--                   if not self.Box:hasFocus() then
--                     Tmv:charIn(ch) 
--                   end
--                   if self.boxOnly  then
--                      Tmv:charIn(ch) 
--                   end
--                   return self.Box:hasFocus() 
--              end,
--            arrowKey = function(key) 
--                   if not self.Box:hasFocus() then
--                      Tmv:arrowKey(key) 
--                   end
--                   return self.Box:hasFocus()
--                end
--     }
  end
end
 
function Tmv:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      self:invalidate()
      return true
   end
   return false
end

function Tmv:refreshBox()
    self.x=0
    self.y=0
  self.ww = pww()
  self.hh = pwh()
  if self:calculateSize() or not self.Box then
      self:CreateBox()
      if self.Box and self.x and self.y and self.w and self.h then
        self.Box:move(self.boxX,self.boxY)
        self.Box:resize(self.boxW, self.boxH)
      end
  end
end
   

function Tmv:postPaint(gc)
    --print("Tmv:postPaint")
    self:refreshBox()
end
 
function  Tmv:onChangeUpd()
end

function  Tmv:extractValue(x)
   if x[2]=="text" or x[2]=="list" then       
      val = x[4].value
      if val == nil or val == "" then
        val = x[6]
      end
      self.varTxt = self.varTxt..tostring(x[6]).."="..tostring(val)..","
      if self.lastVarValue[x[6]] ~= val then
        varValue[x[6]] = val
        self.lastVarValue[x[6]] = val
        self.modification = true
      end
   end
end

function Tmv:extractTxt()
    self.varTxt=""
    table.foreach(self.inputs, function(k,v) self:extractValue(v) end)
    self.varTxt=self.varTxt.."\n"
end

function Tmv:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function Tmv:evaluateTextSize(text)
   return string.len(text)*5.5
end

function Tmv:add(row,text,varname,onchange)
   if self.inputs == nil then
      self.inputs = {}
   end       
   if type(text) == "string" then
     curInput=sInput()
     curInput.extraChange=onchange
       function curInput:onChange()
          if self.extraChange == true then
             self.parent:onChangeUpd()
          end
       end

     curLabel=sLabel(text,curInput)
     result={row,"text",curLabel,curInput,text,varname,onchange}
     self.inputs[table.getn(self.inputs)+1]=result
     curInput:setWidth(50)
     print("add "..tostring(row)..","..tostring(text)..""..tostring(varname))
   end
   if type(text) == "table" then
     curInput=sDropdown(text)
     function curInput:onOpen()
        self.parent.Box:setVisible(false)
     end
     function curInput:onClose()
         self.parent.Box:setVisible(true)
         
     end
     curInput.extraChange=onchange
     function curInput:change()
       if self.extraChange == true then
          self.parent:onChangeUpd()
       end
       self.parent:perform()
     end
     result={row,"list",nil,curInput,text,varname,onchange}
     self.inputs[table.getn(self.inputs)+1]=result
     print("add "..tostring(row)..","..table.val_to_str (text)..""..tostring(varname))
   end   
   return result
end



function  Tmv:addWidget(x)
   local row = tonumber(x[1])
   print(tostring(row).."widget="..tostring(x[6]))
   if row> self.lastRow then
      print("new row")
      self.lastRow = row
      self.curx=0
      if row == 1 then
       self.cury=self.htitle
      end
      self.cury=self.cury+self.spaceh
   end
   if x[2]=="text" then       
       loc=x[3]
       self:appendWidget(loc, self.curx , self.cury)
       loc:setPos(self.curx , self.cury)
       loc=x[4]
       self.curx=self.curx+self.space+self:evaluateTextSize(x[5])       
       self:appendWidget(loc, self.curx+self.space , self.cury)
       loc:setPos(self.curx+self.space , self.cury)
       loc.number=false
       if varValue[x[6]]~=nil then
          loc.value=varValue[x[6]]
       end
       self.curx=self.curx+loc.dw+self.space
   end
   if x[2]=="list" then  
      if row == -1 then
        if self.lastRow == 0 then
           self.curx=self.space
        else
           self.curx=self.ww-x[4].dw-self.space
        end
        self.lastRow = -1
        self.cury=2
      end
       loc=x[4]
      
       self:appendWidget(loc, self.curx+self.space , self.cury)
       loc:setPos(self.curx+self.space , self.cury)
       self.curx=self.curx+loc.dw+self.space
   end    
   self.boxX=self.space
   self.boxY=self.spaceh+self.cury
   self.boxW= self.w-14
   self.boxH=self.h-self.boxY-6     
   
   if x[2]=="text" and not self.yetinit then
      self.yetinit=true
      x[4].focusDown = 1
--      x[4]:giveFocus()
   end   
end


function  Tmv:pushed()
    if self.inputs==nil then
      self.inputs = {}
      self:widgetsInit()
    end
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    if self.widgets==nil or table.getn(self.widgets)==0 then
        self.lasth = 0
        self.lastRow=0
        self.curx=0
        self.cury=self.htitle
        self.widgets  = {}
        table.foreach(self.inputs, function(k,v) self:addWidget(v) end)
        print("appendWidget enterP num of widget="..tostring(table.getn(self.widgets)))
        self:refreshBox()
        self:appendWidget(self.Box, self.boxX,self.boxY)
    end
    
    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    if not self.viewTitle then
        form=tostring(self.operation)
    end
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    if self.Box.setExpression then
        self.Box:setColorable(true)
        self.Box:setTextColor(0x215c98)
        self.Box:setExpression(form, 1)
    else
        self.Box:setText(form, 1)
    end
    
    if self.boxOnly then
       self.Box:setFocus(true)
       self.Box:setVisible(true)
    else
       self.Box:setFocus(false)
    end
    self:invalidate()
end

function Tmv:screenGetFocus()
    self:pushed()
end

function Tmv:screenLoseFocus()
    self:removed()
end


function Tmv:removed()
    if self.Box then
     if self.Box.setVisible then
           self.Box:setVisible(false)
     end
     self.Box:setText("")
     self.Box:resize(1, 1)
     self.Box:move(-10, -10)
     self.Box:registerFilter(nil)
      self.Box:setFocus(false)
    end
    doNotDisplayIcon = false
end
 
 
function Tmv:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,Tmv.font)
  self:extractTxt()
  if self.modification then
     self.modification = false
     self:perform()
     local form =tostring(self.header)..tostring(self.operation)
     if not self.viewTitle then
        form=tostring(self.operation)
     end
     self.Box:setExpression(form)
  end
end

function Tmv:performCalc()
end

function Tmv:appendToResult(x)
   self.operation =  self.operation .." ".. tostring(x)
end

function Tmv:appendTitleToResult(x)
   x=string.gsub(x,"(%S+)","\\1title %1")
   self.operation =  self.operation.." " .. tostring(x).."\n"
end

function Tmv:appendBoldToResult(x)
   x=string.gsub(tostring(x),"(%S+)","\\1title %1")
   self.operation =  self.operation.." " .. tostring(x)
end


function Tmv:appendMathToResult(x)
   self:appendToResult("\\0el {"..tostring(x).."}")
end

function Tmv:perform()
   self.Box:setVisible(true)
   self.operation = ""
   self:extractTxt()
   self.operation = self.varTxt   
   self:performCalc()
   self:invalidate()
end

function Tmv:enterKey()
    self:perform()
    WidgetManager.enterKey(self)
end

function Tmv:arrowKey(arrow)
   WidgetManager.arrowKey(self,arrow)
   self:perform()
end

function Tmv:escapeKey()
  local cid = self.cid
  print("before : "..tostring(cid))
  self:removed()
  print(tostring(cid))
  if cid then
    only_screen_back(SubCatSel, self.cid)
    print("reset cid")
    self.cid = nil
    self.sid = nil
    return
  end
  only_screen_back(Ref)
end

require("finance/tmv/tauxSimple")
require("finance/tmv/tauxCompose")
