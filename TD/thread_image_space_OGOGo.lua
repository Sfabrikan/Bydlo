local canvases = {}
function quad_image() 
  love.window.setTitle(NAME_GAMES.." - Cutting textures")
  for _, child in pairs( love.filesystem.getDirectoryItems( '/tmp' )) do
    love.filesystem.remove('/tmp/'..child)
  end
  local img = love.graphics.newImage("/img/fo/lua.jpg")
  local x,y = img:getDimensions()
  if not love.filesystem.isDirectory(love.filesystem.getSaveDirectory()..'/tmp') then
    love.filesystem.createDirectory('/tmp')
  end
  x = math.ceil(x/(w))
  y = math.ceil(y/(h))
  for i = 1, y do
    for j = 1, x do
      local idata
      table.insert(canvases,love.graphics.newCanvas(w,h))
      love.graphics.setCanvas(canvases[#canvases])
        love.graphics.draw(img,-((j-1)*w),-((i-1)*h))
        idata = canvases[#canvases]:newImageData()
      love.graphics.setCanvas()
      idata:encode('png','/tmp/'..i.."."..j..'.png')
    end
  end
  serializ_t({x,y},"map")
end
local img = love.graphics.newImage("/img/fo/lua.jpg")
local x,y = img:getDimensions()
img = nil
x = math.ceil(x/w)
y = math.ceil(y/h)
local haha = love.filesystem.getDirectoryItems('/tmp')
if x*y ~= #haha then
  quad_image()
end
love.window.setTitle(NAME_GAMES.." - Clear RAM")
canvases = nil

collectgarbage()
love.window.setTitle(NAME_GAMES)