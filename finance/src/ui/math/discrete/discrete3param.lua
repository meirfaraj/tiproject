 
--------------------------------------------------------------------------
--                            Discrete3Params                              --
--------------------------------------------------------------------------
require("std/utils")
require("ui/widgets/widgets")
require("ui/widgets/sinputwidget")
require("ui/widgets/sMathInput")
require("ui/widgets/slabelwidget")

Discrete3Params = addExtension(Screen,WidgetManager)
 

function Discrete3Params:init(titleId,headerId)
  print("init Discrete3Params")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 10}
  self.operation = ""
  self.bn= "BN"
  self.sn= "n"
  self.p="p"
  self.r=0
  self.widgets  = {}
  self.lastInput=""
  self.enterBN = sInput()
  self.enterBN:setWidth(50)
  self.enterBNLabel = sLabel(ASTxt(ENTER_BN_ID),self.enterBN)

  self.enterSN = sInput()
  self.enterSN:setWidth(50)
  self.enterSNLabel = sLabel(ASTxt(ENTER_SN_ID),self.enterSN)

  
  self.enterP = sInput()
  self.enterP:setWidth(50)
  self.enterPLabel = sLabel(ASTxt(ENTER_P_ID),self.enterP)

  
  self.pstartLabel = sLabel("P(")
  self.enterk1 = sInput()
  self.enterk1:setWidth(25)
  self.equalities0={"none","<=","<"} 
  self.equalityType0 = sDropdown(self.equalities0)
  self.XLabel = sLabel("X",self.enterP)
  self.equalities={"=","<","<=",">=",">","All"} 
  self.equalityType = sDropdown(self.equalities)
  self.enterk2 = sInput()
  self.enterk2:setWidth(25)
  self.pendLabel = sLabel(")")
  self.enterBN.value = self.bn
  self.enterSN.value = self.sn
  self.enterP.value = self.p
  self.Box = sMathInput(0,0)
  self.htitle=20    
  self.focus  = 0
  self:size()
  print("end Discrete3Params num of widget="..tostring(table.getn(self.widgets)))
end
 
function Discrete3Params:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h))
      self.lasth=self.h
      self.lastw=self.w
      
      self.htmp =self.htitle+5
      self.enterBNLabelX=0
      --print("self.enterBNLabelX="..tostring(self.enterBNLabelX))
      self.enterBNLabel:setPos(self.enterBNLabelX, self.htmp)
      self.enterBNX=self.enterBNLabelX+52
      --print("self.enterBNX="..tostring(self.enterBNX))
      self.enterBN:setPos(self.enterBNX, self.htmp)
      self.enterBN.number=false
      self.enterBN:enable()
      
      self.enterSNLabelX=self.enterBNX+52
      self.enterSNLabel:setPos(self.enterSNLabelX, self.htmp)
      self.enterSNX=self.enterSNLabelX+52
      --print("self.enterSNX="..tostring(self.enterSNX))
      self.enterSN:setPos(self.enterSNX, self.htmp)
      self.enterSN.number=false
      self.enterSN:enable()

      self.enterPLabelX=self.enterSNX+52      
      --print("self.enterPLabelX="..tostring(self.enterPLabelX))
      self.enterPLabel:setPos(self.enterPLabelX,self.htmp)
      self.enterPX=self.enterPLabelX+52
      --print("self.enterPX="..tostring(self.enterPX))
      self.enterP:setPos(self.enterPX, self.htmp)
      self.enterP.number=false
      self.enterP:enable()
      self.htmp2=self.htmp+22
      self.enterk1Y=self.htmp2+2
      self.enterk2Y=self.htmp2+2
      
      
      self.pstartLabelY=self.htmp2
      self.pstartLabelX=10
      self.enterk1X=self.pstartLabelX+22
      self.equalityTypeY=self.htmp2
      self.equalityType0Y=self.htmp2
      self.equalityType0X=self.enterk1X+30
      self.XLabelX=self.equalityType0X+80
      self.XLabelY=self.htmp2
      self.equalityTypeX=self.XLabelX+15
      self.enterk2X=self.equalityTypeX+80
      self.pendLabelY=self.htmp2
      self.pendLabelX=self.enterk2X+30
      self.pstartLabel:setPos(self.pstartLabelX, self.pstartLabelY)
      self.XLabel:setPos(self.XLabelX, self.XLabelY)
      self.equalityType0:setPos(self.equalityType0X, self.equalityType0Y)
      self.equalityType:setPos(self.equalityTypeX, self.equalityTypeY)
      self.pendLabel:setPos(self.pendLabelX, self.pendLabelY)
      
      self.boxX=4
      self.boxY=30+self.htmp2 
      self.boxW= self.w-(2*self.boxX)
      self.boxH=self.h-self.boxY-2
      self:invalidate()
      print("return true")
      return true
   end
   return false
end

function Discrete3Params:refreshBox()
  self.x=0
  self.y=0
  self.ww = pww()
  self.hh = pwh()
  self:calculateSize()
