  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/portfeuille/func/portefeuille")


-- determination composition portefeuille
CompositionPortefeuilleAversionRisque = Tmv(DET_COMPOSITION_PORTEFEUILLE_AR_ID,DET_COMPOSITION_PORTEFEUILLE_AR_HEADER_ID)
 
function CompositionPortefeuilleAversionRisque:widgetsInit()
 self:add(-1,{"%","value"},"%type")
 self:add(0,"R : R1,R2","Rvect")
 self:add(0, c_sigma.." : "..c_sigma.."1,"..c_sigma.."2",c_sigma.."vect")
 self:add(1, c_rho.." : "..c_rho.."12,"..c_rho.."13,"..c_rho.."23",c_rho.."vect") 
 self:add(1,c_theta ,c_theta)
end

function CompositionPortefeuilleAversionRisque:performCalc()
   local Rvect = varValue["Rvect"]
   local sigmavect = varValue[c_sigma.."vect"]
   local rhoVect = varValue[c_rho.."vect"]
   local coefAversionRisque = varValue[c_theta]
   
   if Rvect~=nil and sigmavect~=nil and rhoVect~=nil and coefAversionRisque~=nil  then
      Portefeuillef.compositionPortefeuilleAversionRisque(self,Rvect,sigmavect,rhoVect,coefAversionRisque)
   end
end

