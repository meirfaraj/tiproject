--------------------------------------------------------------------------
--                            loi normal                                --
--------------------------------------------------------------------------
TestNormaliteWilcoxon = EchantillonTst(LOI_NORMAL_1VAR_TITLE_ID,LOI_NORMAL_1VAR_HEADER_ID,ENTER_MU_ID,ENTER_SIGMA_ID)

-- 1 - enter the sample
-- 2 - n= size(sample)
-- 3 - etendues (biger - smaller) +remove till to more 
-- 4 - read each ai from table
-- 5 - calculate b^2= sum(ai*(etendue i))^2  = numerateur de W
-- 6 - calculate sum(xi-xbar)^2
-- 7 - calc 5/6 read for alpha on table less accepted greater refused (less is RC 6 must >= thant 7)

function TestNormaliteWilcoxon:perform()
    print("TestNormaliteWilcoxon:perform")
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