require("math/math")

Portefeuillef={}


function Portefeuillef.GetRho(self,rhoVect,n)
    local counti = 1
    
    string.gsub(rhoVect,  "([^,]*),*", function(rho) 
      
      if rho~=nil then
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
end

function Portefeuillef.matriceVarianceCovarianceUsingPondEcartTypeCorrelation(self,X,sigmaVect,rhoVect)
   local n = 0
   string.gsub(rhoVect,  "([^,]*),*", function(x) 
      if tonumber(x)~=nil then
        n=n+1
      end
   end)
   self:appendToResult("Il y a "..tostring(n).." actifs dans le portefeuille\n")
   Portefeuillef.GetRho(self,rhoVect,n)
   
end