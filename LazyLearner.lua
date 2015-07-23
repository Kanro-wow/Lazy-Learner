local frame = CreateFrame("Frame", "LazyLearner_Frame", UIParent)
local backdropFrame = {	bgFile = [[Interface\BUTTONS\WHITE8X8]], tile = false, tileSize = 0, insets = { left = 1, right = 1, top = 1, bottom = 1}}
local backdropButton = { bgFile = [[Interface\BUTTONS\WHITE8X8]], edgeFile = [[Interface\BUTTONS\WHITE8X8]], edgeSize = 1, tile = false, tileSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0}}
local questions = {
	{ ID = 1, question = "一", answer = {"one"}},
	{ ID = 2, question = "二", answer = {"two"}},
	{ ID = 3, question = "三", answer = {"three"}},
	{ ID = 4, question = "四", answer = {"four"}},
	{ ID = 5, question = "五", answer = {"five"}},
	{ ID = 6, question = "六", answer = {"six"}},
	{ ID = 7, question = "七", answer = {"seven"}},
	{ ID = 8, question = "八", answer = {"eight"}},
	{ ID = 9, question = "九", answer = {"nine"}},
	{ ID = 10, question = "十", 	answer = {"ten"}},
	{ ID = 11, question = "百", 	answer = {"hundred"}},
	{ ID = 12, question = "千", 	answer = {"thousand"}},
	{ ID = 13, question = "万", 	answer = {"ten thousand"}},
	{ ID = 14, question = "円", 	answer = {"yen", "circle"}},
	{ ID = 15, question = "時", 	answer = {"time"}},
	{ ID = 16, question = "日", 	answer = {"day", "sun"}},
	{ ID = 17, question = "本", 	answer = {"book", "basis"}},
	{ ID = 18, question = "人", 	answer = {"person"}},
	{ ID = 19, question = "月", 	answer = {"moon", "month"}},
	{ ID = 20, question = "火", 	answer = {"fire"}},
	{ ID = 21, question = "水", 	answer = {"water"}},
	{ ID = 22, question = "木", 	answer = {"tree"}},
	{ ID = 23, question = "金", 	answer = {"gold", "money"}},
	{ ID = 24, question = "土", 	answer = {"soil"}},
	{ ID = 26, question = "曜", 	answer = {"weekday"}},
}

local fontDefault = {
	font = [[Fonts\ARKai_C.ttf]],
	size = 30,
	width = 500,
	height = 50,
	relative = frame,
	relativePoint = "BOTTOMLEFT",
	point = "TOPLEFT",
	offsetx = 0,
	offsety = 0,
	align = "CENTER",
}

local current
frame:RegisterEvent("PLAYER_LOGIN")

local function globalVars()
	LazyLearner = nil

	if not LazyLearner then
		LazyLearner = {
			x = 500,
			y = 500,
			unlocked = true,
			answered = {}
		}
	end

	for _,question in next, questions do
		if not LazyLearner.answered[question.ID] then
			LazyLearner.answered[question.ID] = {
				countCorrect = 0,
				countAsked = 0,
				probability = 100,
			}
		end
	end
end

local function uppercase(str)
	local text
	str:gsub("(%l)(%w*)", function(a,b)
		text = text,string.upper(a)..b
	end)
	return text
end

local function checkQuestionCondition()
	frame:Show()
end

local function setUpText(text,font,size,width,height,relative,relativePoint,point,offsetx,offsety,align)
	local settings = fontDefault

	if not font 					then font						= settings.font 					end
	if not size 					then size						= settings.size 					end
	if not width 					then width					= settings.width 					end
	if not height 				then height					= settings.height 				end
	if not relative 			then relative				= settings.relative 			end
	if not relativePoint	then relativePoint	= settings.relativePoint 	end
	if not point 					then point					= settings.point 					end
	if not offsetx 				then offsetx				= settings.offsetx 				end
	if not offsety 				then offsety				= settings.offsety 				end
	if not align 					then align					= settings.align 					end

	text:SetWidth(settings.width)
	text:SetHeight(settings.height)
	text:SetPoint(point,relative,relativeFrame,offsetx,offsety)
	text:SetFont(font,size,"OUTLINEMONOCHROME")
	text:SetJustifyH(align)
end

