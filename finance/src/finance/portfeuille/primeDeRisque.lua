  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")


-- obligation in fine
PrimeDeRisque = Tmv(PRIME_DE_RISQUE_ID,PRIME_DE_RISQUE_HEADER_ID)
 

function PrimeDeRisque:widgetsInit()
 self:add(-1,{"%","value"},"%type")
 self:add(0,"Richesse init:","W0")
 self:add(0,"Fonction Util U(W):","U(W)")
 self:add(1,"proba gain/perte p1,g1;p2,g2 :","gpv") 
end

function PrimeDeRisque:performCalc()
   local w0 = varValue["W0"]
   local gpv = varValue["gpv"]
   local u = varValue["U(W)"]
   
   if w0~=nil and gpv~=nil and u~=nil then
      FonctionUtilitef.primeDeRisque(self,w0,gpv,u)
   end
end

