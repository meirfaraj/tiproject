  
--------------------------------------------------------------------------
--                            Taux compose                               --
--------------------------------------------------------------------------
require("ui/wscreen")
require("finance/tmv/func/tauxCompose")



TauxCompose = Tmv(TAUX_COMPOSE_TITLE_ID,TAUX_COMPOSE_TITLE_HEADER_ID)
 
function TauxCompose:onChangeUpd()
  local sel = self.inputs[1][4].value
  local label1 = self.inputs[5][3] 
  local label2 = self.inputs[6][3] 
  local inp2 = self.inputs[6][4] 
  if sel == "n" then
      label1.text = "nb de periodes n:"
      label2:disable()
      inp2:disable()
  elseif  sel == "nb jour/jour" then
      label1.text = "nb de jour Nj:"
      label2.text = "jour ann�e Na:"
      label2:enable()
      inp2:enable()
  elseif  sel == "exact/exact" or sel == "exact/360" or sel == "30/360" then
      label1.text = "debut:(JJMM.AA)"
      label2.text = "fin :"
      label2:enable()
      inp2:enable()
  end
  self:invalidate()
end

function TauxCompose:widgetsInit()
   self:add(-1,{"n","nombre d'annee","nb jour/jour","exact/exact","exact/360","30/360"},"ptype",true)
   self:add(-1,{"%","value"},"%type")
   self:add(0,"Capital C:","C")
   self:add(0,"Taux d'interet r:","r")
   self:add(1,"periode:","p")
   self:add(1,"nb de periodes n:","n")
   self:add(1,"date fin:","de")
end

function TauxCompose:checkNaNj()
      self.Nj = tostring(varValue["n"])
      self.Na = tostring(varValue["de"])
      if Nj=="n" then
         self.Nj="Nj"
      end
      if Na=="de" then
         self.Na="Na"
      end
end

function TauxCompose:performCalc()
   local r = varValue["r"]
   if varValue["%type"] == "%" then
      local calc = tostring(r).."/100"
      self:appendToResult(tostring(r).."%="..calc)
      r=tostring(math.evalStr(calc))
      self:appendToResult("="..tostring(r).."\n")
   end   
   if varValue["ptype"] == "n" then
      TauxComposef.calcn(self,varValue["C"],r,varValue["n"])
      return
   end
   self:checkNaNj()
-- nothing to be done in "nb jour/jour"
   if varValue["ptype"] == "exact/exact" then
      TauxComposef.calct_exactExact(self,varValue["C"],r,self.Nj,self.Na)
      return
   end
   if varValue["ptype"] == "exact/360" then
      TauxComposef.calct_exact360(self,varValue["C"],r,self.Nj,self.Na)
      return   
   end
   if varValue["ptype"] == "30/360" then
      TauxComposef.calct_30360(self,varValue["C"],r,self.Nj,self.Na)
      return   
   end
   TauxComposef.calct(self,varValue["C"],r,self.Nj,self.Na)
end


