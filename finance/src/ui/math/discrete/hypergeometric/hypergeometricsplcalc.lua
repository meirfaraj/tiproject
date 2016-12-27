--------------------------------------------------------------------------
--                            loi hypergeometrique                      --
--------------------------------------------------------------------------
  
  
LoiHypergeometriqueSplCalc = Discrete3Params(LOI_HYPERGEOMETRIQUE_1VAR_TITLE_ID,LOI_HYPERGEOMETRIQUE_1VAR_HEADER_ID)


function LoiHypergeometriqueSplCalc:checkValidity(N,n,p,k1,op1,op2,k2)

    if tostring(op1)=="none" and tostring(op2)=="none" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end

    if tostring(k2)=="" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end
    return true,""
end

function LoiHypergeometriqueSplCalc:performEx(n,p)
   local calc = tostring(n).."*("..tostring(p)..")"
   local result1,err1 = math.evalStr(tostring(calc))
   local result1b,err1b = math.evalStr("approx("..tostring(calc)..")")
   local res = "\\0el {E(X)="..tostring(calc).."}"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
   if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
   res = res.."\\0el {="..tostring(result1).."="..tostring(result1b).."}"
   return res
end


function LoiHypergeometriqueSplCalc:performVx(N,n,p)
   local calc = tostring(n).."*("..tostring(p)..")*(1-("..tostring(p).."))*(("..tostring(N).."-"..tostring(n)..")/("..tostring(N).."-1))"
   local result1,err1 = math.evalStr(tostring(calc))
   local result1b,err1b = math.evalStr("approx("..tostring(calc)..")")
   local res = "\\0el {V(X)="..tostring(calc).."}"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
   if err1b then
       res = res.."ERROR:"..tostring(err1b).."\n"
    end    
   res = res.."\\0el {="..tostring(result1).."="..tostring(result1b).."}"
   return res
end

function LoiHypergeometriqueSplCalc:performEqual(N,n,p,k2)
   local pstr = "("..tostring(p)..")"
   local pNstr = "("..tostring(pstr).."*"..tostring(N)..")"
   local qNstr = "((1-"..tostring(pstr)..")*"..tostring(N)..")"
   local nlessk = "("..tostring(n).."-"..tostring(k2)..")"
   
   local res = "\\0el {P(X="..tostring(k2)..")="..
   "(C"..tostring(pNstr).."^"..tostring(k2).."*"..
   "C"..tostring(qNstr).."^"..tostring(nlessk)..")/"..
   "C"..tostring(N).."^"..tostring(n).."="..
   "((("..tostring(pNstr).."!)/(("..tostring(pNstr).."-"..tostring(k2)..")!*"..tostring(k2).."!))*"..
   "(("..tostring(qNstr).."!)/(("..tostring(qNstr).."-"..tostring(nlessk)..")!*"..tostring(nlessk).."!)))/"..
   "(("..tostring(N).."!)/(("..tostring(N).."-"..tostring(n)..")!*"..tostring(n).."!))}"
   
   local calc1a="("..tostring(pNstr).."!)/(("..tostring(pNstr).."-"..tostring(k2)..")!*"..tostring(k2).."!)"
   local calc1b="("..tostring(qNstr).."!)/(("..tostring(qNstr).."-"..tostring(nlessk)..")!*"..tostring(nlessk).."!)"
   local calc1c="("..tostring(N).."!)/(("..tostring(N).."-"..tostring(n)..")!*"..tostring(n).."!)"
   local result1,err1 = math.evalStr(tostring(calc1a))
   local result2,err2 = math.evalStr(tostring(calc1b))
   local result3,err3 = math.evalStr(tostring(calc1c))
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end    
    if err2 then
       res = res.."ERROR:"..tostring(err2).."\n"
    end  
    if err3 then
       res = res.."ERROR:"..tostring(err3).."\n"
    end    
   local calc2 = "((("..tostring(result1)..")*("..tostring(result2).."))/("..tostring(result3).."))"
   res=res.."=\\0el {"..tostring(calc2).."}"   
   local result4,err4 = math.evalStr(tostring(calc2))
   local result4b,err4b = math.evalStr("approx("..tostring(calc2)..")")   
   if err4 then
       res = res.."ERROR:"..tostring(err4).."\n"
   end
   if err4b then
       res = res.."ERROR:"..tostring(err4b).."\n"
   end        
   res=res.."=\\0el {"..tostring(result4).."="..tostring(result4b).."}"
   
   return res,result4
