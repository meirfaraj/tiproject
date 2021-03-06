
EN = 1
addLocale(EN,"en", "english")

addTextLocale(ABOUT_TITLE_ID,EN,"About Probabilities :")

addTextLocale(ABOUT_ID,EN,[[Probabilities v1.0
--------------------
Faraj Meir
Thanks also to :
Jim Bauwens, Adrien "Adriweb" Bertrand
(inspired from FormulaPro).
LGPL3 License. Locale:]]..localeName..[[

Tip : Press [Tab] for Reference !]])


addTextLocale(ERROR_TITLE_ID,EN,"Oops... Error handled !")
 
addTextLocale(ERROR_ID,EN,[[Probabilities has encountered an error
-----------------------------
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
--TODO : translate
addTextLocale(CATEGORY_TEST_NORMALITE_ID,EN,"Test de normalité")
--TODO : translate
addTextLocale(CATEGORY_TEST_NORMALITE_DESC_ID,EN,"applications pour tester la normalité")


--TODO : translate
addTextLocale(ARRANGEMENT_AVEC_REP_TITLE_ID,EN,"Arrangements avec répétitions")
--TODO : translate
addTextLocale(ARRANGEMENT_AVEC_REP_HEADER_ID,EN,"Arrangements (suite ordonnée) avec répétitions : on a\n \\0el {Pn^p=n^p}\n")
--TODO : translate
addTextLocale(ARRANGEMENT_SANS_REP_TITLE_ID,EN,"Arrangements sans répétitions")
--TODO : translate
addTextLocale(ARRANGEMENT_SANS_REP_HEADER_ID,EN,"Arrangement(suite ordonnée) sans répétitions : on a\n \\0el {An^p=(n!)/(n-p)!}\n")
--TODO : translate
addTextLocale(PERMUTATION_AVEC_REP_TITLE_ID,EN,"Permutation avec p éléments identiques")
--TODO : translate
addTextLocale(PERMUTATION_AVEC_REP_HEADER_ID,EN,"Permutation avec répétitions(de n éléments avec p objetc identiques): on a\n \\0el {Pn^p=n!/p!}\n")
--TODO : translate
addTextLocale(PERMUTATION_SANS_REP_TITLE_ID,EN,"Permutation sans répétitions")
--TODO : translate
addTextLocale(PERMUTATION_SANS_REP_HEADER_ID,EN,"Permutation sans répétitions : on a\n \\0el {Pn=n!}\n")
--TODO : translate
addTextLocale(COMBINAISONS_AVEC_REP_TITLE_ID,EN,"Combinaisons avec répétitions")
--TODO : translate
addTextLocale(COMBINAISONS_AVEC_REP_HEADER_ID,EN,"Combinaisons(suite non ordonnée) avec répétition : on a\n \\0el {"..c_gama.."n^p=C(n+p-1)^p=[[n+p-1][p]]=(n+p-1)!/(p!*(n-1)!)}\n")
--TODO : translate
addTextLocale(COMBINAISONS_SANS_REP_TITLE_ID,EN,"Combinaisons sans répétitions")
--TODO : translate
addTextLocale(COMBINAISONS_SANS_REP_HEADER_ID,EN,"Combinaisons(suite non ordonnée) sans répétition : on a\n \\0el {Cn^p=[[n][p]]=An^p/p!=n!/(p!*(n-p)!)}\n")
--TODO : translate
addTextLocale(PARTITION_NON_ORD_TITLE_ID,EN,"Partition non ordonnée")
--TODO : translate
addTextLocale(PARTITION_NON_ORD_HEADER_ID,EN,"Partition non ordonnée : on a\n 1- par recurence \\0el {S(n,p)=S(n-1,p-1)+p*S(n-1,p)}\n2 - \\0el {S(n,p)=∑((−1)^((p-1))nCr(p,j)*j^(n),j,0,p)}\n")
addTextLocale(RESULT_WITH_RECURSIVE_STIRLING_ID,EN,"results with the recursive formule : ")
--TODO : translate
addTextLocale(LOI_BINOMIAL_1VAR_TITLE_ID,EN,"Loi binomial une va. (X) B(n,p)")
--TODO : translate
addTextLocale(LOI_BINOMIAL_1VAR_HEADER_ID,EN,"la somme de nvariables de Bernouilli ou la probabilité est p suit une loi binomial B(n,p).\nOn a \\0el {P(X=k)=Cn^k p^kq^(n-k)} avec q=1-p E(X)=np et V(X)=npq\n")
--TODO : translate
addTextLocale(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID,EN,"Loi hypergeometrique H(N,n,p)")
--TODO : translate
addTextLocale(LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=(CpN^k x CqN^(n-k))/CN^n} avec q=1-p \\0el {E(X)=n*p} et \\0el {V(X)=npq(N-n)/(N-1)}\n")
--TODO : translate
addTextLocale(LOI_UNIFORME_1VAR_TITLE_ID,EN,"Loi uniforme")
--TODO : translate
addTextLocale(LOI_UNIFORME_1VAR_HEADER_ID,EN,"\\0el {P(X=xi)=1/n} pour tous xi \\0el {E(X)=(n+1)/2} et \\0el {V(X)=(n^2-1)/12}\n")
--TODO : translate
addTextLocale(LOI_BERNOULLI_1VAR_TITLE_ID,EN,"Loi de Bernoulli")
--TODO : translate
addTextLocale(LOI_BERNOULLI_1VAR_HEADER_ID,EN,"\\0el {P(X=xi)=1/n} pour tous xi \\0el {E(X)=(n+1)/2} et \\0el {V(X)=(n^2-1)/12}\n")
--TODO : translate
addTextLocale(LOI_POISSON_1VAR_TITLE_ID,EN,"Loi de poisson")
--TODO : translate
addTextLocale(LOI_POISSON_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=("..c_lambda.."^k"..")} pour tous xi \\0el {E(X)=(n/p} et \\0el {V(X)=(nq)/p^2}\n")
--TODO : translate
addTextLocale(LOI_BINOMIAL_NEG_1VAR_TITLE_ID,EN,"Loi binomiale négative")
--TODO : translate
addTextLocale(LOI_BINOMIAL_NEG_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=C(k-1)^(n-1)p^nq^(k-n)} k>n \\0el {E(X)=(n/p} et \\0el {V(X)=(nq)/p^2}\n")
--TODO : translate
addTextLocale(LOI_GEOMETRIQUE_1VAR_TITLE_ID,EN,"Loi géométrique")
--TODO : translate
addTextLocale(LOI_GEOMETRIQUE_1VAR_HEADER_ID,EN,"\\0el {P(X=k)=pq^(k-1)} \\0el {E(X)=1/p} et \\0el {V(X)=q/p^2}\n")
addTextLocale(LOI_NORMAL_1VAR_TITLE_ID,EN,"Loi Normal/de Gauss/Laplace-Gauss")
--TODO : translate
addTextLocale(LOI_NORMAL_1VAR_HEADER_ID,EN,"\\0el {f(x)=1/("..c_sigma..sqrt_sym.."(2*"..c_pi.."))*"..exp_sym.."^(1/2*((x-"..c_mu..")/("..c_sigma.."))^2)} \\0el {E(X)="..c_mu.."} et \\0el {V(X)="..c_sigma.."^2}\n")

