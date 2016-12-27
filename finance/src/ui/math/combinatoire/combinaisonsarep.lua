  
--------------------------------------------------------------------------
--                            Combinaisons avec repetition               --
--------------------------------------------------------------------------
require("ui/wscreen")

CombinaisonsAvecRep = Combinatoire(COMBINAISONS_AVEC_REP_TITLE_ID,COMBINAISONS_AVEC_REP_HEADER_ID)


function CombinaisonsAvecRep:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
       return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(n).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end
    local calculate = "("..tostring(n).."+"..tostring(p).."-1"..")!/("..tostring(p).."!*("..tostring(n).."-1)!)"
    local subeval = "("..tostring(n).."+"..tostring(p).."-1"..")"
    local calculateC = "nCr("..tostring(n).."+"..tostring(p).."-1"..","..tostring(p)..")"
    print(tostring(calculate))
    local result,err1 = math.evalStr(tostring(calculate))
    local resultb,err1b = math.evalStr(tostring(subeval))
    local disp = "("..tostring(resultb)..")!/("..tostring(p).."!*("..tostring(n).."-1)!)"
    local dispC = "nCr("..tostring(resultb)..","..tostring(p)..")"
    local resultA,err2 = math.evalStr("approx("..tostring(calculate)..")")
    local resultC,err3 = math.evalStr(tostring(calculateC))
    local res = ASTxt(SOLVE_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).."\n=>  \\0el {"..tostring(calculate).."}=\\0el {"..disp.."}=\\0el {"..tostring(result).."}=\\0el {"..tostring(resultA).."}=\\0el {"..tostring(resultC).."}(build in funct: "..tostring(calculateC).."=\\0el {"..dispC.."})\n" 

    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    if err3 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end
    return res
end

function CombinaisonsAvecRep:perform()
    print("CombinaisonsAvecRep:perform")
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


