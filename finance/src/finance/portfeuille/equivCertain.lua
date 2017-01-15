  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")


-- obligation in fine
EquivCertain = Tmv(EQUIVALENT_CERTAIN_ID,EQUIVALENT_CERTAIN_HEADER_ID)
 

function EquivCertain:widgetsInit()
 self:add(-1,{"%","value"},"%type")
 self:add(0,"Richesse init:","W0")
 self:add(0,"Fonction Util U(W):","U(W)")
 self:add(1,"proba gain/perte p1,g1;p2,g2 :","gpv") 
end

function EquivCertain:performCalc()
   local w0 = varValue["W0"]
   local gpv = varValue["gpv"]
   local u = varValue["U(W)"]
   
   if w0~=nil and gpv~=nil and u~=nil then
      FonctionUtilitef.equivCertain(self,w0,gpv,u)
   end
end

