button = {}

function button:cr(x,y,i)
local t = {}
t.x = x or 0
t.y = y or 0
t.i = i
t.h = false
return setmetatable(t,{__index = self})
end


function button:up(dt)

local x,y = love.mouse.getPosition()
	if x > self.x and x < self.x + self.i:getWidth()*m and y > self.y and y < self.y + self.i:getHeight()*m then
		self.h = true
	else
		self.h = false
	end
end

function button:dr()
	if self.h then
	gr.setColor(255,255,255)
	else
	gr.setColor(255,255,255,175)
	end
gr.draw(self.i, self.x, self.y, 0, m, m)
end

function button:re(x,y)
self.x = x
self.y = y
end

function button:mp(x,y,b)
	if not self.h then
		return false
	end
return true
end
