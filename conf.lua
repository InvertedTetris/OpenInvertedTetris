function love.conf( t )


	t.title = "Open Inverted Tetris"	-- The window title (string)
	t.author = "Lorenz Haspel and Todd Nelling"  -- The author of the game (string)

    t.identity = nil                   -- The name of the save directory (string)
	t.version = "0.9.2"           	-- The LÖVE version this game was made for (number)
	t.console = false           -- Attach a console (boolean, Windows only)

	t.window.fullwindow = false-- Enable fullwindow (boolean)
	t.window.vsync = true       -- Enable vertical sync (boolean)
	t.window.fsaa = 0           -- The number of FSAA-buffers (number)
	t.window.width = 640        -- The window width (number)
	t.window.height = 672		-- The window height (number)

	t.modules.keyboard = true   -- Enable the keyboard module (boolean)
	t.modules.event = true      -- Enable the event module (boolean)
	t.modules.image = true      -- Enable the image module (boolean)
	t.modules.graphics = true   -- Enable the graphics module (boolean)
	t.modules.timer = true      -- Enable the timer module (boolean)
	t.modules.joystick = false   -- Enable the joystick module (boolean)
	t.modules.audio = false      -- Enable the audio module (boolean)
	t.modules.mouse = false      -- Enable the mouse module (boolean)
	t.modules.sound = false      -- Enable the sound module (boolean)
	t.modules.physics = false   -- Enable the physics module (boolean)

    t.icon = nil                       -- The path to the executable icons (string)
    t.email = "inverted_tetris@web.de" -- The email of the author (string)
    t.url = nil                        -- The website of the game (string)
    t.description = "A tribute to the (no longer existing) flashgame Inverted. Your goal in this awesome spin on Tetris is to practice your multi-tasking abilities. You must avoid letting the blocks hit the top or the bottom for as long as possible. Use the ARROW KEYS to control top half of the game and use WASD KEYS to control bottom half of the game. Good luck!"

    -- OS to release your game on. Use a table if you want to overwrite the options, or just the OS name.
    -- Available OS are "love", "windows", "osx", "debian" and "android".
    -- A LÖVE file is created if none is specified.
    t.os = {
        "love",
        windows = {
            x32       = true,
            x64       = true,
            installer = false,
            appid     = nil,
        },
        "osx",
        "debian",
        --"android",
    }


end
