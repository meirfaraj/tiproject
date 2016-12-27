
platform.apilevel = "2.2"
toolpalette.enableCopy(true)
toolpalette.enableCut(true)
toolpalette.enablePaste(true)


 -- Including : C:\tiproject\finance\src\std\i18n.lua


 -- Including : C:\tiproject\finance\src\std\symbols.lua



 -- Including : C:\tiproject\finance\src\std\str.lua


function utf8(n)
	return string.uchar(n)
end

function Utf8to32(utf8str)
  assert(type(utf8str) == "string")
  local res, seq, val = {}, 0, nil
  for i = 1, #utf8str do
    local c = string.byte(utf8str, i)
    if seq == 0 then
      table.insert(res, val)
      seq = c < 0x80 and 1 or c < 0xE0 and 2 or c < 0xF0 and 3 or
            c < 0xF8 and 4 or c < 0xFC and 5 or c < 0xFE and 6 or
          error("invalid UTF-8 character sequence")
      val = bit.band(c, 2^(8-seq) - 1)
    else
      val = bit.bor(bit.lshift(val, 6), bit.band(c, 0x3F))
    end
    seq = seq - 1
  end
  table.insert(res, val)
  table.insert(res, 0)
  return res
end


SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}
function numberToSub(w,n)
	return w..utf8(SubNumbers[tonumber(n)])
end


function string.fromhex(str)
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end

function string.bintohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

function string.tohex(num)
    return string.format('%02X', num)
end

function string.simplify(str)
    local simplified = str
    if 	simplified:match ("\".*\"") then
	   simplified=simplified:sub(2,simplified:len()-1)
	   print("["..str.."] simplified has ["..simplified.."]")
	end
	return simplified
end






local UTF8 = {}

function UTF8.charbytes (s, i)
   i = i or 1
   local c = string.byte(s, i)
   
   if c > 0 and c <= 127 then
      return 1
   elseif c >= 194 and c <= 223 then
      local c2 = string.byte(s, i + 1)
      return 2
   elseif c >= 224 and c <= 239 then
      local c2 = s:byte(i + 1)
      local c3 = s:byte(i + 2)
      return 3
   elseif c >= 240 and c <= 244 then
      local c2 = s:byte(i + 1)
      local c3 = s:byte(i + 2)
      local c4 = s:byte(i + 3)
      return 4
   end
end

function UTF8.len (s)
   local pos = 1
   local bytes = string.len(s)
   local len = 0
   
   while pos <= bytes and len ~= chars do
      local c = string.byte(s,pos)
      len = len + 1
      
      pos = pos + UTF8.charbytes(s, pos)
   end
   
   if chars ~= nil then
      return pos - 1
   end
   
   return len
end


function ulen(str)
    local n = string.len(str)
    local i = 1
    local j = 1
    local c
    while(j<=n) do
        c = string.len(string.usub(str,i,i))
        j = j+c
        i = i+1
    end
    return i-1
end


function UTF8.sub (s, i, j)
   j = j or -1

   if i == nil then
      return ""
   end
   
   local pos = 1
   local bytes = string.len(s)
   local len = 0

   local l = (i >= 0 and j >= 0) or UTF8.len(s)
   local startChar = (i >= 0) and i or l + i + 1
   local endChar = (j >= 0) and j or l + j + 1

   if startChar > endChar then
      return ""
   end
   
   local startByte, endByte = 1, bytes
   
   while pos <= bytes do
      len = len + 1
      
      if len == startChar then
         startByte = pos
      end
      
      pos = pos + UTF8.charbytes(s, pos)
      
      if len == endChar then
         endByte = pos - 1
         break
      end
   end
   
   return string.sub(s, startByte, endByte)
end

function string.isempty(s)
  return s == nil or s == ''
end

function UTF8.replaceAll (s, charToReplace,byChar)
   local pos = 1
   local bytes = string.len(s)
   local charbytes
   local newstr = ""

   while pos <= bytes do
      charbytes = UTF8.charbytes(s, pos)
      local c = string.sub(s, pos, pos + charbytes - 1)
      if charToReplace==c then
        newstr = newstr .. byChar 
      else
        newstr = newstr .. c
      end
      pos = pos + charbytes
   end

   return newstr
end

function UTF8.replace (s, mapping)
   local pos = 1
   local bytes = string.len(s)
   local charbytes
   local newstr = ""

   while pos <= bytes do
      charbytes = UTF8.charbytes(s, pos)
      local c = string.sub(s, pos, pos + charbytes - 1)
      newstr = newstr .. (mapping[c] or c)
      pos = pos + charbytes
   end

   return newstr
end





c_O = utf8(963)
c_alpha = utf8(945)
c_beta = utf8(946)
c_gama = utf8(947)
c_delta = utf8(948)
c_epsilon = utf8(949)
c_e = c_epsilon
c_Pi = utf8(960)
c_pi = c_Pi
c_lambda = utf8(955)
c_mu = utf8(956)
c_sigma = utf8(963)
c_tau = utf8(964)
c_rho = utf8(961)
c_phi = utf8(966)
c_omega = utf8(969)
c_CAPomega = utf8(937)
c_Ohm = c_CAPomega
c_theta = utf8(952)
RIGHTWARDS_DOUBLE_ARROW = string.uchar(0x21D2)


sqrt_sym    = string.uchar(8730)
a_acute     = string.uchar(225)
a_circ      = string.uchar(226)
a_tilde     = string.uchar(227)
a_diaer     = string.uchar(228)
a_ring      = string.uchar(229)
e_acute     = string.uchar(233)
e_grave     = string.uchar(232)
o_acute     = string.uchar(243) 
o_circ      = string.uchar(244)
l_alpha     = string.uchar(945)
l_beta      = string.uchar(946)
l_omega     = string.uchar(2126)
derive_sym  = string.uchar(61448)
sup_plus    = string.uchar(8314)
sup_minus   = string.uchar(8315)
right_arrow = string.uchar(8594)
then_sym    = RIGHTWARDS_DOUBLE_ARROW	
for_all     = string.uchar(8704)
element_of  = string.uchar(8712)
exp_sym     = string.uchar(61503)
neg_sym     = string.uchar(8722)
infinit_sym = string.uchar(8734)

localeName = locale.name()

LocaleId= {}

function checkIfLocaleExists(name)
    for k,v in pairs(LocaleId) do
        if (v.name == name) or (v == name) then
            return true
        end
    end
    return false
end

function addLocale(id,name,description)
    if checkIfLocaleExists(name) then
		if (localeName=="fr") then 
		    print("Attention ! cette locale="..name.." existe déjà! Locale néanmoins ajoutée...")
		else
            print("Warning ! This locale="..name.." appears to already exist! Adding anyway...")
		end
    end
    return table.insert(LocaleId, id, {id=id, name=name, description=description})
end

function ASLocaleId(name)
    for k,v in pairs(LocaleId) do
        if (v.name == name) or (v == name) then
            return v.id
        end
    end
    return nil
end




TextLocale = {}

function checkIfTextIdExists(id,localeId)
    for k,v in pairs(TextLocale) do
        if (v.id == id) and (v.localeId == localeId) then
            return true
        end
    end
    return false
end


function getTextId(id,localeId)
    for k,v in pairs(TextLocale) do
        if (v.id == id) and (v.localeId == localeId) then
            return v
        end
    end
    return nil
end


function addTextLocale(id,localeId,text)
    if checkIfTextIdExists(id,localeId) then
		if (localeName=="fr") then 
		    print("Attention ! cet id="..id.." de text existe déjà dans la locale="..localeId.."! Text néanmoins ajoutée...")
		else
            print("Warning ! This text id="..id.."appears to already exist in locale="..localeId.."! Adding anyway...")
		end
	end
    return table.insert(TextLocale, id+(1000*localeId), {id=id, name=name, localeId=localeId, text=text})
end


function ASText(id,localeId)
    local result = getTextId(id,localeId)
	if result ~= nil then
        return result.text
	end
	result = getTextId(id,EN)
	if result ~= nil then
        return result.text
    end
    local result = "???TEXT("..tostring(id)..","..tostring(localeId)..")" 
    print(result)
    return result
end



function ASTxt(id)
    return ASText(id,curLocaleId)
end



ABOUT_TITLE_ID = 1
ABOUT_ID = 2
ERROR_TITLE_ID = 3
ERROR_ID = 4
BY_ID = 5
BACK_ID = 6
ENTER_FONCTION_ID = 7
CLOSE_ID=8
ENTER_VAR_ID=9
ENTER_A_FUNC_TO_START_ID=10
FUNCTION_ID=11
SOLVE_ID=12
DEMONSTRATION_ID=13
SINCE_ID=14
POLY_NOTHING_TO_DEM_ID=15
OPERATION_PLMN_INTEG_EXP_ID=16
ELEMENTARY_PRIMITIVE_ID=17
OR_ID=18
BORDER_UP_ID=19
BORDER_DOWN_ID=20
INTEGR_CAN_BE_REWRITE_AS_ID=21
PROBABILITY_TITLE=22
ENTER_N_ID=23
ENTER_P_ID=24
AND_ID=25
FOR_ID=26
INVALID_PARAMETERS_ID=27
EMPTY_ID=28
NOTHING_TO_DO_ID=29
NOT_SUPPORTED_ID=30
ENTER_SN_ID=ENTER_N_ID
ENTER_BN_ID=31
ENTER_MU_ID=32
ENTER_SIGMA_ID=33


CATEGORY_COMBINATOIRE_ID=100
CATEGORY_COMBINATOIRE_DESC_ID=101
CATEGORY_LOIS_DISCRETES_ID=102
CATEGORY_LOIS_DISCRETES_DESC_ID=103
CATEGORY_LOIS_CONTINUE_ID=104
CATEGORY_LOIS_CONTINUE_DESC_ID=105
CATEGORY_TEST_NORMALITE_ID=106
CATEGORY_TEST_NORMALITE_DESC_ID=107

IPP_TITLE_ID=202
GREEK_TITLE_ID=203
UTF8_TITLE_ID=204
PERMUTATION_AVEC_REP_TITLE_ID=205
PERMUTATION_AVEC_REP_HEADER_ID=206
PERMUTATION_SANS_REP_TITLE_ID=207
PERMUTATION_SANS_REP_HEADER_ID=208
ARRANGEMENT_AVEC_REP_TITLE_ID=209
ARRANGEMENT_AVEC_REP_HEADER_ID=210
ARRANGEMENT_SANS_REP_TITLE_ID=211
ARRANGEMENT_SANS_REP_HEADER_ID=212
COMBINAISONS_AVEC_REP_TITLE_ID=213
COMBINAISONS_AVEC_REP_HEADER_ID=214
COMBINAISONS_SANS_REP_TITLE_ID=215
COMBINAISONS_SANS_REP_HEADER_ID=216
PARTITION_NON_ORD_TITLE_ID=217
PARTITION_NON_ORD_HEADER_ID=218
RESULT_WITH_RECURSIVE_STIRLING_ID=219
LOI_BINOMIAL_1VAR_TITLE_ID=220
LOI_BINOMIAL_1VAR_HEADER_ID=221
LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID=222
LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID=223
LOI_UNIFORME_1VAR_TITLE_ID=224
LOI_UNIFORME_1VAR_HEADER_ID=225
LOI_BERNOULLI_1VAR_TITLE_ID=226
LOI_BERNOULLI_1VAR_HEADER_ID=227
LOI_POISSON_1VAR_TITLE_ID=228
LOI_POISSON_1VAR_HEADER_ID=229
LOI_BINOMIAL_NEG_1VAR_TITLE_ID=230
LOI_BINOMIAL_NEG_1VAR_HEADER_ID=231
LOI_GEOMETRIQUE_1VAR_TITLE_ID=232
LOI_GEOMETRIQUE_1VAR_HEADER_ID=233
LOI_NORMAL_1VAR_TITLE_ID=234
LOI_NORMAL_1VAR_HEADER_ID=235

version="1.0-"..c_alpha


 -- Including : C:\tiproject\finance\src\std\i18n\en.lua


EN = 1
addLocale(EN,"en", "english")

addTextLocale(ABOUT_TITLE_ID,EN,"About Probabilities :")

addTextLocale(ABOUT_ID,EN,[[Probabilities v1.0
Faraj Meir
Thanks also to :
Jim Bauwens, Adrien "Adriweb" Bertrand
(inspired from FormulaPro).
LGPL3 License. Locale:]]..localeName..[[

Tip : Press [Tab] for Reference !]])


addTextLocale(ERROR_TITLE_ID,EN,"Oops... Error handled !")
 
