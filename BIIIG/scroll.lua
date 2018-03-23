scrb = {}

function scrb:cr(x,y,text,v,w,h)
local t = {}
t.x = x or 0
t.y = y or 0
t.text = text or ""
t.val = v or 0
t.w = w or 255
t.h = h or 10
t.how = false
return setmetatable(t,{__index = self})
end


function scrb:up(dt)
local x,y = love.mouse.getPosition()
self.how = false
		if x > self.x and x < self.x + self.w and y > self.y and y < self.y + self.h then
			if love.mouse.isDown(1) then
			self.val = x-self.x
			end
			self.how = true
		end
end

function scrb:dr(c)
gr.rectangle("fill",self.x,self.y,self.val,self.h)
gr.setColor(255,255,255)
gr.rectangle("line",self.x,self.y,self.w,self.h)
gr.setColor(255,255,255)
gr.rectangle("line",self.x,self.y,self.val,self.h)
gr.setColor(math.abs(c[1]-255),math.abs(c[2]-255),math.abs(c[3]-255))
gr.print(self.text,self.x+self.w*0.5-fw*0.5,self.y+self.h*0.5-fh*0.5)
return self.val
end

function scrb:r(v)
	self.val = v
end

function scrb:mp()
	if not self.how then
		return false
	end
return true
end

