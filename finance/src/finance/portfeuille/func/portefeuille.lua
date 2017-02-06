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
  local expected=tiNspire.approx("nPr("..tostring(countsigma)..",2)/2")
  -- check coherence
  if countRho~=tiNspire.toNumber(expected) then
    self:appendToResult("Attention : Il devrait y avoir "..tostring(expected).." correlation != "..tostring(countRho).."\n")
  else
    self:appendToResult("number of correlation found "..tostring(countRho).." as expected "..tostring(expected).."\n")
  end
  if countsigma~= countR then
    self:appendToResult("Attention : countsigma="..tostring(countsigma).." != countR="..tostring(countR).."\n")
  end
  
  self:appendToResult("Il y a "..tostring(countsigma).." actifs dans le portefeuille\n")
  
  self:appendToResult("Existe-t-il une oportunit"..e_acute.." d'arbitrage, si oui comment?\n")
  self:appendToResult("Le portefeuille Z={"..Portefeuillef.toVectLet(countsigma).."} \n")   

  if countsigma==2 then 
    Portefeuillef.compositionPortefeuille2(self,Rvect,sigmaVect,rhoVect,rf,sigmaLuaVect,RLuaVect,rhoLuaVect[1]) 
  end

end



function Portefeuillef.compositionPortefeuille2(self,Rvect,sigmaVect,rhoVect,rf,sigmaLuaVect,RLuaVect,rho)
  Portefeuillef.courscompositionPortefeuille2(self,rho)
  if sigmaLuaVect~=nil then
     local rhoN=tiNspire.toNumber(rho)
     local XLuaVect={}
     if rhoN==-1 then
        self:appendMathToResult("XA=("..c_sigma.."B/("..c_sigma.."A+"..c_sigma.."B)="..tostring(sigmaLuaVect[2]).."/("..tostring(sigmaLuaVect[1]).."+"..tostring(sigmaLuaVect[2])..")")
        self:appendToResult("\n")
        local res = tiNspire.execute(tostring(sigmaLuaVect[2]).."/("..tostring(sigmaLuaVect[1]).."+"..tostring(sigmaLuaVect[2])..")")
        self:appendMathToResult("="..tostring(res))
        self:appendMathToResult("="..tostring(tiNspire.approx(res)))
        self:appendToResult("\n")
        local resB = tiNspire.execute("1-("..tostring(res)..")")
        self:appendMathToResult("XB=1-XA=1-"..tostring(res).."="..tostring(resB).."="..tostring(tiNspire.approx(resB)))
        self:appendToResult("\n")
        self:appendToResult("Donc : ")
        XLuaVect[1]=res
        XLuaVect[2]=resB
     elseif rhoN==1 then 
        self:appendToResult("cas non trait"..e_acute.." pas de portefeuille Z\n")
        return
     elseif rhoN==0 then 
        self:appendMathToResult("XA=(("..c_sigma.."B^2)/("..c_sigma.."A^2+"..c_sigma.."B^2))=("..tostring(sigmaLuaVect[2]).."^2/("..tostring(sigmaLuaVect[1]).."^2+"..tostring(sigmaLuaVect[2]).."^2)")
        self:appendToResult("\n")
        local res = tiNspire.execute(tostring(sigmaLuaVect[2]).."^2/("..tostring(sigmaLuaVect[1]).."^2+"..tostring(sigmaLuaVect[2]).."^2)")
        self:appendMathToResult("="..tostring(res))
        self:appendMathToResult("="..tostring(tiNspire.approx(res)))
        self:appendToResult("\n")
        local resB = tiNspire.execute("1-("..tostring(res)..")")
        self:appendMathToResult("XB=1-XA=1-"..tostring(res).."="..tostring(resB).."="..tostring(tiNspire.approx(resB)))
        self:appendToResult("\n")
        self:appendToResult("Donc : ")
        XLuaVect[1]=res
        XLuaVect[2]=resB        
     else
        --cas general 
        self:appendMathToResult("XA=("..c_sigma.."B^2-"..c_sigma.."A*"..c_sigma.."B*"..c_rho.."AB)/("..c_sigma.."A^2+"..c_sigma.."B^2-2*"..c_sigma.."A*"..c_sigma.."B*"..c_rho.."AB))")
        self:appendToResult("\n")
        local calcRes = "(("..tostring(sigmaLuaVect[2]).."^2-"..tostring(sigmaLuaVect[1]).."*"..tostring(sigmaLuaVect[2]).."*"..tostring(rho)..")/("..tostring(sigmaLuaVect[1]).."^2+"..tostring(sigmaLuaVect[2]).."^2-2*"..tostring(sigmaLuaVect[1]).."*"..tostring(sigmaLuaVect[2]).."*"..tostring(rho).."))"
        self:appendMathToResult("="..tostring(calcRes))
        local res = tiNspire.execute(tostring(calcRes))
        self:appendMathToResult("="..tostring(res))
        self:appendMathToResult("="..tostring(tiNspire.approx(res)))
        self:appendToResult("\n")
        local resB = tiNspire.execute("1-("..tostring(res)..")")
        self:appendMathToResult("XB=1-XA=1-"..tostring(res).."="..tostring(resB).."="..tostring(tiNspire.approx(resB)))
        self:appendToResult("\n")
        self:appendToResult("Donc : ")
        XLuaVect[1]=res
        XLuaVect[2]=resB                
     end          
     self:appendMathToResult("=Z={"..tostring(XLuaVect[1]).."*A;"..tostring(XLuaVect[2]).."*B}")
     self:appendToResult("\n")
     -- save result 
     varValue["X"]=tostring(res)..","..tostring(resB)
     local rendement = Portefeuillef.rendementPortefeuille(self,XLuaVect,RLuaVect,2)
     self:appendToResult("\n")
     Portefeuillef.OAPortefeuille(self,rendement,rf,XLuaVect)
  end
