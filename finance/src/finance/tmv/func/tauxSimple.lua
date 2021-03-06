require("math/math")
require("std/callendar")

TauxSimplef={}

function TauxSimplef.cours()
   return "I=Crn=CrT\n(F=FV)\nF=-C(1+rT)" ..
          "\nplusieurs convention : exact/exact"
end

function TauxSimplef.calcn(self,c,r,n)
   self:appendMathToResult("I=C*r*n")   
   self:appendToResult("="..tostring(c).."*"..tostring(r).."*"..tostring(r))
   self:appendToResult("=")
   local calc=tostring(c).."*"..tostring(r).."*"..tostring(n)
   self:appendMathToResult(calc)
   self:appendToResult("=")
   self:appendMathToResult(math.evalStr(calc))
   self:appendToResult("=")
   self:appendMathToResult(tiNspire.approx(calc))
end

function TauxSimplef.calct(self,c,r,nj,na)
   self:appendMathToResult("I=C*r*T=C*r*(Nj/Na)")   
   self:appendToResult("="..tostring(c).."*"..tostring(r).."*("..tostring(nj).."/"..tostring(na)..")")
   self:appendToResult("=")
   local calc=tostring(c).."*"..tostring(r).."*("..tostring(nj).."/"..tostring(na)..")"
   self:appendMathToResult(calc);
   self:appendToResult("=")
   self:appendMathToResult(math.evalStr(calc));
   self:appendToResult("=")
   self:appendMathToResult(tiNspire.approx(calc))

end

function TauxSimplef.calct_exactExact(self,c,r,nj,na)
   if nj~="Nj" and na~="Na" then
      self:appendToResult("entre "..tostring(nj).." et "..tostring(na).." il y a :")
      nj=tiNspire.dbd(nj,na)
      self:appendMathToResult( "Nj="..tostring(nj))
      self:appendToResult("Na=365")
      na=tostring(365)
   end
   TauxSimplef.calct(self,varValue["C"],r,nj,na)
end


function TauxSimplef.calct_exact360(self,c,r,nj,na)
   if nj~="Nj" and na~="Na" then
      self:appendToResult("entre "..tostring(nj).." et "..tostring(na).." il y a :")
      nj=tiNspire.dbd(nj,na)
      self:appendMathToResult( "Nj="..tostring(nj))
      self:appendToResult("On pose Na=360 (convention exact/360)")
      na=tostring(360)
   end
   TauxSimplef.calct(self,varValue["C"],r,nj,na)
end

function TauxSimplef.calct_30360(self,c,r,nj,na)
   if nj~="Nj" and na~="Na" then
      local nj,njstr=cal.nbjours30(date1,date2)
      self:appendToResult(tostring(njstr).."\n")
      self:appendMathToResult( "Nj="..tostring(nj))
      self:appendToResult("On pose Na=360 (convention 30/360)")
      na=tostring(360)
   end
   TauxSimplef.calct(self,varValue["C"],r,nj,na)
end

