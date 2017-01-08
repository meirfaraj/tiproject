require("math/math")

FonctionUtilitef={}

function FonctionUtilitef.gainAttendu(self,w0,gp)
   local gpv={}
   local count=1
   for p,v in string.gmatch(line, "([^,])+,([^,])+;*") do
      print(tostring(p).." v="..tostring(v))
      gpv[count]={p,v}
      count=count+1
   end
end