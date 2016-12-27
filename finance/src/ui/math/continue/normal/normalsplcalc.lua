--------------------------------------------------------------------------
--                            loi normal                                --
--------------------------------------------------------------------------
require("math/tables/normal/table1")
require("math/tables/normal/table2")
LoiNormalSplCalc = Spl2Params(LOI_NORMAL_1VAR_TITLE_ID,LOI_NORMAL_1VAR_HEADER_ID,ENTER_MU_ID,ENTER_SIGMA_ID)


function LoiNormalSplCalc:performEx(mu,sigma)
   return "\\0el {E(X)="..c_mu.."="..tostring(mu).."}"
end

function LoiNormalSplCalc:performVx(mu,sigma)
   local calc = "("..tostring(sigma)..")^2"
   local res = "\\0el {V(X)="..c_sigma.."^2="..tostring(calc).."}="
   local result,err = math.evalStr(tostring(calc))
   local resulta,erra = math.evalStr("approx("..tostring(calc)..")")
   res=res.."\\0el {"..tostring(result).."="..tostring(resulta).."}\n"
   if err then
        res = res.."ERROR:"..tostring(err).."\n"
   end        
   if erra then
        res = res.."ERROR:"..tostring(erra).."\n"
   end  
   return res
end

function LoiNormalSplCalc:performCentrageReduction(mu,sigma,x1,compare1,compare2,x2)
   local res = "\\0el {Z=(X-"..c_mu..")/"..c_sigma.."}\n"
   local cx1=x1
   local cx2=x2
   local fcompare1 = compare1
   local fcompare2 = compare2
   if (tonumber(sigma)~=nil) and (tonumber(sigma)<0) then
          if (compare1=="<" or compare1=="<=") then
             fcompare1 = ">"
          elseif (compare1==">" or compare1==">=") then
             fcompare1 = "<"
          end
   
          if (compare2=="<" or compare2=="<=") then
             fcompare2 = ">"
          elseif (compare2==">" or compare2==">=") then
             fcompare2 = "<"
          end
   end 
   if (compare1~=nil and compare1~="" and compare1~="none") then
       res = res.."\\0el {P("..tostring(x1)..tostring(compare1).."X"..tostring(compare2)..tostring(x2)..")}"
       local calc = "(("..tostring(x2)..")-("..tostring(mu).."))/("..tostring(sigma)..")"
       cx2,err =math.evalStr(tostring(calc))
       if err then
        res = res.."ERROR:"..tostring(err).."\n"
       end
       calc = "(("..tostring(x1)..")-("..tostring(mu).."))/("..tostring(sigma)..")"
       cx1,err =math.evalStr(tostring(calc))
       if err then
        res = res.."ERROR:"..tostring(err).."\n"
       end
       res = res.."=\\0el {P("..tostring(cx1)..tostring(fcompare1).."Z"..tostring(fcompare2)..tostring(cx2)..")}"
   else
       res = res.."=\\0el {P(X"..tostring(compare2)..tostring(x2)..")}"
       local calc = "(("..tostring(x2)..")-("..tostring(mu).."))/("..tostring(sigma)..")"
       cx2,err =math.evalStr(tostring(calc))
       if err then
        res = res.."ERROR:"..tostring(err).."\n"
       end       
       res = res.."=\\0el {P(Z"..tostring(fcompare2)..tostring(cx2)..")}"
   end
   return res,cx1,fcompare1,fcompare2,cx2
end

function LoiNormalSplCalc:performSmaller(mu,sigma,x)
   local calc="normCdf(−"..infinit_sym..","..tostring(x)..","..tostring(mu)..","..tostring(sigma)..")"
   local result,err=math.evalStr(tostring(calc))
   local resulta,erra = math.evalStr("approx("..tostring(calc)..")")
   local res="=\\0el {"..tostring(result).."="..tostring(resulta).."}\n"
   if err then
        res = res.."ERROR:"..tostring(err).."\n"
   end        
   if erra then
        res = res.."ERROR:"..tostring(erra).."\n"
   end  
   return res
end

function LoiNormalSplCalc:resolveUsingTiFunc(x1,fcompare1,fcompare2,x2,mu,sigma)
   res = "NormCdf("
   if (fcompare1=="none" or string.isempty(x1)) then
      res=res.."-"..infinit_sym..","
   else
      res=res..tostring(x1)..","
   end
   if (fcompare2=="none" or string.isempty(x2)) then
      res=res..infinit_sym..","
   elseif (fcompare2=="<") then
      res= res..tostring(x2)..","
   elseif (fcompare2==">") then
      res= res..tostring(x2)..","
   else
      res= "1-"..res..fcompare2;
   end
   res = res..mu..","..sigma..")"
   local calca,errcalc=math.evalStr(res)
   if errcalc then
        res = res.."ERROR:"..tostring(errcalc).."\n"
   end
   local calcb,errcalc=math.evalStr("approx("..res..")")         
   if errcalc then
        res = res.."ERROR:"..tostring(errcalc).."\n"
   end
   res = res .. "=\\0el {"..tostring(calca).."}=\\0el {"..tostring(calcb).."}\n"
   return res