addTextLocale(ERROR_ID,EN,[[Probabilities has encountered an error
Sorry for the inconvenience.
Please report this bug to meirfaraj@gmail.com
How/where/when it happened etc.
 (bug at line ]])

 
addTextLocale(BY_ID,EN,"by Faraj Meir")
 
addTextLocale(BACK_ID,EN," Back")

addTextLocale(ENTER_FONCTION_ID,EN,"Enter function")

addTextLocale(CLOSE_ID,EN,"Close")

addTextLocale(ENTER_VAR_ID,EN,"Enter variable")

addTextLocale(ENTER_A_FUNC_TO_START_ID,EN,"Enter a function to start")

addTextLocale(FUNCTION_ID,EN,"Function : ")

addTextLocale(SOLVE_ID,EN,"We will solve : ")


addTextLocale(DEMONSTRATION_ID,EN,"Demonstration")
 
addTextLocale(SINCE_ID,EN,"since ")
 
addTextLocale(POLY_NOTHING_TO_DEM_ID,EN, "it's a polynome it's an easy integration nothing to demonstrate")
 
addTextLocale(OPERATION_PLMN_INTEG_EXP_ID,EN, "As operation is +/- we can integrate separately as this:")

addTextLocale(ELEMENTARY_PRIMITIVE_ID,EN, "This is a elementary primitive")

addTextLocale(INTEGR_CAN_BE_REWRITE_AS_ID,EN, "Interation can be rewritten as ")


addTextLocale(OR_ID,EN, "or")

addTextLocale(BORDER_UP_ID,EN, "Enter border up")

addTextLocale(BORDER_DOWN_ID,EN, "Enter border down")

addTextLocale(PROBABILITY_TITLE,EN, "Probabilities")

addTextLocale(ENTER_N_ID,EN, "Enter n=")

addTextLocale(ENTER_P_ID,EN, "Enter p=")

addTextLocale(AND_ID,EN, "and")

addTextLocale(FOR_ID,EN, "for")


addTextLocale(INVALID_PARAMETERS_ID,EN, "invalid parameters")

addTextLocale(EMPTY_ID,EN, " (Empty)")

addTextLocale(NOTHING_TO_DO_ID,EN, " (Nothing to do)")

addTextLocale(NOT_SUPPORTED_ID,EN, "Not supported yet")

addTextLocale(ENTER_BN_ID,EN, "entrer N=")


addTextLocale(ENTER_MU_ID,EN, "entrer "..c_mu.."=")


addTextLocale(ENTER_SIGMA_ID,EN, "entrer "..c_sigma.."=")


 
addTextLocale(CATEGORY_COMBINATOIRE_ID,EN,"Combinational")

addTextLocale(CATEGORY_COMBINATOIRE_DESC_ID,EN,"In discret case when we have equiprobability")

addTextLocale(CATEGORY_LOIS_DISCRETES_ID,EN,"discrete distributions")

addTextLocale(CATEGORY_LOIS_DISCRETES_DESC_ID,EN,"applications to solve the discrete distributions")

addTextLocale(CATEGORY_LOIS_CONTINUE_ID,EN,"applications to solve the continue distributions")

addTextLocale(IPP_TITLE_ID,EN,"Integration by parts")

addTextLocale(GREEK_TITLE_ID,EN,"Greek Alphabet")

addTextLocale(UTF8_TITLE_ID,EN,"UTF8 codes")
addTextLocale(CATEGORY_TEST_NORMALITE_ID,EN,"Test de normalité")
addTextLocale(CATEGORY_TEST_NORMALITE_DESC_ID,EN,"applications pour tester la normalité")


addTextLocale(ARRANGEMENT_AVEC_REP_TITLE_ID,EN,"Arrangements avec répétitions")
addTextLocale(ARRANGEMENT_AVEC_REP_HEADER_ID,EN,"Arrangements (suite ordonnée) avec répétitions : on a\n \\0el {Pn^p=n^p}\n")
addTextLocale(ARRANGEMENT_SANS_REP_TITLE_ID,EN,"Arrangements sans répétitions")
addTextLocale(ARRANGEMENT_SANS_REP_HEADER_ID,EN,"Arrangement(suite ordonnée) sans répétitions : on a\n \\0el {An^p=(n!)/(n-p)!}\n")
addTextLocale(PERMUTATION_AVEC_REP_TITLE_ID,EN,"Permutation avec p éléments identiques")
addTextLocale(PERMUTATION_AVEC_REP_HEADER_ID,EN,"Permutation avec répétitions(de n éléments avec p objetc identiques): on a\n \\0el {Pn^p=n!/p!}\n")
addTextLocale(PERMUTATION_SANS_REP_TITLE_ID,EN,"Permutation sans répétitions")
addTextLocale(PERMUTATION_SANS_REP_HEADER_ID,EN,"Permutation sans répétitions : on a\n \\0el {Pn=n!}\n")
addTextLocale(COMBINAISONS_AVEC_REP_TITLE_ID,EN,"Combinaisons avec répétitions")
addTextLocale(COMBINAISONS_AVEC_REP_HEADER_ID,EN,"Combinaisons(suite non ordonnée) avec répétition : on a\n \\0el {"..c_gama.."n^p=C(n+p-1)^p=[[n+p-1][p]]=(n+p-1)!/(p!*(n-1)!)}\n")
addTextLocale(COMBINAISONS_SANS_REP_TITLE_ID,EN,"Combinaisons sans répétitions")
addTextLocale(COMBINAISONS_SANS_REP_HEADER_ID,EN,"Combinaisons(suite non ordonnée) sans répétition : on a\n \\0el {Cn^p=[[n][p]]=An^p/p!=n!/(p!*(n-p)!)}\n")
addTextLocale(PARTITION_NON_ORD_TITLE_ID,EN,"Partition non ordonnée")
addTextLocale(PARTITION_NON_ORD_HEADER_ID,EN,"Partition non ordonnée : on a\n 1- par recurence \\0el {S(n,p)=S(n-1,p-1)+p*S(n-1,p)}\n2 - \\0el {S(n,p)=∑((−1)^((p-1))nCr(p,j)*j^(n),j,0,p)}\n")
addTextLocale(RESULT_WITH_RECURSIVE_STIRLING_ID,EN,"results with the recursive formule : ")
addTextLocale(LOI_BINOMIAL_1VAR_TITLE_ID,EN,"Loi binomial une va. (X) B(n,p)")
addTextLocale(LOI_BINOMIAL_1VAR_HEADER_ID,EN,"la somme de nvariables de Bernouilli ou la probabilité est p suit une loi binomial B(n,p).\nOn a \\0el {P(X=k)=Cn^k p^kq^(n-k)} avec q=1-p E(X)=np et V(X)=npq\n")
addTextLocale(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID,EN,"Loi hypergeometrique H(N,n,p)")
addTextLocale(LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=(CpN^k x CqN^(n-k))/CN^n} avec q=1-p \\0el {E(X)=n*p} et \\0el {V(X)=npq(N-n)/(N-1)}\n")
addTextLocale(LOI_UNIFORME_1VAR_TITLE_ID,EN,"Loi uniforme")
addTextLocale(LOI_UNIFORME_1VAR_HEADER_ID,EN,"\\0el {P(X=xi)=1/n} pour tous xi \\0el {E(X)=(n+1)/2} et \\0el {V(X)=(n^2-1)/12}\n")
addTextLocale(LOI_BERNOULLI_1VAR_TITLE_ID,EN,"Loi de Bernoulli")
addTextLocale(LOI_BERNOULLI_1VAR_HEADER_ID,EN,"\\0el {P(X=xi)=1/n} pour tous xi \\0el {E(X)=(n+1)/2} et \\0el {V(X)=(n^2-1)/12}\n")
addTextLocale(LOI_POISSON_1VAR_TITLE_ID,EN,"Loi de poisson")
addTextLocale(LOI_POISSON_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=("..c_lambda.."^k"..")} pour tous xi \\0el {E(X)=(n/p} et \\0el {V(X)=(nq)/p^2}\n")
addTextLocale(LOI_BINOMIAL_NEG_1VAR_TITLE_ID,EN,"Loi binomiale négative")
addTextLocale(LOI_BINOMIAL_NEG_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=C(k-1)^(n-1)p^nq^(k-n)} k>n \\0el {E(X)=(n/p} et \\0el {V(X)=(nq)/p^2}\n")
addTextLocale(LOI_GEOMETRIQUE_1VAR_TITLE_ID,EN,"Loi géométrique")
addTextLocale(LOI_GEOMETRIQUE_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=pq^(k-1)} \\0el {E(X)=1/p} et \\0el {V(X)=q/p^2}\n")
addTextLocale(LOI_NORMAL_1VAR_TITLE_ID,EN,"Loi Normal/de Gauss/Laplace-Gauss")
addTextLocale(LOI_NORMAL_1VAR_HEADER_ID,EN,"\\0el {f(x)=1/("..c_sigma..sqrt_sym.."(2*"..c_pi.."))*"..exp_sym.."^(1/2*((x-"..c_mu..")/("..c_sigma.."))^2)} \\0el {E(X)="..c_mu.."} et \\0el {V(X)="..c_sigma.."^2}\n")


 -- Including : C:\tiproject\finance\src\std\i18n\fr.lua


FR = 2
addLocale(FR,"fr", "français")

addTextLocale(ABOUT_TITLE_ID,FR,"A propos de Probabilités :")

addTextLocale(ABOUT_ID,FR,[[Probabilités v1.0
Faraj Meir
Merci à :
Jim Bauwens, Adrien "Adriweb" Bertrand
(inspiré de FormulaPro).
Licence LGPL3. Locale:]]..localeName..[[

conseil : Appuyé [Tab] pour les références !]])


addTextLocale(ERROR_TITLE_ID,FR,"Oops... Erreur intercepté !")

addTextLocale(ERROR_ID,FR,[[Probabilités à rencontré une erreur
désolé pour le désagrément.
veuillez reporter ce bug à meirfaraj@gmail.com
avec tous les détails à mfaraj@gmail.com.
 (bug à la line ]])
 
addTextLocale(BY_ID,FR,"par Faraj Meir")

addTextLocale(BACK_ID,FR," Retour")
addTextLocale(ENTER_FONCTION_ID,FR,"Entrer la fonction")
addTextLocale(CLOSE_ID,FR,"Fermer")
addTextLocale(ENTER_VAR_ID,FR,"Entrer la variable")
addTextLocale(ENTER_A_FUNC_TO_START_ID,FR,"Entrer une fonction pour commencer")
addTextLocale(FUNCTION_ID,FR,"Fonction : ")
addTextLocale(SOLVE_ID,FR,"Resolvons : ")
addTextLocale(DEMONSTRATION_ID,FR,"Demonstration")
addTextLocale(SINCE_ID,FR,"du fait que ")
addTextLocale(POLY_NOTHING_TO_DEM_ID,FR,"est un polynome l'integration est simple.")
addTextLocale(OPERATION_PLMN_INTEG_EXP_ID,FR,"comme on est face à une operation +/- on peut separer les integration à résoudre.")

addTextLocale(ELEMENTARY_PRIMITIVE_ID,FR,"C'est une primitive elementaire.")

addTextLocale(INTEGR_CAN_BE_REWRITE_AS_ID,FR,"l'integration peut etre réécrite ")
addTextLocale(OR_ID,FR,"ou")
addTextLocale(BORDER_UP_ID,FR,"Entrer intervalle haute")
addTextLocale(BORDER_DOWN_ID,FR, "Entrer intervalle basse")
addTextLocale(PROBABILITY_TITLE,FR, "Probabilités")

addTextLocale(ENTER_N_ID,FR, "entrer n=")
addTextLocale(ENTER_P_ID,FR, "entrer p=")
addTextLocale(AND_ID,FR, "et")
addTextLocale(FOR_ID,FR, "pour")
addTextLocale(INVALID_PARAMETERS_ID,FR, "parametres invalides")

addTextLocale(EMPTY_ID,FR, " (Vide)")
addTextLocale(NOTHING_TO_DO_ID,FR, " (Rien à faire)")
addTextLocale(NOT_SUPPORTED_ID,FR, "Pas encore supporté")

addTextLocale(ENTER_BN_ID,FR, "entrer N=")

addTextLocale(ENTER_MU_ID,FR, "entrer "..c_mu.."=")
addTextLocale(ENTER_SIGMA_ID,FR, "entrer "..c_sigma.."=")
addTextLocale(CATEGORY_COMBINATOIRE_ID,FR,"Combinatoire")
addTextLocale(CATEGORY_COMBINATOIRE_DESC_ID,FR,"Dans le cas discret avec une équiprobabilité => dénombrement")

addTextLocale(CATEGORY_LOIS_CONTINUE_DESC_ID,FR,"applications pour resoudre les lois continues")
addTextLocale(CATEGORY_LOIS_DISCRETES_ID,FR,"lois discrètes")
addTextLocale(CATEGORY_LOIS_DISCRETES_DESC_ID,FR,"applications pour resoudre les lois discrètes")
addTextLocale(IPP_TITLE_ID,FR,"Intégration par parties")
addTextLocale(GREEK_TITLE_ID,FR,"Alphabet grec")
addTextLocale(UTF8_TITLE_ID,FR,"Code UTF8")
addTextLocale(CATEGORY_TEST_NORMALITE_ID,FR,"Test de normalité")
addTextLocale(CATEGORY_TEST_NORMALITE_DESC_ID,FR,"applications pour tester la normalité")


addTextLocale(ARRANGEMENT_AVEC_REP_TITLE_ID,FR,"Arrangements avec répétitions")

addTextLocale(ARRANGEMENT_AVEC_REP_HEADER_ID,FR,"Arrangements (suite ordonnée) avec répétitions : on a\n \\0el {Pn^p=n^p}\n")

addTextLocale(ARRANGEMENT_SANS_REP_TITLE_ID,FR,"Arrangements sans répétitions")

addTextLocale(ARRANGEMENT_SANS_REP_HEADER_ID,FR,"Arrangement(suite ordonnée) sans répétitions : on a\n \\0el {An^p=(n!)/(n-p)!}\n")


addTextLocale(PERMUTATION_AVEC_REP_TITLE_ID,FR,"Permutation avec p éléments identiques")
addTextLocale(PERMUTATION_AVEC_REP_HEADER_ID,FR,"Permutation avec répétitions(de n éléments avec p objetc identiques): on a\n \\0el {Pn^p=n!/p!}\n")

addTextLocale(PERMUTATION_SANS_REP_TITLE_ID,FR,"Permutation sans répétitions")
addTextLocale(PERMUTATION_SANS_REP_HEADER_ID,FR,"Permutation sans répétitions : on a\n \\0el {Pn=n!}\n")

addTextLocale(COMBINAISONS_AVEC_REP_TITLE_ID,FR,"Combinaisons avec répétitions")
addTextLocale(COMBINAISONS_AVEC_REP_HEADER_ID,FR,"Combinaisons(suite non ordonnée) avec répétition : on a\n \\0el {"..c_gama.."n^p=C(n+p-1)^p=[[n+p-1][p]]=(n+p-1)!/(p!*(n-1)!)}\n")


addTextLocale(COMBINAISONS_SANS_REP_TITLE_ID,FR,"Combinaisons sans répétitions")
addTextLocale(COMBINAISONS_SANS_REP_HEADER_ID,FR,"Combinaisons(suite non ordonnée) sans répétition : on a\n \\0el {Cn^p=[[n][p]]=An^p/p!=n!/(p!*(n-p)!)}\n")


addTextLocale(PARTITION_NON_ORD_TITLE_ID,FR,"Partition non ordonnée")
addTextLocale(PARTITION_NON_ORD_HEADER_ID,FR,"Partition non ordonnée : on a\n 1- par recurence \\0el {S(n,p)=S(n-1,p-1)+p*S(n-1,p)}\n2 - \\0el {S(n,p)=∑((−1)^((p-1))nCr(p,j)*j^(n),j,0,p)}\n")

addTextLocale(RESULT_WITH_RECURSIVE_STIRLING_ID,FR,"resultat par recurence en utilisant :\\0el {S(n,p)=S(n-1,p-1)+p*S(n-1,p)}")
 
 
addTextLocale(LOI_BINOMIAL_1VAR_TITLE_ID,FR,"Loi binomial une va. (X) B(n,p)")

addTextLocale(LOI_BINOMIAL_1VAR_HEADER_ID,FR,"la somme de nvariables de Bernouilli ou la probabilité est p suit une loi binomial B(n,p).\nOn a \\0el {P(X=k)=Cn^k p^kq^(n-k)} avec q=1-p E(X)=np et V(X)=npq\n")
 
addTextLocale(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID,FR,"Loi hypergeometrique H(N,n,p)")
addTextLocale(LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID,FR,"\\0el {P(X=k)=(CpN^k x CqN^(n-k))/CN^n} avec q=1-p \\0el {E(X)=n*p} et \\0el {V(X)=npq(N-n)/(N-1)}\n")

 
addTextLocale(LOI_UNIFORME_1VAR_TITLE_ID,FR,"Loi uniforme")
addTextLocale(LOI_UNIFORME_1VAR_HEADER_ID,FR,"\\0el {P(X=xi)=1/n} pour tous xi \\0el {E(X)=(n+1)/2} et \\0el {V(X)=(n^2-1)/12}\n")

 addTextLocale(LOI_BERNOULLI_1VAR_TITLE_ID,FR,"Loi de Bernoulli")

addTextLocale(LOI_BERNOULLI_1VAR_HEADER_ID,FR,"\\0el {P(X=xi)=1/n} pour tous xi \\0el {E(X)=(n+1)/2} et \\0el {V(X)=(n^2-1)/12}\n")


addTextLocale(LOI_POISSON_1VAR_TITLE_ID,FR,"Loi de poisson")

addTextLocale(LOI_POISSON_1VAR_HEADER_ID,FR,"\\0el {P(X=k)=1/n} pour tous xi \\0el {E(X)=(n/p} et \\0el {V(X)=(nq)/p^2}\n")

addTextLocale(LOI_BINOMIAL_NEG_1VAR_TITLE_ID,FR,"Loi binomiale négative")

addTextLocale(LOI_BINOMIAL_NEG_1VAR_HEADER_ID,FR,"\\0el {P(X=k)=C(k-1)^(n-1)p^nq^(k-n)} k>n \\0el {E(X)=(n/p} et \\0el {V(X)=(nq)/p^2}\n")

addTextLocale(LOI_GEOMETRIQUE_1VAR_TITLE_ID,FR,"Loi géométrique")

addTextLocale(LOI_GEOMETRIQUE_1VAR_HEADER_ID,FR,"\\0el {P(X=k)=pq^(k-1)} \\0el {E(X)=1/p} et \\0el {V(X)=q/p^2}\n")


addTextLocale(LOI_NORMAL_1VAR_TITLE_ID,FR,"Normal distribution")

addTextLocale(LOI_NORMAL_1VAR_HEADER_ID,FR,"\\0el {f(x)=1/("..c_sigma..sqrt_sym.."(2*"..c_pi.."))*"..exp_sym.."^(1/2*((x-"..c_mu..")/("..c_sigma.."))^2)} \\0el {E(X)="..c_mu.."} et \\0el {V(X)="..c_sigma.."^2}\n")
 


curLocaleId = ASLocaleId(localeName)


 
local aboutstr	= ASTxt(ABOUT_ID)

 -- Including : C:\tiproject\finance\src\std\utils.lua


function instanceOf (subject, super)
 
  super = tostring(super)
  local mt = getmetatable(subject)
 
  while true do
    if mt == nil then return false end
    if tostring(mt) == super then return true end
 
    mt = getmetatable(mt)
  end 
end

function isSameType (subject, super)
  local mt = getmetatable(super)
  local mt2 = getmetatable(subject)
  return tostring(mt)==tostring(mt2)
end

function addExtension(oldclass, extension)
  local newclass  = class(oldclass)
  for key, data in pairs(extension) do
    newclass[key] = data
  end
  return newclass
end

function Pr(n, d, s, ex)
  local nc  = tonumber(n)
  if ex and nc and nc<math.abs(nc) then
    return s-ex-(type(n)== "number" and math.abs(n) or (.01*s*math.abs(nc)))
  else
    return (type(n)=="number" and n or (type(n)=="string" and .01*s*nc or d))
  end
end


 -- Including : C:\tiproject\finance\src\ui\catutils.lua



function checkIfExists(table, name)
    for k,v in pairs(table) do
        if (v.name == name) or (v == name) then
            print("Conflict (i.e elements appearing twice) detected when loading Database. Skipping the item.")
            return true
        end
    end
    return false
end

function checkIfFormulaExists(table, formula)
    for k,v in pairs(table) do
        if (v.formula == formula)  then -- lulz lua powa
            print("Conflict (i.e formula appearing twice) detected when loading Database. Skipping formula.")
            return true
        end
    end
    return false
end
	

	
Constants	= {}
Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
    if checkIfExists(Categories, name) then
        print("Warning ! This category appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories, id, {id=id, name=name, info=info, sub={}, varlink={}})
end

function addCatVar(cid, var, info, unit)
    Categories[cid].varlink[var] = {unit=unit, info=info }
end

function addSubCat(cid, id, name, info)
    if checkIfExists(Categories[cid].sub, name) then
        print("Warning ! This subcategory appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}})
end

function addSubCatScreen(cid, id, name, info, screen)
    if checkIfExists(Categories[cid].sub, name) then
        print("Warning ! This subcategory appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}, screen=screen})
end


function aF(cid, sid, formula, variables) --add Formula
	local fr	=	{category=cid, sub=sid, formula=formula, variables=variables}

        table.insert(Formulas, fr)
    if not checkIfFormulaExists(Categories[cid].sub[sid].formulas, fr.formula) then
        table.insert(Categories[cid].sub[sid].formulas, fr)
    end
	
	for variable,_ in pairs(variables) do
		Categories[cid].sub[sid].variables[variable]	= true
	end
end

function U(...)
	local out	= {}
	for i, p in ipairs({...}) do
		out[p]	= true
	end
	return out
end

 -- Including : C:\tiproject\finance\src\ui\gcutils.lua


Color = {
    ["black"] = { 0, 0, 0 },
    ["red"] = { 255, 0, 0 },
    ["green"] = { 0, 255, 0 },
    ["blue "] = { 0, 0, 255 },
    ["white"] = { 255, 255, 255 },
    ["brown"] = { 165, 42, 42 },
    ["cyan"] = { 0, 255, 255 },
    ["darkblue"] = { 0, 0, 139 },
    ["darkred"] = { 139, 0, 0 },
    ["fuchsia"] = { 255, 0, 255 },
    ["gold"] = { 255, 215, 0 },
    ["gray"] = { 127, 127, 127 },
    ["grey"] = { 127, 127, 127 },
    ["lightblue"] = { 173, 216, 230 },
    ["lightgreen"] = { 144, 238, 144 },
    ["magenta"] = { 255, 0, 255 },
    ["maroon"] = { 128, 0, 0 },
    ["navyblue"] = { 159, 175, 223 },
    ["orange"] = { 255, 165, 0 },
    ["palegreen"] = { 152, 251, 152 },
    ["pink"] = { 255, 192, 203 },
    ["purple"] = { 128, 0, 128 },
    ["royalblue"] = { 65, 105, 225 },
    ["salmon"] = { 250, 128, 114 },
    ["seagreen"] = { 46, 139, 87 },
    ["silver"] = { 192, 192, 192 },
    ["turquoise"] = { 64, 224, 208 },
    ["violet"] = { 238, 130, 238 },
    ["yellow"] = { 255, 255, 0 }
}
Color.mt = { __index = function() return { 0, 0, 0 } end }
setmetatable(Color,Color.mt)

function copyTable(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function deepcopy(t) -- This function recursively copies a table's contents, and ensures that metatables are preserved. That is, it will correctly clone a pure Lua object.
	if type(t) ~= 'table' then return t end
	local mt = getmetatable(t)
	local res = {}
	for k,v in pairs(t) do
		if type(v) == 'table' then
		v = deepcopy(v)
		end
	res[k] = v
	end
	setmetatable(res,mt)
	return res
end -- from http://snippets.luacode.org/snippets/Deep_copy_of_a_Lua_Table_2



function screenRefresh()
	return platform.window:invalidate()
end

function pww()
	return platform.window:width()
end

function pwh()
	return platform.window:height()
end

function drawPoint(gc, x, y)
	gc:fillRect(x, y, 1, 1)
end

function drawCircle(gc, x, y, diameter)
	gc:drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

function drawCenteredString(gc, str)
	gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), .5*pwh(), "middle")
end

function drawXCenteredString(gc, str, y)
	gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), y, "top")
end

function setColor(gc,theColor)
	if type(theColor) == "string" then
		theColor = string.lower(theColor)
		if type(Color[theColor]) == "table" then gc:setColorRGB(unpack(Color[theColor])) end
	elseif type(theColor) == "table" then
		gc:setColorRGB(unpack(theColor))
	end
end

function verticalBar(gc,x)
	gc:fillRect(gc,x,0,1,pwh())
end

function horizontalBar(gc,y)
	gc:fillRect(gc,0,y,pww(),1)
end

function nativeBar(gc, screen, y)
	gc:setColorRGB(128,128,128)
	gc:fillRect(screen.x+5, screen.y+y, screen.w-10, 2)
end

function drawSquare(gc,x,y,l)
	gc:drawPolyLine(gc,{(x-l/2),(y-l/2), (x+l/2),(y-l/2), (x+l/2),(y+l/2), (x-l/2),(y+l/2), (x-l/2),(y-l/2)})
end

function drawRoundRect(gc,x,y,wd,ht,rd)  -- wd = width, ht = height, rd = radius of the rounded corner
	x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same for y coord
	if rd > ht/2 then rd = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max rd)
	gc:drawLine(x + rd, y, x + wd - (rd), y);
	gc:drawArc(x + wd - (rd*2), y + ht - (rd*2), rd*2, rd*2, 270, 90);
	gc:drawLine(x + wd, y + rd, x + wd, y + ht - (rd));
	gc:drawArc(x + wd - (rd*2), y, rd*2, rd*2,0,90);
	gc:drawLine(x + wd - (rd), y + ht, x + rd, y + ht);
	gc:drawArc(x, y, rd*2, rd*2, 90, 90);
	gc:drawLine(x, y + ht - (rd), x, y + rd);
	gc:drawArc(x, y + ht - (rd*2), rd*2, rd*2, 180, 90);
end

function fillRoundRect(gc,x,y,wd,ht,radius)  -- wd = width and ht = height -- renders badly when transparency (alpha) is not at maximum >< will re-code later
	if radius > ht/2 then radius = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
    gc:fillPolygon({(x-wd/2),(y-ht/2+radius), (x+wd/2),(y-ht/2+radius), (x+wd/2),(y+ht/2-radius), (x-wd/2),(y+ht/2-radius), (x-wd/2),(y-ht/2+radius)})
    gc:fillPolygon({(x-wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y+ht/2), (x-wd/2+radius),(y+ht/2), (x-wd/2+radius),(y-ht/2)})
    x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same
	gc:fillArc(x + wd - (radius*2), y + ht - (radius*2), radius*2, radius*2, 1, -91);
    gc:fillArc(x + wd - (radius*2), y, radius*2, radius*2,-2,91);
    gc:fillArc(x, y, radius*2, radius*2, 85, 95);
    gc:fillArc(x, y + ht - (radius*2), radius*2, radius*2, 180, 95);
end

function textLim(gc, text, max)
	local ttext, out = "",""
	local width	= gc:getStringWidth(text)
	if width<max then
		return text, width
	else
		for i=1, #text do
			ttext	= text:usub(1, i)
			if gc:getStringWidth(ttext .. "..")>max then
				break
			end
			out = ttext
		end
		return out .. "..", gc:getStringWidth(out .. "..")
	end
end

 -- Including : C:\tiproject\finance\src\proba\categories.lua



 -- Including : C:\tiproject\finance\src\proba\..\ui\screen.lua




 -- Including : C:\tiproject\finance\src\ui\fullscreen.lua



local pw	= getmetatable(platform.window)
function pw:invalidateAll()
	if self.setFocus then
		self:setFocus(false)
		self:setFocus(true)
	end
end

function on.draw(gc)
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(18, 5, 20, 20)
end

if not platform.withGC then
    function platform.withGC(func, ...)
        local gc = platform.gc()
        gc:begin()
        func(..., gc)
        gc:finish()
    end
end



local tstart = timer.start
function timer.start(ms)
    if not timer.isRunning then
        tstart(ms)
    end
    timer.isRunning = true
end

local tstop = timer.stop
function timer.stop()
    timer.isRunning = false
    tstop()
end


if platform.hw then
    timer.multiplier = platform.hw() < 4 and 3.2 or 1
else
    timer.multiplier = platform.isDeviceModeRendering() and 3.2 or 1
end

function on.timer()
    local j = 1
    while j <= #timer.tasks do -- for each task
        if timer.tasks[j][2]() then -- delete it if has ended
            table.remove(timer.tasks, j)
            sj = j - 1
        end
        j = j + 1
    end
    if #timer.tasks > 0 then
        platform.window:invalidate()
    else
        timer.stop()
    end
end

timer.tasks = {}

timer.addTask = function(object, task) timer.start(0.01) table.insert(timer.tasks, { object, task }) end

function timer.purgeTasks(object)
    local j = 1
    while j <= #timer.tasks do
        if timer.tasks[j][1] == object then
            table.remove(timer.tasks, j)
            j = j - 1
        end
        j = j + 1
    end
end


Object = class()
function Object:init(x, y, w, h, r)
    self.tasks = {}
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r = r
    self.visible = true
end

function Object:PushTask(task, t, ms, callback)
    table.insert(self.tasks, { task, t, ms, callback })
    timer.start(0.01)
    if #self.tasks == 1 then
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:PopTask()
    table.remove(self.tasks, 1)
    if #self.tasks > 0 then
        local task, t, ms, callback = unpack(self.tasks[1])
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:purgeTasks()
    for i = 1, #self.tasks do
        self.tasks[i] = nil
    end
    collectgarbage()
    timer.purgeTasks(self)
    self.tasks = {}
    return self
end

function Object:paint(gc)
end

speed = 1

function Object:__Animate(t, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    if not t or type(t) ~= "table" then print("Error: Target position is " .. type(t)) return end
    if not t.x then t.x = self.x end
    if not t.y then t.y = self.y end
    if not t.w then t.w = self.w end
    if not t.h then t.h = self.h end
    if not t.r then t.r = self.r else t.r = math.pi * t.r / 180 end
    local xinc = (t.x - self.x) / ms
    local xside = xinc >= 0 and 1 or -1
    local yinc = (t.y - self.y) / ms
    local yside = yinc >= 0 and 1 or -1
    local winc = (t.w - self.w) / ms
    local wside = winc >= 0 and 1 or -1
    local hinc = (t.h - self.h) / ms
    local hside = hinc >= 0 and 1 or -1
    local rinc = (t.r - self.r) / ms
    local rside = rinc >= 0 and 1 or -1
    timer.addTask(self, function()
        local b1, b2, b3, b4, b5 = false, false, false, false, false
        if (self.x + xinc * speed) * xside < t.x * xside then self.x = self.x + xinc * speed else b1 = true end
        if self.y * yside < t.y * yside then self.y = self.y + yinc * speed else b2 = true end
        if self.w * wside < t.w * wside then self.w = self.w + winc * speed else b3 = true end
        if self.h * hside < t.h * hside then self.h = self.h + hinc * speed else b4 = true end
        if self.r * rside < t.r * rside then self.r = self.r + rinc * speed else b5 = true end
        if self.w < 0 then self.w = 0 end
        if self.h < 0 then self.h = 0 end
        if b1 and b2 and b3 and b4 and b5 then
            self.x, self.y, self.w, self.h, self.r = t.x, t.y, t.w, t.h, t.r
            self:PopTask()
            if callback then callback(self) end
            return true
        end
        return false
    end)
    return true
end

function Object:__Delay(_, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    local t = 0
    timer.addTask(self, function()
        if t < ms then
            t = t + 1
            return false
        else
            self:PopTask()
            if callback then callback(self) end
            return true
        end
    end)
    return true
end

function Object:__setVisible(t, _, _)
    timer.addTask(self, function()
        self.visible = t
        self:PopTask()
        return true
    end)
    return true
end

function Object:Animate(t, ms, callback)
    self:PushTask(self.__Animate, t, ms, callback)
    return self
end

function Object:Delay(ms, callback)
    self:PushTask(self.__Delay, false, ms, callback)
    return self
end

function Object:setVisible(t)
    self:PushTask(self.__setVisible, t, 1, false)
    return self
end


stdout	= print

function pprint(...)
	stdout(...)
	local out	= ""
	for _,v in ipairs({...}) do 
		out	=	out .. (_==1 and "" or "    ") .. tostring(v)
	end
	var.store("print", out)
end



clipRectData	= {}

function gc_clipRect(gc, what, x, y, w, h)
	if what == "set" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		
	elseif what == "subset" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		x	= clipRectData.old.x<x and x or clipRectData.old.x
		y	= clipRectData.old.y<y and y or clipRectData.old.y
		h	= clipRectData.old.y+clipRectData.old.h > y+h and h or clipRectData.old.y+clipRectData.old.h-y
		w	= clipRectData.old.x+clipRectData.old.w > x+w and w or clipRectData.old.x+clipRectData.old.w-x
		what = "set"
		
	elseif what == "restore" and clipRectData.old then
		what = "set"
		x	= clipRectData.old.x
		y	= clipRectData.old.y
		h	= clipRectData.old.h
		w	= clipRectData.old.w
	elseif what == "restore" then
		what = "reset"
	end
	
	gc:clipRect(what, x, y, w, h)
	if x and y and w and h then clipRectData.current = {x=x,y=y,w=w,h=h} end
end

Screen	=	class(Object)

Screens	=	{}

function scrollScreen(screen, d, callback)
    local dir = d or 1
    screen.x=dir*kXSize
    screen:Animate( {x=0}, 10, callback )
end

function insertScreen(screen, ...)
	screen:size()
    if current_screen() ~= DummyScreen then
        current_screen():screenLoseFocus()
        local coeff = pushFromBack and 1 or -1
	    current_screen():Animate( {x=coeff*kXSize}, 10)
    end
	table.insert(Screens, screen)

	platform.window:invalidate()
	current_screen():pushed(...)
end

function insertScreen_direct(screen, ...)
	screen:size()
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function push_screen(screen, ...)
    local args = ...
    local theScreen = current_screen()
    pushFromBack = false
    insertScreen(screen, ...)
    scrollScreen(screen, 1, function() remove_screen_previous(theScreen) end)
end

function push_screen_back(screen, ...)
    local theScreen = current_screen()
    pushFromBack = true
    insertScreen(screen, ...)
    scrollScreen(screen, -1, function() remove_screen_previous(theScreen) end)
end

function push_screen_direct(screen, ...)
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function only_screen(screen, ...)
    remove_screen(current_screen())
	Screens	=	{}
	push_screen(screen, ...)
	platform.window:invalidate()
end

function only_screen_back(screen, ...)
	push_screen_back(screen, ...)
	platform.window:invalidate()
end

function remove_screen_previous(...)
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens, #Screens-1)
	current_screen():screenGetFocus()
	return res
end

function remove_screen(...)
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens)
	current_screen():screenGetFocus()
	return res
end

function current_screen()
	return Screens[#Screens] or DummyScreen
end

function Screen:init(xx,yy,ww,hh)

	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	self:ext()
	self:size(0)
	
	Object.init(self, self.x, self.y, self.w, self.h, 0)
end

function Screen:ext()
end

function Screen:size()
	local screenH	=	platform.window:height()
	local screenW	=	platform.window:width()

	if screenH	== 0 then screenH=212 end
	if screenW	== 0 then screenW=318 end

	self.x	=	math.floor(Pr(self.xx, 0, screenW)+.5)
	self.y	=	math.floor(Pr(self.yy, 0, screenH)+.5)
	self.w	=	math.floor(Pr(self.ww, screenW, screenW, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, screenH, screenH, 0)+.5)
end


function Screen:pushed() end
function Screen:removed() end
function Screen:screenLoseFocus() end
function Screen:screenGetFocus() end

function Screen:draw(gc)
	self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey(arrow)	end
function Screen:enterKey()	end
function Screen:backspaceKey()	end
function Screen:clearKey() 	end
function Screen:escapeKey()	end
function Screen:tabKey()	end
function Screen:backtabKey()	end
function Screen:charIn(char)	end


function Screen:mouseDown()	end
function Screen:mouseUp()	end
function Screen:mouseMove()	end
function Screen:contextMenu()	end

function Screen:appended() end

function Screen:resize(w,h) end

function Screen:destroy()
	self	= nil
end

 -- Including : C:\tiproject\finance\src\proba\..\ui\math\combinatoire\combinatoire.lua

 

 -- Including : C:\tiproject\finance\src\ui\widgets\widgets.lua



 -- Including : C:\tiproject\finance\src\ui\widgets\widgetmanager.lua



WidgetManager	= {}

function WidgetManager:ext()
	self.widgets	=	{}
	self.focus	=	0
end

function WidgetManager:resize(w,h)
    if self.x then  --already inited
        self:size()
    end
end

function WidgetManager:moveWidget(widget, xx, yy) 
	widget.xx	=	xx
	widget.yy	=	yy
	widget.parent	=	self
	widget:size()
	return self
end

function WidgetManager:appendWidget(widget, xx, yy) 
	widget.xx	=	xx
	widget.yy	=	yy
	widget.parent	=	self
	widget:size()
	
	table.insert(self.widgets, widget)
	widget.pid	=	#self.widgets
	
	widget:appended(self)
	return self
end

function WidgetManager:getWidget()
	return self.widgets[self.focus]
end

function WidgetManager:drawWidgets(gc) 
  local i=1
	for _, widget in pairs(self.widgets) do
		widget:size()
		widget:draw(gc)
		
		gc:setColorRGB(0,0,0)
		i=i+1
	end
end

function WidgetManager:postPaint(gc) 
end

function WidgetManager:draw(gc)
	self:paint(gc)
	self:drawWidgets(gc)
	self:postPaint(gc)
end


function WidgetManager:loop(n) end

function WidgetManager:stealFocus(n)
	local oldfocus=self.focus
	if oldfocus~=0 then
		local veto	= self:getWidget():loseFocus(n)
		if veto == -1 then
			return -1, oldfocus
		end
		self:getWidget().hasFocus	=	false
		self.focus	= 0
	end
	return 0, oldfocus
end

function WidgetManager:focusChange() end

function WidgetManager:switchFocus(n, b)
	if n~=0 and #self.widgets>0 then
		local veto, focus	= self:stealFocus(n)
		if veto == -1 then
			return -1
		end
		
		local looped
		self.focus	=	focus + n
		if self.focus>#self.widgets then
			self.focus	=	1
			looped	= true
		elseif self.focus<1 then
			self.focus	=	#self.widgets
			looped	= true
		end	
		if looped and self.noloop and not b then
			self.focus	= focus
			self:loop(n)
		else
			self:getWidget().hasFocus	=	true	
			self:getWidget():getFocus(n)
		end
	end
	self:focusChange()
end


function WidgetManager:arrowKey(arrow)	
	if self.focus~=0 then
		self:getWidget():arrowKey(arrow)
	end
	self:invalidate()
end

function WidgetManager:enterKey()
    if self.focus~=0 then
        self:getWidget():enterKey()
    else
        if self.widgets and self.widgets[1] then   -- ugh, quite a bad hack for the mouseUp at (0,0) when cursor isn't shown (grrr TI) :/
            self.widgets[1]:enterKey()
        end
    end
    self:invalidate()
end


function WidgetManager:onErrorDispStart() 
  if self.focus~=0 then
        self:getWidget():onErrorDispStart()
    else
        if self.widgets and self.widgets[1] then   -- ugh, quite a bad hack for the mouseUp at (0,0) when cursor isn't shown (grrr TI) :/
            self.widgets[1]:onErrorDispStart()
        end
    end
    self:invalidate()
end

function WidgetManager:onErrorDispEnd() 
  if self.focus~=0 then
        self:getWidget():onErrorDispEnd()
    else
        if self.widgets and self.widgets[1] then   -- ugh, quite a bad hack for the mouseUp at (0,0) when cursor isn't shown (grrr TI) :/
            self.widgets[1]:onErrorDispEnd()
        end
    end
    self:invalidate()
end

function WidgetManager:clearKey()	
	if self.focus~=0 then
		self:getWidget():clearKey()
	end
	self:invalidate()
end

function WidgetManager:backspaceKey()
	if self.focus~=0 then
		self:getWidget():backspaceKey()
	end
	self:invalidate()
end

function WidgetManager:escapeKey()	
	if self.focus~=0 then
		self:getWidget():escapeKey()
	end
	self:invalidate()
end

function WidgetManager:tabKey()	
	self:switchFocus(1)
	self:invalidate()
end

function WidgetManager:backtabKey()	
	self:switchFocus(-1)
	self:invalidate()
end

function WidgetManager:charIn(char)
	if self.focus~=0 then
		self:getWidget():charIn(char)
	end
	self:invalidate()
end

function WidgetManager:getWidgetIn(x, y)
	for n, widget in pairs(self.widgets) do
		local wox	= widget.ox or 0
		local woy	= widget.oy or 0
		if x>=widget.x-wox and y>=widget.y-wox and x<widget.x+widget.w-wox and y<widget.y+widget.h-woy then
			return n, widget
		end
	end 
end

function WidgetManager:mouseDown(x, y) 
	local n, widget	=	self:getWidgetIn(x, y)
	if n then
		if self.focus~=0 and self.focus~=n then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	n
		
		widget.hasFocus	=	true
		widget:getFocus()

		widget:mouseDown(x, y)
		self:focusChange()
	else
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus() end
		self.focus	=	0
	end
end

function WidgetManager:mouseUp(x, y)
    if self.focus~=0 then
    end
    for _, widget in pairs(self.widgets) do
        widget:mouseUp(x,y) -- well, mouseUp is a release of a button, so everything previously "clicked" should be released, for every widget, even if the mouse has moved (and thus changed widget)
    end
    self:invalidate()
end

function WidgetManager:mouseMove(x, y)
	if self.focus~=0 then
		self:getWidget():mouseMove(x, y)
	end
end





 -- Including : C:\tiproject\finance\src\ui\dialog.lua



 -- Including : C:\tiproject\finance\src\ui\wscreen.lua



 -- Including : C:\tiproject\finance\src\ui\screen.lua




Screen	=	class(Object)

Screens	=	{}

function scrollScreen(screen, d, callback)
    local dir = d or 1
    screen.x=dir*kXSize
    screen:Animate( {x=0}, 10, callback )
end

function insertScreen(screen, ...)
	screen:size()
    if current_screen() ~= DummyScreen then
        current_screen():screenLoseFocus()
        local coeff = pushFromBack and 1 or -1
	    current_screen():Animate( {x=coeff*kXSize}, 10)
    end
	table.insert(Screens, screen)

	platform.window:invalidate()
	current_screen():pushed(...)
end

function insertScreen_direct(screen, ...)
	screen:size()
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function push_screen(screen, ...)
    local args = ...
    local theScreen = current_screen()
    pushFromBack = false
    insertScreen(screen, ...)
    scrollScreen(screen, 1, function() remove_screen_previous(theScreen) end)
end

function push_screen_back(screen, ...)
    local theScreen = current_screen()
    pushFromBack = true
    insertScreen(screen, ...)
    scrollScreen(screen, -1, function() remove_screen_previous(theScreen) end)
end

function push_screen_direct(screen, ...)
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function only_screen(screen, ...)
    remove_screen(current_screen())
	Screens	=	{}
	push_screen(screen, ...)
	platform.window:invalidate()
end

function only_screen_back(screen, ...)
	push_screen_back(screen, ...)
	platform.window:invalidate()
end

function remove_screen_previous(...)
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens, #Screens-1)
	current_screen():screenGetFocus()
	return res
end

function remove_screen(...)
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens)
	current_screen():screenGetFocus()
	return res
end

function current_screen()
	return Screens[#Screens] or DummyScreen
end

function Screen:init(xx,yy,ww,hh)

	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	self:ext()
	self:size(0)
	
	Object.init(self, self.x, self.y, self.w, self.h, 0)
end

function Screen:ext()
end

function Screen:size()
	local screenH	=	platform.window:height()
	local screenW	=	platform.window:width()

	if screenH	== 0 then screenH=212 end
	if screenW	== 0 then screenW=318 end

	self.x	=	math.floor(Pr(self.xx, 0, screenW)+.5)
	self.y	=	math.floor(Pr(self.yy, 0, screenH)+.5)
	self.w	=	math.floor(Pr(self.ww, screenW, screenW, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, screenH, screenH, 0)+.5)
end


function Screen:pushed() end
function Screen:removed() end
function Screen:screenLoseFocus() end
function Screen:screenGetFocus() end

function Screen:draw(gc)
	self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey(arrow)	end
function Screen:enterKey()	end
function Screen:backspaceKey()	end
function Screen:clearKey() 	end
function Screen:escapeKey()	end
function Screen:tabKey()	end
function Screen:backtabKey()	end
function Screen:charIn(char)	end


function Screen:mouseDown()	end
function Screen:mouseUp()	end
function Screen:mouseMove()	end
function Screen:contextMenu()	end

function Screen:appended() end

function Screen:resize(w,h) end

function Screen:destroy()
	self	= nil
end

WScreen = addExtension(Screen, WidgetManager)

Dialog	=	class(WScreen)

function Dialog:init(title,xx,yy,ww,hh)

	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	self.title	=	title
	self:size()
	
	self.widgets	=	{}
	self.focus	=	0
	    
end

function Dialog:paint(gc)
	self.xx	= (pww()-self.w)/2
	self.yy	= (pwh()-self.h)/2
	self.x, self.y	= self.xx, self.yy
	
	gc:setFont("sansserif","r",10)
	gc:setColorRGB(224,224,224)
	gc:fillRect(self.x, self.y, self.w, self.h)

	for i=1, 14,2 do
		gc:setColorRGB(32+i*3, 32+i*4, 32+i*3)
		gc:fillRect(self.x, self.y+i, self.w,2)
	end
	gc:setColorRGB(32+16*3, 32+16*4, 32+16*3)
	gc:fillRect(self.x, self.y+15, self.w, 10)
	
	gc:setColorRGB(128,128,128)
	gc:drawRect(self.x, self.y, self.w, self.h)
	gc:drawRect(self.x-1, self.y-1, self.w+2, self.h+2)
	
	gc:setColorRGB(96,100,96)
	gc:fillRect(self.x+self.w+1, self.y, 1, self.h+2)
	gc:fillRect(self.x, self.y+self.h+2, self.w+3, 1)
	
	gc:setColorRGB(104,108,104)
	gc:fillRect(self.x+self.w+2, self.y+1, 1, self.h+2)
	gc:fillRect(self.x+1, self.y+self.h+3, self.w+3, 1)
	gc:fillRect(self.x+self.w+3, self.y+2, 1, self.h+2)
	gc:fillRect(self.x+2, self.y+self.h+4, self.w+2, 1)
			
	gc:setColorRGB(255,255,255)
	gc:drawString(self.title, self.x + 4, self.y+2, "top")
	
	self:postPaint(gc)
end

function Dialog:postPaint() end



DummyScreen	= Screen()

Widget	=	class(Screen)

function Widget:init()
	self.dw	=	10
	self.dh	=	10
	
	self:ext()
end

function Widget:setSize(w, h)
	self.ww	= w or self.ww
	self.hh	= h or self.hh
end

function Widget:setPos(x, y)
	self.xx	= x or self.xx
	self.yy	= y or self.yy
end

function Widget:size(n)
	if n then return end
	self.w	=	math.floor(Pr(self.ww, self.dw, self.parent.w, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, self.dh, self.parent.h, 0)+.5)
	
	self.rx	=	math.floor(Pr(self.xx, 0, self.parent.w, self.w)+.5)
	self.ry	=	math.floor(Pr(self.yy, 0, self.parent.h, self.h)+.5)
	self.x	=	self.parent.x + self.rx
	self.y	=	self.parent.y + self.ry
end

function Widget:giveFocus()
	if self.parent.focus~=0 then
		local veto	= self.parent:stealFocus()
		if veto == -1 then
			return -1
		end		
	end
	
	self.hasFocus	=	true
	self.parent.focus	=	self.pid
	self:getFocus()
end

function Widget:getFocus() end
function Widget:loseFocus() end
function Widget:clearKey() 	end

function Widget:enterKey() 
	self.parent:switchFocus(1)
end


function Widget:onErrorDispStart() 
end

function Widget:onErrorDispEnd() 
end

function Widget:arrowKey(arrow)
	if arrow=="up" then 
		self.parent:switchFocus(self.focusUp or -1)
	elseif arrow=="down"  then
		self.parent:switchFocus(self.focusDown or 1)
	elseif arrow=="left" then 
		self.parent:switchFocus(self.focusLeft or -1)
	elseif arrow=="right"  then
		self.parent:switchFocus(self.focusRight or 1)	
	end
end


WWidget	= addExtension(Widget, WidgetManager)



 -- Including : C:\tiproject\finance\src\ui\widgets\sinputwidget.lua



sInput	=	class(Widget)

function sInput:init()
	self.dw	=	100
	self.dh	=	20
	
	self.value	=	""	
	self.bgcolor	=	{255,255,255}
	self.disabledcolor	= {128,128,128}
	self.font	=	{"sansserif", "r", 10}
	self.disabled	= false
end

function sInput:setWidth(width)
  self.dw = width
  self:invalidate()
end


function sInput:paint(gc)
	self.gc	=	gc
	local x	=	self.x
	local y = 	self.y
	
	gc:setFont(uCol(self.font))
	gc:setColorRGB(uCol(self.bgcolor))
	gc:fillRect(x, y, self.w, self.h)

	gc:setColorRGB(0,0,0)
	gc:drawRect(x, y, self.w, self.h)
	
	if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(x-1, y-1, self.w+2, self.h+2)
        gc:setColorRGB(0, 0, 0)
    end
		
	local text	=	self.value
	local	p	=	0
	
	
	
	--[[
	while true do
		if p==#self.value then break end
		p	=	p + 1
		text	=	self.value:sub(-p, -p) .. text
		if gc:getStringWidth(text) > (self.w - 8) then
			text	=	text:sub(2,-1)
			break 
		end
	end
	--]]
	
	if self.disabled or self.value == "" then
		gc:setColorRGB(uCol(self.disabledcolor))
	end
	if self.value == ""  then
		text	= self.placeholder or ""
	end
	
	local strwidth = gc:getStringWidth(text)
	
	if strwidth<self.w-4 or not self.hasFocus then
		gc:drawString(text, x+2, y+1, "top")
	else
		gc:drawString(text, x-4+self.w-strwidth, y+1, "top")
	end
	
	if self.hasFocus and self.value ~= "" then
		gc:fillRect(self.x+(text==self.value and strwidth+2 or self.w-4), self.y, 1, self.h)
	end
	
end

function sInput:charIn(char)
	if self.disabled or (self.number and not tonumber(self.value .. char)) then --or char~="," then
		return
	end
	self.value	=	self.value .. char
  self:onChange()
	self:invalidate()
end

function sInput:clearKey()
    if self:deleteInvalid() then return 0 end
    self.value	=	""
    self:onChange()
end

function sInput:backspaceKey()
    if self:deleteInvalid() then return 0 end
	if not self.disabled then
		self.value	=	self.value:usub(1,-2)
		self:onChange()
	end
end

function sInput:onChange()
end

function sInput:deleteInvalid()
    local isInvalid = string.find(self.value, "Invalid input")
    if isInvalid then
        self.value = self.value:usub(1, -19)
        self:onChange()
        return true
    end
    return false
end

function sInput:enable()
	self.disabled	= false
end

function sInput:disable()
	self.disabled	= true
end



 -- Including : C:\tiproject\finance\src\ui\widgets\slabelwidget.lua



sLabel	=	class(Widget)

function sLabel:init(text, widget)
	self.widget	=	widget
	self.text	=	text
	self.ww		=	30
	
	self.hh		=	20
	self.lim	=	false
	self.color	=	{0,0,0}
	self.font	=	{"sansserif", "r", 10}
	self.p		=	"top"
	
end

function sLabel:paint(gc)
	gc:setFont(uCol(self.font))
	gc:setColorRGB(uCol(self.color))
	
	local text	=	""
	local ttext
	if self.lim then
		text, self.dw	= textLim(gc, self.text, self.w)
	else
		text = self.text
	end
	
	gc:drawString(text, self.x, self.y, self.p)
end

function sLabel:getFocus(n)
	if n then
		n	= n < 0 and -1 or (n > 0 and 1 or 0)
	end
	
	if self.widget and not n then
		self.widget:giveFocus()
	elseif n then
		self.parent:switchFocus(n)
	end
end


 -- Including : C:\tiproject\finance\src\ui\widgets\sbuttonwidget.lua


sButton	=	class(Widget)

function sButton:init(text, action)
    self.text	=	text
    self.action	=	action
    self.pushed = false

    self.dh	=	27
    self.dw	=	48

    self.bordercolor	=	{136,136,136}
    self.font	=	{"sansserif", "r", 10}
end

function sButton:paint(gc)
    gc:setFont(uCol(self.font))
    self.ww	=	gc:getStringWidth(self.text)+8
    self:size()

    if self.pushed and self.forcePushed then
        self.y = self.y + 2
    end

    gc:setColorRGB(248,252,248)
    gc:fillRect(self.x+2, self.y+2, self.w-4, self.h-4)
    gc:setColorRGB(0,0,0)

    gc:drawString(self.text, self.x+4, self.y+4, "top")

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:setPen("medium", "smooth")
    else
        gc:setColorRGB(uCol(self.bordercolor))
        gc:setPen("thin", "smooth")
    end
    gc:fillRect(self.x + 2, self.y, self.w-4, 2)
    gc:fillRect(self.x + 2, self.y+self.h-2, self.w-4, 2)
    gc:fillRect(self.x, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+1, self.y+1, 1, self.h-2)
    gc:fillRect(self.x+self.w-1, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+self.w-2, self.y+1, 1, self.h-2)

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
    end
end

function sButton:mouseMove(x,y)
    local isIn = (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h))
    self.pushed = self.forcePushed and isIn
    platform.window:invalidate()
end

function sButton:enterKey()
    if self.action then self.action() end
end

function sButton:mouseDown(x,y)
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self.pushed = true
        self.forcePushed = true
    end
    platform.window:invalidate()
end

function sButton:mouseUp(x,y)
    self.pushed = false
    self.forcePushed = false
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self:enterKey()
    end
    platform.window:invalidate()
end


 -- Including : C:\tiproject\finance\src\ui\widgets\scrollbarwidget.lua



scrollBar	= class(Widget)

scrollBar.upButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")
scrollBar.downButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")

function scrollBar:init(h, top, visible, total)
	self.color1	= {96, 100, 96}
	self.color2	= {184, 184, 184}
	
	self.hh	= h or 100
	self.ww = 14
	
	self.visible = visible or 10
	self.total   = total   or 15
	self.top     = top     or 4
end

function scrollBar:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x+1, self.y+1, self.w-1, self.h-1)
	
	gc:drawImage(self.upButton  , self.x+2, self.y+2)
	gc:drawImage(self.downButton, self.x+2, self.y+self.h-11)
	gc:setColorRGB(uCol(self.color1))
	if self.h > 28 then
		gc:drawRect(self.x + 3, self.y + 14, 8, self.h - 28)
	end
	
	if self.visible<self.total then
		local step	= (self.h-26)/self.total
		gc:fillRect(self.x + 3, self.y + 14  + step*self.top, 9, step*self.visible)
		gc:setColorRGB(uCol(self.color2))
		gc:fillRect(self.x + 2 , self.y + 14 + step*self.top, 1, step*self.visible)
		gc:fillRect(self.x + 12, self.y + 14 + step*self.top, 1, step*self.visible)
	end
end

function scrollBar:update(top, visible, total)
	self.top      = top     or self.top
	self.visible  = visible or self.visible
	self.total    = total   or self.total
end

function scrollBar:action(top) end

function scrollBar:mouseUp(x, y)
	local upX	= self.x+2
	local upY	= self.y+2
	local downX	= self.x+2
	local downY	= self.y+self.h-11
	local butH	= 10
	local butW	= 11
	
	if x>=upX and x<upX+butW and y>=upY and y<upY+butH and self.top>0 then
		self.top	= self.top-1
		self:action(self.top)
	elseif x>=downX and x<downX+butW and y>=downY and y<downY+butH and self.top<self.total-self.visible then
		self.top	= self.top+1
		self:action(self.top)
	end
end

function scrollBar:getFocus(n)
	if n==-1 or n==1 then
		self.parent:switchFocus(n)
	end
end

 -- Including : C:\tiproject\finance\src\ui\widgets\listwidget.lua



sList	= class(WWidget)

function sList:init()
	Widget.init(self)
	self.dw	= 150
	self.dh	= 153

	self.ih	= 18

	self.top	= 0
	self.sel	= 1
	
	self.font	= {"sansserif", "r", 10}
	self.colors	= {50,150,190}
	self.items	= {}
end

function sList:appended()
	self.scrollBar	= scrollBar("100", self.top, #self.items,#self.items)
	self:appendWidget(self.scrollBar, -1, 0)
	
	function self.scrollBar:action(top)
		self.parent.top	= top
	end
end


function sList:paint(gc)
	local x	= self.x
	local y	= self.y
	local w	= self.w
	local h	= self.h
	
	
	local ih	= self.ih   
	local top	= self.top		
	local sel	= self.sel		
		      
	local items	= self.items			
	local visible_items	= math.floor(h/ih)	
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(x, y, w, h)
	gc:setColorRGB(0, 0, 0)
	gc:drawRect(x, y, w, h)
	gc_clipRect(gc, "set", x, y, w, h)
	gc:setFont(unpack(self.font))

	
	
	local label, item
	for i=1, math.min(#items-top, visible_items+1) do
		item	= items[i+top]
		label	= textLim(gc, item, w-(5 + 12 + 2 + 1))
		
		if i+top == sel then
			gc:setColorRGB(unpack(self.colors))
			gc:fillRect(x+1, y + i*ih-ih + 1, w-(12 + 2 + 2), ih)
			
			gc:setColorRGB(255, 255, 255)
		end
		
		gc:drawString(label, x+5, y + i*ih-ih , "top")
		gc:setColorRGB(0, 0, 0)
	end
	
	self.scrollBar:update(top, visible_items, #items)
	
	gc_clipRect(gc, "reset")
end

function sList:arrowKey(arrow)	
    
	if arrow=="up" then
	    if self.sel>1 then
            self.sel	= self.sel - 1
            if self.top>=self.sel then
                self.top	= self.top - 1
            end
        else
            self.top = self.h/self.ih < #self.items and math.ceil(#self.items - self.h/self.ih) or 0
            self.sel = #self.items
        end
        self:change(self.sel, self.items[self.sel])
	end

	if arrow=="down" then
	    if self.sel<#self.items then
            self.sel	= self.sel + 1
            if self.sel>(self.h/self.ih)+self.top then
                self.top	= self.top + 1
            end
        else
            self.top = 0
            self.sel = 1
        end
        self:change(self.sel, self.items[self.sel])
	end
end


function sList:mouseUp(x, y)
	if x>=self.x and x<self.x+self.w-16 and y>=self.y and y<self.y+self.h then
		
		local sel	= math.floor((y-self.y)/self.ih) + 1 + self.top
		if sel==self.sel then
			self:enterKey()
			return
		end
		if self.items[sel] then
			self.sel=sel
			self:change(self.sel, self.items[self.sel])
		else
			return
		end
		
		if self.sel>(self.h/self.ih)+self.top then
			self.top	= self.top + 1
		end
		if self.top>=self.sel then
			self.top	= self.top - 1
		end
						
	end 
	self.scrollBar:mouseUp(x, y)
end


function sList:enterKey()
	if self.items[self.sel] then
		self:action(self.sel, self.items[self.sel])
	end
end


function sList:change() end
function sList:action() end

function sList:reset()
	self.sel	= 1
	self.top	= 0
end

 -- Including : C:\tiproject\finance\src\ui\widgets\sscreenwidget.lua



sScreen	= class(WWidget)

function sScreen:init(w, h)
	Widget.init(self)
	self.ww	= w
	self.hh	= h
	self.oy	= 0
	self.ox	= 0
	self.noloop	= true
end

function sScreen:appended()
	self.oy	= 0
	self.ox	= 0
end

function sScreen:paint(gc)
	gc_clipRect(gc, "set", self.x, self.y, self.w, self.h)
	self.x	= self.x + self.ox
	self.y	= self.y + self.oy
end

function sScreen:postPaint(gc)
	gc_clipRect(gc, "reset")
end

function sScreen:setSize(w, h)
	self.ww	= w or self.ww
	self.hh	= h or self.hh
end

function sScreen:setPos(x, y)
	self:setX(x)
	self:setY(y)
end

function sScreen:setY(y)
	self.oy	= y or self.oy
end
						
function sScreen:setX(x)
	self.ox	= x or self.ox
end

function sScreen:showWidget()
	local w	= self:getWidget()
	if not w then print("bye") return end
	local y	= self.y - self.oy
	local wy = w.y - self.oy
	
	if w.y-2 < y then
		print("Moving up")
		self:setY(-(wy-y)+4)
	elseif w.y+w.h > y+self.h then
		print("moving down")
		self:setY(-(wy-(y+self.h)+w.h+2))
	end
	
	if self.focus == 1 then
		self:setY(0)
	end
end

function sScreen:getFocus(n)
	if n==-1 or n==1 then
		self:stealFocus()
		self:switchFocus(n, true)
	end
end

function sScreen:loop(n)
	self.parent:switchFocus(n)
	self:showWidget()
end

function sScreen:focusChange()
	self:showWidget()
end

function sScreen:loseFocus(n)
	if n and ((n >= 1 and self.focus+n<=#self.widgets) or (n <= -1 and self.focus+n>=1)) then
		self:switchFocus(n)
		return -1
	else
		self:stealFocus()
	end
	
end


 -- Including : C:\tiproject\finance\src\ui\widgets\sdropdownwidget.lua



sDropdown	=	class(Widget)


function sDropdown:init(items)
	self.dh	= 21
	self.dw	= 75
	self.screen	= WScreen()
	self.sList	= sList()
	self.sList.items	= items or {}
	self.screen:appendWidget(self.sList,0,0)
	self.sList.action	= self.listAction
	self.sList.loseFocus	= self.screenEscape
	self.sList.change	= self.listChange
	self.screen.escapeKey	= self.screenEscape
	self.lak	= self.sList.arrowKey	
	self.sList.arrowKey	= self.listArrowKey
	self.value	= items[1] or ""
	self.valuen	= #items>0 and 1 or 0
	self.rvalue	= items[1] or ""
	self.rvaluen=self.valuen
	
	self.sList.parentWidget = self
	self.screen.parentWidget = self
	self.screen.focus=1
end

function sDropdown:screenpaint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.h, self.w)
	gc:setColorRGB(0,0,0)
	gc:drawRect(self.x, self.y, self.h, self.w)
end

function sDropdown:mouseDown()
	self:open()
end


sDropdown.img = image.new("\14\0\0\0\7\0\0\0\0\0\0\0\28\0\0\0\16\0\1\000{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239al{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239alalal{\239{\239\255\255\255\255\255\255\255\255\255\255\255\255{\239{\239alalalalal{\239{\239\255\255\255\255\255\255\255\255{\239{\239alalalalalalal{\239{\239\255\255\255\255{\239{\239alalalalalalalalal{\239{\239{\239{\239alalalalalalalalalalal{\239{\239alalalalalal")

function sDropdown:enterKey()
   self:open()
end

function sDropdown:arrowKey(arrow)	
    self:open()
	if arrow=="up" then
		self.parent:switchFocus(self.focusUp or -1)
	elseif arrow=="down" then
		self.parent:switchFocus(self.focusDown or 1)
		self:open()
	elseif arrow=="left" then 
		self.parent:switchFocus(self.focusLeft or -1)
	elseif arrow == "right" then
		self:open()
	end
end

function sDropdown:listArrowKey(arrow)
	if arrow == "left" then
		self:loseFocus()
	else
		self.parentWidget.lak(self, arrow)
	end
end

function sDropdown:listChange(a, b)
	self.parentWidget.value  = b
	self.parentWidget.valuen = a
end

function sDropdown:open()
	self.screen.yy	= self.y+self.h
	self.screen.xx	= self.x-1
	self.screen.ww	= self.w + 13
	local h = 2+(18*#self.sList.items)
	
	local py	= self.parent.oy and self.parent.y-self.parent.oy or self.parent.y
	local ph	= self.parent.h
	
	self.screen.hh	= self.y+self.h+h>ph+py-10 and ph-py-self.y-self.h-10 or h
	if self.y+self.h+h>ph+py-10  and self.screen.hh<40 then
		self.screen.hh = h < self.y and h or self.y-5
		self.screen.yy = self.y-self.screen.hh
	end
	
	self.sList.ww = self.w + 13
	self.sList.hh = self.screen.hh-2
	self.sList.yy =self.sList.yy+1
	self.sList:giveFocus()
	
    self.screen:size()
    self:onOpen()
	push_screen_direct(self.screen)
end

function sDropdown:onOpen()
end

function sDropdown:onClose()
end

function sDropdown:listAction(a,b)
	self.parentWidget.value  = b
	self.parentWidget.valuen = a
	self.parentWidget.rvalue  = b
	self.parentWidget.rvaluen = a
	self.parentWidget:change(a, b)
	self.parentWidget:onClose()
  remove_screen()
end

function sDropdown:change() end

function sDropdown:screenEscape()
	self.parentWidget.sList.sel = self.parentWidget.rvaluen
	self.parentWidget.value	= self.parentWidget.rvalue
	if current_screen() == self.parentWidget.screen then
		self.parentWidget:onClose()
    remove_screen()
	end
end

function sDropdown:paint(gc)
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(self.x, self.y, self.w-1, self.h-1)
	
	gc:setColorRGB(0,0,0)
	gc:drawRect(self.x, self.y, self.w-1, self.h-1)
	
	if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(self.x-1, self.y-1, self.w+1, self.h+1)
        gc:setColorRGB(0, 0, 0)
    end
	
	gc:setColorRGB(192, 192, 192)
	gc:fillRect(self.x+self.w-21, self.y+1, 20, 19)
	gc:setColorRGB(224, 224, 224)
	gc:fillRect(self.x+self.w-22, self.y+1, 1, 19)
	
	gc:drawImage(self.img, self.x+self.w-18, self.y+9)
	
	gc:setColorRGB(0,0,0)
	local text = self.value
	
	gc:drawString(textLim(gc, text, self.w-5-22), self.x+5, self.y, "top")
end


box	=	class(Widget)

function box:init(ww,hh,t)
	self.dh	= 10
	self.dw	= 10
	self.ww	= ww
	self.hh	= hh
	self.t	= t
end


function box:paint(gc)
	gc:setColorRGB(0,0,0)
	
	if self.hasFocus then
		gc:fillRect(self.x, self.y, self.w, self.h)
	else
		gc:drawRect(self.x, self.y, self.w, self.h)
	end
	
	gc:setColorRGB(128,128,128)
	if self.t then
		gc:drawString(self.t,self.x+2,self.y+2,"top")
	end
end


Combinatoire = addExtension(Screen,WidgetManager)
 

function Combinatoire:init(titleId,headerId)
  print("init Combinatoire")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 10}
  self.operation = ""
  self.n= "n"
  self.p="p"
  self.r=0
  self.widgets  = {}
  self.enterN = sInput()
  self.enterN:setWidth(50)
  self.enterNLabel = sLabel(ASTxt(ENTER_N_ID),self.enterN)
  self.enterP = sInput()
  self.enterP:setWidth(50)
  self.enterPLabel = sLabel(ASTxt(ENTER_P_ID),self.enterP)
  self.lastInput=""
  self.enterN.value = self.n
  self.enterP.value = self.p
  self.htitle=20    
  self.focus  = 0
  self:size()
  print("end Combinatoire num of widget="..tostring(table.getn(self.widgets)))
end

function Combinatoire:CreateBox()
  if not self.Box then
     self.Box = D2Editor.newRichText()
     self.Box:createMathBox()
     self.lastInput=""
     self.Box:registerFilter {
            tabKey = function()
                 if not self.Box:hasFocus() then
                      Combinatoire:tabKey() 
                 end
              return true end,
            charIn = function(ch)
                   if not self.Box:hasFocus() then
                      Combinatoire:charIn(ch) 
                   end
                   return self.Box:hasFocus() 
                end,
            arrowKey = function(key) 
                   if not self.Box:hasFocus() then
                      Combinatoire:arrowKey(key) 
                   end
                   return self.Box:hasFocus()
                end
     }
  end
end
 
function Combinatoire:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h))
      self.lasth=self.h
      self.lastw=self.w
      
      self.htmp =self.htitle+5
      self.enterNLabelX=0
      print("self.enterNLabelX="..tostring(self.enterNLabelX))
      self.enterNLabel:setPos(0, htmp)
      self.enterNX=self.enterNLabelX+52
      print("self.enterNX="..tostring(self.enterNX))
      self.enterN:setPos(self.enterNX, htmp)
      self.enterN.number=false
      self.enterN:enable()
      self.enterPLabelX=self.enterNX+160
      print("self.enterPLabelX="..tostring(self.enterPLabelX))
      self.enterPLabel:setPos(self.enterPLabelX,htmp)
      self.enterPX=self.enterPLabelX+52
      print("self.enterPX="..tostring(self.enterPX))
      self.enterP:setPos(self.enterPX, htmp)
      self.enterP.number=false
      self.enterP:enable()
      
      self.boxX=2
      self.boxY=30+self.htmp 
      self.boxW= self.w-14
      self.boxH=self.h-self.boxY-6-self.htmp     
      self:invalidate()
      print("return true")
      return true
   end
   return false
end

function Combinatoire:refreshBox()
    self.x=0
    self.y=0
  self.ww = pww()
  self.hh = pwh()
  if self:calculateSize() or not self.Box then
      self:CreateBox()
      if self.Box and self.x and self.y and self.w and self.h then
        self.Box:move(self.boxX,self.boxY)
        self.Box:resize(self.boxW, self.boxH)
      end
  end
end
   

function Combinatoire:postPaint(gc)
    self:refreshBox()
end
 


function Combinatoire:extractTxt()
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="n"
  end
  if(self.enterP) then
     self.p=self.enterP.value
  else
     print("Warning : enterp is null")
     self.p="p"
  end

  return self.n,self.p
end

function Combinatoire:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function  Combinatoire:pushed()
    print("Combinatoire:pushed")
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.n= "n"
    self.p="p"
    self.widgets  = {}
    
    self:appendWidget(self.enterNLabel, self.enterNLabelX, self.htmp)
    print("appendWidget enterNLabel")
    self:appendWidget(self.enterN, self.enterNX, self.htmp)
    self.enterN.focusDown = 1
    print("appendWidget enterN")
    self:appendWidget(self.enterPLabel, self.enterPLabelX, self.htmp)
    print("appendWidget enterPLabel")
    self:appendWidget(self.enterP, self.enterPX, self.htmp)
    print("appendWidget enterP num of widget="..tostring(table.getn(self.widgets)))
            function self.enterN:enterKey()
                self:perform()
                self.Box:setFocus(true)
            end
            function self.enterP:enterKey()
                self:perform()
                self.Box:setFocus(true)
            end
    self.enterN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    if self.Box.setExpression then
        self.Box:setColorable(true)
        self.Box:setTextColor(0x215c98)
        self.Box:setExpression(form, 1)
        self.Box:setFocus(false)
    else
        self.Box:setText(form, 1)
    end
    
          self.Box:setVisible(true)
          self:invalidate()
end


function Combinatoire:screenGetFocus()
    self:pushed()
end

function Combinatoire:screenLoseFocus()
    self:removed()
end


function Combinatoire:removed()
    if self.Box then
     if self.Box.setVisible then
           self.Box:setVisible(false)
     end
     self.Box:setText("")
     self.Box:resize(1, 1)
     self.Box:move(-10, -10)
     self.Box:registerFilter(nil)
      self.Box:setFocus(false)
    end
    doNotDisplayIcon = false
end
 
 
function Combinatoire:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,Combinatoire.font)
  local n,p=self:extractTxt()
  if (self.lastInput~=tostring(n)..","..tostring(p)) then
     self:perform()
     self.lastInput=tostring(n)..","..tostring(p)
     local form =tostring(self.header)..tostring(self.operation)
     if self.Box.setExpression then
        self.Box:setExpression(form, 1)
     else
         self.Box:setText(form, 1)
     end
  end
end

function Combinatoire:perform()
end

function Combinatoire:enterKey()
    self:perform()
end

function Combinatoire:arrowKey()
   self:enterKey()
end

function Combinatoire:escapeKey()
  local cid = self.cid
  print("before : "..tostring(cid))
  self:removed()
  print(tostring(cid))
  if cid then
    only_screen_back(SubCatSel, self.cid)
    print("reset cid")
    self.cid = nil
    self.sid = nil
    return
  end
  only_screen_back(Ref)
end



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\arrangementarep.lua

  


ArrangementAvecRep = Combinatoire(ARRANGEMENT_AVEC_REP_TITLE_ID,ARRANGEMENT_AVEC_REP_HEADER_ID)
 

function ArrangementAvecRep:performnp(n,p)
    local calculate = "("..tostring(n)..")^("..tostring(p)..")"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}\n" 
    if err1 then
       res = res.."ERROR:"..tostring(err1)
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2)
    end
    return res
end

function ArrangementAvecRep:perform()
    print("ArrangementAvecRepCls:perform")
    self.font ={"sansserif", "r", 10}    
    self.operation=""
    local n,p=self:extractTxt()
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       p=0
       while p<=tonumber(n) do
          self.operation=self.operation..self:performnp(n,p)
          p=p+1
       end
    else
       self.operation=self.operation..self:performnp(n,p)
    end
    self:invalidate()
end



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\arrangementsrep.lua

  

ArrangementSansRep = Combinatoire(ARRANGEMENT_SANS_REP_TITLE_ID,ARRANGEMENT_SANS_REP_HEADER_ID)


function ArrangementSansRep:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
      return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(n).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end
    local calculate = "("..tostring(n).."!)/("..tostring(n).."-"..tostring(p)..")!"
    local calculateC = "nPr("..tostring(n)..","..tostring(p)..")"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local resultC,err3 = math.evalStr(tostring(calculateC))
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}=\\0el {"..tostring(resultC).."}(build in funct)\n" 

    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    if err3 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    return res
end

function ArrangementSansRep:perform()
    print("ArrangementSansRepCls:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       p=0
       while p<=tonumber(n) do
          self.operation=self.operation..self:performnp(n,p)
          p=p+1
       end
    else
       self.operation=self:performnp(n,p)
    end
    self:invalidate()
end



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\combinaisonsarep.lua

  

CombinaisonsAvecRep = Combinatoire(COMBINAISONS_AVEC_REP_TITLE_ID,COMBINAISONS_AVEC_REP_HEADER_ID)


function CombinaisonsAvecRep:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
       return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(n).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end
    local calculate = "("..tostring(n).."+"..tostring(p).."-1"..")!/("..tostring(p).."!*("..tostring(n).."-1)!)"
    local subeval = "("..tostring(n).."+"..tostring(p).."-1"..")"
    local calculateC = "nCr("..tostring(n).."+"..tostring(p).."-1"..","..tostring(p)..")"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultb,err1b = math.evalStr(tostring(subeval))
    local disp = "("..tostring(resultb)..")!/("..tostring(p).."!*("..tostring(n).."-1)!)"
    local dispC = "nCr("..tostring(resultb)..","..tostring(p)..")"
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local resultC,err3 = math.evalStr(tostring(calculateC))
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..disp.."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}=\\0el {"..tostring(resultC).."}(build in funct: "..tostring(calculateC).."=\\0el {"..dispC.."})\n" 

    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    if err3 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    return res
end

function CombinaisonsAvecRep:perform()
    print("CombinaisonsAvecRep:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       p=0
       while p<=tonumber(n) do
          self.operation=self.operation..self:performnp(n,p)
          p=p+1
       end
    else
       self.operation=self:performnp(n,p)
    end
    self:invalidate()
end



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\combinaisonssrep.lua

  

CombinaisonsSansRep = Combinatoire(COMBINAISONS_SANS_REP_TITLE_ID,COMBINAISONS_SANS_REP_HEADER_ID)


function CombinaisonsSansRep:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
      return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end
    local calculate = "("..tostring(n)..")!/(("..tostring(p).."!)*("..tostring(n).."-"..tostring(p)..")!)"
    local calculateC = "nCr("..tostring(n)..","..tostring(p)..")"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local resultC,err3 = math.evalStr(tostring(calculateC))
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}=\\0el {"..tostring(resultC).."}(build in funct:"..tostring(calculateC)..")\n" 

    if err1 then
       res = res.."ERROR:"..tostring(err1)
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2)
    end
    if err3 then
       res = res.."ERROR:"..tostring(err2)
    end
    return res
end

function CombinaisonsSansRep:perform()
    print("CombinaisonsSansRep:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       p=0
       while p<=tonumber(n) do
          self.operation=self.operation..self:performnp(n,p)
          p=p+1
       end
    else
       self.operation=self:performnp(n,p)
    end
    self:invalidate()
end



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\permutationsrep.lua

  

 
PermutationSansRep = Combinatoire(PERMUTATION_SANS_REP_TITLE_ID,PERMUTATION_SANS_REP_HEADER_ID)



function PermutationSansRep:performnp(n)
    local calculate = "("..tostring(n).."!)"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}\n" 
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    return res
end


function PermutationSansRep:extractTxt()
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="n"
  end
 
  return self.n
end


function  PermutationSansRep:pushed()
    print("Combinatoire:pushed")
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.n= "n"
    self.p=""
    self.widgets  = {}
    
    self:appendWidget(self.enterNLabel, self.enterNLabelX, self.htmp)
    print("appendWidget enterNLabel")
    self:appendWidget(self.enterN, self.enterNX, self.htmp)
    self.enterN.focusDown = 1
    print("appendWidget enterN")
            function self.enterN:enterKey()
                self:perform()
                self.parent:switchFocus(1)
            end
    self.enterN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    if self.Box.setExpression then
        self.Box:setColorable(true)
        self.Box:setTextColor(0x215c98)
        self.Box:setExpression(form, 1)
        self.Box:setFocus(false)
    else
        self.Box:setText(form, 1)
    end
    
          self.Box:setVisible(true)
          self:invalidate()
end

 

function PermutationSansRep:perform()
    print("PermutationSansRep:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    self.operation=self:performnp(n)
    self:invalidate()
end

 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\partitionsord.lua



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\partitionsnord.lua



PartitionNonOrd = Combinatoire(PARTITION_NON_ORD_TITLE_ID,PARTITION_NON_ORD_HEADER_ID)


function PartitionNonOrd:StirlingRecursive(n,k)
  if k>n then
    return 0 , "S("..tostring(n)..","..tostring(k)..")=0\n"
  elseif (k==n) or (k==1) then
    return 1, "S("..tostring(n)..","..tostring(k)..")=1\n"
  else
    local val1,detail1 = self:StirlingRecursive(n-1,k-1)
    local val2,detail2 = self:StirlingRecursive(n-1,k)
    return  val1 + k*val2,detail1..detail2.."=> S("..tostring(n)..","..tostring(k)..")=S("..tostring(n-1)..","..tostring(k-1)..")+"..tostring(k).."*"..
          "S("..tostring(n-1)..","..tostring(k)..")="..tostring(val1).."+"..tostring(k).."*"..tostring(val2).."="..tostring(val1 + k*val2).."\n"
  end
end



function PartitionNonOrd:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
      return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end

    local calculate = "1/("..tostring(p).."!)*∑((−1)^("..tostring(p).."-j)*nCr("..tostring(p)..",j)*j^("..tostring(n).."),j,0,"..tostring(p)..")"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}\n" 


    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    local val,details
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) then
       val,details=self:StirlingRecursive(tonumber(n),tonumber(p))
       if val and details then
          res=res..ASTxt(RESULT_WITH_RECURSIVE_STIRLING_ID)..tostring(val).."\n"
          res=res..ASTxt(DEMONSTRATION_ID).." :\n"
          res=res..details
       end
    end
    
    return res
