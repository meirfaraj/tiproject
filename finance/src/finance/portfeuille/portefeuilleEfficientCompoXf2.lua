  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
PortefeuilleEfficientXfTheta = Tmv(PORTEFEUILLE_EFFICIENT_ID,PORTEFEUILLE_EFFICIENT_HEADER_ID)
 

function PortefeuilleEfficientXfTheta:widgetsInit()
 self:add(0,"V-1(RM-1rf) : form[1,2;3,4]","V-1(RM-1rf)")
 self:add(1,"Xf=" ,"Xf")
end

function PortefeuilleEfficientXfTheta:performCalc()
-- rendement portefeuille cible

   local resultatInt =  varValue["V-1(RM-1rf)"]
   local Xf =  varValue["Xf"]
   
   local count = tiNspire.toNumber(tiNspire.execute("rowDim("..tostring(resultatInt)..")"))
   
   if count==1 then
      -- err between entering , and ; ?
      resultatInt = string.gsub(tostring(resultatInt),",", ";")
      varValue["V-1(RM-1rf)"] = resultatInt
      count = tiNspire.toNumber(tiNspire.execute("rowDim("..tostring(resultatInt)..")"))
   end
   

   self:appendMathToResult(c_theta.."=((1*V^(-1)(RM-1rf))/(1-Xf))")
   
   if count~=nil and resultatInt~=nil and Xf~=nil then      
      local vectUnit = "["
      for i=1,count,1      
      do
        if i~=1 then
          vectUnit =vectUnit .. ","
        end
        vectUnit =vectUnit.."1"
      end
      vectUnit = vectUnit.."]"
   
      local calcStr = "(("..tostring(vectUnit).."*"..tostring(resultatInt)..")/(1-"..tostring(Xf).."))"
      self:appendMathToResult(c_theta.."X="..tostring(calcStr))
      local res = tiNspire.execute(tostring(calcStr))
      self:appendToResult("\n");
      self:appendMathToResult("="..tostring(res))
      self:appendToResult("\n");
      self:appendMathToResult("="..tostring(tiNspire.approx(tostring(res))))
      self:appendToResult("\n");
      varValue[c_theta]=res
   end
   self:appendToResult("\n")
end

