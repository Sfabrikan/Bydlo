math.randomseed(os.time())
gr = love.graphics
win = love.window
lk = love.keyboard
wi, he = win.getMode() 
love.graphics.setDefaultFilter( 'nearest', 'nearest')

m=2
font = {pt = gr.newFont("font/PTM55FT.ttf",20)}
img = {grid = gr.newImage("img/grid/grid.png"), arrowup = gr.newImage("img/gui/arrowup.png"), arrowdown = gr.newImage("img/gui/arrowdown.png")}

fw = font.pt:getWidth(" ")
fh = font.pt:getHeight()

require("weapons")
require("button")
require("scroll")
require("editor")

gr.setFont(font.pt)

function love.load()
room = editor:cr(1)
end

function love.update(dt)
room:up(dt)
end

function love.draw()
room:dr()
end

function love.mousepressed(x, y, b)
room:mp(x,y,b)
end

function love.keypressed(key)
room:kp(key)
end

function love.textinput(t)

end

function love.quit()

end