end

function PartitionNonOrd:perform()
    print("PartitionNonOrd:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       if(tonumber(n))==nil then
          self.operation=self.operation..ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
          return
       end
       p=0
       while p<=tonumber(n) do
          self.operation=self.operation..self:performnp(n,p)
          p=p+1
       end
    else
       self.operation=self:performnp(n,p)
    end
    self:invalidate()
end



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\permutationarep.lua

  

 
PermutationAvecRep = Combinatoire(PERMUTATION_AVEC_REP_TITLE_ID,PERMUTATION_AVEC_REP_HEADER_ID)



function PermutationAvecRep:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
       return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(n).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end
    local calculate = "("..tostring(n).."!)/("..tostring(p).."!)"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}\n" 
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    return res
end

function PermutationAvecRep:perform()
    print("PermutationAvecRep:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       p=0
       while p<=tonumber(n) do
          self.operation=self.operation..self:performnp(n,p)
          p=p+1
       end
    else
       self.operation=self:performnp(n,p)
    end
    self:invalidate()
end

 -- Including : C:\tiproject\finance\src\proba\..\ui\math\discrete\discrete2param.lua

 

 -- Including : C:\tiproject\finance\src\ui\math\spl2param.lua



 -- Including : C:\tiproject\finance\src\ui\widgets\sMathInput.lua




 -- Including : C:\tiproject\finance\src\ui\widgets\sRichInput.lua




sRichInput  = class(Widget)


function sRichInput:init(w,h)
  self.dw = w
  self.dh = h
    self.ww = w
    self.hh = h
  
  self.value  = ""  
  self.bgcolor  = {255,255,255}
  self.disabledcolor  = {128,128,128}
  self.font = {"sansserif", "r", 7}
  self.disabled = false
  
  self.editor = D2Editor.newRichText()
    self.editor:setFocus(false)
    self.editor:setFontSize(8)
     
    self.editor:registerFilter({    mouseDown = function(x,y)
                                            on.mouseDown(x,y)
                                            return false
                                    end,
                                    tabKey = function()
                                        on.tabKey()
                                    end
                                    })

end

function sRichInput:size(n)
    Widget.size(self,n)
    self.editor:move(self.x+2,self.y+1)
    self.editor:resize(self.w-2,self.h-1)
end

function sRichInput:getFocus()
    self.editor:setFocus(true)
    Widget.getFocus()
end

function sRichInput:loseFocus()
    self.editor:setFocus(false)
    Widget.loseFocus()
end

function sRichInput:onErrorDispStart()
    self:setVisible(false)
end

function sRichInput:onErrorDispEnd() 
   self:setVisible(true)
end

function sRichInput:paint(gc)
  self.gc = gc
  local x = self.x
  local y =   self.y
  
  gc:setColorRGB(uCol(self.bgcolor))
  gc:fillRect(x, y, self.w, self.h)

  gc:setColorRGB(0,0,0)
  gc:drawRect(x, y, self.w, self.h)
  
  if self.hasFocus then
    gc:drawRect(x-1, y-1, self.w+2, self.h+2)
  end 
end

function sRichInput:charIn(char)
end

function sRichInput:clearKey()
    if self:deleteInvalid() then return 0 end
    self.value  = ""
end

function sRichInput:backspaceKey()
    if self:deleteInvalid() then return 0 end
  if not self.disabled then
    self.value  = self.value:usub(1,-2)
  end
end

function sRichInput:deleteInvalid()
    local isInvalid = string.find(self.value, "Invalid input")
    if isInvalid then
        self.value = self.value:usub(1, -19)
        return true
    end
    return false
end

function sRichInput:enable()
  self.disabled = false
end

function sRichInput:disable()
  self.disabled = true
end


function sRichInput:setVisible(isVisible)
  self.editor:setVisible(isVisible)
end

sMathInput  = class(Widget)

function sMathInput:init(w,h)
    sRichInput.init(self,w,h)
    self.editor:registerFilter({
           arrowLeft = function()
              _, curpos = self.editor:getExpressionSelection()
              if curpos<7 then 
                 return true
              end
              return false
           end,
           arrowRight = function()
              currentText, curpos = self.editor:getExpressionSelection()
              if curpos>ulen(currentText)-2 then
                 return true
              end
              return false
           end,
           tabKey = function()
              on.tabKey()
              return true
           end ,
           mouseDown = function(x,y)
                                        on.mouseDown(x,y)
                                        return false
                                    end ,
                                    backspaceKey = function()
                                               self:fixCursor()
                                               _,curpos = self.editor:getExpressionSelection()
                                               if curpos <= 6 then return true end
                                               return false
                                    end ,
                                    deleteKey = function()
                                               self:fixCursor()
                                               currentText,curpos = self.editor:getExpressionSelection()
                                               if curpos >= ulen(currentText)-1 then return true end
                                               return false
                                    end ,
                                    enterKey = function()
                                           on.tabKey()
                                    end ,
                                    returnKey = function()
                                           on.tabKey()
                                    end ,
                                    charIn = function(c)
                                            self:fixCursor()
                                            return false
                                    end
                               })
      self:fixContent()
end

function sMathInput:fixContent()
                                            currentText = self.editor:getExpressionSelection()
                                            if currentText=="" or currentText==nil then
                                                self.editor:createMathBox()
                                            end
end

function sMathInput:fixCursor()
                                            currentText, curpos, selstart = self.editor:getExpressionSelection()
                                            l = ulen(currentText)
                                            if curpos<6 or selstart<6 or curpos>l-1 or selstart>l-1 then
                                                if curpos<6 then curpos=6 end
                                                if selstart<6 then selstart=6 end
                                                if curpos>l-1 then curpos=l-1 end
                                                if selstart>l-1 then selstart=l-1 end
                                                self.editor:setExpression(currentText,curpos,selstart)
                                            end
end

function sMathInput:size(n)
    sRichInput.size(self,n)
end

function sMathInput:getFocus()
    sRichInput.getFocus(self)
end

function sMathInput:loseFocus()
    sRichInput.loseFocus(self)
end

function sMathInput:paint(gc)
  sRichInput.paint(self,gc)
end

function sMathInput:enable()
  self.disabled = false
end

function sMathInput:onErrorDispStart()
    self:setVisible(false)
end

function sMathInput:onErrorDispEnd() 
   self:setVisible(true)
end




function sMathInput:disable()
  self.disabled = true
end


function sMathInput:hasFocus()
   self.editor:hasFocus()
end

function sMathInput:setReadOnly(isReadOnly)
   self.editor:setReadOnly(isReadOnly)
end

function sMathInput:setBorderColor(borderColor)
   self.editor:setBorderColor(borderColor)
end


function sMathInput:setBorder(border)
   self.editor:setBorder(border)
end

function sMathInput:setTextColor(color)
   self.editor:setTextColor(color)
end

function sMathInput:setColorable(isColorable)
  self.editor:setColorable(isColorable)
end

function sMathInput:setVisible(isVisible)
  self.editor:setVisible(isVisible)
end

function sMathInput:getRawExpression()
   return self.editor:getExpression()
end

function sMathInput:setFocus(isFocus)
   return self.editor:setFocus(isFocus)
end

function sMathInput:setExpression(str)
     if self.editor.setExpression then
        self.editor:setExpression(str, 1)
     else
         self.editor:setText(str, 1)
     end

end

function sMathInput:getExpression()
    local rawexpr = self:getRawExpression()
    if(not rawexpr) then rawexpr="" end
    local expr = ""
    local n=string.len(rawexpr)
    local b=0
    local bs=0
    local bi=0
    local status=0
    local i=1
    local c
    while i<=n do
        c = string.sub(rawexpr,i,i)
        if c=="{" then
            b=b+1
        elseif c=="}" then
            b=b-1
        end
        if status==0 then
            if string.sub(rawexpr,i,i+5)=="\\0el {" then
                bs=i+6
                i=i+5
                status=1
                bi=b
                b=b+1
            end
        else
            if b==bi then
                status=0
                expr = expr..string.sub(rawexpr,bs,i-1)
            end
        end
        i=i+1
    end
    return expr
end

Spl2Params = addExtension(Screen,WidgetManager)
 

function Spl2Params:init(titleId,headerId,enterParam1Id,enterParam2Id)
  print("init Spl2Params")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 10}
  self.operation = ""
  self.n= "n"
  self.p="p"
  self.r=0
  self.widgets  = {}
  self.enterN = sInput()
  self.enterN:setWidth(50)
  self.enterNLabel = sLabel(ASTxt(enterParam1Id),self.enterN)
  self.enterP = sInput()
  self.enterP:setWidth(50)
  self.enterPLabel = sLabel(ASTxt(enterParam2Id),self.enterP)
  self.lastInput=""
  
  self.pstartLabel = sLabel("P(")
  self.enterk1 = sInput()
  self.enterk1:setWidth(25)
  self.equalities0={"none","<=","<"} 
  self.equalityType0 = sDropdown(self.equalities0)
  self.XLabel = sLabel("X",self.enterP)
  self.equalities={"=","<","<=",">=",">","All"} 
  self.equalityType = sDropdown(self.equalities)
  self.enterk2 = sInput()
  self.enterk2:setWidth(25)
  self.pendLabel = sLabel(")")
  self.enterN.value = self.n
  self.enterP.value = self.p
  self.Box = sMathInput(0,0)
  self.htitle=20    
  self.focus  = 0
  self:size()
  print("end Spl2Params num of widget="..tostring(table.getn(self.widgets)))