end
   

function Discrete3Params:postPaint(gc)
    --print("Discrete2Params:postPaint")
    self:refreshBox()
end
 


function Discrete3Params:extractTxt()

  if(self.enterBN) then
     self.bn=self.enterBN.value
  else
     print("Warning : enterbn is null")
     self.bn="BN"
  end
  if(self.enterSN) then
     self.sn=self.enterSN.value
  else
     print("Warning : entersn is null")
     self.sn="n"
  end
  if(self.enterP) then
     self.p=self.enterP.value
  else
     print("Warning : enterp is null")
     self.p="p"
  end
  
  if(self.enterk1) then
     self.k1=self.enterk1.value
  else
     print("Warning : enterk1 is null")
     self.k1=""
  end

  if(self.enterk2) then
     self.k2=self.enterk2.value
  else
     print("Warning : enterk2 is null")
     self.k2=""
  end
  
  if(self.equalityType0) then
     self.compare1 = self.equalityType0.value
  else
     print("Warning : equalityType0 is null")
     self.compare1="none"
  end
    
  if(self.equalityType) then
     self.compare2 = self.equalityType.value
  else
     print("Warning : equalityType is null")
     self.compare2="none"
  end
  
  return self.bn,self.sn,self.p,self.k1,self.compare1,self.compare2,self.k2
end

function Discrete3Params:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function  Discrete3Params:pushed()
    print("Discrete3Params:pushed")
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.bn= "BN"
    self.sn= "n"
    self.p="p"
    self.widgets  = {}
    
    self:appendWidget(self.enterBNLabel, self.enterBNLabelX, self.htmp)
    self:appendWidget(self.enterBN, self.enterBNX, self.htmp)
    self.enterBN.focusDown = 1
    self:appendWidget(self.enterSNLabel, self.enterSNLabelX, self.htmp)
    self:appendWidget(self.enterSN, self.enterSNX, self.htmp)
    self:appendWidget(self.enterPLabel, self.enterPLabelX, self.htmp)
    self:appendWidget(self.enterP, self.enterPX, self.htmp)
    
    self:appendWidget(self.pstartLabel,self.pstartLabelX, self.pstartLabelY)
    self:appendWidget(self.enterk1, self.enterk1X, self.enterk1Y)
    self:appendWidget(self.equalityType0, self.equalityType0X, self.equalityType0Y)
    self:appendWidget(self.XLabel, self.XLabelX, self.XLabelY)
    self:appendWidget(self.equalityType, self.equalityTypeX, self.equalityTypeY)
    self:appendWidget(self.enterk2, self.enterk2X, self.enterk2Y)
    self:appendWidget(self.pendLabel,self.pendLabelX, self.pendLabelY)
            function self.equalityType:change()
                self.parent:firePerform()
            end
            function self.enterBN:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterSN:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterP:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterk2:enterKey()
                self.parent.Box:setFocus(true)
                self.parent:firePerform()
            end
            function self.enterk2:onChange()
                self.parent:firePerform()
            end
            function self.equalityType:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType:onClose()
                self.parent.Box:setVisible(true)
                if (self.value=="<=" or self.value=="<") then
                   self.parent.equalityType0.sList.sel=self.value
                   self.parent.equalityType0.value=self.value
                else
                   self.parent.equalityType0.value="none"
                end
            end
            function self.equalityType0:change()
                self.parent:firePerform()
            end
            function self.equalityType0:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType0:onClose()
                if (self.value=="<=" or self.value=="<") and (self.parent.equalityType.value~="<=" and self.value~="<") then
                   self.parent.equalityType.sList.sel=self.value
                   self.parent.equalityType.value=self.value
                end
                self.parent.Box:setVisible(true)
            end
    
    
    self.Box:setSize(self.boxW,self.boxH)
    self:appendWidget(self.Box,self.boxX,self.boxY)
    self.enterBN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    self.Box:setColorable(true)
    self.Box:setTextColor(0x215c98)
    self.Box:setExpression(form)
    self.Box:setFocus(false)
    --self.Box:setVisible(true)
    self:invalidate()
end


function Discrete3Params:screenGetFocus()
    self:pushed()
end

function Discrete3Params:screenLoseFocus()
end


function Discrete3Params:removed()
    self.Box:setVisible(false)
    self.Box:setExpression("")
    self.Box:setFocus(false)
    doNotDisplayIcon = false
end
 
 
function Discrete3Params:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,Discrete3Params.font)
  local n,p=self:extractTxt()
  if (self.lastInput~=tostring(n)..","..tostring(p)) then
     self:firePerform()
     self.lastInput=tostring(n)..","..tostring(p)
     local form =tostring(self.header)..tostring(self.operation)
     self.Box:setExpression(form);
  end
end

function Discrete3Params:firePerform()
    self.Box:setVisible(true)
    self:perform()
end


function Discrete3Params:perform()
end

function Discrete3Params:escapeKey()
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


require("ui/math/discrete/hypergeometric/hypergeometricsplcalc")
