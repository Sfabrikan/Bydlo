
local cunpress = {255,255,255}
local cpress = {144,255,144}

--универсальная штука для всех игор
gui = {}
gui.button = {}
gui.textbox = {}

function gui.button:cr(x,y,text)
	local t = {}
	t.x = x; t.y = y; t.text = text; t.tuch = false
	return setmetatable(t,{__index = self})
end
function gui.button:dr()
	if self.tuch then
		gr.print({cpress, self.text},self.x,self.y)
	else
		gr.print({cunpress, self.text},self.x,self.y)
	end
end
function gui.button:up(dt)
	self.tuch = false
	local x,y = love.mouse.getPosition()
	if x >= self.x and x <= self.x+fonts.LMR:getWidth(self.text) and
	y >= self.y and y <= self.y+fonts.LMR:getHeight() then
		self.tuch = true
	end
end
function gui.button:mp(x,y,b)
	if b == 1 and self.tuch then
		return true
	end
	return false
end
function gui.button:get()
return self.x, self.y, fonts.LMR:getWidth(self.text), fonts.LMR:getHeight()
end
function gui.button:act(foo) return foo(self) end


--Эт мое достижение в данный момент 
function gui.textbox:cr(x,y,tbutt,titul,text)
	local t = {}
	t.x=x;t.y=y;t.tit = titul; t.text = gr.newText(fonts.LMR,"")
	t.w = 300
	if fonts.LMR:getWidth(table.concat(tbutt))+#tbutt*10 > t.w then
		t.w = fonts.LMR:getWidth(table.concat(tbutt))+#tbutt*10
	end
	index = t.text:addf(text,t.w-10,"left")
	t.htitul = 20
	th = t.text:getHeight(index)
	t.h = th+2
	print(th)
	t.hbutt = 20
	t.button = {}
	t.bposx = {}
	local bx,bw, _ = 0,0
	for i=1, #tbutt do
		table.insert(t.button, gui.button:cr(t.x+bx+bw+10,t.htitul+t.h+2, tbutt[i]))		
		bx,_,bw = t.button[i]:get()
		table.insert(t.bposx, bx+bw)
	end
	t.body = gr.newCanvas(t.w,t.h+t.htitul+t.hbutt)
	t.grab = false
	t.toch = false
	t.smx = 0; t.smy = 0
	gr.setCanvas(t.body)
		gr.setFont(fonts.LMR)
		gr.setColor(255,255,255)
		love.graphics.setLineStyle("rough")
		gr.rectangle("line",1,1,t.w-1,t.htitul-1)
		gr.printf(titul, 0, 0,t.w, "center")
		gr.rectangle("line",1,t.htitul,t.w-1,t.h)
		gr.rectangle("line",1,t.htitul+t.h,t.w-1,t.hbutt)
		gr.draw(t.text, 5, t.htitul)
	gr.setCanvas()
	return setmetatable(t,{__index = self})
end

function gui.textbox:up(dt)
	gr.draw(self.body,self.x,self.y)
	self.toch = false
	local mx, my = love.mouse.getPosition()
	if mx >= self.x and mx <= self.x+self.w 
	and	my >= self.y and my <= self.y+self.htitul then
		self.toch = true
	end
	if self.grab then
		self.x = mx-self.smx
		self.y = my-self.smy
	end
	if self.x <= 0 then
		self.x = 0
	elseif self.x+self.w >= gr.getWidth()  then
		self.x = gr.getWidth()-self.w
	end
	if self.y <= 0 then
		self.y = 0
	elseif self.y+self.h+self.htitul+self.hbutt >= gr.getHeight()  then
		self.y = gr.getHeight()-self.h-self.htitul-self.hbutt
	end
	for k,v in pairs(self.button) do
		v:up(dt)
		local bx, _ , bw = v:get()
		local foo = function(a)
			if k > 1 then
				a.x = self.x + self.bposx[k-1]+5
			else
				a.x = self.x +5
			end
			a.y = self.y + self.htitul+self.h+2
		end
		v:act(foo)
	end
end

function gui.textbox:dr()
	for k,v in pairs(self.button) do
		v:dr()
	end
	gr.draw(self.body,self.x,self.y)
end

function gui.textbox:mp(x,y,b)
	if self.toch then
		self.grab = true
		self.smx, self.smy = math.abs(x-self.x), math.abs(y-self.y)
	end
end

function gui.textbox:mr(x,y,b)
	self.grab = false
end

