local frame = CreateFrame("Frame", "LazyLearner", UIParent)
local backdropFrame = {	bgFile = [[Interface\BUTTONS\WHITE8X8]], tile = false, tileSize = 0, insets = { left = 1, right = 1, top = 1, bottom = 1}}
local backdropButton = { bgFile = [[Interface\BUTTONS\WHITE8X8]], edgeFile = [[Interface\BUTTONS\WHITE8X8]], edgeSize = 1, tile = false, tileSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0}}
local questions = {
	[1] = { question = "一", answer = {"one"}, askedCount = 0, answerCorrect = 0 },
	[2] = { question = "二", answer = {"two"}, askedCount = 0, answerCorrect = 0 },
	[3] = { question = "三", answer = {"three"}, askedCount = 0, answerCorrect = 0 },
	[4] = { question = "四", answer = {"four"}, askedCount = 0, answerCorrect = 0 },
	[5] = { question = "五", answer = {"five"}, askedCount = 0, answerCorrect = 0 },
	[6] = { question = "六", answer = {"six"}, askedCount = 0, answerCorrect = 0 },
	[7] = { question = "七", answer = {"seven"}, askedCount = 0, answerCorrect = 0 },
	[8] = { question = "八", answer = {"eight"}, askedCount = 0, answerCorrect = 0 },
	[9] = { question = "九", answer = {"nine"}, askedCount = 0, answerCorrect = 0 },
	[10] = { question = "十", 	answer = {"ten"}, askedCount = 0, answerCorrect = 0 },
	[11] = { question = "百", 	answer = {"hundred"}, askedCount = 0, answerCorrect = 0 },
	[12] = { question = "千", 	answer = {"thousand"}, askedCount = 0, answerCorrect = 0 },
	[13] = { question = "万", 	answer = {"ten thousand"}, askedCount = 0, answerCorrect = 0 },
	[14] = { question = "円", 	answer = {"yen", "circle"}, askedCount = 0, answerCorrect = 0 },
	[15] = { question = "時", 	answer = {"time"}, askedCount = 0, answerCorrect = 0 },
	[16] = { question = "日", 	answer = {"day", "sun"}, askedCount = 0, answerCorrect = 0 },
	[17] = { question = "本", 	answer = {"book", "basis"}, askedCount = 0, answerCorrect = 0 },
	[18] = { question = "人", 	answer = {"person"}, askedCount = 0, answerCorrect = 0 },
	[19] = { question = "月", 	answer = {"moon", "month"}, askedCount = 0, answerCorrect = 0 },
	[20] = { question = "火", 	answer = {"fire"}, askedCount = 0, answerCorrect = 0 },
	[21] = { question = "水", 	answer = {"water"}, askedCount = 0, answerCorrect = 0 },
	[22] = { question = "木", 	answer = {"tree"}, askedCount = 0, answerCorrect = 0 },
	[23] = { question = "金", 	answer = {"gold", "money"}, askedCount = 0, answerCorrect = 0 },
	[24] = { question = "土", 	answer = {"soil"}, askedCount = 0, answerCorrect = 0 },
	[25] = { question = "曜", 	answer = {"weekday"}, askedCount = 0, answerCorrect = 0 },
}

frame:RegisterEvent("PLAYER_LOGIN")

if not LazyLearner then
	LazyLearner = {
		x = 500,
		y = 500,
		unlocked = true
	}
end

local function CreateSubFrame(name,sort,width,height,point,relative,parent)
	local subFrame
	if sort == "frame" then
		subFrame = CreateFrame("Frame",name,frame)
	elseif sort == "fontString" then
		subFrame = parent:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	end
	subFrame:SetWidth(width)
	subFrame:SetHeight(height)
	subFrame:SetPoint(point,relative)
	return subFrame
end

local function uppercase(str)
	local temp
	str:gsub("(%l)(%w*)", function(a,b)
		temp = temp,string.upper(a)..b
	end)
	return temp
end

local function CreateMainFrame()
	local random = math.random(1,#questions)
	frame:SetWidth(200)
	frame:SetHeight(200)
	frame:SetPoint("BOTTOMLEFT", 500,500)
	frame:SetClampedToScreen(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetBackdrop(backdropFrame)
	frame:SetBackdropBorderColor(79/255, 79/255, 79/255)
	frame:SetBackdropColor(26/255, 26/255, 26/255)
	frame:EnableMouse(LazyLearner.unlocked)
	frame:SetMovable(LazyLearner.unlocked)

	frame.question = CreateSubFrame("LazyLearner_question","frame",200,100,"TOPLEFT",frame)
	frame.question.toptext = CreateSubFrame(_,"fontString",200,50,"TOPLEFT",frame.question,frame.question)
	frame.question.questiontext = CreateSubFrame(_,"fontString",200,50,"BOTTOMLEFT",frame.question,frame.question)

	frame.answer = CreateSubFrame("LazyLearner_question","frame",200,100,"BOTTOMLEFT",frame)
	frame.answer.toptext = CreateSubFrame(_,"fontString",200,30,"TOPLEFT",frame.answer,frame.answer)
	frame.answer.questiontext = CreateSubFrame(_,"fontString",200,50,"BOTTOMLEFT",frame.answer,frame.answer)

	frame.answer.editbox = CreateFrame("EditBox",nil,frame.answer)
	frame.answer.editbox:SetWidth(150)
	frame.answer.editbox:SetHeight(24)
	frame.answer.editbox:SetPoint("CENTER",frame.answer,"CENTER")
	frame.answer.editbox:SetFontObject(GameFontNormal)
	frame.answer.editbox:Disable()

	frame.question.toptext:SetText("Question:")
	frame.question.questiontext:SetText(questions[random].question)
	frame.answer.toptext:SetText("Your answer:")
	frame.answer.questiontext:SetText(uppercase(table.concat(questions[random].answer,",")))


	frame:SetScript("OnDragStart",frame.StartMoving)
	frame:SetScript("OnDragStop", function()
		frame:StopMovingOrSizing()
		LazyLearner.x = math.ceil(frame:GetLeft())
		LazyLearner.y = math.ceil(frame:GetBottom())
	end)

end

frame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		CreateMainFrame()

		StaticPopup_Show("TEST", "test")
	end
end)



