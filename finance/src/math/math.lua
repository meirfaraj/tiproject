
------------------------------------------------------------------
--                        Maths                                 --
------------------------------------------------------------------

require("math/tifunc/tia")

function math.solve(formula, tosolve)
    --local eq="max(exp" .. string.uchar(9654) .. "list(solve(" .. formula .. ", " .. tosolve ..")," .. tosolve .."))"
    local eq = "nsolve(" .. formula .. ", " .. tosolve .. ")"
    local evalStr,err = math.evalStr(eq)
	local res = evalStr:gsub(utf8(8722), "-")
    return tonumber(res)
end

function round(num, idp)
    if num >= 0.001 or num <= -0.001 then
        local mult = 10 ^ (idp or 0)
        if num >= 0 then
            return math.floor(num * mult + 0.5) / mult
        else
            return math.ceil(num * mult - 0.5) / mult
        end
    else
        return tonumber(string.format("%.0" .. (idp + 1) .. "g", num))
    end
end

math.round = round -- just in case

basicFuncsInited = false
function initBasicFunctions()
    if basicFuncsInited==false then
		local basicFunctions = {
			["hasmult"] = [[Define hasmult(x)=Func:Return not(0=inString(string(x),"*") or not (part(x,0)="*") or not (part(factor(x),0)="*")):EndFunc]],
			["isPoly"] = [[Define isPoly(x,var)=Func:Return string(polyCoeffs(x,var)):EndFunc]],
		}
		for var, func in pairs(basicFunctions) do
		    print("defining func "..var.." has : "..func)
			math.eval(func .. ":Lock " .. var) -- defines and prevents against delvar.
		end
		math.setEvalSettings({{'Calculation Mode','Exact'}})
        local settings = math.getEvalSettings()
		local i=1
		while settings[i] and settings[i][1] and settings[i][2] do
		   print(settings[i][1].."="..settings[i][2])
		   i=i+1
		end
		basicFuncsInited=true
	end
end

function test(arg)
	return arg and 1 or 0
end

function hasMult(expression)
    local res,err = math.evalStr("hasmult("..expression..")")
	return res=="true"
end

function partCount(expression)
    if expression then       
       local res,err = math.evalStr("part("..expression..")")
	   if res then
    	 print("partcount="..res)
	     return tonumber(res)
	   end
	   print("Error : "..err)
	else
	   print("partcount failure")
	end
	return 0
end

function partOp(expression)
    if expression then
       local res,err = math.evalStr("part("..expression..",0)")
	   if res then
	     res = string.simplify(res)
	     print("partOp : "..res)
	     return res
	   end
	   print("Error : "..err)
	else
	   print("partOp failure")
	end
	return 0
end


function part(expression,n)
    if expression then
	   local res,err = math.evalStr("part("..expression..","..tostring(n)..")")
	   if res then 
	      print("part("..expression..","..tostring(n)..")="..res)
          return res 
	   end
	   print("part("..expression..","..tostring(n)..") Failed")
	else
	   print("part failure")
	end
	return 0
end

function isPoly(expression,var)
   if expression and var then
       local result,err = math.evalStr("isPoly("..expression..","..var..")")
	   print(result)
	   if result then
         return true
	   end
	   return false
	else
	   print("isPoly failure")
	end
	return false
end

Integration = {}
--for op ++
function Integration:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end


function Integration:setFunction (expression)
    self.expression = expression
	self.isBounded  = false
end


function isDependOnVar(expression,var)
    if expression and var then
        local toEval = derive_sym.."("..expression..","..var..")";
		local result,err = math.evalStr(toEval)
		if result then
			print("result="..result)
			if result=="0" or result=="0."  then
               print("isDependOnVar : return false")
			   return false
			end
		else
		   print("error occured : derive "..expression.." with var"..var)
		end
	else
	    print("isDependOnVar : Expression and var must be not null")
	end
    print("isDependOnVar : return true")
	return true
end

function isOfTypeAx(expression,var)
    if expression and var then
        local derivSecond,err = math.evalStr(derive_sym.."("..expression..","..var..",2)")
    	if isDependOnVar(expression,var) and (derivSecond=="0" or derivSecond=="0.") then
           print("isOfTypeAx : return true")
		   return true
		end
	else
	    print("isOfTypeAx : Expression and var must be not null")
	end
    print("isOfTypeAx : return false")
	return false
end

