
FR = 2
addLocale(FR,"fr", "français")

addTextLocale(ABOUT_TITLE_ID,FR,"A propos de Probabilités :")

addTextLocale(ABOUT_ID,FR,[[Probabilités v1.0
--------------------
Faraj Meir
Merci à :
Jim Bauwens, Adrien "Adriweb" Bertrand
(inspiré de FormulaPro).
Licence LGPL3. Locale:]]..localeName..[[

conseil : Appuyé [Tab] pour les références !]])


addTextLocale(ERROR_TITLE_ID,FR,"Oops... Erreur intercepté !")

addTextLocale(ERROR_ID,FR,[[Probabilités à rencontré une erreur
-----------------------------
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
 