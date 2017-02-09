  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
PortefeuilleEfficientActifX = Tmv(PORTEFEUILLE_EFFICIENT_ID,PORTEFEUILLE_EFFICIENT_HEADER_ID)
 

function PortefeuilleEfficientActifX:widgetsInit()
 self:add(0,"RX:" ,"RX")
 self:add(0,c_sigma.."X:" ,c_sigma.."X")
 self:add(1,"RM:" ,"RM")
 self:add(1,"rf:" ,"rf")
 self:add(2,c_sigma.."M:" ,c_sigma.."M")
 self:add(2,c_beta.."X",c_beta.."X")
end

function PortefeuilleEfficientActifX:performCalc()
   local rx = varValue["RX"]
   local volX = varValue[c_sigma.."X"]
   local rm = varValue["RM"]
   local rf = varValue["rf"]


   self:appendMathToResult(c_beta.."X=(Rx-rf)/(RM-rf)")
   self:appendToResult("\n")
   if rx~=nil and volX~=nil and rm~=nil and rf~=nil then
      local calcStr = "("..tostring(rx).."-"..tostring(rf)..")/("..tostring(rm).."-"..tostring(rf)..")"
      self:appendMathToResult(c_beta.."X="..tostring(calcStr))
      varValue[c_beta.."X"] = tiNspire.execute(tostring(calcStr))
      self:appendToResult("\n")
      self:appendMathToResult("="..tostring(varValue[c_beta.."X"]))
      self:appendMathToResult("="..tostring(tiNspire.approx(tostring(varValue[c_beta.."X"]))))
   end

   local betaX = varValue[c_beta.."X"]
   local sigmaM = varValue[c_sigma.."M"]

   if betaX~=nil and sigmaM~=nil then
      self:appendToResult("\nRisque systematique:\n")
      self:appendMathToResult("="..c_beta.."X^2*"..c_sigma.."M^2")
      local calcStr = "("..tostring(betaX)..")^2*("..tostring(sigmaM)..")^2"
      self:appendMathToResult("="..tostring(calcStr))
      self:appendToResult("\n")
      local res = tiNspire.execute(tostring(calcStr))
      self:appendMathToResult("="..tostring(res))
      self:appendMathToResult("="..tostring(tiNspire.approx(tostring(res))))
      self:appendToResult("\nRisque specifique:\n")
      self:appendMathToResult("="..c_sigma.."X^2-risqSyst")
      if volX~=nil then
         calcStr =  "("..tostring(volX)..")^2-"..tostring(res)
         self:appendMathToResult("="..tostring(calcStr))
         local res2 = tiNspire.execute(tostring(calcStr))
         self:appendMathToResult("="..tostring(res2))
         self:appendMathToResult("="..tostring(tiNspire.approx(tostring(res2))))
      end
   end
end