end
 
function Spl2Params:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h))
      self.lasth=self.h
      self.lastw=self.w
      
      self.htmp =self.htitle+5
      self.enterNLabelX=0
      self.enterNLabel:setPos(0, self.htmp)
      self.enterNX=self.enterNLabelX+52
      self.enterN:setPos(self.enterNX, self.htmp)
      self.enterN.number=false
      self.enterN:enable()
      self.enterPLabelX=self.enterNX+160
      self.enterPLabel:setPos(self.enterPLabelX,self.htmp)
      self.enterPX=self.enterPLabelX+52
      self.enterP:setPos(self.enterPX, self.htmp)
      self.enterP.number=false
      self.enterP:enable()
      self.htmp2=self.htmp+22
      self.enterk1Y=self.htmp2+2
      self.enterk2Y=self.htmp2+2
      
      
      self.pstartLabelY=self.htmp2
      self.pstartLabelX=10
      self.enterk1X=self.pstartLabelX+22
      self.equalityTypeY=self.htmp2
      self.equalityType0Y=self.htmp2
      self.equalityType0X=self.enterk1X+30
      self.XLabelX=self.equalityType0X+80
      self.XLabelY=self.htmp2
      self.equalityTypeX=self.XLabelX+15
      self.enterk2X=self.equalityTypeX+80
      self.pendLabelY=self.htmp2
      self.pendLabelX=self.enterk2X+30
      self.pstartLabel:setPos(self.pstartLabelX, self.pstartLabelY)
      self.XLabel:setPos(self.XLabelX, self.XLabelY)
      self.equalityType0:setPos(self.equalityType0X, self.equalityType0Y)
      self.equalityType:setPos(self.equalityTypeX, self.equalityTypeY)
      self.pendLabel:setPos(self.pendLabelX, self.pendLabelY)
      
      self.boxX=4
      self.boxY=30+self.htmp2 
      self.boxW= self.w-(2*self.boxX)
      self.boxH=self.h-self.boxY-2
      self:invalidate()
      print("return true")
      return true
   end
   return false
end

function Spl2Params:refreshBox()
  self.x=0
  self.y=0
  self.ww = pww()
  self.hh = pwh()
  self:calculateSize()
end
   

function Spl2Params:postPaint(gc)
    self:refreshBox()
end

function  Spl2Params:removeEquals(compare)
   local fcompare=compare
   if (compare=="<=") then
      fcompare="<"
   elseif compare==">=" then
      fcompare=">"
   end
   return fcompare
end

function Spl2Params:getEqualityAsTxt(k1,compare1,compare2,k2)
  if compare1==nil or compare1=="" or compare1=="none" then
     return "P(X"..tostring(compare2)..tostring(k2)..")"
  end
  return "P("..tostring(k1)..tostring(compare1).."X"..tostring(compare2)..tostring(k2)..")"
end

function Spl2Params:extractTxt()
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="n"
  end
  if(self.enterP) then
     self.p=self.enterP.value
  else
     print("Warning : enterp is null")
     self.p="p"
  end
  
  if(self.enterk1) then
     self.k1=self.enterk1.value
  else
     print("Warning : enterk1 is null")
     self.k1=""
  end

  if(self.enterk2) then
     self.k2=self.enterk2.value
  else
     print("Warning : enterk2 is null")
     self.k2=""
  end
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="none"
  end
  
  if(self.equalityType0) then
     self.compare1 = self.equalityType0.value
  else
     print("Warning : equalityType0 is null")
     self.compare1="none"
  end
    
  if(self.equalityType) then
     self.compare2 = self.equalityType.value
  else
     print("Warning : equalityType is null")
     self.compare2="none"
  end

  return self.n,self.p,self.k1,self.compare1,self.compare2,self.k2
end

function Spl2Params:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function  Spl2Params:pushed()
    print("Spl2Params:pushed")
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.n= "n"
    self.p="p"
    self.widgets  = {}
    
    self:appendWidget(self.enterNLabel, self.enterNLabelX, self.htmp)
    self:appendWidget(self.enterN, self.enterNX, self.htmp)
    self.enterN.focusDown = 1
    self:appendWidget(self.enterPLabel, self.enterPLabelX, self.htmp)
    self:appendWidget(self.enterP, self.enterPX, self.htmp)
    
    self:appendWidget(self.pstartLabel,self.pstartLabelX, self.pstartLabelY)
    self:appendWidget(self.enterk1, self.enterk1X, self.enterk1Y)
    self:appendWidget(self.equalityType0, self.equalityType0X, self.equalityType0Y)
    self:appendWidget(self.XLabel, self.XLabelX, self.XLabelY)
    self:appendWidget(self.equalityType, self.equalityTypeX, self.equalityTypeY)
    self:appendWidget(self.enterk2, self.enterk2X, self.enterk2Y)
    self:appendWidget(self.pendLabel,self.pendLabelX, self.pendLabelY)
            function self.equalityType:change()
                self.parent:firePerform()
            end
            function self.enterN:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterP:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterk2:enterKey()
                self.parent.Box:setFocus(true)
                self.parent:firePerform()
            end
            function self.enterk2:onChange()
                self.parent:firePerform()
            end
            function self.equalityType:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType:onClose()
                self.parent.Box:setVisible(true)
                if (self.value~="<=" or self.value~="<") then
                   self.parent.equalityType0.value="none"
                end
            end
            function self.equalityType0:change()
                self.parent:firePerform()
            end
            function self.equalityType0:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType0:onClose()
                if (self.value=="<=" or self.value=="<") and (self.parent.equalityType.value~="<=" and self.value~="<") then
                   self.parent.equalityType.sList.sel=self.value
                   self.parent.equalityType.value=self.value
                end
                self.parent.Box:setVisible(true)
            end
    
    
    self.Box:setSize(self.boxW,self.boxH)
    self:appendWidget(self.Box,self.boxX,self.boxY)
    self.enterN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    self.Box:setColorable(true)
    self.Box:setTextColor(0x215c98)
    self.Box:setExpression(form)
    self.Box:setFocus(false)
    self:invalidate()
end


function Spl2Params:screenGetFocus()
    self:pushed()
end

function Spl2Params:screenLoseFocus()
end


function Spl2Params:removed()
    self.Box:setVisible(false)
    self.Box:setExpression("")
    self.Box:setFocus(false)
    doNotDisplayIcon = false
end
 
 
function Spl2Params:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,Spl2Params.font)
  local n,p=self:extractTxt()
  if (self.lastInput~=tostring(n)..","..tostring(p)) then
     self:firePerform()
     self.lastInput=tostring(n)..","..tostring(p)
     local form =tostring(self.header)..tostring(self.operation)
     self.Box:setExpression(form);
  end
end

function Spl2Params:firePerform()
    self.Box:setVisible(true)
    self:perform()
end


function Spl2Params:perform()
end

function Spl2Params:escapeKey()
  local cid = self.cid
  print("before : "..tostring(cid))
  self:removed()
  print(tostring(cid))
  if cid then
    only_screen_back(SubCatSel, self.cid)
    print("reset cid")
    self.cid = nil
    self.sid = nil
    return
  end
  only_screen_back(Ref)
end




 -- Including : C:\tiproject\finance\src\ui\math\discrete\binomial\binomsplcalc.lua

  
LoiBinomialSplCalc = Spl2Params(LOI_BINOMIAL_1VAR_TITLE_ID,LOI_BINOMIAL_1VAR_HEADER_ID,ENTER_N_ID,ENTER_P_ID)

function LoiBinomialSplCalc:checkValidity(n,p,k1,op1,op2,k2)

    if tostring(op1)=="none" and tostring(op2)=="none" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end

    if tostring(k2)=="" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end
    return true,""
end

function LoiBinomialSplCalc:performEx(n,p)
   local calc = tostring(n).."*("..tostring(p)..")"
   local result1,err1 = math.evalStr(tostring(calc))
   local result1b,err1b = math.evalStr("approx("..tostring(calc)..")")
   local res = "\\0el {E(X)="..tostring(calc).."}"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
   if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
   res = res.."\\0el {="..tostring(result1).."="..tostring(result1b).."}"
   return res
end


function LoiBinomialSplCalc:performVx(n,p)
   local calc = tostring(n).."*("..tostring(p)..")*(1-("..tostring(p).."))"
   local result1,err1 = math.evalStr(tostring(calc))
   local result1b,err1b = math.evalStr("approx("..tostring(calc)..")")
   local res = "\\0el {V(X)="..tostring(calc).."}"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
   if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
   res = res.."\\0el {="..tostring(result1).."="..tostring(result1b).."}"
   return res
end

function LoiBinomialSplCalc:performEqual(n,p,k2)
   local res = "\\0el {P(X="..tostring(k2)..")=C"..tostring(n).."^"..tostring(k2).."*("..tostring(p)..")^"..tostring(k2).."*q^("..tostring(n).."-"..tostring(k2)..")="..
    "(("..tostring(n).."!)/(("..tostring(n).."-"..tostring(k2)..")!*"..tostring(k2).."!))".."*("..tostring(p)..")^"..tostring(k2).."*(1-("..tostring(p).."))^("..tostring(n).."-"..tostring(k2)..")}"
   local calc1a="(("..tostring(n).."!)/(("..tostring(n).."-"..tostring(k2)..")!*"..tostring(k2).."!))"
   local calc1b="(("..tostring(p)..")^"..tostring(k2)..")"
   local calc1c="(1-("..tostring(p).."))^("..tostring(n).."-"..tostring(k2)..")"
   local result1,err1 = math.evalStr(tostring(calc1a))
   local result2,err2 = math.evalStr(tostring(calc1b))
   local result3,err3 = math.evalStr(tostring(calc1c))
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end  
    if err3 then
       res = res.."ERROR:"..tostring(err3).."\n"
    end    
    res=res.."=\\0el {("..tostring(result1)..")*("..tostring(result2)..")*("..tostring(result3).."))}"   
   local calc2 = "(("..tostring(n).."!)/(("..tostring(n).."-"..tostring(k2)..")!*"..tostring(k2).."!))".."*("..tostring(p)..")^"..tostring(k2).."*(1-("..tostring(p).."))^("..tostring(n).."-"..tostring(k2)..")"
   local calc3 = "binomPdf("..tostring(n)..",("..tostring(p).."),"..tostring(k2)..")"
   local result4,err4 = math.evalStr(tostring(calc2))
   local result4b,err4b = math.evalStr("approx("..tostring(calc2)..")")   
   local result5,err5 = math.evalStr(tostring(calc3))
   if err4 then
       res = res.."ERROR:"..tostring(err4).."\n"
   end
   if err4b then
       res = res.."ERROR:"..tostring(err4b).."\n"
   end        
   if err5 then
       res = res.."ERROR:"..tostring(err5).."\n"
   end    
   res=res.."=\\0el {"..tostring(result4).."="..tostring(result4b).."} (build in funct: \\0el {"..tostring(result5).."})"
   
   return res
end

function LoiBinomialSplCalc:performGreaterOrEqual(n,p,k2)
   local res = "\\0el {P(X>="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)>(tonumber(n)/2)) then
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(tonumber(k2))..","..tostring(n)..")"
          local result1,err1 = math.evalStr(tostring(calc)) 
          local result1a,err1a = math.evalStr("approx("..tostring(calc)..")") 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          if err1a then
             res = res.."ERROR:"..tostring(err1a).."\n"
          end 

          res = res .. "\\0el {"..tostring(result1).."="..tostring(result1a).."}(using calc)=\n"          
          res = res .. "\\0el {1-P(X<="..(tostring(k2)-1)..")}\n"
          
          calc = "binomCdf("..tostring(n)..",("..tostring(p).."),0,"..tostring(tonumber(k2)).."-1)"
          local result1,err1 = math.evalStr(tostring(calc)) 
          local result1a,err1a = math.evalStr("approx("..tostring(calc)..")") 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          if err1a then
             res = res.."ERROR:"..tostring(err1a).."\n"
          end 
          res = res .. "\\0el {P(X<="..(tostring(k2)-1)..")="..tostring(result1).."="..tostring(result1a).."} =>\n"
          result1,err1 = math.evalStr("1-"..tostring(calc))
          res = res .. "\\0el {1-P(X<="..(tostring(k2)-1)..")="..tostring(result1)
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          result1,err1 = math.evalStr("approx(1-"..tostring(calc)..")") 
          res = res .. "="..tostring(result1).."}\n"
          res = res .. ASTxt(DEMONSTRATION_ID).."\n"
          res = res .. self:performSmallerOrEqual(n,p,k2-1)
          return res
       end
   end
     res= res.."\\0el {∑(P(X=i),i,"..tostring(k2)..","..tostring(n)..")}\n"
     local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k2)..","..tostring(n)..")"
     local result1,err1 = math.evalStr(tostring(calc)) 
     if err1 then
         res = res.."ERROR:"..tostring(err1).."\n"
     end   
     res = res .. "\\0el {"..tostring(result1).."} =>\n"
     if (tonumber(k2)~=nil) then
         for i=tonumber(k2),tonumber(n) do
            res= res..self:performEqual(n,p,i).."\n"
         end
     end
     return res
end


function LoiBinomialSplCalc:performGreater(n,p,k2)
   local k3 = ""
   if(tonumber(k2)~=nil)then
      k3 = tonumber(k2)+1
   else
      k3 = "("..tostring(k2).."+1)"
   end
   local res = "\\0el {P(X>"..tostring(k2).."=P(X>="..tostring(k3).."}\n"
   res = res..self:performGreaterOrEqual(n,p,k3)
   return res
end

function LoiBinomialSplCalc:performSmallerOrEqual(n,p,k2)
   local res = "\\0el {P(X<="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)<(tonumber(n)/2)) then
          local k3 =tonumber(k2)+1
          res = res .. "\\0el {1-P(X>="..tostring(k3)..")}\n"
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(n)..")"
          local result1,err1 = math.evalStr(tostring(calc)) 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          res = res .. "\\0el {P(X>="..(tostring(k2).."+1")..")="..tostring(result1).."} =>\n"
          result1,err1 = math.evalStr("1-"..tostring(calc))
          res = res .. "\\0el {1-P(X>="..tostring(k3)..")="..tostring(result1)
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          result1,err1 = math.evalStr("approx(1-"..tostring(calc)..")") 
          res = res .. "="..tostring(result1).."}\n"
          res = res .. ASTxt(DEMONSTRATION_ID).."\n"
          res = res .. self:performGreaterOrEqual(n,p,k2)
       end
   end
     res= res.."\\0el {∑(P(X=i),i,0,"..tostring(k2)..")}\n"
     if (tonumber(k2)~=nil) then
         for i=0,tonumber(k2) do
            res= res..self:performEqual(n,p,i).."\n"
         end
     end
     return res
end

function LoiBinomialSplCalc:performSmaller(n,p,k2)
   local k3 = ""
   if(tonumber(k2)~=nil)then
      k3 = tonumber(k2)-1
   else
      k3 = "("..tostring(k2).."-1)"
   end
   local res = "\\0el {P(X<"..tostring(k2).."=P(X<="..tostring(k3).."}\n"
   res = res..self:performSmallerOrEqual(n,p,k3)
   return res
end

function LoiBinomialSplCalc:performBetween(n,p,k1,op1,op2,k2)
    local res="\\0el {P("..tostring(k1)..tostring(op1).."X"..tostring(op2)..tostring(k2)..")=}"
          local k3 = k1
          local k4 = k2
          local reprintEquality = false
          if op1=="<" then
             if tonumber(k1)~=nil then
                k3 = tonumber(k1) - 1
             else
                k3 = tostring(k1).. "-1"
             end
             reprintEquality = true
          end
          if op2=="<" then 
             if tonumber(k2)~=nil then
                k4 = tonumber(k2) + 1
             else
                k4 = tostring(k2).. "+1"
             end   
            reprintEquality = true
          end
          if reprintEquality then
             res=res.."\\0el {P("..tostring(k3).."<=X<="..tostring(k4)..")=}" 
          end
    if (tonumber(n)~=nil and tonumber(k3)~=nil and tonumber(k4)~=nil) then
       if(tonumber(k4)-tonumber(k3)>tonumber(n)-(tonumber(k4)-tonumber(k3))) then
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(k4)..")"  
          local result1,err1 = math.evalStr(tostring(calc))
          res=res..tostring(result1).."}\n"
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end
          local calc2a = "binomCdf("..tostring(n)..",("..tostring(p).."),0,"..tostring(k3).."-1)"  
          local calc2b = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k4)..","..tostring(n)..")"  
          local result2a,err2a = math.evalStr(tostring(calc2a))
          local result2b,err2b = math.evalStr(tostring(calc2b))
          
          res=res.."\\0el {=P(X<="..tostring(k4)..")-P(X<"..tostring(k3).."-1)="..tostring(result2b).."-"..tostring(result2a).."="..tostring(result1).."}\n"
          if err2a then
             res = res.."ERROR:"..tostring(err2a).."\n"
          end  
          if err2b then
             res = res.."ERROR:"..tostring(err2b).."\n"
          end
          res = res..self:performSmallerOrEqual(n,p,tostring(k3).."-1").."\n"
          res = res..self:performSmallerOrEqual(n,p,k4).."\n"
          return res
       end
       local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(k4)..")"  
       local result,err = math.evalStr(tostring(calc))
       local resulta,erra = math.evalStr("approx("..tostring(calc)..")")
       res=res.."\\0el {"..tostring(result).."="..tostring(resulta).."}\n"
          if err then
             res = res.."ERROR:"..tostring(err).."\n"
          end        
          if erra then
             res = res.."ERROR:"..tostring(erra).."\n"
          end  
       res= res.."\\0el {∑(P(X=i),i,"..tostring(k3)..","..tostring(k4)..")}\n"      
       for i=tonumber(k3),tonumber(k4) do
         res= res..self:performEqual(n,p,i).."\n"
       end 
       return res
    end
    res= res.."\\0el {∑(P(X=i),i,"..tostring(k3)..","..tostring(k4)..")}\n"    
    return res
end

function LoiBinomialSplCalc:performBNP(n,p,k1,op1,op2,k2)
    local isValid,errtxt = self:checkValidity(n,p,k1,op1,op2,k2)
    if (not isValid) then
       return errtxt
    end

    if (op2=="=") then
       return self:performEqual(n,p,k2)
    end

    if (op1=="<" or op1=="<=") and (op2=="<" or op2=="<=") then
      return self:performBetween(n,p,k1,op1,op2,k2)
    end
    
    if (op2=="<" ) then
       return self:performSmaller(n,p,k2)
    end
    
    if (op2=="<=") then
      return self:performSmallerOrEqual(n,p,k2)
    end
    
    if (op2==">") then 
      return self:performGreater(n,p,k2)
    end
    
    if (op2==">=") then 
      return self:performGreaterOrEqual(n,p,k2)
    end
    
    return ASTxt(NOT_SUPPORTED_ID)
end

function LoiBinomialSplCalc:perform()
    print("LoiBinomialSplCalc:perform")
    self.font ={"sansserif", "r", 10}
    local n,p,k1,compare1,compare2,k2 =self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
      return
    end

    local ex = self:performEx(n,p)
    local vx = self:performVx(n,p)
    self.operation=tostring(ex).."\n"..tostring(vx)
    
    if (tostring(k1)=="nil") then
      return tostring(ex).."\n"..tostring(vx)
    end

    if (tostring(k2)=="nil") or tostring(k2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end



    if (tostring(compare1)=="nil") or tostring(compare1)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    if (tostring(compare2)=="nil") or tostring(compare2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    self.operation=self:performBNP(n,p,k1,compare1,compare2,k2).."\n"..tostring(ex).."\n"..tostring(vx)
    self:invalidate()
end


 -- Including : C:\tiproject\finance\src\proba\..\ui\math\discrete\discrete3param.lua

 

Discrete3Params = addExtension(Screen,WidgetManager)
 

function Discrete3Params:init(titleId,headerId)
  print("init Discrete3Params")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 10}
  self.operation = ""
  self.bn= "BN"
  self.sn= "n"
  self.p="p"
  self.r=0
  self.widgets  = {}
  self.lastInput=""
  self.enterBN = sInput()
  self.enterBN:setWidth(50)
  self.enterBNLabel = sLabel(ASTxt(ENTER_BN_ID),self.enterBN)

  self.enterSN = sInput()
  self.enterSN:setWidth(50)
  self.enterSNLabel = sLabel(ASTxt(ENTER_SN_ID),self.enterSN)

  
  self.enterP = sInput()
  self.enterP:setWidth(50)
  self.enterPLabel = sLabel(ASTxt(ENTER_P_ID),self.enterP)

  
  self.pstartLabel = sLabel("P(")
  self.enterk1 = sInput()
  self.enterk1:setWidth(25)
  self.equalities0={"none","<=","<"} 
  self.equalityType0 = sDropdown(self.equalities0)
  self.XLabel = sLabel("X",self.enterP)
  self.equalities={"=","<","<=",">=",">","All"} 
  self.equalityType = sDropdown(self.equalities)
  self.enterk2 = sInput()
  self.enterk2:setWidth(25)
  self.pendLabel = sLabel(")")
  self.enterBN.value = self.bn
  self.enterSN.value = self.sn
  self.enterP.value = self.p
  self.Box = sMathInput(0,0)
  self.htitle=20    
  self.focus  = 0
  self:size()
  print("end Discrete3Params num of widget="..tostring(table.getn(self.widgets)))
end
 
function Discrete3Params:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h))
      self.lasth=self.h
      self.lastw=self.w
      
      self.htmp =self.htitle+5
      self.enterBNLabelX=0
      self.enterBNLabel:setPos(self.enterBNLabelX, self.htmp)
      self.enterBNX=self.enterBNLabelX+52
      self.enterBN:setPos(self.enterBNX, self.htmp)
      self.enterBN.number=false
      self.enterBN:enable()
      
      self.enterSNLabelX=self.enterBNX+52
      self.enterSNLabel:setPos(self.enterSNLabelX, self.htmp)
      self.enterSNX=self.enterSNLabelX+52
      self.enterSN:setPos(self.enterSNX, self.htmp)
      self.enterSN.number=false
      self.enterSN:enable()

      self.enterPLabelX=self.enterSNX+52      
      self.enterPLabel:setPos(self.enterPLabelX,self.htmp)
      self.enterPX=self.enterPLabelX+52
      self.enterP:setPos(self.enterPX, self.htmp)
      self.enterP.number=false
      self.enterP:enable()
      self.htmp2=self.htmp+22
      self.enterk1Y=self.htmp2+2
      self.enterk2Y=self.htmp2+2
      
      
      self.pstartLabelY=self.htmp2
      self.pstartLabelX=10
      self.enterk1X=self.pstartLabelX+22
      self.equalityTypeY=self.htmp2
      self.equalityType0Y=self.htmp2
      self.equalityType0X=self.enterk1X+30
      self.XLabelX=self.equalityType0X+80
      self.XLabelY=self.htmp2
      self.equalityTypeX=self.XLabelX+15
      self.enterk2X=self.equalityTypeX+80
      self.pendLabelY=self.htmp2
      self.pendLabelX=self.enterk2X+30
      self.pstartLabel:setPos(self.pstartLabelX, self.pstartLabelY)
      self.XLabel:setPos(self.XLabelX, self.XLabelY)
      self.equalityType0:setPos(self.equalityType0X, self.equalityType0Y)
      self.equalityType:setPos(self.equalityTypeX, self.equalityTypeY)
      self.pendLabel:setPos(self.pendLabelX, self.pendLabelY)
      
      self.boxX=4
      self.boxY=30+self.htmp2 
      self.boxW= self.w-(2*self.boxX)
      self.boxH=self.h-self.boxY-2
      self:invalidate()
      print("return true")
      return true
   end
   return false
end

function Discrete3Params:refreshBox()
  self.x=0
  self.y=0
  self.ww = pww()
  self.hh = pwh()
  self:calculateSize()
end
   

function Discrete3Params:postPaint(gc)
    self:refreshBox()
end
 


function Discrete3Params:extractTxt()

  if(self.enterBN) then
     self.bn=self.enterBN.value
  else
     print("Warning : enterbn is null")
     self.bn="BN"
  end
  if(self.enterSN) then
     self.sn=self.enterSN.value
  else
     print("Warning : entersn is null")
     self.sn="n"
  end
  if(self.enterP) then
     self.p=self.enterP.value
  else
     print("Warning : enterp is null")
     self.p="p"
  end
  
  if(self.enterk1) then
     self.k1=self.enterk1.value
  else
     print("Warning : enterk1 is null")
     self.k1=""
  end

  if(self.enterk2) then
     self.k2=self.enterk2.value
  else
     print("Warning : enterk2 is null")
     self.k2=""
  end
  
  if(self.equalityType0) then
     self.compare1 = self.equalityType0.value
  else
     print("Warning : equalityType0 is null")
     self.compare1="none"
  end
    
  if(self.equalityType) then
     self.compare2 = self.equalityType.value
  else
     print("Warning : equalityType is null")
     self.compare2="none"
  end
  
  return self.bn,self.sn,self.p,self.k1,self.compare1,self.compare2,self.k2
end

