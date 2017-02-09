  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
PortefeuilleEfficientBeta = Tmv(PORTEFEUILLE_EFFICIENT_ID,PORTEFEUILLE_EFFICIENT_HEADER_ID)
 

function PortefeuilleEfficientBeta:widgetsInit()
 self:add(0,"RM:" ,"RM")
 self:add(0,c_beta..":" ,c_beta)
 self:add(1,c_theta ,c_theta)
 self:add(1,"rf:" ,"rf")
end

function PortefeuilleEfficientBeta:performCalc()
   local beta = varValue[c_beta]

   if beta~=nil then 
      self:appendToResult(c_beta.."=XM="..tostring(beta).."\n");
      self:appendToResult("comme "..tostring(beta).." investi dans le portefeuille marche\n");
      local calcStr = "1-"..tostring(beta)
      self:appendMathToResult("Xf=1-XM="..tostring(calcStr))
      varValue["XM"] = beta
      varValue["Xf"] = tiNspire.execute(tostring(calcStr))
      self:appendMathToResult("="..tostring(varValue["Xf"]))
      self:appendMathToResult("="..tostring(tiNspire.approx(tostring(varValue["Xf"]))))
      self:appendToResult("\ncar "..c_beta.."p="..sum_sym.."(Xi*"..c_beta.."i,i,1,n)=XM*"..c_beta.."M+Xf*"..c_beta.."f avec "..c_beta.."f=0\n");
   end


   local theta =  varValue[c_theta]
   local rm =  varValue["RM"]
   local xm =  varValue["XM"]
   local rf =  varValue["rf"]
   
   
   if theta ~=nil then
      theta = string.gsub(theta,"[%[%]]*","")
   end
   
   
   
   --variance du portefeuille du marche
   if theta~=nil and rm~=nil and xm~=nil then
     self:appendToResult("\nVar du ptf de marche:\n")
     self:appendMathToResult("XM=(RM-rf)/("..c_theta.."*"..c_sigma.."M^2)")
     self:appendToResult("\ndonc:\n")
     self:appendMathToResult(c_sigma.."M^2=(RM-rf)/("..c_theta.."*XM)")
     local calcStr = "("..tostring(rm).."-"..tostring(rf)..")/("..tostring(theta).."*"..tostring(xm)..")"
     self:appendToResult("\n")
     self:appendMathToResult("="..tostring(calcStr))
     varValue["varM"]=tiNspire.execute(tostring(calcStr))
     self:appendMathToResult("="..tostring(varValue["varM"]))
     self:appendMathToResult("="..tostring(tiNspire.approx(tostring(varValue["varM"]))))
     self:appendToResult("\n")
     varValue[c_sigma.."M"]=tiNspire.execute(sqrt_sym.."("..tostring(calcStr)..")")
     self:appendMathToResult(c_sigma.."M="..tostring(varValue[c_sigma.."M"]))
     self:appendMathToResult("="..tostring(tiNspire.approx(tostring(varValue[c_sigma.."M"]))))
   end
   self:appendToResult("\nFUtil\n")
   Portefeuillef.portefeuilleEff(self)
   self:appendToResult("\n")
end