end

function LoiHypergeometriqueSplCalc:performGreaterOrEqual(N,n,p,k2)
   local res = "\\0el {P(X>="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)>(tonumber(n)/2)) then
          res = res .. "\\0el {=1-P(X<="..(tostring(k2)-1)..")}\n"
          local k3=tonumber(k2)-1
          
          local demRes,value = self:performSmallerOrEqual(N,n,p,k3)
          
          res = res .. "\\0el {P(X<="..tostring(k3)..")="..tostring(value).."} =>\n"
          local result1,err1 = math.evalStr("1-"..tostring(value))
          res = res .. "\\0el {1-P(X<="..(tostring(k2)-1)..")="..tostring(result1)
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          result1,err1 = math.evalStr("approx(1-"..tostring(value)..")") 
          res = res .. "="..tostring(result1).."}\n"
          res = res .. ASTxt(DEMONSTRATION_ID).."\n"
          
          res = res .. tostring(demRes)
          return res
       end
   end
     res= res.."\\0el {∑(P(X=i),i,"..tostring(k2)..","..tostring(n)..")}\n"
     local details1 =""
     local details2 =""
     if tonumber(n)~=nil and (tonumber(k2)~=nil) then
         for i=tonumber(k2),tonumber(n) do
            local dem,val=self:performEqual(N,n,p,i)
            if(i>tonumber(k2)) then
               details1=details1.."+"
            end
            details1=details1..tostring(val)
            details2= details2..tostring(dem).."\n"
         end
     end

     local result1,err1 = math.evalStr(details1)
     res = res .. "=\\0el {"..tostring(details1)..")="..tostring(result1).."}"
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
     result1,err1 = math.evalStr("approx("..details1..")")
     res = res .. "=\\0el {"..tostring(result1).."}"
       if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
     res = res .."\n".. details2    
     return res
end


function LoiHypergeometriqueSplCalc:performGreater(N,n,p,k2)
   local k3 = ""
   if(tonumber(k2)~=nil)then
      k3 = tonumber(k2)+1
   else
      k3 = "("..tostring(k2).."+1)"
   end
   local res = "\\0el {P(X>"..tostring(k2)..")=P(X>="..tostring(k3).."}\n"
   res = res..self:performGreaterOrEqual(N,n,p,k3)
   return res
end

function LoiHypergeometriqueSplCalc:performSmallerOrEqual(n,p,k2)
   local res = "\\0el {P(X<="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)<(tonumber(n)/2)) then
          res = res .. "\\0el {=1-P(X>="..(tostring(k2)+1)..")}\n"
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(tonumber(k2)+1)..","..tostring(n)..")"
          local result1,err1 = math.evalStr(tostring(calc)) 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          res = res .. "\\0el {P(X>="..(tostring(k2)+1)..")="..tostring(result1).."} =>\n"
          result1,err1 = math.evalStr("1-"..tostring(calc))
          res = res .. "\\0el {1-P(X>="..(tostring(k2)+1)..")="..tostring(result1)
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          result1,err1 = math.evalStr("approx(1-"..tostring(calc)..")") 
          res = res .. "="..tostring(result1).."}\n"
          res = res .. ASTxt(DEMONSTRATION_ID).."\n"
          res = res .. self:performGreaterOrEqual(n,p,k2)
       end
   end
     res= res.."\\0el {∑(P(X=i),i,0,"..tostring(k2)..")}\n"
     if (tonumber(k2)~=nil) then
         for i=0,tonumber(k2) do
            res= res..self:performEqual(N,n,p,i).."\n"
         end
     end
     return res
end

function LoiHypergeometriqueSplCalc:performSmaller(n,p,k2)
   local k3 = ""
   if(tonumber(k2)~=nil)then
      k3 = tonumber(k2)-1
   else
      k3 = "("..tostring(k2).."-1)"
   end
   local res = "\\0el {P(X<"..tostring(k2).."=P(X<="..tostring(k3).."}\n"
   res = res..self:performSmallerOrEqual(n,p,k3)
   return res
end

