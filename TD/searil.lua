function serializ_t(t,filename)
  if type(t) == "table" then
    local file = love.filesystem.newFile(filename..".sfabrikan")
    file:open('w')
    file:write("return {\n")
    for k,v in pairs(t) do
      if type(v) == "string" then
        v = string.format("%q",v)
      end
      if type(k) == "number" then
        file:write("\t["..k.."] = "..v..",\n")
      elseif type(k) == "string" then
        file:write("\t"..k.." = "..v..",\n")
      end
    end
    file:write("}")
    file:close()
  end
end

function load_serializ(filename)
  return love.filesystem.load(filename..".sfabrikan")()
end
