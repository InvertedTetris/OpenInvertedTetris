--Global variables

boardX = 10
boardY = 21

tileX = 32
tileY = 32

screenX = 2 * boardX * tileX --640 
screenY = boardY * tileY 	 --672

cubes = {}
gray = 1
other = 2

pieceI = 2
pieceJ = 3
pieceL = 4
pieceO = 5
pieceS = 6
pieceT = 7
pieceZ = 8

pieceCentering = {}
pieceCentering[pieceI] = 3
pieceCentering[pieceJ] = 3
pieceCentering[pieceL] = 4
pieceCentering[pieceO] = 4
pieceCentering[pieceS] = 4
pieceCentering[pieceT] = 3
pieceCentering[pieceZ] = 3

piece = 0
col = 1
row = 2
width = 3
height = 4
shape = 5
rotation = 6
color = 7

rotPressDelay = 0.2 --Amount of time between rotation key presses
keyPressDelay = 0.1 --Amount of time between non-rotation key presses
descentDelayStart = 1--Amount of time for a piece to drop one square at game start
minDelay = 0.05 --Minimum descent delay (never gets faster than this)
scoreDelayThreshold = 2 --Score threshold for increase in descent speed
speedIncrease = 0.05 --Reduction in time for a piece to drop when threshold is hit
gameOverDelay = 1.5 --Amount of time between game over and ability to hit a key to continue

play = 0
pause = 1
menu = 2

--Create a board
function createBoard()
	myBoard = {}
	
	for i=1, boardX do
		myBoard[i] = {}
		for j=1, boardY do
			if j < boardY/2 then
				myBoard[i][j] = gray
			else if j == math.ceil(boardY/2) and i <= boardX/2 then
					myBoard[i][j] =	gray 
				else
					myBoard[i][j] =	other
			end 
			end
		end
	end
	
	return myBoard
end

--Set up the pieces
function createPieces()
	pieces = {}
	
	for i=pieceI, pieceZ do
		pieces[i] = {}
	end
	
	createPieceI(pieceI)
	createPieceJ(pieceJ)
	createPieceL(pieceL)
	createPieceO(pieceO)
	createPieceS(pieceS)
	createPieceT(pieceT)
	createPieceZ(pieceZ)
end

function createPieceI(myPiece)
	for i=1,4 do
		pieces[myPiece][i] = {}
		pieces[myPiece][i][1] = true
	end
end

function createPieceJ(myPiece)
	for i=1,3 do
		pieces[myPiece][i] = {}
	end
	pieces[myPiece][1][1] = true
	pieces[myPiece][2][1] = false
	pieces[myPiece][3][1] = false
	pieces[myPiece][1][2] = true
	pieces[myPiece][2][2] = true
	pieces[myPiece][3][2] = true
end

function createPieceL(myPiece)
	for i=1,3 do
		pieces[myPiece][i] = {}
	end
	pieces[myPiece][1][1] = false
	pieces[myPiece][2][1] = false
	pieces[myPiece][3][1] = true
	pieces[myPiece][1][2] = true
	pieces[myPiece][2][2] = true
	pieces[myPiece][3][2] = true
end

function createPieceO(myPiece)
	for i=1,2 do
		pieces[myPiece][i] = {}
		for j=1,2 do
			pieces[myPiece][i][j] = true
		end
	end
end

function createPieceS(myPiece)
	for i=1,3 do
		pieces[myPiece][i] = {}
	end
	pieces[myPiece][1][1] = false
	pieces[myPiece][2][1] = true
	pieces[myPiece][3][1] = true
	pieces[myPiece][1][2] = true
	pieces[myPiece][2][2] = true
	pieces[myPiece][3][2] = false
end

function createPieceT(myPiece)
	for i=1,3 do
		pieces[myPiece][i] = {}
	end
	pieces[myPiece][1][1] = false
	pieces[myPiece][2][1] = true
	pieces[myPiece][3][1] = false
	pieces[myPiece][1][2] = true
	pieces[myPiece][2][2] = true
	pieces[myPiece][3][2] = true
