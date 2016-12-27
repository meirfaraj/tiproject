
--------------------------------------------------------------------------
--                            Partition non ordonnée                        --
--------------------------------------------------------------------------

PartitionNonOrd = Combinatoire(PARTITION_NON_ORD_TITLE_ID,PARTITION_NON_ORD_HEADER_ID)


function PartitionNonOrd:StirlingRecursive(n,k)
  if k>n then
    return 0 , "S("..tostring(n)..","..tostring(k)..")=0\n"
  elseif (k==n) or (k==1) then
    return 1, "S("..tostring(n)..","..tostring(k)..")=1\n"
  else
    local val1,detail1 = self:StirlingRecursive(n-1,k-1)
    local val2,detail2 = self:StirlingRecursive(n-1,k)
    return  val1 + k*val2,detail1..detail2.."=> S("..tostring(n)..","..tostring(k)..")=S("..tostring(n-1)..","..tostring(k-1)..")+"..tostring(k).."*"..
          "S("..tostring(n-1)..","..tostring(k)..")="..tostring(val1).."+"..tostring(k).."*"..tostring(val2).."="..tostring(val1 + k*val2).."\n"
  end
end



function PartitionNonOrd:performnp(n,p)
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) and ((tonumber(n)<tonumber(p)) or (tonumber(p)<=0)) then
      return ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
    end

    local calculate = "1/("..tostring(p).."!)*∑((−1)^("..tostring(p).."-j)*nCr("..tostring(p)..",j)*j^("..tostring(n).."),j,0,"..tostring(p)..")"
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
    local val,details
    if (tonumber(n) ~= nil) and (tonumber(p) ~= nil) then
       val,details=self:StirlingRecursive(tonumber(n),tonumber(p))
       if val and details then
          res=res..ASTxt(RESULT_WITH_RECURSIVE_STIRLING_ID)..tostring(val).."\n"
          res=res..ASTxt(DEMONSTRATION_ID).." :\n"
          res=res..details
       end
    end
    
    return res
end

function PartitionNonOrd:perform()
    print("PartitionNonOrd:perform")
    self.font ={"sansserif", "r", 10}
    local n,p=self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
       if(tonumber(n))==nil then
          self.operation=self.operation..ASTxt(FOR_ID).." n="..tostring(n).." "..ASTxt(AND_ID).." p="..tostring(p).." "..ASTxt(INVALID_PARAMETERS_ID).." => 0"
          return
       end
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


