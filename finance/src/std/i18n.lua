localeName = locale.name()

LocaleId= {}

function checkIfLocaleExists(name)
    for k,v in pairs(LocaleId) do
        if (v.name == name) or (v == name) then
            return true
        end
    end
    return false
end

function addLocale(id,name,description)
    if checkIfLocaleExists(name) then
      -- No yet Locale so use static text
    if (localeName=="fr") then 
        print("Attention ! cette locale="..name.." existe déjà! Locale néanmoins ajoutée...")
    else
            print("Warning ! This locale="..name.." appears to already exist! Adding anyway...")
    end
    end
    return table.insert(LocaleId, id, {id=id, name=name, description=description})
end

function ASLocaleId(name)
    for k,v in pairs(LocaleId) do
        if (v.name == name) or (v == name) then
            return v.id
        end
    end
    return nil
end




TextLocale = {}

function checkIfTextIdExists(id,localeId)
    for k,v in pairs(TextLocale) do
        if (v.id == id) and (v.localeId == localeId) then
            return true
        end
    end
    return false
end


function getTextId(id,localeId)
    for k,v in pairs(TextLocale) do
        if (v.id == id) and (v.localeId == localeId) then
            return v
        end
    end
    return nil
end


--------------------------------------------------------------------------------
-- add text for local and text id
--
-- @function addTextLocale
-- @param #number id  the id of the text
-- @param #number localeId  the local id
-- @param #string text  the text to assign to the id on localId
-- @return #number Typed return description
-- @return #nil, #string Traditional nil and error message
function addTextLocale(id,localeId,text)
    if checkIfTextIdExists(id,localeId) then
   -- No yet Locale so use static text
    if (localeName=="fr") then 
        print("Attention ! cet id="..id.." de text existe déjà dans la locale="..localeId.."! Text néanmoins ajoutée...")
    else
            print("Warning ! This text id="..id.."appears to already exist in locale="..localeId.."! Adding anyway...")
    end
  end
    return table.insert(TextLocale, id+(1000*localeId), {id=id, name=name, localeId=localeId, text=text})
end


function ASText(id,localeId)
    local result = getTextId(id,localeId)
  if result ~= nil then
        return result.text
  end
  result = getTextId(id,EN)
  if result ~= nil then
        return result.text
    end
    local result = "???TEXT("..tostring(id)..","..tostring(localeId)..")" 
    print(result)
    return result
end



function ASTxt(id)
    return ASText(id,curLocaleId)
end