end

function createPieceZ(myPiece)
	for i=1,3 do
		pieces[myPiece][i] = {}
	end
	pieces[myPiece][1][1] = true
	pieces[myPiece][2][1] = true
	pieces[myPiece][3][1] = false
	pieces[myPiece][1][2] = false
	pieces[myPiece][2][2] = true
	pieces[myPiece][3][2] = true
end

--Load the images
function createImages()
	cubes[gray] = love.graphics.newImage("images/cubeGray.png")
	cubes[other] = love.graphics.newImage("images/cubeGreen.png")
end

--Renders the current block to the screen
function renderBlock(blockToDraw)
	local pieceToDraw = blockToDraw[piece]
	local x = blockToDraw[col]
	local y = blockToDraw[row]

	local paint = blockToDraw[color]

	for i=1,blockToDraw[width] do
		for j=1,blockToDraw[height] do
			if pieceToDraw[i][j] then
				love.graphics.draw(cubes[paint], tileX*(x+i-2), tileY*(y+j-2))
			end
			j=j+1
		end
		i=i+1
	end
end

--Randomly chooses a new block to drop and returns it
function getNewBlock(inverted)	--inverted -> newRow (starting position), color
	math.random()
	math.random()
	math.random()
	
	local newBlock = {}
	local newPiece = math.random(pieceI, pieceZ)
	local newCol = pieceCentering[newPiece] + 1
	local newRow 
	local newColor

	local i=1
	local j=1
	while pieces[newPiece][i]~=nil do
		while pieces[newPiece][i][j]~=nil do
			j=j+1
		end
		i=i+1
	end
	if inverted then
		newRow = boardY-(j-2)
		newColor = gray 
	else
		newRow = 1
		newColor = other 
	end

	newBlock[piece] = pieces[newPiece]
	newBlock[col] = newCol
	newBlock[row] = newRow
	newBlock[width] = i-1
	newBlock[height] = j-1
	newBlock[shape] = newPiece
	newBlock[rotation] = 1
	newBlock[color]	= newColor 

	return newBlock
end

--Draws to the screen, called continuously
function love.draw()
	if gameState == pause then
		renderPause()
		return
	end

	renderTitle()
	renderScore()
	
	if gameOver then
		renderGameOver()
		return
	end
	
    for i=1, boardX do
		for j=1, boardY do
			love.graphics.draw(cubes[board[i][j]], tileX * (i-1), tileY * (j-1))
		end
	end
	
	renderBlock(activeBlock)
	renderBlock(activeBlock2)
	renderQueueTitle()
	renderQueueBlock(queueBlock)
	renderQueueBlock(queueBlock2)
end

--Renders Game Over screen
function renderGameOver()
	local toPrintA = "Game Over"
	local textWidthA = medFont:getWidth(toPrintA)
	local boardWidth = boardX*tileX
	
	love.graphics.setFont(medFont)
	love.graphics.print(toPrintA, (boardWidth-textWidthA)/2, 100)
	
	if gameOverTimer > gameOverDelay then
		local toPrintB = "Press any key to play again"
		local textWidthB = smallFont:getWidth(toPrintB)
		love.graphics.setFont(smallFont)
		love.graphics.print(toPrintB, (boardWidth-textWidthB)/2, 200)
	end
end

--Draw the game title
function renderTitle()
	local toPrintA = "OpenInverted"
	local textWidthA = bigFont:getWidth(toPrintA)
	local boardWidth = boardX*tileX
	
	love.graphics.setFont(bigFont)
	love.graphics.print(toPrintA, (boardWidth+screenX-textWidthA)/2, 50)

	local toPrintB = "use arrow keys" 
	local toPrintC = "and wasd to move"
	local textWidthB = smallFont:getWidth(toPrintB)
	local textWidthC = smallFont:getWidth(toPrintC)
	love.graphics.setFont(smallFont)
	love.graphics.print(toPrintB, (boardWidth+screenX-textWidthB)/2, 115)
	love.graphics.print(toPrintC, (boardWidth+screenX-textWidthC)/2, 130)