function Discrete3Params:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function  Discrete3Params:pushed()
    print("Discrete3Params:pushed")
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.bn= "BN"
    self.sn= "n"
    self.p="p"
    self.widgets  = {}
    
    self:appendWidget(self.enterBNLabel, self.enterBNLabelX, self.htmp)
    self:appendWidget(self.enterBN, self.enterBNX, self.htmp)
    self.enterBN.focusDown = 1
    self:appendWidget(self.enterSNLabel, self.enterSNLabelX, self.htmp)
    self:appendWidget(self.enterSN, self.enterSNX, self.htmp)
    self:appendWidget(self.enterPLabel, self.enterPLabelX, self.htmp)
    self:appendWidget(self.enterP, self.enterPX, self.htmp)
    
    self:appendWidget(self.pstartLabel,self.pstartLabelX, self.pstartLabelY)
    self:appendWidget(self.enterk1, self.enterk1X, self.enterk1Y)
    self:appendWidget(self.equalityType0, self.equalityType0X, self.equalityType0Y)
    self:appendWidget(self.XLabel, self.XLabelX, self.XLabelY)
    self:appendWidget(self.equalityType, self.equalityTypeX, self.equalityTypeY)
    self:appendWidget(self.enterk2, self.enterk2X, self.enterk2Y)
    self:appendWidget(self.pendLabel,self.pendLabelX, self.pendLabelY)
            function self.equalityType:change()
                self.parent:firePerform()
            end
            function self.enterBN:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterSN:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterP:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterk2:enterKey()
                self.parent.Box:setFocus(true)
                self.parent:firePerform()
            end
            function self.enterk2:onChange()
                self.parent:firePerform()
            end
            function self.equalityType:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType:onClose()
                self.parent.Box:setVisible(true)
                if (self.value=="<=" or self.value=="<") then
                   self.parent.equalityType0.sList.sel=self.value
                   self.parent.equalityType0.value=self.value
                else
                   self.parent.equalityType0.value="none"
                end
            end
            function self.equalityType0:change()
                self.parent:firePerform()
            end
            function self.equalityType0:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType0:onClose()
                if (self.value=="<=" or self.value=="<") and (self.parent.equalityType.value~="<=" and self.value~="<") then
                   self.parent.equalityType.sList.sel=self.value
                   self.parent.equalityType.value=self.value
                end
                self.parent.Box:setVisible(true)
            end
    
    
    self.Box:setSize(self.boxW,self.boxH)
    self:appendWidget(self.Box,self.boxX,self.boxY)
    self.enterBN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    self.Box:setColorable(true)
    self.Box:setTextColor(0x215c98)
    self.Box:setExpression(form)
    self.Box:setFocus(false)
    self:invalidate()
end


function Discrete3Params:screenGetFocus()
    self:pushed()
end

function Discrete3Params:screenLoseFocus()
end


function Discrete3Params:removed()
    self.Box:setVisible(false)
    self.Box:setExpression("")
    self.Box:setFocus(false)
    doNotDisplayIcon = false
end
 
 
function Discrete3Params:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,Discrete3Params.font)
  local n,p=self:extractTxt()
  if (self.lastInput~=tostring(n)..","..tostring(p)) then
     self:firePerform()
     self.lastInput=tostring(n)..","..tostring(p)
     local form =tostring(self.header)..tostring(self.operation)
     self.Box:setExpression(form);
  end
end

function Discrete3Params:firePerform()
    self.Box:setVisible(true)
    self:perform()
end


function Discrete3Params:perform()
end

function Discrete3Params:escapeKey()
  local cid = self.cid
  print("before : "..tostring(cid))
  self:removed()
  print(tostring(cid))
  if cid then
    only_screen_back(SubCatSel, self.cid)
    print("reset cid")
    self.cid = nil
    self.sid = nil
    return
  end
  only_screen_back(Ref)
end



 -- Including : C:\tiproject\finance\src\ui\math\discrete\hypergeometric\hypergeometricsplcalc.lua

  
  
LoiHypergeometriqueSplCalc = Discrete3Params(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID,LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID)


function LoiHypergeometriqueSplCalc:checkValidity(N,n,p,k1,op1,op2,k2)

    if tostring(op1)=="none" and tostring(op2)=="none" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end

    if tostring(k2)=="" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end
    return true,""
end

function LoiHypergeometriqueSplCalc:performEx(n,p)
   local calc = tostring(n).."*("..tostring(p)..")"
   local result1,err1 = math.evalStr(tostring(calc))
   local result1b,err1b = math.evalStr("approx("..tostring(calc)..")")
   local res = "\\0el {E(X)="..tostring(calc).."}"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
   if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
   res = res.."\\0el {="..tostring(result1).."="..tostring(result1b).."}"
   return res
end


function LoiHypergeometriqueSplCalc:performVx(N,n,p)
   local calc = tostring(n).."*("..tostring(p)..")*(1-("..tostring(p).."))*(("..tostring(N).."-"..tostring(n)..")/("..tostring(N).."-1))"
   local result1,err1 = math.evalStr(tostring(calc))
   local result1b,err1b = math.evalStr("approx("..tostring(calc)..")")
   local res = "\\0el {V(X)="..tostring(calc).."}"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
   if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
   res = res.."\\0el {="..tostring(result1).."="..tostring(result1b).."}"
   return res
end

function LoiHypergeometriqueSplCalc:performEqual(N,n,p,k2)
   local pstr = "("..tostring(p)..")"
   local pNstr = "("..tostring(pstr).."*"..tostring(N)..")"
   local qNstr = "((1-"..tostring(pstr)..")*"..tostring(N)..")"
   local nlessk = "("..tostring(n).."-"..tostring(k2)..")"
   
   local res = "\\0el {P(X="..tostring(k2)..")="..
   "(C"..tostring(pNstr).."^"..tostring(k2).."*"..
   "C"..tostring(qNstr).."^"..tostring(nlessk)..")/"..
   "C"..tostring(N).."^"..tostring(n).."="..
   "((("..tostring(pNstr).."!)/(("..tostring(pNstr).."-"..tostring(k2)..")!*"..tostring(k2).."!))*"..
   "(("..tostring(qNstr).."!)/(("..tostring(qNstr).."-"..tostring(nlessk)..")!*"..tostring(nlessk).."!)))/"..
   "(("..tostring(N).."!)/(("..tostring(N).."-"..tostring(n)..")!*"..tostring(n).."!))}"
   
   local calc1a="("..tostring(pNstr).."!)/(("..tostring(pNstr).."-"..tostring(k2)..")!*"..tostring(k2).."!)"
   local calc1b="("..tostring(qNstr).."!)/(("..tostring(qNstr).."-"..tostring(nlessk)..")!*"..tostring(nlessk).."!)"
   local calc1c="("..tostring(N).."!)/(("..tostring(N).."-"..tostring(n)..")!*"..tostring(n).."!)"
   local result1,err1 = math.evalStr(tostring(calc1a))
   local result2,err2 = math.evalStr(tostring(calc1b))
   local result3,err3 = math.evalStr(tostring(calc1c))
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end  
    if err3 then
       res = res.."ERROR:"..tostring(err3).."\n"
    end    
   local calc2 = "((("..tostring(result1)..")*("..tostring(result2).."))/("..tostring(result3).."))"
   res=res.."=\\0el {"..tostring(calc2).."}"   
   local result4,err4 = math.evalStr(tostring(calc2))
   local result4b,err4b = math.evalStr("approx("..tostring(calc2)..")")   
   if err4 then
       res = res.."ERROR:"..tostring(err4).."\n"
   end
   if err4b then
       res = res.."ERROR:"..tostring(err4b).."\n"
   end        
   res=res.."=\\0el {"..tostring(result4).."="..tostring(result4b).."}"
   
   return res,result4
end

function LoiHypergeometriqueSplCalc:performGreaterOrEqual(N,n,p,k2)
   local res = "\\0el {P(X>="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)>(tonumber(n)/2)) then
          res = res .. "\\0el {=1-P(X<="..(tostring(k2)-1)..")}\n"
          local k3=tonumber(k2)-1
          
          local demRes,value = self:performSmallerOrEqual(N,n,p,k3)
          
          res = res .. "\\0el {P(X<="..tostring(k3)..")="..tostring(value).."} =>\n"
          local result1,err1 = math.evalStr("1-"..tostring(value))
          res = res .. "\\0el {1-P(X<="..(tostring(k2)-1)..")="..tostring(result1)
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          result1,err1 = math.evalStr("approx(1-"..tostring(value)..")") 
          res = res .. "="..tostring(result1).."}\n"
          res = res .. ASTxt(DEMONSTRATION_ID).."\n"
          
          res = res .. tostring(demRes)
          return res
       end
   end
     res= res.."\\0el {∑(P(X=i),i,"..tostring(k2)..","..tostring(n)..")}\n"
     local details1 =""
     local details2 =""
     if tonumber(n)~=nil and (tonumber(k2)~=nil) then
         for i=tonumber(k2),tonumber(n) do
            local dem,val=self:performEqual(N,n,p,i)
            if(i>tonumber(k2)) then
               details1=details1.."+"
            end
            details1=details1..tostring(val)
            details2= details2..tostring(dem).."\n"
         end
     end

     local result1,err1 = math.evalStr(details1)
     res = res .. "=\\0el {"..tostring(details1)..")="..tostring(result1).."}"
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
     result1,err1 = math.evalStr("approx("..details1..")")
     res = res .. "=\\0el {"..tostring(result1).."}"
       if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
     res = res .."\n".. details2    
     return res
end


function LoiHypergeometriqueSplCalc:performGreater(N,n,p,k2)
   local k3 = ""
   if(tonumber(k2)~=nil)then
      k3 = tonumber(k2)+1
   else
      k3 = "("..tostring(k2).."+1)"
   end
   local res = "\\0el {P(X>"..tostring(k2)..")=P(X>="..tostring(k3).."}\n"
   res = res..self:performGreaterOrEqual(N,n,p,k3)
   return res
end

function LoiHypergeometriqueSplCalc:performSmallerOrEqual(n,p,k2)
   local res = "\\0el {P(X<="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)<(tonumber(n)/2)) then
          res = res .. "\\0el {=1-P(X>="..(tostring(k2)+1)..")}\n"
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(tonumber(k2)+1)..","..tostring(n)..")"
          local result1,err1 = math.evalStr(tostring(calc)) 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          res = res .. "\\0el {P(X>="..(tostring(k2)+1)..")="..tostring(result1).."} =>\n"
          result1,err1 = math.evalStr("1-"..tostring(calc))
          res = res .. "\\0el {1-P(X>="..(tostring(k2)+1)..")="..tostring(result1)
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          result1,err1 = math.evalStr("approx(1-"..tostring(calc)..")") 
          res = res .. "="..tostring(result1).."}\n"
          res = res .. ASTxt(DEMONSTRATION_ID).."\n"
          res = res .. self:performGreaterOrEqual(n,p,k2)
       end
   end
     res= res.."\\0el {∑(P(X=i),i,0,"..tostring(k2)..")}\n"
     if (tonumber(k2)~=nil) then
         for i=0,tonumber(k2) do
            res= res..self:performEqual(N,n,p,i).."\n"
         end
     end
     return res
end

function LoiHypergeometriqueSplCalc:performSmaller(n,p,k2)
   local k3 = ""
   if(tonumber(k2)~=nil)then
      k3 = tonumber(k2)-1
   else
      k3 = "("..tostring(k2).."-1)"
   end
   local res = "\\0el {P(X<"..tostring(k2).."=P(X<="..tostring(k3).."}\n"
   res = res..self:performSmallerOrEqual(n,p,k3)
   return res
end

function LoiHypergeometriqueSplCalc:performBetween(n,p,k1,op1,op2,k2)
    local res="\\0el {P("..tostring(k1)..tostring(op1).."X"..tostring(op2)..tostring(k2)..")="
    if (tonumber(n)~=nil and tonumber(k1)~=nil and tonumber(k2)~=nil) then
    end
    local k3 = k1
    local k4 = k2
    local reprintEquality = false
    if op1=="<" then
       if tonumber(k1)~=nil then
          k3 = tonumber(k1) - 1
       else
          k3 = tostring(k1).. "-1"
       end
       reprintEquality = true
    end
    if op2=="<" then 
       if tonumber(k2)~=nil then
          k4 = tonumber(k2) + 1
       else
          k4 = tostring(k2).. "+1"
       end   
      reprintEquality = true
    end
    if reprintEquality then
       res=res.."\\0el {=P("..tostring(k3).."<=X<="..tostring(k4)..")=" 
    end
    local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(k4)..")"  
    local result1,err1 = math.evalStr(tostring(calc))
    res=res..tostring(result1).."}\n"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end
    local calc2a = "binomCdf("..tostring(n)..",("..tostring(p).."),0,"..tostring(k3)..")"  
    local calc2b = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k4)..","..tostring(n)..")"  
    local result2a,err2a = math.evalStr(tostring(calc2a))
    local result2b,err2b = math.evalStr(tostring(calc2b))
    
    res=res.."\\0el {=P(X<="..tostring(k4)..")-P(X<="..tostring(k3)..")="..tostring(result2b).."-"..tostring(result2a).."="..tostring(result1).."}\n"
    if err2a then
       res = res.."ERROR:"..tostring(err2a).."\n"
    end  
    if err2b then
       res = res.."ERROR:"..tostring(err2b).."\n"
    end
    res = res..self:performSmallerOrEqual(n,p,k3).."\n"
    res = res..self:performSmallerOrEqual(n,p,k4).."\n"
    return res
end

function LoiHypergeometriqueSplCalc:performHNnP(N,n,p,k1,op1,op2,k2)
    local isValid,errtxt = self:checkValidity(N,n,p,k1,op1,op2,k2)
    if (not isValid) then
       return errtxt
    end

    if (op2=="=") then
       return self:performEqual(N,n,p,k2)
    end

    if (op1=="<" or op1=="<=") and (op2=="<" or op2=="<=") then
      return self:performBetween(N,n,p,k1,op1,op2,k2)
    end
    
    if (op2=="<" ) then
       return self:performSmaller(N,n,p,k2)
    end
    
    if (op2=="<=") then
      return self:performSmallerOrEqual(N,n,p,k2)
    end
    
    if (op2==">") then 
      return self:performGreater(N,n,p,k2)
    end
    
    if (op2==">=") then 
      return self:performGreaterOrEqual(N,n,p,k2)
    end
    
    return ASTxt(NOT_SUPPORTED_ID)
end

function LoiHypergeometriqueSplCalc:perform()
    print("LoiHypergeometriqueSplCalc:perform")
    self.font ={"sansserif", "r", 10}
    local bn,sn,p,k1,compare1,compare2,k2 =self:extractTxt()
    self.operation=""
    if (tostring(bn)=="nil") or tostring(bn)=="" then
      return self.operation
    end
    if (tostring(sn)=="nil") or tostring(sn)=="" then
      return self.operation
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
      return self.operation
    end

    local ex = self:performEx(sn,p)
    local vx = self:performVx(bn,sn,p)

    local exVx=tostring(ex).."\n"..tostring(vx)
    self.operation=exVx
    if (tostring(k1)=="nil") then
      return self.operation
    end

    if (tostring(k2)=="nil") or tostring(k2)=="" then
      return self.operation
    end



    if (tostring(compare1)=="nil") or tostring(compare1)=="" then
      return self.operation
    end

    if (tostring(compare2)=="nil") or tostring(compare2)=="" then
      return self.operation
    end
    self.operation=self:performHNnP(bn,sn,p,k1,compare1,compare2,k2).."\n"..tostring(exVx)
    self:invalidate()
    return self.operation
end


 -- Including : C:\tiproject\finance\src\proba\..\ui\math\continue\continue2param.lua

 




 -- Including : C:\tiproject\finance\src\ui\math\continue\normal\normalsplcalc.lua


 -- Including : C:\tiproject\finance\src\math\tables\normal\table1.lua


 -- Including : C:\tiproject\finance\src\std\num.lua

number={}
function number.tonumber(num)
   local ini = string.gsub(tostring(num), "−","-")
   return tonumber(ini)
end

function number.round(num, idp)
  local res = number.tonumber(num)
  return string.format("%." .. (idp or 0) .. "f",res )
end

 -- Including : C:\tiproject\finance\src\std\array.lua

array={}

function array.checkSortedArray(array)
   for i = 2, #array do
      if(names[i-1]>names[i]) then
         return false
      end
   end
   return true
end

function array.searchClosestIdx(array,val)
   local low = 0
   local high = #array
   local med =math.floor((high + low) / 2)
   local temp

   while (high ~= low+1) do
      temp = array[med]
      if (temp == val) then
          return med
      elseif (temp < val) then
          low = med
      else
          high = med
      end
         med = math.floor((high + low) / 2);
   end
   
   if  math.abs(val-array[high]) < math.abs(val-array[low]) then
      return high
   end
   return low
end

normal={}
normal.table1={}
normal.table1.start = 0
normal.table1.step =0.01
normal.table1.val = {
    0.5000, 0.5040, 0.5080, 0.5120, 0.5160, 0.5199, 0.5239, 0.5279, 0.5319, 0.5359,
    0.5398, 0.5438, 0.5478, 0.5517, 0.5557, 0.5596, 0.5636, 0.5675, 0.5714, 0.5753,
    0.5793, 0.5832, 0.5871, 0.5910, 0.5948, 0.5987, 0.6026, 0.6064, 0.6103, 0.6141,
    0.6179, 0.6217, 0.6255, 0.6293, 0.6331, 0.6368, 0.6406, 0.6443, 0.6480, 0.6517,
    0.6554, 0.6591, 0.6628, 0.6664, 0.6700, 0.6736, 0.6772, 0.6808, 0.6844, 0.6879,
    0.6915, 0.6950, 0.6985, 0.7019, 0.7054, 0.7088, 0.7123, 0.7157, 0.7190, 0.7224,
    0.7257, 0.7290, 0.7324, 0.7357, 0.7389, 0.7422, 0.7454, 0.7486, 0.7517, 0.7549,
    0.7580, 0.7611, 0.7642, 0.7673, 0.7704, 0.7734, 0.7764, 0.7794, 0.7823, 0.7852,
    0.7881, 0.7910, 0.7939, 0.7967, 0.7995, 0.8023, 0.8051, 0.8078, 0.8106, 0.8133,
    0.8159, 0.8186, 0.8212, 0.8238, 0.8264, 0.8264, 0.8315, 0.8315, 0.8340, 0.8389,
    
    0.8413, 0.8438, 0.8461, 0.8485, 0.8508, 0.8531, 0.8554, 0.8577, 0.8599, 0.8621,
    0.8643, 0.8665, 0.8686, 0.8708, 0.8729, 0.8749, 0.8770, 0.8790, 0.8810, 0.8830,
    0.8849, 0.8869, 0.8888, 0.8907, 0.8925, 0.8944, 0.8962, 0.8980, 0.8997, 0.9015,
    0.9032, 0.9049, 0.9066, 0.9082, 0.9099, 0.9115, 0.9131, 0.9147, 0.9162, 0.9177,
    0.9192, 0.9207, 0.9222, 0.9236, 0.9251, 0.9265, 0.9279, 0.9292, 0.9306, 0.9319,
    0.9332, 0.9345, 0.9357, 0.9370, 0.9382, 0.9394, 0.9406, 0.9418, 0.9429, 0.9441,
    0.9452, 0.9463, 0.9474, 0.9484, 0.9495, 0.9505, 0.9515, 0.9525, 0.9535, 0.9545,
    0.9554, 0.9564, 0.9573, 0.9582, 0.9591, 0.9599, 0.9608, 0.9616, 0.9625, 0.9633,
    0.9641, 0.9649, 0.9656, 0.9664, 0.9671, 0.9678, 0.9686, 0.9693, 0.9699, 0.9706,
    0.9713, 0.9719, 0.9726, 0.9732, 0.9738, 0.9744, 0.9750, 0.9756, 0.9761, 0.9767,
    
    0.9772, 0.9779, 0.9783, 0.9788, 0.9793, 0.9798, 0.9803, 0.9808, 0.9812, 0.9817,
    0.9821, 0.9826, 0.9830, 0.9834, 0.9838, 0.9842, 0.9846, 0.9850, 0.9854, 0.9857,
    0.9861, 0.9864, 0.9868, 0.9871, 0.9875, 0.9878, 0.9881, 0.9884, 0.9887, 0.9890,
    0.9893, 0.9896, 0.9898, 0.9901, 0.9904, 0.9906, 0.9909, 0.9911, 0.9913, 0.9916,
    0.9918, 0.9920, 0.9922, 0.9925, 0.9927, 0.9929, 0.9931, 0.9932, 0.9934, 0.9936,
    0.9938, 0.9940, 0.9941, 0.9943, 0.9945, 0.9946, 0.9948, 0.9949, 0.9951, 0.9952,
    0.9953, 0.9955, 0.9956, 0.9957, 0.9959, 0.9960, 0.9961, 0.9962, 0.9963, 0.9964,
    0.9965, 0.9966, 0.9967, 0.9968, 0.9969, 0.9970, 0.9971, 0.9972, 0.9973, 0.9974,
    0.9974, 0.9975, 0.9976, 0.9977, 0.9977, 0.9978, 0.9979, 0.9979, 0.9980, 0.9981,
    0.9981, 0.9982, 0.9982, 0.9983, 0.9984, 0.9984, 0.9985, 0.9985, 0.9986, 0.9986,
    
    .99865, .99865, .99865, .99865, .99865, .99904, .99904, .99904, .99904, .99904,
    .99904, .99904, .99904, .99904, .99904, .99931, .99931, .99931, .99931, .99931,
    .99931, .99931, .99931, .99931, .99931, .99952, .99952, .99952, .99952, .99952,
    .99952, .99952, .99952, .99952, .99952, .99966, .99966, .99966, .99966, .99966,
    .99966, .99966, .99966, .99966, .99966, .99976, .99976, .99976, .99976, .99976,
    .99976, .99976, .99976, .99976, .99976,.999841,.999841,.999841,.999841,.999841,
    .999841,.999841,.999841,.999841,.999841,.999928,.999928,.999928,.999928,.999928,
    .999928,.999928,.999928,.999928,.999928,.999968,.999968,.999968,.999968,.999968,
    .999968,.999968,.999968,.999968,.999968,.999997,.999997,.999997,.999997,.999997,
    .999997,.999997,.999997,.999997,.999997,.999997,.999997,.999997,.999997,.999997,
}

function normal.table1.size()
   return table.getn(normal.table1.val)
end

function normal.table1.getIndexForU(u)
   return (number.round(u,2)*(1/normal.table1.step))+1
end

function normal.table1.resolveFu(u)
    if (number.tonumber(u) == nil) then
      return "NAN"..tostring(u)
    end
    u=number.tonumber(u)
    if (u<0) then
       return 1-normal.table1.resolveFu(-u)
    end
    i = normal.table1.getIndexForU(u)
    if(i<=normal.table1.size()) then 
       return normal.table1.val[i]
    end
    return "0.999997(NIT)"
end

function normal.table1.invResolveFu(p)
   if (number.tonumber(p) == nil) then
      return "NAN:"..tostring(p)
   end
   p=number.tonumber(p)
   if (p<0.5) then
      return 1-normal.table1.invResolveFu(-p)
   end
   return (array.searchClosestIdx(normal.table1.val,p)-1)*normal.table1.step
end



 -- Including : C:\tiproject\finance\src\math\tables\normal\table2.lua


normal.table2={}
normal.table2.start = 0
normal.table2.step =0.001
normal.table2.val = {
   infinit_sym, 3.0902, 2.8182, 2.7478, 2.6521, 2.5758, 2.5121, 2.4573, 2.4089, 2.3656, 
   2.3263,      2.2904, 2.2571, 2.2262, 2.1973, 2.1701, 2.1444, 2.1201, 2.0969, 2.0749,
   2.0537,      2.0335, 2.0141, 1.9954, 1.9774, 1.9600, 1.9431, 1.9268, 1.9110, 1.8957,
   1.8808,      1.8663, 1.8522, 1.8384, 1.8250, 1.8119, 1.7991, 1.7866, 1.7744, 1.7624,
   1.7507,      1.7392, 1.7279, 1.7169, 1.7060, 1.6954, 1.6849, 1.6747, 1.6646, 1.6546,
   
   1.6449,      1.6352, 1.6258, 1.6164, 1.6072, 1.5982, 1.5893, 1.5805, 1.5718, 1.5632,
   1.5548,      1.5464, 1.5382, 1.5301, 1.5220, 1.5141, 1.5063, 1.4985, 1.4909, 1.4833,
   1.4758,      1.4684, 1.4611, 1.4538, 1.4466, 1.4395, 1.4325, 1.4255, 1.4187, 1.4118,
   1.4051,      1.3984, 1.3917, 1.3852, 1.3787, 1.3722, 1.3658, 1.3595, 1.3532, 1.3469,
   1.3408,      1.3346, 1.3285, 1.3225, 1.3165, 1.3106, 1.3047, 1.2988, 1.2930, 1.2873,
   
   1.2816,      1.2759, 1.2702, 1.2646, 1.2591, 1.2536, 1.2481, 1.2426, 1.2372, 1.2319,
   1.2265,      1.2212, 1.2160, 1.2107, 1.2055, 1.2004, 1.1952, 1.1901, 1.1850, 1.1800,
   1.1750,      1.1700, 1.1650, 1.1601, 1.1552, 1.1503, 1.1455, 1.1407, 1.1359, 1.1311,
   1.1264,      1.1217, 1.1170, 1.1123, 1.1077, 1.1031, 1.0985, 1.0939, 1.0893, 1.0848,
   1.0803,      1.0758, 1.0714, 1.0669, 1.0625, 1.0581, 1.0537, 1.0494, 1.0450, 1.0407,
   
   1.0364,      1.0322, 1.0279, 1.0237, 1.0194, 1.0152, 1.0110, 1.0069, 1.0027, 0.9986,
   0.9945,      0.9904, 0.9863, 0.9822, 0.9782, 0.9741, 0.9701, 0.9661, 0.9621, 0.9581,
   0.9542,      0.9502, 0.9463, 0.9424, 0.9385, 0.9346, 0.9307, 0.9269, 0.9230, 0.9192,
   0.9154,      0.9116, 0.9078, 0.9040, 0.9002, 0.8965, 0.8927, 0.8890, 0.8853, 0.8813,
   0.8779,      0.8742, 0.8705, 0.8669, 0.8633, 0.8596, 0.8560, 0.8524, 0.8488, 0.8452,
   
   0.8416,      0.8381, 0.8345, 0.8310, 0.8274, 0.8239, 0.8204, 0.8169, 0.8134, 0.8099,
   0.8064,      0.8030, 0.7995, 0.7961, 0.7926, 0.7892, 0.7858, 0.7824, 0.7790, 0.7755,
   0.7722,      0.7688, 0.7655, 0.7621, 0.7588, 0.7554, 0.7521, 0.7488, 0.7454, 0.7421,
   0.7388,      0.7356, 0.7323, 0.7290, 0.7257, 0.7225, 0.7192, 0.7160, 0.7128, 0.7095,
   0.7063,      0.7031, 0.6999, 0.6967, 0.6935, 0.6903, 0.6871, 0.6840, 0.6808, 0.6776,
   
   0.6745,      0.6713, 0.6682, 0.6651, 0.6620, 0.6588, 0.6557, 0.6526, 0.6495, 0.6464,
   0.6433,      0.6403, 0.6372, 0.6341, 0.6311, 0.6280, 0.6250, 0.6219, 0.6189, 0.6158,
   0.6128,      0.6098, 0.6068, 0.6038, 0.6008, 0.5978, 0.5948, 0.5918, 0.5888, 0.5858,
   0.5828,      0.5799, 0.5769, 0.5740, 0.5710, 0.5681, 0.5651, 0.5622, 0.5592, 0.5568,
   0.5534,      0.5505, 0.5476, 0.5446, 0.5417, 0.5388, 0.5359, 0.5330, 0.5302, 0.5278,
   
   0.5244,      0.5215, 0.5187, 0.5158, 0.5129, 0.5101, 0.5072, 0.5044, 0.5015, 0.4987,
   0.4959,      0.4930, 0.4902, 0.4874, 0.4845, 0.4817, 0.4789, 0.4761, 0.4733, 0.4705,
   0.4677,      0.4649, 0.4621, 0.4593, 0.4565, 0.4538, 0.4510, 0.4482, 0.4454, 0.4427,
   0.4399,      0.4372, 0.4344, 0.4316, 0.4289, 0.4261, 0.4234, 0.4207, 0.4179, 0.4152,
   0.4125,      0.4097, 0.4070, 0.4043, 0.4016, 0.3989, 0.3961, 0.3934, 0.3907, 0.3880,
   
   0.3853,      0.3826, 0.3799, 0.3772, 0.3745, 0.3719, 0.3692, 0.3665, 0.3638, 0.3611,
   0.3585,      0.3558, 0.3531, 0.3505, 0.3478, 0.3451, 0.3425, 0.3398, 0.3372, 0.3345,
   0.3319,      0.3292, 0.3266, 0.3239, 0.3213, 0.3186, 0.3160, 0.3134, 0.3107, 0.3081,
   0.3055,      0.3029, 0.3002, 0.2976, 0.2950, 0.2924, 0.2898, 0.2871, 0.2845, 0.2819,
   0.2793,      0.2767, 0.2741, 0.2715, 0.2689, 0.2663, 0.2637, 0.2611, 0.2585, 0.2553,
   
   0.2533,      0.2508, 0.2482, 0.2456, 0.2430, 0.2404, 0.2378, 0.2353, 0.2327, 0.2301,
   0.2275,      0.2250, 0.2224, 0.2198, 0.2173, 0.2147, 0.2121, 0.2096, 0.2070, 0.2045,
   0.2019,      0.1993, 0.1968, 0.1942, 0.1917, 0.1891, 0.1866, 0.1840, 0.1815, 0.1789,
   0.1764,      0.1738, 0.1713, 0.1687, 0.1662, 0.1637, 0.1611, 0.1586, 0.1560, 0.1535,
   0.1510,      0.1484, 0.1459, 0.1434, 0.1408, 0.1383, 0.1358, 0.1332, 0.1307, 0.1282,
   
   0.1257,      0.1231, 0.1206, 0.1181, 0.1156, 0.1130, 0.1105, 0.1080, 0.1055, 0.1030,
   0.1004,      0.0979, 0.0954, 0.0929, 0.0904, 0.0878, 0.0853, 0.0828, 0.0803, 0.0773,
   0.0753,      0.0728, 0.0702, 0.0677, 0.0652, 0.0627, 0.0602, 0.0577, 0.0552, 0.0527,
   0.0502,      0.0476, 0.0451, 0.0426, 0.0401, 0.0376, 0.0351, 0.0326, 0.0301, 0.0276,
   0.0251,      0.0226, 0.0201, 0.0175, 0.0150, 0.0125, 0.0100, 0.0075, 0.0050, 0.0025,
   0.0000,
}

function normal.table2.size()
   return table.getn(normal.table2.val)
end

LoiNormalSplCalc = Spl2Params(LOI_NORMAL_1VAR_TITLE_ID,LOI_NORMAL_1VAR_HEADER_ID,ENTER_MU_ID,ENTER_SIGMA_ID)


function LoiNormalSplCalc:performEx(mu,sigma)
   return "\\0el {E(X)="..c_mu.."="..tostring(mu).."}"
end

function LoiNormalSplCalc:performVx(mu,sigma)
   local calc = "("..tostring(sigma)..")^2"
   local res = "\\0el {V(X)="..c_sigma.."^2="..tostring(calc).."}="
   local result,err = math.evalStr(tostring(calc))
   local resulta,erra = math.evalStr("approx("..tostring(calc)..")")
   res=res.."\\0el {"..tostring(result).."="..tostring(resulta).."}\n"
   if err then
        res = res.."ERROR:"..tostring(err).."\n"
   end        
   if erra then
        res = res.."ERROR:"..tostring(erra).."\n"
   end  
   return res
end

