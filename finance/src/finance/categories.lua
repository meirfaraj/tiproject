----------------------------------------------
-- Categories && Sub-Categories && Formulas --
----------------------------------------------

require("ui/screen")

require("finance/tmv/tmv")

require("ui/genref/greekref")
require("ui/genref/utf8ref")
require("finance/tmv/cours/mathfi/conventionDeBase")
require("finance/tmv/cours/mathfi/gen/marcheObligataire")
require("finance/tmv/cours/mathfi/gen/CoursLesSwaps")
require("finance/tmv/cours/mathfi/gen/ExempleGenaralSwap")
require("finance/tmv/cours/mathfi/gen/ExempleValoEtRisqueSwap")
require("finance/tmv/cours/mathfi/gen/ExempleSwapAvecTauxForward")
require("finance/tmv/cours/mathfi/gen/GestionPtfEfficienceMarko")
require("finance/tmv/cours/mathfi/gen/ModelesPtfCapmCml")
require("finance/tmv/cours/mathfi/gen/TATIFEtGammesDesTauxZC")
require("finance/tmv/cours/mathfi/gen/InstrumentsVanillesTauxFlottant")
require("finance/oblig/ex1")
require("finance/portfeuille/utilite")
require("finance/portfeuille/equivCertain")
require("finance/portfeuille/primeDeRisque")
require("finance/portfeuille/matriceVarianceCovariance")
require("finance/portfeuille/matriceFonctionDutilite")
require("finance/portfeuille/sansActifSansRisqueMinimisationRisque")
require("finance/portfeuille/sansActifSansRisqueMinimisationRisque2")
require("finance/portfeuille/sansActifSansRisqueMinimisationRisque3")
require("finance/portfeuille/detCompositionPortefeuilleZ")
require("finance/portfeuille/detCompositionPortefeuilleAversionRisque")
require("finance/portfeuille/portefeuilleEfficientCompoXf")
require("finance/portfeuille/portefeuilleEfficientCompoXf2")
require("finance/portfeuille/portefeuilleEfficientCompoXf3")
require("finance/portfeuille/portefeuilleEfficientCompoXf4")

require("finance/swap/swapPreteur")


References  = {
  {title=ASTxt(MARCHE_OBLIGATAIRE_TITLE_ID), screen=MarcheObligataire  },
  {title=ASTxt(T_A_T_I_F_ET_GAMMES_DES_TAUX_Z_C_TITLE_ID), screen=TATIFEtGammesDesTauxZC  },
  {title="Instruments Vanilles Taux Flottant", screen=InstrumentsVanillesTauxFlottant },
  {title=ASTxt(SWAP_DE_TAUX_TITLE_ID).." - Cours", screen=CoursLesSwaps },
  {title=ASTxt(SWAP_DE_TAUX_TITLE_ID).." - Expl Gen", screen=ExempleGenaralSwap },
  {title=ASTxt(SWAP_DE_TAUX_TITLE_ID).." - Expl Valo+Risk", screen=ExempleValoEtRisqueSwap },
  {title=ASTxt(SWAP_DE_TAUX_TITLE_ID).." - Expl Swap+Forward", screen=ExempleSwapAvecTauxForward },
  {title=ASTxt(GESTION_PTF_EFFICIENCE_MARKO_TITLE_ID), screen=GestionPtfEfficienceMarko },
  {title=ASTxt(MODELES_PTF_CAPM_CML_TITLE_ID), screen=ModelesPtfCapmCml },
  {title=ASTxt(CONVENTION_DE_BASE_TITLE_ID), screen=ConventionDeBaseCours  },
  {title=ASTxt(GREEK_TITLE_ID), screen=Greek   },
  {title=ASTxt(UTF8_TITLE_ID), screen=UTF8Ref  },
}


----------------------TMV---------------------------------------
addCat(1, ASTxt(CATEGORY_TIME_MONEY_VALUE_ID), ASTxt(CATEGORY_TIME_MONEY_VALUE_DESC_ID))
addSubCatScreen(1,1,ASTxt(TAUX_SIMPLE_TITLE_ID),ASTxt(TAUX_SIMPLE_TITLE_HEADER_ID),TauxSimple)
addSubCatScreen(1,2,ASTxt(TAUX_COMPOSE_TITLE_ID),ASTxt(TAUX_COMPOSE_TITLE_HEADER_ID),TauxCompose)
addSubCatScreen(1,3,ASTxt(TAB_AMORT_TITLE_ID),ASTxt(TAB_AMORT_TITLE_HEADER_ID),TabAmort)


----------------------MONEY MARKET---------------------------------------
addCat(2, ASTxt(CATEGORY_MONEY_MARKET_ID), ASTxt(CATEGORY_MONEY_MARKET_DESC_ID))
addSubCatScreen(2,1,ASTxt(TAUX_SIMPLE_TITLE_ID),ASTxt(TAUX_SIMPLE_TITLE_HEADER_ID),TauxSimple)

----------------------FIXED INCOME---------------------------------------
addCat(3, ASTxt(CATEGORY_FIXED_INCOME_ID), ASTxt(CATEGORY_FIXED_INCOME_DESC_ID))
addSubCatScreen(3,1,ASTxt(TAUX_SIMPLE_TITLE_ID),ASTxt(TAUX_SIMPLE_TITLE_HEADER_ID),TauxSimple)


