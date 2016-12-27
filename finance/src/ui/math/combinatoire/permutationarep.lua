  
--------------------------------------------------------------------------
--                            Permutation avec repetition                 --
--------------------------------------------------------------------------
require("ui/wscreen")

 
PermutationAvecRep = Combinatoire(PERMUTATION_AVEC_REP_TITLE_ID,PERMUTATION_AVEC_REP_HEADER_ID)



function PermutationAvecRep:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
       return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(n).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end
    local calculate = "("..tostring(n).."!)/("..tostring(p).."!)"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}\n" 
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    return res
end

function PermutationAvecRep:perform()
    print("PermutationAvecRep:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
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
       self.operation=self:performnp(n,p)
    end
    self:invalidate()
end
