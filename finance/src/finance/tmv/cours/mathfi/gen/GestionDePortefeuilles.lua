--------------------------------------------------------------------------
-- cours exported from GestionDePortefeuilles.txt
--------------------------------------------------------------------------


GestionDePortefeuilles = Tmv(GESTION_DE_PORTEFEUILLES_TITLE_ID,GESTION_DE_PORTEFEUILLES_TITLE_HEADER_ID)

function GestionDePortefeuilles:performCalc()
  self:appendToResult("")
  self:appendTitleToResult("Gestion de portefeuilles")
  self:appendToResult("\n")
  self:appendToResult("Markowitz : ")
  self:appendMathToResult("Rp - "..c_theta.."/2 "..c_sigma.."(P)^2")
  self:appendToResult(" -> max \n")
  self:appendToResult("ici pour obtenir la composition du ptf on aura:\n")
  self:appendToResult("")
  self:appendMathToResult("Rp - "..c_theta.."/2 * "..c_sigma.."(P)^2")
  self:appendToResult(" -> max donc ")
  self:appendMathToResult("rf + Xm(R-rf)-"..c_theta.."/2 *(Xm*"..c_sigma.."(M))^2")
  self:appendToResult(" -->max et donc en dérivant on aura\n")
  self:appendToResult("")
  self:appendMathToResult("Xm=(R(M)-rf)/("..c_theta.." * "..c_sigma.."(M)^2)")
  self:appendToResult("\n")
  self:appendToResult("\n")
  self:appendToResult("")
  self:appendMathToResult(""..c_sigma.."(P)^2 = X(A)^2*"..c_sigma.."(P)^2+ X(B)^2*"..c_sigma.."(B)^2+2*"..c_rho.."*"..c_sigma.."(A)*"..c_sigma.."(B) ")
  self:appendToResult("\n")
  self:appendToResult("et le ptf qui minimise le risque on mimnimise \n")
  self:appendToResult("")
  self:appendMathToResult(""..c_sigma.."(P)= (X(A)^2*"..c_sigma.."(A)^2+ X(B)^2*"..c_sigma.."(B)^2+2*"..c_rho.."*"..c_sigma.."(A)*"..c_sigma.."(B))^(1/2) ")
  self:appendToResult("\n")
  self:appendToResult("on dérivant par X(A) on aura \n")
  self:appendToResult("pour "..c_rho.." entre {-1 et 1} ")
  self:appendMathToResult(" X(A)= ("..c_sigma.."(B)^2 - "..c_rho.."*"..c_sigma.."(A)*"..c_sigma.."(B))/("..c_sigma.."(A)^2+"..c_sigma.."(B)^2-2*"..c_rho.."*"..c_sigma.."(A)*"..c_sigma.."(B))")
  self:appendToResult(" \n")
  self:appendToResult("pour "..c_rho.." = -1 la composition du ptf Z et tel que ")
  self:appendMathToResult("X(A) = "..c_sigma.."(B) / ("..c_sigma.."(A) + "..c_sigma.."(B))")
  self:appendMathToResult(" \n")
  self:appendToResult("et donc par ex Z= {3/5 A ; 2/5 B} alors Rz=(3/5)*Ra+(2/5)*Rb \n")
  self:appendToResult(" \n")
  self:appendToResult("le ptf parfait en fct de "..c_theta.." on ")
  self:appendMathToResult("Rp - "..c_theta.."/2 "..c_sigma.."(P)^2")
  self:appendToResult("-> max \n")
  self:appendToResult("")
  self:appendMathToResult("X(A)*R(A) + (1-X(A))*R(B) - ("..c_theta.."/2) (X(A)^2*"..c_sigma.."(A)^2+ X(B)^2*"..c_sigma.."(B)^2+2*"..c_rho.."*"..c_sigma.."(A)*"..c_sigma.."(B)) ")
  self:appendToResult(" \n")
  self:appendToResult("")
  self:appendMathToResult("X(A)=(R(A)-R(B)+"..c_theta.."*("..c_sigma.."(B)^2-"..c_rho.."*"..c_sigma.."(A)*"..c_sigma.."(B)))/("..c_theta.."*("..c_sigma.."(A)^2 + "..c_sigma.."(B)^2-2*"..c_rho.."*"..c_sigma.."(A)*"..c_sigma.."(B)))")
  self:appendToResult(" \n")
  self:appendToResult(" \n")
  self:appendToResult("Quand on a une VAD le risque du ptf peut etre superieur au risques de tous les actifs qui le composent. \n")
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
  self:appendMathToResult(""..c_sigma.."(i)^2 = ("..c_beta.."(i)*"..c_sigma.."(M))^2+var(Epsilon(i))")
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
  self:appendMathToResult("Sharpe-ratio = (Rm-rf)/"..c_sigma.."(M) = (R(Y))-rf)/"..c_sigma.."(Y)")
  self:appendToResult(" et "..c_rho.."(Y/M) = 1")
  self:appendToResult(" \n")

end