end

function Portefeuillef.OAPortefeuille(self,rendement,rf,XLuaVect)
  --
  local deltaEq = 0.1
  local count = table.getn(XLuaVect)
  local rendAp = tiNspire.approx(rendement)
  local res=""
  if tonumber(count) ~= nil then
     for i=1,count,1 
     do
       if i>1 then 
          res=res..","
       end
       local c=string.char(65+i-1)
        res=res..tostring(XLuaVect[i]).."*"..c
     end
  end


  local rendNum = tiNspire.toNumber(tostring(rendement))
  local rfNum = tiNspire.toNumber(tostring(rf))
  local delta = tiNspire.toNumber(tiNspire.abs(tostring(rendement).."-"..tostring(rf)))
  if rendNum ~=nil and delta~=nil and rfNum~=nil then
    if delta<deltaEq then
     self:appendToResult("pas d'OA car "..tostring(rendAp).." et "..tostring(rf).." sont proche(=)")
    elseif rendNum <rfNum then
       self:appendToResult("ici OA car "..tostring(rendAp).."% < "..tostring(rf).."%\n")
       self:appendToResult("Donc vente "..a_acute.." decouvert du portefeuille z et achat de rf :\n")
       self:appendToResult("ici VAD :")
       self:appendMathToResult(tostring(res))
       self:appendToResult("et position longue rf \n")
    else
       self:appendToResult("ici OA car "..tostring(rendAp).."% > "..tostring(rf).."%\n")
       self:appendToResult("Donc achat du portefeuille z et position courte sur rf :\n")
       self:appendToResult("ici achat :")
       self:appendMathToResult(tostring(res))
       self:appendToResult("\n et position courte rf \n")
    end
  else
    self:appendToResult("rf or rendement is null!\n")
  end
end

