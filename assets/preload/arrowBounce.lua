local beaty = not downscroll
local originalY = 40
local yPos = originalY

function onBeatHit()
	triggerEvent('Add Camera Zoom',0.1,0.05);
	local beatCalc = (60/bpm)
	yPos = beaty and originalY or -1 * originalY

	if beaty then
		strumY('player',1)
		noteTweenY(math.random(),5,defaultPlayerStrumY0,beatCalc,'circOut')
		strumY('player',3)
		noteTweenY(math.random(),7,defaultPlayerStrumY0,beatCalc,'circOut')
		strumY('opponent',0)
		noteTweenY(math.random(),0,defaultPlayerStrumY0,beatCalc,'circOut')
		strumY('opponent',2)
		noteTweenY(math.random(),2,defaultPlayerStrumY0,beatCalc,'circOut')
	else
		strumY('player',0)
		noteTweenY(math.random(),4,defaultPlayerStrumY0,beatCalc,'circOut')
		strumY('player',2)
		noteTweenY(math.random(),6,defaultPlayerStrumY0,beatCalc,'circOut')
		strumY('opponent',1)
		noteTweenY(math.random(),1,defaultPlayerStrumY0,beatCalc,'circOut')
		strumY('opponent',3)
		noteTweenY(math.random(),3,defaultPlayerStrumY0,beatCalc,'circOut')
	end
		beaty = not beaty;
end

function strumY(strum,index)
	setPropertyFromGroup(strum .. 'Strums',index,'y', defaultPlayerStrumY0 - yPos)
end