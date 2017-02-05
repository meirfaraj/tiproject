--------------------------------------------------------------------------
-- cours exported from CoursLesSwaps.txt
--------------------------------------------------------------------------


CoursLesSwaps = Tmv(COURS_LES_SWAPS_TITLE_ID,COURS_LES_SWAPS_TITLE_HEADER_ID)

function CoursLesSwaps:performCalc()
  self:appendToResult("")
  self:appendTitleToResult("Les Swaps Cours")
  self:appendToResult("Swap taux fixe contre taux variable ou taux fixe donneur:swap emprunteur ")
  self:appendMathToResult("M * Di*[TV-TF]")
  self:appendToResult(".\n")
  self:appendToResult("Swap taux variable contre taux fixe ou taux fixe receveur:swap preteur ")
  self:appendMathToResult("M * Di*[TF-TV]")
  self:appendToResult(".\n")
  self:appendToResult("Swap taux fixe k donneur: ")
  self:appendMathToResult("S(r-k)")
  self:appendToResult(" s'analyse comme un emprunt à taux fixe k combiné à \n")
  self:appendToResult("un pret à taux variable r, long actif Ar et court actik Ak: ")
  self:appendMathToResult("S(r-k)=Ar-Ak")
  self:appendToResult(" et vis versa pour ")
  self:appendMathToResult("S(k-r)")
  self:appendToResult(".\n")
  self:appendToResult("")
  self:appendMathToResult("S(k-r)=ak-ar")
  self:appendToResult(": jambe fixe -jambe variable ou bien ")
  self:appendMathToResult("S(k-r)=Ak-Ar")
  self:appendToResult(": composante fixe - composante variable \n")
  self:appendToResult("Deux méthodes de valorisation des swap: démantèlement et équivalence.\n")
  self:appendToResult("pour démentèlement on actualise en utilisant les taux ZC extrait des gamme des taux swap k(t)")

end

