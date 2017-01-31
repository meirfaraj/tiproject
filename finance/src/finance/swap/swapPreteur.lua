
--------------------------------------------------------------------------
--                            swap                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/swap/func/swap")


-- obligation in fine
SwapPreteur = Tmv(SWAP_PRETEUR_ID,SWAP_PRETEUR_HEADER_ID)
 

function SwapPreteur:widgetsInit()
 self:add(-1,{"%","value"},"%type")
 self:add(0,"dur"..e_acute.."e","d")
 self:add(0,{"ans","mois","jours"},"dType")
 self:add(0,{"coupon semestriel","coupon trimestriel","coupon mensuel","coupon annuel"},"couponFixType")
 self:add(0,"de","k")
 self:add(1,"le (dd/mm/yy)","dateObs")  
 self:add(1,"nominal","nominal") 
 self:add(1,{"Taux r"..e_acute.."visable","Taux variable"},"varType")
 self:add(2,{"coupon semestriel","coupon trimestriel","coupon mensuel","coupon annuel"},"couponVarType")
 self:add(2,"referenc"..e_acute.." jj-mm,...","resetVar")
 
 
end

function SwapPreteur:performCalc()
   local w0 = varValue["W0"]
   local gpv = varValue["gpv"]
   local u = varValue["U(W)"]
   
end

