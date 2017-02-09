--------------------------------------------------------------------------
-- cours exported from ModelesPtfCapmCml.txt
--------------------------------------------------------------------------


ModelesPtfCapmCml = Tmv(MODELES_PTF_CAPM_CML_TITLE_ID,MODELES_PTF_CAPM_CML_TITLE_HEADER_ID)

function ModelesPtfCapmCml:performCalc()
  self:appendToResult("")
  self:appendTitleToResult("Modeles Gestion de ptf CAPM CML")
  self:appendToResult("")
  self:appendMathToResult("Sharpe-ratio = (Rm-rf)/"..c_sigma.."(M)")
  self:appendToResult(" donc sur CML on a ")
  self:appendMathToResult("R(P)=rf+((Rm-rf)/"..c_sigma.."(M))*"..c_sigma.."(P)")
  self:appendToResult(" \n")
  self:appendToResult("Si actif non efficient et on veut garder R:  ")
  self:appendMathToResult("R(P)=rf+X(M)(Rm-rf)")
  self:appendToResult(" et "..c_sigma.."(P)=X(M)"..c_sigma.."(M)  \n")
  self:appendToResult(" \n")
  self:appendToResult("composition du ptf efficient en fct de "..c_theta.." \n")
  self:appendToResult("")
  self:appendMathToResult("X=1/"..c_theta.." * V^(-1) * (R-1*rf)")
  self:appendToResult(" et ")
  self:appendMathToResult("Xf = 1-1*X")
  self:appendToResult(" \n")
  self:appendToResult(" \n")
  self:appendToResult("Le seul ptf efficient qui ne contient que des actifs risqués et le ptf Tangent. ")
  self:appendToResult("\n")
  self:appendToResult("")
  self:appendMathToResult("T=(V^(-1)*(R-1*rf))/(1*V^(-1) * (R-1*rf))")
  self:appendToResult(" \n")
  self:appendToResult("risque systematique ")
  self:appendMathToResult(""..c_beta.." = cov/var=(Ri-rf)/(Rm-rf)")
  self:appendToResult(" et CAPM : ")
  self:appendMathToResult("Ri=rf+"..c_beta.."(i)(Rm-rf)")
  self:appendToResult(" \n")
  self:appendToResult(" \n")
  self:appendToResult(" ")
  self:appendMathToResult(""..c_beta.."(p)=X(M)*"..c_beta.."(M)+Xf*"..c_beta.."(f)")
  self:appendMathToResult(" donc ")
  self:appendMathToResult(""..c_beta.."(p)=X(M)")
  self:appendMathToResult(" car "..c_beta.."(M)=1 et "..c_beta.."(f)=0")
  self:appendToResult("  \n")
  self:appendToResult(" Donc on peut deduire lq composition du ptf si pqr ex "..c_beta.."(p)=0.3 donc X(M)=0.3 et X(f)=0.7")
  self:appendToResult(" \n")
  self:appendToResult("tous les actifs sur SML donc si Alpha=R(observe)-R(estime)>0 actif sous estimé et on achète sinon VAD.")
  self:appendToResult(" \n")
  self:appendToResult("")
  self:appendMathToResult("Ri=(P(i)+D-P(i-1))/P(i-1)")
  self:appendToResult(" \n")
  self:appendToResult("risque systematique et specifique : ")
  self:appendMathToResult(""..c_sigma.."(i)^2 = ("..c_beta.."(i)*"..c_sigma.."(M))^2+var("..c_epsilon.."(i))")
  self:appendToResult(" \n")
  self:appendToResult("et on commence par calculer ")
  self:appendMathToResult(""..c_beta.."(i)=(Ri-rf)/(Rm-rf)")
  self:appendToResult(" \n")
  self:appendToResult("Si Dr/D"..c_sigma.." forme une fct concave monotone croissante avec vitesse décroissante donc frontire efficiente. \n")
  self:appendToResult("Le ptf de marché et celui qui a le plus grands Sahrpe ratio \n")
  self:appendToResult(" \n")
  self:appendToResult("P appartient CML : ")
  self:appendMathToResult("Rp=rf+Xm(Rm-rf)")
  self:appendToResult(" et on en déduit Xm et "..c_sigma.."(M) qui vaudra ")
  self:appendMathToResult("Xm*"..c_sigma.."(M)")
  self:appendToResult(" \n")
  self:appendToResult("Si on a pour un actif "..c_sigma.."=0 donc c'est rf donc on charche Xf à l'aide de ")
  self:appendMathToResult("Xf=1-1*X")
  self:appendToResult(" avec ")
  self:appendMathToResult("X=(1/"..c_theta..") * V^(-1) * (R-1*rf)")
  self:appendToResult(" \n")
  self:appendToResult("Si ptf Y dans CML donc même Sharpe ratio que ptf de matché ")
  self:appendMathToResult("Sharpe-ratio = (Rm-rf)/"..c_sigma.."(M) = (R(Y)-rf)/"..c_sigma.."(Y)")
  self:appendToResult(" et "..c_rho.."(Y/M) = 1")
  self:appendToResult(" \n")

end