end

function LoiNormalSplCalc:performNormal(mu,sigma,x1,compare1,compare2,x2)
   if (string.isempty(compare2) or compare2=="none" or compare2=="=") then
       return "\\0el {P(X"..tostring(compare2)..tostring(x2)..")=0}="
   end
   
   local res = self:getEqualityAsTxt(x1,compare1,compare2,x2)
   local fcompare1=self:removeEquals(compare1)
   local fcompare2=self:removeEquals(compare2)
   if (fcompare1~=compare1) or (fcompare2~=compare2) then
      res = res..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."="
   end
   -- first calc it simply by using interna function
   res = res..self:resolveUsingTiFunc(x1,fcompare1,fcompare2,x2,mu,sigma);
   
   if (compare=="All") then
       return ASTxt(NOT_SUPPORTED_ID)
   end
   
   local toadd,cx1,fcompare1,fcompare2,cx2 =self:performCentrageReduction(mu,sigma,x1,fcompare1,fcompare2,x2)
   if (fcompare1=="none") and (fcompare2==">") then
      fcompare2="<"
      local sres,sresval=self:performSmaller(mu,sigma,x2)
      local calc,errcalc=math.evalStr("1-"..tostring(sresval))   
      local calca,errcalc=math.evalStr("approx(1-"..tostring(sresval)..")")         
   if errcalc then
        res = res.."ERROR:"..tostring(errcalc).."\n"
   end  
      res = res.."=\\0el {1-"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}=\\0el {"..calc.."}=\\0el {"..calca.."}="
      res = res.."\n \\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}="      
      res = res..sres
      res = res..tostring(toadd)
      res = res.."\n \\0el {P(Z"..tostring(compare2)..tostring(cx2)..")=0}="
      print("cx2="..tostring(cx2))
      cx2=tiNspire.execute("approx("..tostring(cx2)..")")
      print("cx2="..tostring(cx2))
      res = res.."\\0el {P(Z"..tostring(compare2)..tostring(cx2)..")=0}="
      
      local cres,cresval=self:performSmaller(0,1,cx2)
      res = res..cres
      res=res.."\n"..tostring(toadd)
      res=res.."\n Resolution with table P(Z<"..tostring(cx2)..")="..tostring(normal.table1.resolveFu(cx2))
      
   elseif (fcompare1=="none") and (fcompare2=="<") then
      res = res.."=\\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}="
      local sres,sresval=self:performSmaller(mu,sigma,x2)
      local calc,errcalc=math.evalStr(tostring(sresval))   
      local calca,errcalc=math.evalStr("approx("..tostring(sresval)..")")         
      if errcalc then
          res = res.."ERROR:"..tostring(errcalc).."\n"
      end
      res = res..tostring(toadd)
      res = res..self:performSmaller(0,1,cx2)
      res = res.."=\\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}=\\0el {"..calc.."}=\\0el {"..calca.."}="
      res = res.."\n \\0el {"..self:getEqualityAsTxt(x1,fcompare1,fcompare2,x2).."}="      
      print("cx2="..tostring(cx2))
      cx2=tiNspire.execute("approx("..tostring(cx2)..")")
      print("cx2="..tostring(cx2))
      res = res.."\\0el {P(Z"..tostring(compare2)..tostring(cx2)..")=0}="
      
      local cres,cresval=self:performSmaller(0,1,cx2)
      res = res..cres
      res=res.."\n"..tostring(toadd)
      res=res.."\n Resolution with table P(Z<"..tostring(cx2)..")="..tostring(normal.table1.resolveFu(cx2))
       
   else 
       return ASTxt(NOT_SUPPORTED_ID)
   end   
   return res
end

function LoiNormalSplCalc:perform()
    print("LoiNormalSplCalc:perform")
    self.font ={"sansserif", "r", 10}
    local mu,sigma,x1,compare1,compare2,x2 =self:extractTxt()
    self.operation=""
    if (tostring(mu)=="nil") or tostring(mu)=="" then
      return
    end
    
    if (tostring(sigma)=="nil") or tostring(sigma)=="" then
      return 
    end

    -- step 1 : calculate E(X) and V(X)
    local ex = self:performEx(mu,sigma)
    local vx = self:performVx(mu,sigma)
    
    -- step 2 : checks
    
    self.operation=tostring(ex).."\n"..tostring(vx)
    

    if (tostring(x2)=="nil") or tostring(x2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end



    if (tostring(compare1)=="nil") or tostring(compare1)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    if (tostring(compare2)=="nil") or tostring(compare2)=="" then
      return tostring(ex).."\n"..tostring(vx)
    end

    -- perform resolution
    self.operation=self:performNormal(mu,sigma,x1,compare1,compare2,x2).."\n"..tostring(ex).."\n"..tostring(vx)

    self:invalidate()
end