function LoiNormalSplCalc:performCentrageReduction(mu,sigma,x1,compare1,compare2,x2)
   local res = "\\0el {Z=(X-"..c_mu..")/"..c_sigma.."}\n"
   local cx1=x1
   local cx2=x2
   local fcompare1 = compare1
   local fcompare2 = compare2
   if (tonumber(sigma)~=nil) and (tonumber(sigma)<0) then
          if (compare1=="<" or compare1=="<=") then
             fcompare1 = ">"
          elseif (compare1==">" or compare1==">=") then
             fcompare1 = "<"
          end
   
          if (compare2=="<" or compare2=="<=") then
             fcompare2 = ">"
          elseif (compare2==">" or compare2==">=") then
             fcompare2 = "<"
          end
   end 
   if (compare1~=nil and compare1~="" and compare1~="none") then
       res = res.."\\0el {P("..tostring(x1)..tostring(compare1).."X"..tostring(compare2)..tostring(x2)..")}"
       local calc = "(("..tostring(x2)..")-("..tostring(mu).."))/("..tostring(sigma)..")"
       cx2,err =math.evalStr(tostring(calc))
       if err then
        res = res.."ERROR:"..tostring(err).."\n"
       end
       calc = "(("..tostring(x1)..")-("..tostring(mu).."))/("..tostring(sigma)..")"
       cx1,err =math.evalStr(tostring(calc))
       if err then
        res = res.."ERROR:"..tostring(err).."\n"
       end
       res = res.."=\\0el {P("..tostring(cx1)..tostring(fcompare1).."Z"..tostring(fcompare2)..tostring(cx2)..")}"
   else
       res = res.."=\\0el {P(X"..tostring(compare2)..tostring(x2)..")}"
       local calc = "(("..tostring(x2)..")-("..tostring(mu).."))/("..tostring(sigma)..")"
       cx2,err =math.evalStr(tostring(calc))
       if err then
        res = res.."ERROR:"..tostring(err).."\n"
       end       
       res = res.."=\\0el {P(Z"..tostring(fcompare2)..tostring(cx2)..")}"
   end
   return res,cx1,fcompare1,fcompare2,cx2
end

function LoiNormalSplCalc:performSmaller(mu,sigma,x)
   local calc="normCdf(−"..infinit_sym..","..tostring(x)..","..tostring(mu)..","..tostring(sigma)..")"
   local result,err=math.evalStr(tostring(calc))
   local resulta,erra = math.evalStr("approx("..tostring(calc)..")")
   local res="=\\0el {"..tostring(result).."="..tostring(resulta).."}\n"
   if err then
        res = res.."ERROR:"..tostring(err).."\n"
   end        
   if erra then
        res = res.."ERROR:"..tostring(erra).."\n"
   end  
   return res
end

function LoiNormalSplCalc:resolveUsingTiFunc(x1,fcompare1,fcompare2,x2,mu,sigma)
   res = "NormCdf("
   if (fcompare1=="none" or string.isempty(x1)) then
      res=res.."-"..infinit_sym..","
   else
      res=res..tostring(x1)..","
   end
   if (fcompare2=="none" or string.isempty(x2)) then
      res=res..infinit_sym..","
   elseif (fcompare2=="<") then
      res= res..tostring(x2)..","
   elseif (fcompare2==">") then
      res= res..tostring(x2)..","
   else
      res= "1-"..res..fcompare2;
   end
   res = res..mu..","..sigma..")"
   local calca,errcalc=math.evalStr(res)
   if errcalc then
        res = res.."ERROR:"..tostring(errcalc).."\n"
   end
   local calcb,errcalc=math.evalStr("approx("..res..")")         
   if errcalc then
        res = res.."ERROR:"..tostring(errcalc).."\n"
   end
   res = res .. "=\\0el {"..tostring(calca).."}=\\0el {"..tostring(calcb).."}\n"
   return res
end

function LoiNormalSplCalc:performNormal(mu,sigma,x1,compare1,compare2,x2)
   if (string.isempty(compare2) or compare2=="none" or compare2=="=") then
       return "\\0el {P(X"..tostring(compare2)..tostring(x2)..")=0}="
   end
   
   local res = self:getEqualityAsTxt(x1,compare1,compare2,x2)
   local fcompare1=self:removeEquals(compare1)
   local fcompare2=self:removeEquals(compare2)
   if (fcompare1~=compare1) or (fcompare2~=compare2) then
      res = res..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."="
   end
   res = res..self:resolveUsingTiFunc(x1,fcompare1,fcompare2,x2,mu,sigma);
   
   if (compare=="All") then
       return ASTxt(NOT_SUPPORTED_ID)
   end
   
   local toadd,cx1,fcompare1,fcompare2,cx2 =self:performCentrageReduction(mu,sigma,x1,fcompare1,fcompare2,x2)
   if (fcompare1=="none") and (fcompare2==">") then
      fcompare2="<"
      local sres,sresval=self:performSmaller(mu,sigma,x2)
      local calc,errcalc=math.evalStr("1-"..tostring(sresval))   
      local calca,errcalc=math.evalStr("approx(1-"..tostring(sresval)..")")         
   if errcalc then
        res = res.."ERROR:"..tostring(errcalc).."\n"
   end  
      res = res.."=\\0el {1-"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}=\\0el {"..calc.."}=\\0el {"..calca.."}="
      res = res.."\n \\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}="      
      res = res..sres
      res = res..tostring(toadd)
      res = res.."\n \\0el {P(Z"..tostring(compare2)..tostring(cx2)..")=0}="
      print("cx2="..tostring(cx2))
      cx2=tiNspire.execute("approx("..tostring(cx2)..")")
      print("cx2="..tostring(cx2))
      res = res.."\\0el {P(Z"..tostring(compare2)..tostring(cx2)..")=0}="
      
      local cres,cresval=self:performSmaller(0,1,cx2)
      res = res..cres
      res=res.."\n"..tostring(toadd)
      res=res.."\n Resolution with table P(Z<"..tostring(cx2)..")="..tostring(normal.table1.resolveFu(cx2))
      
   elseif (fcompare1=="none") and (fcompare2=="<") then
      res = res.."=\\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}="
      local sres,sresval=self:performSmaller(mu,sigma,x2)
      local calc,errcalc=math.evalStr(tostring(sresval))   
      local calca,errcalc=math.evalStr("approx("..tostring(sresval)..")")         
      if errcalc then
          res = res.."ERROR:"..tostring(errcalc).."\n"
      end
      res = res..tostring(toadd)
      res = res..self:performSmaller(0,1,cx2)
      res = res.."=\\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}=\\0el {"..calc.."}=\\0el {"..calca.."}="
      res = res.."\n \\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}="      
      print("cx2="..tostring(cx2))
      cx2=tiNspire.execute("approx("..tostring(cx2)..")")
      print("cx2="..tostring(cx2))
      res = res.."\\0el {P(Z"..tostring(compare2)..tostring(cx2)..")=0}="
      
      local cres,cresval=self:performSmaller(0,1,cx2)
      res = res..cres
      res=res.."\n"..tostring(toadd)
      res=res.."\n Resolution with table P(Z<"..tostring(cx2)..")="..tostring(normal.table1.resolveFu(cx2))
       
   else 
       return ASTxt(NOT_SUPPORTED_ID)
   end   
   return res
end

function LoiNormalSplCalc:perform()
    print("LoiNormalSplCalc:perform")
    self.font ={"sansserif", "r", 10}
    local mu,sigma,x1,compare1,compare2,x2 =self:extractTxt()
    self.operation=""
    if (tostring(mu)=="nil") or tostring(mu)=="" then
      return
    end
    
    if (tostring(sigma)=="nil") or tostring(sigma)=="" then
      return 
    end

    local ex = self:performEx(mu,sigma)
    local vx = self:performVx(mu,sigma)
    
    
    self.operation=tostring(ex).."\n"..tostring(vx)
    

    if (tostring(x2)=="nil") or tostring(x2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end



    if (tostring(compare1)=="nil") or tostring(compare1)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    if (tostring(compare2)=="nil") or tostring(compare2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    self.operation=self:performNormal(mu,sigma,x1,compare1,compare2,x2).."\n"..tostring(ex).."\n"..tostring(vx)

    self:invalidate()
end

 -- Including : C:\tiproject\finance\src\ui\math\continue\chi2\chi2.lua


 -- Including : C:\tiproject\finance\src\math\tables\chi2\table.lua

chi2={}
chi2.table={}
chi2.table.start = 0
chi2.table.step =0.001
chi2.table.val = {
    0.000000393,  0.00000157,  0.0000393,  0.000157,  0.000982,  0.00393,  0.0158,  0.0642,  0.148,  0.275,  0.455,  0.708,  1.074,  1.642,  2.706,  3.841,  3.024,  6.635,  7.879, 10.828, 12.116,
    0.00100    ,  0.00200   ,  0.0100   ,  0.0201  ,  0.0506  ,  0.103  ,  0.211 ,  0.446 ,  0.713,  1.022,  1.386,  1.833,  2.408,  3.219,  4.605,  5.991,  7.378,  9.210, 10.597, 13.816, 15.202,
    0.0150     ,  0.0243    ,  0.0717   ,  0.115   ,  0.216   ,  0.352  ,  0.584 ,  1.005 ,  1.424,  1.869,  2.366,  2.946,  3.665,  4.642,  6.251,  7.815,  9.348, 11.345, 12.838, 16.266, 17.730, 
    0.0639     ,  0.0908    ,  0.207    ,  0.297   ,  0.484   ,  0.711  ,  1.064 ,  1.649 ,  2.195,  2.753,  3.357,  4.045,  4.878,  5.989,  7.779,  9.488, 11.143, 13.277, 14.860, 18.467, 19.998,
   
    0.158      ,  0.210     ,  0.412    ,  0.554   ,  0.831   ,  1.145  ,  1.610 ,  2.343 ,  3.000,  3.655,  4.351,  5.132,  6.064,  7.289,  9.236, 11.070, 12.832, 15.086, 16.750, 20.515, 22.105,  
    0.299      ,  0.381     ,  0.676    ,  0.872   ,  1.237   ,  1.635  ,  2.204 ,  3.070 ,  3.828,  4.570,  5.348,  6.211,  7.231,  8.558, 10.645, 12.592, 14.449, 16.812, 18.548, 22.458, 24.103,
    0.485      ,  0.598     ,  0.989    ,  1.239   ,  1.690   ,  2.167  ,  2.833 ,  3.822 ,  4.671,  5.493,  6.346,  7.283,  8.383,  9.803, 12.017, 14.067, 16.013, 18.475, 20.278, 24.322, 26.018,
    0.710      ,  0.857     ,  1.344    ,  1.646   ,  2.180   ,  2.733  ,  3.490 ,  4.594 ,  5.527,  6.423,  7.344,  8.351,  9.624, 11.030, 13.362, 15.507, 17.535, 20.090, 21.955, 26.125, 27.868,
    0.972      ,  1.153     ,  1.735    ,  2.088   ,  2.700   ,  3.325  ,  4.168 ,  5.380 ,  6.393,  7.393,  8.343,  9.414, 10.656, 12.242, 14.684, 16.919, 19.023, 21.666, 23.585, 27.877, 29.666,
   
    1.265      ,  1.479     ,  2.151    ,  2.558   ,  3.247   ,  3.940  ,  4.865 ,  6.179 ,  7.267,  8.295,  9.342, 10.473, 11.781, 13.442, 15.987, 18.307, 20.483, 23.209, 25.188, 29.588, 31.419,
    1.587      ,  1.834     ,  2.603    ,  3.053   ,  3.816   ,  4.575  ,  5.578 ,  6.989 ,  8.148,  9.237, 10.341, 11.530, 12.899, 14.631, 17.275, 19.675, 21.920, 24.725, 26.757, 31.264, 33.136,
    1.934      ,  2.214     ,  3.074    ,  3.571   ,  4.404   ,  5.226  ,  6.304 ,  7.807 ,  9.034, 10.182, 11.340, 12.584, 14.011, 15.812, 18.549, 21.026, 23.336, 26.217, 28.300, 32.909, 34.821,
    2.305      ,  2.617     ,  3.565    ,  4.107   ,  5.009   ,  5.892  ,  7.042 ,  8.634 ,  9.926, 11.129, 12.340, 13.636, 15.119, 16.985, 19.812, 22.362, 24.736, 27.688, 29.818, 34.528, 36.478,
    2.697      ,  3.041     ,  4.075    ,  4.660   ,  5.629   ,  6.571  ,  7.790 ,  9.467 , 10.821, 12.079, 13.339, 14.685, 16.222, 18.151, 21.064, 23.685, 26.119, 29.141, 31.319, 36.123, 38.109,
   
    3.108      ,  3.483     ,  4.601    ,  5.229   ,  5.262   ,  7.261  ,  8.547 , 10.307 , 11.721, 13.030, 14.339, 15.733, 17.322, 19.311, 22.307, 24.996, 27.488, 30.578, 32.801, 37.697, 39.719,
    3.536      ,  3.942     ,  5.142    ,  5.812   ,  6.908   ,  7.962  ,  9.312 , 11.152 , 12.624, 13.983, 15.338, 16.780, 18.418, 20.465, 23.542, 26.296, 28.845, 32.000, 34.267, 39.252, 41.308,
    3.980      ,  4.416     ,  5.697    ,  6.408   ,  7.564   ,  8.672  , 10.085 , 12.002 , 13.531, 14.937, 16.338, 17.824, 19.511, 21.615, 24.769, 27.587, 30.191, 33.409, 35.718, 40.790, 42.879,
    4.439      ,  4.905     ,  6.265    ,  7.015   ,  8.231   ,  9.390  , 10.865 , 12.857 , 14.440, 15.893, 17.338, 18.868, 20.601, 22.750, 25.989, 28.869, 31.526, 34.805, 37.156, 42.312, 44.434,    
    4.912      ,  5.407     ,  6.844    ,  7.633   ,  8.907   , 10.117  , 11.651 , 13.716 , 15.352, 16.850, 18.338, 19.910, 21.689, 23.900, 27.204, 30.144, 32.852, 36.191, 38.582, 43.820, 45.973,
   
    5.398      ,  5.921     ,  7.434    ,  8.260   ,  9.591   , 10.851  , 12.443 , 14.578 , 16.266, 17.809, 19.337, 20.951, 22.775, 25.038, 28.412, 31.410, 34.170, 37.566, 39.997, 45.315, 47.498,
    5.896      ,  6.447     ,  8.034    ,  8.897   , 10.283   , 11.591  , 13.240 , 15.445 , 17.182, 18.768, 20.337, 21.991, 23.858, 26.171, 29.615, 32.671, 35.479, 38.932, 41.401, 46.797, 49.010, 
    6.405      ,  6.983     ,  8.643    ,  9.542   , 10.982   , 12.338  , 14.041 , 16.314 , 18.101, 19.729, 21.337, 23.031, 24.939, 27.301, 30.813, 33.924, 36.781, 40.289, 42.796, 48.268, 50.511, 
    6.924      ,  7.529     ,  9.260    , 10.196   , 11.688   , 13.091  , 14.848 , 17.187 , 19.021, 20.690, 22.337, 24.069, 26.018, 28.429, 32.007, 35.172, 38.076, 41.638, 44.181, 49.728, 52.000,
    7.453      ,  8.085     ,  9.886    , 10.856   , 12.401   , 13.848  , 15.659 , 18.062 , 19.943, 21.652, 23.337, 25.106, 27.096, 29.553, 33.196, 36.415, 39.364, 42.980, 45.558, 51.179, 53.479,
   
    7.991      ,  8.649     , 10.520    , 11.524   , 13.120   , 14.611  , 16.473 , 18.940 , 20.867, 22.616, 24.337, 26.143, 28.172, 30.675, 34.382, 37.652, 40.646, 44.314, 46.928, 52.620, 54.947,
    8.538      ,  9.222     , 11.160    , 12.198   , 13.844   , 15.379  , 17.292 , 19.820 , 21.792, 23.579, 25.336, 27.179, 29.246, 31.795, 35.563, 38.885, 41.923, 45.642, 48.290, 54.052, 56.407,
    9.093      ,  9.803     , 11.808    , 12.879   , 14.573   , 16.151  , 18.114 , 20.703 , 22.719, 24.544, 26.336, 28.214, 30.319, 32.912, 36.741, 40.113, 43.194, 46.963, 49.645, 55.476, 57.858,
    9.656      , 10.391     , 12.461    , 13.565   , 15.308   , 16.928  , 18.939 , 21.588 , 23.647, 25.509, 27.336, 29.249, 31.391, 34.027, 37.916, 41.337, 44.461, 48.278, 50.993, 56.892, 59.300,
   10.227      , 10.986     , 13.121    , 14.256   , 16.047   , 17.708  , 19.768 , 22.475 , 24.577, 26.475, 28.336, 30.283, 32.461, 35.139, 39.087, 42.557, 45.722, 49.588, 52.336, 58.302, 60.734,
   
   10.804      , 11.588     , 13.787    , 14.953   , 16.791   , 18.493  , 20.599 , 23.364 , 25.508, 27.442, 29.336, 31.316, 33.530, 36.250, 40.256, 43.773, 46.979, 50.892, 53.672, 59.703, 62.161,
   11.389      , 12.196     , 13.458    , 15.655   , 17.539   , 19.281  , 21.434 , 24.255 , 26.440, 28.409, 30.336, 32.349, 34.598, 37.359, 41.422, 44.985, 48.232, 52.191, 55.003, 61.098, 63.582,
   11.979      , 12.811     , 15.134    , 16.362   , 18.291   , 20.072  , 22.271 , 25.148 , 27.373, 29.376, 31.336, 33.381, 35.665, 38.466, 42.585, 46.194, 49.480, 53.486, 56.328, 62.487, 64.995,
   12.576      , 13.431     , 15.815    , 17.073   , 19.047   , 20.867  , 23.110 , 26.042 , 28.307, 30.344, 32.336, 34.413, 36.731, 39.572, 43.745, 47.400, 50.725, 54.776, 57.648, 63.870, 66.402,
   13.179      , 14.057     , 16.501    , 17.789   , 19.806   , 21.664  , 23.952 , 26.938 , 29.242, 31.313, 33.336, 35.444, 37.795, 40.676, 44.903, 48.602, 51.966, 56.061, 58.964, 65.247, 67.803,
   
   13.788      , 14.688     , 17.192    , 18.509   , 20.569   , 22.465  , 24.797 , 27.836 , 30.178, 32.282, 34.336, 36.475, 38.859, 41.778, 46.059, 49.802, 53.203, 57.342, 60.275, 66.619, 69.198,
   14.401      , 15.324     , 17.887    , 19.233   , 21.336   , 23.269  , 25.643 , 28.735 , 31.115, 33.252, 35.336, 37.505, 39.922, 42.879, 47.212, 50.998, 54.437, 58.619, 61.581, 67.985, 70.588,   
   15.020      , 15.965     , 18.586    , 19.960   , 22.106   , 24.075  , 26.492 , 29.635 , 32.053, 34.222, 36.336, 38.535, 40.984, 43.978, 48.363, 52.192, 55.668, 59.892, 62.883, 69.346, 71.972,  
   15.644      , 16.611     , 19.289    , 20.691   , 22.878   , 24.884  , 27.343 , 30.537 , 32.992, 35.192, 37.335, 39.564, 42.045, 45.076, 49.513, 53.384, 56.895, 61.162, 64.181, 70.703, 73.351, 
   16.273      , 17.261     , 19.996    , 21.426   , 23.654   , 25.695  , 28.196 , 31.441 , 33.932, 36.163, 38.335, 40.593, 43.105, 46.173, 50.660, 54.572, 58.120, 62.428, 65.476, 72.055, 74.725,
   
   16.906      , 17.916     , 20.707    , 22.164   , 24.433   , 26.509  , 29.051 , 32.345 , 34.872, 37.134, 39.335, 41.622, 44.165, 47.269, 51.805, 55.758, 59.342, 63.691, 66.766, 73.402, 76.095,
   17.544      , 18.575     , 21.421    , 22.906   , 25.215   , 27.326  , 29.907 , 33.251 , 35.813, 38.105, 40.335, 42.651, 45.224, 48.363, 52.949, 56.942, 60.561, 64.950, 68.053, 74.745, 77.459,
   18.184      , 19.238     , 22.138    , 23.650   , 25.999   , 28.144  , 30.765 , 34.157 , 36.755, 39.077, 41.335, 43.679, 46.282, 49.456, 54.090, 58.124, 61.777, 66.206, 69.336, 76.084, 78.820, 
   18.832      , 19.905     , 22.859    , 24.398   , 26.785   , 28.965  , 31.625 , 35.065 , 37.698, 40.050, 42.335, 44.706, 47.339, 50.548, 55.230, 59.304, 62.990, 67.459, 70.616, 77.418, 80.176,
   19.482      , 20.576     , 23.584    , 25.148   , 27.575   , 29.787  , 32.487 , 35.974 , 38.641, 41.022, 43.335, 45.734, 48.396, 51.639, 56.369, 60.481, 64.201, 68.709, 71.893, 78.749, 81.528,
   
   20.136      , 21.251     , 24.311    , 25.901   ,
   20.794      , 21.929     , 25.041    , 
   21.456      , 22.610     ,
   22.121      , 23.295     ,
   22.789      , 23.983     ,
   
   23.461      , 24.674     ,
}

function chi2.table.size()
   return table.getn(chi2.table2.val)
end

print("chi2.table.size()="..chi2.table2.size())

 -- Including : C:\tiproject\finance\src\proba\..\ui\math\testNormalite\testNormalite.lua

 

 -- Including : C:\tiproject\finance\src\ui\math\testechantillons.lua



EchantillonTst = addExtension(Screen,WidgetManager)
 

function EchantillonTst:init(titleId,headerId,enterParam1Id,enterParam2Id)
  print("init EchantillonTst")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 10}
  self.operation = ""
  self.n= "n"
  self.p="p"
  self.r=0
  self.widgets  = {}
  self.enterEchantillon = sInput()
  self.enterEchantillon:setWidth(300)
  self.enterEchantillonLabel = sLabel(ASTxt(enterParam1Id),self.enterEchantillon) 
  self.Box = sMathInput(0,0)
  self.htitle=20    
  self.focus  = 0
  self:size()
  print("end EchantillonTst num of widget="..tostring(table.getn(self.widgets)))
end
 
function EchantillonTst:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h))
      self.lasth=self.h
      self.lastw=self.w
      
      self.htmp =self.htitle+5
      self.enterNLabelX=0
      self.enterNLabel:setPos(0, self.htmp)
      self.enterNX=self.enterNLabelX+52
      self.enterN:setPos(self.enterNX, self.htmp)
      self.enterN.number=false
      self.enterN:enable()
      self.enterPLabelX=self.enterNX+160
      self.enterPLabel:setPos(self.enterPLabelX,self.htmp)
      self.enterPX=self.enterPLabelX+52
      self.enterP:setPos(self.enterPX, self.htmp)
      self.enterP.number=false
      self.enterP:enable()
      self.htmp2=self.htmp+22
      self.enterk1Y=self.htmp2+2
      self.enterk2Y=self.htmp2+2
      
      
      self.pstartLabelY=self.htmp2
      self.pstartLabelX=10
      self.enterk1X=self.pstartLabelX+22
      self.equalityTypeY=self.htmp2
      self.equalityType0Y=self.htmp2
      self.equalityType0X=self.enterk1X+30
      self.XLabelX=self.equalityType0X+80
      self.XLabelY=self.htmp2
      self.equalityTypeX=self.XLabelX+15
      self.enterk2X=self.equalityTypeX+80
      self.pendLabelY=self.htmp2
      self.pendLabelX=self.enterk2X+30
      self.pstartLabel:setPos(self.pstartLabelX, self.pstartLabelY)
      self.XLabel:setPos(self.XLabelX, self.XLabelY)
      self.equalityType0:setPos(self.equalityType0X, self.equalityType0Y)
      self.equalityType:setPos(self.equalityTypeX, self.equalityTypeY)
      self.pendLabel:setPos(self.pendLabelX, self.pendLabelY)
      
      self.boxX=4
      self.boxY=30+self.htmp2 
      self.boxW= self.w-(2*self.boxX)
      self.boxH=self.h-self.boxY-2
      self:invalidate()
      print("return true")
      return true
   end
   return false
end

function EchantillonTst:refreshBox()
  self.x=0
  self.y=0
  self.ww = pww()
  self.hh = pwh()
  self:calculateSize()
end
   

function EchantillonTst:postPaint(gc)
    self:refreshBox()
end

function  EchantillonTst:removeEquals(compare)
   local fcompare=compare
   if (compare=="<=") then
      fcompare="<"
   elseif compare==">=" then
      fcompare=">"
   end
   return fcompare
end

function EchantillonTst:getEqualityAsTxt(k1,compare1,compare2,k2)
  if compare1==nil or compare1=="" or compare1=="none" then
     return "P(X"..tostring(compare2)..tostring(k2)..")"
  end
  return "P("..tostring(k1)..tostring(compare1).."X"..tostring(compare2)..tostring(k2)..")"
end

function EchantillonTst:extractTxt()
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="n"
  end
  if(self.enterP) then
     self.p=self.enterP.value
  else
     print("Warning : enterp is null")
     self.p="p"
  end
  
  if(self.enterk1) then
     self.k1=self.enterk1.value
  else
     print("Warning : enterk1 is null")
     self.k1=""
  end

  if(self.enterk2) then
     self.k2=self.enterk2.value
  else
     print("Warning : enterk2 is null")
     self.k2=""
  end
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="none"
  end
  
  if(self.equalityType0) then
     self.compare1 = self.equalityType0.value
  else
     print("Warning : equalityType0 is null")
     self.compare1="none"
  end
    
  if(self.equalityType) then
     self.compare2 = self.equalityType.value
  else
     print("Warning : equalityType is null")
     self.compare2="none"
  end

  return self.n,self.p,self.k1,self.compare1,self.compare2,self.k2
end

function EchantillonTst:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function  EchantillonTst:pushed()
    print("EchantillonTst:pushed")
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.n= "n"
    self.p="p"
    self.widgets  = {}
    
    self:appendWidget(self.enterNLabel, self.enterNLabelX, self.htmp)
    self:appendWidget(self.enterN, self.enterNX, self.htmp)
    self.enterN.focusDown = 1
    self:appendWidget(self.enterPLabel, self.enterPLabelX, self.htmp)
    self:appendWidget(self.enterP, self.enterPX, self.htmp)
    
    self:appendWidget(self.pstartLabel,self.pstartLabelX, self.pstartLabelY)
    self:appendWidget(self.enterk1, self.enterk1X, self.enterk1Y)
    self:appendWidget(self.equalityType0, self.equalityType0X, self.equalityType0Y)
    self:appendWidget(self.XLabel, self.XLabelX, self.XLabelY)
    self:appendWidget(self.equalityType, self.equalityTypeX, self.equalityTypeY)
    self:appendWidget(self.enterk2, self.enterk2X, self.enterk2Y)
    self:appendWidget(self.pendLabel,self.pendLabelX, self.pendLabelY)
            function self.equalityType:change()
                self.parent:firePerform()
            end
            function self.enterN:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterP:enterKey()
                self.parent.Box:setFocus(true)
            end
            function self.enterk2:enterKey()
                self.parent.Box:setFocus(true)
                self.parent:firePerform()
            end
            function self.enterk2:onChange()
                self.parent:firePerform()
            end
            function self.equalityType:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType:onClose()
                self.parent.Box:setVisible(true)
                if (self.value~="<=" or self.value~="<") then
                   self.parent.equalityType0.value="none"
                end
            end
            function self.equalityType0:change()
                self.parent:firePerform()
            end
            function self.equalityType0:onOpen()
                self.parent.Box:setVisible(false)
            end
            function self.equalityType0:onClose()
                if (self.value=="<=" or self.value=="<") and (self.parent.equalityType.value~="<=" and self.value~="<") then
                   self.parent.equalityType.sList.sel=self.value
                   self.parent.equalityType.value=self.value
                end
                self.parent.Box:setVisible(true)
            end
    
    
    self.Box:setSize(self.boxW,self.boxH)
    self:appendWidget(self.Box,self.boxX,self.boxY)
    self.enterN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    self.Box:setColorable(true)
    self.Box:setTextColor(0x215c98)
    self.Box:setExpression(form)
    self.Box:setFocus(false)
    self:invalidate()
end


function EchantillonTst:screenGetFocus()
    self:pushed()
end

function EchantillonTst:screenLoseFocus()
end


function EchantillonTst:removed()
    self.Box:setVisible(false)
    self.Box:setExpression("")
    self.Box:setFocus(false)
    doNotDisplayIcon = false
end
 
 
function EchantillonTst:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,EchantillonTst.font)
  local n,p=self:extractTxt()
  if (self.lastInput~=tostring(n)..","..tostring(p)) then
     self:firePerform()
     self.lastInput=tostring(n)..","..tostring(p)
     local form =tostring(self.header)..tostring(self.operation)
     self.Box:setExpression(form);
  end
end

function EchantillonTst:firePerform()
    self.Box:setVisible(true)
    self:perform()
end


function EchantillonTst:perform()
end

function EchantillonTst:escapeKey()
  local cid = self.cid
  print("before : "..tostring(cid))
  self:removed()
  print(tostring(cid))
  if cid then
    only_screen_back(SubCatSel, self.cid)
    print("reset cid")
    self.cid = nil
    self.sid = nil
    return
  end
  only_screen_back(Ref)
end




 -- Including : C:\tiproject\finance\src\ui\math\testNormalite\wilcoxon\testNormaliteWilcoxon.lua

TestNormaliteWilcoxon = EchantillonTst(LOI_NORMAL_1VAR_TITLE_ID,LOI_NORMAL_1VAR_HEADER_ID,ENTER_MU_ID,ENTER_SIGMA_ID)


function TestNormaliteWilcoxon:perform()
    print("TestNormaliteWilcoxon:perform")
    self.font ={"sansserif", "r", 10}
    local mu,sigma,x1,compare1,compare2,x2 =self:extractTxt()
    self.operation=""
    if (tostring(mu)=="nil") or tostring(mu)=="" then
      return
    end
    
    if (tostring(sigma)=="nil") or tostring(sigma)=="" then
      return 
    end

    local ex = self:performEx(mu,sigma)
    local vx = self:performVx(mu,sigma)
    
    
    self.operation=tostring(ex).."\n"..tostring(vx)
    

    if (tostring(x2)=="nil") or tostring(x2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end



    if (tostring(compare1)=="nil") or tostring(compare1)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    if (tostring(compare2)=="nil") or tostring(compare2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    self.operation=self:performNormal(mu,sigma,x1,compare1,compare2,x2).."\n"..tostring(ex).."\n"..tostring(vx)

    self:invalidate()
end

addCat(1, ASTxt(CATEGORY_COMBINATOIRE_ID), ASTxt(CATEGORY_COMBINATOIRE_DESC_ID))

addSubCatScreen(1,1,ASTxt(ARRANGEMENT_AVEC_REP_TITLE_ID),ASTxt(ARRANGEMENT_AVEC_REP_HEADER_ID),ArrangementAvecRep)
addSubCatScreen(1,2,ASTxt(ARRANGEMENT_SANS_REP_TITLE_ID),ASTxt(ARRANGEMENT_SANS_REP_HEADER_ID),ArrangementSansRep)
addSubCatScreen(1,3,ASTxt(COMBINAISONS_AVEC_REP_TITLE_ID),ASTxt(COMBINAISONS_AVEC_REP_HEADER_ID),CombinaisonsAvecRep)
addSubCatScreen(1,4,ASTxt(COMBINAISONS_SANS_REP_TITLE_ID),ASTxt(COMBINAISONS_SANS_REP_HEADER_ID),CombinaisonsSansRep)
addSubCatScreen(1,5,ASTxt(PERMUTATION_AVEC_REP_TITLE_ID),ASTxt(PERMUTATION_AVEC_REP_HEADER_ID),PermutationAvecRep)
addSubCatScreen(1,6,ASTxt(PERMUTATION_SANS_REP_TITLE_ID),ASTxt(PERMUTATION_SANS_REP_HEADER_ID),PermutationSansRep)
addSubCatScreen(1,7,ASTxt(PARTITION_NON_ORD_TITLE_ID),ASTxt(PARTITION_NON_ORD_HEADER_ID),PartitionNonOrd)




addCat(2, ASTxt(CATEGORY_LOIS_DISCRETES_ID), ASTxt(CATEGORY_LOIS_DISCRETES_DESC_ID))
addSubCatScreen(2,1,ASTxt(LOI_UNIFORME_1VAR_TITLE_ID),ASTxt(LOI_UNIFORME_1VAR_HEADER_ID),LoiUniforme)
addSubCatScreen(2,2,ASTxt(LOI_BERNOULLI_1VAR_TITLE_ID),ASTxt(LOI_BERNOULLI_1VAR_HEADER_ID),LoiBernoulli)
addSubCatScreen(2,3,ASTxt(LOI_BINOMIAL_1VAR_TITLE_ID),ASTxt(LOI_BINOMIAL_1VAR_HEADER_ID),LoiBinomialSplCalc)
addSubCatScreen(2,4,ASTxt(LOI_POISSON_1VAR_TITLE_ID),ASTxt(LOI_POISSON_1VAR_HEADER_ID),LoiPoisson)
addSubCatScreen(2,5,ASTxt(LOI_BINOMIAL_NEG_1VAR_TITLE_ID),ASTxt(LOI_BINOMIAL_NEG_1VAR_HEADER_ID),LoiBinomialNegSplCalc)
addSubCatScreen(2,6,ASTxt(LOI_GEOMETRIQUE_1VAR_TITLE_ID),ASTxt(LOI_GEOMETRIQUE_1VAR_HEADER_ID),LoiGeometriqueSplCalc)
addSubCatScreen(2,7,ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID),ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID),LoiHypergeometriqueSplCalc)




