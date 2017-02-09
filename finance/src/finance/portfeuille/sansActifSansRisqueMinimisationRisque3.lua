  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
SansActifSansRisqueMinimisationDeRisque3 = Tmv(SANS_ACTIF_SANS_RISQUE_MIN_ID,SANS_ACTIF_SANS_RISQUE_MIN_HEADER_ID)
 

function SansActifSansRisqueMinimisationDeRisque3:widgetsInit()
 self:add(0,"A-1 : form[1,2;3,4]","AMatInv")
 self:add(0,"Rp* Rendement ","Rp*")
end

function SansActifSansRisqueMinimisationDeRisque3:performCalc()
-- rendement portefeuille cible
   local rp =  varValue["Rp*"]
   local AMatInv =  varValue["AMatInv"]
   
   
   
   if AMatInv ~=nil then
     AMatInv = string.gsub(AMatInv,"[%[%]]*","")
     AMatInv="["..AMatInv.."]"
   end
   
    
    
   local count = tiNspire.toNumber(tiNspire.execute("colDim("..tostring(AMatInv)..")-2"))
   if rp~=nil and count~=nil then
      Portefeuillef.constructTMat(rp,count)
   end
   
   local tMat =  varValue["tMat"]
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

