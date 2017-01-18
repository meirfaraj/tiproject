require("math/math")

Portefeuillef={}


function Portefeuillef.GetVect(self,vect)
    local counti = 1
    local luaVect = {}
    local tiVect = "["
    string.gsub(vect,  "([^,]*),*", function(val) 
      if tiNspire.toNumber(val)~=nil then
        luaVect[counti]=val
        if counti~=1 then
          tiVect=tiVect..","
        end 
        tiVect=tiVect..tostring(val)
        counti=counti+1
      end
      return ""
   end) 
   tiVect=tiVect.."]"
   return luaVect,tiVect,counti-1
end

function Portefeuillef.toRhoIdx(i,j,n)
  local count = n
  local res=j-n
  for a=1,i,1
  do
     count = count-1
     res = res+count
  end 
  return res
end

function Portefeuillef.matriceVarianceCovarianceUsingPondEcartTypeCorrelation(self,X,sigmaVect,rhoVect)
   
   local rhoLuaVect,rhoTiVect,countRho=Portefeuillef.GetVect(self,rhoVect)
   local sigmaLuaVect,sigmaTiVect,countsigma=Portefeuillef.GetVect(self,sigmaVect)
   local XLuaVect,XTiVect,countX=Portefeuillef.GetVect(self,X)
   
   local expected=tiNspire.approx("nPr("..countX..",2)/2")
   if countRho~=tiNspire.toNumber(expected) then
      self:appendToResult("Attention : Il devrait y avoir "..tostring(expected).." correlation != "..tostring(countRho))
   else
      self:appendToResult("number of correlation found "..tostring(countRho).." as expected "..tostring(expected))
   end
   if countsigma~= countX then
      self:appendToResult("Attention : countsigma="..tostring(countsigma).." != countX="..tostring(countX))
   end
   self:appendToResult("\nIl y a "..tostring(countX).." actifs dans le portefeuille\n")
   self:appendMathToResult("X="..tostring(XTiVect))
   self:appendMathToResult(c_sigma.."="..tostring(sigmaTiVect))
   self:appendMathToResult(c_rho.."="..tostring(rhoTiVect))
   
   local  matriceCours="["
   local  matriceIntermediaire="["
   local  matriceResult ="["

   for i=1,countX,1 
   do
      if i~=1 then
         matriceCours=matriceCours..";"
         matriceResult = matriceResult ..";"
         matriceIntermediaire=matriceIntermediaire..";"
      end
      for j=1,countX,1 
      do 
         if j~=1 then
            matriceCours=matriceCours..","
            matriceResult =matriceResult ..","
            matriceIntermediaire =matriceIntermediaire..","
         end
         local calc = ""
         if i==j then
            matriceCours=matriceCours..c_sigma..tostring(i).."^2"
            calc=tostring(sigmaLuaVect[i]).."^2"
         else
            local a,b
            if i<j then
               a=i
               b=j
            else
               b=i
               a=j
            end
            matriceCours=matriceCours..c_rho..tostring(a).."_"..tostring(b).."*"..c_sigma..tostring(i).."*"..c_sigma..tostring(j)
            calc=tostring(rhoLuaVect[Portefeuillef.toRhoIdx(a,b,countX)]).."*"..tostring(sigmaLuaVect[i]).."*"..tostring(sigmaLuaVect[j])
         end
         matriceIntermediaire=matriceIntermediaire..tostring(calc)
         matriceResult =matriceResult ..tostring(tiNspire.execute(tostring(calc)))         
         print("loop : "..tostring(i)..","..tostring(j)) 
      end
   end   
   matriceCours=matriceCours.."]"
   matriceResult =matriceResult .."]"
   matriceIntermediaire =matriceIntermediaire .."]"
   self:appendToResult("\nMatriceCov=")
   self:appendMathToResult(matriceCours)
   self:appendToResult("=")
   self:appendMathToResult(matriceIntermediaire)
   self:appendToResult("=")
   self:appendMathToResult(matriceResult)
   self:appendToResult("=")
   self:appendMathToResult(tiNspire.approx(matriceResult))
   return XTiVect,sigmaTiVect,rhoTiVect,matriceResult
end


