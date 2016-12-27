--------------------------------------------------------------------------
--                                  String utils                        --
--------------------------------------------------------------------------

function utf8(n)
	return string.uchar(n)
end

function Utf8to32(utf8str)
  assert(type(utf8str) == "string")
  local res, seq, val = {}, 0, nil
  for i = 1, #utf8str do
    local c = string.byte(utf8str, i)
    if seq == 0 then
      table.insert(res, val)
      seq = c < 0x80 and 1 or c < 0xE0 and 2 or c < 0xF0 and 3 or
            c < 0xF8 and 4 or c < 0xFC and 5 or c < 0xFE and 6 or
          error("invalid UTF-8 character sequence")
      val = bit.band(c, 2^(8-seq) - 1)
    else
      val = bit.bor(bit.lshift(val, 6), bit.band(c, 0x3F))
    end
    seq = seq - 1
  end
  table.insert(res, val)
  table.insert(res, 0)
  return res
end


SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}
function numberToSub(w,n)
	return w..utf8(SubNumbers[tonumber(n)])
end


function string.fromhex(str)
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end

function string.bintohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

function string.tohex(num)
    return string.format('%02X', num)
end

function string.simplify(str)
    local simplified = str
    if 	simplified:match ("\".*\"") then
	   simplified=simplified:sub(2,simplified:len()-1)
	   print("["..str.."] simplified has ["..simplified.."]")
	end
	return simplified
end




-- ABNF from RFC 3629
--
-- UTF8-octets = *( UTF8-char )
-- UTF8-char = UTF8-1 / UTF8-2 / UTF8-3 / UTF8-4
-- UTF8-1 = %x00-7F
-- UTF8-2 = %xC2-DF UTF8-tail
-- UTF8-3 = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
-- %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
-- UTF8-4 = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
-- %xF4 %x80-8F 2( UTF8-tail )
-- UTF8-tail = %x80-BF
--

-- returns the number of bytes used by the UTF-8 character at byte i in s
-- also doubles as a UTF-8 character validator

local UTF8 = {}

function UTF8.charbytes (s, i)
   -- argument defaults
   i = i or 1
   local c = string.byte(s, i)
   
   -- determine bytes needed for character, based on RFC 3629
   if c > 0 and c <= 127 then
      -- UTF8-1
      return 1
   elseif c >= 194 and c <= 223 then
      -- UTF8-2
      local c2 = string.byte(s, i + 1)
      return 2
   elseif c >= 224 and c <= 239 then
      -- UTF8-3
      local c2 = s:byte(i + 1)
      local c3 = s:byte(i + 2)
      return 3
   elseif c >= 240 and c <= 244 then
      -- UTF8-4
      local c2 = s:byte(i + 1)
      local c3 = s:byte(i + 2)
      local c4 = s:byte(i + 3)
      return 4
   end
end

-- returns the number of characters in a UTF-8 string
function UTF8.len (s)
   local pos = 1
   local bytes = string.len(s)
   local len = 0
   
   while pos <= bytes and len ~= chars do
      local c = string.byte(s,pos)
      len = len + 1
      
      pos = pos + UTF8.charbytes(s, pos)
   end
   
   if chars ~= nil then
      return pos - 1
   end
   
   return len
end


-- pretty printed square root characters from MathBoxes take two 'special' characters in returned expression string
-- cursor position in expression returned by getExpression() then does not match cursor position in string after the square root
function ulen(str)
    local n = string.len(str)
    local i = 1
    local j = 1
    local c
    while(j<=n) do
        c = string.len(string.usub(str,i,i))
        j = j+c
        i = i+1
    end
    return i-1
end


-- functions identically to string.sub except that i and j are UTF-8 characters
-- instead of bytes
function UTF8.sub (s, i, j)
   j = j or -1

   if i == nil then
      return ""
   end
   
   local pos = 1
   local bytes = string.len(s)
   local len = 0

   -- only set l if i or j is negative
   local l = (i >= 0 and j >= 0) or UTF8.len(s)
   local startChar = (i >= 0) and i or l + i + 1
   local endChar = (j >= 0) and j or l + j + 1

   -- can't have start before end!
   if startChar > endChar then
      return ""
   end
   
   -- byte offsets to pass to string.sub
   local startByte, endByte = 1, bytes
   
   while pos <= bytes do
      len = len + 1
      
      if len == startChar then
         startByte = pos
      end
      
      pos = pos + UTF8.charbytes(s, pos)
      
      if len == endChar then
         endByte = pos - 1
         break
      end
   end
   
   return string.sub(s, startByte, endByte)
end

function string.isempty(s)
  return s == nil or s == ''
end

-- replace UTF-8 characters based match
function UTF8.replaceAll (s, charToReplace,byChar)
   local pos = 1
   local bytes = string.len(s)
   local charbytes
   local newstr = ""

   while pos <= bytes do
      charbytes = UTF8.charbytes(s, pos)
      local c = string.sub(s, pos, pos + charbytes - 1)
      if charToReplace==c then
        newstr = newstr .. byChar 
      else
        newstr = newstr .. c
      end
      pos = pos + charbytes
   end

   return newstr
end

-- replace UTF-8 characters based on a mapping table
function UTF8.replace (s, mapping)
   local pos = 1
   local bytes = string.len(s)
   local charbytes
   local newstr = ""

   while pos <= bytes do
      charbytes = UTF8.charbytes(s, pos)
      local c = string.sub(s, pos, pos + charbytes - 1)
      newstr = newstr .. (mapping[c] or c)
      pos = pos + charbytes
   end

   return newstr
end




