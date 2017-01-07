  
--------------------------------------------------------------------------
--                            Obligation                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/oblig/func/obligation")


-- obligation in fine
Ex2 = Tmv(EX_OBLIGATION_2_TITLE_ID,EX_OBLIGATION_2_TITLE_HEADER_ID)
 

function Ex2:widgetsInit()
   self:add(-1,{"%","value"},"%type")
   self:add(0,"Emission oblig in fine au terme de ","T")
   self:add(1,"Taux nominal r:","r")
   self:add(1,"valeur d'emis. Ve:","Ve")
   self:add(2,"Valuer nominal Vn=Vr:","Vn")  
end

function Ex2:performCalc()
   local T = varValue["T"]
   local r = varValue["r"]
   local Ve = varValue["Ve"]
   local Vn = varValue["Vn"]
   if varValue["%type"] == "%" then
      local calc = tostring(r).."/100"
      self:appendToResult(tostring(r).."%="..calc)
      r=tostring(tiNspire.approx(calc))
      self:appendToResult("="..tostring(r).."\n")
   end   
   Obligation.FluxInFine(self,T,r,Ve,Vn )
   Obligation.TABInFine(self,T,r,Ve,Vn )
end

