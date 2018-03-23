game = {}
local empty = gr.newImage("img/empty.png")
function game:cr()
	self.map = {{1,1,1},
				{1,1,1},
				{1,1,1}}
	
end

function game:dr()
	for k,v in pairs(self.map) do
		gr.draw(empty,)
	end
end

function game:up(dt)

end

