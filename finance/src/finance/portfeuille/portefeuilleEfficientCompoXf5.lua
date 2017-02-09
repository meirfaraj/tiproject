  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
PortefeuilleEfficientTitreY = Tmv(PORTEFEUILLE_EFFICIENT_ID,PORTEFEUILLE_EFFICIENT_HEADER_ID)
 

function PortefeuilleEfficientTitreY:widgetsInit()
 self:add(0,"RY:" ,"RY")
 self:add(0,"rf:" ,"rf")
 self:add(1,c_sigma.."M:" ,c_sigma.."M")
 self:add(1,"RM:" ,"RM")
 self:add(2,c_sigma.."Y" ,c_sigma.."Y")
end

function PortefeuilleEfficientTitreY:performCalc()
   local ry = varValue["RY"]
   local sigmay = varValue[c_sigma.."Y"]
   local rm = varValue["RM"]
   local rf = varValue["rf"]
   local sigmaM = varValue[c_sigma.."M"]
 
   if sigmaM ~=nil then
     sigmaM = string.gsub(sigmaM,"[%[%]]*","")
   end

   if rm ~=nil then
     rm = string.gsub(rm,"[%[%]]*","")
   end
   
    
   if rf ~=nil then
     rf = string.gsub(rf,"[%[%]]*","")
   end
   

   self:appendMathToResult("Sharpe-Ratio=(RM-rf)/("..c_sigma.."M)=(RY-rf)/("..c_sigma.."Y)")
   self:appendToResult("\n")
   if rm~=nil and rf~=nil then
      local calcStr = "("..tostring(rm).. "-"..tostring(rf).. ")/("..tostring(sigmaM)..")=("..tostring(ry).."-"..tostring(rf)..")/("..c_sigma.."Y)"
      self:appendMathToResult("Sharpe-Ratio="..tostring(calcStr))
      self:appendToResult("\n")
      self:appendMathToResult(tostring(tiNspire.solve(tostring(calcStr),"RY")))
      self:appendToResult("\n")
      self:appendMathToResult(tostring(tiNspire.solve(tostring(calcStr),c_sigma.."Y")))
      self:appendToResult("\n")  
   end
end

