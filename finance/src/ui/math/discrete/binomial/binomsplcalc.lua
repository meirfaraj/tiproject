--------------------------------------------------------------------------
--                            loi binomial                              --
--------------------------------------------------------------------------
  
LoiBinomialSplCalc = Spl2Params(LOI_BINOMIAL_1VAR_TITLE_ID,LOI_BINOMIAL_1VAR_HEADER_ID,ENTER_N_ID,ENTER_P_ID)

function LoiBinomialSplCalc:checkValidity(n,p,k1,op1,op2,k2)

    if tostring(op1)=="none" and tostring(op2)=="none" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end

    if tostring(k2)=="" then
      return false, ASTxt(NOTHING_TO_DO_ID).."\n"
    end
    return true,""
end

function LoiBinomialSplCalc:performEx(n,p)
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


function LoiBinomialSplCalc:performVx(n,p)
   local calc = tostring(n).."*("..tostring(p)..")*(1-("..tostring(p).."))"
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

function LoiBinomialSplCalc:performEqual(n,p,k2)
   local res = "\\0el {P(X="..tostring(k2)..")=C"..tostring(n).."^"..tostring(k2).."*("..tostring(p)..")^"..tostring(k2).."*q^("..tostring(n).."-"..tostring(k2)..")="..
    "(("..tostring(n).."!)/(("..tostring(n).."-"..tostring(k2)..")!*"..tostring(k2).."!))".."*("..tostring(p)..")^"..tostring(k2).."*(1-("..tostring(p).."))^("..tostring(n).."-"..tostring(k2)..")}"
   local calc1a="(("..tostring(n).."!)/(("..tostring(n).."-"..tostring(k2)..")!*"..tostring(k2).."!))"
   local calc1b="(("..tostring(p)..")^"..tostring(k2)..")"
   local calc1c="(1-("..tostring(p).."))^("..tostring(n).."-"..tostring(k2)..")"
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
    res=res.."=\\0el {("..tostring(result1)..")*("..tostring(result2)..")*("..tostring(result3).."))}"   
   local calc2 = "(("..tostring(n).."!)/(("..tostring(n).."-"..tostring(k2)..")!*"..tostring(k2).."!))".."*("..tostring(p)..")^"..tostring(k2).."*(1-("..tostring(p).."))^("..tostring(n).."-"..tostring(k2)..")"
   local calc3 = "binomPdf("..tostring(n)..",("..tostring(p).."),"..tostring(k2)..")"
   local result4,err4 = math.evalStr(tostring(calc2))
   local result4b,err4b = math.evalStr("approx("..tostring(calc2)..")")   
   local result5,err5 = math.evalStr(tostring(calc3))
   if err4 then
       res = res.."ERROR:"..tostring(err4).."\n"
   end
   if err4b then
       res = res.."ERROR:"..tostring(err4b).."\n"
   end        
   if err5 then
       res = res.."ERROR:"..tostring(err5).."\n"
   end    
   res=res.."=\\0el {"..tostring(result4).."="..tostring(result4b).."} (build in funct: \\0el {"..tostring(result5).."})"
   
   return res
end

function LoiBinomialSplCalc:performGreaterOrEqual(n,p,k2)
   local res = "\\0el {P(X>="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)>(tonumber(n)/2)) then
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(tonumber(k2))..","..tostring(n)..")"
          local result1,err1 = math.evalStr(tostring(calc)) 
          local result1a,err1a = math.evalStr("approx("..tostring(calc)..")") 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          if err1a then
             res = res.."ERROR:"..tostring(err1a).."\n"
          end 

          res = res .. "\\0el {"..tostring(result1).."="..tostring(result1a).."}(using calc)=\n"          
          res = res .. "\\0el {1-P(X<="..(tostring(k2)-1)..")}\n"
          
          calc = "binomCdf("..tostring(n)..",("..tostring(p).."),0,"..tostring(tonumber(k2)).."-1)"
          local result1,err1 = math.evalStr(tostring(calc)) 
          local result1a,err1a = math.evalStr("approx("..tostring(calc)..")") 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          if err1a then
             res = res.."ERROR:"..tostring(err1a).."\n"
          end 
          res = res .. "\\0el {P(X<="..(tostring(k2)-1)..")="..tostring(result1).."="..tostring(result1a).."} =>\n"
          result1,err1 = math.evalStr("1-"..tostring(calc))
          res = res .. "\\0el {1-P(X<="..(tostring(k2)-1)..")="..tostring(result1)
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          result1,err1 = math.evalStr("approx(1-"..tostring(calc)..")") 
          res = res .. "="..tostring(result1).."}\n"
          res = res .. ASTxt(DEMONSTRATION_ID).."\n"
          res = res .. self:performSmallerOrEqual(n,p,k2-1)
          return res
       end
   end
     res= res.."\\0el {∑(P(X=i),i,"..tostring(k2)..","..tostring(n)..")}\n"
     local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k2)..","..tostring(n)..")"
     local result1,err1 = math.evalStr(tostring(calc)) 
     if err1 then
         res = res.."ERROR:"..tostring(err1).."\n"
     end   
     res = res .. "\\0el {"..tostring(result1).."} =>\n"
     if (tonumber(k2)~=nil) then
         for i=tonumber(k2),tonumber(n) do
            res= res..self:performEqual(n,p,i).."\n"
         end
     end
     return res
end


function LoiBinomialSplCalc:performGreater(n,p,k2)
   local k3 = ""
   if(tonumber(k2)~=nil)then
      k3 = tonumber(k2)+1
   else
      k3 = "("..tostring(k2).."+1)"
   end
   local res = "\\0el {P(X>"..tostring(k2).."=P(X>="..tostring(k3).."}\n"
   res = res..self:performGreaterOrEqual(n,p,k3)
   return res