end

--Draw the pause screen
function renderPause()
	local toPrint = "Game Paused"
	local textWidth = medFont:getWidth(toPrint)
	local textHeight = medFont:getHeight()
	
	love.graphics.setFont(medFont)
	love.graphics.print(toPrint, (screenX-textWidth)/2, (screenY-textHeight)/2)
end

--Update function, handles teh logics
function love.update(dt)
	if gameOver then
		gameOverTimer = gameOverTimer + dt
		return
	end
	
	if gameState == pause then
		return
	end
	update1(dt)
	update2(dt)
	score = score + dt
end

function update1(dt)	
	
	keyPressTimerL = keyPressTimerL - dt
	keyPressTimerR = keyPressTimerR - dt
	keyPressTimerU = keyPressTimerU - dt
	keyPressTimerD = keyPressTimerD - dt
	
	if keyPressTimerU <= 0 then
		if love.keyboard.isDown("up") then
			activeBlock = attemptRotation(activeBlock)
			keyPressTimerU = rotPressDelay
		end
	end
		
	if keyPressTimerL <= 0 then
		if love.keyboard.isDown("left") then
			if checkBlockedLeft(activeBlock)==false then
				activeBlock[col] = activeBlock[col] - 1
			end
			keyPressTimerL = keyPressDelay
		end
	end

	if keyPressTimerR <= 0 then
		if love.keyboard.isDown("right") then
			if checkBlockedRight(activeBlock)==false then
				activeBlock[col] = activeBlock[col] + 1
			end
			keyPressTimerR = keyPressDelay
		end
	end
		
	if keyPressTimerD <= 0 then
		if love.keyboard.isDown("down") then
			if checkBlockedDown(activeBlock) then
				addBlockToBoard(activeBlock)
				placeNewBlock1()
			else
				activeBlock[row] = activeBlock[row] + 1
			end
			keyPressTimerD = keyPressDelay
		end
	end
	
	--Keeping the check here allows for 'wall kicks'
	--Wall kicks are larger at slower descent speeds
	--Add a check before the key press checks to eliminate wall kicks
	descentTimer = descentTimer - dt
	if descentTimer <=0 then
		descentTimer = descentDelay
		if checkBlockedDown(activeBlock) then
			addBlockToBoard(activeBlock)
			placeNewBlock1()
		else
			activeBlock[row] = activeBlock[row] + 1
		end
	end	
end


function update2(dt)	
	
	keyPressTimerL2 = keyPressTimerL2 - dt
	keyPressTimerR2 = keyPressTimerR2 - dt
	keyPressTimerU2 = keyPressTimerU2 - dt
	keyPressTimerD2 = keyPressTimerD2 - dt
	
	if keyPressTimerU2 <= 0 then
		if love.keyboard.isDown("s") then
			activeBlock2 = attemptRotation(activeBlock2)
			keyPressTimerU2 = rotPressDelay
		end
	end
		
	if keyPressTimerL2 <= 0 then
		if love.keyboard.isDown("a") then
			if checkBlockedLeft(activeBlock2)==false then
				activeBlock2[col] = activeBlock2[col] - 1
			end
			keyPressTimerL2 = keyPressDelay
		end
	end

	if keyPressTimerR2 <= 0 then
		if love.keyboard.isDown("d") then
			if checkBlockedRight(activeBlock2)==false then
				activeBlock2[col] = activeBlock2[col] + 1
			end
			keyPressTimerR2 = keyPressDelay
		end
	end
		
	if keyPressTimerD2 <= 0 then
		if love.keyboard.isDown("w") then
			if checkBlockedUp(activeBlock2) then
				addBlockToBoard(activeBlock2)
				placeNewBlock2()
			else
				activeBlock2[row] = activeBlock2[row] - 1
			end
			keyPressTimerD2 = keyPressDelay
		end
	end
	
	--Keeping the check here allows for 'wall kicks'
	--Wall kicks are larger at slower descent speeds
	--Add a check before the key press checks to eliminate wall kicks
	descentTimer2 = descentTimer2 - dt
	if descentTimer2 <=0 then
		descentTimer2 = descentDelay
		if checkBlockedUp(activeBlock2) then
			addBlockToBoard(activeBlock2)
			placeNewBlock2()
		else
			activeBlock2[row] = activeBlock2[row] - 1
		end
	end	
