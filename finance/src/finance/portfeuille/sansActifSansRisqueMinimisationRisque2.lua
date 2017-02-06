  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
SansActifSansRisqueMinimisationDeRisque2 = Tmv(SANS_ACTIF_SANS_RISQUE_MIN_ID,SANS_ACTIF_SANS_RISQUE_MIN_HEADER_ID)
 

function SansActifSansRisqueMinimisationDeRisque2:widgetsInit()
 self:add(0,"A : form[1,2;3,4]","AMat")
 self:add(0,"Rp* Rendement ","Rp*")
end

function SansActifSansRisqueMinimisationDeRisque2:performCalc()
-- rendement portefeuille cible
   local rp =  varValue["Rp*"]
   local AMat =  varValue["AMat"]
    
   local count = tiNspire.toNumber(tiNspire.execute("colDim("..tostring(AMat)..")-2"))
   if rp~=nil and count~=nil then
      Portefeuillef.constructTMat(rp,count)
   end
   local tMat =  varValue["tMat"]
   if AMat~=nil then  
      self:appendToResult("\n");
      self:appendMathToResult(tostring(AMat)..c_transpose)
      varValue["AMatInv"] =  tiNspire.execute(tostring(AMat).."^(-1)")
      self:appendToResult("=")
      self:appendMathToResult(tostring(varValue["AMatInv"]))
      self:appendToResult("\n=")
      self:appendMathToResult(tostring(tiNspire.approx((tostring(varValue["AMatInv"])))))
   end
   local AMatInv =  varValue["AMatInv"]
   
   if AMatInv ~=nil and tMat ~= nil then
      self:appendToResult("\n");
      self:appendMathToResult("X=A^(-1)*T")
      self:appendToResult("\n=")
      self:appendMathToResult(tostring(AMatInv).."*"..tostring(tMat))
      varValue["XMat"] = tiNspire.execute(tostring(AMatInv).."*"..tostring(tMat))
      self:appendToResult("\n=")
      self:appendMathToResult(tostring(varValue["XMat"]))
      self:appendToResult("\n=")
      self:appendMathToResult(tostring(tiNspire.approx(tostring(varValue["XMat"]))))
   end
   Portefeuillef.coursSansActifSansRisqueMinimisationDeRisque(self)
end