function Portefeuillef.rendementPortefeuille(self,XLuaVect,RLuaVect,count)
  local res=""
  local resCalc=""
  
  if tonumber(count) ~= nil then
    for i=1,count,1 
    do
      if i>1 then 
        res=res.."+"
        resCalc=resCalc.."+"
      end
      local c=string.char(65+i-1)
      res=res.."X"..c.."*R"..c
      resCalc=resCalc..tostring(XLuaVect[i]).."*"..tostring(RLuaVect[i])
    end
  end

  self:appendMathToResult("R="..tostring(res).."="..tostring(resCalc));
  local resFromCalc = tiNspire.execute(tostring(resCalc))
  self:appendMathToResult("="..tostring(resFromCalc))
  self:appendMathToResult("="..tostring(tiNspire.approx(resFromCalc)))
  return resFromCalc
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

function Portefeuillef.courscompositionPortefeuille2(self,rho)
   self:appendMathToResult("Rp=X1*R1+X2+R2")
   self:appendToResult(" avec ");
   self:appendMathToResult("X2=1-X1")
   self:appendToResult("\n")
   self:appendMathToResult(c_sigma.."p^2=X1*"..c_sigma.."1^2+(1-X1)^2*"..c_sigma.."2^2+2*"..c_rho.."1_2*"..c_sigma.."1*"..c_sigma.."2*X1*(1-X1)")
   self:appendToResult("\n")
   self:appendMathToResult("Rp="..sum_sym.."(xi*Ri,i,1,N)")
   self:appendToResult("\n")
   self:appendMathToResult(c_sigma.."p^2="..sum_sym.."("..sum_sym.."(xi*xj*"..c_sigma.."ij,j,1,N),i,1,N)")
   self:appendToResult("\n")
   local rhoN=tiNspire.toNumber(rho)
   if rhoN==-1 then
      self:appendMathToResult(c_rho.."1_2=-1")
      self:appendToResult("\n")
      self:appendMathToResult("X1=("..c_sigma.."2/("..c_sigma.."1+"..c_sigma.."2))")
   elseif rhoN==1 then 
      self:appendMathToResult(c_rho.."1_2=1")
      self:appendToResult("\n")
      self:appendMathToResult(c_sigma.."p=X1*"..c_sigma.."1+(1-X1)*"..c_sigma.."2")
      self:appendToResult("\n")
      self:appendMathToResult("X1=("..c_sigma.."p-"..c_sigma.."2)/("..c_sigma.."1-"..c_sigma.."2)")
      self:appendToResult("\n")
      self:appendMathToResult("Rp=((R2-((R1-R2)/("..c_sigma.."1-"..c_sigma.."2))*"..c_sigma.."2)+((R1-R2)/("..c_sigma.."1-"..c_sigma.."2))*"..c_sigma.."p")
   elseif rhoN==0 then 
      self:appendMathToResult(c_rho.."1_2=0")
      self:appendToResult("\n")
      self:appendMathToResult("X1min=(("..c_sigma.."2^2)/("..c_sigma.."1^2+"..c_sigma.."2^2))")
   else 
      self:appendMathToResult(c_rho.."1_2="..tostring(rhoN))
      self:appendToResult("\n")
      self:appendMathToResult(c_sigma.."p=(X1^2)/("..c_sigma.."1^2+(1-X1)^2*"..c_sigma.."2^2+2*X1*(1-X1)*"..c_sigma.."1*"..c_sigma.."2*"..c_rho.."1_2)^(1/2)")
      self:appendToResult("\n")
      self:appendMathToResult("X1min=("..c_sigma.."2^2-"..c_sigma.."1*"..c_sigma.."2*"..c_rho.."1_2)/("..c_sigma.."1^2+"..c_sigma.."2^2-2*"..c_sigma.."1*"..c_sigma.."2*"..c_rho.."1_2))")
   end
   self:appendToResult("\n")
   self:appendMathToResult("X2=1-X1")
   self:appendToResult("\n")
end
