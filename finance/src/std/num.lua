number={}
function number.tonumber(num)
   local ini = string.gsub(tostring(num), "−","-")
   --print(ini)
   return tonumber(ini)
end

function number.round(num, idp)
--print(num)
  local res = number.tonumber(num)
--print(res)
  return string.format("%." .. (idp or 0) .. "f",res )
end
-- print(number.round("−5.",2))
