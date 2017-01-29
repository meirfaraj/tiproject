-- Portefeuille 

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

  local expected=tiNspire.approx("nPr("..tostring(countX)..",2)/2")
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


function Portefeuillef.toVectLet(count)
  local res=""
  if tonumber(count) ~= nil then
    for i=1,count,1 
    do
      if i>1 then 
        res=res..","
      end
      res=res..string.char(65+i-1)
    end
  end
  return res 
end


function Portefeuillef.compositionPortefeuille(self,Rvect,sigmaVect,rhoVect,rf)
  local rhoLuaVect,rhoTiVect,countRho=Portefeuillef.GetVect(self,rhoVect)
  local sigmaLuaVect,sigmaTiVect,countsigma=Portefeuillef.GetVect(self,sigmaVect)
  local RLuaVect,RTiVect,countR=Portefeuillef.GetVect(self,Rvect)
  local expected=tiNspire.approx("nPr("..tostring(countX)..",2)/2")
  if countRho~=tiNspire.toNumber(expected) then
    self:appendToResult("Attention : Il devrait y avoir "..tostring(expected).." correlation != "..tostring(countRho))
  else
    self:appendToResult("number of correlation found "..tostring(countRho).." as expected "..tostring(expected))
  end
  if countsigma~= countX then
    self:appendToResult("Attention : countsigma="..tostring(countsigma).." != countX="..tostring(countX))
  end
  self:appendToResult("\nIl y a "..tostring(countX).." actifs dans le portefeuille\n")
  self:appendToResult("Existe-t-il une oportunit"..e_acute.." d'arbitrage, si oui comment?\n")
  self:appendToResult("Le portefeuille Z={"..Portefeuillef.toVectLet(countX).."} \n")   



end


--  local sigmaSumAll = ""
--  local sigmaSumAllTxt = ""
--
--  for i=1,countX,1 
--  do
--    if i>1 then 
--      sigmaSumAllTxt=sigmaSumAllTxt.."+"
--      sigmaSumAll=sigmaSumAll.."+"
--    end
--    sigmaSumAllTxt=sigmaSumAllTxt..c_sigma..tostring(i)
--    sigmaSumAll=sigmaSumAll..tostring(sigmaLuaVect[i])
--  end
--  self:appendToResult(sum_sym..c_sigma..tostring(sigmaSumAllTxt).."=")
--  self:appendMathToResult(tostring(sigmaSumAll).."=")
--  local sigmaSumAllRes = tiNspire.execute(sigmaSumAll)
--  self:appendMathToResult(tostring(sigmaSumAllRes).."="..tostring(tiNspire.approx(sigmaSumAll)))
--
--  for i=1,countX,1 
--  do
--    self:appendToResult("X"..string.char(65+i-1).."=")
--    local sigmaSumHightTxt=""
--    local sigmaSumHight=""
--    local countsum=0
--    for j=1,countX,1
--    do  
--      if j~=i then
--        if countsum>0 then 
--          sigmaSumHightTxt=sigmaSumHightTxt.."+"
--          sigmaSumAll=sigmaSumAll.."+"
--        end
--        sigmaSumHightTxt=sigmaSumHightTxt..c_sigma..tostring(i)
--        sigmaSumHight=sigmaSumHight..
--        countsum=countsum+1
--      end
--    end
--  end