----------------------Swap---------------------------------------
addCat(4, ASTxt(SWAP_ID), ASTxt(SWAP_HEADER_ID))
addSubCatScreen(4,1, ASTxt(SWAP_PRETEUR_ID), ASTxt(SWAP_PRETEUR_HEADER_ID),SwapPreteur)

----------------------Portfolio management---------------------------------------

addCat(5, ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_ID).." - Pref. et util.", ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID))
addSubCatScreen(5,1,ASTxt(FONCTION_UTILITE_ID),ASTxt(FONCTION_UTILITE_ID_HEADER_ID),FonctionUtilite)
addSubCatScreen(5,2,ASTxt(EQUIVALENT_CERTAIN_ID),ASTxt(EQUIVALENT_CERTAIN_HEADER_ID),EquivCertain)
addSubCatScreen(5,3,ASTxt(PRIME_DE_RISQUE_ID),ASTxt(PRIME_DE_RISQUE_HEADER_ID),PrimeDeRisque)


----------------------Portfolio management---------------------------------------

addCat(6, ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_ID).." - 2 actifs", ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID))
addSubCatScreen(6,1,ASTxt(DET_COMPOSITION_PORTEFEUILLE_ID),ASTxt(DET_COMPOSITION_PORTEFEUILLE_HEADER_ID),CompositionPortefeuilleZ)
addSubCatScreen(6,2,ASTxt(DET_COMPOSITION_PORTEFEUILLE_AR_ID),ASTxt(DET_COMPOSITION_PORTEFEUILLE_AR_HEADER_ID),CompositionPortefeuilleAversionRisque)

addCat(7, ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_ID).." - Matrice VarCov", ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID))
addSubCatScreen(7,1,ASTxt(MATRICE_VAR_COVAR_ID),ASTxt(MATRICE_VAR_COVAR_HEADER_ID),MatriceVarianceCovariance)


addCat(8, ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_ID).." - Lagr.", ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID))
addSubCatScreen(8,1,ASTxt(SANS_ACTIF_SANS_RISQUE_MIN_ID),ASTxt(SANS_ACTIF_SANS_RISQUE_MIN_HEADER_ID),SansActifSansRisqueMinimisationDeRisque)
addSubCatScreen(8,2,ASTxt(SANS_ACTIF_SANS_RISQUE_MIN_ID).."-2",ASTxt(SANS_ACTIF_SANS_RISQUE_MIN_HEADER_ID),SansActifSansRisqueMinimisationDeRisque2)
addSubCatScreen(8,3,ASTxt(SANS_ACTIF_SANS_RISQUE_MIN_ID).."-3",ASTxt(SANS_ACTIF_SANS_RISQUE_MIN_HEADER_ID),SansActifSansRisqueMinimisationDeRisque3)
addSubCatScreen(8,4,ASTxt(SANS_ACTIF_SANS_RISQUE_MAX_ID),ASTxt(SANS_ACTIF_SANS_RISQUE_MAX_HEADER_ID),MatriceFunctionDutilite)
addSubCatScreen(8,5,ASTxt(SANS_ACTIF_SANS_RISQUE_MAX_ID).."-2",ASTxt(SANS_ACTIF_SANS_RISQUE_MAX_HEADER_ID),MatriceFunctionDutilite)


addCat(9, ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_ID).." - Matr. Func Util", ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID))
addSubCatScreen(9,1,ASTxt(MATRICE_FUNC_UTIL_ID),ASTxt(MATRICE_FUNC_UTIL_HEADER_ID),MatriceFunctionDutilite)

addCat(10, ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_ID).." - Ptf T", ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID))
addSubCatScreen(10,1,ASTxt(PORTEFEUILLE_EFFICIENT_ID),ASTxt(PORTEFEUILLE_EFFICIENT_HEADER_ID),PortefeuilleEfficientXf)
addSubCatScreen(10,2,ASTxt(PORTEFEUILLE_EFFICIENT_ID).." - det "..c_theta,ASTxt(PORTEFEUILLE_EFFICIENT_HEADER_ID),PortefeuilleEfficientXfTheta)
addSubCatScreen(10,3,ASTxt(PORTEFEUILLE_EFFICIENT_ID).." - det comp avec "..c_beta,ASTxt(PORTEFEUILLE_EFFICIENT_HEADER_ID),PortefeuilleEfficientBeta)
addSubCatScreen(10,4,ASTxt(PORTEFEUILLE_EFFICIENT_ID).." - det risk actif X", ASTxt(PORTEFEUILLE_EFFICIENT_HEADER_ID), PortefeuilleEfficientActifX)

addCat(11, ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_ID).." - CAPM/CML", ASTxt(CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID))

----------------------Exercice FIXED INCOME---------------------------------------
addCat(12, ASTxt(EXERCICES_TITLE_ID)..ASTxt(CATEGORY_FIXED_INCOME_ID), ASTxt(CATEGORY_FIXED_INCOME_DESC_ID))
addSubCatScreen(12,1,ASTxt(EX_OBLIGATION_1_TITLE_ID),ASTxt(EX_OBLIGATION_1_TITLE_HEADER_ID),Oblig_Ex1)