function isDivElem(expression,var,opCount,op,ops)
   local elemDtl=""
   for i=1, opCount do
     if ops[i] then 
       print("isDivElem:ops["..tostring(i).."]"..ops[i])
     else
       print("isDivElem:ops["..tostring(i).."] is nill for "..expression)
     end
   end
   
   if not isDependOnVar(expression,var) then
       elemDtl = "f("..var..")=a => F("..var..")=a"..var
	   return true,elemDtl
   end
   
   if isPoly(expression,var) then
	   elemDtl = ASTxt(SINCE_ID)..expression..ASTxt(POLY_NOTHING_TO_DEM_ID)
	   return true,elemDtl
   end
   if op == "/" then
	 print("op is div")
     -- check if the first part is a constant parts 
	 if not isDependOnVar(ops[1],var) then
	    print(ops[1].."does not depends on "..var)
	    -- is a k * x type
		if isOfTypeAx(ops[2],var) then
    	   print(ops[2].." is of type a*"..var)
		   elemDtl = "f("..var..")=\\0el {a*(1/"..var..")} "..then_sym.." F("..var..")=\\0el {a*ln(abs("..var.."))} "..for_all.." "..var..element_of.."]0;+∞[ "..ASTxt(OR_ID).." ]−∞;0["
		   return true,elemDtl
		end
    	print(ops[2].." is not of type a*"..var)
	 end
   end
   return false,""
end

function expand(expression,var)
    if expression and var then
        local expanded,err = math.evalStr("expand("..expression..","..var..")")
    	if expanded then
		   expanded = string.simplify(expanded)
           print("expand : "..expanded)
		   return expanded
		end
	elseif expression then
	    print("expand : Strange var null")
        local expanded,err = math.evalStr("expand("..expression..")")
    	if expanded then
		   expanded = string.simplify(expanded)
           print("expand : "..expanded)
		   return expanded
		end
	else
	    print("expand : Expression and var must be not null")
	end
    print("expand : return initial value")
	return expression
end

--cautious made for only use with exponential expended function
-- probably bugged
function ePart(expression)
   print("ePart:"..expression)
   local index=string.find(expression, '\\^' , 1, true)
   local result = UTF8.replaceAll(expression, '^', ',')
   print("search return "..result.." index="..tostring(index))
  -- while
end

