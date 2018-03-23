math.randomseed(os.time())
gr = love.graphics
win = love.window
lk = love.keyboard
wi, he = win.getMode() 

editor = {}

local p = gr.newImage("img/pistols/pistol.png")
local q = {s = {gr.newQuad(0,0,6,2,p:getDimensions()),gr.newQuad(7,0,6,2,p:getDimensions()),gr.newQuad(14,0,6,2,p:getDimensions())},d = {gr.newQuad(0,3,4,3,p:getDimensions()),gr.newQuad(5,3,4,3,p:getDimensions()),gr.newQuad(10,3,4,3,p:getDimensions()),gr.newQuad(15,3,4,3,p:getDimensions())},g = {gr.newQuad(0,7,4,2,p:getDimensions()),gr.newQuad(5,7,4,2,p:getDimensions()),gr.newQuad(10,7,4,2,p:getDimensions()),gr.newQuad(15,7,4,2,p:getDimensions()),gr.newQuad(20,7,4,2,p:getDimensions())},p = {gr.newQuad(0,10,4,2,p:getDimensions()),gr.newQuad(5,10,4,2,p:getDimensions()),gr.newQuad(10,10,4,2,p:getDimensions()),gr.newQuad(15,10,4,2,p:getDimensions()),gr.newQuad(20,10,4,2,p:getDimensions())},a = {gr.newQuad(0,13,3,2,p:getDimensions()),gr.newQuad(4,13,3,2,p:getDimensions()),gr.newQuad(8,13,3,2,p:getDimensions())}}

local pistol = gr.newQuad(21,0,11,7,p:getDimensions())

gr.setBackgroundColor(255,0,255)



function editor:cr(weap) --#оружия
local t = {}
t.weap = weap
local cumm = math.ceil(wi/img.grid:getWidth()*he/img.grid:getHeight())
t.edit = gr.newCanvas(wi,he)
	love.graphics.setCanvas(t.edit)
	for i=0, math.ceil(wi/img.grid:getWidth()) do
		for j=0, math.ceil(he/img.grid:getHeight()) do
			gr.draw(img.grid, i*img.grid:getWidth(),j*img.grid:getHeight())
		end
	end
	love.graphics.setCanvas()
t.pos = {{math.floor(wi/2/m)*m, math.floor(he/2/m)*m}}
t.pos[2] = {t.pos[1][1] - 3*m, t.pos[1][2]+weapons[weap][3][1][2]*m}
t.pos[3] = {t.pos[1][1] + weapons[weap][3][1][1]*m, t.pos[1][2]}
t.pos[4] = {t.pos[1][1], t.pos[1][2]-4*m}
t.pos[5] = {t.pos[2][1] + weapons[weap][3][2][1]*m, t.pos[1][2] + weapons[weap][3][1][2]*m-1*m}
return setmetatable(t,{__index = self})
end



local ind = 0
local buttons = {button:cr(0,0,img.arrowdown),button:cr(0,0,img.arrowup)}
local list = {1,1,1,1,1} --типо номера обвеса для оружия
local color = {{255,255,255},{255,255,255},{255,255,255},{255,255,255},{255,255,255}}
local scroll = {r = scrb:cr(10,10,"R",100),g = scrb:cr(10,30,"G"),b = scrb:cr(10,50,"B")}

function editor:dr()
gr.setColor(255,0,255)
gr.draw(self.edit)
gr.setColor(0,150,0,100)
--gr.draw(p,pistol,pos[1][1]-m,pos[1][2]-m*2,0,m,m)

	for i=1,5 do
		if ind == 0 or ind == i then
			gr.setColor(color[i][1],color[i][2],color[i][3])
		else
			gr.setColor(color[i][1],color[i][2],color[i][3],150)
		end
		gr.draw(weapons[1][1][i],weapons[1][2][i][list[i]][5],self.pos[i][1],self.pos[i][2],0,m,m)
	end

gr.setColor(255,255,255)
	if ind ~= 0 then
		gr.setColor(color[ind][1],color[ind][2],color[ind][3])
		color[ind][1] = scroll.r:dr(color[ind])
		gr.setColor(color[ind][1],color[ind][2],color[ind][3])
		color[ind][2] = scroll.g:dr(color[ind])
		gr.setColor(color[ind][1],color[ind][2],color[ind][3])
		color[ind][3] = scroll.b:dr(color[ind])
		buttons[1]:dr()
		buttons[2]:dr()
	end
gr.print(love.timer.getFPS())
gr.setColor(255,255,255)
end



function editor:up(dt)
	if ind ~= 0 then
		scroll.r:up(dt)
		scroll.g:up(dt)
		scroll.b:up(dt)
		buttons[1]:up(dt)
		buttons[2]:up(dt)
	end
end






function editor:mp(x,y,b)
	if b == 1 then
		if scroll.r:mp() or scroll.g:mp() or scroll.b:mp() then
		
		elseif not buttons[1]:mp(x,y,b) and not buttons[2]:mp(x,y,b) then
			for i=1,5 do
				if x > self.pos[i][1] and x < self.pos[i][1]+weapons[self.weap][3][i][1]*m and y > self.pos[i][2] and y < self.pos[i][2]+weapons[self.weap][3][i][2]*m then
					ind = i
					break
				else
					ind = 0
				end
			end
		else
			if buttons[1]:mp(x,y,b) then
				if list[ind] > 1 then
					list[ind] = list[ind] -1
				else
					list[ind] = 5
				end
			elseif buttons[2]:mp(x,y,b) then
				if list[ind] < 5 then
					list[ind] = list[ind] +1
				else
					list[ind] = 1
				end
			end
		end
	end
	if ind ~= 0 then
		scroll.r:r(color[ind][1]); scroll.g:r(color[ind][2]); scroll.b:r(color[ind][3]);
		buttons[1]:re(self.pos[ind][1],self.pos[ind][2]+3*m)
		buttons[2]:re(self.pos[ind][1],self.pos[ind][2]-10*m)
	end
end



function editor:kp(k)
	if k == "-" and m > 1 then
		m = m - 1
		pos = {{math.floor(wi/2/m)*m, math.floor(he/2/m)*m}}
		pos[2] = {pos[1][1]-m,pos[1][2]+m*2}; pos[3] = {pos[1][1]+m*6,pos[1][2]}; pos[4] = {pos[1][1]+m*2,pos[1][2]-m*2};  pos[5] = {pos[1][1]+m*3,pos[1][2]+m*2}
		pos[0] = {-100*m,-100*m}
	elseif k == "=" and m < 20 then
		m = m + 1
		pos = {{math.floor(wi/2/m)*m, math.floor(he/2/m)*m}}
		pos[2] = {pos[1][1]-m,pos[1][2]+m*2}; pos[3] = {pos[1][1]+m*6,pos[1][2]}; pos[4] = {pos[1][1]+m*2,pos[1][2]-m*2};  pos[5] = {pos[1][1]+m*3,pos[1][2]+m*2}
		pos[0] = {-100*m,-100*m}
	end
buttons[1]:re(pos[ind][1],pos[ind][2]+3*m)
buttons[2]:re(pos[ind][1],pos[ind][2]-10*m)
end
