stdout  = print

function pprint(...)
  stdout(...)
  local out = ""
  for _,v in ipairs({...}) do 
    out = out .. (_==1 and "" or "    ") .. tostring(v)
  end
  var.store("print", out)
end
