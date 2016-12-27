  
--------------------------------------------------------------------------
--                            Permutation avec repetion                 --
--------------------------------------------------------------------------
require("ui/wscreen")


ArrangementAvecRep = Combinatoire(ARRANGEMENT_AVEC_REP_TITLE_ID,ARRANGEMENT_AVEC_REP_HEADER_ID)
 

function ArrangementAvecRep:performnp(n,p)
    local calculate = "("..tostring(n)..")^("..tostring(p)..")"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}\n" 
    if err1 then
       res = res.."ERROR:"..tostring(err1)
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2)
    end
    return res
end

function ArrangementAvecRep:perform()
    print("ArrangementAvecRepCls:perform")
    self.font ={"sansserif", "r", 10}    
    self.operation=""
    local n,p=self:extractTxt()
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       p=0
       while p<=tonumber(n) do
          self.operation=self.operation..self:performnp(n,p)
          p=p+1
       end
    else
       self.operation=self.operation..self:performnp(n,p)
    end
    self:invalidate()
end