addCat(3, ASTxt(CATEGORY_LOIS_CONTINUE_ID), ASTxt(CATEGORY_LOIS_CONTINUE_DESC_ID))
addSubCatScreen(3,1,ASTxt(LOI_NORMAL_1VAR_TITLE_ID),ASTxt(LOI_NORMAL_1VAR_HEADER_ID),LoiNormalSplCalc)
addSubCatScreen(3,2,ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID),ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID),LoiHypergeometriqueSplCalc)


addCat(4, ASTxt(CATEGORY_TEST_NORMALITE_ID), ASTxt(CATEGORY_TEST_NORMALITE_DESC_ID))
addSubCatScreen(4,1,ASTxt(TEST_WILCOXON_ID),ASTxt(TEST_WILCOXON_HEADER_ID),TestNormaliteWilcoxon)



 -- Including : C:\tiproject\finance\src\math\math.lua




 -- Including : C:\tiproject\finance\src\math\tifunc\tia.lua

tiNspire={}

function tiNspire.execute(expression)
    if expression then       
       local res,err = math.evalStr(expression)
       if res then
         print("execute : "..expression.." returned "..res)
         return res,err
       end
       print("Error : "..err)
       return res,err
   else
     print("execute failure")
   end
   return nil,"failed to execute : "..tostring(expression)
end


function tiNspire.abs(expression)
    return tiNspire.execute("abs("..expression..")")
end

function tiNspire.amortTbl(NPmt,N,I,PV, Pmt, FV, PpY, CpY,PmtAt, valArrondi)
    return tiNspire.execute("amortTbl("..expression..")")
end


function tiNspire.angle(expression)
    return tiNspire.execute("angle("..expression..")")
end


function math.solve(formula, tosolve)
    local eq = "nsolve(" .. formula .. ", " .. tosolve .. ")"
    local evalStr,err = math.evalStr(eq)
	local res = evalStr:gsub(utf8(8722), "-")
    return tonumber(res)
end

function round(num, idp)
    if num >= 0.001 or num <= -0.001 then
        local mult = 10 ^ (idp or 0)
        if num >= 0 then
            return math.floor(num * mult + 0.5) / mult
        else
            return math.ceil(num * mult - 0.5) / mult
        end
    else
        return tonumber(string.format("%.0" .. (idp + 1) .. "g", num))
    end
end

math.round = round -- just in case

basicFuncsInited = false
function initBasicFunctions()
    if basicFuncsInited==false then
		local basicFunctions = {
			["hasmult"] = [[Define hasmult(x)=Func:Return not(0=inString(string(x),"*") or not (part(x,0)="*") or not (part(factor(x),0)="*")):EndFunc]],
			["isPoly"] = [[Define isPoly(x,var)=Func:Return string(polyCoeffs(x,var)):EndFunc]],
		}
		for var, func in pairs(basicFunctions) do
		    print("defining func "..var.." has : "..func)
			math.eval(func .. ":Lock " .. var) -- defines and prevents against delvar.
		end
		math.setEvalSettings({{'Calculation Mode','Exact'}})
        local settings = math.getEvalSettings()
		local i=1
		while settings[i] and settings[i][1] and settings[i][2] do
		   print(settings[i][1].."="..settings[i][2])
		   i=i+1
		end
		basicFuncsInited=true
	end
end

function test(arg)
	return arg and 1 or 0
end

function hasMult(expression)
    local res,err = math.evalStr("hasmult("..expression..")")
	return res=="true"
end

function partCount(expression)
    if expression then       
       local res,err = math.evalStr("part("..expression..")")
	   if res then
    	 print("partcount="..res)
	     return tonumber(res)
	   end
	   print("Error : "..err)
	else
	   print("partcount failure")
	end
	return 0
end

function partOp(expression)
    if expression then
       local res,err = math.evalStr("part("..expression..",0)")
	   if res then
	     res = string.simplify(res)
	     print("partOp : "..res)
	     return res
	   end
	   print("Error : "..err)
	else
	   print("partOp failure")
	end
	return 0
end


function part(expression,n)
    if expression then
	   local res,err = math.evalStr("part("..expression..","..tostring(n)..")")
	   if res then 
	      print("part("..expression..","..tostring(n)..")="..res)
          return res 
	   end
	   print("part("..expression..","..tostring(n)..") Failed")
	else
	   print("part failure")
	end
	return 0
end

function isPoly(expression,var)
   if expression and var then
       local result,err = math.evalStr("isPoly("..expression..","..var..")")
	   print(result)
	   if result then
         return true
	   end
	   return false
	else
	   print("isPoly failure")
	end
	return false
end

Integration = {}
function Integration:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end


function Integration:setFunction (expression)
    self.expression = expression
	self.isBounded  = false
end


function isDependOnVar(expression,var)
    if expression and var then
        local toEval = derive_sym.."("..expression..","..var..")";
		local result,err = math.evalStr(toEval)
		if result then
			print("result="..result)
			if result=="0" or result=="0."  then
               print("isDependOnVar : return false")
			   return false
			end
		else
		   print("error occured : derive "..expression.." with var"..var)
		end
	else
	    print("isDependOnVar : Expression and var must be not null")
	end
    print("isDependOnVar : return true")
	return true
end

function isOfTypeAx(expression,var)
    if expression and var then
        local derivSecond,err = math.evalStr(derive_sym.."("..expression..","..var..",2)")
    	if isDependOnVar(expression,var) and (derivSecond=="0" or derivSecond=="0.") then
           print("isOfTypeAx : return true")
		   return true
		end
	else
	    print("isOfTypeAx : Expression and var must be not null")
	end
    print("isOfTypeAx : return false")
	return false
end

function isDivElem(expression,var,opCount,op,ops)
   local elemDtl=""
   for i=1, opCount do
     if ops[i] then 
       print("isDivElem:ops["..tostring(i).."]"..ops[i])
     else
       print("isDivElem:ops["..tostring(i).."] is nill for "..expression)
     end
   end
   
   if not isDependOnVar(expression,var) then
       elemDtl = "f("..var..")=a => F("..var..")=a"..var
	   return true,elemDtl
   end
   
   if isPoly(expression,var) then
	   elemDtl = ASTxt(SINCE_ID)..expression..ASTxt(POLY_NOTHING_TO_DEM_ID)
	   return true,elemDtl
   end
   if op == "/" then
	 print("op is div")
	 if not isDependOnVar(ops[1],var) then
	    print(ops[1].."does not depends on "..var)
		if isOfTypeAx(ops[2],var) then
    	   print(ops[2].." is of type a*"..var)
		   elemDtl = "f("..var..")=\\0el {a*(1/"..var..")} "..then_sym.." F("..var..")=\\0el {a*ln(abs("..var.."))} "..for_all.." "..var..element_of.."]0;+∞[ "..ASTxt(OR_ID).." ]−∞;0["
		   return true,elemDtl
		end
    	print(ops[2].." is not of type a*"..var)
	 end
   end
   return false,""
end

function expand(expression,var)
    if expression and var then
        local expanded,err = math.evalStr("expand("..expression..","..var..")")
    	if expanded then
		   expanded = string.simplify(expanded)
           print("expand : "..expanded)
		   return expanded
		end
	elseif expression then
	    print("expand : Strange var null")
        local expanded,err = math.evalStr("expand("..expression..")")
    	if expanded then
		   expanded = string.simplify(expanded)
           print("expand : "..expanded)
		   return expanded
		end
	else
	    print("expand : Expression and var must be not null")
	end
    print("expand : return initial value")
	return expression
end

function ePart(expression)
   print("ePart:"..expression)
   local index=string.find(expression, '\\^' , 1, true)
   local result = UTF8.replaceAll(expression, '^', ',')
   print("search return "..result.." index="..tostring(index))
end

function integr(expression,var,borderUp,borderDown,ctx)
   local isBounded =false
   local boundTxt=""
   if borderUp and borderDown then
     isBounded = true
	 boundTxt = ","..borderUp..","..borderDown
   end
   local evaluated,err
   evaluated,err = math.evalStr("∫("..expression..","..var..boundTxt..")")
   
   local calcResult = ctx..ASTxt(SOLVE_ID).."\\0el {".."∫("..expression..","..var..boundTxt..")}=\\0el {"..evaluated.."}\n"
   calcResult = calcResult..ASTxt(DEMONSTRATION_ID).." : \n"

    local opCount    = partCount(expression)
	local op         = partOp(expression)
	local ops        = {}
	local isElem     = false
	local elemDtl    = ""
	local sep        = ""
	if ctx and ctx:len()>1 then 
		sep="."
	end
	print("op="..op..";opCount="..tostring(partCount))
	for i=1, opCount do
      ops[i] = part(expression,i)
	  if ops[i] then 
	    print("integr:ops["..tostring(i).."]"..ops[i])
	  else
		print("integr:ops["..tostring(i).."] is nill for "..expression)
	  end
    end
	
	isElem,elemDtl = isDivElem(expression,var,opCount,op,ops)
    print("isDivElem return "..tostring(isElem)..","..elemDtl)
	if isElem then
	   calcResult=calcResult..ASTxt(ELEMENTARY_PRIMITIVE_ID).."\n"..elemDtl
	   return calcResult
	end
    
	
    if op == "+" or op == "-" then 
	    calcResult = calcResult..ASTxt(OPERATION_PLMN_INTEG_EXP_ID)
		for i=1, opCount do
          calcResult=calcResult..integr(ops[i],var,borderUp,borderDown,ctx..sep..tostring(i)).."\n"
        end
	elseif op == "/" and opCount==2 and not isDependOnVar(ops[2],var) then
        calcResult=calcResult..ASTxt(INTEGR_CAN_BE_REWRITE_AS_ID).."\\0el {(1/("..ops[2].."))*∫("..ops[1]..","..var..boundTxt..")}\n"

		calcResult=calcResult..integr(ops[1],var,borderUp,borderDown,ctx..sep.."1")
	elseif op == "*" then
	    print("operation is * extracting parts than are '"..var.."' independent")		
		local outOpCount = 0
		local outOp = {}
		local opForIppCount = 0
		local opForIpp = {}
	    i=1
		while i<=opCount do
		  print("ops["..tostring(i).."]="..ops[i])
          if not isDependOnVar(ops[i],var) then
		     print("parts is independent")
			 outOpCount = outOpCount + 1
		     outOp[outOpCount] = ops[i]
		  elseif partOp(ops[i]) == "*" then
			 local subCount = partCount(ops[i])
    		 print("parts is dependent but is a sub * extracting sub parts count="..tostring(subCount))
			 for j=1, subCount do
			   ops[opCount+j] = part(ops[i],j)
			   if ops[opCount+j] then 
				 print("integr:ops["..tostring(opCount+j).."]"..ops[opCount+j])
			   else
				 print("integr:ops["..tostring(opCount+j).."] is nill for "..expression)
			   end
   			 end
			 opCount = opCount + subCount
		  elseif  partOp(ops[i]) == "^" then
		     print("exponential symbol found. in:"..ops[i])
			 local expanded = expand(ops[i],var)
             print("expanded = "..expanded)
			 calcResult=calcResult.."expanded = \\0el {"..expanded.."}\n"
			 calcResult=calcResult.."since part function refactorise it it will be a small manual part.\n"
			 ePart(expanded)
			 if partOp(expanded) == "*" then -- successfully simplified
				local subCount = partCount(expanded)
        		print("parts is dependent but after simplification is divided in sub * extracting sub parts count="..tostring(subCount))
				for j=1, subCount do
				   ops[opCount+j] = part(expanded,j)
				   if ops[opCount+j] then 
					 print("integr:ops["..tostring(opCount+j).."]"..ops[opCount+j])
				   else
					 print("integr:ops["..tostring(opCount+j).."] is nill for "..expression)
				   end
				end
				calcResult=calcResult.."\\0el {"..ops[i].."="..expanded.."}\n"
				opCount = opCount + subCount			
             elseif partOp(expanded) == "/" then -- successfully simplified
				local subCount = partCount(expanded)
        		if subCount == 2 then
					print("parts is dependent but after simplification is divided in sub * extracting sub parts count="..tostring(subCount))
					ops[opCount+j] = part(expanded,j)
					if ops[opCount+j] then 
					  print("integr:ops["..tostring(opCount+j).."]"..ops[opCount+j])
					else
				 	  print("integr:ops["..tostring(opCount+j).."] is nill for "..expression)
					end
					calcResult=calcResult.."\\0el {"..ops[i].."="..expanded.."}\n"
					opCount = opCount + subCount			
				else
				   print("strange parts count for div = "..tostring(subCount))
	    	      opForIppCount = opForIppCount + 1
    		      opForIpp[opForIppCount]=ops[i]    
				end
			 else
    	       opForIppCount = opForIppCount + 1
    		   opForIpp[opForIppCount]=ops[i]   
			 end         			 			 
	  	  else
		   opForIppCount = opForIppCount + 1
		   opForIpp[opForIppCount]=ops[i]
		  end
		  i=i+1
		end
		local ippStr = ""
		local outStr = ""
		if opForIppCount>0 then
		    for j=1, opForIppCount do
			   if ippStr=="" then
			     ippStr = "("..opForIpp[j]..")"
			   else
			     ippStr = ippStr.."*("..opForIpp[j]..")"
			   end
			end
		end
		if outOpCount >0 then
		    for j=1, outOpCount do
			   if outStr=="" then
			     outStr = "("..outOp[j]..")"
			   else
			     outStr = outStr.."*("..outOp[j]..")"
			   end
			end
		   calcResult=calcResult..ASTxt(INTEGR_CAN_BE_REWRITE_AS_ID).."\\0el {("..outStr..")*∫("..ippStr..","..var..boundTxt..")}"
		   calcResult=calcResult..integr(ippStr,var,borderUp,borderDown,ctx..sep.."1")
		else 
		    calcResult=calcResult.." We should use now IPP to resolve \\0el {∫("..ippStr..","..var..boundTxt..")} with :\n"
		    for j=1, opForIppCount do
			   calcResult=calcResult..opForIpp[j].."\n"
			end
		end
		
	elseif op == "/" then
		calcResult=calcResult.."inworks\n"
    end
    return calcResult
end

function Integration:integrBy(var,borderUp,borderDown)
   self.var = var
   self.borderUp = borderUp
   self.borderDown =borderDown
   local result = ""
   return integr(self.expression,self.var,self.borderUp,self.borderDown,"")
end

function analysis(expression,var)
   print(partOp(expression))
   print(part(expression,1))
   local op = partOp(expression)
   local count = partCount(expression);
   if count>1 then 
   return tostring(partCount(expression))..","..op..","..tostring(part(expression,1))
   end
   return tostring(partCount(expression))..tostring(op)
end







function on.paint(gc)	
    allWentWell, generalErrMsg = pcall(onpaint, gc)
    if not allWentWell and errorHandler then
        errorHandler.display = true
        errorHandler.errorMessage = generalErrMsg
    end
    if platform.hw and platform.hw() < 4 and not doNotDisplayIcon then 
    	platform.withGC(on.draw)
    end
end

function onpaint(gc)
	for _, screen in pairs(Screens) do
		screen:draw(gc)	
	end
	if errorHandler.display then
	    errorPopup(gc)
	end
end

function on.resize(w, h)
	kXRatio = w/320
	kYRatio = h/212
	
	kXSize, kYSize = w, h
	
	for _,screen in pairs(Screens) do
		screen:resize(w,h)
	end
end

function on.arrowKey(arrw)	current_screen():arrowKey(arrw)  end
function on.enterKey()		current_screen():enterKey()		 end
function on.escapeKey()		current_screen():escapeKey()	 end
function on.tabKey()		current_screen():tabKey()		 end
function on.backtabKey()	current_screen():backtabKey()	 end
function on.charIn(ch)		current_screen():charIn(ch)		 end
function on.backspaceKey()	current_screen():backspaceKey()  end
function on.contextMenu()	current_screen():contextMenu()   end
function on.mouseDown(x,y)	current_screen():mouseDown(x,y)	 end
function on.mouseUp(x,y)	if (x == 0 and y == 0) then current_screen():enterKey() else current_screen():mouseUp(x,y) end	 end
function on.mouseMove(x,y)	current_screen():mouseMove(x,y)  end
function on.clearKey()    	current_screen():clearKey()      end

function uCol(col)
	return col[1] or 0, col[2] or 0, col[3] or 0
end





function find_data(known, cid, sid)
    local done = {}

    for _, var in ipairs(var.list()) do
        math.eval("delvar " .. var)
    end

    for key, value in pairs(known) do
        var.store(key, value)
    end

    local no
    local dirty_exit = true
    local tosolve
    local couldnotsolve = {}

    local loops = 0
    while dirty_exit do
        loops = loops + 1
        if loops == 100 then error("too many loops!") end
        dirty_exit = false

        for i, formula in ipairs(Formulas) do

            local skip = false
            if couldnotsolve[formula] then
                skip = true
                for k, v in pairs(known) do
                    if not couldnotsolve[formula][k] then
                        skip = false
                        couldnotsolve[formula] = nil
                        break
                    end
                end
            end

            if ((not cid) or (cid and formula.category == cid)) and ((not sid) or (formula.category == cid and formula.sub == sid)) and not skip then
                no = 0

                for var in pairs(formula.variables) do
                    if not known[var] then
                        no = no + 1
                        tosolve = var
                        if no == 2 then break end
                    end
                end

                if no == 1 then
                    print("I can solve " .. tosolve .. " for " .. formula.formula)

                    local sol, r = math.solve(formula.formula, tosolve)
                    if sol then
                        sol = round(sol, 4)
                        known[tosolve] = sol
                        done[formula] = true
                        var.store(tosolve, sol)
                        couldnotsolve[formula] = nil
                        print(tosolve .. " = " .. sol)
                    else
                        print("Oops! Something went wrong:", r)
                        couldnotsolve[formula] = copyTable(known)
                    end
                    dirty_exit = true
                    break

                elseif no == 2 then
                    print("I cannot solve " .. formula.formula .. " because I don't know the value of multiple variables")
                end
            end
        end
    end

    return known
end


CategorySel = WScreen()
CategorySel.iconS = 48

CategorySel.sublist = sList()
CategorySel:appendWidget(CategorySel.sublist, 5, 5 + 24)
CategorySel.sublist:setSize(-10, -70)
CategorySel.sublist.cid = 0

function CategorySel.sublist:action(sid)
    push_screen(SubCatSel, sid)
end

function CategorySel:charIn(ch)
    if ch == "l" then
        self:pushed() -- refresh list
        self:invalidate() -- asks for screen repaint
    end
end

function CategorySel:paint(gc)
    initBasicFunctions()
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)

    if not kIsInSubCatScreen then
        gc:setColorRGB(0, 0, 0)
        gc:setFont("sansserif", "r", 16)
        gc:drawString(ASTxt(PROBABILITY_TITLE), self.x + 5, 0, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString("v"..version, self.x + .4 * self.w, 4, "top")

        gc:setFont("sansserif", "r", 12)
		
        gc:drawString(ASTxt(BY_ID), self.x + self.w - gc:getStringWidth(ASTxt(BY_ID)) - 5, 4, "top")

        gc:setColorRGB(220, 220, 220)
        gc:setFont("sansserif", "r", 8)
        gc:drawRect(5, self.h - 46 + 10, self.w - 10, 25 + 6)
        gc:setColorRGB(128, 128, 128)
    end

    local splinfo = Categories[self.sublist.sel].info:split("\n")
    for i, str in ipairs(splinfo) do
        gc:drawString(str, self.x + 7, self.h - 56 + 12 + i * 10, "top")
    end
    self.sublist:giveFocus()
end

function CategorySel:pushed()
    local items = {}
    for cid, cat in ipairs(Categories) do
        table.insert(items, cat.name)
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function CategorySel:tabKey()
    push_screen_back(Ref)
end



SubCatSel = WScreen()
SubCatSel.sel = 1

SubCatSel.sublist = sList()
SubCatSel:appendWidget(SubCatSel.sublist, 5, 5 + 24)
SubCatSel.back = sButton(utf8(9664) .. " Back")
SubCatSel:appendWidget(SubCatSel.back, 5, -5)
SubCatSel.sublist:setSize(-10, -66)
SubCatSel.sublist.cid = 0

function SubCatSel.back:action()
    SubCatSel:escapeKey()
end

function SubCatSel.sublist:action(sub)
    local cid = self.parent.cid
    if #Categories[cid].sub[sub].formulas > 0 then
        push_screen(manualSolver, cid, sub)
    elseif Categories[cid].sub[sub].screen then
       if Categories[cid].sub[sub].screen.setCSid then
          Categories[cid].sub[sub].screen:setCSid(cid,sub)
       end
       push_screen(Categories[cid].sub[sub].screen)
    end
end

function SubCatSel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)
    gc:setFont("sansserif", "r", 16)
    gc:drawString(Categories[self.cid].name, self.x + 5, 0, "top")
end

function SubCatSel:pushed(sel)

    kIsInSubCatScreen = true
    self.cid = sel
    local items = {}
    for sid, subcat in ipairs(Categories[sel].sub) do
        local isEmpty = ""
        if #subcat.formulas == 0 and not subcat.screen then
           isEmpty=ASTxt(EMPTY_ID)
        end
        table.insert(items, subcat.name .. isEmpty)
    end

    if self.sublist.cid ~= sel then
        self.sublist.cid = sel
        self.sublist:reset()
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function SubCatSel:escapeKey()
    kIsInSubCatScreen = false
    only_screen_back(CategorySel)
end



 -- Including : C:\tiproject\finance\src\ui\math\manualsolver.lua




 -- Including : C:\tiproject\finance\src\ui\math\usedformula.lua



usedFormulas = Dialog("Used formulas", 10, 10, -20, -20)

usedFormulas.but = sButton("Close")

usedFormulas:appendWidget(usedFormulas.but, -10, -5)

function usedFormulas:postPaint(gc)
    if self.ed then
        self.ed:move(self.x + 5, self.y + 30)
        self.ed:resize(self.w - 9, self.h - 74)
    end

    nativeBar(gc, self, self.h - 40)
end

function usedFormulas:pushed()
    doNotDisplayIcon = true
    self.ed = D2Editor.newRichText()
    self.ed:setReadOnly(true)
    local cont = ""

    local fmls = #manualSolver.sub.formulas
	
    for k, v in ipairs(manualSolver.sub.formulas) do
        cont = cont.. k .. ": \\0el {" .. v.formula .. "} " .. (k < fmls and "\n" or "")
    end

    if self.ed.setExpression then
        self.ed:setColorable(true)
        self.ed:setTextColor(0x215c98)
		self.ed:setExpression(cont, 1)
		
        self.ed:registerFilter{ escapeKey = usedFormulas.closeEditor, enterKey = usedFormulas.closeEditor, tabKey = usedFormulas.leaveEditor }
        self.ed:setFocus(true)
    else
        self.ed:setText(cont, 1)
    end

    self.but:giveFocus()
end

function usedFormulas.leaveEditor()
    platform.window:setFocus(true)
    usedFormulas.but:giveFocus()
    return true
end

function usedFormulas.closeEditor()
    platform.window:setFocus(true)
    if current_screen() == usedFormulas then
        remove_screen()
    end
    doNotDisplayIcon = false
    return true
end

function usedFormulas:screenLoseFocus()
    self:removed()
end

function usedFormulas:screenGetFocus()
    self:pushed()
end

function usedFormulas:removed()
    if usedFormulas.ed.setVisible then
        usedFormulas.ed:setVisible(false)
    else
        usedFormulas.ed:setText("")
        usedFormulas.ed:resize(1, 1)
        usedFormulas.ed:move(-10, -10)
    end
    usedFormulas.ed = nil
    doNotDisplayIcon = false
end

function usedFormulas.but.action(self)
    remove_screen()
end	

manualSolver = WScreen()
manualSolver.pl = sScreen(-20, -50)
manualSolver:appendWidget(manualSolver.pl, 2, 4)

manualSolver.sb = scrollBar(-50)
manualSolver:appendWidget(manualSolver.sb, -2, 3)

manualSolver.back = sButton(utf8(9664) .. " Back")
manualSolver:appendWidget(manualSolver.back, 5, -5)

manualSolver.usedFormulas = sButton("Formulas")
manualSolver:appendWidget(manualSolver.usedFormulas, -5, -5)

function manualSolver.back:action()
    manualSolver:escapeKey()
end

function manualSolver.usedFormulas:action()
    push_screen_direct(usedFormulas)
end

function manualSolver.sb:action(top)
    self.parent.pl:setY(4 - top * 30)
end

function manualSolver:paint(gc)
    gc:setColorRGB(224, 224, 224)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(128, 128, 128)
    gc:fillRect(self.x + 5, self.y + self.h - 42, self.w - 10, 2)
    self.sb:update(math.floor(-(self.pl.oy - 4) / 30 + .5))

    gc:setFont("sansserif", "r", 10)
    local name = self.sub.name
    local len = gc:getStringWidth(name)
    if len >= .7*self.w then name = string.sub(name, 1, -10) .. ". " end
    local len = gc:getStringWidth(name)
    local x = self.x + (self.w - len) / 2


    gc:setColorRGB(0, 0, 0)
    gc:drawString(name, x, self.h - 28, "top")
end

function manualSolver:postPaint(gc)
end


function manualSolver:pushed(cid, sid)

    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end

    self.pl.widgets = {}
    self.pl.focus = 0
    self.cid = cid
    self.sid = sid
    self.sub = Categories[cid].sub[sid]
    self.pl.oy = 0
    self.known = {}
    self.inputs = {}
    self.constants = {}

    local inp, lbl
    local i = 0
    local nodropdown, lastdropdown
    for variable, _ in pairs(self.sub.variables) do


        if not Constants[variable] or Categories[cid].varlink[variable] then
            i = i + 1
            inp = sInput()
            inp.value = ""

            function inp:enterKey()
                if not tonumber(self.value) and #self.value > 0 then
                    if not manualSolver:preSolve(self) then
                        self.value = self.value .. "   " .. utf8(8658) .. " Invalid input"
                    end
                end
                manualSolver:solve()
                self.parent:switchFocus(1)
            end

            self.inputs[variable] = inp
            inp.ww = -145
            inp.focusDown = 4
            inp.focusUp = -2
            lbl = sLabel(variable, inp)

            self.pl:appendWidget(inp, 60, i * 30 - 28)
            self.pl:appendWidget(lbl, 2, i * 30 - 28)
            self.pl:appendWidget(sLabel(":", inp), 50, i * 30 - 28)

            print(variable)
            local variabledata = Categories[cid].varlink[variable]
            inp.placeholder = variabledata.info

            if nodropdown then
                inp.focusUp = -1
            end

            if variabledata then
                if variabledata.unit ~= "unitless" then
                    local itms = { variabledata.unit }
                    for k, _ in pairs(Units[variabledata.unit]) do
                        table.insert(itms, k)
                    end
                    inp.dropdown = sDropdown(itms)
                    inp.dropdown.unitmode = true
                    inp.dropdown.change = self.update
                    inp.dropdown.focusUp = nodropdown and -5 or -4
                    inp.dropdown.focusDown = 2
                    self.pl:appendWidget(inp.dropdown, -2, i * 30 - 28)
                    nodropdown = false
                    lastdropdown = inp.dropdown
                else
                    self.pl:appendWidget(sLabel("Unitless"), -32, i * 30 - 28)
                end
            else
                nodropdown = true
                inp.focusDown = 1
                if lastdropdown then
                    lastdropdown.focusDown = 1
                    lastdropdown = false
                end
            end

            inp.getFocus = manualSolver.update
        else
            self.constants[variable] = math.eval(Constants[variable].value)
        end
    end
    inp.focusDown = 1

    manualSolver.sb:update(0, math.floor(self.pl.h / 30 + .5), i)
    self.pl:giveFocus()

    self.pl.focus = 1
    self.pl:getWidget().hasFocus = true
    self.pl:getWidget():getFocus()
end

function manualSolver.update()
    manualSolver:solve()
end

function manualSolver:preSolve(input)
    local res, err
    res, err = math.eval(input.value)
    res = res and round(res, 4)
    print("Presolve : ", input.value .. " = " .. tostring(res), "(err ? = " .. tostring(err) .. ")")
    input.value = res and tostring(res) or input.value
    return res and 1 or false
end

function manualSolver:solve()
    local inputed = {}
    local disabled = {}

    for variable, input in pairs(self.inputs) do
        local variabledata = Categories[self.cid].varlink[variable]
        if input.disabled then
            inputed[variable] = nil
            input.value = ""
        end

        input:enable()
        if input.value ~= "" then
            local tmpstr = input.value:gsub(utf8(8722), "-")
            inputed[variable] = tonumber(tmpstr)
            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                inputed[variable] = Units.subToMain(variabledata.unit, input.dropdown.rvalue, inputed[variable])
            end
        end
    end

    local invs = copyTable(inputed)
    for k, v in pairs(self.constants) do
        invs[k] = v
    end
    self.known = find_data(invs, self.cid, self.sid)

    for variable, value in pairs(self.known) do
        if (not inputed[variable] and self.inputs[variable]) then
            local variabledata = Categories[self.cid].varlink[variable]
            local result = tostring(value)
            local input = self.inputs[variable]

            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                result = Units.mainToSub(variabledata.unit, input.dropdown.rvalue, result)
            end

            input.value = result
            input:disable()
        end
    end
end

function manualSolver:escapeKey()
    only_screen_back(SubCatSel, self.cid)
end

function manualSolver:contextMenu()
    push_screen_direct(usedFormulas)
end


 -- Including : C:\tiproject\finance\src\ui\math\autoSolver.lua




autoSolver = WScreen()
autoSolver.pl = sScreen(-20, -50)
autoSolver:appendWidget(autoSolver.pl, 2, 4)

autoSolver.sb = scrollBar(-50)
autoSolver:appendWidget(manualSolver.sb, -2, 3)



autoSolver.back = sButton(utf8(9664) .. ASTxt(BACK_ID))
autoSolver:appendWidget(autoSolver.back, 5, -5)

autoSolver.usedFormulas = sButton("Formulas")
autoSolver:appendWidget(autoSolver.usedFormulas, -5, -5)

function autoSolver.back:action()
    autoSolver:escapeKey()
end

function autoSolver.usedFormulas:action()
    push_screen_direct(usedFormulas)
end

function manualSolver.sb:action(top)
    self.parent.pl:setY(4 - top * 30)
end

function manualSolver:paint(gc)
    gc:setColorRGB(224, 224, 224)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(128, 128, 128)
    gc:fillRect(self.x + 5, self.y + self.h - 42, self.w - 10, 2)
    self.sb:update(math.floor(-(self.pl.oy - 4) / 30 + .5))

    gc:setFont("sansserif", "r", 10)
    local name = self.sub.name
    local len = gc:getStringWidth(name)
    if len >= .7*self.w then name = string.sub(name, 1, -10) .. ". " end
    local len = gc:getStringWidth(name)
    local x = self.x + (self.w - len) / 2


    gc:setColorRGB(0, 0, 0)
    gc:drawString(name, x, self.h - 28, "top")
end

function autoSolver:postPaint(gc)
end


