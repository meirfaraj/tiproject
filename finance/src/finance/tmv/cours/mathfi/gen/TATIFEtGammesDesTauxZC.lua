--------------------------------------------------------------------------
-- cours exported from TATIFEtGammesDesTauxZC.txt
--------------------------------------------------------------------------


TATIFEtGammesDesTauxZC = Tmv(T_A_T_I_F_ET_GAMMES_DES_TAUX_Z_C_TITLE_ID,T_A_T_I_F_ET_GAMMES_DES_TAUX_Z_C_TITLE_HEADER_ID)

function TATIFEtGammesDesTauxZC:performCalc()
  self:appendToResult("TATIF Gamme des taux...")
  self:appendToResult("D"..e_acute.."terminer les taux ZC "..a_grave.." partir des TATIF")
  self:appendToResult("Un calcul de proche en proche de la gamme (rn)n=1...n")
  self:appendToResult("Exemple : Eur-1an = 5%, TATIF 2 ans 5.5%, TATIF 3 ans 6%")
  self:appendToResult("Pour d"..e_acute.."terminer ZC compatibles avec ces 3 taux")
  self:appendToResult("Euribor doit "..e_circ .."tre converti en taux exact : 5%*365/360=5.07%")
  self:appendToResult("les op"..e_acute.."rations moins d'un an "..e_acute.."tant ZC, le taux ZC-1 : r1=5.07%  ")
  self:appendToResult("consid"..e_acute.."ron maintenant un titre 2 ans, in fine , au pair; son taux facial se confond")
  self:appendToResult("avec son taux actuariel.Sa valeur, "..e_acute.."gale "..a_grave.." 1, est aussi "..e_acute.."gale "..a_grave.." la valeur pr"..e_acute.."sente des flux auxquels il donne droit,")
  self:appendToResult("actualis"..e_acute.."s avce la gamme des taux ZC(r1=5.07% et r2 inconnue recherch"..e_acute.."e), soit:")
  self:appendToResult("")
  self:appendMathToResult("1=0.055/1.057+1.055/(1+r2)^2")
  self:appendToResult("de la m"..e_circ .."me façon apr"..e_grave.." avoir trouv"..e_acute.." r2 on calcule r3")
  self:appendToResult("")
  self:appendMathToResult("1=0.06/1.06 + 0.06/(1+r2)^2 + 1.06/(1+r3)^3")
  self:appendToResult("Les taux d'int"..e_acute.."r"..e_circ .."t "..a_grave.." terme implicites")
  self:appendToResult("")
  self:appendMathToResult("(1+f(n,d))^d = (1+r(n+d))^(n+d)/(1+r(n))^(n)")
  self:appendToResult("f(n,d) est appel"..e_acute.." le taux forward du d p"..e_acute.."riodes dans n p"..e_acute.."riodes taux relatif "..a_grave.." la p"..e_acute.."riode (n, n+d)")
  self:appendToResult("Exemple: Les taux ZC r(t) s'"..e_acute.."tablissent comme suit")
  self:appendToResult("3mois: 5%, 6mois: 5.3%, 9mois: 5.4%, 12mois: 5.5%, 15mois: 5.6%")
  self:appendToResult("taux 6mois dans 9mois ")
  self:appendMathToResult("(1+f(9,6))^0.5=(1+r(15))^1.25/(1+r(9))^0.75")

end

