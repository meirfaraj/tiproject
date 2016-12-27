 
--------------------------------------------------------------------------
--                            references UTF8Ref                          --
--------------------------------------------------------------------------
require("datastructures/stack")


UTF8Ref = Screen()
 
UTF8Ref.font = "serif"

UTF8Ref.previousHist = Stack()
UTF8Ref.previousHist:init()
UTF8Ref.curStart = 0
UTF8Ref.nextStart = 125
UTF8Ref.max = 0x10006B

utf8Ranges = {}
utf8RangesCnt=0
function addRange(id,minSkp,maxSkp)
    utf8RangesCnt= utf8RangesCnt+1
    return table.insert(utf8Ranges, id, {id=id, minSkp=minSkp, maxSkp=maxSkp})
end


addRange(1,0,31)
addRange(2,127,159)
addRange(3,384,461)
addRange(4,463,463)
addRange(5,467,467)
addRange(6,469,469)
addRange(7,471,471)
addRange(8,473,473)
addRange(9,475,475)     
addRange(10,477,503)
addRange(11,512,591)
addRange(12,594,595)
addRange(13,597,600)
addRange(14,602,602)
addRange(15,604,608)
addRange(16,610,617)
addRange(17,619,628)
addRange(18,630,642)
addRange(19,644,649)
addRange(20,651,651)
addRange(21,653,657)
addRange(22,659,711)
addRange(23,713,715)
addRange(24,717,912)
addRange(25,930,930)
addRange(26,938,944)
addRange(27,962,962)
addRange(28,970,8200)
addRange(29,8202,8210)
addRange(30,8213,8215)
addRange(31,8219,8219)
addRange(32,8223,8225)
addRange(33,8228,8229)
addRange(34,8231,8239)
addRange(35,8241,8248)
addRange(36,8252,8303)
addRange(37,8306,8307)
addRange(38,8316,8316)
addRange(39,8332,8332)
addRange(40,8335,8363)
addRange(41,8365,8449)
addRange(42,8452,8456)
addRange(43,8458,8468)
addRange(44,8470,8472)
addRange(45,8475,8476)
addRange(46,8478,8481)
addRange(47,8483,8483)
addRange(48,8487,8591)
addRange(49,8598,8613)
addRange(50,8615,8628)
addRange(51,8630,8655)
addRange(52,8657,8657)
addRange(53,8659,8659)
addRange(54,8661,8676)
addRange(55,8678,8678)
addRange(56,8680,8703)
addRange(57,8705,8705)
addRange(58,8720,8720)
addRange(59,8724,8727)
addRange(60,8731,8732)
addRange(61,8738,8738)
addRange(62,8748,8755)
addRange(63,8758,8758)
addRange(64,8760,8763)
addRange(65,8766,8770)
addRange(66,8772,8772)
addRange(67,8774,8775)
addRange(68,8777,8779)
addRange(69,8781,8798)
addRange(70,8803,8803)
addRange(71,8806,8833)
addRange(72,8835,8837)
addRange(73,8839,8856)
addRange(74,8858,8868)
addRange(75,8870,8894)
addRange(76,8896,8983)
addRange(77,8985,9321)
addRange(78,9328,9423)
addRange(79,9429,9631)

function isInSkipped(i,from)
    if utf8Ranges[from].minSkp>i then 
      from=1 -- strange
    end
    print("isInSkipped:"..tostring(from)..";utf8RangesCnt="..utf8RangesCnt..";i="..tostring(i))
    local nextFrom=from
    local nextRes=i
    
    for j=from,utf8RangesCnt do
        --print("j:"..tostring(j).." checking "..tostring(i).." against ["..tostring(utf8Ranges[j].minSkp)..","..tostring(utf8Ranges[j].maxSkp).."]")
        if utf8Ranges[j].minSkp <= i and utf8Ranges[j].maxSkp >= i then
            print(tostring(i).." is in skipped range between "..tostring(utf8Ranges[j].minSkp).." and "..tostring(utf8Ranges[j].maxSkp))
            nextRes=utf8Ranges[j].maxSkp+1
            return true,nextRes,nextFrom
        end
        --print("smaller than cur arr?")
        
		if utf8Ranges[j].minSkp > i then
		  nextFrom=j  
		  print(tostring(i).." is not in skipped range.j="..tostring(j))
          return false,i,nextFrom
		end
        --print("nextFrom"..tostring(j))
		nextFrom=j
    end
	--print(tostring(i).." is not in skipped range.")
    return false,i,nextFrom
end


function utf8ToStringBasic(i,from)
   local inSkiped=false
   local nextNotskiped=i
   local nextFrom=from
   --print(isInSkipped(i,from))
   inSkiped,nextNotskiped,nextFrom=isInSkipped(i,from)
   local j=nextNotskiped
   local dsp =tostring(j) .. "-U" .. string.tohex(j) .. ":'" .. utf8(j) .."'  | "
   return j,dsp,nextFrom
end

function utf8ToStringRef(i,from)
   local txt=""
   local tmp=""
   local nextFrom=from
   local j=i
   --print(utf8ToStringBasic(j,nextFrom))
   j,txt,nextFrom=utf8ToStringBasic(j,nextFrom)
   j,tmp,nextFrom=utf8ToStringBasic(j+1,nextFrom)
   txt=txt..tmp
   j,tmp,nextFrom=utf8ToStringBasic(j+1,nextFrom)
   txt=txt..tmp
   j,tmp,nextFrom=utf8ToStringBasic(j+1,nextFrom)
   txt=txt..tmp   
   return j,txt,nextFrom
end
 
function UTF8Ref:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	printTitle(gc,UTF8_TITLE_ID,UTF8Ref.font)
    gc:setFont("sansserif","b",6)
	local count = 0
	local from = 1
	local i=self.curStart
    local j=0
    local curtxt=""
	while i<self.max and count<16 do
    	count=count+1
    	--print(tostring(count))
    	--print(utf8ToStringRef(i,from))
	    j,curtxt,from  = utf8ToStringRef(i,from)
		gc:drawString(curtxt, 5, 8+12*count, "top")
		i=j+1    
	end
	self.nextStart=i
end
 
function UTF8Ref:enterKey()
   self:setNewStart(self.nextStart)
end

function UTF8Ref:previous()
    self.curStart=self.previousHist:pop()
    UTF8Ref:invalidate()
end
function UTF8Ref:setNewStart(start)
    if self.nextStart~=self.curStart then
       self.previousHist:push(self.curStart)
	end
	self.curStart=start
    UTF8Ref:invalidate()
end

function UTF8Ref:arrowKey(arrow)
    --print(arrow)
    if arrow=="right" then
       self:enterKey()
    elseif arrow=="left" then  
	   self:previous()
	end
    UTF8Ref:invalidate()
end

function UTF8Ref:escapeKey()
	only_screen_back(Ref)
end


