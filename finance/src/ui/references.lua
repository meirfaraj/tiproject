
--------------------------------------------------------------------------
--                            references dialog                         --
--------------------------------------------------------------------------
require("ui/math/ippref")
require("ui/genref/greekref")
require("ui/genref/utf8ref")
require("ui/math/combinatoire/combinatoire")

function printTitle(gc,idTxt,originalFont)
   gc:setColorRGB(0,0,0)
   gc:setFont("sansserif","b",10)
   drawXCenteredString(gc,ASTxt(idTxt),2)
   gc:setFont(Greek.font,"r",8) 
   return 22
end

Ref	= WScreen()

RefList	= sList()
RefList:setSize(-8, -32)

Ref:appendWidget(RefList, 4, Ref.y+28)

function Ref.addRefs()
	for n, ref in ipairs(References) do
		if ref.screen then
			table.insert(RefList.items, ref.title)
		else
			table.insert(RefList.items, ref.title .. " (not yet done)")  -- TODO !
		end
	end
end

function RefList:action(ref)
	if References[ref].screen then
		push_screen(References[ref].screen)
	end
end

function Ref:pushed()
	RefList:giveFocus()
end

function Ref:paint(gc)
    gc:setFont("serif", "b", 16)
    gc:drawString("Reference", self.x+6, -2, "top")
    gc:setFont("serif", "r", 12)
end

function Ref:tabKey()
    push_screen(CategorySel)
end

Ref.escapeKey = Ref.tabKey

Ref.addRefs()
