  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
MatriceFunctionDutilite = Tmv(MATRICE_VAR_COVAR_ID,MATRICE_VAR_COVAR_HEADER_ID)
 

function MatriceFunctionDutilite:widgetsInit()
 self:add(-1,{"%","value"},"%type") 
 self:add(0,"Pond.actifs X: x1,x2","X")
 self:add(0,c_sigma.." : "..c_sigma.."1,"..c_sigma.."2",c_sigma.."vect")
 self:add(1,"correlation "..c_rho.." : "..c_rho.."12,"..c_rho.."13,"..c_rho.."23",c_rho.."vect") 
end

function MatriceFunctionDutilite:performCalc()
-- ponderation
   local X =  varValue["X"]
-- ecart type
   local sigmaVect =  varValue[c_sigma.."vect"]
-- correlation
   local rhoVect   =  varValue[c_rho.."vect"]
   
   local XTiVect,sigmaTiVect,rhoTiVect,matriceResult
   XTiVect,sigmaTiVect,rhoTiVect,matriceResult=Portefeuillef.MatriceFunctionDutilite(self,X,sigmaVect,rhoVect)
   varValue["matriceVarCovar"] = matriceResult
   self:appendToResult("\nRisque specific/systemique=")
   self:appendMathToResult( tostring(XTiVect).."*"..matriceResult.."*".. tostring(XTiVect)..c_transpose)
   self:appendToResult("=")
   self:appendMathToResult( tostring(tiNspire.execute(tostring(XTiVect).."*"..matriceResult)).."*".. tostring(XTiVect)..c_transpose)
   self:appendToResult("=")
   self:appendMathToResult( tostring(tiNspire.approx(tostring(XTiVect).."*"..matriceResult)).."*".. tostring(XTiVect)..c_transpose)
   self:appendToResult("=")
   self:appendMathToResult( tostring(tiNspire.execute(tostring(XTiVect).."*"..matriceResult.."*".. tostring(XTiVect)..c_transpose)))
   self:appendToResult("=")
   self:appendMathToResult( tostring(tiNspire.approx(tostring(XTiVect).."*"..matriceResult.."*".. tostring(XTiVect)..c_transpose)))
end

