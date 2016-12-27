 
--------------------------------------------------------------------------
--                            Combinatoire                              --
--------------------------------------------------------------------------
require("std/utils")
require("ui/widgets/widgets")
require("ui/widgets/sinputwidget")
require("ui/widgets/slabelwidget")

Combinatoire = addExtension(Screen,WidgetManager)
 

function Combinatoire:init(titleId,headerId)
  print("init Combinatoire")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 10}
  self.operation = ""
  self.n= "n"
  self.p="p"
  self.r=0
  self.widgets  = {}
  self.enterN = sInput()
  self.enterN:setWidth(50)
  self.enterNLabel = sLabel(ASTxt(ENTER_N_ID),self.enterN)
  self.enterP = sInput()
  self.enterP:setWidth(50)
  self.enterPLabel = sLabel(ASTxt(ENTER_P_ID),self.enterP)
  self.lastInput=""
  self.enterN.value = self.n
  self.enterP.value = self.p
  self.htitle=20    
  self.focus  = 0
  self:size()
  print("end Combinatoire num of widget="..tostring(table.getn(self.widgets)))
end

function Combinatoire:CreateBox()
  if not self.Box then
     self.Box = D2Editor.newRichText()
     self.Box:createMathBox()
     self.lastInput=""
     self.Box:registerFilter {
            tabKey = function()
                 if not self.Box:hasFocus() then
                      Combinatoire:tabKey() 
                 end
              return true end,
            charIn = function(ch)
                   if not self.Box:hasFocus() then
                      Combinatoire:charIn(ch) 
                   end
                   return self.Box:hasFocus() 
                end,
            arrowKey = function(key) 
                   if not self.Box:hasFocus() then
                      Combinatoire:arrowKey(key) 
                   end
                   return self.Box:hasFocus()
                end
     }
  end
end
 
function Combinatoire:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h))
      self.lasth=self.h
      self.lastw=self.w
      
      self.htmp =self.htitle+5
      self.enterNLabelX=0
      print("self.enterNLabelX="..tostring(self.enterNLabelX))
      self.enterNLabel:setPos(0, htmp)
      self.enterNX=self.enterNLabelX+52
      print("self.enterNX="..tostring(self.enterNX))
      self.enterN:setPos(self.enterNX, htmp)
      self.enterN.number=false
      self.enterN:enable()
      self.enterPLabelX=self.enterNX+160
      print("self.enterPLabelX="..tostring(self.enterPLabelX))
      self.enterPLabel:setPos(self.enterPLabelX,htmp)
      self.enterPX=self.enterPLabelX+52
      print("self.enterPX="..tostring(self.enterPX))
      self.enterP:setPos(self.enterPX, htmp)
      self.enterP.number=false
      self.enterP:enable()
      
      self.boxX=2
      self.boxY=30+self.htmp 
      self.boxW= self.w-14
      self.boxH=self.h-self.boxY-6-self.htmp     
      self:invalidate()
      print("return true")
      return true
   end
   return false
end

function Combinatoire:refreshBox()
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
   

function Combinatoire:postPaint(gc)
    --print("Combinatoire:postPaint")
    self:refreshBox()
end
 


function Combinatoire:extractTxt()
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="n"
  end
  if(self.enterP) then
     self.p=self.enterP.value
  else
     print("Warning : enterp is null")
     self.p="p"
  end

  return self.n,self.p
end

function Combinatoire:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function  Combinatoire:pushed()
    print("Combinatoire:pushed")
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.n= "n"
    self.p="p"
    self.widgets  = {}
    
    self:appendWidget(self.enterNLabel, self.enterNLabelX, self.htmp)
    print("appendWidget enterNLabel")
    self:appendWidget(self.enterN, self.enterNX, self.htmp)
    self.enterN.focusDown = 1
    print("appendWidget enterN")
    self:appendWidget(self.enterPLabel, self.enterPLabelX, self.htmp)
    print("appendWidget enterPLabel")
    self:appendWidget(self.enterP, self.enterPX, self.htmp)
    print("appendWidget enterP num of widget="..tostring(table.getn(self.widgets)))
            function self.enterN:enterKey()
                self:perform()
                self.Box:setFocus(true)
            end
            function self.enterP:enterKey()
                self:perform()
                self.Box:setFocus(true)
            end
    self.enterN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    if self.Box.setExpression then
        self.Box:setColorable(true)
        self.Box:setTextColor(0x215c98)
        self.Box:setExpression(form, 1)
        self.Box:setFocus(false)
    else
        self.Box:setText(form, 1)
    end
    
          self.Box:setVisible(true)
          self:invalidate()
end


function Combinatoire:screenGetFocus()
    self:pushed()
end

function Combinatoire:screenLoseFocus()
    self:removed()
end


function Combinatoire:removed()
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
 
 
function Combinatoire:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,Combinatoire.font)
  local n,p=self:extractTxt()
  if (self.lastInput~=tostring(n)..","..tostring(p)) then
     self:perform()
     self.lastInput=tostring(n)..","..tostring(p)
     local form =tostring(self.header)..tostring(self.operation)
     if self.Box.setExpression then
        self.Box:setExpression(form, 1)
     else
         self.Box:setText(form, 1)
     end
  end
end

function Combinatoire:perform()
end

function Combinatoire:enterKey()
    self:perform()
end

function Combinatoire:arrowKey()
   self:enterKey()
end

function Combinatoire:escapeKey()
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


require("ui/math/combinatoire/arrangementarep")
require("ui/math/combinatoire/arrangementsrep")
require("ui/math/combinatoire/combinaisonsarep")
require("ui/math/combinatoire/combinaisonssrep")
require("ui/math/combinatoire/permutationsrep")
require("ui/math/combinatoire/partitionsord")
require("ui/math/combinatoire/partitionsnord")
require("ui/math/combinatoire/permutationarep")
require("ui/math/combinatoire/permutationsrep")
