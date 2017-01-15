require("math/math")

FonctionUtilitef={}

function FonctionUtilitef.equivCertain(self,w0,gp,u)
   local count=1
   local calcd1=""  
   local calc2=""  
   local calc3=""  
   self:appendToResult("calculons E(U(W0+L)) : \n")

   string.gsub(gp,  "([^,]*),([^;]*);*", function(p,v) 
      if p~=nil and v~=nil then
        if varValue["%type"] == "%" then
           local pc = tostring(p).."/100"
           self:appendMathToResult(tostring(p).."%="..pc)
           p=tostring(tiNspire.approx(pc))
           self:appendMathToResult("="..tostring(p))
           self:appendToResult("\n")
        end   
        local W=tostring(w0).."+"..tostring(v)
        self:appendMathToResult("L="..tostring(v).." W0+L="..W)
        W=tiNspire.execute(W)
        self:appendMathToResult("="..tostring(W))
        self:appendToResult("\n")
        if count~=1 then
           calcd1=calcd1.."+"
           calc2=calc2.."+"
           calc3=calc3.."+"
        end
        
        calcd1=calcd1..tostring(p).."*U("..tostring(W)..")"
        calc2=calc2..tostring(p).."*("..string.gsub(u,"W",tostring(W))..")"
        calc3=calc3..tostring(p).."*("..tostring(tiNspire.execute(tostring(u).."|W="..tostring(W)))..")"
        count=count+1
      end
      return ""
   end)   
   self:appendToResult("\n")
   self:appendMathToResult("E(U(W0+L))="..tostring(calcd1))
   self:appendToResult("=")
   self:appendMathToResult(tostring(calc2))
   self:appendMathToResult(tostring(calc3))
   local res=tiNspire.execute(tostring(calc3))
   self:appendMathToResult(tostring(res))
   self:appendToResult("=")
   self:appendMathToResult(tostring(tiNspire.approx(calc3)))
   self:appendToResult("\ndonc l'equivalent certain est :")
   res=tiNspire.solve(tostring(u).."="..tostring(res),"W")
   self:appendMathToResult(tostring(res))
   self:appendToResult("=")
   self:appendMathToResult(tiNspire.approx(res))
   return res
end

function FonctionUtilitef.approxArrowPratt(self,w0,gp,u)
    
end

function FonctionUtilitef.primeDeRisque(self,w0,gp,u)
    local G=FonctionUtilitef.gainAttendu(self,w0,gp)
       
end

function FonctionUtilitef.gainAttendu(self,w0,gp)
   local gpv={}
   local count=1
   local calc=""  
   string.gsub(gp,  "([^,]*),([^;]*);*", function(p,v) 
      if p~=nil and v~=nil then
        print("p="..tostring(p).." v="..tostring(v))
        if varValue["%type"] == "%" then
           local pc = tostring(p).."/100"
           self:appendMathToResult(tostring(p).."%="..pc)
           p=tostring(tiNspire.approx(pc))
           self:appendMathToResult("="..tostring(p))
           self:appendToResult("\n")
        end   
        gpv[count]={p,v}
        if count~=1 then
           calc=calc.."+"
        end
        calc=calc..tostring(p).."*"..tostring(v)
        count=count+1
      end
      return ""
   end)
   
   self:appendToResult("gain attendu=")
   self:appendMathToResult(calc)
   self:appendToResult("=")
   local res=tiNspire.execute(calc)
   self:appendMathToResult(tostring(res))
   self:appendToResult("=")
   self:appendMathToResult(tostring(tiNspire.approx(calc)))
   return res
end

function FonctionUtilitef.fonctionUtilite(self,u,w0,gp)
  self:appendMathToResult("U(W)="..tostring(u))
  local firstDeriv,err,firstDerivStr = tiNspire.deriv(u,"W")
  local firstDerivValue = tiNspire.deriv(u,"W",1,w0)
  self:appendMathToResult("U'(W)="..tostring(firstDerivStr).."="..tostring(firstDeriv).."="..tostring(firstDerivValue).."="..tostring(tiNspire.approx(firstDerivValue)))
  local secDeriv,err,secDerivStr = tiNspire.deriv(u,"W",2)
  local secDerivValue = tiNspire.deriv(u,"W",2,w0)
  self:appendToResult("\nU\"(W)=")
  self:appendMathToResult(tostring(secDerivStr).."="..tostring(secDeriv).."="..tostring(secDerivValue).."="..tostring(tiNspire.approx(secDerivValue)))
  
  firstDerivValue = tiNspire.approx(firstDerivValue)
  secDerivValue = tiNspire.approx(secDerivValue)
  
  
  if tonumber(firstDerivValue)~=nil then 
    if tiNspire.toNumber(tiNspire.sign(firstDerivValue))>=0 then
      self:appendToResult("U'(W)>0\n")
      local secVal = tiNspire.toNumber(tiNspire.sign(secDerivValue))
      if secVal~=nil then 
        if secVal==0 then
           self:appendToResult("U\"(W)=0 neutre au risque\n")
        elseif secVal>0 then
           self:appendToResult("U\"(W)>0 risquophil\n")
        else -- <
           self:appendToResult("U\"(W)<0 averse au risque\n")        
        end
      end 
    else 
       self:appendToResult("la premiere derive doit etre positive\n")
    end
  end
-- Fonction d'utilite applique au differents cas :
  self:appendToResult("\n utilite dans chaque cas : dans le cas d'un refus : ")
  self:appendMathToResult(tostring(u).." | W = "..tostring(w0))
  self:appendToResult("=")
  self:appendMathToResult(tostring(tiNspire.execute(tostring(u).." | W = "..tostring(w0))))
  self:appendToResult("=")
  self:appendMathToResult(tostring(tiNspire.approx(tostring(u).." | W = "..tostring(w0))))
  if gp~=nil then
   local count=1
   string.gsub(gp,  "([^,]*),([^;]*);*", function(p,v) 
      if v~=nil then
        self:appendToResult("\n utilite dans cas "..tostring(count).." ou v="..tostring(v).." :")
        local wval=tostring(w0).."+("..tostring(v)..")"
        local wvalRes=tiNspire.execute(wval)
        self:appendMathToResult("W="..wval.."="..tostring(wvalRes))
        self:appendToResult("utilit"..e_acute.."=")
        local tocalc=tostring(u).." | W ="..wvalRes
        self:appendMathToResult(tocalc)
        self:appendToResult("=")
        self:appendMathToResult(tostring(tiNspire.execute(tocalc)))
        self:appendToResult("=")
        self:appendMathToResult(tostring(tiNspire.approx(tocalc)))
        self:appendToResult("\n")
        count=count+1  
      end
      return ""
   end)
  end
end
