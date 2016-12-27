--------------------------------------------------------------------------
--                                  Includes                            --
--------------------------------------------------------------------------
require("plateform")

require("finance/i18n")

require("std/str")
require("std/utils")
require("std/symbols")
require("ui/catutils")
require("ui/gcutils")
require("finance/categories")
require("ui/fullscreen")
require("math/math")
require("ui/screen")


------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc) 
    allWentWell, generalErrMsg = pcall(onpaint, gc)
    if not allWentWell and errorHandler then
        errorHandler.display = true
        errorHandler.errorMessage = generalErrMsg
    end
    if platform.hw and platform.hw() < 4 and not doNotDisplayIcon then 
      platform.withGC(on.draw)
    end
end

function onpaint(gc)
  for _, screen in pairs(Screens) do
    screen:draw(gc) 
  end
  if errorHandler.display then
      errorPopup(gc)
  end
end

function on.resize(w, h)
  -- Global Ratio Constants for On-Calc (shouldn't be used often though...)
  kXRatio = w/320
  kYRatio = h/212
  
  kXSize, kYSize = w, h
  
  for _,screen in pairs(Screens) do
    screen:resize(w,h)
  end
end

function on.arrowKey(arrw)  current_screen():arrowKey(arrw)  end
function on.enterKey()    current_screen():enterKey()    end
function on.escapeKey()   current_screen():escapeKey()   end
function on.tabKey()    current_screen():tabKey()    end
function on.backtabKey()  current_screen():backtabKey()  end
function on.charIn(ch)    current_screen():charIn(ch)    end
function on.backspaceKey()  current_screen():backspaceKey()  end
function on.contextMenu() current_screen():contextMenu()   end
function on.mouseDown(x,y)  current_screen():mouseDown(x,y)  end
function on.mouseUp(x,y)  if (x == 0 and y == 0) then current_screen():enterKey() else current_screen():mouseUp(x,y) end   end
function on.mouseMove(x,y)  current_screen():mouseMove(x,y)  end
function on.clearKey()      current_screen():clearKey()      end

function uCol(col)
  return col[1] or 0, col[2] or 0, col[3] or 0
end



require("ui/widgets/widgets")


function find_data(known, cid, sid)
    local done = {}

    for _, var in ipairs(var.list()) do
        math.eval("delvar " .. var)
    end

    for key, value in pairs(known) do
        var.store(key, value)
    end

    local no
    local dirty_exit = true
    local tosolve
    local couldnotsolve = {}

    local loops = 0
    while dirty_exit do
        loops = loops + 1
        if loops == 100 then error("too many loops!") end
        dirty_exit = false

        for i, formula in ipairs(Formulas) do

            local skip = false
            if couldnotsolve[formula] then
                skip = true
                for k, v in pairs(known) do
                    if not couldnotsolve[formula][k] then
                        skip = false
                        couldnotsolve[formula] = nil
                        break
                    end
                end
            end

            if ((not cid) or (cid and formula.category == cid)) and ((not sid) or (formula.category == cid and formula.sub == sid)) and not skip then
                no = 0

                for var in pairs(formula.variables) do
                    if not known[var] then
                        no = no + 1
                        tosolve = var
                        if no == 2 then break end
                    end
                end

                if no == 1 then
                    print("I can solve " .. tosolve .. " for " .. formula.formula)

                    local sol, r = math.solve(formula.formula, tosolve)
                    if sol then
                        sol = round(sol, 4)
                        known[tosolve] = sol
                        done[formula] = true
                        var.store(tosolve, sol)
                        couldnotsolve[formula] = nil
                        print(tosolve .. " = " .. sol)
                    else
                        print("Oops! Something went wrong:", r)
                        -- Need to issue a warning dialog
                        couldnotsolve[formula] = copyTable(known)
                    end
                    dirty_exit = true
                    break

                elseif no == 2 then
                    print("I cannot solve " .. formula.formula .. " because I don't know the value of multiple variables")
                end
            end
        end
    end

    return known
end


CategorySel = WScreen()
CategorySel.iconS = 48

CategorySel.sublist = sList()
CategorySel:appendWidget(CategorySel.sublist, 5, 5 + 24)
CategorySel.sublist:setSize(-10, -70)
CategorySel.sublist.cid = 0

function CategorySel.sublist:action(sid)
    push_screen(SubCatSel, sid)
end

function CategorySel:charIn(ch)
    if ch == "l" then
        self:pushed() -- refresh list
        self:invalidate() -- asks for screen repaint
    end
end

function CategorySel:paint(gc)
    initBasicFunctions()
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)

    if not kIsInSubCatScreen then
        gc:setColorRGB(0, 0, 0)
        gc:setFont("sansserif", "r", 16)
        gc:drawString(ASTxt(PROBABILITY_TITLE), self.x + 5, 0, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString("v"..version, self.x + .4 * self.w, 4, "top")

        gc:setFont("sansserif", "r", 12)
    
        gc:drawString(ASTxt(BY_ID), self.x + self.w - gc:getStringWidth(ASTxt(BY_ID)) - 5, 4, "top")

        gc:setColorRGB(220, 220, 220)
        gc:setFont("sansserif", "r", 8)
        gc:drawRect(5, self.h - 46 + 10, self.w - 10, 25 + 6)
        gc:setColorRGB(128, 128, 128)
    end

    local splinfo = Categories[self.sublist.sel].info:split("\n")
    for i, str in ipairs(splinfo) do
        gc:drawString(str, self.x + 7, self.h - 56 + 12 + i * 10, "top")
    end
    self.sublist:giveFocus()
end

function CategorySel:pushed()
    local items = {}
    for cid, cat in ipairs(Categories) do
        table.insert(items, cat.name)
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function CategorySel:tabKey()
    push_screen_back(Ref)
end



SubCatSel = WScreen()
SubCatSel.sel = 1

SubCatSel.sublist = sList()
SubCatSel:appendWidget(SubCatSel.sublist, 5, 5 + 24)
SubCatSel.back = sButton(utf8(9664) .. " Back")
SubCatSel:appendWidget(SubCatSel.back, 5, -5)
SubCatSel.sublist:setSize(-10, -66)
SubCatSel.sublist.cid = 0

function SubCatSel.back:action()
    SubCatSel:escapeKey()
end

function SubCatSel.sublist:action(sub)
    local cid = self.parent.cid
    if #Categories[cid].sub[sub].formulas > 0 then
        push_screen(manualSolver, cid, sub)
    elseif Categories[cid].sub[sub].screen then
       if Categories[cid].sub[sub].screen.setCSid then
          Categories[cid].sub[sub].screen:setCSid(cid,sub)
       end
       push_screen(Categories[cid].sub[sub].screen)
    end
end

function SubCatSel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)
    gc:setFont("sansserif", "r", 16)
    gc:drawString(Categories[self.cid].name, self.x + 5, 0, "top")
end

function SubCatSel:pushed(sel)

    kIsInSubCatScreen = true
    self.cid = sel
    local items = {}
    for sid, subcat in ipairs(Categories[sel].sub) do
        local isEmpty = ""
        if #subcat.formulas == 0 and not subcat.screen then
           isEmpty=ASTxt(EMPTY_ID)
        end
        table.insert(items, subcat.name .. isEmpty)
    end

    if self.sublist.cid ~= sel then
        self.sublist.cid = sel
        self.sublist:reset()
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function SubCatSel:escapeKey()
    kIsInSubCatScreen = false
    only_screen_back(CategorySel)
end


require("ui/math/manualsolver")

require("ui/math/usedformula")
require("ui/math/autoSolver")


require("ui/references")
----------------------------------------

require("ui/about")
require("ui/error")

---------------------------------------------------------------

require("ui/launch")


