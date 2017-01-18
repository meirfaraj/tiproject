
require("math/math")


Obligation={}


function Obligation.FluxInFine(self,T,r,Ve,Vn )
   if tiNspire.toNumber(T)~=nil then
      local res="[0,-"..tostring(Ve)..",-"..tostring(Ve);
      
      for i = 1,T do
        local calc = tostring(r).."*"..tostring(Vn)
        if i==tiNspire.toNumber(T) then
           res = tostring(res)..";"..tostring(i)..","..tostring(Vn).."+"..calc..","..tostring(tiNspire.execute(tostring(Vn).."+"..calc))
        else 
           res = tostring(res)..";"..tostring(i)..","..calc..","..tostring(tiNspire.execute(calc))
        end
      end 
      self:appendMathToResult(res.."]")
   end
end

function Obligation.TABInFine(self,T,r,Ve,Vn)
  if tiNspire.toNumber(T)~=nil then
   local eq = tostring(Ve).."="
   local calc = tostring(r).."*"..tostring(Vn)
   local coupon = tostring(tiNspire.execute(calc));
   local calc = calc.."="..tostring(coupon)
   self:appendToResult("\ncoupon : ")
   self:appendMathToResult(calc)
   for i = 1,T do
        if i==tiNspire.toNumber(T) then
           calc="("..tostring(Vn).."+"..coupon..")/(rx^"..tostring(i)..")"
        else 
           calc=coupon.."/(rx^"..tostring(i)..")+"
        end
        eq=eq..calc
   end
   self:appendMathToResult(eq)
   self:appendMathToResult(tostring(tiNspire.solve(tiNspire.solve(eq,"rx"),"rx")))
   self:appendToResult("\n since rx>0 : ")
   self:appendMathToResult(tostring(tiNspire.solveCond(tiNspire.solveCond(eq,"rx","rx>0"),"rx","rx>0")))
   self:appendToResult("\n rx=1+r* => r*=rx-1 : ")
   self:appendToResult("\n=> TAB "..a_acute.." l'"..e_acute.."mission : r*=")
   local res = tostring(tiNspire.nSolveCond(eq,"rx","rx>0"));
   self:appendMathToResult(res.."-1="..tostring(tiNspire.approx("("..res.."-1)*100")).."%")
  end
end
