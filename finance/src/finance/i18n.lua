--------------------------------------------------------------------------
--                                  Local dependents                    --
--------------------------------------------------------------------------
require("std/symbols")
require("std/i18n")


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

CATEGORY_TIME_MONEY_VALUE_ID=108
CATEGORY_TIME_MONEY_VALUE_DESC_ID=109
CATEGORY_MONEY_MARKET_ID=110
CATEGORY_MONEY_MARKET_DESC_ID=111
CATEGORY_FIXED_INCOME_ID=112
CATEGORY_FIXED_INCOME_DESC_ID=113
CATEGORY_GESTION_DE_PORTEFEUILLE_ID=114
CATEGORY_GESTION_DE_PORTEFEUILLE_DESC_ID=115
FONCTION_UTILITE_ID=116
FONCTION_UTILITE_ID_HEADER_ID=117
EQUIVALENT_CERTAIN_ID=118
EQUIVALENT_CERTAIN_HEADER_ID=119
PRIME_DE_RISQUE_ID=120
PRIME_DE_RISQUE_HEADER_ID=121


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

TAUX_SIMPLE_TITLE_ID=236
TAUX_SIMPLE_TITLE_HEADER_ID=237
TAUX_COMPOSE_TITLE_ID=238
TAUX_COMPOSE_TITLE_HEADER_ID=239
TAB_AMORT_TITLE_ID=240
TAB_AMORT_TITLE_HEADER_ID=241
CONVENTION_DE_BASE_TITLE_ID=242
CONVENTION_DE_BASE_TITLE_HEADER_ID=243
MARCHE_OBLIGATAIRE_TITLE_ID=244
MARCHE_OBLIGATAIRE_TITLE_HEADER_ID=245
SWAP_DE_TAUX_TITLE_ID=246
SWAP_DE_TAUX_TITLE_HEADER_ID=247
T_A_T_I_F_ET_GAMMES_DES_TAUX_Z_C_TITLE_ID=248
T_A_T_I_F_ET_GAMMES_DES_TAUX_Z_C_TITLE_HEADER_ID=249
EX_OBLIGATION_1_TITLE_ID=250
EX_OBLIGATION_1_TITLE_HEADER_ID=251
EXERCICES_TITLE_ID=252
MATRICE_VAR_COVAR_ID=253
MATRICE_VAR_COVAR_HEADER_ID=254

version="1.1-"..c_alpha

require("finance/i18n/en")
require("finance/i18n/fr")


curLocaleId = ASLocaleId(localeName)


 
local aboutstr	= ASTxt(ABOUT_ID)
