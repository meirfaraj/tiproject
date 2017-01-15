require("math/math")

FonctionUtilitef={}

function FonctionUtilitef.equivCertain(self,w0,gp,u)
   local count=1
   local calcd1=""  
   local calc2=""  
   local calc3=""  
   self:appendToResult("\ncalculons E(U(W0+L)) : \n")

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
   res=tiNspire.approx(res)
   self:appendMathToResult(tostring(res))
   res=string.gsub(tostring(res),"w=","")
   return res
end

function FonctionUtilitef.checkAversionFromARA(self,ara)
   if ara~=nil then
      local nara = tiNspire.toNumber(tiNspire.sign(ara))
      if nara>0 then
         self:appendToResult("\naversion absolue au risque (ARA)>0 => averse vis a vis du risque\n")
      elseif nara<0 then
         self:appendToResult("\naversion absolue au risque (ARA)<0 => risquophile\n")
      elseif  nara==0 then
         self:appendToResult("\naversion absolue au risque (ARA)=0 => neutre au risque\n")
      end
   end
end

function FonctionUtilitef.approxArrowPratt(self,w0,gp,u)
   self:appendToResult("\n l'approximation d'Arrow-Pratt :")
   self:appendMathToResult(c_pi.."=(1/2)*"..c_sigma.."L^2*(-(U''(W0)/U'(W0)))")
   self:appendToResult("\n")
   self:appendToResult("1 calculons "..c_sigma.."L^2 qui caracterise l'intensit"..e_acute.." du risque L :\n")
   local sigma=FonctionUtilitef.variance(self,w0,gp)
   self:appendMathToResult(c_sigma.."L^2="..tostring(sigma))
   self:appendToResult("\n")
   self:appendToResult("calculons le coefficient d'aversion absolue : A(W0)=")
   self:appendMathToResult("-(U''(W0)/U'(W0))")
   self:appendToResult("\n")
   
   local firstDeriv,firstDerivStr,firstDerivValue,secDeriv,secDerivStr,secDerivValue = FonctionUtilitef.derivFonctionUtilite(self,u,w0)
   local aVal ="-(("..tostring(secDerivValue)..")/("..tostring(firstDerivValue).."))"
   self:appendMathToResult("A(W0)="..tostring(aVal))   
   aVal=tiNspire.approx(aVal)
   self:appendMathToResult("="..tostring(aVal))
   FonctionUtilitef.checkAversionFromARA(self,aVal)
      
   self:appendToResult("\n")
   self:appendToResult("Note le coefficient d'aversion relatif : R(W0)=W0*A(W0)=")
   local rval=tostring(w0).."*("..tostring(aVal)..")"
   self:appendMathToResult("="..tostring(rval))
   rval=tiNspire.approx(tostring(rVal))
   self:appendMathToResult("="..tostring(rVal))
   self:appendToResult("\n")
   
   local piRes = "(1/2)*("..tostring(sigma)..")*("..tostring(aVal)..")"
   self:appendMathToResult(c_pi.."="..tostring(piRes))
   piRes =tiNspire.approx(tostring(piRes))
   self:appendMathToResult("="..tostring(piRes)) 
   return piRes
end

function FonctionUtilitef.primeDeRisque(self,w0,gp,u)
   local G=FonctionUtilitef.gainAttendu(self,w0,gp)
   local equivalentCertain=FonctionUtilitef.equivCertain(self,w0,gp,u)
   self:appendToResult("\nLa prime de risque s'eleve donc "..a_acute..":")
   local primeExact = tostring(w0).."-"..tostring(equivalentCertain)    
   self:appendMathToResult("W0-EquivCertain="..tostring(primeExact))
   self:appendMathToResult("="..tostring(tiNspire.execute(tostring(primeExact))))
   self:appendToResult("\nprime("..c_pi..")=")
   local res=tiNspire.approx(tostring(primeExact))
   self:appendMathToResult(tostring(res))
   self:appendToResult("\n")
   FonctionUtilitef.approxArrowPratt(self,w0,gp,u)
   return res
end

function FonctionUtilitef.variance(self,w0,gp)
   local esp=FonctionUtilitef.gainAttendu(self,w0,gp)
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
        if count~=1 then
           calc=calc.."+"
        end
        calc=calc..tostring(p).."*("..tostring(v).."-"..tostring(esp)..")^2"
        count=count+1
      end
      return ""
   end)
   
   self:appendMathToResult(calc)
   self:appendToResult("=")
   local res=tiNspire.execute(calc)
   self:appendMathToResult(tostring(res))
   self:appendToResult("=")
   self:appendMathToResult(tostring(tiNspire.approx(calc)))
   return res
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
           self:appendMathToResult(tostring(p).."%="..tostring(pc))
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
   
   self:appendToResult("(Esperance)gain attendu=")
   self:appendMathToResult(calc)
   self:appendToResult("=")
   local res=tiNspire.execute(calc)
   self:appendMathToResult(tostring(res))
   self:appendToResult("=")
   self:appendMathToResult(tostring(tiNspire.approx(calc)))
   return res
end


function FonctionUtilitef.derivFonctionUtilite(self,u,w0)
  self:appendMathToResult("U(W)="..tostring(u))
  local firstDeriv,err,firstDerivStr = tiNspire.deriv(u,"W")
  local firstDerivValue = tiNspire.deriv(u,"W",1,w0)
  self:appendMathToResult("U'(W)="..tostring(firstDerivStr).."="..tostring(firstDeriv).."="..tostring(firstDerivValue).."="..tostring(tiNspire.approx(firstDerivValue)))
  local secDeriv,err,secDerivStr = tiNspire.deriv(u,"W",2)
  local secDerivValue = tiNspire.deriv(u,"W",2,w0)
  self:appendToResult("\nU\"(W)=")
  self:appendMathToResult(tostring(secDerivStr).."="..tostring(secDeriv).."="..tostring(secDerivValue).."="..tostring(tiNspire.approx(secDerivValue)))
  return firstDeriv,firstDerivStr,firstDerivValue,secDeriv,secDerivStr,secDerivValue
end

function FonctionUtilitef.fonctionUtilite(self,u,w0,gp)
  local firstDeriv,firstDerivStr,firstDerivValue,secDeriv,secDerivStr,secDerivValue = FonctionUtilitef.derivFonctionUtilite(self,u,w0)
    
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
        local wvalRes=tostring(tiNspire.execute(wval))
        self:appendMathToResult("W="..tostring(wval).."="..tostring(wvalRes))
        self:appendToResult("utilit"..e_acute.."=")
        local tocalc=tostring(u).." | W ="..tostring(wvalRes)
        self:appendMathToResult(tostring(tocalc))
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