end

function love.keypressed(key)
	if gameOver then
		if gameOverTimer > gameOverDelay then
			beginGame()
			return
		end
	end

	if key == "escape" then
		if gameState == play then
			gameState = pause
		elseif gameState == pause then
			gameState = play
		end
	end
end

--Returns true if a block has 'landed' (for upper block moving down)
function checkBlockedDown(activeBlock)
	if activeBlock[row] + activeBlock[height] > boardY then
		return true
	end
	for i=1,activeBlock[width] do
		for j=1, activeBlock[height] do
			if activeBlock[piece][i][j] then
				if board[activeBlock[col]+i-1]~=nil then
					if board[activeBlock[col]+i-1][activeBlock[row]+j]~=nil then
						if board[activeBlock[col]+i-1][activeBlock[row]+j]==activeBlock[color] then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

--Returns true if a block has 'landed' (for lower block moving up)
function checkBlockedUp(activeBlock)
	if activeBlock[row] < 2 then
		return true
	end
	for i=1,activeBlock[width] do
		for j=1, activeBlock[height] do
			if activeBlock[piece][i][j] then
				if board[activeBlock[col]+i-1]~=nil then
					if board[activeBlock[col]+i-1][activeBlock[row]+j-2]~=nil then
						if board[activeBlock[col]+i-1][activeBlock[row]+j-2]==activeBlock[color] then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

--Returns true if a block can't slide to the left
function checkBlockedLeft(activeBlock)
	if activeBlock[col] < 2 then
		return true
	end
	for i=1,activeBlock[width] do
		for j=1,activeBlock[height] do
			if activeBlock[piece][i][j] then
				if board[activeBlock[col]+i-2]~=nil then
					if board[activeBlock[col]+i-2][activeBlock[row]+j-1]~=nil then
						if board[activeBlock[col]+i-2][activeBlock[row]+j-1]==activeBlock[color] then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

--Returns true if a block can't slide to the right
function checkBlockedRight(activeBlock)
	if activeBlock[col] + activeBlock[width] > boardX then
		return true
	end
	for i=1,activeBlock[width] do
		for j=1,activeBlock[height] do
			if activeBlock[piece][i][j] then
				if board[activeBlock[col]+i]~=nil then
					if board[activeBlock[col]+i][activeBlock[row]+j-1]~=nil then
						if board[activeBlock[col]+i][activeBlock[row]+j-1]==activeBlock[color] then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

--Returns true if a block is in a legal position
function checkLegal(blockToCheck)
	for i=1,blockToCheck[width] do
		for j=1,blockToCheck[height] do
			if blockToCheck[piece][i][j] then
				if board[blockToCheck[col]+i-1] == nil then
					return false
				elseif board[blockToCheck[col]+i-1][blockToCheck[row]+j-1] == nil then
					return false
				elseif board[blockToCheck[col]+i-1][blockToCheck[row]+j-1]==blockToCheck[color] then
					return false
				end
			end
		end
	end
	return true
end