function autoSolver:pushed(cid, sid)

    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end

    self.pl.widgets = {}
    self.pl.focus = 0
    self.cid = cid
    self.sid = sid
    self.sub = Categories[cid].sub[sid]
    self.pl.oy = 0
    self.known = {}
    self.inputs = {}
    self.constants = {}

    local inp, lbl
    local i = 0
    local nodropdown, lastdropdown
    for variable, _ in pairs(self.sub.variables) do


        if not Constants[variable] or Categories[cid].varlink[variable] then
            i = i + 1
            inp = sInput()
            inp.value = ""

            function inp:enterKey()
                if not tonumber(self.value) and #self.value > 0 then
                    if not autoSolver:preSolve(self) then
                        self.value = self.value .. "   " .. utf8(8658) .. " Invalid input"
                    end
                end
                autoSolver:solve()
                self.parent:switchFocus(1)
            end

            self.inputs[variable] = inp
            inp.ww = -145
            inp.focusDown = 4
            inp.focusUp = -2
            lbl = sLabel(variable, inp)

            self.pl:appendWidget(inp, 60, i * 30 - 28)
            self.pl:appendWidget(lbl, 2, i * 30 - 28)
            self.pl:appendWidget(sLabel(":", inp), 50, i * 30 - 28)

            print(variable)
            local variabledata = Categories[cid].varlink[variable]
            inp.placeholder = variabledata.info

            if nodropdown then
                inp.focusUp = -1
            end

            if variabledata then
                if variabledata.unit ~= "unitless" then
                    local itms = { variabledata.unit }
                    for k, _ in pairs(Units[variabledata.unit]) do
                        table.insert(itms, k)
                    end
                    inp.dropdown = sDropdown(itms)
                    inp.dropdown.unitmode = true
                    inp.dropdown.change = self.update
                    inp.dropdown.focusUp = nodropdown and -5 or -4
                    inp.dropdown.focusDown = 2
                    self.pl:appendWidget(inp.dropdown, -2, i * 30 - 28)
                    nodropdown = false
                    lastdropdown = inp.dropdown
                else
                    self.pl:appendWidget(sLabel("Unitless"), -32, i * 30 - 28)
                end
            else
                nodropdown = true
                inp.focusDown = 1
                if lastdropdown then
                    lastdropdown.focusDown = 1
                    lastdropdown = false
                end
            end

            inp.getFocus = autoSolver.update
        else
            self.constants[variable] = math.eval(Constants[variable].value)
        end
    end
    inp.focusDown = 1

    autoSolver.sb:update(0, math.floor(self.pl.h / 30 + .5), i)
    self.pl:giveFocus()

    self.pl.focus = 1
    self.pl:getWidget().hasFocus = true
    self.pl:getWidget():getFocus()
end

function autoSolver.update()
    autoSolver:solve()
end

function autoSolver:preSolve(input)
    local res, err
    res, err = math.eval(input.value)
    res = res and round(res, 4)
    print("Presolve : ", input.value .. " = " .. tostring(res), "(err ? = " .. tostring(err) .. ")")
    input.value = res and tostring(res) or input.value
    return res and 1 or false
end

function autoSolver:solve()
    local inputed = {}
    local disabled = {}

    for variable, input in pairs(self.inputs) do
        local variabledata = Categories[self.cid].varlink[variable]
        if input.disabled then
            inputed[variable] = nil
            input.value = ""
        end

        input:enable()
        if input.value ~= "" then
            local tmpstr = input.value:gsub(utf8(8722), "-")
            inputed[variable] = tonumber(tmpstr)
            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                inputed[variable] = Units.subToMain(variabledata.unit, input.dropdown.rvalue, inputed[variable])
            end
        end
    end

    local invs = copyTable(inputed)
    for k, v in pairs(self.constants) do
        invs[k] = v
    end
    self.known = find_data(invs, self.cid, self.sid)

    for variable, value in pairs(self.known) do
        if (not inputed[variable] and self.inputs[variable]) then
            local variabledata = Categories[self.cid].varlink[variable]
            local result = tostring(value)
            local input = self.inputs[variable]

            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                result = Units.mainToSub(variabledata.unit, input.dropdown.rvalue, result)
            end

            input.value = result
            input:disable()
        end
    end
end

function autoSolver:escapeKey()
    only_screen_back(SubCatSel, self.cid)
end

function autoSolver:contextMenu()
    push_screen_direct(usedFormulas)
end



 -- Including : C:\tiproject\finance\src\ui\references.lua



 -- Including : C:\tiproject\finance\src\ui\math\ippref.lua

 

 -- Including : C:\tiproject\finance\src\ui\math\enterFormulas.lua



enterFormulas = WScreen()

enterFormulas.but = sButton(ASTxt(CLOSE_ID))

enterFormulas:appendWidget(enterFormulas.but, -10, -5)

enterFormulas.formula="0.8(x+3y)*"..exp_sym.."^("..neg_sym.."x-2y)"
enterFormulas.var="x"
enterFormulas.borderUp = infinit_sym
enterFormulas.borderDown = "0"

function enterFormulas:postPaint(gc)
    if self.ed then
        self.ed:move(self.x + 5, self.y + 30)
        self.ed:resize(self.w - 9, self.h - 74)
    end

    nativeBar(gc, self, self.h - 40)
end

function enterFormulas:previousScreen(scr)
   self.scr = scr
end

function enterFormulas:pushed()
    doNotDisplayIcon = true
    self.ed = D2Editor.newRichText()
    self.ed:setReadOnly(false)
    local cont = ASTxt(ENTER_FONCTION_ID).." : \\0el {"..self.formula.."} \n"..ASTxt(ENTER_VAR_ID).." : \\0el {"..self.var.."}\n"..
	ASTxt(BORDER_UP_ID).." : \\0el {"..self.borderUp.."}\n"..
	ASTxt(BORDER_DOWN_ID).." : \\0el {"..self.borderDown.."}\n"

    

    if self.ed.setExpression then
        self.ed:setColorable(true)
        self.ed:setTextColor(0x215c98)
		self.ed:setExpression(cont, 1)
		
        self.ed:registerFilter{ escapeKey = enterFormulas.closeEditor, enterKey = usedFormulas.closeEditor, tabKey = usedFormulas.leaveEditor }
        self.ed:setFocus(true)
    else
        self.ed:setText(cont, 1)
    end

    self.but:giveFocus()
end


function enterFormulas.leaveEditor()
    platform.window:setFocus(true)
    enterFormulas.but:giveFocus()
    return true
end

function enterFormulas.closeEditor()
    platform.window:setFocus(true)
    if current_screen() == enterFormulas then
        remove_screen()
    end
    doNotDisplayIcon = false
    return true
end

function enterFormulas:screenLoseFocus()
    self:removed()
end

function enterFormulas:screenGetFocus()
    self:pushed()
end

function enterFormulas:extractTxt(typeTxt)
    local expression=self.ed:getExpression()
    for word in expression:gmatch(typeTxt.." : \\0el {[^{]*}") do
    	print("found : "..word)
	    for wordRes in word:gmatch("{[^{}]*") do
    	   local result = wordRes:sub(2,wordRes:len())
    	   print("extracted : "..result)
		   return result
		end
	end
	return ""
end

function enterFormulas:removed()

    enterFormulas.formula = self:extractTxt(ASTxt(ENTER_FONCTION_ID))
	if enterFormulas.formula and enterFormulas.formula:len()>1 then
	   formula = enterFormulas.formula
	end
	print(formula)
	enterFormulas.var = self:extractTxt(ASTxt(ENTER_VAR_ID))
	enterFormulas.borderUp = self:extractTxt(ASTxt(BORDER_UP_ID))
	enterFormulas.borderDown = self:extractTxt(ASTxt(BORDER_DOWN_ID))
	if enterFormulas.ed.setVisible then
        enterFormulas.ed:setVisible(false)
    else
        enterFormulas.ed:setText("")
        enterFormulas.ed:resize(1, 1)
        enterFormulas.ed:move(-10, -10)
    end
    enterFormulas.ed = nil
    doNotDisplayIcon = false
end

function enterFormulas.but.action(self)
    remove_screen()
	push_screen(enterFormulas.scr)
end	

Ipp = WScreen()
 
Ipp.font = "serif"
Ipp.h = pwh()  
Ipp.w = pww()


Ipp.enterFunction = sButton(ASTxt(ENTER_FONCTION_ID))
Ipp:appendWidget(Ipp.enterFunction, 0, 0)


function Ipp.enterFunction:action()
    enterFormulas:previousScreen(Ipp)
    push_screen(enterFormulas)
end

function Ipp:CreateBox()
	if not self.IppBox then
	   self.IppBox = D2Editor.newRichText()
	   self.IppBox:createMathBox()
	end
end
 
function Ipp:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h).." ;Ipp.enterFunction.h="..tostring(Ipp.enterFunction.h))
      self.lasth=self.h
      self.lastw=self.w
      self.enterButX=-Ipp.enterFunction.w      
      self.enterButY=self.h -Ipp.enterFunction.h -3
      self.boxX=2
      self.boxY=30
      self.boxW= self.w-14
      self.boxH=self.h-self.boxY-Ipp.enterFunction.h-6     
      print("self.enterButX="..tostring(self.enterButX)..";self.enterButY="..tostring(self.enterButY))
      return true
   end
   return false
end

function Ipp:refreshIppBox()
    self.x=0
    self.y=0
	self.ww	= pww()
	self.hh	= pwh()
	if self:calculateSize() or not self.IppBox then
      self:CreateBox()
      if self.IppBox and self.x and self.y and self.w and self.h then
        self.IppBox:move(self.boxX,self.boxY)
        self.IppBox:resize(self.boxW, self.boxH)
      end
	  Ipp.enterFunction:setPos(self.enterButX, self.enterButY)
	end
end
   

function Ipp:postPaint(gc)
end
 
function Ipp:integr()
  Ipp.operation=ASTxt(ENTER_A_FUNC_TO_START_ID)
  if enterFormulas.formula and enterFormulas.formula:len()>1 then
    Ipp.operation=ASTxt(FUNCTION_ID).."\\0el {"..enterFormulas.formula.."}\n"
	Integration:setFunction(enterFormulas.formula)
	Ipp.operation = Ipp.operation..Integration:integrBy(enterFormulas.var,enterFormulas.borderDown,enterFormulas.borderUp)
  end
end

 
function  Ipp:pushed()
    doNotDisplayIcon = true
	
    self:refreshIppBox()
    self.IppBox:setReadOnly(true)
	self:integr()
	local form ="\\0el {∫(u*v',x,a,b)  =  [u*v]system(b,a)  -  ∫(u'*v,x,a,b)}\n"..Ipp.operation
    self.IppBox:setBorderColor(0x51cecb)
    self.IppBox:setBorder(1)
	if self.IppBox.setExpression then
        self.IppBox:setColorable(true)
        self.IppBox:setTextColor(0x215c98)
		self.IppBox:setExpression(form, 1)
        self.IppBox:setFocus(true)
    else
        self.IppBox:setText(form, 1)
    end
    
               self.IppBox:setVisible(true)
end


function Ipp:screenGetFocus()
    self:pushed()
end

function Ipp:screenLoseFocus()
    self:removed()
end


function Ipp:removed()
    if self.IppBox then
	   if self.IppBox.setVisible then
           self.IppBox:setVisible(false)
       else
           self.IppBox:setText("")
           self.IppBox:resize(1, 1)
           self.IppBox:move(-10, -10)
       end
	end
	self.IppBox = nil
    doNotDisplayIcon = false
end
 
function Ipp:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	Ipp.h = printTitle(gc,IPP_TITLE_ID,Greek.font)
end
 
function Ipp:enterKey()
    Ipp.font = Ipp.font == "serif" and "sansserif" or "serif"
    self.invalidate()
end

function Ipp:escapeKey()
	only_screen_back(Ref)
end


 -- Including : C:\tiproject\finance\src\ui\genref\greekref.lua

 

Greek = Screen()
 
Greek.font = "serif"
  
Greek.alphabet1 = {
 { utf8(913), utf8(945), "Alpha" },
 { utf8(914), utf8(946), "Beta" },
 { utf8(915), utf8(947), "Gamma" },
 { utf8(916), utf8(948), "Delta" },
 { utf8(917), utf8(949), "Epsilon" },
 { utf8(918), utf8(950), "Zeta" },
 { utf8(919), utf8(951), "Eta" },
 { utf8(920), utf8(952), "Theta" }
}
Greek.alphabet2 = {
 { utf8(921), utf8(953), "Iota" },
 { utf8(922), utf8(954), "Kappa" },
 { utf8(923), utf8(955), "Lambda" },
 { utf8(924), utf8(956), "Mu" },
 { utf8(925), utf8(957), "Nu" },
 { utf8(926), utf8(958), "Xi" },
 { utf8(927), utf8(959), "Omicron" },
 { utf8(928), utf8(960), "Pi" }
}
Greek.alphabet3 = {
 { utf8(929), utf8(961), "Rho" },
 { utf8(931), utf8(963), "Sigma" },
 { utf8(932), utf8(964), "Tau" },
 { utf8(933), utf8(965), "Upsilon" },
 { utf8(934), utf8(966), "Phi" },
 { utf8(935), utf8(967), "Chi" },
 { utf8(936), utf8(968), "Psi" },
 { utf8(937), utf8(969), "Omega" }
}
 

function Greek:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	printTitle(gc,GREEK_TITLE_ID,Greek.font)
    for k,v in ipairs(Greek.alphabet1) do
        gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5, 10+22*k, "top")
    end
    for k,v in ipairs(Greek.alphabet2) do
        gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.34*pww(), 10+22*k, "top")
    end
    for k,v in ipairs(Greek.alphabet3) do
        gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.67*pww(), 10+22*k, "top")
    end
end
 
function Greek:enterKey()
    Greek.font = Greek.font == "serif" and "sansserif" or "serif"
    Greek:invalidate()
end

function Greek:escapeKey()
	only_screen_back(Ref)
end

 -- Including : C:\tiproject\finance\src\ui\genref\utf8ref.lua

 

 -- Including : C:\tiproject\finance\src\datastructures\stack.lua



Stack	= class()

function Stack:init()
   self.count=0
   self.items={}
end

function Stack:push(data)
   self.count=self.count+1
   self.items[self.count]=data
end

function Stack:pop()
   if self.count==0 then
      return nil
   end
   local data = self.items[self.count]
   self.count = self.count -1
   return data
end

function Stack:top()
   if self.count==0 then
      return nil
   end
   local data = self.items[self.count]
   return data
end


UTF8Ref = Screen()
 
UTF8Ref.font = "serif"

UTF8Ref.previousHist = Stack()
UTF8Ref.previousHist:init()
UTF8Ref.curStart = 0
UTF8Ref.nextStart = 125
UTF8Ref.max = 0x10006B

utf8Ranges = {}
utf8RangesCnt=0
function addRange(id,minSkp,maxSkp)
    utf8RangesCnt= utf8RangesCnt+1
    return table.insert(utf8Ranges, id, {id=id, minSkp=minSkp, maxSkp=maxSkp})
end


addRange(1,0,31)
addRange(2,127,159)
addRange(3,384,461)
addRange(4,463,463)
addRange(5,467,467)
addRange(6,469,469)
addRange(7,471,471)
addRange(8,473,473)
addRange(9,475,475)     
addRange(10,477,503)
addRange(11,512,591)
addRange(12,594,595)
addRange(13,597,600)
addRange(14,602,602)
addRange(15,604,608)
addRange(16,610,617)
addRange(17,619,628)
addRange(18,630,642)
addRange(19,644,649)
addRange(20,651,651)
addRange(21,653,657)
addRange(22,659,711)
addRange(23,713,715)
addRange(24,717,912)
addRange(25,930,930)
addRange(26,938,944)
addRange(27,962,962)
addRange(28,970,8200)
addRange(29,8202,8210)
addRange(30,8213,8215)
addRange(31,8219,8219)
addRange(32,8223,8225)
addRange(33,8228,8229)
addRange(34,8231,8239)
addRange(35,8241,8248)
addRange(36,8252,8303)
addRange(37,8306,8307)
addRange(38,8316,8316)
addRange(39,8332,8332)
addRange(40,8335,8363)
addRange(41,8365,8449)
addRange(42,8452,8456)
addRange(43,8458,8468)
addRange(44,8470,8472)
addRange(45,8475,8476)
addRange(46,8478,8481)
addRange(47,8483,8483)
addRange(48,8487,8591)
addRange(49,8598,8613)
addRange(50,8615,8628)
addRange(51,8630,8655)
addRange(52,8657,8657)
addRange(53,8659,8659)
addRange(54,8661,8676)
addRange(55,8678,8678)
addRange(56,8680,8703)
addRange(57,8705,8705)
addRange(58,8720,8720)
addRange(59,8724,8727)
addRange(60,8731,8732)
addRange(61,8738,8738)
addRange(62,8748,8755)
addRange(63,8758,8758)
addRange(64,8760,8763)
addRange(65,8766,8770)
addRange(66,8772,8772)
addRange(67,8774,8775)
addRange(68,8777,8779)
addRange(69,8781,8798)
addRange(70,8803,8803)
addRange(71,8806,8833)
addRange(72,8835,8837)
addRange(73,8839,8856)
addRange(74,8858,8868)
addRange(75,8870,8894)
addRange(76,8896,8983)
addRange(77,8985,9321)
addRange(78,9328,9423)
addRange(79,9429,9631)

function isInSkipped(i,from)
    if utf8Ranges[from].minSkp>i then 
      from=1 -- strange
    end
    print("isInSkipped:"..tostring(from)..";utf8RangesCnt="..utf8RangesCnt..";i="..tostring(i))
    local nextFrom=from
    local nextRes=i
    
    for j=from,utf8RangesCnt do
        if utf8Ranges[j].minSkp <= i and utf8Ranges[j].maxSkp >= i then
            print(tostring(i).." is in skipped range between "..tostring(utf8Ranges[j].minSkp).." and "..tostring(utf8Ranges[j].maxSkp))
            nextRes=utf8Ranges[j].maxSkp+1
            return true,nextRes,nextFrom
        end
        
		if utf8Ranges[j].minSkp > i then
		  nextFrom=j  
		  print(tostring(i).." is not in skipped range.j="..tostring(j))
          return false,i,nextFrom
		end
		nextFrom=j
    end
    return false,i,nextFrom
end


function utf8ToStringBasic(i,from)
   local inSkiped=false
   local nextNotskiped=i
   local nextFrom=from
   inSkiped,nextNotskiped,nextFrom=isInSkipped(i,from)
   local j=nextNotskiped
   local dsp =tostring(j) .. "-U" .. string.tohex(j) .. ":'" .. utf8(j) .."'  | "
   return j,dsp,nextFrom
end

function utf8ToStringRef(i,from)
   local txt=""
   local tmp=""
   local nextFrom=from
   local j=i
   j,txt,nextFrom=utf8ToStringBasic(j,nextFrom)
   j,tmp,nextFrom=utf8ToStringBasic(j+1,nextFrom)
   txt=txt..tmp
   j,tmp,nextFrom=utf8ToStringBasic(j+1,nextFrom)
   txt=txt..tmp
   j,tmp,nextFrom=utf8ToStringBasic(j+1,nextFrom)
   txt=txt..tmp   
   return j,txt,nextFrom
end
 
function UTF8Ref:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	printTitle(gc,UTF8_TITLE_ID,UTF8Ref.font)
    gc:setFont("sansserif","b",6)
	local count = 0
	local from = 1
	local i=self.curStart
    local j=0
    local curtxt=""
	while i<self.max and count<16 do
    	count=count+1
	    j,curtxt,from  = utf8ToStringRef(i,from)
		gc:drawString(curtxt, 5, 8+12*count, "top")
		i=j+1    
	end
	self.nextStart=i
end
 
function UTF8Ref:enterKey()
   self:setNewStart(self.nextStart)
end

function UTF8Ref:previous()
    self.curStart=self.previousHist:pop()
    UTF8Ref:invalidate()
end
function UTF8Ref:setNewStart(start)
    if self.nextStart~=self.curStart then
       self.previousHist:push(self.curStart)
	end
	self.curStart=start
    UTF8Ref:invalidate()
end

function UTF8Ref:arrowKey(arrow)
    if arrow=="right" then
       self:enterKey()
    elseif arrow=="left" then  
	   self:previous()
	end
    UTF8Ref:invalidate()
end

function UTF8Ref:escapeKey()
	only_screen_back(Ref)
end



 -- Including : C:\tiproject\finance\src\ui\math\combinatoire\combinatoire.lua

 

Combinatoire = addExtension(Screen,WidgetManager)
 

function Combinatoire:init(titleId,headerId)
  print("init Combinatoire")
  self.tasks={}
  self.title  = ASTxt(titleId) or ""
  self.header  = ASTxt(headerId) or ""
  self.titleId = titleId
  self.font = {"sansserif", "r", 10}
  self.operation = ""
  self.n= "n"
  self.p="p"
  self.r=0
  self.widgets  = {}
  self.enterN = sInput()
  self.enterN:setWidth(50)
  self.enterNLabel = sLabel(ASTxt(ENTER_N_ID),self.enterN)
  self.enterP = sInput()
  self.enterP:setWidth(50)
  self.enterPLabel = sLabel(ASTxt(ENTER_P_ID),self.enterP)
  self.lastInput=""
  self.enterN.value = self.n
  self.enterP.value = self.p
  self.htitle=20    
  self.focus  = 0
  self:size()
  print("end Combinatoire num of widget="..tostring(table.getn(self.widgets)))
end

function Combinatoire:CreateBox()
  if not self.Box then
     self.Box = D2Editor.newRichText()
     self.Box:createMathBox()
     self.lastInput=""
     self.Box:registerFilter {
            tabKey = function()
                 if not self.Box:hasFocus() then
                      Combinatoire:tabKey() 
                 end
              return true end,
            charIn = function(ch)
                   if not self.Box:hasFocus() then
                      Combinatoire:charIn(ch) 
                   end
                   return self.Box:hasFocus() 
                end,
            arrowKey = function(key) 
                   if not self.Box:hasFocus() then
                      Combinatoire:arrowKey(key) 
                   end
                   return self.Box:hasFocus()
                end
     }
  end
end
 
function Combinatoire:calculateSize()
   if self.lasth~=self.h or self.lastw~=self.w then
      print("pwh="..tostring(pwh())..";self.y="..self.y..";self.h="..tostring(self.h))
      self.lasth=self.h
      self.lastw=self.w
      
      self.htmp =self.htitle+5
      self.enterNLabelX=0
      print("self.enterNLabelX="..tostring(self.enterNLabelX))
      self.enterNLabel:setPos(0, htmp)
      self.enterNX=self.enterNLabelX+52
      print("self.enterNX="..tostring(self.enterNX))
      self.enterN:setPos(self.enterNX, htmp)
      self.enterN.number=false
      self.enterN:enable()
      self.enterPLabelX=self.enterNX+160
      print("self.enterPLabelX="..tostring(self.enterPLabelX))
      self.enterPLabel:setPos(self.enterPLabelX,htmp)
      self.enterPX=self.enterPLabelX+52
      print("self.enterPX="..tostring(self.enterPX))
      self.enterP:setPos(self.enterPX, htmp)
      self.enterP.number=false
      self.enterP:enable()
      
      self.boxX=2
      self.boxY=30+self.htmp 
      self.boxW= self.w-14
      self.boxH=self.h-self.boxY-6-self.htmp     
      self:invalidate()
      print("return true")
      return true
   end
   return false
end

function Combinatoire:refreshBox()
    self.x=0
    self.y=0
  self.ww = pww()
  self.hh = pwh()
  if self:calculateSize() or not self.Box then
      self:CreateBox()
      if self.Box and self.x and self.y and self.w and self.h then
        self.Box:move(self.boxX,self.boxY)
        self.Box:resize(self.boxW, self.boxH)
      end
  end
end
   

function Combinatoire:postPaint(gc)
    self:refreshBox()
end
 


function Combinatoire:extractTxt()
  if(self.enterN) then
     self.n=self.enterN.value
  else
     print("Warning : entern is null")
     self.n="n"
  end
  if(self.enterP) then
     self.p=self.enterP.value
  else
     print("Warning : enterp is null")
     self.p="p"
  end

  return self.n,self.p
end

function Combinatoire:setCSid(cid,sid)
    print("setCSid"..tostring(cid))
    self.cid = cid
    self.sid = sid
end

function  Combinatoire:pushed()
    print("Combinatoire:pushed")
    
    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end
    
    doNotDisplayIcon = true
    self:refreshBox()
    self.lasth = 0
    self.n= "n"
    self.p="p"
    self.widgets  = {}
    
    self:appendWidget(self.enterNLabel, self.enterNLabelX, self.htmp)
    print("appendWidget enterNLabel")
    self:appendWidget(self.enterN, self.enterNX, self.htmp)
    self.enterN.focusDown = 1
    print("appendWidget enterN")
    self:appendWidget(self.enterPLabel, self.enterPLabelX, self.htmp)
    print("appendWidget enterPLabel")
    self:appendWidget(self.enterP, self.enterPX, self.htmp)
    print("appendWidget enterP num of widget="..tostring(table.getn(self.widgets)))
            function self.enterN:enterKey()
                self:perform()
                self.Box:setFocus(true)
            end
            function self.enterP:enterKey()
                self:perform()
                self.Box:setFocus(true)
            end
    self.enterN:giveFocus()

    self:refreshBox()
    self.Box:setReadOnly(true)
    local form =tostring(self.header)..tostring(self.operation)
    self.Box:setBorderColor(0x51cecb)
    self.Box:setBorder(1)
    if self.Box.setExpression then
        self.Box:setColorable(true)
        self.Box:setTextColor(0x215c98)
        self.Box:setExpression(form, 1)
        self.Box:setFocus(false)
    else
        self.Box:setText(form, 1)
    end
    
          self.Box:setVisible(true)
          self:invalidate()
end


function Combinatoire:screenGetFocus()
    self:pushed()
end

function Combinatoire:screenLoseFocus()
    self:removed()
end


function Combinatoire:removed()
    if self.Box then
     if self.Box.setVisible then
           self.Box:setVisible(false)
     end
     self.Box:setText("")
     self.Box:resize(1, 1)
     self.Box:move(-10, -10)
     self.Box:registerFilter(nil)
      self.Box:setFocus(false)
    end
    doNotDisplayIcon = false
end
 
 
function Combinatoire:paint(gc)
  gc:setColorRGB(255,255,255)
  gc:fillRect(self.x, self.y, self.w, self.h)
  self.htitle = printTitle(gc,self.titleId,Combinatoire.font)
  local n,p=self:extractTxt()
  if (self.lastInput~=tostring(n)..","..tostring(p)) then
     self:perform()
     self.lastInput=tostring(n)..","..tostring(p)
     local form =tostring(self.header)..tostring(self.operation)
     if self.Box.setExpression then
        self.Box:setExpression(form, 1)
     else
         self.Box:setText(form, 1)
     end
  end
end

function Combinatoire:perform()
end

function Combinatoire:enterKey()
    self:perform()
end

function Combinatoire:arrowKey()
   self:enterKey()
end

function Combinatoire:escapeKey()
  local cid = self.cid
  print("before : "..tostring(cid))
  self:removed()
  print(tostring(cid))
  if cid then
    only_screen_back(SubCatSel, self.cid)
    print("reset cid")
    self.cid = nil
    self.sid = nil
    return
  end
  only_screen_back(Ref)
end



function printTitle(gc,idTxt,originalFont)
   gc:setColorRGB(0,0,0)
   gc:setFont("sansserif","b",12)
   drawXCenteredString(gc,ASTxt(idTxt),5)
   gc:setFont(Greek.font,"r",12) 
   return 22
end

References	= {
	{title=ASTxt(IPP_TITLE_ID), screen=Ipp       },
	{title=ASTxt(ARRANGEMENT_AVEC_REP_TITLE_ID),screen=ArrangementAvecRep },
	{title=ASTxt(ARRANGEMENT_SANS_REP_TITLE_ID),screen=ArrangementSansRep },
  {title=ASTxt(COMBINAISONS_AVEC_REP_TITLE_ID),screen=CombinaisonsAvecRep },
	{title=ASTxt(COMBINAISONS_SANS_REP_TITLE_ID),screen=CombinaisonsSansRep },
	{title=ASTxt(PERMUTATION_AVEC_REP_TITLE_ID),screen=PermutationAvecRep },
  {title=ASTxt(PERMUTATION_SANS_REP_TITLE_ID),screen=PermutationSansRep },
  {title=ASTxt(PARTITION_NON_ORD_TITLE_ID), screen=PartitionNonOrd },
  {title=ASTxt(GREEK_TITLE_ID), screen=Greek   },
	{title=ASTxt(UTF8_TITLE_ID), screen=UTF8Ref  },
}

Ref	= WScreen()

RefList	= sList()
RefList:setSize(-8, -32)

Ref:appendWidget(RefList, 4, Ref.y+28)

function Ref.addRefs()
	for n, ref in ipairs(References) do
		if ref.screen then
			table.insert(RefList.items, ref.title)
		else
			table.insert(RefList.items, ref.title .. " (not yet done)")  -- TODO !
		end
	end
end

function RefList:action(ref)
	if References[ref].screen then
		push_screen(References[ref].screen)
	end
end

function Ref:pushed()
	RefList:giveFocus()
end

function Ref:paint(gc)
    gc:setFont("serif", "b", 16)
    gc:drawString("Reference", self.x+6, -2, "top")
    gc:setFont("serif", "r", 12)
end

function Ref:tabKey()
    push_screen(CategorySel)
end

Ref.escapeKey = Ref.tabKey

Ref.addRefs()


 -- Including : C:\tiproject\finance\src\ui\about.lua



aboutWindow	= Dialog(ASTxt(ABOUT_TITLE_ID), 50, 20, 280, 200)


local aboutButton	= sButton("OK")

for i, line in ipairs(aboutstr:split("\n")) do
	local aboutlabel	= sLabel(line)
	aboutWindow:appendWidget(aboutlabel, 10, 27 + i*14-12)
end

aboutWindow:appendWidget(aboutButton,-10,-5)

function aboutWindow:postPaint(gc)
	nativeBar(gc, self, self.h-40)
	on.help = function() return 0 end
end

aboutButton:giveFocus()

function aboutButton:action()
	remove_screen(aboutWindow)
	on.help = function() push_screen_direct(aboutWindow) end
end

 -- Including : C:\tiproject\finance\src\ui\error.lua



errorHandler = {}

function errorPopup(gc)
    errorHandler.display = false

    errorDialog = Dialog(ASTxt(ERROR_TITLE_ID), 50, 20, "85", "80")

    local textMessage	=  ASTxt(ERROR_ID) .. errorHandler.errorLine .. ":"..errorHandler.errorMessage..")"
    
    local errorOKButton	= sButton("OK")
    
    for i, line in ipairs(textMessage:split("\n")) do
        local errorLabel = sLabel(line)
        errorDialog:appendWidget(errorLabel, 10, 27 + i*14-12)
    end
    
    errorDialog:appendWidget(errorOKButton,-10,-5)
    
    function errorDialog:postPaint(gc)
        nativeBar(gc, self, self.h-40)
    end
    
    errorOKButton:giveFocus()
    
    function errorOKButton:action()
        remove_screen(errorDialog)
        errorHandler.errorMessage = nil
    current_screen():onErrorDispEnd();
    end
    current_screen():onErrorDispStart();
    push_screen_direct(errorDialog)
end

function handleError(line, errMsg, callStack, locals)
    print(ASTxt(ERROR_TITLE_ID), errMsg)
    errorHandler.display = true
    errorHandler.errorMessage = errMsg
    errorHandler.errorLine = line
    errorHandler.callStack = callStack
    errorHandler.locals = locals
    platform.window:invalidate()
    return true -- go on....
end

if platform.registerErrorHandler then
    platform.registerErrorHandler( handleError )
end





 -- Including : C:\tiproject\finance\src\ui\launch.lua

function on.help()
  push_screen_direct(aboutWindow)
end

function on.create()
  platform.os = "3.9"
end

function on.construction()
  platform.os = "3.9"
end



push_screen_direct(CategorySel)



