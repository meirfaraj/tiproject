
function instanceOf (subject, super)
 
  super = tostring(super)
  local mt = getmetatable(subject)
 
  while true do
    if mt == nil then return false end
    if tostring(mt) == super then return true end
 
    mt = getmetatable(mt)
  end 
end

function isSameType (subject, super)
  local mt = getmetatable(super)
  local mt2 = getmetatable(subject)
  return tostring(mt)==tostring(mt2)
end

-- Apply an extension on a class, and return our new frankenstein 
function addExtension(oldclass, extension)
  local newclass  = class(oldclass)
  for key, data in pairs(extension) do
    newclass[key] = data
  end
  return newclass
end

function Pr(n, d, s, ex)
  local nc  = tonumber(n)
  if ex and nc and nc<math.abs(nc) then
    return s-ex-(type(n)== "number" and math.abs(n) or (.01*s*math.abs(nc)))
  else
    return (type(n)=="number" and n or (type(n)=="string" and .01*s*nc or d))
  end
end