local function createMainFrame()
	frame:SetPoint("BOTTOMLEFT", 500, 500)
	frame:SetClampedToScreen(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetBackdrop(backdropFrame)
	frame:SetBackdropBorderColor(79/255, 79/255, 79/255)
	frame:SetBackdropColor(26/255, 26/255, 26/255)
	frame:EnableMouse(LazyLearner.unlocked)
	frame:SetMovable(LazyLearner.unlocked)
	frame:SetWidth(500)
	frame:SetHeight(300)

	frame.toptext = frame:CreateFontString("LazyLearner_toptext", "BACKGROUND")
	setUpText(frame.toptext,nil,30,nil,nil,frame,nil,nil,nil,nil,nil)
	frame.toptext:SetText(questions[math.random(1,#questions)].question)

	frame.editbox = CreateFrame("EditBox",nil,frame)
	frame.editbox:Disable()
	setUpText(frame.editbox,nil,20,nil,200,frame,nil,nil,nil,-50,nil)
	frame.editbox:SetScript("OnMouseDown", function()
		frame.editbox:Enable()
	end)
	frame.editbox:SetScript("OnEnterPressed", function()
		frame.editbox:Disable()
		frame.editbox:SetText("")
	end)
	frame.editbox:SetScript("OnEscapePressed", function()
		frame.editbox:Disable()
	end)

	frame.answer = frame:CreateFontString("LazyLearner_answertext", "BACKGROUND")
	setUpText(frame.answer,nil,20,nil,200,frame,nil,nil,nil,-250,nil)
	frame.answer:SetText(table.concat(questions[math.random(1,#questions)].answer,", "))



	-- frame.toptext = createSubFrame("LazyLearner_toptext", "fontstring", 500,50,0,0,frame)
	-- frame.toptext:SetText("Question:")
	-- frame.question = createSubFrame("LazyLearner_Question", "fontstring", 500,50,0,0,frame.toptext)
	-- frame.question:SetText("s-s-enpai")

end



-- local function createMainFrame()
-- 	local random = math.random(1,#questions)
-- 	frame:SetWidth(500)
-- 	frame:SetHeight(200)
-- 	frame:SetPoint("BOTTOMLEFT", 500,500)

-- 	frame.question = createSubFrame("LazyLearner_question","frame",500,100,"TOPLEFT",frame)
-- 	frame.question.toptext = createSubFrame(_,"fontString",500,50,"TOPLEFT",frame.question,frame.question)
-- 	frame.question.questiontext = createSubFrame(_,"fontString",500,50,"BOTTOMLEFT",frame.question,frame.question)

-- 	frame.answer = createSubFrame("LazyLearner_question","frame",500,100,"BOTTOMLEFT",frame)
-- 	frame.answer.toptext = createSubFrame(_,"fontString",500,24,"CENTER",frame.answer,frame.answer,"CENTER")
-- 	frame.answer.questiontext = createSubFrame(_,"fontString",500,50,"BOTTOMLEFT",frame.answer,frame.answer)

-- 	-- frame.answer.toptext:SetBackdrop(backdropFrame)
-- 	-- frame.answer.toptext:SetBackdropColor(26/255, 26/255, 26/255)
-- 	frame.answer.editbox =
-- 	frame.answer.editbox:SetWidth(450)
-- 	frame.answer.editbox:SetHeight(24)
-- 	frame.answer.editbox:SetPoint("CENTER",frame.answer,"CENTER")
-- 	frame.answer.editbox:SetFontObject(GameFontNormal)
-- 	frame.answer.editbox:Disable()
--

-- 	frame.question.toptext:SetText("Question:")
-- 	frame.question.questiontext:SetText(questions[random].question)
-- 	frame.answer.toptext:SetText("Your answer:")
-- 	frame.answer.questiontext:SetText(uppercase(table.concat(questions[random].answer,",")))


-- 	frame:SetScript("OnDragStart",frame.StartMoving)
-- 	frame:SetScript("OnDragStop", function()
-- 		frame:StopMovingOrSizing()
-- 		LazyLearner.x = math.ceil(frame:GetLeft())
-- 		LazyLearner.y = math.ceil(frame:GetBottom())
-- 	end)
-- end

frame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		globalVars()
		createMainFrame()

	end
end)



