  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
SansActifSansRisqueMinimisationDeRisque = Tmv(SANS_ACTIF_SANS_RISQUE_MIN_ID,SANS_ACTIF_SANS_RISQUE_MIN_HEADER_ID)
 

function SansActifSansRisqueMinimisationDeRisque:widgetsInit()
 self:add(0,"R : R1,R2","Rvect")
 self:add(0,"Rp* Rendement ","Rp*")
 self:add(1,"Cov:c11,c12,c13,c22,c23","covVect")
end

function SansActifSansRisqueMinimisationDeRisque:performCalc()
-- cov
   local covVect   =  varValue["covVect"]
-- rendement portefeuille cible
   local rp =  varValue["Rp*"]
-- rendement actifs
   local Rvect =  varValue["Rvect"]
   Portefeuillef.sansActifSansRisqueMinimisationDeRisque(self,covVect,rp,Rvect)
   local AMat =  varValue["AMat"]
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

