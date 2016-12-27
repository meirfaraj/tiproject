
----------------------------------------------
-- Categories && Sub-Categories && Formulas --
----------------------------------------------
require("ui/math/ippref")
require("ui/genref/greekref")
require("ui/genref/utf8ref")
require("ui/math/combinatoire/combinatoire")

References  = {
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

require("ui/screen")
require("ui/math/combinatoire/combinatoire")
require("ui/math/discrete/discrete2param")
require("ui/math/discrete/discrete3param")

require("ui/math/continue/continue2param")
require("ui/math/testNormalite/testNormalite")

----------------------Combinatoire---------------------------------------
addCat(1, ASTxt(CATEGORY_COMBINATOIRE_ID), ASTxt(CATEGORY_COMBINATOIRE_DESC_ID))

--addCatVar(1, "n", "Number ", "m2")
--addSubCat(1, 1, "Resistance Formulas", "")
addSubCatScreen(1,1,ASTxt(ARRANGEMENT_AVEC_REP_TITLE_ID),ASTxt(ARRANGEMENT_AVEC_REP_HEADER_ID),ArrangementAvecRep)
addSubCatScreen(1,2,ASTxt(ARRANGEMENT_SANS_REP_TITLE_ID),ASTxt(ARRANGEMENT_SANS_REP_HEADER_ID),ArrangementSansRep)
addSubCatScreen(1,3,ASTxt(COMBINAISONS_AVEC_REP_TITLE_ID),ASTxt(COMBINAISONS_AVEC_REP_HEADER_ID),CombinaisonsAvecRep)
addSubCatScreen(1,4,ASTxt(COMBINAISONS_SANS_REP_TITLE_ID),ASTxt(COMBINAISONS_SANS_REP_HEADER_ID),CombinaisonsSansRep)
addSubCatScreen(1,5,ASTxt(PERMUTATION_AVEC_REP_TITLE_ID),ASTxt(PERMUTATION_AVEC_REP_HEADER_ID),PermutationAvecRep)
addSubCatScreen(1,6,ASTxt(PERMUTATION_SANS_REP_TITLE_ID),ASTxt(PERMUTATION_SANS_REP_HEADER_ID),PermutationSansRep)
addSubCatScreen(1,7,ASTxt(PARTITION_NON_ORD_TITLE_ID),ASTxt(PARTITION_NON_ORD_HEADER_ID),PartitionNonOrd)


--aF(1, 1, "R=("..c_rho.."*len)/A",U("R",c_rho,"len","A") )
--aF(1, 1, "G=("..c_O.."*A)/len",U("G",c_O,"len","A") )
--aF(1, 1, "G=1/R", U("G","R"))
--aF(1, 1, c_O.."=1/"..c_rho, U(c_O,c_P))

----------------------Loi discretes---------------------------------------

addCat(2, ASTxt(CATEGORY_LOIS_DISCRETES_ID), ASTxt(CATEGORY_LOIS_DISCRETES_DESC_ID))
addSubCatScreen(2,1,ASTxt(LOI_UNIFORME_1VAR_TITLE_ID),ASTxt(LOI_UNIFORME_1VAR_HEADER_ID),LoiUniforme)
addSubCatScreen(2,2,ASTxt(LOI_BERNOULLI_1VAR_TITLE_ID),ASTxt(LOI_BERNOULLI_1VAR_HEADER_ID),LoiBernoulli)
addSubCatScreen(2,3,ASTxt(LOI_BINOMIAL_1VAR_TITLE_ID),ASTxt(LOI_BINOMIAL_1VAR_HEADER_ID),LoiBinomialSplCalc)
addSubCatScreen(2,4,ASTxt(LOI_POISSON_1VAR_TITLE_ID),ASTxt(LOI_POISSON_1VAR_HEADER_ID),LoiPoisson)
addSubCatScreen(2,5,ASTxt(LOI_BINOMIAL_NEG_1VAR_TITLE_ID),ASTxt(LOI_BINOMIAL_NEG_1VAR_HEADER_ID),LoiBinomialNegSplCalc)
addSubCatScreen(2,6,ASTxt(LOI_GEOMETRIQUE_1VAR_TITLE_ID),ASTxt(LOI_GEOMETRIQUE_1VAR_HEADER_ID),LoiGeometriqueSplCalc)
addSubCatScreen(2,7,ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID),ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID),LoiHypergeometriqueSplCalc)


----------------------Loi continue---------------------------------------


addCat(3, ASTxt(CATEGORY_LOIS_CONTINUE_ID), ASTxt(CATEGORY_LOIS_CONTINUE_DESC_ID))
addSubCatScreen(3,1,ASTxt(LOI_NORMAL_1VAR_TITLE_ID),ASTxt(LOI_NORMAL_1VAR_HEADER_ID),LoiNormalSplCalc)
addSubCatScreen(3,2,ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID),ASTxt(LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID),LoiHypergeometriqueSplCalc)

----------------------Test de normalite---------------------------------------

addCat(4, ASTxt(CATEGORY_TEST_NORMALITE_ID), ASTxt(CATEGORY_TEST_NORMALITE_DESC_ID))
addSubCatScreen(4,1,ASTxt(TEST_WILCOXON_ID),ASTxt(TEST_WILCOXON_HEADER_ID),TestNormaliteWilcoxon)