function LoiHypergeometriqueSplCalc:performBetween(n,p,k1,op1,op2,k2)
    local res="\\0el {P("..tostring(k1)..tostring(op1).."X"..tostring(op2)..tostring(k2)..")="
    --optimise if possible
    if (tonumber(n)~=nil and tonumber(k1)~=nil and tonumber(k2)~=nil) then
       -- check witch calv give less calculation:
       -- k2-k1
    end
    local k3 = k1
    local k4 = k2
    local reprintEquality = false
    if op1=="<" then
       if tonumber(k1)~=nil then
          k3 = tonumber(k1) - 1
       else
          k3 = tostring(k1).. "-1"
       end
       reprintEquality = true
    end
    if op2=="<" then 
       if tonumber(k2)~=nil then
          k4 = tonumber(k2) + 1
       else
          k4 = tostring(k2).. "+1"
       end   
      reprintEquality = true
    end
    if reprintEquality then
       res=res.."\\0el {=P("..tostring(k3).."<=X<="..tostring(k4)..")=" 
    end
    local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(k4)..")"  
    local result1,err1 = math.evalStr(tostring(calc))
    res=res..tostring(result1).."}\n"
    if err1 then
       res = res.."ERROR:"..tostring(err1).."\n"
    end
    local calc2a = "binomCdf("..tostring(n)..",("..tostring(p).."),0,"..tostring(k3)..")"  
    local calc2b = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k4)..","..tostring(n)..")"  
    local result2a,err2a = math.evalStr(tostring(calc2a))
    local result2b,err2b = math.evalStr(tostring(calc2b))
    
    res=res.."\\0el {=P(X<="..tostring(k4)..")-P(X<="..tostring(k3)..")="..tostring(result2b).."-"..tostring(result2a).."="..tostring(result1).."}\n"
    if err2a then
       res = res.."ERROR:"..tostring(err2a).."\n"
    end  
    if err2b then
       res = res.."ERROR:"..tostring(err2b).."\n"
    end
    res = res..self:performSmallerOrEqual(n,p,k3).."\n"
    res = res..self:performSmallerOrEqual(n,p,k4).."\n"
    return res
end

function LoiHypergeometriqueSplCalc:performHNnP(N,n,p,k1,op1,op2,k2)
    local isValid,errtxt = self:checkValidity(N,n,p,k1,op1,op2,k2)
    if (not isValid) then
       return errtxt
    end

    if (op2=="=") then
       return self:performEqual(N,n,p,k2)
    end

    if (op1=="<" or op1=="<=") and (op2=="<" or op2=="<=") then
      return self:performBetween(N,n,p,k1,op1,op2,k2)
    end
    
    if (op2=="<" ) then
       return self:performSmaller(N,n,p,k2)
    end
    
    if (op2=="<=") then
      return self:performSmallerOrEqual(N,n,p,k2)
    end
    
    if (op2==">") then 
      return self:performGreater(N,n,p,k2)
    end
    
    if (op2==">=") then 
      return self:performGreaterOrEqual(N,n,p,k2)
    end
    
    return ASTxt(NOT_SUPPORTED_ID)
end

function LoiHypergeometriqueSplCalc:perform()
    print("LoiHypergeometriqueSplCalc:perform")
    self.font ={"sansserif", "r", 10}
    local bn,sn,p,k1,compare1,compare2,k2 =self:extractTxt()
    self.operation=""
    if (tostring(bn)=="nil") or tostring(bn)=="" then
      return self.operation
    end
    if (tostring(sn)=="nil") or tostring(sn)=="" then
      return self.operation
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
      return self.operation
    end

    local ex = self:performEx(sn,p)
    local vx = self:performVx(bn,sn,p)

    local exVx=tostring(ex).."\n"..tostring(vx)
    self.operation=exVx
    if (tostring(k1)=="nil") then
      return self.operation
    end

    if (tostring(k2)=="nil") or tostring(k2)=="" then
      return self.operation
    end



    if (tostring(compare1)=="nil") or tostring(compare1)=="" then
      return self.operation
    end

    if (tostring(compare2)=="nil") or tostring(compare2)=="" then
      return self.operation
    end
    self.operation=self:performHNnP(bn,sn,p,k1,compare1,compare2,k2).."\n"..tostring(exVx)
    self:invalidate()
    return self.operation
end
