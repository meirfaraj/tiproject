  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/utilite")
require("finance/portfeuille/func/portefeuille")


-- obligation in fine
MatriceVarianceCovariance = Tmv(MATRICE_VAR_COVAR_ID,MATRICE_VAR_COVAR_HEADER_ID)
 

function MatriceVarianceCovariance:widgetsInit()
 self:add(-1,{"%","value"},"%type")
 self:add(-1,{"ponder+rend+ecart+corel","from data","from scratch"},"defMatriceKind")
 
 self:add(0,"Ponderation des actifs X: x1,x2","X")
 self:add(1,"ecart type "..c_sigma.." : "..c_sigma.."1,"..c_sigma.."2",c_sigma.."vect")
 self:add(2,"correlation "..c_rho.." : "..c_rho.."12,"..c_rho.."13,"..c_rho.."23",c_rho.."vect") 
end

function MatriceVarianceCovariance:performCalc()
   local defMatriceKind =  varValue["defMatriceKind"]
-- ponderation
   local X =  varValue["X"]
-- ecart type
   local sigmaVect =  varValue[c_sigma.."vect"]
-- correlation
   local rhoVect   =  varValue[c_rho.."vect"]
   
   local XTiVect,sigmaTiVect,rhoTiVect,matriceResult
   if defMatriceKind == "ponder+rend+ecart+corel" then
      XTiVect,sigmaTiVect,rhoTiVect,matriceResult=Portefeuillef.matriceVarianceCovarianceUsingPondEcartTypeCorrelation(self,X,sigmaVect,rhoVect)
      varValue["matriceVarCovar"] = matriceResult
   end
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

