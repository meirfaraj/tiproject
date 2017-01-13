require("math/math")

FonctionUtilitef={}

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
        return ""
      end
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

function FonctionUtilitef.fonctionUtilite(self,u,w0)
  self:appendMathToResult("U(W)="..tostring(u))
  local firstDeriv,err,firstDerivStr = tiNspire.deriv(u,"W")
  local firstDerivValue = tiNspire.deriv(u,"W",1,w0)
  self:appendMathToResult("U'(W)="..firstDerivStr.."="..firstDeriv.."="..tostring(firstDerivValue).."="..tostring(tiNspire.approx(firstDerivValue)))
  local secDeriv,err,secDerivStr = tiNspire.deriv(u,"W",2)
  local secDerivValue = tiNspire.deriv(u,"W",2,w0)
  self:appendToResult("\nU\"(W)=")
  self:appendMathToResult(tostring(secDerivStr).."="..secDeriv.."="..tostring(secDerivValue).."="..tostring(tiNspire.approx(secDerivValue)))
  
  firstDerivValue = tiNspire.approx(firstDerivValue)
  secDerivValue = tiNspire.approx(secDerivValue)
  
  
  if tonumber(firstDerivValue)~=nil then 
    if tonumber(firstDerivValue)>=0 then
      self:appendToResult("U'(W)>0\n")
      local secVal = tiNspire.toNumber(secDerivValue)
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
    
end