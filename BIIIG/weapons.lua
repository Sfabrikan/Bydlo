--оружие[1] рисунок
--оружие[2] = {[1]штука{[1]деталь{имя,урон,точность,патроны,квад}

weapons = {}

--1 пестоли
--2 пулеметы
--3 особые
--4 ближний бой
--5 гранаты

weapons[1] = {{	gr.newImage("img/pistols/zatvor.png"),gr.newImage("img/pistols/ruk.png"),gr.newImage("img/pistols/dulo.png"),
				gr.newImage("img/pistols/pr.png"),gr.newImage("img/pistols/ass.png")}}
weapons[1][2] = {	{{"A",1,50,100},{"X",5,60,25},{"Z",1,100,100},{"R",1,100,100},{"P",1,100,100}},
				{{"A",1,50,100},{"J",5,60,25},{"K",1,100,100},{"R",1,100,100},{"L",1,100,100}},
				{{"B",1,50,100},{"A-S",5,60,25},{"S",1,100,100},{"C",1,100,100},{"G",1,100,100}},
				{{"23",1,50,100},{"100500",5,60,25},{"90",1,100,100},{"2K",1,100,100},{"5",1,100,100}},
				{{"D",1,50,100},{"Q",5,60,25},{"F",1,100,100},{"J",1,100,100},{"V",1,100,100}}}
weapons[1][3] = {{23,6},{18,11},{11,7},{23,4},{23,9}} --pos

for i=1,5 do
	weapons[1][2][1][i][5] = gr.newQuad(0,6*(i-1),23,6,weapons[1][1][1]:getDimensions())
	weapons[1][2][2][i][5] = gr.newQuad(0,11*(i-1),18,11,weapons[1][1][2]:getDimensions())
	weapons[1][2][3][i][5] = gr.newQuad(0,7*(i-1),11,7,weapons[1][1][3]:getDimensions())
	weapons[1][2][4][i][5] = gr.newQuad(0,4*(i-1),23,4,weapons[1][1][4]:getDimensions())
	weapons[1][2][5][i][5] = gr.newQuad(0,9*(i-1),23,9,weapons[1][1][5]:getDimensions())
end



