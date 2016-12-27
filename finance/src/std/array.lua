array={}

function array.checkSortedArray(array)
   for i = 2, #array do
      if(names[i-1]>names[i]) then
         return false
      end
   end
   return true
end

function array.searchClosestIdx(array,val)
   local low = 0
   local high = #array
   local med =math.floor((high + low) / 2)
   local temp

   while (high ~= low+1) do
      temp = array[med]
      if (temp == val) then
          return med
      elseif (temp < val) then
          low = med
      else
          high = med
      end
         med = math.floor((high + low) / 2);
   end
   
   if  math.abs(val-array[high]) < math.abs(val-array[low]) then
      return high
   end
   return low
end

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end