function integr(expression,var,borderUp,borderDown,ctx)
   local isBounded =false
   local boundTxt=""
   if borderUp and borderDown then
     isBounded = true
	 boundTxt = ","..borderUp..","..borderDown
   end
   local evaluated,err
   evaluated,err = math.evalStr("∫("..expression..","..var..boundTxt..")")
   
   local calcResult = ctx..ASTxt(SOLVE_ID).."\\0el {".."∫("..expression..","..var..boundTxt..")}=\\0el {"..evaluated.."}\n"
   calcResult = calcResult..ASTxt(DEMONSTRATION_ID).." : \n"

    local opCount    = partCount(expression)
	local op         = partOp(expression)
	local ops        = {}
	local isElem     = false
	local elemDtl    = ""
	local sep        = ""
	if ctx and ctx:len()>1 then 
		sep="."
	end
	print("op="..op..";opCount="..tostring(partCount))
	for i=1, opCount do
      ops[i] = part(expression,i)
	  if ops[i] then 
	    print("integr:ops["..tostring(i).."]"..ops[i])
	  else
		print("integr:ops["..tostring(i).."] is nill for "..expression)
	  end
    end
	
	isElem,elemDtl = isDivElem(expression,var,opCount,op,ops)
    print("isDivElem return "..tostring(isElem)..","..elemDtl)
	if isElem then
	   calcResult=calcResult..ASTxt(ELEMENTARY_PRIMITIVE_ID).."\n"..elemDtl
	   return calcResult
	end
    
	
    if op == "+" or op == "-" then 
	    calcResult = calcResult..ASTxt(OPERATION_PLMN_INTEG_EXP_ID)
		for i=1, opCount do
          calcResult=calcResult..integr(ops[i],var,borderUp,borderDown,ctx..sep..tostring(i)).."\n"
        end
	elseif op == "/" and opCount==2 and not isDependOnVar(ops[2],var) then
        calcResult=calcResult..ASTxt(INTEGR_CAN_BE_REWRITE_AS_ID).."\\0el {(1/("..ops[2].."))*∫("..ops[1]..","..var..boundTxt..")}\n"

		calcResult=calcResult..integr(ops[1],var,borderUp,borderDown,ctx..sep.."1")
	elseif op == "*" then
	    print("operation is * extracting parts than are '"..var.."' independent")		
		local outOpCount = 0
		local outOp = {}
		local opForIppCount = 0
		local opForIpp = {}
	    i=1
		while i<=opCount do
		  print("ops["..tostring(i).."]="..ops[i])
          if not isDependOnVar(ops[i],var) then
		     print("parts is independent")
			 outOpCount = outOpCount + 1
		     outOp[outOpCount] = ops[i]
		  elseif partOp(ops[i]) == "*" then
			 local subCount = partCount(ops[i])
    		 print("parts is dependent but is a sub * extracting sub parts count="..tostring(subCount))
			 for j=1, subCount do
			   ops[opCount+j] = part(ops[i],j)
			   if ops[opCount+j] then 
				 print("integr:ops["..tostring(opCount+j).."]"..ops[opCount+j])
			   else
				 print("integr:ops["..tostring(opCount+j).."] is nill for "..expression)
			   end
   			 end
			 opCount = opCount + subCount
		  elseif  partOp(ops[i]) == "^" then
		     print("exponential symbol found. in:"..ops[i])
			 local expanded = expand(ops[i],var)
             print("expanded = "..expanded)
			 ---local partsMut=part(expanded)
			 calcResult=calcResult.."expanded = \\0el {"..expanded.."}\n"
			 calcResult=calcResult.."since part function refactorise it it will be a small manual part.\n"
			 ePart(expanded)
			 --???
			 if partOp(expanded) == "*" then -- successfully simplified
				local subCount = partCount(expanded)
        		print("parts is dependent but after simplification is divided in sub * extracting sub parts count="..tostring(subCount))
				for j=1, subCount do
				   ops[opCount+j] = part(expanded,j)
				   if ops[opCount+j] then 
					 print("integr:ops["..tostring(opCount+j).."]"..ops[opCount+j])
				   else
					 print("integr:ops["..tostring(opCount+j).."] is nill for "..expression)
				   end
				end
				calcResult=calcResult.."\\0el {"..ops[i].."="..expanded.."}\n"
				opCount = opCount + subCount			
             elseif partOp(expanded) == "/" then -- successfully simplified
				local subCount = partCount(expanded)
        		if subCount == 2 then
					print("parts is dependent but after simplification is divided in sub * extracting sub parts count="..tostring(subCount))
					ops[opCount+j] = part(expanded,j)
					if ops[opCount+j] then 
					  print("integr:ops["..tostring(opCount+j).."]"..ops[opCount+j])
					else
				 	  print("integr:ops["..tostring(opCount+j).."] is nill for "..expression)
					end
					calcResult=calcResult.."\\0el {"..ops[i].."="..expanded.."}\n"
					opCount = opCount + subCount			
				else
				   print("strange parts count for div = "..tostring(subCount))
	    	      opForIppCount = opForIppCount + 1
    		      opForIpp[opForIppCount]=ops[i]    
				end
			 else
    	       opForIppCount = opForIppCount + 1
    		   opForIpp[opForIppCount]=ops[i]   
			 end         			 			 
	  	  else
		   opForIppCount = opForIppCount + 1
		   opForIpp[opForIppCount]=ops[i]
		  end
		  i=i+1
		end
		local ippStr = ""
		local outStr = ""
		if opForIppCount>0 then
		    for j=1, opForIppCount do
			   if ippStr=="" then
			     ippStr = "("..opForIpp[j]..")"
			   else
			     ippStr = ippStr.."*("..opForIpp[j]..")"
			   end
			end
		end
		if outOpCount >0 then
		    for j=1, outOpCount do
			   if outStr=="" then
			     outStr = "("..outOp[j]..")"
			   else
			     outStr = outStr.."*("..outOp[j]..")"
			   end
			end
		   calcResult=calcResult..ASTxt(INTEGR_CAN_BE_REWRITE_AS_ID).."\\0el {("..outStr..")*∫("..ippStr..","..var..boundTxt..")}"
		   calcResult=calcResult..integr(ippStr,var,borderUp,borderDown,ctx..sep.."1")
		else 
		    --use ipp now since no simplification has been done successfully
		    calcResult=calcResult.." We should use now IPP to resolve \\0el {∫("..ippStr..","..var..boundTxt..")} with :\n"
		    for j=1, opForIppCount do
			   calcResult=calcResult..opForIpp[j].."\n"
			end
		end
		
	elseif op == "/" then
		calcResult=calcResult.."inworks\n"
    end
    return calcResult
end

function Integration:integrBy(var,borderUp,borderDown)
   self.var = var
   self.borderUp = borderUp
   self.borderDown =borderDown
   local result = ""
   return integr(self.expression,self.var,self.borderUp,self.borderDown,"")
end

function analysis(expression,var)
   print(partOp(expression))
   print(part(expression,1))
   local op = partOp(expression)
   local count = partCount(expression);
   if count>1 then 
   return tostring(partCount(expression))..","..op..","..tostring(part(expression,1))
   end
   return tostring(partCount(expression))..tostring(op)
end



--#include<integrals>
