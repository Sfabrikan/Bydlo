--thread img_load
require("love.filesystem")
require("love.image")

local channel_1 = love.thread.getChannel("a")
local channel_2 = love.thread.getChannel("b")
while true do
  local t = channel_1:demand()
  local img = {}
  if t then
    if t[3] == 1 then
      local ck = 1
      for i=t[2]-1, t[2]+1 do
        if love.filesystem.isFile('/tmp/'..(i).."."..(t[1]+1)..'.png') then
          img[ck] = love.image.newImageData('/tmp/'..(i).."."..(t[1]+1)..'.png')
        else
          img[ck] = love.image.newImageData('/img/err.png')
        end
      ck = ck +1
      end
    elseif t[3] == 2 then
      local ck = 1
      for i=t[1]-1, t[1]+1 do
        if love.filesystem.isFile('/tmp/'..(t[2]+1).."."..(i)..'.png') then
          img[ck] = love.image.newImageData('/tmp/'..(t[2]+1).."."..(i)..'.png')
        else
          img[ck] = love.image.newImageData('/img/err.png')
        end
      ck = ck +1
      end
    end
  channel_2:push({img,t[3]})
  else
    error(t)
  end
end