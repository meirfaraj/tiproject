require("std/symbols")

tiNspire={}

function tiNspire.execute(expression)
    if expression then       
       local res,err = math.evalStr(expression)
       math.setEvalSettings({{'Calculation Mode','Exact'}})
       if res then
         print("execute : "..tostring(expression).." returned "..tostring(res))
         return res,err
       end
       print("execute : "..tostring(expression).." returned "..tostring(res).." Error : "..tostring(err))
       return res,err
   else
     print("execute failure")
   end
   return nil,"failed to execute : "..tostring(expression)
end


--abs(Expr1)Þexpression
--abs(Liste1)Þliste
--abs(Matrice1)Þmatrice
--Donne la valeur absolue de l'argument.
--Remarque : Voir aussi Modèle Valeur absolue, page 7.
--Si l'argument est un nombre complexe, donne le
--module de ce nombre.
--Remarque : toutes les variables non affectées sont
--considérées comme réelles.
function tiNspire.abs(expression)
    return tiNspire.execute("abs("..tostring(expression)..")")
end



function tiNspire.approx(expression)
    return tiNspire.execute("approx("..tostring(expression)..")")
end



function tiNspire.nSolve(expression,var)
    math.setEvalSettings({{'Calculation Mode','Auto'}})
    return tiNspire.execute("nSolve("..tostring(expression)..","..tostring(var)..")")
end

function tiNspire.solve(expression,var)
    math.setEvalSettings({{'Calculation Mode','Auto'}})
    return tiNspire.execute("Solve("..tostring(expression)..","..tostring(var)..")")
end

function tiNspire.nSolveCond(expression,var,cond)
    math.setEvalSettings({{'Calculation Mode','Auto'}})
    return tiNspire.execute("nSolve("..tostring(expression)..","..tostring(var)..")|"..tostring(cond))
end

function tiNspire.solveCond(expression,var,cond)
    math.setEvalSettings({{'Calculation Mode','Auto'}})
    return tiNspire.execute("Solve("..tostring(expression)..","..tostring(var)..")|"..tostring(cond))
end


--amortTbl(NPmt,N,I,PV, [Pmt], [FV], [PpY], [CpY],
--[PmtAt], [valArrondi])Þmatrice
--Fonction d'amortissement affichant une matrice
--représentant un tableau d'amortissement pour un
--ensemble d'arguments TVM.
--NPmt est le nombre de versements à inclure au
--tableau. Le tableau commence avec le premier
--versement.
--N, I, PV, Pmt, FV, PpY, CpY et PmtAt sont décrits
--dans le tableau des arguments TVM, page 183.
--• Si vous omettez Pmt, il prend par défaut la
--valeur Pmt=tvmPmt
--(N,I,PV,FV,PpY,CpY,PmtAt).
--• Si vous omettez FV, il prend par défaut la valeur
--FV=0.
--• Les valeurs par défaut pour PpY, CpY et PmtAt
--sont les mêmes que pour les fonctions TVM.
--valArrondi spécifie le nombre de décimales pour
--arrondissement. Valeur par défaut=2.
--Les colonnes dans la matrice résultante apparaissent
--dans l'ordre suivant : Numéro de versement, montant
--versé pour les intérêts, montant versé pour le capital
--et solde.
--Le solde affiché à la ligne n correspond au solde après
--le versement n.
--Vous pouvez utiliser la matrice de sortie pour insérer
--les valeurs des autres fonctions d'amortissement
--GInt() et GPrn(), page 211 et bal(), page 20.
function tiNspire.amortTbl(NPmt,N,I,PV, Pmt, FV, PpY, CpY,PmtAt, valArrondi)
-- TODO : amortTbl
    return tiNspire.execute("amortTbl("..tostring(NPmt)..")")
end


-- <b>angle</b>(<i>Expr1</i>) [expression]
-- <p>Donne l'argument de l'expression passée en
-- paramètre, celle-ci étant interprétée comme un
-- nombre complexe.
-- <u><b>Remarque</b></u> : toutes les variables non affectées sont
--considérées comme réelles.</p>
--angle(Liste1)Þliste
--angle(Matrice1)Þmatrice
--Donne la liste ou la matrice des arguments des
--éléments de Liste1 ou Matrice1, où chaque élément
--est interprété comme un nombre complexe
--représentant un point de coordonnée rectangulaire à
--deux dimensions.
function tiNspire.angle(expression)
    return tiNspire.execute("angle("..tostring(expression)..")")
end



--dbd() Catalogue >
--dbd(date1,date2)⇒valeur
--Calcule le nombre de jours entre date1 et date2 à
--l'aide de la méthode de calcul des jours.
--date1 et date2 peuvent être des chiffres ou des listes
--Liste alphabétique 47
--48 Liste alphabétique
--dbd() Catalogue >
--de chiffres compris dans une plage de dates d'un
--calendrier normal. Si date1 et date2 sont toutes deux
--des listes, elles doivent être de la même longueur.
--date1 et date2 doivent être comprises entre 1950 et
--2049.
--Vous pouvez saisir les dates à l'un des deux formats.
--L'emplacement de la décimale permet de distinguer
--les deux formats.
--MM.JJAA (format communément utilisé aux EtatsUnis)
--JJMM.AA (format communément utilisé en Europe)
function tiNspire.dbd(date1,date2)
    return tiNspire.execute("dbd("..tostring(date1)..","..tostring(date2)..")")
end


function tiNspire.deriv(funct,param,order,value)
   local calc
   if order~=nil then
      calc = "derivative("..tostring(funct)..","..tostring(param)..","..order..")"
   else
      calc = "derivative("..tostring(funct)..","..tostring(param)..")"
   end
   if value~=nil then
     calc = calc.."|"..tostring(param).."="..tostring(value)
   end
   local res,err = tiNspire.execute(calc)
   return res,err,calc
end

function tiNspire.sign(val)
   return tiNspire.execute("sign("..tostring(val)..")")
end

function tiNspire.toNumber(val)
  if val==nil then
    return nil
  end
  if string.find(tostring(val), "/") then
    val = tiNspire.approx(tostring(val))
  end
  local valstr = string.gsub(tostring(val),neg_sym,"-")
  return tonumber(valstr)
end