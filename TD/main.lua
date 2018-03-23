NAME_GAMES = "TD(ð)"
love.window.setTitle(NAME_GAMES.." - Init")
gr = love.graphics
w, h = gr.getDimensions()
require("searil") --сеарилизация serializ_t(t,filename), load_serializ(filename)
require("thread_image_space_OGOGo") --Резалка пикчей на куски 

map={}
local save = {px=0,py=0,xboo=false,yboo=false}
function love.load()
  x_pos_player = 400
  y_pos_player = 250
  save.px,save.py = math.ceil((x_pos_player-w)/(w))+1, math.ceil((y_pos_player-h)/(h))+1
  for i = save.py-1, save.py+1 do
    map[i] = {}
    for j = save.px-1,save.px+1 do
      local img
      if love.filesystem.isFile('/tmp/'..i.."."..j..'.png') then
        img = love.image.newImageData('/tmp/'..i.."."..j..'.png')
      else
        img = love.image.newImageData('/img/err.png')
      end
      map[i][j] = gr.newImage(img)
    end
  end
  x_trasp = w/2
  y_trasp = h/2
  gg = gr.newImage('/img/G.png')
  imgs= gg
  load_img = love.thread.newThread('load_img.lua')
  channel_1 = love.thread.getChannel("a")
  channel_2 = love.thread.getChannel("b")
  load_img:start()
end

function love.update(dt)
  local tut = channel_2:pop()
  local px, py = math.ceil((x_pos_player-w)/w)+1, math.ceil((y_pos_player-h)/h)+1
  if save.py ~= py then
    if py > save.py then
      save.yboo=true
      channel_1:push({px,py,2})
      
    else
      save.yboo=false
      channel_1:push({px,py-2,2})
    end
    save.py = py 
  end
  if save.px ~= px then
    if px > save.px then
      save.xboo=true
      channel_1:push({px,py,1})
    else
      save.xboo=false
      channel_1:push({px-2,py,1})
    end
    save.px = px
  end
  if tut then
    if tut[2] == 1 then --Тут X обработка
      if save.xboo then
        local ck = 1
        for i = save.py-1, save.py+1 do
          if not map[i] then
            map[i] = {}
          end
          map[i][px-2] = nil
          map[i][px+1] = gr.newImage(tut[1][ck])
          ck = ck+1
        end
      else
        local ck = 1
        for i = save.py-1, save.py+1 do
          if not map[i] then
            map[i] = {}
          end
          map[i][px+2] = nil
          map[i][px-1] = gr.newImage(tut[1][ck])
          ck = ck+1
        end
      end
    elseif tut[2] == 2 then ----тут Y
      if save.yboo then
        local ck = 1
        for i = save.px-1, save.px+1 do
          if not map[py+1] then
            map[py+1] = {}
          end
          map[py-2]= nil
          map[py+1][i] = gr.newImage(tut[1][ck])
          ck = ck+1
        end
      else
        local ck = 1
        for i = save.px-1, save.px+1 do
          if not map[py-1] then
            map[py-1] = {}
          end
          map[py+2]= nil
          map[py-1][i] = gr.newImage(tut[1][ck])
          ck = ck+1
        end
      end
    end
  end
  local c = 1
  if love.keyboard.isDown("lshift") then
    c = 10
  end
  if love.keyboard.isDown("w") then
    y_pos_player = y_pos_player-100*dt*c
  elseif love.keyboard.isDown("s") then
    y_pos_player = y_pos_player+100*dt*c
  elseif love.keyboard.isDown("a") then
    x_pos_player = x_pos_player-100*dt*c
  elseif love.keyboard.isDown("d") then
    x_pos_player = x_pos_player+100*dt*c
  end
  collectgarbage()
end


function love.draw()
  local px, py = math.ceil((x_pos_player-w)/(w)), math.ceil((y_pos_player-h)/(h))
  love.graphics.translate(x_trasp-x_pos_player,y_trasp-y_pos_player)
  for k,v in pairs(map) do
    for k1,v1 in pairs(v) do
      gr.draw(map[k][k1],(k1-1)*w,(k-1)*h)
    end
  end
  gr.draw(gg,x_pos_player,y_pos_player)
  gr.print((px+1).." "..(py+1),x_pos_player,y_pos_player)
  gr.print(love.timer.getFPS(),x_pos_player,y_pos_player+20)
end


