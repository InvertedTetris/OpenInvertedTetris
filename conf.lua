function love.conf( t )

	t.title = "Open Inverted Tetris"	-- The window title (string)
	t.author = "Todd Nelling and Lorenz Haspel"  -- The author of the game (string)

	--t.version = 0.80           	-- The L�VE version this game was made for (number)
	t.console = false           -- Attach a console (boolean, Windows only)
	t.window.fullwindow = false-- Enable fullwindow (boolean)
	t.window.vsync = true       -- Enable vertical sync (boolean)
	t.window.fsaa = 0           -- The number of FSAA-buffers (number)
	t.window.width = 640        -- The window width (number)
	t.window.height = 672		-- The window height (number)

	t.modules.joystick = false   -- Enable the joystick module (boolean)
	t.modules.audio = false      -- Enable the audio module (boolean)
	t.modules.keyboard = true   -- Enable the keyboard module (boolean)
	t.modules.event = true      -- Enable the event module (boolean)
	t.modules.image = true      -- Enable the image module (boolean)
	t.modules.graphics = true   -- Enable the graphics module (boolean)
	t.modules.timer = true      -- Enable the timer module (boolean)
	t.modules.mouse = false      -- Enable the mouse module (boolean)
	t.modules.sound = false      -- Enable the sound module (boolean)
	t.modules.physics = false   -- Enable the physics module (boolean)

end
