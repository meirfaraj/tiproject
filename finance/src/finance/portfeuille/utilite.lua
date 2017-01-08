  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")


-- obligation in fine
FonctionUtilite = Tmv(FONCTION_UTILITE_ID,FONCTION_UTILITE_ID_HEADER_ID)
 

function FonctionUtilite:widgetsInit()
 self:add(0,"Richesse init:","W0")
 self:add(0,"Fonction Util U(W):","U(W)")
 self:add(1,"proba gain/perte p1,g1;p2,g2 :","gpv") 
end

function FonctionUtilite:performCalc()
end