--Attempts to rotate a piece clockwise, does nothing if illegal
function attemptRotation(activeBlock)
	--No sense rotating the box piece
	if activeBlock[shape] == pieceO then
		return activeBlock
	end
	
	local newBlock = {}
	newBlock[piece] = {}
	newBlock[shape] = activeBlock[shape]
	newBlock[color] = activeBlock[color]
	newBlock[rotation] = activeBlock[rotation]+1
	if newBlock[rotation] == 5 then
		newBlock[rotation] = 1
	end

	if activeBlock[shape] == pieceI or activeBlock[shape] == pieceS or activeBlock[shape] == pieceZ then
		if activeBlock[rotation] == 1 then
			newBlock[col] = activeBlock[col]-math.floor((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.ceil((activeBlock[width]-activeBlock[height])/2)
		elseif activeBlock[rotation] == 2 then
			newBlock[col] = activeBlock[col]-math.ceil((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.floor((activeBlock[width]-activeBlock[height])/2)
		elseif activeBlock[rotation] == 3 then
			newBlock[col] = activeBlock[col]-math.floor((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.ceil((activeBlock[width]-activeBlock[height])/2)
		elseif activeBlock[rotation] == 4 then
			newBlock[col] = activeBlock[col]-math.ceil((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.floor((activeBlock[width]-activeBlock[height])/2)
		end
	else
		if activeBlock[rotation] == 1 then
			newBlock[col] = activeBlock[col]-math.floor((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.floor((activeBlock[width]-activeBlock[height])/2)
		elseif activeBlock[rotation] == 2 then
			newBlock[col] = activeBlock[col]-math.ceil((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.floor((activeBlock[width]-activeBlock[height])/2)
		elseif activeBlock[rotation] == 3 then
			newBlock[col] = activeBlock[col]-math.ceil((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.ceil((activeBlock[width]-activeBlock[height])/2)
		elseif activeBlock[rotation] == 4 then
			newBlock[col] = activeBlock[col]-math.floor((activeBlock[height]-activeBlock[width])/2)
			newBlock[row] = activeBlock[row]-math.ceil((activeBlock[width]-activeBlock[height])/2)
		end
	end
	
	newBlock[height] = activeBlock[width]
	newBlock[width] = activeBlock[height]
	
	for i=1,newBlock[width] do
		newBlock[piece][i] = {}
	end
	
	for i=1,activeBlock[width] do
		for j=1,activeBlock[height] do
			newBlock[piece][activeBlock[height]-j+1][i] = activeBlock[piece][i][j]
		end
	end
	
	if checkLegal(newBlock)==true then
		activeBlock = newBlock
	else
		bump(newBlock)
		if checkLegal(newBlock)==true then
			activeBlock = newBlock
		end
	end
	return activeBlock
end

--Attempts to 'bump' a piece back on to the board, to allow for more flexibility when rotating
function bump(blockToBump)
	if blockToBump[row] < 1 then
		blockToBump[row] = 1
	elseif (blockToBump[row]+blockToBump[height]-1) > boardY then
		blockToBump[row] = boardY-blockToBump[height]+1
	end
	
	if blockToBump[col] < 1 then
		blockToBump[col] = 1	
	elseif (blockToBump[col]+blockToBump[width]-1) > boardX then
		blockToBump[col] = boardX-blockToBump[width]+1
	end
end

--Puts a block on the board and gets a new block
function addBlockToBoard(activeBlock)
	for i=1,activeBlock[width] do
		for j=1,activeBlock[height] do
			if activeBlock[piece][i][j] then
				board[activeBlock[col]+i-1][activeBlock[row]+j-1] = activeBlock[color]
			end
		end
	end
end

--get a new block and gameOve check
function placeNewBlock1()	
	activeBlock = queueBlock
	
	--Check to see if game is over
	if checkLegal(activeBlock)==false then
		gameOver = true
	end
	
	queueBlock = getNewBlock()
	increaseDifficulty()
end

--get a new block and gameOve check
function placeNewBlock2()
	activeBlock2 = queueBlock2
	
	--Check to see if game is over
	if checkLegal(activeBlock2)==false then
		gameOver = true
	end
	
	queueBlock2 = getNewBlock(true)
	increaseDifficulty2()
end

--Updates current score and increase speed if appropriate
function increaseDifficulty()
	--If descentDelay isn't greater than minDelay, we're done increasing speed
	if descentDelay2 > minDelay then
		scoreThresholdTracker2 = scoreThresholdTracker2+1
		
		--Increase speed
		while scoreThresholdTracker2 >= scoreDelayThreshold do
			scoreThresholdTracker2 = scoreThresholdTracker2-scoreDelayThreshold
			descentDelay2 = descentDelay2-speedIncrease
		end
	end
end

--Updates current score and increase speed if appropriate
function increaseDifficulty2()		
	--If descentDelay isn't greater than minDelay, we're done increasing speed
	if descentDelay > minDelay then
		scoreThresholdTracker = scoreThresholdTracker+1
		
		--Increase speed
		while scoreThresholdTracker >= scoreDelayThreshold do
			scoreThresholdTracker = scoreThresholdTracker-scoreDelayThreshold
			descentDelay = descentDelay-speedIncrease
		end
	end
end

--Draws score to screen
function renderScore()
	local toPrint = "Time: " .. math.floor(score) .."." .. math.floor((score-math.floor(score))*10)
	local textWidth = medFont:getWidth(toPrint)
	local boardWidth = boardX*tileX
	
	love.graphics.setFont(medFont)
	love.graphics.print(toPrint, (boardWidth+screenX-textWidth)/2, 200)
end


--Draws "Next Pieces" to screen
function renderQueueTitle()
	local toPrint = "Next Pieces:"
	local textWidth = medFont:getWidth(toPrint)
	local boardWidth = boardX*tileX
	
	love.graphics.setFont(medFont)
	love.graphics.print(toPrint, (boardWidth+screenX-textWidth)/2, 304)
end

--Draws upcoming block
function renderQueueBlock(blockToDraw)
	local pieceToDraw = blockToDraw[piece]
	local x = blockToDraw[col] + 10
	local y = blockToDraw[row] -2	-- lower block position
	if y < 0 then
		y = 14	-- upper block position
	end 
	
	local centering = 0
	if blockToDraw[col] == 5 then
		if blockToDraw[width] > 2 then
			centering = -16
		end
	elseif blockToDraw[width] == 3 then
		centering = 16
	end

	for i=1,blockToDraw[width] do
		for j=1,blockToDraw[height] do
			if pieceToDraw[i][j] then
				love.graphics.draw(cubes[blockToDraw[color]], (tileX*(x+i-2))+centering, tileY*(y+j-2))
			end
			j=j+1
		end
		i=i+1
	end
end

--Run at the beginning of each game
function beginGame()
	board = createBoard()

	activeBlock = getNewBlock()
	queueBlock = getNewBlock()

	activeBlock2 = getNewBlock(true)
	queueBlock2 = getNewBlock(true)

	descentTimer = 0
	keyPressTimerL = 0
	keyPressTimerR = 0
	keyPressTimerU = 0
	keyPressTimerD = 0
	scoreThresholdTracker = 0
	descentDelay = descentDelayStart 

	descentTimer2 = 0
	keyPressTimerL2 = 0
	keyPressTimerR2 = 0
	keyPressTimerU2 = 0
	keyPressTimerD2 = 0
	scoreThresholdTracker2 = 0
	descentDelay2 = descentDelayStart
	
	score = 0
	gameOver = false
	gameState = play
	gameOverTimer = 0
end

--Run once at game start 
function love.load()
	createImages()
	createPieces()
	math.randomseed(os.time())
	smallFont = love.graphics.newFont("fonts/BAUHS93.TTF", 24)
	medFont = love.graphics.newFont("fonts/BAUHS93.TTF", 36)
	bigFont = love.graphics.newFont("fonts/BAUHS93.TTF", 48)
	
	beginGame()
end