end

function LoiBinomialSplCalc:performSmallerOrEqual(n,p,k2)
   local res = "\\0el {P(X<="..tostring(k2)..")} = "
   if tonumber(n)~=nil and tonumber(k2)~=nil then
       if (tonumber(n)-tonumber(k2)<(tonumber(n)/2)) then
          local k3 =tonumber(k2)+1
          res = res .. "\\0el {1-P(X>="..tostring(k3)..")}\n"
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(n)..")"
          local result1,err1 = math.evalStr(tostring(calc)) 
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end   
          res = res .. "\\0el {P(X>="..(tostring(k2).."+1")..")="..tostring(result1).."} =>\n"
          result1,err1 = math.evalStr("1-"..tostring(calc))
          res = res .. "\\0el {1-P(X>="..tostring(k3)..")="..tostring(result1)
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
            res= res..self:performEqual(n,p,i).."\n"
         end
     end
     return res
end

function LoiBinomialSplCalc:performSmaller(n,p,k2)
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

function LoiBinomialSplCalc:performBetween(n,p,k1,op1,op2,k2)
    local res="\\0el {P("..tostring(k1)..tostring(op1).."X"..tostring(op2)..tostring(k2)..")=}"
    --optimise if possible
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
             res=res.."\\0el {P("..tostring(k3).."<=X<="..tostring(k4)..")=}" 
          end
    if (tonumber(n)~=nil and tonumber(k3)~=nil and tonumber(k4)~=nil) then
       -- check witch calv give less calculation:
       if(tonumber(k4)-tonumber(k3)>tonumber(n)-(tonumber(k4)-tonumber(k3))) then
          local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(k4)..")"  
          local result1,err1 = math.evalStr(tostring(calc))
          res=res..tostring(result1).."}\n"
          if err1 then
             res = res.."ERROR:"..tostring(err1).."\n"
          end
          local calc2a = "binomCdf("..tostring(n)..",("..tostring(p).."),0,"..tostring(k3).."-1)"  
          local calc2b = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k4)..","..tostring(n)..")"  
          local result2a,err2a = math.evalStr(tostring(calc2a))
          local result2b,err2b = math.evalStr(tostring(calc2b))
          
          res=res.."\\0el {=P(X<="..tostring(k4)..")-P(X<"..tostring(k3).."-1)="..tostring(result2b).."-"..tostring(result2a).."="..tostring(result1).."}\n"
          if err2a then
             res = res.."ERROR:"..tostring(err2a).."\n"
          end  
          if err2b then
             res = res.."ERROR:"..tostring(err2b).."\n"
          end
          res = res..self:performSmallerOrEqual(n,p,tostring(k3).."-1").."\n"
          res = res..self:performSmallerOrEqual(n,p,k4).."\n"
          return res
       end
       local calc = "binomCdf("..tostring(n)..",("..tostring(p).."),"..tostring(k3)..","..tostring(k4)..")"  
       local result,err = math.evalStr(tostring(calc))
       local resulta,erra = math.evalStr("approx("..tostring(calc)..")")
       res=res.."\\0el {"..tostring(result).."="..tostring(resulta).."}\n"
          if err then
             res = res.."ERROR:"..tostring(err).."\n"
          end        
          if erra then
             res = res.."ERROR:"..tostring(erra).."\n"
          end  
       res= res.."\\0el {∑(P(X=i),i,"..tostring(k3)..","..tostring(k4)..")}\n"      
       for i=tonumber(k3),tonumber(k4) do
         res= res..self:performEqual(n,p,i).."\n"
       end 
       return res
    end
    res= res.."\\0el {∑(P(X=i),i,"..tostring(k3)..","..tostring(k4)..")}\n"    
    return res
end

function LoiBinomialSplCalc:performBNP(n,p,k1,op1,op2,k2)
    local isValid,errtxt = self:checkValidity(n,p,k1,op1,op2,k2)
    if (not isValid) then
       return errtxt
    end

    if (op2=="=") then
       return self:performEqual(n,p,k2)
    end

    if (op1=="<" or op1=="<=") and (op2=="<" or op2=="<=") then
      return self:performBetween(n,p,k1,op1,op2,k2)
    end
    
    if (op2=="<" ) then
       return self:performSmaller(n,p,k2)
    end
    
    if (op2=="<=") then
      return self:performSmallerOrEqual(n,p,k2)
    end
    
    if (op2==">") then 
      return self:performGreater(n,p,k2)
    end
    
    if (op2==">=") then 
      return self:performGreaterOrEqual(n,p,k2)
    end
    
    return ASTxt(NOT_SUPPORTED_ID)
end

function LoiBinomialSplCalc:perform()
    print("LoiBinomialSplCalc:perform")
    self.font ={"sansserif", "r", 10}
    local n,p,k1,compare1,compare2,k2 =self:extractTxt()
    self.operation=""
    if (tostring(n)=="nil") or tostring(n)=="" then
      return
    end
    
    if (tostring(p)=="nil") or tostring(p)=="" then
      return
    end

    local ex = self:performEx(n,p)
    local vx = self:performVx(n,p)
    self.operation=tostring(ex).."\n"..tostring(vx)
    
    if (tostring(k1)=="nil") then
      return tostring(ex).."\n"..tostring(vx)
    end

    if (tostring(k2)=="nil") or tostring(k2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end



    if (tostring(compare1)=="nil") or tostring(compare1)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    if (tostring(compare2)=="nil") or tostring(compare2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    self.operation=self:performBNP(n,p,k1,compare1,compare2,k2).."\n"..tostring(ex).."\n"..tostring(vx)
    self:invalidate()
end

