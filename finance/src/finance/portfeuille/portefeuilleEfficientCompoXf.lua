  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
PortefeuilleEfficientXf = Tmv(PORTEFEUILLE_EFFICIENT_ID,PORTEFEUILLE_EFFICIENT_HEADER_ID)
 

function PortefeuilleEfficientXf:widgetsInit()
 self:add(0,"V-1(RM-1rf) : form[1,2;3,4]","V-1(RM-1rf)")
 self:add(1,c_theta ,c_theta)
end

function PortefeuilleEfficientXf:performCalc()
-- rendement portefeuille cible

   local resultatInt =  varValue["V-1(RM-1rf)"]
   local theta =  varValue[c_theta]
   
   if theta ~=nil then
     theta = string.gsub(theta,"[%[%]]*","")
   end
   
   
   if resultatInt ~=nil then
     resultatInt = string.gsub(resultatInt,"[%[%]]*","")
     resultatInt="["..resultatInt.."]"
   end
      
   local count = tiNspire.toNumber(tiNspire.execute("rowDim("..tostring(resultatInt)..")"))
   
   if count==1 then
      -- err between entering , and ; ?
      resultatInt = string.gsub(tostring(resultatInt),",", ";")
      varValue["V-1(RM-1rf)"] = resultatInt
      count = tiNspire.toNumber(tiNspire.execute("rowDim("..tostring(resultatInt)..")"))
   end
   
   Portefeuillef.portefeuilleEff(self)
   if count~=nil and resultatInt~=nil and theta~=nil then      
   
      local calcStr = "(1/"..tostring(theta)..")*"..tostring(resultatInt)
      self:appendMathToResult("X="..tostring(calcStr))
      local res = tiNspire.execute(tostring(calcStr))
      self:appendToResult("\n");
      self:appendMathToResult("="..tostring(res))
      self:appendToResult("\n");
      self:appendMathToResult("="..tostring(tiNspire.approx(tostring(res))))
      self:appendToResult("\n");
      self:appendMathToResult("Xf = 1-1*"..tostring(res))
      local vectUnit = "["
      for i=1,count,1      
      do
        if i~=1 then
          vectUnit =vectUnit .. ","
        end
        vectUnit =vectUnit.."1"
      end
      vectUnit = vectUnit.."]"
      local calcXfStr = "1- "..tostring(vectUnit).." * "..tostring(res)
      self:appendMathToResult("Xf="..tostring(calcXfStr))
      self:appendToResult("\n");
      local resxf = tiNspire.execute(tostring(calcXfStr))
      varValue["Xf"]=resxf
      self:appendMathToResult("="..tostring(resxf))
      self:appendMathToResult("="..tostring(tiNspire.approx(tostring(resxf))))
   end
   self:appendToResult("\n")
end

