pregame = {}

function pregame:cr()
	self.buttons = {gui.button(100,100,"<"), gui.button(140,100,">"), gui.button(100,140,"<"), gui.button(140,140,">")}
	self.text = "name: "
end

function pregame:dr()
	gr.print()
end

function pregame:up(dt)

end

