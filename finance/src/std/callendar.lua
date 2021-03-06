--
require("std/str")

cal={}
--MM.JJAA (format communément utilisé aux EtatsUnis)
--JJMM.AA (format communément utilisé en Europe)
function cal.parse(date)
   local mmjjaa="(%d%d)\\.(%d%d)(%d%d)"
   local jjmmaa="(%d%d)(%d%d)\\.(%d%d)"
   if string.find(date,mmjjaa)~=nil then
      return string.gsub(date, mmjjaa, function(m,j,a) return {tiNspire.toNumber(j),tiNspire.toNumber(m),tiNspire.toNumber(a)} end ) 
   elseif string.find(date,jjmmaa)~=nil then 
      return string.gsub(date, jjmmaa, function(j,m,a) return {tiNspire.toNumber(j),tiNspire.toNumber(m),tiNspire.toNumber(a)} end ) 
   end
   return {}
end

function cal.nbmois(date1,date2)
   local d1=cal.parse(date1) 
   local d2=cal.parse(date2)     
   local numMois = (d2[3]-d1[3])*12 + (d2[2]-d1[2])
   local numMoisStr = "Nombre  de mois entre "..date1.." et "..date2.."=("..tostring(d2[3]).."-"..tostring(d1[3])..")*12+("..tostring(d2[2]).."-"..tostring(d1[2])..")="..tostring(numMois)
   return numMois,numMoisStr,d1,d2
end

function cal.nbjours30(date1,date2)
   local numMois,numMoisStr,d1,d2 = cal.nbmois(date1,date2)
   local numjour=numMois+(d2[1]-d1[1])
   local numjourStr=numMoisStr.."\n donc nombre de jours en convention 30 : "..tostring(numMois).."+("..tostring(d2[1]).."-"..tostring(d1[1])..")="..tostring(numjour)
   return numjour,numjourStr
end
