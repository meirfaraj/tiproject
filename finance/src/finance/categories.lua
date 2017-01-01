----------------------------------------------
-- Categories && Sub-Categories && Formulas --
----------------------------------------------

require("ui/screen")

require("finance/tmv/tmv")

require("ui/genref/greekref")
require("ui/genref/utf8ref")
require("finance/tmv/cours/mathfi/conventionDeBase")
require("finance/tmv/cours/mathfi/gen/marcheObligataire.lua")
require("finance/tmv/cours/mathfi/gen/SwapDeTaux.lua")
require("finance/tmv/cours/mathfi/gen/TATIFEtGammesDesTauxZC.lua")

References  = {
  {title=ASTxt(CONVENTION_DE_BASE_TITLE_ID), screen=ConventionDeBaseCours  },
  {title=ASTxt(MARCHE_OBLIGATAIRE_TITLE_ID), screen=MarcheObligataire  },
  {title=ASTxt(SWAP_DE_TAUX_TITLE_ID), screen=SwapDeTaux  },
  {title=ASTxt(T_A_T_I_F_ET_GAMMES_DES_TAUX_Z_C_TITLE_ID), screen=TATIFEtGammesDesTauxZC  },

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
