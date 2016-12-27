

--algo ne prends pas en compte
--le cas ou c'est une primitive usuel pas besoin dans ce cas d'ipp
--algo ne prends pas en compte si on a une autre variable que x
--algo ne sort pas les constantes et ne simplifie pas avant de choisir
-- les deux parties
function autoexpr(expression)  
  local ux
  local vpx
  
  if hasMult(expression) then
    vpx = 1
    ux = expression
  else
  
  local strexpr
   DelVar ux
   DelVar vpx
   strexpr:=string(expression)
     vpx:=1
     ux:=expression
   Else
     local tmp1,tmp2
     tmp1:=part(expression,1)
     tmp2:=part(expression,2)
     Try
       If dim(string(?(tmp1,x)))+dim(string(?(tmp2,x)))<dim(string(?(tmp1,x)))+dim(string(?(tmp2,x))) Then
        ux:=part(expression,2)
        vpx:=part(expression,1)
       Else
        ux:=part(expression,1)
        vpx:=part(expression,2)
       EndIf
     Else
     ux:=part(expression,1)
     vpx:=part(expression,2)
     EndTry
   EndIf
end
   
function ipp(userexpr)
   local exprRes = autoexpr(userexpr)
   local tmp
   upx:=?(ux,x)
   vx:=?(vpx,x)
   Disp "On prend : u(x) = ",ux,"  et  v'(x) = ",vpx
   Disp "     Donc :  u'(x) = ",upx,"  et  v(x) = ",vx
   Disp "On applique la formule : "
   Disp "     ?(u*v')  =  [u*v]  -  ?(u'*v)"
   Disp "Donc on a : "
   Disp "     ? [u*v] = ",ux,"*",vx," = ",ux*vx
   tmp:=?(upx*vx,x)
   Disp "     ? ?(u'*v) =  ?(",upx,"*",vx,")dx = ","?(",upx*vx,")dx = ",tmp
   Disp "D'où : ?(",userexpr,") = ",string(ux*vx)&"-("&string(tmp)&")"
   Disp "         =   ",ux*vx-tmp
   Try
     If 0=inString(string(?(ux*vpx,x)),"?") Then
       If ux*vx-tmp??(ux*vpx,x) Then
             Disp ?(ux*vpx,x)
             Disp "(véritable résultat)"
       EndIf
     Else
       Disp "L'intégrale n'est pas déterminable..."
     EndIf
   Else
     Disp "L'intégrale n'est pas déterminable..."
   EndTry
   DelVar ux
   DelVar upx
   DelVar vx
   DelVar vpx
end

function ippgui()
   local userexpr
   Request "Fonction (x) ? ",userexpr
   ipp(userexpr)
end

function numipp(userexpr,borneinf,bornesup)
Prgm
:autoexpr(userexpr)
:Local tmp
:upx:=?(ux,x)
:vx:=?(vpx,x)
:Disp "On prend : u(x) = ",ux,"  et  v'(x) = ",vpx
:Disp "     Donc :  u'(x) = ",upx,"  et  v(x) = ",vx
:Disp "On applique la formule (de ",borneinf," à ",bornesup,")"
:Disp "     ?(u*v')  =  [u*v]  -  ?(u'*v)"
:Disp "Donc on a : "
:Local tmp1,tmp2,tmp3
:tmp1:=ux*vx|x=bornesup
:tmp2:=ux*vx|x=borneinf
:Disp "     ? [u*v] = ",ux,"*",vx," = ",ux*vx," de ",borneinf," à ",bornesup," = ",tmp1-tmp2
:tmp3:=?(upx*vx,x,borneinf,bornesup)
:Disp "     ? ?(u'*v) =  ?(",upx,"*",vx,")dx = ","?(",upx*vx,")dx = ",?(upx*vx,x)," et de ",borneinf," à ",bornesup," = ",tmp3
:Disp "D'où entre",borneinf," et ",bornesup,",  ?(",userexpr,") = ",tmp1-tmp2-tmp3
:Try
:  If 0=inString(string(?(ux*vpx,x,borneinf,bornesup)),"?") Then
:    If tmp1-tmp2-tmp3??(ux*vpx,x,borneinf,bornesup) Then
:       Disp ?(ux*vpx,x,borneinf,bornesup)
:       Disp "(véritable résultat)"
:    EndIf
:  Else
:     Disp "L'intégrale n'est pas déterminable..."
:  EndIf
:Else
:  Disp "L'intégrale n'est pas déterminable..."
:EndTry
:DelVar borneinf
:DelVar bornesup
end

