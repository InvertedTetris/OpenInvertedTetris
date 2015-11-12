function love.conf( t )

	t.title = "Tetris"			-- The window title (string)
	t.author = "Todd Nelling and Oren"  -- The author of the game (string)

	t.version = 0.72            -- The L�VE version this game was made for (number)
	t.console = false           -- Attach a console (boolean, Windows only)
	t.screen.fullscreen = false -- Enable fullscreen (boolean)
	t.screen.vsync = true       -- Enable vertical sync (boolean)
	t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
	t.screen.width = 576        -- The window width (number)
	t.screen.height = 480       -- The window height (number)

	t.modules.joystick = true   -- Enable the joystick module (boolean)
	t.modules.audio = true      -- Enable the audio module (boolean)
	t.modules.keyboard = true   -- Enable the keyboard module (boolean)
	t.modules.event = true      -- Enable the event module (boolean)
	t.modules.image = true      -- Enable the image module (boolean)
	t.modules.graphics = true   -- Enable the graphics module (boolean)
	t.modules.timer = true      -- Enable the timer module (boolean)
	t.modules.mouse = true      -- Enable the mouse module (boolean)
	t.modules.sound = true      -- Enable the sound module (boolean)
	t.modules.physics = false   -- Enable the physics module (boolean)

end