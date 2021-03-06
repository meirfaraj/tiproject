  
--------------------------------------------------------------------------
--                            cours                               --
--------------------------------------------------------------------------

ConventionDeBaseCours = Tmv(CONVENTION_DE_BASE_TITLE_ID,CONVENTION_DE_BASE_TITLE_HEADER_ID)
 


-- start by self:appendToResult(" 
-- replace � by "..e_acute.."
-- replace � by "..e_circ .."
-- replace � by "..e_grave.."
-- replace � by "..u_grave.."
-- replace � by "..points_susp.."
-- replace � by "..a_grave.."
-- end by \n")

function ConventionDeBaseCours:performCalc()
  self:appendToResult("Ces conventions sont utilis"..e_acute.."es pour tout instrument financier comportant une composante d'int"..e_acute.."r"..e_circ.."ts (obligation, swap de taux "..points_susp.."). Dans le cas des valeurs mobili"..e_grave.."res, elle fait partie des caract"..e_acute.."ristiques sp"..e_acute.."cifi"..e_acute.."s dans le prospectus d'"..e_acute.."mission, dans le cas des produits d"..e_acute.."riv"..e_acute.."s (swaps, caps, floors "..points_susp.."), elle est arr"..e_circ.."t"..e_acute.."e au moment de la n"..e_acute.."gociation entre les deux parties contractantes.\n")
  self:appendToResult("Les conventions de base sont exprim"..e_acute.."es sous forme de fraction, o"..u_grave.." le num"..e_acute.."rateur exprime le nombre de jours pris en compte pour calculer les jours d'int"..e_acute.."r"..e_circ.."t, et le d"..e_acute.."nominateur le nombre de jours pris en compte pour d"..e_acute.."terminer la p"..e_acute.."riode d'int"..e_acute.."r"..e_circ.."t.\n")
  self:appendToResult("Il existe un certain nombre de conventions, dont les quatre les plus fr"..e_acute.."quemment utilis"..e_acute.."es sont d"..e_acute.."taill"..e_acute.."es ci-dessous.\n")
  self:appendTitleToResult("Exact/Exact")
  self:appendToResult("Appel"..e_acute.."e aussi")
  self:appendBoldToResult("Act/Act")
  self:appendToResult(",")
  self:appendBoldToResult("Act/nAct")
  self:appendToResult("ou")
  self:appendBoldToResult("bond basis")
  self:appendToResult(". Elle consiste "..a_grave.." prendre en compte, aussi bien pour le num"..e_acute.."rateur que pour le d"..e_acute.."nominateur, le nombre de jours exacts.\n")
  self:appendTitleToResult("Exact/365")
  self:appendToResult("Convention proche de la bond basis, "..a_grave.." la diff"..e_acute.."rence pr"..e_grave.."s que la convention Exact/365 ne tient pas compte des ann"..e_acute.."es bissextiles.\n")
  self:appendTitleToResult("Exact/360")
  self:appendToResult("Appel"..e_acute.."e "..e_acute.."galement ")
  self:appendBoldToResult("Act/360")
  self:appendToResult("ou")
  self:appendBoldToResult("base mon"..e_acute.."taire")
  self:appendToResult(" . Le num"..e_acute.."rateur est le nombre exact de jours "..e_acute.."coul"..e_acute.."s durant la p"..e_acute.."riode d'application. L'ann"..e_acute.."e est calcul"..e_acute.." comme comportant 360 jours. Cette convention est appliqu"..e_acute.." pour la plupart des instruments et indices mon"..e_acute.."taires, d'o"..u_grave.." son nom.\n")
  self:appendTitleToResult("30/360")
  self:appendToResult("Convention consistant "..a_grave.." compter tous les mois avec 30 jours, et les ann"..e_acute.."es avec 360 jours.\n")
  self:appendToResult("Il y a deux versions distinctes de cette convention, une am"..e_acute.."ricaine et une europ"..e_acute.."enne:\n")
  self:appendTitleToResult("30/360 US ou 30/360 NASD")
  self:appendToResult("R"..e_grave.."gles:\n")
  self:appendToResult("Si la date de d"..e_acute.."part est un dernier jour du mois, il devient le 30 de ce mois. Un 28 ou 29 de f"..e_acute.."vrier devient donc, pour le calcul un ")
  self:appendBoldToResult("30 f"..e_acute.."vrier\n")
  self:appendToResult("Si la date de fin est un dernier jour du mois et la date de d"..e_acute.."part et la date de d"..e_acute.."but se situe avant le 30 du mois, la date de fin devient le premier jour du mois suivant.\n")
  self:appendToResult("sinon, la date de fin devient le 30 du mois\n")
  self:appendTitleToResult("30/360 EU")
  self:appendToResult("Les dates de d"..e_acute.."but ou de fin qui sont des 31 d'un mois deviennent les 30 du mois.\n")
end


