  
--------------------------------------------------------------------------
--                            Permutation sans repetition                 --
--------------------------------------------------------------------------
require("ui/wscreen")

 
PermutationSansRep = Combinatoire(PERMUTATION_SANS_REP_TITLE_ID,PERMUTATION_SANS_REP_HEADER_ID)



function PermutationSansRep:performnp(n)
    local calculate = "("..tostring(n).."!)"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}\n" 
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    return res
end


function PermutationSansRep:extractTxt()
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="n"
  end
 
  return self.n
end


function  PermutationSansRep:pushed()
    print("Combinatoire:pushed")
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.n= "n"
    self.p=""
    self.widgets  = {}
    
    self:appendWidget(self.enterNLabel, self.enterNLabelX, self.htmp)
    print("appendWidget enterNLabel")
    self:appendWidget(self.enterN, self.enterNX, self.htmp)
    self.enterN.focusDown = 1
    print("appendWidget enterN")
            function self.enterN:enterKey()
                self:perform()
                self.parent:switchFocus(1)
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

 

function PermutationSansRep:perform()
    print("PermutationSansRep:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    self.operation=self:performnp(n)
    self:invalidate()
end
