  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")


-- obligation in fine
FonctionUtilite = Tmv(FONCTION_UTILITE_ID,FONCTION_UTILITE_ID_HEADER_ID)
 

function FonctionUtilite:widgetsInit()
 self:add(-1,{"%","value"},"%type")
 self:add(0,"Richesse init:","W0")
 self:add(0,"Fonction Util U(W):","U(W)")
 self:add(1,"proba gain/perte p1,g1;p2,g2 :","gpv") 
end

function FonctionUtilite:performCalc()
   local w0 = varValue["W0"]
   local gpv = varValue["gpv"]
   local u = varValue["U(W)"]
   
   if w0~=nil and gpv~=nil then
      FonctionUtilitef.gainAttendu(self,w0,gpv)
   end
   self:appendToResult("\n")
   if u~=nil and w0~=nil then
      FonctionUtilitef.fonctionUtilite(self,u,w0)
   end
end

