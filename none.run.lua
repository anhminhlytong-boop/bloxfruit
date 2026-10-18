do -- [patched] bo guard chong tamper, chay thang than script
	local fn = cloneref or function(arg)
		return arg
	end

	while true do
		task.wait()
		if not (game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")) then
			continue
		end
		break
	end

	local v = fn(game:GetService("Players"))

	if v.LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
		if not getgenv().Team or getgenv().Team == "" then
			getgenv().Team = "Pirates"
		end

		local container = v.LocalPlayer.PlayerGui["Main (minimal)"]:WaitForChild("ChooseTeam"):WaitForChild("Container")
		local textButton = nil

		if getgenv().Team == "Pirates" then
			textButton = container:WaitForChild("Pirates"):WaitForChild("Frame"):WaitForChild("TextButton")
		elseif getgenv().Team == "Marines" then
			textButton = container:WaitForChild("Marines"):WaitForChild("Frame"):WaitForChild("TextButton")
		end

		if textButton then
			repeat
				task.wait()

				pcall(function()
					firesignal(textButton.Activated)
				end)
			until not v.LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
		end
	end

	repeat
		task.wait()
	until v.LocalPlayer.PlayerGui:FindFirstChild("Main")

	-- [patched] bo chan "already running"
	getgenv().QuantumOnyxActive = true
	local request_ = nil

	if syn and syn.request then
		request_ = syn.request
	elseif http_request then
		request_ = http_request
	elseif http and http.request then
		request_ = http.request
	else
		request_ = request or httprequest or request_
	end

	local function fn2(arg)
		if not request_ then
			return nil
		end
		return request_(arg)
	end

	local config = {
		AutoAttack = true,
		FastSettings = "Fast Attack",
		FastAttackDelay = 0,
		attackmobs = true,
		BringMonster = true,
		BringMonsterRadius = 250,
		MasteryFarm = false,
		HealthMob = 50,
		HopDelay = 10,
		StopHopEliteIfChalice = true,
	}

	local hub = {
		Services = {},
		Player = {},
		Environment = {},
		Remotes = {},
		Modules = {},
		Preload = {},
		Cache = {},
		Runtime = {},
		Performance = {},
		Webhook = {},
	}

	setmetatable(hub.Services, { __index = function(arg, arg2)
		local ok, result = pcall(game.GetService, game, arg2)

		if ok and result then
			local v2 = fn(result)
			rawset(arg, arg2, v2)
			return v2
		end

		return nil
	end })

	local v2 = fn(game:GetService("Workspace"))
	local v3 = fn(game:GetService("Players"))
	local RS = fn(game:GetService("ReplicatedStorage"))
	local v5 = fn(game:GetService("CollectionService"))
	local v6 = fn(game:GetService("RunService"))
	local LightingSvc = fn(game:GetService("Lighting"))
	local v8 = fn(game:GetService("VirtualInputManager"))
	local v9 = fn(game:GetService("HttpService"))
	local v10 = fn(game:GetService("UserInputService"))
	local v11 = fn(game:GetService("LogService"))
	local v12 = fn(game:GetService("ScriptContext"))
	local v13 = fn(game:GetService("StarterGui"))
	local v14 = fn(game:GetService("Stats"))
	local v15 = fn(game:GetService("TeleportService"))
	local v16 = fn(game:GetService("GuiService"))
	local v17 = fn(game:GetService("VirtualUser"))
	hub.Services.Workspace = v2
	hub.Services.Players = v3
	hub.Services.ReplicatedStorage = RS
	hub.Services.CollectionService = v5
	hub.Services.RunService = v6
	hub.Services.Lighting = LightingSvc
	hub.Services.VirtualInputManager = v8
	hub.Services.HttpService = v9
	hub.Services.UserInputService = v10
	hub.Services.LogService = v11
	hub.Services.ScriptContext = v12
	hub.Services.StarterGui = v13
	hub.Services.Stats = v14
	hub.Services.TeleportService = v15
	hub.Services.GuiService = v16
	hub.Services.VirtualUser = v17
	local tbl3 = {}
	local tbl4 = {}
	local obj = setmetatable({}, { __mode = "k" })
	local tbl5 = {}
	local obj2 = setmetatable({}, { __mode = "k" })
	local obj3 = setmetatable({}, { __mode = "k" })
	local localPlayer = v3.LocalPlayer
	local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid", 10)
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
	local data = localPlayer:WaitForChild("Data")
	local level = data:WaitForChild("Level")
	local fragments = data:WaitForChild("Fragments")
	local beli = data:WaitForChild("Beli")

	hub.Player = {
		LocalPlayer = localPlayer,
		Character = character,
		Humanoid = humanoid,
		HumanoidRootPart = humanoidRootPart,
		Data = data,
		Level = level,
		Fragments = fragments,
		Beli = beli,
		Money = beli,
	}

	localPlayer.CharacterAdded:Connect(function(character2)
		if not character2 then
			return
		end
		character = character2
		humanoid = character2:WaitForChild("Humanoid", 10)
		humanoidRootPart = character2:WaitForChild("HumanoidRootPart", 10)
		hub.Player.Character = character2
		hub.Player.Humanoid = humanoid
		hub.Player.HumanoidRootPart = humanoidRootPart
	end)

	local enemies = v2:WaitForChild("Enemies")
	local seaBeasts = v2:WaitForChild("SeaBeasts")
	local boats = v2:WaitForChild("Boats")
	local map = v2:WaitForChild("Map")
	local worldOrigin = v2:WaitForChild("_WorldOrigin")
	local attribute = v2:GetAttribute("MAP")
	local flag = attribute == "Sea1"
	local isSea2 = attribute == "Sea2"
	local isSea3 = attribute == "Sea3"

	hub.Environment = {
		Workspace = v2,
		Enemies = enemies,
		SeaBeasts = seaBeasts,
		Boats = boats,
		Map = map,
		WorldOrigin = worldOrigin,
		MAPA = attribute,
		Sea_1 = flag,
		Sea_2 = isSea2,
		Sea_3 = isSea3,
	}

	local remotes = RS:WaitForChild("Remotes")
	local commF = remotes:WaitForChild("CommF_")
	local commE = RS.Remotes.CommE
	local modules = RS:WaitForChild("Modules")
	local net = modules:WaitForChild("Net")
	hub.Remotes = { Remotes = remotes, CommF_ = commF, CommE = commE, Modules = modules, Net = net }
	local GuideModule = require(RS:WaitForChild("GuideModule"))
	local GetWaterHeightAtLocation = require(RS.Util.GetWaterHeightAtLocation)
	local DangerDistance = require(RS.DangerDistance)
	local Net = require(game.ReplicatedStorage.Modules.Net)
	local ItemConfig = require(game.ReplicatedStorage.ItemConfig)

	pcall(function()
		local CombatUtil = require(RS:WaitForChild("Modules"):WaitForChild("CombatUtil"))

		if CombatUtil and CombatUtil.CanAttack and hookfunction then
			hookfunction(CombatUtil.CanAttack, function()
				return true
			end)
		end
	end)

	hub.Modules = { GuideModule = GuideModule, GetWaterHeight = GetWaterHeightAtLocation, DangerDistance = DangerDistance, Net3 = Net, ItemConfig = ItemConfig }
	local str = "https://api.quantumonyx.cc"
	local str2 = "QnTmOnyX"

	local function fn3(arg, arg2)
		return (arg - ("QnTmOnyX"):byte((arg2 - 1) % #str2 + 1) - arg2) % 32
	end

	local function fn4(arg)
		local str3 = arg:gsub("^%.", ""):gsub("%.$", "")
		local mods = {}
		local n = 0

		for i = 1, #str3 do
			n += 1

			if n % 5 ~= 0 then
				table.insert(mods, str3:sub(i, i))
			end
		end

		local str4 = table.concat(mods)
		local tbl7 = {}
		local n2 = 1
		local n3 = 1

		while n2 <= #str4 do
			local str5 = str4:sub(n2, n2)
			local str6 = str4:sub(n2 + 1, n2 + 1)
			local n4 = ("kQ9mZ2xW7nR4vB1jY6tF3hD8pL5cG0sA"):find(str5, 1, true) - 1
			local n5 = ("kQ9mZ2xW7nR4vB1jY6tF3hD8pL5cG0sA"):find(str6, 1, true) - 1
			table.insert(tbl7, string.char(fn3(n4, n3) + fn3(n5, n3 + 100) * 32))
			n2 += 2
			n3 += 1
		end

		return table.concat(tbl7)
	end

	local str3 = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/main/"
	local mods = {}
	local tbl7 = {}

	local function fn5(arg, arg2)
		local n = arg2 or 2
		local v19 = arg
		if v19 and tbl7[v19] then
			return tbl7[v19]
		end

		if arg then
			for i = 1, n do
				local ok, result = pcall(function()
					local response = game:HttpGet(str3 .. arg)

					if response and #response > 0 and not response:sub(1, 20):find("404") and not response:find("404: Not Found", 1, true) then
						local chunk = loadstring(response)
						if chunk then
							return chunk()
						end
					end
				end)

				if ok and result ~= nil then
					if v19 then
						tbl7[v19] = result
					end

					return result
				end

				if i < n then
					task.wait(0.3)
				end
			end
		end

		return nil
	end

	local lua = fn5("Util/BloxFruitModule/Preload/Data.lua") or {}
	local lua2 = fn5("Util/BloxFruitModule/Preload/Visuals.lua") or {}
	-- [patched] Onyx UI: thu vien GUI noi bo, khong con load remote
	local OnyxUI = function()
	--[[ ==================================================================
	     Onyx UI  --  minimal, scroll-first replacement GUI library
	     Same API surface as the old remote lib, but:
	       * real scrolling (vertical per tab, horizontal tab bar)
	       * canvas height computed explicitly, so it cannot get stuck at 0
	       * no key gate, no "locked" feature, no remote dependency
	       * large touch targets, flat/basic layout
	     ================================================================== ]]

	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local TextService = game:GetService("TextService")

	local player = Players.LocalPlayer
	local function getPlayer()
		return player or Players.LocalPlayer
	end

	local T = {
		bg      = Color3.fromRGB(13, 13, 17),
		panel   = Color3.fromRGB(19, 19, 25),
		card    = Color3.fromRGB(27, 27, 35),
		card2   = Color3.fromRGB(36, 36, 46),
		stroke  = Color3.fromRGB(46, 46, 58),
		text    = Color3.fromRGB(238, 238, 246),
		dim     = Color3.fromRGB(148, 148, 164),
		accent  = Color3.fromRGB(152, 92, 255),
		accent2 = Color3.fromRGB(198, 158, 255),
	}

	local FONT   = Enum.Font.GothamMedium
	local FONT_B = Enum.Font.GothamBold

	-- ---------------------------------------------------------------- utils

	local function corner(obj, r)
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, r or 8)
		c.Parent = obj
		return c
	end

	local function stroke(obj, col, th)
		local s = Instance.new("UIStroke")
		s.Color = col or T.stroke
		s.Thickness = th or 1
		s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		s.Parent = obj
		return s
	end

	local function padding(obj, l, t, r, b)
		local p = Instance.new("UIPadding")
		p.PaddingLeft   = UDim.new(0, l or 0)
		p.PaddingTop    = UDim.new(0, t or 0)
		p.PaddingRight  = UDim.new(0, r or 0)
		p.PaddingBottom = UDim.new(0, b or 0)
		p.Parent = obj
		return p
	end

	local function listLayout(obj, gap, dir)
		local l = Instance.new("UIListLayout")
		l.FillDirection = dir or Enum.FillDirection.Vertical
		l.Padding = UDim.new(0, gap or 6)
		l.SortOrder = Enum.SortOrder.LayoutOrder
		l.HorizontalAlignment = Enum.HorizontalAlignment.Left
		l.VerticalAlignment = Enum.VerticalAlignment.Top
		l.Parent = obj
		return l
	end

	local function textLabel(parent, txt, size, color, bold)
		local t = Instance.new("TextLabel")
		t.BackgroundTransparency = 1
		t.BorderSizePixel = 0
		t.Text = txt or ""
		t.TextSize = size or 13
		t.TextColor3 = color or T.text
		t.Font = bold and FONT_B or FONT
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.TextYAlignment = Enum.TextYAlignment.Center
		t.RichText = true
		t.Parent = parent
		return t
	end

	local function measure(txt, size, bold)
		local ok, res = pcall(function()
			return TextService:GetTextSize(txt, size, bold and FONT_B or FONT, Vector2.new(4000, 200))
		end)
		if ok and res then
			return res.X
		end
		return #tostring(txt) * (size * 0.62)
	end

	local function tween(obj, props, time)
		local ok, tw = pcall(function()
			return TweenService:Create(obj, TweenInfo.new(time or 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
		end)
		if ok and tw then
			tw:Play()
		end
	end

	-- ------------------------------------------------ the scroll fix itself
	-- Two things break scrolling on this GUI:
	--   1. AutomaticCanvasSize never recomputes for a frame that was
	--      invisible while its children were added -> canvas stays 0x0
	--      and there is literally nothing to scroll.
	--   2. Wrong ScrollingDirection / ScrollingEnabled.
	-- So: compute CanvasSize from the UIListLayout explicitly, and keep
	-- recomputing it. Native engine scrolling then does the rest (touch,
	-- mouse drag and wheel all work without extra code).

	local ScrollRefresh = setmetatable({}, { __mode = "k" })

	local function makeScrollable(sf, axis)
		sf.BorderSizePixel = 0
		sf.BackgroundTransparency = 1
		sf.ClipsDescendants = true
		sf.ScrollingEnabled = true
		sf.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		sf.ScrollBarThickness = 4
		sf.ScrollBarImageColor3 = T.accent
		sf.ScrollBarImageTransparency = 0.4
		sf.AutomaticCanvasSize = Enum.AutomaticSize.None

		if axis == "X" then
			sf.ScrollingDirection = Enum.ScrollingDirection.X
			sf.CanvasSize = UDim2.new(0, 0, 0, 0)
		else
			sf.ScrollingDirection = Enum.ScrollingDirection.Y
			sf.CanvasSize = UDim2.new(0, 0, 0, 0)
		end

		sf.CanvasPosition = Vector2.new(0, 0)

		local function recompute()
			if not sf.Parent then
				return
			end

			local layout = sf:FindFirstChildOfClass("UIListLayout")
			if not layout then
				return
			end

			local pad = sf:FindFirstChildOfClass("UIPadding")
			local pl = pad and pad.PaddingLeft.Offset or 0
			local pr = pad and pad.PaddingRight.Offset or 0
			local pt = pad and pad.PaddingTop.Offset or 0
			local pb = pad and pad.PaddingBottom.Offset or 0

			local cs = layout.AbsoluteContentSize

			if axis == "X" then
				local w = math.floor(cs.X + pl + pr)
				if w < 1 then
					w = 1
				end
				-- Y scale 1 keeps children vertically aligned to the bar
				sf.CanvasSize = UDim2.new(0, w, 1, 0)
			else
				local h = math.floor(cs.Y + pt + pb)
				if h < 1 then
					h = 1
				end
				-- X scale 1 so children with Size X = 1 always fill the frame
				sf.CanvasSize = UDim2.new(1, 0, 0, h)
			end
		end

		ScrollRefresh[sf] = recompute

		task.defer(function()
			local layout = sf:FindFirstChildOfClass("UIListLayout")
			if layout then
				layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(recompute)
			end
			sf.ChildAdded:Connect(function()
				task.defer(recompute)
			end)
			sf.ChildRemoved:Connect(function()
				task.defer(recompute)
			end)
			recompute()
		end)

		-- slow safety poll: covers layout changes that never fire a signal
		task.spawn(function()
			for _ = 1, 20 do
				task.wait(0.4)
				if not sf.Parent then
					return
				end
				recompute()
			end
		end)

		return sf
	end

	-- ------------------------------------------------------------- the GUI

	local function buildScreenGui(name)
		local p = getPlayer()
		if not p then
			return nil
		end
		local pg = p:WaitForChild("PlayerGui")
		local old = pg:FindFirstChild(name)
		if old then
			pcall(function()
				old:Destroy()
			end)
		end

		local gui = Instance.new("ScreenGui")
		gui.Name = name
		gui.ResetOnSpawn = false
		gui.IgnoreGuiInset = false
		gui.DisplayOrder = 9999
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		gui.Parent = pg
		return gui
	end

	-- ============================================================ Notifications

	local NotifyHolder = nil

	local function notifyHolder(gui)
		if NotifyHolder and NotifyHolder.Parent then
			return NotifyHolder
		end

		local h = Instance.new("Frame")
		h.Name = "OnyxNotify"
		h.BackgroundTransparency = 1
		h.AnchorPoint = Vector2.new(1, 0)
		h.Position = UDim2.new(1, -10, 0, 10)
		h.Size = UDim2.new(0, 250, 0, 0)
		h.AutomaticSize = Enum.AutomaticSize.Y
		h.ZIndex = 50
		h.Parent = gui
		listLayout(h, 8, Enum.FillDirection.Vertical)

		NotifyHolder = h
		return h
	end

	local Notification = {}

	function Notification:Notify(data, opts)
		data = data or {}
		opts = opts or {}

		local gui = self.__gui
		if not gui or not gui.Parent then
			return
		end

		local holder = notifyHolder(gui)

		local card = Instance.new("Frame")
		card.BackgroundColor3 = T.card
		card.BorderSizePixel = 0
		card.Size = UDim2.new(1, 0, 0, 0)
		card.AutomaticSize = Enum.AutomaticSize.Y
		card.ZIndex = 51
		card.Parent = holder
		corner(card, 10)
		stroke(card, T.stroke)
		padding(card, 14, 9, 10, 9)

		local accentBar = Instance.new("Frame")
		accentBar.BackgroundColor3 = T.accent
		accentBar.BorderSizePixel = 0
		accentBar.Size = UDim2.new(0, 3, 1, -8)
		accentBar.Position = UDim2.new(0, -8, 0, 4)
		accentBar.ZIndex = 52
		accentBar.Parent = card
		corner(accentBar, 2)

		local inner = Instance.new("Frame")
		inner.BackgroundTransparency = 1
		inner.Size = UDim2.new(1, 0, 0, 0)
		inner.AutomaticSize = Enum.AutomaticSize.Y
		inner.ZIndex = 52
		inner.Parent = card
		listLayout(inner, 3)

		local title = textLabel(inner, data.Title or "Notice", 13, T.text, true)
		title.Size = UDim2.new(1, 0, 0, 0)
		title.AutomaticSize = Enum.AutomaticSize.Y
		title.TextWrapped = true
		title.ZIndex = 53

		local desc = textLabel(inner, data.Description or "", 12, T.dim, false)
		desc.Size = UDim2.new(1, 0, 0, 0)
		desc.AutomaticSize = Enum.AutomaticSize.Y
		desc.TextWrapped = true
		desc.ZIndex = 53

		if data.Buttons and #data.Buttons > 0 then
			local row = Instance.new("Frame")
			row.BackgroundTransparency = 1
			row.Size = UDim2.new(1, 0, 0, 26)
			row.ZIndex = 53
			row.Parent = inner
			listLayout(row, 6, Enum.FillDirection.Horizontal)

			for _, b in ipairs(data.Buttons) do
				local btn = Instance.new("TextButton")
				btn.AutoButtonColor = false
				btn.BackgroundColor3 = T.card2
				btn.BorderSizePixel = 0
				btn.Text = ""
				btn.Size = UDim2.new(0, measure(b.Text or "OK", 12, false) + 22, 1, 0)
				btn.ZIndex = 54
				btn.Parent = row
				corner(btn, 6)

				local lb = textLabel(btn, b.Text or "OK", 12, T.text, false)
				lb.Size = UDim2.new(1, 0, 1, 0)
				lb.TextXAlignment = Enum.TextXAlignment.Center
				lb.ZIndex = 55

				btn.MouseButton1Click:Connect(function()
					if type(b.Callback) == "function" then
						pcall(b.Callback)
					end
					pcall(function()
						card:Destroy()
					end)
				end)
			end
		end

		local life = tonumber(opts.Time) or tonumber(opts.time) or 5
		if life > 0 then
			task.delay(life, function()
				if card and card.Parent then
					pcall(function()
						card:Destroy()
					end)
				end
			end)
		end

		return card
	end

	-- ============================================================ Containers

	local containerProto = {}
	containerProto.__index = containerProto

	local function elementRow(container, height)
		local f = Instance.new("Frame")
		f.BackgroundTransparency = 1
		f.BorderSizePixel = 0
		f.Size = UDim2.new(1, 0, 0, height or 34)
		f.Parent = container.body
		return f
	end

	function containerProto:addLabel(title, desc)
		local row = elementRow(self, 0)
		row.AutomaticSize = Enum.AutomaticSize.Y
		listLayout(row, 2)

		local t = textLabel(row, title or "", 12, T.text, true)
		t.Size = UDim2.new(1, 0, 0, 0)
		t.AutomaticSize = Enum.AutomaticSize.Y
		t.TextWrapped = true

		local d = textLabel(row, desc or "", 11, T.dim, false)
		d.Size = UDim2.new(1, 0, 0, 0)
		d.AutomaticSize = Enum.AutomaticSize.Y
		d.TextWrapped = true

		local api = { Frame = row, Label = d }
		function api:RefreshDesc(txt)
			d.Text = tostring(txt or "")
		end
		function api:Refresh(txt)
			d.Text = tostring(txt or "")
		end
		function api:SetDesc(txt)
			d.Text = tostring(txt or "")
		end
		return api
	end

	function containerProto:addButton(label, callback)
		local btn = Instance.new("TextButton")
		btn.AutoButtonColor = false
		btn.BackgroundColor3 = T.card
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.Size = UDim2.new(1, 0, 0, 32)
		btn.Parent = self.body
		corner(btn, 7)
		stroke(btn, T.stroke)

		local lb = textLabel(btn, label or "Button", 12, T.text, false)
		lb.Size = UDim2.new(1, -20, 1, 0)
		lb.Position = UDim2.new(0, 10, 0, 0)
		lb.TextTruncate = Enum.TextTruncate.AtEnd

		local function paint(c)
			btn.BackgroundColor3 = c
		end

		btn.MouseEnter:Connect(function()
			paint(T.card2)
		end)
		btn.MouseLeave:Connect(function()
			paint(T.card)
		end)
		btn.MouseButton1Down:Connect(function()
			paint(T.accent)
		end)
		btn.MouseButton1Up:Connect(function()
			paint(T.card2)
		end)
		btn.MouseButton1Click:Connect(function()
			if type(callback) == "function" then
				local ok, err = pcall(callback)
				if not ok then
					warn("[Onyx UI] button error: " .. tostring(err))
				end
			end
		end)

		local api = { Frame = btn, Button = btn }
		function api:Set(txt)
			lb.Text = tostring(txt or "")
		end
		return api
	end

	function containerProto:addButtonGrid(title, grid)
		if title and title ~= "" then
			local h = textLabel(self.body, title, 12, T.accent2, true)
			h.Size = UDim2.new(1, 0, 0, 16)
		end

		local holder = Instance.new("Frame")
		holder.BackgroundTransparency = 1
		holder.Size = UDim2.new(1, 0, 0, 0)
		holder.AutomaticSize = Enum.AutomaticSize.Y
		holder.Parent = self.body

		local gl = Instance.new("UIGridLayout")
		gl.CellSize = UDim2.new(0.5, -3, 0, 30)
		gl.CellPadding = UDim2.new(0, 6, 0, 6)
		gl.SortOrder = Enum.SortOrder.LayoutOrder
		gl.Parent = holder

		local n = 0
		for _, item in ipairs(grid or {}) do
			n = n + 1
			local b = Instance.new("TextButton")
			b.AutoButtonColor = false
			b.BackgroundColor3 = T.card
			b.BorderSizePixel = 0
			b.Text = ""
			b.LayoutOrder = n
			b.Parent = holder
			corner(b, 7)
			stroke(b, T.stroke)

			local lb = textLabel(b, item.Label or "?", 11, T.text, false)
			lb.Size = UDim2.new(1, -12, 1, 0)
			lb.Position = UDim2.new(0, 6, 0, 0)
			lb.TextTruncate = Enum.TextTruncate.AtEnd
			lb.TextXAlignment = Enum.TextXAlignment.Center

			local cb = item.Callback
			b.MouseButton1Click:Connect(function()
				if type(cb) == "function" then
					local ok, err = pcall(cb)
					if not ok then
						warn("[Onyx UI] grid button error: " .. tostring(err))
					end
				end
			end)
			b.MouseEnter:Connect(function()
				b.BackgroundColor3 = T.card2
			end)
			b.MouseLeave:Connect(function()
				b.BackgroundColor3 = T.card
			end)
		end

		return { Frame = holder }
	end

	function containerProto:addToggle(label, default, callback, locked, description, flag)
		local row = elementRow(self, description and 48 or 34)

		local lb = textLabel(row, label or "Toggle", 12, T.text, false)
		lb.Size = UDim2.new(1, -56, 0, description and 22 or 34)
		lb.Position = UDim2.new(0, 0, 0, 0)
		lb.TextTruncate = Enum.TextTruncate.AtEnd

		if description then
			local d = textLabel(row, description, 10, T.dim, false)
			d.Size = UDim2.new(1, -56, 0, 14)
			d.Position = UDim2.new(0, 0, 0, 22)
			d.TextTruncate = Enum.TextTruncate.AtEnd
		end

		local track = Instance.new("Frame")
		track.BackgroundColor3 = T.card2
		track.BorderSizePixel = 0
		track.Size = UDim2.new(0, 40, 0, 21)
		track.AnchorPoint = Vector2.new(1, 0.5)
		track.Position = UDim2.new(1, 0, 0.5, 0)
		track.Parent = row
		corner(track, 11)
		stroke(track, T.stroke)

		local knob = Instance.new("Frame")
		knob.BackgroundColor3 = T.dim
		knob.BorderSizePixel = 0
		knob.Size = UDim2.new(0, 15, 0, 15)
		knob.AnchorPoint = Vector2.new(0, 0.5)
		knob.Position = UDim2.new(0, 3, 0.5, 0)
		knob.Parent = track
		corner(knob, 8)

		local state = false

		local function paint(on)
			tween(knob, { Position = UDim2.new(0, on and 22 or 3, 0.5, 0) }, 0.14)
			tween(track, { BackgroundColor3 = on and T.accent or T.card2 }, 0.14)
			tween(knob, { BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or T.dim }, 0.14)
		end

		local function apply(v)
			state = v and true or false
			paint(state)
		end

		apply(default)

		local hit = Instance.new("TextButton")
		hit.BackgroundTransparency = 1
		hit.Text = ""
		hit.Size = UDim2.new(1, 0, 1, 0)
		hit.Parent = row

		hit.MouseButton1Click:Connect(function()
			state = not state
			paint(state)
			if type(callback) == "function" then
				local ok, err = pcall(callback, state)
				if not ok then
					warn("[Onyx UI] toggle error: " .. tostring(err))
				end
			end
		end)

		local api = { Frame = row, Toggle = hit }
		function api:Update(v)
			apply(v)
		end
		function api:Set(v)
			apply(v)
		end
		function api:Get()
			return state
		end
		return api
	end

	-- ---- dropdown (expands inline, so it never gets clipped)

	local function normalizeOptions(options)
		local out = {}
		if type(options) ~= "table" then
			return out
		end

		local isArray = true
		for k in pairs(options) do
			if type(k) ~= "number" then
				isArray = false
				break
			end
		end

		if isArray then
			for _, v in ipairs(options) do
				table.insert(out, tostring(v))
			end
		else
			local keys = {}
			for k in pairs(options) do
				table.insert(keys, tostring(k))
			end
			table.sort(keys)
			for _, k in ipairs(keys) do
				local v = options[k]
				if type(v) == "string" then
					table.insert(out, v)
				else
					table.insert(out, k)
				end
			end
		end

		return out
	end

	function containerProto:addDropdown(label, default, options, callback, locked, extra, flag)
		local multi = (extra == true)

		local outer = elementRow(self, 34)
		outer.ClipsDescendants = true

		local head = Instance.new("TextButton")
		head.AutoButtonColor = false
		head.BackgroundColor3 = T.card
		head.BorderSizePixel = 0
		head.Text = ""
		head.Size = UDim2.new(1, 0, 0, 34)
		head.Parent = outer
		corner(head, 7)
		stroke(head, T.stroke)

		local lb = textLabel(head, label or "Select", 12, T.text, false)
		lb.Size = UDim2.new(1, -70, 1, 0)
		lb.Position = UDim2.new(0, 10, 0, 0)
		lb.TextTruncate = Enum.TextTruncate.AtEnd

		local val = textLabel(head, "", 11, T.accent2, false)
		val.AnchorPoint = Vector2.new(1, 0.5)
		val.Position = UDim2.new(1, -10, 0.5, 0)
		val.Size = UDim2.new(0, 0, 1, 0)
		val.AutomaticSize = Enum.AutomaticSize.X
		val.TextXAlignment = Enum.TextXAlignment.Right
		val.TextTruncate = Enum.TextTruncate.AtEnd

		local body = Instance.new("Frame")
		body.BackgroundTransparency = 1
		body.BorderSizePixel = 0
		body.Position = UDim2.new(0, 0, 0, 36)
		body.Size = UDim2.new(1, 0, 0, 0)
		body.ClipsDescendants = true
		body.Visible = false
		body.Parent = outer
		listLayout(body, 3)

		local current = nil
		local selected = {}
		local expanded = false
		local listHeight = 0

		local function displayText()
			if multi then
				local n = 0
				local one = nil
				for k in pairs(selected) do
					n = n + 1
					one = k
				end
				if n == 0 then
					return "none"
				elseif n == 1 then
					return tostring(one)
				end
				return n .. " selected"
			end
			if current == nil then
				return "none"
			end
			return tostring(current)
		end

		local function setExpanded(on)
			expanded = on
			body.Visible = on
			local h = 34
			if on then
				h = 34 + listHeight + 4
			end
			outer.Size = UDim2.new(1, 0, 0, h)
		end

		local function commit(value)
			current = value
			val.Text = displayText()
			if type(callback) == "function" then
				local ok, err = pcall(callback, value)
				if not ok then
					warn("[Onyx UI] dropdown error: " .. tostring(err))
				end
			end
		end

		local function rebuild(opts)
			for _, c in ipairs(body:GetChildren()) do
				if c:IsA("TextButton") then
					c:Destroy()
				end
			end

			local list = normalizeOptions(opts)
			local n = 0
			for _, opt in ipairs(list) do
				n = n + 1
				local b = Instance.new("TextButton")
				b.AutoButtonColor = false
				b.BackgroundColor3 = T.card2
				b.BorderSizePixel = 0
				b.Text = ""
				b.Size = UDim2.new(1, -6, 0, 26)
				b.Position = UDim2.new(0, 3, 0, (n - 1) * 29)
				b.Parent = body
				corner(b, 6)

				local ob = textLabel(b, opt, 11, T.text, false)
				ob.Size = UDim2.new(1, -18, 1, 0)
				ob.Position = UDim2.new(0, 9, 0, 0)
				ob.TextTruncate = Enum.TextTruncate.AtEnd

				b.MouseButton1Click:Connect(function()
					if multi then
						if selected[opt] then
							selected[opt] = nil
						else
							selected[opt] = true
						end
						val.Text = displayText()
						if type(callback) == "function" then
							pcall(callback, selected)
						end
					else
						commit(opt)
						setExpanded(false)
					end
				end)
			end

			listHeight = math.min(n * 29, 150)
			if expanded then
				setExpanded(true)
			end
		end

		head.MouseButton1Click:Connect(function()
			setExpanded(not expanded)
		end)

		local initial = nil
		if type(default) == "number" then
			local list = normalizeOptions(options)
			initial = list[default] or tostring(default)
		elseif type(default) == "table" then
			for k, v in pairs(default) do
				if type(k) == "string" and v then
					selected[k] = true
				elseif type(v) == "string" then
					selected[v] = true
				end
			end
		elseif default ~= nil then
			initial = tostring(default)
		end

		rebuild(options)
		current = initial
		val.Text = displayText()

		local api = { Frame = outer, Button = head }
		function api:Refresh(opts)
			rebuild(opts)
		end
		function api:Set(v)
			commit(v)
		end
		function api:Get()
			if multi then
				return selected
			end
			return current
		end
		return api
	end

	-- ---- slider

	function containerProto:addSlider(label, min, max, default, callback, locked, step, flag)
		min = tonumber(min) or 0
		max = tonumber(max) or 100
		if max < min then
			min, max = max, min
		end
		step = tonumber(step) or 0

		local outer = elementRow(self, 44)

		local lb = textLabel(outer, label or "Slider", 12, T.text, false)
		lb.Size = UDim2.new(1, -70, 0, 18)
		lb.Position = UDim2.new(0, 0, 0, 0)
		lb.TextTruncate = Enum.TextTruncate.AtEnd

		local val = textLabel(outer, "", 11, T.accent2, false)
		val.AnchorPoint = Vector2.new(1, 0)
		val.Position = UDim2.new(1, 0, 0, 0)
		val.Size = UDim2.new(0, 0, 0, 18)
		val.AutomaticSize = Enum.AutomaticSize.X
		val.TextXAlignment = Enum.TextXAlignment.Right

		local track = Instance.new("Frame")
		track.BackgroundColor3 = T.card2
		track.BorderSizePixel = 0
		track.Size = UDim2.new(1, 0, 0, 5)
		track.Position = UDim2.new(0, 0, 0, 28)
		track.Parent = outer
		corner(track, 3)

		local fill = Instance.new("Frame")
		fill.BackgroundColor3 = T.accent
		fill.BorderSizePixel = 0
		fill.Size = UDim2.new(0, 0, 1, 0)
		fill.Parent = track
		corner(fill, 3)

		local knob = Instance.new("Frame")
		knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		knob.BorderSizePixel = 0
		knob.Size = UDim2.new(0, 13, 0, 13)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		knob.Position = UDim2.new(0, 0, 0.5, 0)
		knob.Parent = track
		corner(knob, 7)

		local value = math.clamp(tonumber(default) or min, min, max)

		local function fmt(v)
			if step >= 1 then
				return tostring(math.floor(v + 0.5))
			end
			return string.format("%.2f", v)
		end

		local function paint()
			local a = 0
			if max > min then
				a = (value - min) / (max - min)
			end
			fill.Size = UDim2.new(a, 0, 1, 0)
			knob.Position = UDim2.new(a, 0, 0.5, 0)
			val.Text = fmt(value)
		end

		local function setValue(v, fire)
			v = math.clamp(v, min, max)
			if step > 0 then
				v = min + math.floor((v - min) / step + 0.5) * step
				v = math.clamp(v, min, max)
			end
			value = v
			paint()
			if fire and type(callback) == "function" then
				local ok, err = pcall(callback, value)
				if not ok then
					warn("[Onyx UI] slider error: " .. tostring(err))
				end
			end
		end

		paint()

		local dragging = false

		local function fromInput(posX)
			local abs = track.AbsolutePosition.X
			local w = track.AbsoluteSize.X
			if w <= 0 then
				return
			end
			local a = math.clamp((posX - abs) / w, 0, 1)
			setValue(min + a * (max - min), true)
		end

		local hit = Instance.new("TextButton")
		hit.BackgroundTransparency = 1
		hit.Text = ""
		hit.Size = UDim2.new(1, 0, 1, 0)
		hit.Parent = outer

		hit.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				fromInput(input.Position.X)
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if not dragging then
				return
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch then
				fromInput(input.Position.X)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		local api = { Frame = outer, Slider = hit }
		function api:Set(v)
			setValue(tonumber(v) or min, false)
		end
		function api:Get()
			return value
		end
		return api
	end

	-- ---- textbox

	function containerProto:addTextbox(label, callback, placeholder, flag)
		local outer = elementRow(self, 48)

		local lb = textLabel(outer, label or "Input", 12, T.text, false)
		lb.Size = UDim2.new(1, 0, 0, 16)
		lb.Position = UDim2.new(0, 0, 0, 0)

		local box = Instance.new("TextBox")
		box.BackgroundColor3 = T.card
		box.BorderSizePixel = 0
		box.ClearTextOnFocus = false
		box.Text = ""
		box.PlaceholderText = placeholder or "type here..."
		box.PlaceholderColor3 = T.dim
		box.TextColor3 = T.text
		box.TextSize = 12
		box.Font = FONT
		box.TextXAlignment = Enum.TextXAlignment.Left
		box.Size = UDim2.new(1, 0, 0, 28)
		box.Position = UDim2.new(0, 0, 0, 18)
		box.Parent = outer
		corner(box, 6)
		stroke(box, T.stroke)
		padding(box, 9, 0, 9, 0)

		box.FocusLost:Connect(function()
			if type(callback) == "function" then
				local ok, err = pcall(callback, box.Text)
				if not ok then
					warn("[Onyx UI] textbox error: " .. tostring(err))
				end
			end
		end)

		local api = { Frame = outer, TextBox = box }
		function api:Set(v)
			box.Text = tostring(v or "")
		end
		function api:Get()
			return box.Text
		end
		return api
	end

	-- ---- section (flat group) / menu (collapsible card)

	function containerProto:addSection()
		local f = Instance.new("Frame")
		f.BackgroundTransparency = 1
		f.BorderSizePixel = 0
		f.Size = UDim2.new(1, 0, 0, 0)
		f.AutomaticSize = Enum.AutomaticSize.Y
		f.Parent = self.body
		listLayout(f, 6)

		return setmetatable({ frame = f, body = f }, containerProto)
	end

	function containerProto:addMenu(name)
		local card = Instance.new("Frame")
		card.BackgroundColor3 = T.panel
		card.BorderSizePixel = 0
		card.Size = UDim2.new(1, 0, 0, 0)
		card.AutomaticSize = Enum.AutomaticSize.Y
		card.Parent = self.body
		corner(card, 9)
		stroke(card, T.stroke)
		padding(card, 0, 0, 0, 8)

		local head = Instance.new("TextButton")
		head.AutoButtonColor = false
		head.BackgroundTransparency = 1
		head.Text = ""
		head.Size = UDim2.new(1, 0, 0, 30)
		head.Parent = card

		local chev = textLabel(head, "v", 10, T.accent2, true)
		chev.Size = UDim2.new(0, 14, 1, 0)
		chev.Position = UDim2.new(0, 9, 0, 0)
		chev.TextXAlignment = Enum.TextXAlignment.Center

		local title = textLabel(head, name or "Menu", 12, T.text, true)
		title.Size = UDim2.new(1, -40, 1, 0)
		title.Position = UDim2.new(0, 26, 0, 0)
		title.TextTruncate = Enum.TextTruncate.AtEnd

		local body = Instance.new("Frame")
		body.BackgroundTransparency = 1
		body.BorderSizePixel = 0
		body.Size = UDim2.new(1, -14, 0, 0)
		body.Position = UDim2.new(0, 7, 0, 32)
		body.AutomaticSize = Enum.AutomaticSize.Y
		body.Parent = card
		listLayout(body, 6)

		local sub = setmetatable({ frame = card, body = body }, containerProto)

		local open = true
		head.MouseButton1Click:Connect(function()
			open = not open
			body.Visible = open
			chev.Text = open and "v" or ">"
		end)

		return sub
	end

	-- ============================================================ Window

	local windowProto = {}
	windowProto.__index = windowProto

	function windowProto:AddTab(name, icon)
		local holder = Instance.new("ScrollingFrame")
		holder.Name = "Tab_" .. tostring(name)
		holder.Size = UDim2.new(1, 0, 1, 0)
		holder.Visible = false
		holder.Parent = self.__content
		makeScrollable(holder, "Y")
		listLayout(holder, 8)
		padding(holder, 10, 8, 10, 16)

		local tabObj = setmetatable({ frame = holder, body = holder, __window = self }, containerProto)

		local btn = Instance.new("TextButton")
		btn.AutoButtonColor = false
		btn.BackgroundColor3 = T.card
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.Size = UDim2.new(0, math.floor(measure(tostring(name), 12, true)) + 26, 0, 28)
		btn.Parent = self.__tabbar
		corner(btn, 7)

		local lb = textLabel(btn, tostring(name), 12, T.dim, true)
		lb.Size = UDim2.new(1, 0, 1, 0)
		lb.TextXAlignment = Enum.TextXAlignment.Center

		local entry = { button = btn, label = lb, frame = holder }

		local function select()
			for _, e in ipairs(self.__tabs) do
				e.frame.Visible = false
				e.button.BackgroundColor3 = T.card
				e.label.TextColor3 = T.dim
			end
			holder.Visible = true
			btn.BackgroundColor3 = T.accent
			lb.TextColor3 = Color3.fromRGB(255, 255, 255)
			holder.CanvasPosition = Vector2.new(0, 0)

			local r = ScrollRefresh[holder]
			if r then
				task.defer(r)
				task.delay(0.25, r)
			end
		end

		btn.MouseButton1Click:Connect(select)

		table.insert(self.__tabs, entry)
		if #self.__tabs == 1 then
			select()
		end

		return tabObj
	end

	local lib = {}

	lib.Notification = Notification

	function lib:CreateWindow(opts)
		opts = opts or {}

		local gui = buildScreenGui("OnyxUI")
		if not gui then
			return nil
		end
		Notification.__gui = gui

		local cam = workspace.CurrentCamera
		local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)

		local W = math.clamp(vp.X - 28, 280, 560)
		local H = math.clamp(vp.Y - 28, 240, 420)

		local main = Instance.new("Frame")
		main.Name = "Main"
		main.BackgroundColor3 = T.bg
		main.BorderSizePixel = 0
		main.AnchorPoint = Vector2.new(0.5, 0.5)
		main.Position = UDim2.new(0.5, 0, 0.5, 0)
		main.Size = UDim2.new(0, W, 0, H)
		main.ClipsDescendants = true
		main.Parent = gui
		corner(main, 12)
		stroke(main, T.stroke)

		local bar = Instance.new("Frame")
		bar.BackgroundColor3 = T.panel
		bar.BorderSizePixel = 0
		bar.Size = UDim2.new(1, 0, 0, 42)
		bar.Parent = main
		corner(bar, 12)

		local barFix = Instance.new("Frame")
		barFix.BackgroundColor3 = T.panel
		barFix.BorderSizePixel = 0
		barFix.Size = UDim2.new(1, 0, 0, 12)
		barFix.Position = UDim2.new(0, 0, 1, -12)
		barFix.Parent = bar

		local ttl = textLabel(bar, opts.Title or "Menu", 14, T.text, true)
		ttl.Size = UDim2.new(1, -110, 0, 20)
		ttl.Position = UDim2.new(0, 12, 0, 6)
		ttl.TextTruncate = Enum.TextTruncate.AtEnd

		local sub = textLabel(bar, tostring(opts.Subtitle or "") .. "  " .. tostring(opts.Version or ""), 10, T.dim, false)
		sub.Size = UDim2.new(1, -110, 0, 12)
		sub.Position = UDim2.new(0, 12, 0, 24)
		sub.TextTruncate = Enum.TextTruncate.AtEnd

		local function barButton(txt, right, cb)
			local b = Instance.new("TextButton")
			b.AutoButtonColor = false
			b.BackgroundColor3 = T.card
			b.BorderSizePixel = 0
			b.Text = ""
			b.Size = UDim2.new(0, 24, 0, 22)
			b.AnchorPoint = Vector2.new(1, 0.5)
			b.Position = UDim2.new(1, -right, 0.5, 0)
			b.Parent = bar
			corner(b, 6)

			local lb = textLabel(b, txt, 12, T.dim, true)
			lb.Size = UDim2.new(1, 0, 1, 0)
			lb.TextXAlignment = Enum.TextXAlignment.Center

			b.MouseButton1Click:Connect(function()
				pcall(cb)
			end)
			return b
		end

		local tabbar = Instance.new("ScrollingFrame")
		tabbar.Name = "TabBar"
		tabbar.Size = UDim2.new(1, 0, 0, 36)
		tabbar.Position = UDim2.new(0, 0, 0, 42)
		tabbar.Parent = main
		makeScrollable(tabbar, "X")
		local tl = listLayout(tabbar, 6, Enum.FillDirection.Horizontal)
		tl.VerticalAlignment = Enum.VerticalAlignment.Center
		padding(tabbar, 10, 0, 10, 0)

		local content = Instance.new("Frame")
		content.Name = "Content"
		content.BackgroundTransparency = 1
		content.Size = UDim2.new(1, 0, 1, -78)
		content.Position = UDim2.new(0, 0, 0, 78)
		content.Parent = main

		local win = setmetatable({
			__gui = gui,
			__main = main,
			__tabbar = tabbar,
			__content = content,
			__tabs = {},
		}, windowProto)

		-- drag the window by its title bar
		local dragStart = nil
		local startPos = nil
		local dragging = false

		bar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = Vector2.new(input.Position.X, input.Position.Y)
				startPos = main.Position
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if not dragging then
				return
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch then
				local d = Vector2.new(input.Position.X, input.Position.Y) - dragStart
				main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		local fab = Instance.new("TextButton")
		fab.Name = "OnyxFab"
		fab.AutoButtonColor = false
		fab.BackgroundColor3 = T.accent
		fab.BorderSizePixel = 0
		fab.Text = ""
		fab.Size = UDim2.new(0, 46, 0, 46)
		fab.AnchorPoint = Vector2.new(1, 1)
		fab.Position = UDim2.new(1, -14, 1, -14)
		fab.Visible = false
		fab.Parent = gui
		corner(fab, 23)

		local fabLb = textLabel(fab, "Q", 18, Color3.fromRGB(255, 255, 255), true)
		fabLb.Size = UDim2.new(1, 0, 1, 0)
		fabLb.TextXAlignment = Enum.TextXAlignment.Center

		fab.MouseButton1Click:Connect(function()
			main.Visible = true
			fab.Visible = false
		end)

		barButton("-", 40, function()
			main.Visible = false
			fab.Visible = true
		end)

		barButton("x", 12, function()
			main.Visible = false
			fab.Visible = true
		end)

		if cam then
			cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				local v = cam.ViewportSize
				main.Size = UDim2.new(0, math.clamp(v.X - 28, 280, 560), 0, math.clamp(v.Y - 28, 240, 420))
			end)
		end

		UserInputService.InputBegan:Connect(function(input, processed)
			if processed then
				return
			end
			if input.KeyCode == Enum.KeyCode.RightShift then
				main.Visible = not main.Visible
				fab.Visible = not main.Visible
			end
		end)

		return win
	end

	return lib
	end
	local lua3 = OnyxUI()
	local materialEnemies = lua.MaterialEnemies
	local quests = lua.QUESTS
	local bossList = lua.BossList
	local itemsToBuy = lua.ItemsToBuy
	local islands = lua.Islands
	local melees = lua.Melees
	local swordData = lua.SwordData

	mods.FireInvoke = function(...)
		return commF:InvokeServer(select(2, ...))
	end

	hub.Cache = {
		MonCached = obj,
		IslandSent = tbl5,
		DistanceCache = obj2,
		TargetCache = obj3,
		Clean = function()
			for k in pairs(tbl5) do
				if not worldOrigin.Locations:FindFirstChild(k) then
					tbl5[k] = nil
				end
			end
		end,
	}

	local state = {
		CurrentDracoStage = 1,
		DracoSequence = { "Relic1", "EndRelic1", "Relic2", "EndRelic2", "Relic3", "EndRelic3" },
		SwordList = { "Shizu", "Saishi", "Oroshi" },
		ActiveSword = nil,
		JoinTime = os.time(),
		CamLockConn = nil,
		BlueMoonState = "FIND_ISLAND",
	}

	hub.State = state

	mods.IsReady = function(arg, arg2)
		if not arg2 or not arg2.Parent or not arg2:IsDescendantOf(v2) then
			return false
		end

		if arg2.Parent == boats or arg2:GetAttribute("IsBoat") or arg2.Name:find("Brigade") or arg2.Name:find("Boat") or arg2.Name:find("Ship") then
			local health = arg2:FindFirstChild("Health")

			if health then
				local flag4 = health:IsA("ValueBase") and health.Value <= 0

				if flag4 then
					health = flag4
				else
					health = type(health.Value) == "number" and health.Value <= 0
				end
			end

			if health then
				return false
			end
			local humanoid2 = arg2:FindFirstChildOfClass("Humanoid") or arg2:FindFirstChild("Humanoid")

			if humanoid2 then
				local flag4 = humanoid2:IsA("Humanoid") and humanoid2.Health <= 0

				if flag4 then
					humanoid2 = flag4
				else
					humanoid2 = humanoid2:IsA("ValueBase") and humanoid2.Value <= 0
				end
			end

			if humanoid2 then
				return false
			end

			if arg2:GetAttribute("Dead") == true or arg2:GetAttribute("Sunk") == true then
				return false
			end
			local engine = arg2:FindFirstChild("Engine") or arg2.PrimaryPart or arg2:FindFirstChildWhichIsA("BasePart")
			if not engine or engine.Position.Y < -15 then
				return false
			end
			return true
		end

		if arg2.Parent == seaBeasts then
			local health = arg2:FindFirstChild("Health")
			return health and health.Value > 0
		end
		local humanoid2 = arg2:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart2 = arg2:FindFirstChild("HumanoidRootPart") or arg2.PrimaryPart
		if humanoid2 and humanoid2.Health > 0 and humanoidRootPart2 then
			return true
		end
		return false
	end

	local function fn6()
		if not character then
			return 0
		end
		return DangerDistance(character:GetPivot().Position)
	end

	hub.Runtime = {
		StartTime = tick(),
		StartLevel = level and level.Value or 0,
		StartBeli = beli and beli.Value or 0,
		StartFragments = fragments and fragments.Value or 0,
		LastDataLogTick = 0,
		LastErrorTick = {},
		ErrorLogs = {},
		FarmsCompleted = 0,
		ChestsCollected = 0,
		MobsKilled = 0,
		BossesKilled = 0,
		LevelGained = 0,
		BeliGained = 0,
		FragmentsGained = 0,
		ActiveFarm = "None",
	}

	hub.Performance = {
		CleanMemory = function()
			pcall(function()
				if collectgarbage then
					collectgarbage("step", 200)
				end

				hub.Cache.Clean()
			end)
		end,
		ClearDebris = function()
			pcall(function()
				local v19 = next
				local children, v20 = v2:GetChildren()

				for _, v21 in v19, children, v20 do
					if v21:IsA("Tool") and (not v21.Parent or not v21.Parent:FindFirstChildOfClass("Humanoid")) then
						v21:Destroy()
					elseif v21.Name == "Debris" or v21.Name == "Effect" or v21.Name == "Effects" then
						v21:ClearAllChildren()
					else
						local isBasePart = v21:IsA("BasePart")

						if isBasePart then
							isBasePart = v21.Name:find("Slash") or v21.Name:find("HitEffect") or v21.Name:find("Particle") or v21.Name:find("Explosion")
						end

						if isBasePart then
							v21:Destroy()
						end
					end
				end

				if v2:FindFirstChild("Characters") then
					local v21 = next
					local children2, v22 = v2.Characters:GetChildren()

					for _, v23 in v21, children2, v22 do
						local humanoid2 = v23:FindFirstChildOfClass("Humanoid")

						if humanoid2 and humanoid2.Health <= 0 and v23 ~= localPlayer.Character then
							v23:Destroy()
						end
					end
				end
			end)
		end,
		OptimizeClient = function()
			pcall(function()
				local terrain = v2:FindFirstChildOfClass("Terrain")

				if terrain then
					terrain.WaterWaveSize = 0
					terrain.WaterWaveSpeed = 0
					terrain.WaterReflectance = 0
					terrain.WaterTransparency = 0
				end

				LightingSvc.GlobalShadows = false
				LightingSvc.FogEnd = 9e9
				settings().Rendering.QualityLevel = 1

				for _, descendant in ipairs(LightingSvc:GetDescendants()) do
					if descendant:IsA("BlurEffect") or descendant:IsA("SunRaysEffect") or descendant:IsA("ColorCorrectionEffect") or descendant:IsA("BloomEffect") or descendant:IsA("DepthOfFieldEffect") then
						descendant.Enabled = false
					end
				end
			end)
		end,
		ClearNew = function(arg)
			if arg then
				table.clear(arg)
				return arg
			end
			return {}
		end,
		CreateDictionary = function(arg, arg2)
			local tbl8 = {}
			arg2 = arg2 ~= nil and arg2 or true

			if arg then
				for i = 1, #arg do
					tbl8[arg[i]] = arg2
				end
			end

			return tbl8
		end,
		CreateAutoCache = function(arg)
			local tbl8 = {}

			setmetatable(tbl8, { __index = function(arg2, arg3)
				if arg3 == nil then
					return nil
				end
				local v19 = arg(arg3)
				rawset(arg2, arg3, v19)
				return v19
			end })

			return tbl8
		end,
		FastMode = false,
		SetFastMode = function(fastMode)
			if fastMode == nil then
				fastMode = true
			end

			hub.Performance.FastMode = fastMode

			task.spawn(function()
				pcall(function()
					local playerGui = localPlayer and localPlayer:FindFirstChild("PlayerGui")
					local fastMode2 = playerGui and playerGui:FindFirstChild("Main") and playerGui.Main:FindFirstChild("SettingsMenu") and playerGui.Main.SettingsMenu:FindFirstChild("Content") and playerGui.Main.SettingsMenu.Content:FindFirstChild("ScrollingFrame") and playerGui.Main.SettingsMenu.Content.ScrollingFrame:FindFirstChild("FastMode")

					if fastMode2 and firesignal then
						local firstButton = fastMode and fastMode2:FindFirstChild("FirstButton") or fastMode2:FindFirstChild("SecondButton")

						if firstButton and firstButton:IsA("GuiButton") then
							firesignal(firstButton.Activated)
						end
					end
				end)
			end)

			return hub.Performance.FastMode
		end,
	}

	local clearNew = hub.Performance.ClearNew

	hub.Scheduler = {
		Phase = 1,
		PhaseStart = tick(),
		LastHop = tick(),
		LastRejoin = tick(),
		LastFruitRoll = 0,
		_IsHopping = false,
		_CancelHop = false,
		StopHop = function()
			hub.Scheduler._CancelHop = true
			hub.Scheduler._IsHopping = false

			if tbl4 then
				for k in pairs(tbl4) do
					tbl4[k] = false
				end
			end

			for _, v19 in ipairs({
				"AutoAfkJoinCastleRaid",
				"AutoAfkJoinFactoryRaid",
				"AutoAfkJoinBossRaid",
				"AutoAfkJoinEliteHunter",
				"AutoAfkJoinFruit",
			}) do
				if config then
					config[v19] = false
				end

				if mods and mods.Toggles and mods.Toggles[v19] and mods.Toggles[v19].Update then
					pcall(function()
						mods.Toggles[v19].Update(false)
					end)
				end
			end

			if mods and mods.SendNotify then
				mods:SendNotify("AFK Farm", "AFK farm & server hop stopped.", 3)
			end
		end,
		ServerHop = function(arg)
			hub.Scheduler._CancelHop = false

			task.spawn(function()
				hub.Scheduler._IsHopping = true
				local n = arg or config and tonumber(config.HopDelay) or 0

				local tbl8 = {
					{
						Text = "Stop Hop",
						Callback = function()
							hub.Scheduler.StopHop()
						end,
					},
				}

				if n > 0 then
					if mods and mods.SendNotify then
						local min = math.min
						mods:SendNotify("Server Hop", string.format("Hopping server in %d seconds...", math.floor(n)), min(math.floor(n), 5), tbl8)
					end

					local n2 = 0
					local exitTo = nil

					while true do
						if n2 < n then
							if not hub.Scheduler._CancelHop then
								task.wait(0.2)
								n2 += 0.2
								continue
							end

							break
						else
							exitTo = 1
							break
						end
					end

					if exitTo ~= 1 then
						hub.Scheduler._IsHopping = false
						return
					end
				end

				if hub.Scheduler._CancelHop then
					hub.Scheduler._IsHopping = false
					return
				end
				local flag4 = false

				for i = 1, 100 do
					if not hub.Scheduler._CancelHop then
						task.spawn(function()
							if flag4 or hub.Scheduler._CancelHop then
								return
							end

							local ok, result = pcall(function()
								return RS.__ServerBrowser:InvokeServer(i)
							end)

							if ok and type(result) == "table" then
								for k, v19 in pairs(result) do
									if not flag4 and not hub.Scheduler._CancelHop and type(v19) == "table" and v19.Count and v19.Count < 12 and k ~= game.JobId then
										flag4 = true

										if mods and mods.SendNotify then
											mods:SendNotify("Hopping", "Server found! Teleporting...", 5, nil, "ServerHop")
										end

										pcall(function()
											if not hub.Scheduler._CancelHop then
												RS.__ServerBrowser:InvokeServer("teleport", k)
											end
										end)
									end
								end
							end
						end)

						continue
					end

					break
				end

				hub.Scheduler._IsHopping = false
			end)
		end,
		Rejoin = function()
			if mods and mods.SendNotify then
				mods:SendNotify("Rejoin", "Rejoining current server...", 3)
			end

			pcall(function()
				RS.__ServerBrowser:InvokeServer("teleport", game.JobId)
			end)
		end,
	}

	hub.StopAfkFarm = hub.Scheduler.StopHop
	mods.StopAfkFarm = hub.Scheduler.StopHop

	pcall(function()
		v15.TeleportInitFailed:Connect(function(arg, arg2, arg3)
			pcall(function()
				v16:ClearError()
			end)

			if not hub.Scheduler._IsHopping and not hub.Scheduler._IsJoiningActive then
				if mods and mods.SendNotify then
					mods:SendNotify("Quantum API", "Teleport failed: " .. tostring(arg3 or "Server full"), 2)
				end
			end
		end)
	end)

	local function joinAPI(arg, arg2)
		pcall(function()
			v16:ClearError()
		end)

		if tbl4[arg] then
			if mods and mods.SendNotify then
				mods:SendNotify("Quantum API", "Already searching servers for " .. tostring(arg) .. "...", 2)
			end

			return
		end

		local tbl8 = {
			{
				Text = "Stop Hop",
				Callback = function()
					hub.Scheduler.StopHop()
				end,
			},
		}

		local str4 = "/api/logs/" .. tostring(arg):lower()
		local now = os.clock()
		local n = tbl3[arg] or 0

		if arg2 and now - n < arg2 then
			local v19 = math.ceil(arg2 - now - n)

			if mods and mods.SendNotify then
				mods:SendNotify("Cooldown", string.format("Wait %ds before next %s", v19, arg), 2)
			end

			return
		end

		hub.Scheduler._CancelHop = false
		hub.Scheduler._IsJoiningActive = true
		tbl4[arg] = true
		tbl3[arg] = now

		task.spawn(function()
			local ok, result = pcall(function()
				return fn2({ Url = str .. str4, Method = "GET", Headers = { ["Content-Type"] = "application/json" } })
			end)

			if not ok or not result or result.StatusCode ~= 200 then
				tbl4[arg] = false
				hub.Scheduler._IsJoiningActive = false

				if mods and mods.SendNotify then
					mods:SendNotify("Error", "Failed to fetch " .. arg .. " data", 3)
				end

				return
			end

			if hub.Scheduler._CancelHop then
				tbl4[arg] = false
				hub.Scheduler._IsJoiningActive = false
				return
			end

			local v19 = v9:JSONDecode(result.Body)[tostring(arg):lower()]

			if not v19 or #v19 == 0 then
				tbl4[arg] = false
				hub.Scheduler._IsJoiningActive = false
				if hub.Scheduler._CancelHop then
					return
				end

				if mods and mods.SendNotify then
					mods:SendNotify("Hopping Server", "No recent report found, hopping server...", 3, tbl8, "ServerHop")
				end

				hub.Scheduler.ServerHop(0, true)
				return
			end

			local tbl9 = {}

			for i = #v19, 1, -1 do
				local v20 = v19[i]

				if v20.jobId and v20.jobId ~= "" then
					local v21 = fn4(v20.jobId)

					if v21 and v21 ~= "" and v21 ~= game.JobId then
						if not v20.placeId or tostring(v20.placeId) == tostring(game.PlaceId) then
							if not table.find(tbl9, v21) then
								table.insert(tbl9, v21)
							end
						end
					end
				end
			end

			if #tbl9 == 0 then
				tbl4[arg] = false
				hub.Scheduler._IsJoiningActive = false
				if hub.Scheduler._CancelHop then
					return
				end

				if mods and mods.SendNotify then
					mods:SendNotify("Hopping Server", "No active server found, hopping server...", 3, tbl8, "ServerHop")
				end

				hub.Scheduler.ServerHop(0, true)
				return
			end

			local jobId = game.JobId

			for i, v20 in ipairs(tbl9) do
				if not (game.JobId ~= jobId or hub.Scheduler._CancelHop) then
					pcall(function()
						v16:ClearError()
					end)

					if mods and mods.SendNotify then
						mods:SendNotify("Hopping Server", i == 1 and string.format("Connecting to server (%d/%d)...", i, #tbl9) or string.format("Server full!\nRetrying with server (%d/%d)...", i, #tbl9), 30, tbl8, "ServerHop")
					end

					local flag4 = false
					local flag5 = false
					local v21 = coroutine.running()

					local connection = v15.TeleportInitFailed:Connect(function()
						flag4 = true

						pcall(function()
							v16:ClearError()
						end)

						if not flag5 then
							flag5 = true
							task.spawn(v21)
						end
					end)

					task.spawn(function()
						pcall(function()
							if not hub.Scheduler._CancelHop then
								RS.__ServerBrowser:InvokeServer("teleport", v20)
							end
						end)
					end)

					task.delay(6, function()
						if not flag5 then
							flag5 = true
							task.spawn(v21)
						end
					end)

					coroutine.yield()

					pcall(function()
						connection:Disconnect()
					end)

					pcall(function()
						v16:ClearError()
					end)

					if game.JobId ~= jobId or hub.Scheduler._CancelHop then
						break
					else
						if flag4 then
							task.wait(0.8)
						end

						continue
					end
				end

				break
			end

			tbl4[arg] = false
			hub.Scheduler._IsJoiningActive = false

			if game.JobId == jobId and not hub.Scheduler._CancelHop then
				if mods and mods.SendNotify then
					mods:SendNotify("Hopping Server", "All candidate servers were full. Hopping to random server...", 5, tbl8, "ServerHop")
				end

				hub.Scheduler.ServerHop(0, true)
			end
		end)
	end

	mods.JoinAPI = joinAPI

	mods.JoinAPI = function(arg, arg2, arg3)
		return joinAPI(arg2, arg3)
	end

	local function fn7()
		local tbl8 = {
			ActiveTween = nil,
			ActiveTweenTarget = nil,
			ActiveBoatTween = nil,
			PlayerSpawns = worldOrigin.PlayerSpawns.Pirates,
			Locations = worldOrigin.Locations,
			StopBoatFlag = false,
			StopCurrentTween = nil,
		}

		local n = 0

		local tbl9 = {
			Sea_1 = {
				Vector3.new(-7894.62, 5545.49, -380.25),
				Vector3.new(-4607.82, 872.54, -1667.56),
				Vector3.new(61163.85, 11.76, 1819.78),
				Vector3.new(3876.28, 35.11, -1939.32),
			},
			Sea_2 = {
				Vector3.new(-288.46, 306.13, 598),
				Vector3.new(2284.91, 15.15, 905.48),
				Vector3.new(923.21, 126.98, 32852.83),
				Vector3.new(-6508.56, 89.03, -132.84),
			},
			Sea_3 = {
				Vector3.new(-5058, 314, -3170),
				Vector3.new(-12463, 374, -7550),
				Vector3.new(5670, 1020, -340),
				Vector3.new(28286, 14897, 103),
			},
		}

		local flag4 = false
		local flag5 = false
		local n2 = 0
		local n3 = 5
		local bodyVelocity = nil

		local function fn8(character2)
			character = character2
			humanoid = character2:WaitForChild("Humanoid", 10)
			humanoidRootPart = character2:WaitForChild("HumanoidRootPart", 10)
		end

		local function fn9()
			local v19 = next
			local children, v20 = localPlayer.Character:GetChildren()

			for _, v21 in v19, children, v20 do
				if v21:IsA("BasePart") and v21.CanCollide then
					v21.CanCollide = false
				end
			end
		end

		local function fn10()
			if not humanoidRootPart then
				return
			end

			if not humanoidRootPart:FindFirstChild("PartVelocuty") then
				if bodyVelocity then
					bodyVelocity:Destroy()
				end

				bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
				bodyVelocity.Name = "PartVelocuty"
				bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bodyVelocity.Velocity = Vector3.zero
				bodyVelocity.P = 1000
			end
		end

		localPlayer.CharacterAdded:Connect(fn8)

		if localPlayer.Character then
			fn8(localPlayer.Character)
		end

		local locations = tbl8.Locations

		local function fn11()
			local v19 = humanoidRootPart
			if not v19 or not v19.Parent then
				return false
			end
			local humanoid2 = v19.Parent:FindFirstChildOfClass("Humanoid")
			return humanoid2 and humanoid2.Parent and humanoid2.Health > 0
		end

		local function fn12(arg)
			local position = arg.Position
			local v19 = next
			local children, v20 = locations:GetChildren()

			for _, v21 in v19, children, v20 do
				if (position - v21.Position).Magnitude <= v21.Mesh.Scale.X then
					return v21
				end
			end

			return { Name = "" }
		end

		local function fn13(arg)
			local position = arg.Position
			local sea1 = flag and tbl9.Sea_1 or isSea2 and tbl9.Sea_2 or isSea3 and tbl9.Sea_3 or {}
			local huge = math.huge
			local v19 = nil

			for _, v20 in ipairs(sea1) do
				local magnitude = (v20 - position).Magnitude

				if magnitude < huge then
					huge = magnitude
					v19 = v20
				end
			end

			return huge <= (position - humanoidRootPart.Position).Magnitude and v19 or nil
		end

		local function fn14(arg)
			if (humanoidRootPart.Position - arg).Magnitude > 300 then
				mods:FireInvoke("requestEntrance", arg)
				task.wait(0.1)
				fn10()
				humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 20)
				task.wait(0.5)
			end
		end

		local function fn15(arg)
			local position = arg.Position
			local v19 = next
			local children, v20 = tbl8.PlayerSpawns:GetChildren()

			for _, v21 in v19, children, v20 do
				if (v21.Part.Position - position).Magnitude <= 2500 then
					return v21
				end
			end
		end

		local function fn16(arg)
			local name = fn12(arg).Name
			if name == "" then
				return false
			end

			if name:find("Dimension") or name:find("Cursed") or name:find("Submerged") or name == "Sealed Cavern" or name:lower():find("under") or data.LastSpawnPoint.Value == "SubmergedIsland" then
				return false
			end
			return (arg.Position - humanoidRootPart.Position).Magnitude > 3500
		end

		local function fn17(arg)
			local v19 = fn15(humanoidRootPart)
			local magnitude = (arg.Position - humanoidRootPart.Position).Magnitude
			local position = humanoidRootPart.Position
			local position2 = arg.Position
			local v20 = next
			local children, v21 = tbl8.PlayerSpawns:GetChildren()
			local huge = math.huge
			local v22 = nil

			for _, v23 in v20, children, v21 do
				local position3 = v23.Part.Position
				local magnitude2 = (position3 - position2).Magnitude
				local magnitude3 = (position3 - position).Magnitude

				if magnitude >= 3000 and fn15(v23.Part) ~= v19 and magnitude3 <= 10200 and magnitude2 <= huge then
					huge = magnitude2
					v22 = v23
				end
			end

			return v22
		end

		local function fn18(arg)
			if not fn12(humanoidRootPart).Name:find("Submerged") or fn12(arg).Name:find("Submerged") then
				return
			end
			local v19 = humanoidRootPart

			while true do
				tbl8:topos(CFrame.new(11426, -2155, 9732))
				task.wait(2)
				net:WaitForChild("RF/SubmarineTransportation"):InvokeServer("InitiateTeleport", "Tiki Outpost")
				task.wait(2)
				if not (not fn12(v19).Name:find("Submerged") or not fn11()) then
					continue
				end
				break
			end
		end

		local function fn19(arg)
			while true do
				local v19 = fn17(arg)

				if not v19 then
					break
				else
					for i = 1, 3 do
						mods:FireInvoke("SetLastSpawnPoint", v19.Name)
						mods:FireInvoke("SetSpawnPoint")
						localPlayer.Character:PivotTo(v19.Part.CFrame)
						local humanoid2 = localPlayer.Character:FindFirstChild("Humanoid")

						if humanoid2 then
							humanoid2.Health = 0
						end
					end

					task.wait(0.1)

					while true do
						task.wait(0.1)
						if not (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character:FindFirstChild("Humanoid").Health > 0) then
							continue
						end
						break
					end

					if not (not fn16(arg) or not fn17(arg)) then
						continue
					end
					break
				end
			end
		end

		local function fn20(arg)
			local v19 = fn13(arg)

			if v19 and tick() - n2 >= n3 then
				fn14(v19)
				n2 = tick()
				task.wait(1)
			end
		end

		local function fn21(arg)
			if typeof(arg) == "Vector3" then
				return CFrame.new(arg)
			end

			if typeof(arg) == "CFrame" then
				return arg
			end

			if typeof(arg) == "Instance" and arg:IsA("BasePart") then
				return arg.CFrame
			end
		end

		local function fn22(cFrame, arg)
			if flag5 then
				return
			end
			n += 1
			local v19 = n
			flag4 = false
			flag5 = true
			if not humanoidRootPart or not humanoid then
				flag5 = false
				return
			end

			task.spawn(function()
				local cFrame2 = humanoidRootPart.CFrame
				local magnitude = (cFrame.Position - cFrame2.Position).Magnitude
				if magnitude <= 5 then
					flag5 = false
					return
				end
				local now = tick()
				local n4 = 0

				while not (v19 ~= n or flag4) do
					if not humanoid or humanoid.Health <= 0 then
						break
					end

					if not humanoidRootPart or not humanoidRootPart.Parent then
						break
					end
					local now2 = tick()
					local n5 = now2 - now
					n4 += math.max((tonumber(config.TweenSpeed) or 250) * (arg or 1), 0.1) * n5
					local n6 = math.clamp(n4 / magnitude, 0, 1)
					humanoidRootPart.CFrame = cFrame2:Lerp(cFrame, n6)
					if n6 >= 1 or (cFrame.Position - humanoidRootPart.Position).Magnitude <= 10 then
						humanoidRootPart.CFrame = cFrame
						break
					end
					task.wait()
					now = now2
				end

				flag5 = false
			end)
		end

		tbl8.StopTween = function()
			flag4 = true
			n += 1
			flag5 = false

			if bodyVelocity then
				pcall(function()
					if bodyVelocity.Parent then
						bodyVelocity:Destroy()
					end
				end)

				bodyVelocity = nil
			end

			if humanoidRootPart then
				local partVelocuty = humanoidRootPart:FindFirstChild("PartVelocuty")

				if partVelocuty then
					partVelocuty:Destroy()
				end
			end
		end

		tbl8.topos = function(arg, arg2, arg3, arg4, arg5)
			if flag5 then
				return
			end

			if not fn11() then
				return
			end
			local v19 = fn21(arg2)
			if not v19 then
				return
			end
			fn18(v19)
			if not fn11() then
				return
			end
			local pos = isSea3 and fn12(humanoidRootPart).Name:find("Temple of Time") or fn12(v19).Name:find("Temple of Time")

			if config.BypassTP and fn16(v19) and not pos then
				fn19(v19)
				if not fn11() then
					return
				end
			else
				fn20(v19)
			end

			if config.ForceAnchoredY and not pos then
				humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.CFrame.X, v19.Y, humanoidRootPart.CFrame.Z)
			end

			fn9()
			fn22(v19, arg5)
			if flag4 then
				arg:StopTween()
				return
			end

			if arg3 then
				fn10()
			elseif not arg4 and humanoidRootPart then
				local partVelocuty = humanoidRootPart:FindFirstChild("PartVelocuty")

				if partVelocuty then
					partVelocuty:Destroy()
				end
			end
		end

		GetAllBoats = function()
			local tbl10 = { "My Boat" }
			local boats2 = v2:FindFirstChild("Boats")

			if boats2 then
				for _, child in ipairs(boats2:GetChildren()) do
					local owner = child:FindFirstChild("Owner")

					if owner and owner.Value then
						local value = owner.Value
						local name = typeof(value) == "Instance" and value.Name or tostring(value)

						if name ~= localPlayer.Name and value ~= localPlayer and value ~= localPlayer.Character then
							tbl10[#tbl10 + 1] = child.Name .. " [" .. name .. "]"
						end
					end
				end
			end

			return tbl10
		end

		GetSelectedBoat = function()
			local sailTargetBoat = config.SailTargetBoat
			local v19 = next
			local children, v20 = v2.Boats:GetChildren()

			for _, v21 in v19, children, v20 do
				local owner = v21:FindFirstChild("Owner")

				if owner then
					if not sailTargetBoat or sailTargetBoat == "My Boat" then
						local name = localPlayer.Name
						if tostring(owner.Value) == name then
							return v21
						end
						continue
					end

					if v21.Name .. " [" .. tostring(owner.Value) .. "]" == sailTargetBoat then
						return v21
					end
				end
			end

			return nil
		end

		tbl8.StopBoatTween = function()
			tbl8.StopBoatFlag = true
			tbl8.ActiveBoatTween = nil
		end

		tbl8.toposboat = function(arg, arg2)
			if tbl8.ActiveBoatTween then
				return
			end
			local v19 = GetSelectedBoat()
			local vehicleSeat = v19 and v19:FindFirstChild("VehicleSeat")
			local cframe = typeof(arg2) == "Vector3" and CFrame.new(arg2) or arg2
			if not (v19 and vehicleSeat and humanoid and humanoid.Sit and cframe) then
				return
			end
			local n4 = tonumber(config.BoatPosY) or 31
			local cframe2 = CFrame.new(cframe.X, n4, cframe.Z)
			local cframe3 = CFrame.new(vehicleSeat.CFrame.X, n4, vehicleSeat.CFrame.Z)
			local magnitude = (cframe2.Position - cframe3.Position).Magnitude
			if magnitude <= 25 then
				return
			end
			tbl8.ActiveBoatTween = true
			tbl8.StopBoatFlag = false
			local bodyVelocity2 = Instance.new("BodyVelocity")
			bodyVelocity2.MaxForce = Vector3.new(1e9, 1e9, 1e9)
			bodyVelocity2.Velocity = Vector3.zero
			bodyVelocity2.P = 1e9
			bodyVelocity2.Parent = vehicleSeat

			task.spawn(function()
				local now = tick()
				local n5 = 0

				while not tbl8.StopBoatFlag and humanoid.Health > 0 and humanoid.Sit do
					local now2 = tick()
					local n6 = now2 - now
					local n7 = math.max(tonumber(config.SpeedBoat) or 250, 0.1)
					n5 += n7 * n6
					local n8 = math.clamp(n5 / magnitude, 0, 1)
					local v20 = cframe3:Lerp(cframe2, n8)
					bodyVelocity2.Velocity = (v20.Position - vehicleSeat.CFrame.Position).Magnitude > 0.1 and (v20.Position - vehicleSeat.CFrame.Position).Unit * n7
					vehicleSeat.CFrame = v20
					if n8 >= 1 or (cframe2.Position - vehicleSeat.CFrame.Position).Magnitude <= 25 then
						vehicleSeat.CFrame = cframe2
						break
					end
					task.wait()
					now = now2
				end

				if tbl8.StopBoatFlag then
					bodyVelocity2.Velocity = Vector3.zero
					bodyVelocity2:Destroy()
				end

				tbl8.ActiveBoatTween = nil
				tbl8.StopBoatFlag = false
			end)
		end

		return tbl8
	end

	mods.TweenManager = fn7()
	local tweenManager = mods.TweenManager

	local function fn8(arg)
		local flag4 = not (arg.Team == localPlayer.Team and tostring(arg.Team) == "Marines")

		if flag4 then
			flag4 = not (arg:HasTag("Ally" .. localPlayer.Name) or localPlayer:HasTag("Ally" .. arg.Name))
		end

		return flag4
	end

	local function fn9()
		local obj4 = setmetatable({}, {
			__index = {
				BodyParts = {
					"RightLowerArm",
					"RightUpperArm",
					"LeftLowerArm",
					"LeftUpperArm",
					"RightHand",
					"LeftHand",
				},
				LastCombo = 0,
				ComboTime = 0,
				GunDebounce = 0,
				MaxHits = 2,
				IgnoredTools = {},
				OverheatData = {
					Dragonstorm = { MaxOverheat = 3, Cooldown = 0, TotalOverheat = 0, Distance = 500, Shooting = false },
				},
				ShootsPerTarget = { ["Dual Flintlock"] = 2 },
				ShootStyles = {
					["Skull Guitar"] = "TAP",
					Bazooka = "Position",
					Cannon = "Position",
					Dragonstorm = "Overheat",
				},
				RemoteFruits = { ["Blade-Blade"] = true, ["Gas-Gas"] = true },
				NormalFruits = { ["Light-Light"] = true, ["Ice-Ice"] = true },
			},
		})

		local CombatUtil = require(RS.Modules.CombatUtil)
		local CombatController = require(RS.Controllers.CombatController)
		local validator2 = remotes:WaitForChild("Validator2")
		local reRegisterAttack = net:WaitForChild("RE/RegisterAttack")
		local reShootGunEvent = net:FindFirstChild("RE/ShootGunEvent")
		local RegisterHit = require(RS.Modules.Net):RemoteEvent("RegisterHit", true)

		local ok, result = pcall(function()
			return getupvalue(CombatController.Attack, 9)
		end)

		local function fn10()
			if not result then
				pcall(function()
					result = getupvalue(CombatController.Attack, 9)
				end)
			end

			if not result then
				return 0, 0
			end
			local v19 = getupvalue(result, 15)
			local v20 = getupvalue(result, 13)
			local v21 = getupvalue(result, 16)
			local v22 = getupvalue(result, 17)
			local v23 = getupvalue(result, 14)
			local v24 = getupvalue(result, 18)
			local v25 = getupvalue(result, 19)
			if not v19 or not v20 or not v21 or not v22 or not v23 or not v24 or not v25 then
				return 0, 0
			end
			local n = ((v19 * v23 + v20 * v21) % v22 * v22 + v20 * v23) % v24
			local n2 = math.floor(n / v22)
			local n3 = n - n2 * v22
			local n4 = v25 + 1

			pcall(function()
				setupvalue(result, 15, n2)
				setupvalue(result, 13, n3)
				setupvalue(result, 19, n4)
			end)

			return math.floor(n / v24 * 16777215), n4
		end

		local function fn11()
			pcall(function()
				local equippedWeapon = character:FindFirstChild("EquippedWeapon")
				if not humanoid or not equippedWeapon then
					return
				end
				local movesetAnimCache = CombatUtil:GetMovesetAnimCache(humanoid)
				local weaponName = CombatUtil:GetWeaponName(equippedWeapon)
				local v19 = movesetAnimCache[CombatUtil:GetPureWeaponName(weaponName) .. "-basic" .. math.random(1, #CombatUtil:GetWeaponData(weaponName).Moveset.Basic)]

				if v19 and not config.RemoveAnimationFast then
					v19:Play(0, 1, (v19:GetAttribute("SpeedMult") or 1) * 5)
					v19.TimePosition = 0.01
				end
			end)
		end

		local function fn12()
			if humanoidRootPart and humanoidRootPart:FindFirstChild("Buddha") then
				return 10
			end
			return obj4.MaxHits
		end

		local tbl8 = {}

		local function fn13(arg, arg2)
			local tbl9 = {}
			local v19 = obj4.BodyParts[math.random(#obj4.BodyParts)]
			arg2 = arg2 or 50
			local humanoidRootPart2 = humanoidRootPart or localPlayer.Character and (localPlayer.Character:FindFirstChild("HumanoidRootPart") or localPlayer.Character.PrimaryPart)
			if not humanoidRootPart2 then
				return tbl9
			end
			local v20 = fn12()
			local tbl10 = {}

			if config.attackmobs then
				local children = enemies:GetChildren()

				for i = 1, #children do
					local v21 = children[i]

					if not v21:GetAttribute("IsBoat") and mods:IsReady(v21) then
						local humanoidRootPart3 = v21:FindFirstChild("HumanoidRootPart") or v21.PrimaryPart

						if humanoidRootPart3 then
							local magnitude = (humanoidRootPart3.Position - humanoidRootPart2.Position).Magnitude

							if magnitude <= arg2 then
								local masteryFarm = not arg and config.MasteryFarm
								local flag4 = false

								if masteryFarm then
									local humanoid2 = v21:FindFirstChildOfClass("Humanoid")
									humanoid2 = humanoid2 and humanoid2.Health / humanoid2.MaxHealth <= config.HealthMob / 100
									local flag5 = false

									if humanoid2 then
										flag4 = true
									else
										flag4 = flag5
									end
								end

								if not flag4 then
									local insert = table.insert
									local tbl11 = {}
									local v22 = v21:FindFirstChild(v19) or humanoidRootPart3
									tbl11[1] = v21
									tbl11[2] = v22
									tbl11[3] = magnitude
									insert(tbl10, tbl11)
								end
							end
						end
					end
				end
			end

			if config.attackplayers and not localPlayer:GetAttribute("PvpDisabled") then
				local children = v2.Characters:GetChildren()
				local character2 = localPlayer and localPlayer.Character

				for _, child in pairs(children) do
					if child ~= character2 then
						local playerFromCharacter = v3:GetPlayerFromCharacter(child)
						local autoKillPlayerinTrial

						if playerFromCharacter then
							autoKillPlayerinTrial = config.AutoKillPlayerinTrial or fn8(playerFromCharacter)
						else
							autoKillPlayerinTrial = playerFromCharacter
						end

						if autoKillPlayerinTrial then
							local humanoidRootPart3 = child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart

							if humanoidRootPart3 then
								local magnitude = (humanoidRootPart3.Position - humanoidRootPart2.Position).Magnitude

								if magnitude <= arg2 then
									table.insert(tbl10, { child, humanoidRootPart3, magnitude })
								end
							end
						end
					end
				end
			end

			table.sort(tbl10, function(arg3, arg4)
				return arg3[3] < arg4[3]
			end)

			for i = 1, math.min(#tbl10, v20) do
				table.insert(tbl9, { tbl10[i][1], tbl10[i][2] })
			end

			return tbl9
		end

		local function fn14(arg, arg2, arg3)
			tbl8 = {}
			arg = arg or 500
			local character2 = localPlayer.Character or character
			local humanoidRootPart2

			if character2 then
				humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart") or character2.PrimaryPart
			else
				humanoidRootPart2 = character2
			end

			if not humanoidRootPart2 then
				return
			end
			local tbl9 = {}

			if arg2 or config.attackmobs then
				for _, child in ipairs(enemies:GetChildren()) do
					local flag4 = not child:GetAttribute("IsBoat")
					local v19 = mods:IsReady(child)

					if flag4 and v19 and child ~= character2 then
						local primaryPart = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart")
						local playerFromCharacter = v3:GetPlayerFromCharacter(child)

						if primaryPart and (child.Parent ~= v2.Characters or playerFromCharacter and fn8(playerFromCharacter)) then
							local magnitude = (humanoidRootPart2.Position - primaryPart.Position).Magnitude

							if magnitude <= arg then
								table.insert(tbl9, { child, primaryPart, magnitude })
							end
						end
					end
				end
			end

			if arg2 or config.attackplayers and not localPlayer:GetAttribute("PvpDisabled") then
				for _, child in ipairs(v2.Characters:GetChildren()) do
					if child ~= character2 then
						local playerFromCharacter = v3:GetPlayerFromCharacter(child)
						local autoKillPlayerinTrial

						if playerFromCharacter then
							autoKillPlayerinTrial = config.AutoKillPlayerinTrial or fn8(playerFromCharacter)
						else
							autoKillPlayerinTrial = playerFromCharacter
						end

						if autoKillPlayerinTrial then
							local humanoidRootPart3 = child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart

							if humanoidRootPart3 then
								local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

								if magnitude <= arg then
									table.insert(tbl9, { child, humanoidRootPart3, magnitude })
								end
							end
						end
					end
				end
			end

			if arg3 then
				for _, child in ipairs(seaBeasts:GetChildren()) do
					local meshPart = child:FindFirstChildOfClass("MeshPart") or child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart

					if mods:IsReady(child) and meshPart then
						local magnitude = (humanoidRootPart2.Position - meshPart.Position).Magnitude

						if magnitude < arg then
							table.insert(tbl9, { child, meshPart, magnitude })
						end
					end
				end

				for _, child in ipairs(enemies:GetChildren()) do
					if child:GetAttribute("IsBoat") then
						local meshPart = child:FindFirstChildOfClass("MeshPart") or child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")

						if mods:IsReady(child) and meshPart then
							local magnitude = (humanoidRootPart2.Position - meshPart.Position).Magnitude

							if magnitude < arg then
								table.insert(tbl9, { child, meshPart, magnitude })
							end
						end
					end
				end
			end

			table.sort(tbl9, function(arg4, arg5)
				return arg4[3] < arg5[3]
			end)

			for _, v19 in ipairs(tbl9) do
				table.insert(tbl8, { v19[1], v19[2] })
			end
		end

		local function fn15()
			if #tbl8 == 0 then
				return nil, nil
			end
			local v19 = tbl8[1]
			if not v19 or not v19[2] then
				return nil, nil
			end
			return v19[2].Position, v19[2]
		end

		local function fn16(arg)
			fn14(arg, true, true)
			if #tbl8 > 0 and tbl8[1] and tbl8[1][2] then
				return tbl8[1][2]
			end
			return nil
		end

		local handlers = { ["Skull Guitar"] = function(arg, arg2)
			arg.RemoteEvent:FireServer("TAP", arg2)
		end }

		local function fn17()
			local character2 = localPlayer.Character or character
			local tool = character2 and character2:FindFirstChildOfClass("Tool")

			if not tool or tool.ToolTip ~= "Gun" then
				if localPlayer.Backpack then
					for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
						if child:IsA("Tool") and child.ToolTip == "Gun" then
							if character2 and character2:FindFirstChildOfClass("Humanoid") then
								character2.Humanoid:EquipTool(child)
								tool = child
								task.wait(0.05)
							end

							break
						end
					end
				end
			end

			if not tool or not tool.Enabled then
				return
			end
			tool.Enabled = true
			tool:SetAttribute("IsReloading_Client", false)
			tool:SetAttribute("LocalShotsLeft", 100)
			tool:SetAttribute("LocalTotalShots", (tool:GetAttribute("LocalTotalShots") or 0) + 1)
			local distance = obj4.OverheatData[tool.Name] and obj4.OverheatData[tool.Name].Distance
			local n = 500

			if distance then
				n = obj4.OverheatData[tool.Name].Distance
			end

			fn14(n, false, true)

			if #tbl8 == 0 then
				local v19 = fn16(n)

				if v19 then
					table.insert(tbl8, { v19.Parent, v19 })
				end
			end

			if #tbl8 == 0 then
				return
			end
			local v19, v20 = fn15()
			if not v19 or not v20 then
				return
			end

			if handlers[tool.Name] then
				handlers[tool.Name](tool, v19)
				return
			end
			local str4 = obj4.ShootStyles[tool.Name]

			if not str4 then
				str4 = tool:FindFirstChild("RemoteEvent") and "TAP" or "Normal"
			end

			local n2 = obj4.ShootsPerTarget[tool.Name] or 1

			pcall(function()
				local v21, v22 = fn10()
				validator2:FireServer(v21, v22)

				if tool:FindFirstChild("RemoteEvent") and (str4 == "TAP" or tool.Name == "Skull Guitar") then
					tool.RemoteEvent:FireServer("TAP", v19)
				elseif reShootGunEvent then
					for i = 1, n2 do
						reShootGunEvent:FireServer(v19, { v20 })
					end
				end
			end)
		end

		local function fn18(arg, arg2)
			if not arg2 or not arg2:FindFirstChild("LeftClickRemote") then
				return
			end
			local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart2 then
				return
			end
			local position = humanoidRootPart2.Position

			for _, child in ipairs(enemies:GetChildren()) do
				if mods:IsReady(child) and not child:GetAttribute("IsBoat") then
					local primaryPart = child.PrimaryPart or child:FindFirstChild("HumanoidRootPart")

					if primaryPart and (primaryPart.Position - position).Magnitude <= 60 then
						arg2.LeftClickRemote:FireServer((primaryPart.Position - position).Unit, arg)
					end
				end
			end

			for _, child in ipairs(seaBeasts:GetChildren()) do
				if mods:IsReady(child) then
					local meshPart = child:FindFirstChildOfClass("MeshPart") or child.PrimaryPart

					if meshPart and (meshPart.Position - position).Magnitude <= 70 then
						arg2.LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
					end
				end
			end
		end

		local function fn19(arg)
			local character2 = localPlayer.Character or character
			local tool = character2 and character2:FindFirstChildOfClass("Tool")

			if not tool or tool.ToolTip ~= "Gun" then
				if localPlayer.Backpack then
					for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
						if child:IsA("Tool") and child.ToolTip == "Gun" then
							if character2 and character2:FindFirstChildOfClass("Humanoid") then
								character2.Humanoid:EquipTool(child)
								tool = child
								task.wait(0.05)
							end

							break
						end
					end
				end
			end

			if not tool or not tool.Enabled then
				return
			end
			tool.Enabled = true
			tool:SetAttribute("IsReloading_Client", false)
			tool:SetAttribute("LocalShotsLeft", 100)
			tool:SetAttribute("LocalTotalShots", (tool:GetAttribute("LocalTotalShots") or 0) + 1)
			if handlers[tool.Name] then
				return handlers[tool.Name](tool, arg)
			end

			pcall(function()
				local v19, v20 = fn10()
				validator2:FireServer(v19, v20)

				if obj4.ShootStyles[tool.Name] == "TAP" and tool:FindFirstChild("RemoteEvent") then
					tool.RemoteEvent:FireServer("TAP", arg)
				elseif reShootGunEvent then
					reShootGunEvent:FireServer(arg, { character2 and (character2:FindFirstChild("HumanoidRootPart") or character2.PrimaryPart) })
				end
			end)
		end

		local function fn20()
			for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
				if child:IsA("Tool") and child.ToolTip == "Blox Fruit" and child:FindFirstChild("LeftClickRemote") then
					return child
				end
			end

			return nil
		end

		local function fn21()
			local tool = character:FindFirstChildOfClass("Tool")
			local toolTip = tool and tool.ToolTip or nil

			if config.DoubleAttack then
				local v19 = fn20()

				if v19 and v19:FindFirstChild("LeftClickRemote") then
					pcall(function()
						v19.LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
					end)
				end
			end

			if not tool then
				if not config.DoubleAttack then
					return
				end
				local v19 = fn20()
				if not v19 then
					return
				end
				tool = v19
				toolTip = "Blox Fruit"
			end

			if not table.find({ "Melee", "Blox Fruit", "Sword", "Gun" }, toolTip) then
				return
			end

			if config.FastSettings == "Fast Attack" then
				if toolTip == "Gun" then
					fn17()
					return
				end
				local leftClickRemote = tool:FindFirstChild("LeftClickRemote")
				local v19 = fn13(toolTip == "Blox Fruit" and leftClickRemote ~= nil)

				if toolTip == "Blox Fruit" and not obj4.NormalFruits[tool.Name] and not obj4.RemoteFruits[tool.Name] then
					if tool:FindFirstChild("LeftClickRemote") and (config.DoubleAttack or character:FindFirstChildOfClass("Tool") == tool) then
						pcall(function()
							tool.LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
						end)
					end
				elseif toolTip == "Blox Fruit" and obj4.RemoteFruits[tool.Name] then
					local lastCombo = obj4.LastCombo
					local comboTime = obj4.ComboTime

					if tick() - comboTime > 0.65 then
						lastCombo = 0
					end

					local lastCombo2

					if lastCombo >= 5 then
						lastCombo2 = 1
					else
						lastCombo2 = lastCombo + 1
					end

					obj4.LastCombo = lastCombo2
					obj4.ComboTime = tick()

					if tool:FindFirstChild("LeftClickRemote") then
						fn18(lastCombo2, tool)
					end
				else
					reRegisterAttack:FireServer(config.FastAttackDelay or 0.3)
					fn11()
					local tbl9 = {}
					local v20 = nil

					for _, v21 in ipairs(v19) do
						if v21[1] and v21[2] then
							table.insert(tbl9, v21)
							v20 = v20 or v21[2]
						end
					end

					if v20 and RegisterHit then
						RegisterHit:FireServer(v20, tbl9, nil, nil, tostring(localPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15))
					end
				end

				if config.DoubleAttack and toolTip == "Blox Fruit" then
					local v20 = fn20()

					if v20 and v20 ~= tool and v20:FindFirstChild("LeftClickRemote") then
						if obj4.RemoteFruits and obj4.RemoteFruits[v20.Name] then
							fn18(obj4.LastCombo or 1, v20)
						else
							pcall(function()
								v20.LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
							end)
						end
					end
				end
			elseif config.FastSettings == "Legit Attack" then
				local function fn22(arg)
					local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart")
					local upperTorso = arg:FindFirstChild("UpperTorso")

					if humanoidRootPart2 and upperTorso and (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude <= 50 then
						upperTorso.Size = Vector3.new(70, 70, 70)
						upperTorso.Transparency = 1
						upperTorso.CanCollide = false
						upperTorso.Massless = true
						CombatController:Attack(tool)
					end
				end

				for _, child in ipairs(enemies:GetChildren()) do
					if mods:IsReady(child) then
						fn22(child)
					end
				end

				if config.attackplayers and not localPlayer:GetAttribute("PvpDisabled") then
					for _, child in ipairs(v2.Characters:GetChildren()) do
						if child ~= localPlayer.Character then
							local playerFromCharacter = v3:GetPlayerFromCharacter(child)

							if playerFromCharacter then
								playerFromCharacter = config.AutoKillPlayerinTrial or fn8(playerFromCharacter)
							end

							if playerFromCharacter then
								fn22(child)
							end
						end
					end
				end
			end
		end

		return (setmetatable({ Attack = fn21, ShootGun = fn17, CustomShoot = fn19, GetHits = fn13, AttackManager = obj4 }, { __call = function(...)
			return fn21(select(2, ...))
		end }))
	end

	mods.FastAttack = fn9()
	local fastAttack = mods.FastAttack
	local shootGun = fastAttack.ShootGun
	local customShoot = fastAttack.CustomShoot

	local function fn10()
		return { GetFruitStock = function()
			local ok, result = pcall(function()
				return mods:FireInvoke("GetFruits")
			end)

			local ok2, result2 = pcall(function()
				return mods:FireInvoke("GetFruits", true)
			end)

			local tbl8 = {}
			local tbl9 = {}

			if ok and typeof(result) == "table" then
				for _, v19 in next, result, nil do
					if type(v19) == "table" and (v19.OnSale == true or v19.InStock == true) then
						tbl8[#tbl8 + 1] = "<font color=\"#00BFFF\">[ * ]</font> " .. tostring(v19.Name or "Unknown"):gsub("%-.*", "") .. " — $" .. math.floor(tonumber(v19.Price) or 0)
					end
				end
			end

			if ok2 and typeof(result2) == "table" then
				for _, v19 in next, result2, nil do
					if type(v19) == "table" and (v19.OnSale == true or v19.InStock == true) then
						tbl9[#tbl9 + 1] = "<font color=\"#FFD700\">[  ]</font> " .. tostring(v19.Name or "Unknown"):gsub("%-.*", "") .. " — $" .. math.floor(tonumber(v19.Price) or 0)
					end
				end
			end

			local restockIn = type(result) == "table" and result.RestockIn or 14400 - os.time() % 14400
			local restockIn2 = type(result2) == "table" and result2.RestockIn or 7200 - os.time() % 7200

			local function fn11(arg)
				local n = math.floor(arg / 3600)
				local n2 = math.floor(arg % 3600 / 60)
				local n3 = arg % 60
				return n > 0 and n .. "h " .. n2 .. "m " .. n3 .. "s" or n2 > 0 and n2 .. "m " .. n3 .. "s" or n3 .. "s"
			end

			return ([[<font color="#00BFFF"><b>Normal Dealer</b></font>
%s
Restock: %s

%s

<font color="#FFD700"><b>Mirage Dealer</b></font>
%s
Restock: %s

%s]]):format("<font color=\"#333333\">────────────────────</font>", fn11(restockIn), #tbl8 > 0 and table.concat(tbl8, "\n") or "No fruits in stock", "<font color=\"#333333\">────────────────────</font>", fn11(restockIn2), #tbl9 > 0 and table.concat(tbl9, "\n") or "No fruits in stock")
		end }
	end

	mods.ServerStatus = fn10()
	local serverStatus = mods.ServerStatus

	mods.DataList = {
		BonesList = {
			["Reborn Skeleton"] = true,
			["Living Zombie"] = true,
			["Demonic Soul"] = true,
			["Posessed Mummy"] = true,
		},
		CakesList = {
			["Head Baker"] = true,
			["Baking Staff"] = true,
			["Cake Guard"] = true,
			["Cookie Crafter"] = true,
		},
		RaceList = {
			Fishman = CFrame.new(28224.057, 14889.427, -210.587),
			Human = CFrame.new(29237.295, 14889.427, -206.95),
			Cyborg = CFrame.new(28492.414, 14894.427, -422.11),
			Skypiea = CFrame.new(28967.408, 14918.075, 234.312),
			Ghoul = CFrame.new(28672.721, 14889.128, 454.596),
			Mink = CFrame.new(29020.66, 14889.427, -379.268),
		},
		HumanRace = { Orbitus = true, Diamond = true, Jeremy = true },
		TyrantList = {
			["Serpent Hunter"] = true,
			["Skull Slayer"] = true,
			["Isle Champion"] = true,
			["Sun-kissed Warrior"] = true,
		},
	}

	local function fn11()
		local tbl8 = {
			ActiveTweens = {},
			SpawnCache = {},
			MobCycle = {},
			NextSpawnCooldown = {},
			OrbitAngle = 0,
			OrbitSpeed = 3,
			LastTick = tick(),
			GetFarmCFrame = function(arg, arg2)
				if not arg2 then
					return nil
				end
				local posMethod = config.PosMethod or "Above"
				local position = arg2.Position
				local tool = character and character:FindFirstChildOfClass("Tool")
				tool = tool and tool.ToolTip == "Blox Fruit"
				local n = tonumber(config.PosY) or tool and 6 or 18
				local n2

				if tool then
					n2 = math.clamp(n, 3, 8)
				else
					n2 = math.clamp(n, 5, 25)
				end

				if posMethod == "Orbit" then
					local now = tick()
					local n3 = now - arg.LastTick
					arg.LastTick = now
					arg.OrbitAngle = arg.OrbitAngle + arg.OrbitSpeed * n3
					local n4 = tonumber(config.CircleRadius) or tool and 6 or n2
					return CFrame.new(position + Vector3.new(math.cos(arg.OrbitAngle) * n4, n2, math.sin(arg.OrbitAngle) * n4))
				end

				return CFrame.new(position + Vector3.new(0, n2, 0.5))
			end,
			GetDistance = function(arg, arg2)
				if typeof(arg2) == "CFrame" then
					return localPlayer:DistanceFromCharacter(arg2.Position)
				end

				if typeof(arg2) == "Vector3" then
					return localPlayer:DistanceFromCharacter(arg2)
				end
			end,
			AutoHaki = function()
				if not localPlayer.Character:HasTag("Buso") and beli.Value >= 25000 then
					mods:FireInvoke("BuyHaki", "Buso")
				elseif localPlayer.Character:HasTag("Buso") and not localPlayer.Character:FindFirstChild("HasBuso") then
					mods:FireInvoke("Buso")
				end
			end,
			CheckToolName = function(arg, arg2)
				local backpack = localPlayer and localPlayer.Backpack
				if character then
					return character:FindFirstChild(arg2) or backpack:FindFirstChild(arg2)
				end
			end,
			Checkfruit = function()
				local backpack = localPlayer and localPlayer.Backpack
				local character2 = localPlayer and localPlayer.Character
				local tbl8 = {}

				if backpack then
					table.insert(tbl8, backpack:GetChildren())
				end

				if character2 then
					table.insert(tbl8, character2:GetChildren())
				end

				for _, v19 in ipairs(tbl8) do
					for _, v20 in pairs(v19) do
						if v20:IsA("Tool") then
							if v20:FindFirstChild("EatRemote") or v20:FindFirstChild("DropRemote") or v20:GetAttribute("IsPhysical") or v20:GetAttribute("Fruit") or v20.ToolTip ~= "Blox Fruit" and string.find(v20.Name, "Fruit") then
								return v20.Name
							end
						end
					end
				end

				return nil
			end,
			EquipTool = function(arg, arg2)
				local backpack = localPlayer and localPlayer.Backpack

				if backpack and humanoid and backpack:FindFirstChild(arg2) then
					humanoid:EquipTool(backpack[arg2])
				end
			end,
			EquipWeapon = function(arg, arg2)
				local selectWeapon = arg2 or config.SelectWeapon
				local backpack = localPlayer and localPlayer.Backpack

				for _, child in ipairs(backpack:GetChildren()) do
					if child and child:IsA("Tool") and child.ToolTip == selectWeapon then
						arg:EquipTool(child.Name)
						return true
					end
				end
			end,
		}

		mods.CheckInventory = function(arg, arg2)
			local ok, result = pcall(function()
				return Net:RemoteFunction("GetAllItemValues"):InvokeServer()
			end)

			if not ok or not result then
				return nil
			end
			local tbl9 = {}

			for _, v19 in next, result, nil do
				local str4 = tostring(v19.ItemId) .. "_" .. tostring(v19.NetworkedUID)
				tbl9[str4] = tbl9[str4] or { ItemId = v19.ItemId, UID = v19.NetworkedUID, Attributes = {} }

				if v19.Value ~= nil then
					tbl9[str4].Attributes[v19.Key] = v19.Value
				end
			end

			for _, v19 in next, tbl9, nil do
				local ok2, result2 = pcall(function()
					return ItemConfig.match(v19.ItemId)
				end)

				ok2 = ok2 and result2 and result2:isOk()
				local str4 = nil

				if ok2 then
					local v20 = result2:unwrap()
					local debugLabel = v20 and v20.Index and v20.Index.DebugLabel
					str4 = nil

					if debugLabel then
						str4 = tostring(v20.Index.DebugLabel)
					end
				end

				if str4 then
					str4 = str4:match("^(.-)%s*%[") or str4
				end

				local attributes = v19.Attributes

				if str4 == arg2 and attributes.IsOwned == true then
					return {
						Name = str4,
						ItemId = v19.ItemId,
						UID = v19.UID,
						Quantity = attributes.Quantity,
						Mastery = attributes.Mastery,
						IsOwned = attributes.IsOwned,
						IsEquipped = attributes.IsEquipped,
						Attributes = attributes,
					}
				end
			end

			return nil
		end

		tbl8.CheckInventory = function(arg, arg2, arg3, arg4)
			local ok, result = pcall(function()
				return Net:RemoteFunction("GetAllItemValues"):InvokeServer()
			end)

			if not ok or not result then
				local n = arg2 == "Material" and 0
				local n2

				if n then
					n2 = n
				else
					n2 = arg2 == "Sword" and 0
				end

				return n2 or false
			end

			local tbl9 = {}

			for _, v19 in next, result, nil do
				local str4 = tostring(v19.ItemId) .. "_" .. tostring(v19.NetworkedUID)
				tbl9[str4] = tbl9[str4] or { ItemId = v19.ItemId, UID = v19.NetworkedUID, Attributes = {} }

				if v19.Value ~= nil then
					tbl9[str4].Attributes[v19.Key] = v19.Value
				end
			end

			for _, v19 in next, tbl9, nil do
				local ok2, result2 = pcall(function()
					return ItemConfig.match(v19.ItemId)
				end)

				ok2 = ok2 and result2 and result2:isOk()
				local str4 = nil

				if ok2 then
					local v20 = result2:unwrap()
					local debugLabel = v20 and v20.Index and v20.Index.DebugLabel
					str4 = nil

					if debugLabel then
						str4 = tostring(v20.Index.DebugLabel)
					end
				end

				if str4 then
					if string.lower(str4:match("^(.-)%s*%[") or str4) ~= string.lower(arg3) then
						continue
					end
					local attributes = v19.Attributes
					if arg2 == "Material" then
						return attributes.Quantity or 0
					end

					if arg2 == "Moveset" then
						return attributes.Mastery or 0
					end

					if arg2 == "Mastery" then
						return (attributes.Mastery or 0) >= (arg4 or 0)
					end
				end
			end

			return arg2 == "Material" and 0 or arg2 == "Sword" and 0 or false
		end

		tbl8.GetConnectMon = function(arg, arg2, arg3)
			local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			local flag4 = type(arg2) == "table"
			local flag5 = type(arg2) == "string"
			if arg3 and not humanoidRootPart2 then
				return nil
			end
			local tbl9 = {}

			if enemies then
				table.insert(tbl9, enemies)
			end

			table.insert(tbl9, RS)
			local huge = math.huge
			local v19 = nil

			for _, v20 in next, tbl9, nil do
				local v21 = next
				local children, v22 = v20:GetChildren()

				for _, v23 in v21, children, v22 do
					if flag5 then
						if v23.Name == arg2 then
							local v24 = v23:IsDescendantOf(v2)
							local flag6 = v23.Parent == RS or v23:IsDescendantOf(RS)

							if v24 and mods:IsReady(v23) or flag6 and v23:FindFirstChild("HumanoidRootPart") ~= nil then
								if not arg3 then
									return v23
								end
								local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart

								if humanoidRootPart3 then
									local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

									if flag6 then
										magnitude += 50000
									end

									if magnitude < huge then
										huge = magnitude
										v19 = v23
									end
								end

								continue
							end

							continue
						end

						if string.lower(v23.Name) ~= string.lower(arg2) then
							continue
						end
						local v24 = v23:IsDescendantOf(v2)
						local flag6 = v23.Parent == RS or v23:IsDescendantOf(RS)

						if v24 and mods:IsReady(v23) or flag6 and v23:FindFirstChild("HumanoidRootPart") ~= nil then
							if not arg3 then
								return v23
							end
							local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart

							if humanoidRootPart3 then
								local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

								if flag6 then
									magnitude += 50000
								end

								if magnitude < huge then
									huge = magnitude
									v19 = v23
								end
							end

							continue
						end

						continue
					end

					if flag4 then
						local flag6 = arg2[v23.Name] == true or table.find(arg2, v23.Name) ~= nil

						if not flag6 then
							for _, v24 in next, arg2, nil do
								if typeof(v24) == "string" and string.lower(v24) == string.lower(v23.Name) then
									flag6 = true
									break
								end
							end

							if flag6 then
								local v24 = v23:IsDescendantOf(v2)
								local flag7 = v23.Parent == RS or v23:IsDescendantOf(RS)

								if v24 and mods:IsReady(v23) or flag7 and v23:FindFirstChild("HumanoidRootPart") ~= nil then
									if not arg3 then
										return v23
									end
									local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart

									if humanoidRootPart3 then
										local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

										if flag7 then
											magnitude += 50000
										end

										if magnitude < huge then
											huge = magnitude
											v19 = v23
										end
									end

									continue
								end

								continue
							end

							continue
						end

						if flag6 then
							local v24 = v23:IsDescendantOf(v2)
							local flag7 = v23.Parent == RS or v23:IsDescendantOf(RS)

							if v24 and mods:IsReady(v23) or flag7 and v23:FindFirstChild("HumanoidRootPart") ~= nil then
								if not arg3 then
									return v23
								end
								local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart

								if humanoidRootPart3 then
									local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

									if flag7 then
										magnitude += 50000
									end

									if magnitude < huge then
										huge = magnitude
										v19 = v23
									end
								end

								continue
							end
						end
					end
				end
			end

			return v19
		end

		tbl8.CheckMon = function(arg, arg2)
			return arg:GetConnectMon(arg2) ~= nil
		end

		tbl8.GetEnemies = function(arg, arg2)
			return arg:GetConnectMon(arg2, true)
		end

		tbl8.BringCache = {}
		local n = 0
		local n2 = 0

		tbl8.BringEnemies = function(arg, arg2)
			if not config.BringMonster then
				return
			end
			local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
			local humanoidRootPart3 = arg2 and (arg2:FindFirstChild("HumanoidRootPart") or arg2.PrimaryPart)
			if not humanoidRootPart2 or not humanoidRootPart3 then
				return
			end
			local now = tick()
			if now - n < 0.25 then
				return
			end
			n = now
			local n3 = tonumber(config.BringMonsterRadius) or 350
			local n4 = math.clamp(n3 + 50, 100, 500)

			if now - n2 > 3 then
				n2 = now

				pcall(function()
					sethiddenproperty(localPlayer, "SimulationRadius", n4)
					sethiddenproperty(localPlayer, "MaxSimulationRadius", n4)
				end)
			end

			tbl8.BringCache[arg2.Name] = humanoidRootPart3.CFrame
			local tagged = v5:GetTagged("QuantumBringTag")

			for _, v19 in next, tagged, nil do
				local humanoid2 = v19:FindFirstChildOfClass("Humanoid")

				if not v19.Parent or not humanoid2 or humanoid2.Health <= 0 then
					pcall(function()
						v19:RemoveTag("QuantumBringTag")
					end)
				end
			end

			if #tagged >= 8 then
				return
			end
			local tbl9 = {}
			local character2 = localPlayer and localPlayer.Character

			if v2:FindFirstChild("Characters") then
				local v19 = next
				local children, v20 = v2.Characters:GetChildren()

				for _, v21 in v19, children, v20 do
					if v21 ~= character2 and v21:IsA("Model") then
						local humanoidRootPart4 = v21:FindFirstChild("HumanoidRootPart") or v21.PrimaryPart

						if humanoidRootPart4 then
							table.insert(tbl9, humanoidRootPart4.Position)
						end
					end
				end
			end

			local enemies2 = enemies or v2:FindFirstChild("Enemies")
			if not enemies2 then
				return
			end
			local v19 = next
			local children, v20 = enemies2:GetChildren()
			local n5 = 0

			for _, v21 in v19, children, v20 do
				if v21 ~= arg2 and v21.Name == arg2.Name and mods:IsReady(v21) and not v21:HasTag("QuantumBringTag") and not v3:GetPlayerFromCharacter(v21) then
					local humanoidRootPart4 = v21:FindFirstChild("HumanoidRootPart") or v21.PrimaryPart
					local humanoid2 = v21:FindFirstChildOfClass("Humanoid")

					if humanoidRootPart4 and humanoid2 and humanoid2.Health > 0 then
						local position = humanoidRootPart4.Position

						if (position - humanoidRootPart3.Position).Magnitude <= n3 and (position - humanoidRootPart2.Position).Magnitude <= n3 then
							local flag4 = false

							for _, v22 in next, tbl9, nil do
								if (position - v22).Magnitude <= 55 then
									flag4 = true
									break
								end
							end

							if not flag4 then
								v21:AddTag("QuantumBringTag")
								n5 += 1
								if n5 >= 4 then
									return
								end
								continue
							end

							continue
						end
					end
				end
			end
		end

		v5:GetInstanceAddedSignal("QuantumBringTag"):Connect(function(arg)
			task.spawn(function()
				local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart") or arg.PrimaryPart
				local humanoid2 = arg:FindFirstChildOfClass("Humanoid")

				if not humanoidRootPart2 or not humanoid2 then
					pcall(function()
						arg:RemoveTag("QuantumBringTag")
					end)

					return
				end

				local name = arg.Name
				local bringBodyPos = humanoidRootPart2:FindFirstChild("BringBodyPos")

				if not bringBodyPos then
					bringBodyPos = Instance.new("BodyPosition")
					bringBodyPos.Name = "BringBodyPos"
					bringBodyPos.MaxForce = Vector3.new(1000000, 1000000, 1000000)
					bringBodyPos.P = 8000
					bringBodyPos.D = 600
					bringBodyPos.Position = humanoidRootPart2.Position
					bringBodyPos.Parent = humanoidRootPart2
				end

				local n3 = tick() + 25
				local n4 = 0

				while true do
					if config.BringMonster and arg.Parent and humanoidRootPart2.Parent and humanoid2.Health > 0 and arg:HasTag("QuantumBringTag") and tick() < n3 then
						local character2 = localPlayer.Character
						character2 = character2 and character2:FindFirstChild("HumanoidRootPart")
						local bringCache = tbl8.BringCache and tbl8.BringCache[name]
						local n5 = tonumber(config.BringMonsterRadius) or 350

						if character2 and bringCache then
							if (character2.Position - humanoidRootPart2.Position).Magnitude <= n5 + 50 then
								local v19 = next
								local children, v20 = arg:GetChildren()

								for _, v21 in v19, children, v20 do
									if v21:IsA("BasePart") then
										v21.CanCollide = false
									end
								end

								humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
								humanoidRootPart2.AssemblyAngularVelocity = Vector3.zero
								bringBodyPos.Position = bringCache.Position
								n4 = 0
							else
								n4 += 1
							end
						else
							n4 += 1
						end

						if not (n4 > 15) then
							task.wait(0.04)
							continue
						end
					end

					break
				end

				pcall(function()
					if bringBodyPos and bringBodyPos.Parent then
						bringBodyPos:Destroy()
					end

					if arg:HasTag("QuantumBringTag") then
						arg:RemoveTag("QuantumBringTag")
					end

					local v19 = next
					local children, v20 = arg:GetChildren()

					for _, v21 in v19, children, v20 do
						if v21:IsA("BasePart") then
							v21.CanCollide = true
						end
					end
				end)
			end)
		end)

		tbl8.MobsNextSpawn = function(arg, arg2)
			if tbl8.NextSpawnCooldown[arg2] then
				return task.wait()
			end
			tbl8.NextSpawnCooldown[arg2] = true
			task.wait(1)

			if not tbl8.SpawnCache[arg2] then
				local fortBuilderReplicatedSpawnPositi = RS:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")
				local v19 = next
				local children, v20 = fortBuilderReplicatedSpawnPositi:GetChildren()

				for _, v21 in v19, children, v20 do
					if v21:IsA("BasePart") then
						tbl8.SpawnCache[v21.Name] = tbl8.SpawnCache[v21.Name] or {}
						table.insert(tbl8.SpawnCache[v21.Name], v21.CFrame)
					end
				end
			end

			local v19 = tbl8.SpawnCache[arg2]
			if not v19 or #v19 == 0 then
				tbl8.NextSpawnCooldown[arg2] = nil
				return
			end
			tbl8.MobCycle[arg2] = (tbl8.MobCycle[arg2] or 0) % #v19 + 1
			tweenManager:topos(CFrame.new(v19[tbl8.MobCycle[arg2]].Position + Vector3.new(0, math.max(tonumber(config.PosY) or 15, 1), 0)))

			task.delay(1, function()
				tbl8.NextSpawnCooldown[arg2] = nil
			end)

			return arg:GetEnemies({ arg2 })
		end

		tbl8.StartQuest = function(arg, arg2, arg3, arg4)
			if config.BypassGetQuest then
				mods:FireInvoke("StartQuest", arg2, arg3)
				task.wait(0.3)
				return
			end

			local character2 = localPlayer.Character

			if character2 and character2:FindFirstChild("HumanoidRootPart") and arg:GetDistance(arg4) <= 25 then
				mods:FireInvoke("StartQuest", arg2, arg3)
				task.wait(0.5)
			else
				tweenManager:topos(arg4)
			end
		end

		tbl8.ServerHop = function(arg, arg2)
			hub.Scheduler.ServerHop(arg2)
		end

		tbl8.Rejoin = function()
			hub.Scheduler.Rejoin()
		end

		local tbl9 = {
			["Rocket-Rocket"] = 1,
			["Spin-Spin"] = 2,
			["Blade-Blade"] = 3,
			["Chop-Chop"] = 3,
			["Spring-Spring"] = 4,
			["Bomb-Bomb"] = 5,
			["Smoke-Smoke"] = 6,
			["Spike-Spike"] = 7,
			["Flame-Flame"] = 8,
			["Falcon-Falcon"] = 9,
			["Ice-Ice"] = 10,
			["Sand-Sand"] = 11,
			["Dark-Dark"] = 12,
			["Diamond-Diamond"] = 13,
			["Light-Light"] = 14,
			["Ghost-Ghost"] = 15,
			["Rubber-Rubber"] = 16,
			["Barrier-Barrier"] = 17,
			["Magma-Magma"] = 18,
		}

		tbl8.GetLowestFruit = function()
			local Net2 = require(RS.Modules.Net)

			local ok, result = pcall(function()
				return Net2:RemoteFunction("GetAllItemValues"):InvokeServer()
			end)

			if not ok or not result or type(result) ~= "table" then
				return nil
			end
			local tbl10 = {}

			for _, v19 in ipairs(result) do
				if v19.Key == "IsOwned" and v19.Value == true then
					tbl10[v19.ItemId] = true
				end
			end

			local huge = math.huge
			local tbl11 = nil

			for k in pairs(tbl10) do
				local ok2, result2 = pcall(function()
					return ItemConfig.match(k)
				end)

				if ok2 and result2 and result2.isOk and result2:isOk() then
					local v19 = result2:unwrap()

					if v19 and v19.Index and v19.Index.IdType == "PhysicalMoveset" then
						local str4 = tostring(v19.Index.DebugLabel or v19.Index.Name or "")
						local match = str4:match("^(.-)%s*%[") or str4
						local str5 = tostring(v19.Index.StorageKey or match)
						local v20 = tbl9[match] or tbl9[str5]

						if v20 and v20 < huge then
							tbl11 = { Name = match, RawName = match, StorageKey = str5, ItemId = k, Rank = v20 }
							huge = v20
						end
					end
				end
			end

			return tbl11
		end

		tbl8.GetDistance = function(arg, arg2)
			local humanoidRootPart2 = localPlayer.Character and (localPlayer.Character:FindFirstChild("HumanoidRootPart") or localPlayer.Character.PrimaryPart)
			if not humanoidRootPart2 or not arg2 then
				return math.huge
			end

			if typeof(arg2) ~= "Vector3" then
				if typeof(arg2) == "CFrame" then
					arg2 = arg2.Position
				elseif typeof(arg2) == "Instance" then
					local isBasePart = arg2:IsA("BasePart") and arg2

					if isBasePart then
						arg2 = isBasePart
					else
						arg2 = arg2:FindFirstChild("HumanoidRootPart") or arg2:FindFirstChild("Head") or arg2.PrimaryPart
					end

					arg2 = arg2 and arg2.Position
				else
					local v19 = nil

					if typeof(arg2) ~= "table" then
						arg2 = v19
					else
						local position = arg2.Position

						if position then
							arg2 = position
						else
							arg2 = arg2.CFrame and arg2.CFrame.Position
						end
					end
				end
			end

			return arg2 and (humanoidRootPart2.Position - arg2).Magnitude or math.huge
		end

		tbl8.GetRootPart = function(arg, arg2)
			if not arg2 then
				return nil
			end

			if arg2:IsA("BasePart") then
				return arg2
			end
			return arg2:FindFirstChild("HumanoidRootPart") or arg2:FindFirstChild("Head") or arg2.PrimaryPart or arg2:FindFirstChildWhichIsA("BasePart")
		end

		tbl8.AttackMob = function(arg)
			arg:AutoHaki()
			arg:EquipWeapon(config.AutoFarmWeapon)
		end

		tbl8.SafeTween = function(arg, arg2, arg3)
			if not arg2 then
				return
			end
			local flag4 = typeof(arg2) == "CFrame" and arg2
			local cframe

			if flag4 then
				cframe = flag4
			else
				cframe = typeof(arg2) == "Vector3" and CFrame.new(arg2) or nil
			end

			if not cframe and typeof(arg2) == "Instance" then
				cframe = arg:GetRootPart(arg2)
				cframe = cframe and cframe.CFrame
			end

			if not cframe then
				return
			end
			tweenManager:topos(cframe * CFrame.new(0, arg3 or tonumber(config.PosY) or 15, 0))
		end

		return tbl8
	end

	mods.Utilities = fn11()
	local utilities = mods.Utilities

	HasActiveQuest = function()
		local quest = localPlayer and localPlayer:FindFirstChild("PlayerGui") and localPlayer.PlayerGui:FindFirstChild("Main") and localPlayer.PlayerGui.Main:FindFirstChild("Quest")
		return quest ~= nil and quest.Visible == true
	end

	GetActiveQuestMob = function()
		if GuideModule and GuideModule.Data and GuideModule.Data.QuestData then
			local questData = GuideModule.Data.QuestData

			if questData.Task then
				local v19 = table.pack(a_1())
				if v19[1] then
					return tostring(v19[2])
				end
			end

			if questData.Name then
				return tostring(questData.Name)
			end
		end

		local quest = localPlayer and localPlayer:FindFirstChild("PlayerGui") and localPlayer.PlayerGui:FindFirstChild("Main") and localPlayer.PlayerGui.Main:FindFirstChild("Quest")

		if quest and quest.Visible then
			local container = quest:FindFirstChild("Container")
			local questTitle = container and container:FindFirstChild("QuestTitle")
			questTitle = questTitle and questTitle:FindFirstChild("Title")

			if questTitle and questTitle.Text and questTitle.Text ~= "" then
				local match = questTitle.Text:match("Defeat%s+%d+%s+(.-)%s+%(") or questTitle.Text:match("Defeat%s+(.-)%s+%(")
				if match then
					return match
				end
			end
		end

		return nil
	end

	VerifyQuest = function(arg)
		if not arg then
			return false
		end

		if not HasActiveQuest() then
			return false
		end
		local v19 = GetActiveQuestMob()

		if v19 then
			if type(arg) == "table" then
				for _, v20 in next, arg, nil do
					local flag4 = type(v20) == "string"

					if flag4 then
						flag4 = v20:lower() == v19:lower() or v19:lower():find(v20:lower(), 1, true) or v20:lower():find(v19:lower(), 1, true)
					end

					if flag4 then
						return true
					end
				end
			else
				local str4 = tostring(arg):lower()
				local str5 = v19:lower()
				if str4 == str5 or str5:find(str4, 1, true) or str4:find(str5, 1, true) then
					return true
				end
			end
		end

		local quest = localPlayer and localPlayer:FindFirstChild("PlayerGui") and localPlayer.PlayerGui:FindFirstChild("Main") and localPlayer.PlayerGui.Main:FindFirstChild("Quest")
		if not quest or not quest.Visible then
			return false
		end
		local container = quest:FindFirstChild("Container")
		local questTitle = container and container:FindFirstChild("QuestTitle")
		questTitle = questTitle and questTitle:FindFirstChild("Title")
		if not questTitle or not questTitle.Text or questTitle.Text == "" then
			return false
		end
		local str4 = questTitle.Text:gsub("-", ""):lower()

		if type(arg) == "table" then
			for _, v20 in next, arg, nil do
				if type(v20) ~= "string" then
					continue
				end
				local str5 = v20:gsub("-", ""):lower()
				if str4:find(str5, 1, true) then
					return true
				end
				local str6 = str5:gsub("man$", "m"):gsub("ies$", "y"):gsub("s$", "")
				if #str6 >= 4 and str4:find(str6, 1, true) then
					return true
				end
			end

			return false
		end

		local str5 = tostring(arg):gsub("-", ""):lower()
		if str4:find(str5, 1, true) then
			return true
		end
		local str6 = str5:gsub("man$", "m"):gsub("ies$", "y"):gsub("s$", "")
		if #str6 >= 4 and str4:find(str6, 1, true) then
			return true
		end
		return false
	end

	CheckQuest = function()
		local n = level and level.Value or 1
		local sea1 = flag and quests.Sea_1 or isSea2 and quests.Sea_2 or isSea3 and quests.Sea_3

		if HasActiveQuest() then
			local v19 = GetActiveQuestMob()

			if v19 and v19 ~= "" then
				if sea1 then
					for _, v20 in next, sea1, nil do
						if v20[3] and v20[3]:lower() == v19:lower() then
							return { v20[3], v20[4], v20[5], n }
						end

						if type(v20[6]) == "table" then
							for i = #v20, 6, -1 do
								local v21 = v20[i]
								if type(v21) == "table" and v21[1] and v21[1]:lower() == v19:lower() then
									return { v21[1], v21[3], v21[4], n }
								end
							end

							continue
						end

						if v20[6] and type(v20[6]) == "string" and v20[6]:lower() == v19:lower() then
							local tbl8 = {}
							local v21 = v20[6]
							local v22 = v20[4]
							local n2 = v20[5] or 1
							tbl8[1] = v21
							tbl8[2] = v22
							tbl8[3] = n2 + 1
							tbl8[4] = n
							return tbl8
						end
					end
				end

				return { v19, "", 0, n }
			end
		end

		if not sea1 then
			return { "", "", 0, n }
		end

		if flag and n >= 1 and n <= 9 then
			if tostring(localPlayer.Team) == "Marines" then
				return { "Trainee", "MarineQuest", 1, n }
			end
			return { "Bandit", "BanditQuest1", 1, n }
		end

		local questFarmMode = config.QuestFarmMode or "Double Quest"

		for k, v19 in next, sea1, nil do
			if n >= v19[1] and n <= v19[2] then
				if questFarmMode == "Single Quest" or questFarmMode == "1 Quest (Normal Only)" or questFarmMode == "1 Quest" then
					return { v19[3], v19[4], v19[5], n }
				end
				local tbl8

				if type(v19[6]) == "table" then
					tbl8 = nil

					for i = #v19, 6, -1 do
						local v20 = v19[i]

						if type(v20) == "table" and v20[1] and v20[2] and v20[3] and v20[4] then
							if n >= v20[2] and utilities:CheckMon(v20[1]) then
								tbl8 = { v20[1], v20[3], v20[4], n }
								break
							else
								tbl8 = nil
							end
						else
							tbl8 = nil
						end
					end
				else
					local flag4 = v19[6] and type(v19[6]) == "string"
					tbl8 = nil

					if flag4 then
						local v20 = v19[6]
						local flag5 = n >= (v19[7] or v19[1]) and utilities:CheckMon(v20)
						tbl8 = nil

						if flag5 then
							tbl8 = {}
							local v21 = v19[4]
							local n2 = v19[5] or 1
							tbl8[1] = v20
							tbl8[2] = v21
							tbl8[3] = n2 + 1
							tbl8[4] = n
						end
					end
				end

				if tbl8 then
					return tbl8
				end

				if questFarmMode == "Triple Quest" or questFarmMode == "Triple Quest (Normal + Boss + Nearby)" then
					if not utilities:CheckMon(v19[3]) and k > 1 then
						local v20 = sea1[k - 1]

						if v20 and n >= v20[1] and utilities:CheckMon(v20[3]) then
							local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
							local enemies2 = utilities:GetEnemies(v20[3])
							local humanoidRootPart3 = enemies2 and (enemies2:FindFirstChild("HumanoidRootPart") or enemies2.PrimaryPart)
							local magnitude = humanoidRootPart2 and humanoidRootPart3 and (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude or 0
							if magnitude <= 3000 or magnitude == 0 then
								return { v20[3], v20[4], v20[5], n }
							end
						end
					end
				end

				return { v19[3], v19[4], v19[5], n }
			end
		end

		local v19 = sea1[#sea1]

		if v19 then
			if questFarmMode ~= "Single Quest" and questFarmMode ~= "1 Quest (Normal Only)" and questFarmMode ~= "1 Quest" then
				if type(v19[6]) == "table" then
					for i = #v19, 6, -1 do
						local v20 = v19[i]

						if type(v20) == "table" and v20[1] and v20[2] and v20[3] and v20[4] then
							if n >= v20[2] and utilities:CheckMon(v20[1]) then
								return { v20[1], v20[3], v20[4], n }
							end
						end
					end
				elseif v19[6] and type(v19[6]) == "string" then
					local v20 = v19[6]

					if n >= (v19[7] or v19[1]) and utilities:CheckMon(v20) then
						local tbl8 = {}
						local v21 = v19[4]
						local n2 = v19[5] or 1
						tbl8[1] = v20
						tbl8[2] = v21
						tbl8[3] = n2 + 1
						tbl8[4] = n
						return tbl8
					end
				end
			end

			return { v19[3], v19[4], v19[5], n }
		end

		return { "", "", 0, n }
	end

	CheckBoss = function(arg)
		local sea3 = isSea3 and bossList.Sea_3 or isSea2 and bossList.Sea_2 or flag and bossList.Sea_1
		if not sea3 then
			return nil
		end

		for _, v19 in next, sea3, nil do
			if v19[2] == arg then
				return v19
			end
		end

		return nil
	end

	local lua4 = lua3

	mods.SendNotify = function(arg, arg2, arg3, arg4, arg5, arg6)
		pcall(function()
			if lua4 and lua4.Notification and lua4.Notification.Notify then
				lua4.Notification:Notify({ Title = arg2, Description = arg3, Buttons = arg5, Id = arg6 }, { Time = arg4 or 5 })
			end
		end)
	end

	local name = nil
	local v19 = nil
	local fn12 = nil
	local position = nil
	local humanoidRootPart2 = nil

	local function fn13()
		if humanoidRootPart2 then
			if typeof(humanoidRootPart2) == "Instance" then
				if humanoidRootPart2.Parent and humanoidRootPart2:IsDescendantOf(workspace) then
					local isModel = humanoidRootPart2:IsA("Model") and humanoidRootPart2 or humanoidRootPart2.Parent
					isModel = isModel and isModel:FindFirstChildOfClass("Humanoid")

					if not isModel or isModel.Health > 0 then
						if humanoidRootPart2:IsA("BasePart") then
							return humanoidRootPart2.Position
						end

						if humanoidRootPart2:IsA("Model") then
							local humanoidRootPart3 = humanoidRootPart2:FindFirstChild("HumanoidRootPart") or humanoidRootPart2:FindFirstChild("Head") or humanoidRootPart2.PrimaryPart
							if humanoidRootPart3 then
								return humanoidRootPart3.Position
							end
						end
					else
						humanoidRootPart2 = nil
					end
				else
					humanoidRootPart2 = nil
				end
			elseif typeof(humanoidRootPart2) == "Vector3" then
				return humanoidRootPart2
			end
		end

		if position then
			if typeof(position) == "Instance" then
				if position.Parent and position:IsDescendantOf(workspace) then
					local isModel = position:IsA("Model") and position or position.Parent
					isModel = isModel and isModel:FindFirstChildOfClass("Humanoid")

					if not isModel or isModel.Health > 0 then
						if position:IsA("BasePart") then
							return position.Position
						end

						if position:IsA("Model") then
							local humanoidRootPart3 = position:FindFirstChild("HumanoidRootPart") or position:FindFirstChild("Head") or position.PrimaryPart
							if humanoidRootPart3 then
								return humanoidRootPart3.Position
							end
						end
					else
						position = nil
					end
				else
					position = nil
				end
			else
				if typeof(position) == "Vector3" then
					return position
				end

				if typeof(position) == "CFrame" then
					return position.Position
				end
			end
		end

		local enableAimbot = config

		if config then
			enableAimbot = config.EnableAimbot or config.Aimbot
		end

		if enableAimbot and fn12 then
			local v20 = fn12()

			if v20 and v20.Character and v20.Character:IsDescendantOf(workspace) then
				local character2 = v20.Character
				local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

				if not humanoid2 or humanoid2.Health > 0 then
					local humanoidRootPart3 = character2:FindFirstChild("HumanoidRootPart") or character2:FindFirstChild("Head") or character2.PrimaryPart
					if humanoidRootPart3 then
						return humanoidRootPart3.Position
					end
				end
			end
		end

		return nil
	end

	local v20 = getrawmetatable(game)
	local namecall = v20.__namecall
	setreadonly(v20, false)

	v20.__namecall = newcclosure(function(arg, ...)
		local v21 = table.pack(...)
		local v22 = getnamecallmethod()
		local tbl8 = { ... }

		if not checkcaller() and (v22 == "FireServer" or v22 == "InvokeServer") then
			local v23 = fn13()

			if v23 and typeof(tbl8[1]) ~= "boolean" then
				for i = 1, math.min(6, #tbl8) do
					local v24 = tbl8[i]
					if typeof(v24) == "Vector3" then
						tbl8[i] = v23
						return namecall(arg, unpack(tbl8))
					end

					if typeof(v24) == "CFrame" then
						tbl8[i] = CFrame.new(v24.Position, v23)
						return namecall(arg, unpack(tbl8))
					end
				end
			end
		end

		return namecall(arg, table.unpack(v21, 1, v21.n))
	end)

	NPCPos = function(arg, arg2)
		local n = level and level.Value or 1

		local function fn14(arg3, arg4)
			if typeof(arg3) == "Instance" then
				if arg3:IsA("BasePart") then
					return arg3.CFrame
				end

				if arg3:IsA("Model") then
					return arg3:GetPivot()
				end
			else
				if typeof(arg3) == "CFrame" then
					return arg3
				end

				if typeof(arg3) == "Vector3" then
					return CFrame.new(arg3)
				end
			end

			if arg4 and type(arg4) == "table" then
				if arg4.CFrame and typeof(arg4.CFrame) == "CFrame" then
					return arg4.CFrame
				end

				if arg4.Position and typeof(arg4.Position) == "Vector3" then
					return CFrame.new(arg4.Position)
				end

				if arg4.Position and typeof(arg4.Position) == "CFrame" then
					return arg4.Position
				end
			end

			return nil
		end

		if GuideModule and GuideModule.Data and GuideModule.Data.NPCList then
			pcall(function()
				if GuideModule.ChangeQuest and arg2 then
					GuideModule.ChangeQuest(arg2)
				end
			end)

			if arg2 then
				for k, v21 in next, GuideModule.Data.NPCList, nil do
					if v21 and v21.InternalQuestName and string.lower(v21.InternalQuestName) == string.lower(arg2) then
						local v22 = fn14(k, v21)
						if v22 then
							return v22
						end
					end
				end
			end

			for k, v21 in next, GuideModule.Data.NPCList, nil do
				if v21 and v21.Levels and table.find(v21.Levels, n) then
					local v22 = fn14(k, v21)
					if v22 then
						return v22
					end
				end
			end

			local str4

			if arg2 then
				str4 = arg2:gsub("Quest.*", ""):gsub("%d+", ""):lower()
			else
				str4 = arg2
			end

			str4 = str4 or ""
			local match = arg and arg:match("^(%a+)")
			local str5

			if match then
				str5 = arg:match("^(%a+)"):lower()
			else
				str5 = match
			end

			str5 = str5 or ""

			for k, v21 in next, GuideModule.Data.NPCList, nil do
				if v21 and type(v21) == "table" then
					local str6 = tostring(v21.NPCName or ""):lower()
					local str7 = tostring(v21.InternalQuestName or ""):lower()

					if str4 ~= "" and (str6:find(str4, 1, true) or str7:find(str4, 1, true)) or str5 ~= "" and #str5 >= 4 and str6:find(str5, 1, true) then
						local v22 = fn14(k, v21)
						if v22 then
							return v22
						end
					end
				end
			end

			local lastClosestNPC = GuideModule.Data.LastClosestNPC

			if lastClosestNPC then
				for k, v21 in next, GuideModule.Data.NPCList, nil do
					if v21 and v21.NPCName == lastClosestNPC then
						local v22 = fn14(k, v21)
						if v22 then
							return v22
						end
					end
				end
			end
		end

		local function fn15(arg3)
			if not arg3 then
				return nil
			end
			local str4 = arg2

			if arg2 then
				str4 = arg2:gsub("Quest.*", ""):gsub("%d+", ""):lower()
			end

			str4 = str4 or ""
			local match = arg and arg:match("^(%a+)")

			if match then
				match = arg:match("^(%a+)"):lower()
			end

			match = match or ""
			local v21 = next
			local children, v22 = arg3:GetChildren()

			for _, v23 in v21, children, v22 do
				local str5 = v23.Name:lower()
				local flag4

				if str4 ~= "" and str5:find(str4, 1, true) and (str5:find("quest") or str5:find("giver")) then
					flag4 = true
				elseif match ~= "" and #match >= 4 and str5:find(match, 1, true) then
					flag4 = true
				else
					local pos = str5:find("quest") and arg2 and str5:find(arg2:lower():gsub("quest.*", ""))
					flag4 = false

					if pos then
						flag4 = true
					end
				end

				if flag4 then
					local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart
					if humanoidRootPart3 then
						return humanoidRootPart3.CFrame
					end
					return v23:GetPivot()
				end
			end

			return nil
		end

		local v21 = fn15(v2:FindFirstChild("NPCs")) or fn15(RS:FindFirstChild("NPCs"))
		if v21 then
			return v21
		end

		if arg then
			if not utilities.SpawnCache or not utilities.SpawnCache[arg] then
				local fortBuilderReplicatedSpawnPositi = RS:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")

				if fortBuilderReplicatedSpawnPositi then
					local v22 = next
					local children, v23 = fortBuilderReplicatedSpawnPositi:GetChildren()

					for _, v24 in v22, children, v23 do
						if v24:IsA("BasePart") then
							utilities.SpawnCache = utilities.SpawnCache or {}
							utilities.SpawnCache[v24.Name] = utilities.SpawnCache[v24.Name] or {}
							table.insert(utilities.SpawnCache[v24.Name], v24.CFrame)
						end
					end
				end
			end

			local spawnCache = utilities.SpawnCache and utilities.SpawnCache[arg]
			if spawnCache and #spawnCache > 0 then
				return spawnCache[1]
			end
		end

		if arg then
			local enemies2 = utilities:GetEnemies(arg)
			local humanoidRootPart3

			if enemies2 then
				humanoidRootPart3 = enemies2:FindFirstChild("HumanoidRootPart") or enemies2.PrimaryPart
			else
				humanoidRootPart3 = enemies2
			end

			if humanoidRootPart3 then
				return humanoidRootPart3.CFrame
			end
		end

		return nil
	end

	local n = 0
	local v21 = nil

	GetQuest = function()
		local v22 = CheckQuest()
		if not v22 or not v22[2] or v22[2] == "" then
			return
		end
		local v23 = v22[1]
		local v24 = v22[2]
		local v25 = v22[3]
		if HasActiveQuest() then
			return
		end

		if config.BypassGetQuest then
			mods:FireInvoke("StartQuest", v24, v25)

			if config.QuestDebounce then
				n = tick()
				v21 = v24
			end

			task.wait(0.3)

			if config.AutoSetSpawnPoint then
				mods:FireInvoke("SetSpawnPoint")
			end

			return
		end

		local v26 = NPCPos(v23, v24)
		if not v26 then
			return
		end

		if utilities:GetDistance(v26) <= 25 then
			mods:FireInvoke("StartQuest", v24, v25)

			if config.QuestDebounce then
				n = tick()
				v21 = v24
			end

			task.wait(0.3)
		elseif localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local position2 = localPlayer.Character.HumanoidRootPart.Position
			local position3 = typeof(v26) == "CFrame" and v26.Position or typeof(v26) == "Vector3" and v26 or v26.Position
			tweenManager:topos(CFrame.new(position3 - ((position3 - position2).Magnitude > 5 and (position3 - position2).Unit * 5 or Vector3.zero)))
		else
			tweenManager:topos(v26)
		end

		if config.AutoSetSpawnPoint then
			mods:FireInvoke("SetSpawnPoint")
		end
	end

	local tbl8 = {
		["Blox Fruit"] = { tooltip = "Blox Fruit", keys = "BloxFruitKeys", delay = "BloxFruitDelay" },
		Melee = { tooltip = "Melee", keys = "MeleeKeys", delay = "MeleeDelay" },
		Sword = { tooltip = "Sword", keys = "SwordKeys", delay = "SwordDelay" },
		Gun = { tooltip = "Gun", keys = "GunKeys", delay = "GunDelay" },
	}

	local function fn14()
		if not config.AutoSkills then
			return
		end

		if not humanoid then
			return
		end
		local selectSkills = config.SelectSkills
		local tbl9 = type(selectSkills) == "table" and selectSkills or { selectSkills }

		for _, v22 in next, tbl9, nil do
			local v23 = tbl8[v22]

			if v23 then
				local character2 = localPlayer.Character
				character2 = character2 and character2:FindFirstChildWhichIsA("Tool")

				if not character2 or character2.ToolTip ~= v23.tooltip then
					local v24 = next
					local children, v25 = localPlayer.Backpack:GetChildren()

					for _, v26 in v24, children, v25 do
						if v26:IsA("Tool") and v26.ToolTip == v23.tooltip then
							humanoid:EquipTool(v26)
							task.wait(0.5)
							break
						end
					end
				end

				local n2 = (config[v23.delay] or 300) / 1000
				local v24 = config[v23.keys]
				local tbl10 = type(v24) == "table" and v24 or { v24 }

				for _, v25 in next, tbl10, nil do
					local flag4 = typeof(v25) == "EnumItem" and v25 or Enum.KeyCode[v25]

					if flag4 then
						local n3 = (config["HoldTime_" .. (typeof(v25) == "EnumItem" and v25.Name or tostring(v25))] or 0) / 1000
						v8:SendKeyEvent(true, flag4, false, game)

						if n3 > 0 then
							task.wait(n3)
						else
							task.wait()
						end

						v8:SendKeyEvent(false, flag4, false, game)
						task.wait(n2)
					end
				end
			end
		end
	end

	checkv3boss = function()
		return utilities:CheckMon("Diamond") or utilities:CheckMon("Orbitus") or utilities:CheckMon("Jeremy")
	end

	EquipSword = function(arg)
		if not localPlayer.Character:FindFirstChild(arg) then
			mods:FireInvoke("LoadItem", arg)
		end
	end

	PostWebhook = function(arg, arg2)
		if not arg or arg == "" or typeof(arg) ~= "string" or not arg:find("http") then
			return
		end

		task.spawn(function()
			pcall(function()
				fn2({
					Url = arg,
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body = typeof(arg2) == "table" and v9:JSONEncode(arg2) or tostring(arg2),
				})
			end)
		end)
	end

	WeeboLogs = function(arg, arg2)
		local tbl9 = arg2 or {}
		local str4 = ">>> **User:** " .. localPlayer.Name .. "\n**Event:** " .. arg

		if tbl9.Position then
			str4 ..= "\n**Distance:** " .. math.floor(localPlayer:DistanceFromCharacter(tbl9.Position)) .. "m"
		end

		if tbl9.Extra then
			str4 ..= "\n" .. tbl9.Extra
		end

		local tbl10 = { { name = "Event Details", value = str4, inline = true } }

		if tbl9.Field2 then
			table.insert(tbl10, {
				name = tbl9.Field2.name or "Info",
				value = "```\n" .. tostring(tbl9.Field2.value) .. "\n```",
				inline = false,
			})
		end

		local flag4 = config and config.WebhookPingId and config.WebhookPingId ~= ""
		local str5 = nil

		if flag4 then
			if config.WebhookPingOnEvents and (arg:find("Mirage") or arg:find("Kitsune") or arg:find("Prehistoric")) then
				str5 = "<@" .. config.WebhookPingId .. ">"
			else
				local webhookPingOnMythical = config.WebhookPingOnMythical

				if webhookPingOnMythical then
					webhookPingOnMythical = tostring(tbl9.Extra):find("Dragon") or tostring(tbl9.Extra):find("Kitsune") or tostring(tbl9.Extra):find("Leopard") or tostring(tbl9.Extra):find("T-Rex") or tostring(tbl9.Extra):find("Mammoth") or tostring(tbl9.Extra):find("Dough")
				end

				str5 = nil

				if webhookPingOnMythical then
					str5 = "<@" .. config.WebhookPingId .. ">"
				end
			end
		end

		return {
			content = str5,
			embeds = {
				{
					type = "rich",
					color = 8202738,
					fields = tbl10,
					thumbnail = {
						url = "https://cdn.discordapp.com/attachments/1262751352791236620/1505931000948068513/Screenshot_2026-04-18_235959.png?ex=6a0c6b09&is=6a0b1989&hm=f43a97cbb0b52c83e79ef0247dac0e986d46d7455506a50e106993d36c1dea4b&",
					},
					timestamp = DateTime.now():ToIsoDate(),
				},
			},
		}
	end

	local function fn15(arg)
		local v22, v23, v24 = string.match(tostring(arg), "^([^%d]*%d)(%d*)(.-)$")
		if not v22 then
			return tostring(arg)
		end
		return v22 .. v23:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v24
	end

	local function fn16(arg)
		local n2 = math.floor(arg % 60)
		local n3 = math.floor(arg / 60 % 60)
		return string.format("%02d:%02d:%02d", math.floor(arg / 3600), n3, n2)
	end

	local function fn17()
		if not localPlayer.Character then
			return "None"
		end
		local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
		if tool then
			return tool.Name .. " (" .. (tool.ToolTip ~= "" and tool.ToolTip or "Weapon") .. ")"
		end
		return "None"
	end

	local function fn18()
		local tbl9 = {}

		for k in next, {
			{ "AutoFarmLevel", "Level Farm" },
			{ "AutoBone", "Bone Farm" },
			{ "AutoCakePrince", "Cake Prince" },
			{ "AutoDoughKing", "Dough King" },
			{ "AutoTaskEliteHunter", "Elite Hunter" },
			{ "AutoChest", "Chest Farm" },
			{ "AutoMaterial", "Material Farm" },
			{ "AutoRaid", "Raid / Dungeon" },
			{ "AutoTrialDracoTP", "Draco Trial" },
			{ "AutoSeaEvents", "Sea Events" },
			{ "AutoFish", "Fish Farm" },
			{ "AutoTTK", "True Triple Katana" },
			{ "AutoSoulReaper", "Soul Reaper" },
			{ "AutoFactoryRaid", "Factory Raid" },
			{ "AutoFarmPirateRaid", "Pirate Raid" },
			{ "AutoKaitun", "Quantum Kaitun" },
			{ "AutoFindLeviatan", "Leviathan Hunt" },
		}, nil do
			if config[f[1]] then
				table.insert(tbl9, "[ON] " .. f[2])
			end
		end

		if #tbl9 == 0 then
			return "None (Idle)"
		end
		return table.concat(tbl9, "\n")
	end

	hub.Webhook.SendDataLog = function(arg, arg2, arg3)
		local dataLogWebhookUrl = config.DataLogWebhookUrl and config.DataLogWebhookUrl ~= "" and config.DataLogWebhookUrl or config.Webhook
		if not dataLogWebhookUrl or dataLogWebhookUrl == "" or typeof(dataLogWebhookUrl) ~= "string" or not dataLogWebhookUrl:find("http") then
			return
		end
		local n2 = level and level.Value or 0
		local n3 = beli and beli.Value or 0
		local n4 = fragments and fragments.Value or 0
		local n5 = math.max(0, n2 - hub.Runtime.StartLevel)
		local n6 = math.max(0, n3 - hub.Runtime.StartBeli)
		local n7 = math.max(0, n4 - hub.Runtime.StartFragments)
		local str4 = flag and "Sea 1 (Old World)" or isSea2 and "Sea 2 (Dressrosa)"
		local str5

		if str4 then
			str5 = str4
		else
			local v22 = isSea3

			if isSea3 then
				str5 = "Sea 3 (Zou)"
			else
				str5 = v22
			end
		end

		str5 = str5 or "Unknown Sea"
		local str6 = localPlayer:FindFirstChild("leaderstats") and localPlayer.leaderstats:FindFirstChild("Bounty/Honor") and localPlayer.leaderstats["Bounty/Honor"].Value or "N/A"
		local activeFunction = mods.ActiveFunction or "Idle"
		local startTime = hub.Runtime.StartTime
		local v22 = fn16(tick() - startTime)
		local n8 = math.floor(v2:GetRealPhysicsFPS())
		local n9 = 0

		pcall(function()
			n9 = math.floor(tonumber(v14.Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")) or 0)
		end)

		local tbl9 = {}

		local tbl10 = {
			name = "Player Profile",
			value = "**User:** " .. localPlayer.Name .. " (`" .. localPlayer.UserId .. "`)\n**Sea:** " .. str5 .. "\n**Bounty/Honor:** " .. fn15(str6),
			inline = true,
		}

		local tbl11 = {
			name = "Statistics",
			value = "**Level:** " .. fn15(n2) .. " *(+" .. fn15(n5) .. ")*\n**Beli:** $" .. fn15(n3) .. " *(+$" .. fn15(n6) .. ")*\n**Fragments:** Frags: " .. fn15(n4) .. " *(+" .. fn15(n7) .. ")*",
			inline = true,
		}

		local tbl12 = {
			name = "Equipment & Status",
			value = "**Active Farm:** `" .. activeFunction .. "`\n**Equipped:** " .. fn17() .. "\n**Elapsed Time:** " .. v22 .. "\n**Performance:** " .. n8 .. " FPS | " .. n9 .. " ms",
			inline = false,
		}

		tbl9[1] = tbl10
		tbl9[2] = tbl11
		tbl9[3] = tbl12

		if config.SendWebhookInventory ~= false then
			local tbl13 = {}
			local tbl14 = {}
			local tbl15 = {}
			local tbl16 = {}
			local tbl17 = {}

			pcall(function()
				local response = Net:RemoteFunction("GetAllItemValues"):InvokeServer()

				if response and typeof(response) == "table" then
					local tbl18 = {}

					for _, v23 in next, response, nil do
						local str7 = tostring(v23.ItemId) .. "_" .. tostring(v23.NetworkedUID)
						tbl18[str7] = tbl18[str7] or { ItemId = v23.ItemId, UID = v23.NetworkedUID, Attributes = {} }

						if v23.Value ~= nil then
							tbl18[str7].Attributes[v23.Key] = v23.Value
						end
					end

					for _, v23 in next, tbl18, nil do
						local attributes = v23.Attributes

						if attributes.IsOwned == true or attributes.Quantity and attributes.Quantity > 0 then
							local ok, result = pcall(function()
								return ItemConfig.match(v23.ItemId)
							end)

							local isOk = ok and result and result.isOk and result:isOk()
							local str7 = ""

							if isOk then
								local v24 = result:unwrap()

								if v24 and v24.Index and v24.Index.DebugLabel then
									str7 = tostring(v24.Index.DebugLabel)
								end
							end

							local str8 = (str7:match("^(.-)%s*%[") or str7):gsub("^%-%-%s*", "")
							local match = str7:match("%[(.-)%]") or ""
							local quantity = attributes.Quantity or 1

							if match:find("PhysicalMoveset") or match:find("Fruit") then
								table.insert(tbl13, (str8:match("^(.-)%-") or str8) .. (quantity > 1 and " (x" .. quantity .. ")" or ""))
							elseif match:find("Accessory") then
								table.insert(tbl16, str8)
							elseif match:find("Material") then
								table.insert(tbl17, str8 .. " (" .. quantity .. ")")
							end
						end
					end
				end
			end)

			pcall(function()
				local response = commF:InvokeServer("getInventoryWeapons")

				if response and typeof(response) == "table" then
					for k in next, response, nil do
						if w.Type == "Sword" or not w.Type then
							table.insert(tbl14, w.Name)
						elseif w.Type == "Gun" then
							table.insert(tbl15, w.Name)
						end
					end
				end
			end)

			table.sort(tbl13)
			table.sort(tbl14)
			table.sort(tbl17)
			local str7 = #tbl13 > 0 and table.concat(tbl13, ", ") or "None"

			if #str7 > 900 then
				str7 = str7:sub(1, 897) .. "..."
			end

			table.insert(tbl9, {
				name = "Fruit Storage (" .. #tbl13 .. " Fruits)",
				value = "```\n" .. str7 .. "\n```",
				inline = false,
			})

			local str8 = #tbl14 > 0 and table.concat(tbl14, ", ") or "None"

			if #str8 > 900 then
				str8 = str8:sub(1, 897) .. "..."
			end

			table.insert(tbl9, { name = "Owned Swords (" .. #tbl14 .. ")", value = "```\n" .. str8 .. "\n```", inline = false })

			if #tbl17 > 0 then
				local str9 = table.concat(tbl17, ", ")

				if #str9 > 900 then
					str9 = str9:sub(1, 897) .. "..."
				end

				table.insert(tbl9, { name = "Materials (" .. #tbl17 .. ")", value = "```\n" .. str9 .. "\n```", inline = false })
			end
		end

		if config.SendWebhookFarmsAll then
			table.insert(tbl9, { name = "Farms All Status", value = "```\n" .. fn18() .. "\n```", inline = false })
		end

		if arg3 then
			table.insert(tbl9, { name = "Log Details", value = arg3, inline = false })
		end

		PostWebhook(dataLogWebhookUrl, {
			embeds = {
				{
					title = arg2 or "Quantum Onyx - Blox Fruit Data Log",
					type = "rich",
					color = 3066993,
					fields = tbl9,
					thumbnail = {
						url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. localPlayer.UserId .. "&width=420&height=420&format=png",
					},
					footer = { text = "Quantum Onyx | " .. os.date("%X") },
					timestamp = DateTime.now():ToIsoDate(),
				},
			},
		})

		hub.Runtime.LastDataLogTick = tick()
	end

	hub.Webhook.LogError = function()
	end

	local tbl9 = {}

	mods.GetPedestal = function()
		if not map:FindFirstChild("Turtle") or not map.Turtle:FindFirstChild("Cursed") then
			return nil
		end
		local cursed = map.Turtle.Cursed
		if tbl9.Evil == 3 and cursed:FindFirstChild("Pedestal2") then
			return cursed.Pedestal2
		end

		if tbl9.Good == 3 and cursed:FindFirstChild("Pedestal1") then
			return cursed.Pedestal1
		end

		if tbl9.Evil == 4 and tbl9.Good == 4 and cursed:FindFirstChild("Pedestal3") then
			return cursed.Pedestal3
		end
		return nil
	end

	mods.CDKProgress = function()
		local CDKQuest = mods:FireInvoke("CDKQuest", "Progress")
		if type(CDKQuest) ~= "table" then
			return "None"
		end
		local evil = CDKQuest.Evil or -2
		local good = CDKQuest.Good or -2
		tbl9.Evil = evil
		tbl9.Good = good
		tbl9.Finished = CDKQuest.Finished or false
		local flag4 = CDKQuest.Finished == true
		local flag5

		if flag4 then
			flag5 = flag4
		else
			flag5 = evil == 4 and good == 4
		end

		if flag5 then
			return "Alucard Boss"
		end

		if good == 0 or good == -3 then
			return "Boat Quest"
		end

		if good == 1 or good == -4 then
			return "Raid Quest"
		end

		if good == 2 or good == -5 then
			return "Heavenly Quest"
		end

		if good == 3 then
			return "Burn Tushita Scroll"
		end

		if evil == 0 or evil == -3 then
			return "Pain Quest"
		end

		if evil == 1 or evil == -4 then
			return "Haze Quest"
		end

		if evil == 2 or evil == -5 then
			return "Hell Quest"
		end

		if evil == 3 then
			return "Burn Yama Scroll"
		end

		if good == -2 and evil == -2 then
			local Tushita = utilities:CheckToolName("Tushita")

			if not Tushita then
				Tushita = (utilities:CheckInventory("Moveset", "Tushita") or 0) >= 350
			end

			if Tushita then
				return "Start Tushita"
			end
			return "Start Yama"
		end

		if good == -2 then
			return "Start Tushita"
		end

		if evil == -2 then
			return "Start Yama"
		end
		return "None"
	end

	local function fn19(arg)
		for _, v22 in ipairs(arg) do
			sethiddenproperty(localPlayer, "SimulationRadius", math.huge)

			if v22:FindFirstChild("Humanoid") then
				v22.Humanoid.Health = 0
			end

			if v22:FindFirstChild("HumanoidRootPart") then
				v22.HumanoidRootPart.CanCollide = false
			end
		end
	end

	RemoveEffects = function()
		return function()
			local container = RS.Effect.Container
			local CameraShaker = require(RS.Util.CameraShaker)
			local Death = require(container:FindFirstChild("Death"))
			local Respawn = require(container:FindFirstChild("Respawn"))
			local LevelUp = require(container:FindFirstChild("LevelUp"))

			hookfunction(Death, function()
			end)

			hookfunction(LevelUp, function()
			end)

			hookfunction(Respawn, function()
			end)

			CameraShaker:Stop()
		end
	end

	round = function(arg)
		return math.floor(arg + 0.5)
	end

	GetHeadshotImage = function(arg)
		return string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", arg)
	end

	mods._ActiveESPs = mods._ActiveESPs or {}

	ClearESP = function(arg)
		for k, v22 in next, mods._ActiveESPs, nil do
			if not arg or v22.Category == arg then
				if v22.Folder and v22.Folder.Parent then
					pcall(function()
						v22.Folder:Destroy()
					end)
				end

				mods._ActiveESPs[k] = nil
			end
		end
	end

	AddESP = function(adornee, color, arg, arg2, arg3, arg4)
		if not adornee or adornee:FindFirstChild("ESPquantumONYX") then
			return
		end
		local folder = Instance.new("Folder", adornee)
		folder.Name = "ESPquantumONYX"
		mods._ActiveESPs[adornee] = { Folder = folder, Category = arg4 or "General" }
		local n2 = math.clamp(adornee.Size.Y / 2 + 2.2, 2.6, 40)

		if arg4 == "Player" then
			n2 = 2.4
		end

		local billboardGui = Instance.new("BillboardGui", folder)
		billboardGui.Name = "ESP_Billboard"
		billboardGui.Adornee = adornee
		billboardGui.Size = UDim2.new(0, 260, 0, arg3 and 42 or 26)
		billboardGui.StudsOffset = Vector3.new(0, n2, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.LightInfluence = 0
		billboardGui.MaxDistance = 100000
		billboardGui.ClipsDescendants = false
		local frame = Instance.new("Frame", billboardGui)
		frame.Name = "IconContainer"
		frame.Size = UDim2.new(0, 28, 0, 28)
		frame.Position = UDim2.new(0, 0, 0.5, -14)
		frame.BackgroundTransparency = 0.25
		frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
		Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
		local uiStroke = Instance.new("UIStroke", frame)
		uiStroke.Color = color or Color3.fromRGB(255, 255, 255)
		uiStroke.Thickness = 1.2
		local imageLabel = Instance.new("ImageLabel", frame)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Size = UDim2.new(1, 0, 1, 0)
		imageLabel.Image = "rbxassetid://0"
		Instance.new("UICorner", imageLabel).CornerRadius = UDim.new(1, 0)
		local frame2 = Instance.new("Frame", billboardGui)
		frame2.Name = "InfoContainer"
		frame2.BackgroundTransparency = 1
		frame2.Position = UDim2.new(0, 0, 0, 0)
		frame2.Size = UDim2.new(1, 0, 1, 0)
		frame2.ClipsDescendants = false
		local textLabel = Instance.new("TextLabel", frame2)
		textLabel.Name = "NameLabel"
		textLabel.BackgroundTransparency = 1
		textLabel.TextSize = 12
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextStrokeTransparency = 0.2
		textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.RichText = true
		local frame3 = nil
		local frame4 = nil
		local uiStroke2 = nil
		local textLabel2 = nil
		local frame5 = nil
		local frame6 = nil
		local uiStroke3 = nil
		local textLabel3 = nil

		if arg3 then
			textLabel.Size = UDim2.new(1, 0, 0, 16)
			textLabel.Position = UDim2.new(0, 0, 0, 1)
			textLabel.TextYAlignment = Enum.TextYAlignment.Center
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			local frame7 = Instance.new("Frame", frame2)
			frame7.Name = "BarsContainer"
			frame7.BackgroundTransparency = 1
			frame7.Size = UDim2.new(0, 160, 0, 13)
			frame7.Position = UDim2.new(0, 0, 0, 19)
			frame7.ClipsDescendants = false
			frame3 = Instance.new("Frame", frame7)
			frame3.Name = "HealthBar"
			frame3.Size = UDim2.new(0, 76, 0, 13)
			frame3.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			frame3.BackgroundTransparency = 0.3
			frame3.BorderSizePixel = 0
			frame3.ClipsDescendants = true
			Instance.new("UICorner", frame3).CornerRadius = UDim.new(0, 3)
			uiStroke2 = Instance.new("UIStroke", frame3)
			uiStroke2.Color = Color3.fromRGB(50, 255, 100)
			uiStroke2.Thickness = 0.8
			uiStroke2.Transparency = 0.4
			frame4 = Instance.new("Frame", frame3)
			frame4.Name = "Fill"
			frame4.Size = UDim2.new(1, 0, 1, 0)
			frame4.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
			frame4.BackgroundTransparency = 0.35
			frame4.BorderSizePixel = 0
			Instance.new("UICorner", frame4).CornerRadius = UDim.new(0, 3)
			textLabel2 = Instance.new("TextLabel", frame3)
			textLabel2.Name = "HealthText"
			textLabel2.BackgroundTransparency = 1
			textLabel2.Size = UDim2.new(1, 0, 1, 0)
			textLabel2.TextSize = 9
			textLabel2.Font = Enum.Font.GothamBold
			textLabel2.TextStrokeTransparency = 0.15
			textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
			textLabel2.RichText = true
			frame5 = Instance.new("Frame", frame7)
			frame5.Name = "EnergyBar"
			frame5.Size = UDim2.new(0, 76, 0, 13)
			frame5.Position = UDim2.new(0, 80, 0, 0)
			frame5.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			frame5.BackgroundTransparency = 0.3
			frame5.BorderSizePixel = 0
			frame5.ClipsDescendants = true
			Instance.new("UICorner", frame5).CornerRadius = UDim.new(0, 3)
			uiStroke3 = Instance.new("UIStroke", frame5)
			uiStroke3.Color = Color3.fromRGB(70, 180, 255)
			uiStroke3.Thickness = 0.8
			uiStroke3.Transparency = 0.4
			frame6 = Instance.new("Frame", frame5)
			frame6.Name = "Fill"
			frame6.Size = UDim2.new(1, 0, 1, 0)
			frame6.BackgroundColor3 = Color3.fromRGB(70, 180, 255)
			frame6.BackgroundTransparency = 0.35
			frame6.BorderSizePixel = 0
			Instance.new("UICorner", frame6).CornerRadius = UDim.new(0, 3)
			textLabel3 = Instance.new("TextLabel", frame5)
			textLabel3.Name = "EnergyText"
			textLabel3.BackgroundTransparency = 1
			textLabel3.Size = UDim2.new(1, 0, 1, 0)
			textLabel3.TextSize = 9
			textLabel3.Font = Enum.Font.GothamBold
			textLabel3.TextStrokeTransparency = 0.15
			textLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
			textLabel3.RichText = true
		else
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.Position = UDim2.new(0, 0, 0, 0)
			textLabel.TextYAlignment = Enum.TextYAlignment.Center
			textLabel.TextXAlignment = Enum.TextXAlignment.Center
		end

		local str4 = ""
		local str5 = ""

		task.spawn(function()
			while task.wait(0.1) do
				if not billboardGui or not billboardGui.Parent or not adornee or not adornee.Parent then
					mods._ActiveESPs[adornee] = nil
					break
				else
					pcall(function()
						local text = arg and arg() or ""

						if text ~= str4 then
							str4 = text
							textLabel.Text = text
						end

						if arg2 then
							local image = arg2() or ""

							if image ~= str5 then
								str5 = image

								if image ~= "" and image ~= "rbxassetid://0" then
									imageLabel.Image = image
									frame.Visible = true
									frame2.Position = UDim2.new(0, 34, 0, 0)
									frame2.Size = UDim2.new(1, -34, 1, 0)
									textLabel.TextXAlignment = Enum.TextXAlignment.Left
								else
									frame.Visible = false
									frame2.Position = UDim2.new(0, 0, 0, 0)
									frame2.Size = UDim2.new(1, 0, 1, 0)

									if not arg3 then
										textLabel.TextXAlignment = Enum.TextXAlignment.Center
									end
								end
							end
						elseif frame.Visible then
							frame.Visible = false
							frame2.Position = UDim2.new(0, 0, 0, 0)
							frame2.Size = UDim2.new(1, 0, 1, 0)

							if not arg3 then
								textLabel.TextXAlignment = Enum.TextXAlignment.Center
							end
						end

						if arg3 and frame3 then
							local v22, v23, v24, v25, v26, v27 = arg3()

							if v22 then
								frame3.Visible = true
								frame4.Size = UDim2.new(math.clamp(v22, 0, 1), 0, 1, 0)

								if v23 then
									frame4.BackgroundColor3 = v23
									uiStroke2.Color = v23
								end

								textLabel2.Text = v24 or ""
							else
								frame3.Visible = false
							end

							if v25 and frame5 then
								frame5.Visible = true
								frame6.Size = UDim2.new(math.clamp(v25, 0, 1), 0, 1, 0)

								if v26 then
									frame6.BackgroundColor3 = v26
									uiStroke3.Color = v26
								end

								textLabel3.Text = v27 or ""
							elseif frame5 then
								frame5.Visible = false
							end
						end
					end)
				end
			end
		end)
	end

	PlayerESP = function()
		if not config.ESPPlayer then
			return
		end
		local character2 = localPlayer.Character

		if character2 then
			if not character2:FindFirstChild("Head") then
				character2:FindFirstChild("HumanoidRootPart")
			end
		end

		local v22 = next
		local players, v23 = v3:GetPlayers()

		for _, v24 in v22, players, v23 do
			if v24 ~= localPlayer and v24.Character then
				local head = v24.Character:FindFirstChild("Head") or v24.Character:FindFirstChild("HumanoidRootPart")
				local humanoid2 = v24.Character:FindFirstChildOfClass("Humanoid") or v24.Character:FindFirstChild("Humanoid")

				if head and humanoid2 and humanoid2.Health > 0 and not head:FindFirstChild("ESPquantumONYX") then
					local flag4 = localPlayer.Team ~= nil and v24.Team ~= nil and v24.Team == localPlayer.Team

					AddESP(head, flag4 and Color3.fromRGB(0, 255, 140) or Color3.fromRGB(255, 60, 60), function()
						local character3 = localPlayer.Character

						if character3 then
							character3 = character3:FindFirstChild("Head") or character3:FindFirstChild("HumanoidRootPart")
						end

						local n2 = character3 and head and head.Parent and math.floor((character3.Position - head.Position).Magnitude) or 0
						local data2 = v24:FindFirstChild("Data")
						return string.format("<b>%s</b> <font color='rgb(255,215,0)'>[Lv. %s]</font> • <font color='rgb(210,210,210)'>%dm</font>", v24.DisplayName or v24.Name, data2 and data2:FindFirstChild("Level") and tostring(data2.Level.Value) or "?", n2)
					end, function()
						return GetHeadshotImage(v24.UserId)
					end, function()
						local character3 = v24.Character
						if not (character3 and character3:FindFirstChildOfClass("Humanoid")) then
							return 0, Color3.fromRGB(50, 255, 100), "", nil, nil, nil
						end
						local humanoid3 = character3:FindFirstChildOfClass("Humanoid")
						local n2 = math.floor(humanoid3.Health)
						local n3 = math.max(math.floor(humanoid3.MaxHealth), 1)
						local n4 = math.clamp(n2 / n3, 0, 1)
						local color = flag4 and Color3.fromRGB(0, 255, 140) or Color3.fromRGB(50, 255, 100)
						local str4 = string.format("%d/%d HP", n2, n3)
						local energy = character3:FindFirstChild("Energy")
						local n5, n6

						if energy and energy.Value ~= nil then
							n5 = math.floor(tonumber(energy.Value) or 0)
							n6 = math.max(tonumber(energy.MaxValue) or 100, 1)
						else
							local data2 = v24:FindFirstChild("Data")
							local level2 = data2 and data2:FindFirstChild("Stats") and data2.Stats:FindFirstChild("Melee") and data2.Stats.Melee:FindFirstChild("Level")
							n6 = 100
							n5 = 100

							if level2 then
								n6 = 100 + (tonumber(data2.Stats.Melee.Level.Value) or 1) * 5
								n5 = n6
							end
						end

						return n4, color, str4, math.clamp(n5 / n6, 0, 1), Color3.fromRGB(70, 180, 255), (string.format("%d/%d EN", n5, n6))
					end, "Player")
				end
			end
		end
	end

	local function fn20(player)
		if player == localPlayer then
			return
		end

		player.CharacterAdded:Connect(function()
			task.wait(0.4)

			if config.ESPPlayer then
				pcall(PlayerESP)
			end
		end)
	end

	for _, player in ipairs(v3:GetPlayers()) do
		fn20(player)
	end

	v3.PlayerAdded:Connect(fn20)

	IslandESP = function()
		if not config.ESPIsland then
			return
		end
		local head = localPlayer.Character and localPlayer.Character:FindFirstChild("Head")
		local v22 = next
		local children, v23 = worldOrigin.Locations:GetChildren()

		for _, v24 in v22, children, v23 do
			if v24:IsA("BasePart") and v24.Name ~= "Sea" and not v24:FindFirstChild("ESPquantumONYX") then
				AddESP(v24, Color3.fromRGB(100, 200, 255), function()
					return string.format("<b><font color='rgb(100,200,255)'>%s</font></b>\n<font color='rgb(200,200,200)'>%d studs</font>", v24.Name, head and math.floor((head.Position - v24.Position).Magnitude) or 0)
				end, nil, nil, "Island")
			end
		end
	end

	FruitESP = function()
		if not config.DevilFruitESP then
			return
		end
		local v22 = next
		local children, v23 = v2:GetChildren()

		for _, v24 in v22, children, v23 do
			if v24:IsA("Model") and string.find(v24.Name, "Fruit") then
				local handle = v24:FindFirstChild("Handle") or v24.PrimaryPart

				if handle and not handle:FindFirstChild("ESPquantumONYX") then
					local name2 = v24.Name == "Fruit" and "Spawned Fruit" or v24.Name

					AddESP(handle, Color3.fromRGB(255, 170, 0), function()
						local character2 = localPlayer.Character

						if character2 then
							character2 = character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
						end

						return string.format("Fruit: <b><font color='rgb(255,170,0)'>%s</font></b>\n<font color='rgb(220,220,220)'>%d studs away</font>", name2, character2 and math.floor((character2.Position - handle.Position).Magnitude) or 0)
					end, nil, nil, "Fruit")
				end
			end
		end
	end

	ChestESP = function()
		if not config.ESPChest then
			return
		end
		local chestModels = v2:FindFirstChild("ChestModels")
		if not chestModels then
			return
		end
		local v22 = next
		local children, v23 = chestModels:GetChildren()

		for _, v24 in v22, children, v23 do
			local rootPart = v24:FindFirstChild("RootPart")

			if rootPart and not rootPart:FindFirstChild("ESPquantumONYX") then
				local str4 = v24.Name:lower()
				local color = Color3.fromRGB(255, 255, 255)
				local str5 = "rbxassetid://0"
				local str6 = "Chest"

				if str4:find("silver") then
					color = Color3.fromRGB(210, 210, 220)
					str5 = "rbxassetid://97335861533611"
					str6 = "Silver Chest"
				elseif str4:find("gold") then
					color = Color3.fromRGB(255, 215, 0)
					str5 = "rbxassetid://103232045481498"
					str6 = "Gold Chest"
				elseif str4:find("diamond") then
					color = Color3.fromRGB(0, 230, 255)
					str5 = "rbxassetid://103232045481498"
					str6 = "Diamond Chest"
				end

				AddESP(rootPart, color, function()
					local character2 = localPlayer.Character

					if character2 then
						character2 = character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
					end

					return string.format("<b><font color='rgb(%d,%d,%d)'>%s</font></b>\n<font color='rgb(200,200,200)'>%d studs</font>", color.R * 255, color.G * 255, color.B * 255, str6, character2 and math.floor((character2.Position - rootPart.Position).Magnitude) or 0)
				end, function()
					return str5
				end, nil, "Chest")
			end
		end
	end

	local tbl10 = {
		["Yellow Star Berry"] = Color3.fromRGB(255, 220, 50),
		["Red Cherry Berry"] = Color3.fromRGB(255, 65, 65),
		["Purple Jelly Berry"] = Color3.fromRGB(190, 80, 255),
		["Pink Pig Berry"] = Color3.fromRGB(255, 130, 180),
		["Blue Icicle Berry"] = Color3.fromRGB(80, 210, 255),
		["Green Toad Berry"] = Color3.fromRGB(65, 235, 95),
		["Orange Berry"] = Color3.fromRGB(255, 145, 35),
		["White Cloud Berry"] = Color3.fromRGB(240, 240, 255),
	}

	local color = Color3.fromRGB(255, 105, 180)
	local quantumBerryAnchors = v2:FindFirstChild("Quantum_Berry_Anchors")

	if not quantumBerryAnchors then
		quantumBerryAnchors = Instance.new("Folder")
		quantumBerryAnchors.Name = "Quantum_Berry_Anchors"
		quantumBerryAnchors.Parent = v2
	end

	local tbl11 = {}

	BerryESP = function()
		if not config.ESP_Berries then
			ClearESP("Berry")

			for _, v22 in pairs(tbl11) do
				if v22 and v22.Parent then
					pcall(function()
						v22:Destroy()
					end)
				end
			end

			table.clear(tbl11)
			return
		end

		local tbl12 = {}

		for _, v22 in ipairs(v5:GetTagged("BerryBush")) do
			if v22 and v22.Parent then
				local parent = v22.Parent
				local attribute2 = parent:GetAttribute("CFrame") or parent:IsA("Model") and parent:GetPivot()
				local flag4 = false

				for _, child in ipairs(v22:GetChildren()) do
					if child:IsA("Model") or child:IsA("BasePart") then
						local proximityPrompt = child:FindFirstChildOfClass("ProximityPrompt") or child:FindFirstChildWhichIsA("ProximityPrompt", true)
						local actionText = proximityPrompt and proximityPrompt.ActionText ~= "" and proximityPrompt.ActionText or child.Name

						if actionText == "ProximityPrompt" or #actionText <= 1 then
							actionText = "Berry"
						end

						local isBasePart = child:IsA("BasePart") and child
						local meshPart

						if isBasePart then
							meshPart = isBasePart
						else
							meshPart = child:FindFirstChildOfClass("MeshPart") or child:FindFirstChildWhichIsA("BasePart") or child.PrimaryPart
						end

						if meshPart and not meshPart:FindFirstChild("ESPquantumONYX") then
							local v23 = tbl10[actionText] or color

							AddESP(meshPart, v23, function()
								local character2 = localPlayer.Character
								local head = character2 and (character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart"))
								return string.format("Berry: <b><font color='rgb(%d,%d,%d)'>%s</font></b>\n<font color='rgb(220,220,220)'>%d studs</font>", v23.R * 255, v23.G * 255, v23.B * 255, actionText, head and math.floor((head.Position - meshPart.Position).Magnitude) or 0)
							end, nil, nil, "Berry")
						end

						flag4 = true
					end
				end

				if flag4 then
					for k in pairs(v22:GetAttributes()) do
						local str4 = parent.Name .. "_" .. k

						if tbl11[str4] then
							pcall(function()
								tbl11[str4]:Destroy()
							end)

							tbl11[str4] = nil
						end
					end
				else
					for k, v23 in pairs(v22:GetAttributes()) do
						if typeof(v23) == "string" and v23 ~= "" then
							local v24 = v23
							local str4 = parent.Name .. "_" .. k
							tbl12[str4] = true
							local attribute3 = parent:GetAttribute(k)
							local v25

							if attribute2 and attribute3 then
								v25 = attribute2:ToWorldSpace(attribute3)
							else
								local isModel = attribute3 and parent:IsA("Model")
								v25 = nil

								if isModel then
									v25 = parent:GetPivot():ToWorldSpace(attribute3)
								end
							end

							if v25 then
								local part = tbl11[str4]

								if not part or not part.Parent then
									part = Instance.new("Part")
									part.Name = "BerryAnchor_" .. v24
									part.Size = Vector3.new(1.2, 1.2, 1.2)
									part.Transparency = 1
									part.CanCollide = false
									part.Anchored = true
									part.CFrame = v25
									part.Parent = quantumBerryAnchors
									tbl11[str4] = part
								else
									part.CFrame = v25
								end

								if part and not part:FindFirstChild("ESPquantumONYX") then
									local v26 = tbl10[v24] or color

									AddESP(part, v26, function()
										local character2 = localPlayer.Character

										if character2 then
											character2 = character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
										end

										return string.format("Berry: <b><font color='rgb(%d,%d,%d)'>%s</font></b>\n<font color='rgb(220,220,220)'>%d studs</font>", v26.R * 255, v26.G * 255, v26.B * 255, v24, character2 and math.floor((character2.Position - part.Position).Magnitude) or 0)
									end, nil, nil, "Berry")
								end
							end
						end
					end
				end
			end
		end

		for k, v22 in pairs(tbl11) do
			if not tbl12[k] then
				if v22 and v22.Parent then
					pcall(function()
						v22:Destroy()
					end)
				end

				tbl11[k] = nil
			end
		end

		local v22 = next
		local children, v23 = v2:GetChildren()

		for _, v24 in v22, children, v23 do
			if v24:IsA("Tool") and (tbl10[v24.Name] or v24.Name:find("Berry")) then
				local handle = v24:FindFirstChild("Handle") or v24:FindFirstChildWhichIsA("BasePart")

				if handle and not handle:FindFirstChild("ESPquantumONYX") then
					local v25 = tbl10[v24.Name] or color

					AddESP(handle, v25, function()
						local character2 = localPlayer.Character

						if character2 then
							character2 = character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
						end

						return string.format("Dropped Berry: <b><font color='rgb(%d,%d,%d)'>%s</font></b>\n<font color='rgb(220,220,220)'>%d studs</font>", v25.R * 255, v25.G * 255, v25.B * 255, v24.Name, character2 and math.floor((character2.Position - handle.Position).Magnitude) or 0)
					end, nil, nil, "Berry")
				end
			end
		end
	end

	RealFruitESP = function()
		if not config.ESP_RealFruits then
			return
		end

		for _, v22 in next, { "PineappleSpawner", "AppleSpawner", "BananaSpawner" }, nil do
			local v23 = v2:FindFirstChild(v22)

			if v23 and not v23:FindFirstChild("ESPquantumONYX") then
				local str4 = v22:gsub("Spawner", "")

				AddESP(v23, Color3.fromRGB(50, 205, 50), function()
					local character2 = localPlayer.Character

					if character2 then
						character2 = character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
					end

					return string.format("Natural Fruit: <b><font color='rgb(50,205,50)'>%s</font></b>\n<font color='rgb(220,220,220)'>%d studs</font>", str4, character2 and math.floor((character2.Position - v23.Position).Magnitude) or 0)
				end, nil, nil, "RealFruit")
			end
		end

		local v22 = next
		local children, v23 = v2:GetChildren()

		for _, v24 in v22, children, v23 do
			if v24:IsA("Tool") and (v24.Name == "Pineapple" or v24.Name == "Apple" or v24.Name == "Banana") then
				local handle = v24:FindFirstChild("Handle") or v24

				if handle and handle:IsA("BasePart") and not handle:FindFirstChild("ESPquantumONYX") then
					AddESP(handle, Color3.fromRGB(50, 205, 50), function()
						local character2 = localPlayer.Character

						if character2 then
							character2 = character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
						end

						return string.format("Natural Fruit: <b><font color='rgb(50,205,50)'>%s</font></b>\n<font color='rgb(220,220,220)'>%d studs</font>", v24.Name, character2 and math.floor((character2.Position - handle.Position).Magnitude) or 0)
					end, nil, nil, "RealFruit")
				end
			end
		end
	end

	MyBoatESP = function()
		if not config.ESPMyBoat then
			ClearESP("MyBoat")
			return
		end
		local boats2 = v2:FindFirstChild("Boats")
		if not boats2 then
			return
		end

		for _, child in ipairs(boats2:GetChildren()) do
			local owner = child:FindFirstChild("Owner")
			local str4 = ""

			if owner then
				if typeof(owner.Value) == "Instance" then
					str4 = owner.Value.Name
				else
					str4 = tostring(owner.Value or "")
				end
			end

			if str4 == localPlayer.Name or owner and owner.Value == localPlayer then
				local primaryPart = child.PrimaryPart or child:FindFirstChildWhichIsA("VehicleSeat") or child:FindFirstChildWhichIsA("BasePart")

				if primaryPart and not primaryPart:FindFirstChild("ESPquantumONYX") then
					AddESP(primaryPart, Color3.fromRGB(0, 255, 180), function()
						local character2 = localPlayer.Character

						if character2 then
							character2 = character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
						end

						local n2 = character2 and math.floor((character2.Position - primaryPart.Position).Magnitude) or 0
						local health = child:FindFirstChild("Health")
						return string.format("My Boat (%s)%s\n%d studs away", child.Name, health and string.format(" [%d HP]", health.Value) or "", n2)
					end, nil, nil, "MyBoat")
				end
			end
		end
	end

	local function fn21(arg, arg2)
		if not arg then
			return
		end
		local n2 = arg2 or 450
		local pivot = arg:GetPivot()

		if pivot.Position.Y < n2 - 10 then
			pcall(function()
				arg:PivotTo(CFrame.new(pivot.Position.X, n2, pivot.Position.Z))
			end)
		end

		local vehicleSeat = arg:FindFirstChildWhichIsA("VehicleSeat", true) or arg:FindFirstChild("VehicleSeat", true) or arg:FindFirstChildWhichIsA("Seat", true) or arg.PrimaryPart

		if vehicleSeat and vehicleSeat:IsA("BasePart") then
			local boatProtectBP = vehicleSeat:FindFirstChild("BoatProtectBP")

			if not boatProtectBP then
				local bodyPosition = Instance.new("BodyPosition")
				bodyPosition.Name = "BoatProtectBP"
				bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bodyPosition.P = 100000
				bodyPosition.D = 1000
				bodyPosition.Position = Vector3.new(pivot.Position.X, n2, pivot.Position.Z)
				bodyPosition.Parent = vehicleSeat
			else
				boatProtectBP.Position = Vector3.new(pivot.Position.X, n2, pivot.Position.Z)
			end

			local boatProtectBV = vehicleSeat:FindFirstChild("BoatProtectBV")

			if not boatProtectBV then
				local bodyVelocity = Instance.new("BodyVelocity")
				bodyVelocity.Name = "BoatProtectBV"
				bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bodyVelocity.Velocity = Vector3.zero
				bodyVelocity.P = 100000
				bodyVelocity.Parent = vehicleSeat
			else
				boatProtectBV.Velocity = Vector3.zero
			end
		end
	end

	local function fn22(arg)
		if not arg then
			return
		end

		pcall(function()
			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant.Name == "BoatProtectBP" or descendant.Name == "BoatProtectBV" then
					descendant:Destroy()
				end
			end
		end)
	end

	local function fn23(arg)
		if not (arg and arg.Character and arg.Character:FindFirstChild("HumanoidRootPart") and arg.Character:FindFirstChild("Humanoid")) then
			return false
		end
		local humanoidRootPart3 = arg.Character.HumanoidRootPart
		if arg.Character:FindFirstChild("ForceField") ~= nil then
			return true
		end

		for _, child in ipairs(v2:GetChildren()) do
			if child:IsA("BasePart") and (child.Name:find("SafeZone") or child.Name:find("PeaceZone")) then
				if (humanoidRootPart3.Position - child.Position).Magnitude < child.Size.Magnitude / 2 + 10 then
					return true
				end
			end
		end

		return false
	end

	fn12 = function()
		if not config.EnableAimbot and not config.Aimbot then
			name = nil
			v19 = nil
			return nil
		end

		if v19 then
			local character2 = v19.Character
			local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart3 = character2 and (character2:FindFirstChild("HumanoidRootPart") or character2.PrimaryPart)
			if character2 and character2.Parent and humanoid2 and humanoid2.Health > 0 and humanoidRootPart3 and not fn23(v19) then
				return v19
			end
			v19 = nil
			name = nil
		end

		local character2 = localPlayer.Character

		if character2 then
			character2 = character2:FindFirstChild("HumanoidRootPart") or character2.PrimaryPart
		end

		if not character2 then
			return nil
		end
		local huge = math.huge
		local v22 = nil

		for _, player in ipairs(v3:GetPlayers()) do
			if player ~= localPlayer and player.Character and player.Character.Parent then
				local humanoid2 = player.Character:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart3 = player.Character:FindFirstChild("HumanoidRootPart") or player.Character.PrimaryPart

				if humanoid2 and humanoid2.Health > 0 and humanoidRootPart3 and not fn23(player) then
					local magnitude = (humanoidRootPart3.Position - character2.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v22 = player
					end
				end
			end
		end

		v19 = v22
		name = v22 and v22.Name or nil
		return v22
	end

	local function fn24(arg)
		if not arg then
			return false
		end

		if arg == localPlayer then
			return false
		end

		if not (arg.Character and arg.Character:FindFirstChild("HumanoidRootPart") and arg.Character:FindFirstChild("Humanoid") and arg.Character.Humanoid.Health > 0) then
			return false
		end

		if arg.Team and localPlayer.Team and arg.Team == localPlayer.Team then
			return false
		end
		return true
	end

	local tbl12 = {
		Fishman = CFrame.new(28224.057, 14889.427, -210.587),
		Human = CFrame.new(29237.295, 14889.427, -206.95),
		Cyborg = CFrame.new(28492, 14901, -426),
		Skypiea = CFrame.new(28967.408, 14918.075, 234.312),
		Ghoul = CFrame.new(28672.721, 14889.128, 454.596),
		Mink = CFrame.new(29020.66, 14889.427, -379.268),
	}

	local function fn25()
		local tbl13 = { "roar", "slam", "spin", "bite", "charge", "breath", "beam", "laser", "smash" }
		local tbl14

		tbl14 = {
			CurrentQuest = nil,
			GetPvPTarget = fn12,
			GetNearest = function(arg, arg2)
				local huge = arg2 or math.huge
				local character2 = localPlayer.Character
				local humanoidRootPart3 = character2 and (character2:FindFirstChild("HumanoidRootPart") or character2.PrimaryPart)
				if not humanoidRootPart3 then
					return nil
				end
				local position2 = humanoidRootPart3.Position
				local v22 = nil

				for _, child in ipairs(enemies:GetChildren()) do
					local humanoidRootPart4 = child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart
					local humanoid2 = child:FindFirstChildOfClass("Humanoid")

					if humanoidRootPart4 and humanoid2 and humanoid2.Health > 0 then
						local magnitude = (position2 - humanoidRootPart4.Position).Magnitude

						if magnitude <= (config.checknearestdist or 500) and magnitude < huge then
							huge = magnitude
							v22 = child
						end
					end
				end

				return v22
			end,
			GetNearestPlayer = function()
				local character2 = localPlayer.Character

				if character2 then
					character2 = character2:FindFirstChild("HumanoidRootPart") or character2.PrimaryPart
				end

				if not character2 then
					return nil
				end
				local position2 = character2.Position
				local huge = math.huge
				local v22 = nil

				for _, player in ipairs(v3:GetPlayers()) do
					if player ~= localPlayer and fn24(player) and player.Character and player.Character.Parent then
						local humanoid2 = player.Character:FindFirstChildOfClass("Humanoid")
						local humanoidRootPart3 = player.Character:FindFirstChild("HumanoidRootPart") or player.Character.PrimaryPart

						if humanoid2 and humanoid2.Health > 0 and humanoidRootPart3 and not fn23(player) then
							local magnitude = (humanoidRootPart3.Position - position2).Magnitude

							if magnitude < huge then
								huge = magnitude
								v22 = player
							end
						end
					end
				end

				return v22
			end,
			PlatesBartilo = function()
				local bartiloPlates = map.Dressrosa.BartiloPlates
				local brickColor = BrickColor.new("Sand yellow")

				for i = 1, 8 do
					if bartiloPlates["Plate" .. i].BrickColor == brickColor then
						return "Plate" .. i
					end
				end
			end,
			DetectChest = function()
				local huge = math.huge
				local v22 = nil

				for _, v23 in ipairs(v5:GetTagged("_ChestTagged")) do
					if v23:IsA("BasePart") and v23.Parent and v23:GetAttribute("IsDisabled") ~= true then
						local v24 = localPlayer:DistanceFromCharacter(v23.Position)

						if v24 < huge then
							huge = v24
							v22 = v23
						end
					end
				end

				return v22
			end,
			GetRaidIslands = function()
				local locations = worldOrigin:WaitForChild("Locations")

				for i = 5, 1, -1 do
					local str4 = "Island " .. i

					for _, child in ipairs(locations:GetChildren()) do
						if child.Name == str4 and child:IsA("Part") and (localPlayer.Character.PrimaryPart.Position - child.Position).Magnitude < 3500 then
							return child
						end
					end
				end
			end,
			GetCurrentRaidIslandIndex = function(arg)
				local raidIslands = arg:GetRaidIslands()
				if raidIslands and raidIslands.Name:match("Island (%d+)") then
					return tonumber(raidIslands.Name:match("Island (%d+)"))
				end
				return nil
			end,
			GetDungeonProps = function(arg, arg2)
				if not arg2 then
					return nil
				end

				if not arg2:FindFirstChild("Props") then
					return nil
				end
				local v22 = next
				local children, v23 = arg2.Props:GetChildren()

				for _, v24 in v22, children, v23 do
					if v24:GetAttribute("KitsuneMarkActive") == true or v24:GetAttribute("Speed") == 5 then
						return v24
					end
				end

				return nil
			end,
			Checkelites = function()
				for _, v22 in pairs({ "Urban", "Deandre", "Diablo" }) do
					if utilities:CheckMon(v22) then
						return v22
					end
				end

				for _, v22 in pairs({ "Urban", "Deandre", "Diablo" }) do
					if VerifyQuest(v22) then
						return v22
					end
				end

				return nil
			end,
			DetectPirateRaid = function()
				for _, child in ipairs(v2.Enemies:GetChildren()) do
					local humanoidRootPart3 = child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart
					local humanoid2 = child:FindFirstChildOfClass("Humanoid")
					if humanoidRootPart3 and humanoid2 and humanoid2.Health > 0 and (humanoidRootPart3.Position - Vector3.new(-5542, 314, -2971)).Magnitude <= 1200 and not string.find(child.Name:lower(), "indra") and not string.find(child.Name, "Boss") and child.Name ~= "Blank Buddy" then
						return child
					end
				end

				return nil
			end,
			PreventHappen = function()
				if utilities:Checkfruit() or utilities:CheckToolName("Microchip") or utilities:CheckToolName("Special Microchip") or utilities:CheckToolName("Fist of Darkness") or utilities:CheckToolName("God's Chalice") or localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or localPlayer:GetAttribute("IslandRaiding") then
					return true
				end
				return false
			end,
			GetDungeonIslands = function()
				local dungeon = map:FindFirstChild("Dungeon")
				if not dungeon then
					return nil
				end
				local huge = math.huge
				local v22 = nil
				local n2 = 0

				for i = 1, 100 do
					local v23 = dungeon:FindFirstChild(tostring(i))

					if v23 then
						local magnitude = (humanoidRootPart.Position - v23:GetPivot().Position).Magnitude
						local extentsSize = v23:GetExtentsSize()

						if magnitude < math.max(extentsSize.X, extentsSize.Y, extentsSize.Z) / 2 + 100 and magnitude < huge then
							huge = magnitude
							v22 = v23
							n2 = i
						end
					end
				end

				if not v22 then
					return nil
				end

				if not dungeon:FindFirstChild(tostring(n2 + 1)) then
					return nil
				end

				if v22:FindFirstChild("ExitTeleporter") and v22.ExitTeleporter:FindFirstChild("Root") then
					return v22.ExitTeleporter.Root
				end
				return nil
			end,
			HazePosition = function()
				local questHaze = localPlayer:FindFirstChild("QuestHaze")
				if not questHaze then
					return nil
				end
				local huge = math.huge
				local position2 = nil

				for _, child in ipairs(questHaze:GetChildren()) do
					if child.Value > 0 then
						for _, child2 in pairs(enemies:GetChildren()) do
							if child2:IsA("Model") and string.find(child2.Name, child.Name) and child2:FindFirstChild("HumanoidRootPart") and child2:FindFirstChild("HazeESP") then
								local v22 = localPlayer:DistanceFromCharacter(child2.HumanoidRootPart.Position)

								if v22 < huge then
									position2 = child2.HumanoidRootPart.Position
									huge = v22
								end
							end
						end

						if not position2 then
							for _, child2 in pairs(worldOrigin.EnemySpawns:GetChildren()) do
								if string.find(child2.Name, child.Name) then
									local v22 = localPlayer:DistanceFromCharacter(child2.Position)

									if v22 < huge then
										position2 = child2.Position
										huge = v22
									end
								end
							end
						end
					end
				end

				return position2
			end,
			HazeMobs = function()
				local questHaze = localPlayer:FindFirstChild("QuestHaze")
				if not questHaze then
					return nil
				end
				local huge = math.huge
				local v22 = nil

				for _, child in ipairs(questHaze:GetChildren()) do
					if child.Value > 0 then
						for _, child2 in pairs(enemies:GetChildren()) do
							if child2:IsA("Model") and string.find(child2.Name, child.Name) and child2:FindFirstChild("HumanoidRootPart") and child2:FindFirstChild("Humanoid") and child2.Humanoid.Health > 0 and child2:FindFirstChild("HazeESP") and mods:IsReady(child2) then
								local v23 = localPlayer:DistanceFromCharacter(child2.HumanoidRootPart.Position)

								if v23 < huge then
									huge = v23
									v22 = child2
								end
							end
						end
					end
				end

				return v22
			end,
			GetPathButton = function()
				local v22 = next
				local children, v23 = map["Boat Castle"].Summoner:FindFirstChild("Circle"):GetChildren()

				for _, v24 in v22, children, v23 do
					if v24 and v24.Name == "Part" and v24:FindFirstChild("Part") and v24.Part.BrickColor ~= BrickColor.new("Lime green") then
						return v24.Part
					end
				end
			end,
			GetPathFruit = function()
				local v22 = next
				local children, v23 = v2:GetChildren()

				for _, v24 in v22, children, v23 do
					if v24:IsA("Tool") or v24:IsA("Model") and string.find(v24.Name, "Fruit") then
						return v24
					end
				end
			end,
			CheckQuestStatus = function()
				local response = nil

				pcall(function()
					net:WaitForChild("RF/DragonHunter"):InvokeServer({ Context = "RequestQuest" })
				end)

				pcall(function()
					response = net:WaitForChild("RF/DragonHunter"):InvokeServer({ Context = "Check" })
				end)

				local str4 = nil
				local n2 = nil
				local flag4 = false
				local n3

				if response then
					str4 = nil
					n2 = nil
					n3 = nil

					if response.Text then
						local str5 = tostring(response.Text)

						if str5:find("Destroy") or str5:find("Tree") then
							n2 = tonumber(str5:match("%d+")) or 10
							str4 = "Tree"
							flag4 = true
							n3 = 2
						else
							local pos = str5:find("Defeat") or str5:find("Enforcer") or str5:find("Assailant") or str5:find("Venomous")
							str4 = nil
							n2 = nil
							n3 = nil

							if pos then
								n2 = tonumber(str5:match("%d+")) or 0
								str4 = nil

								for _, v22 in ipairs({ "Hydra Enforcer", "Venomous Assailant" }) do
									if str5:find(v22) or str5:find(v22:gsub(" ", "")) then
										str4 = v22
										break
									else
										str4 = nil
									end
								end

								flag4 = true
								n3 = 1

								if not str4 then
									if str5:find("Venomous") or str5:find("Assailant") then
										str4 = "Venomous Assailant"
									else
										str4 = "Hydra Enforcer"
									end
								end
							end
						end
					end
				end

				return flag4, str4, n2, n3
			end,
			TaskDone = function()
				local notifications = localPlayer.PlayerGui:FindFirstChild("Notifications")

				if notifications then
					local v22 = next
					local children, v23 = notifications:GetChildren()

					for _, v24 in v22, children, v23 do
						local v25 = next
						local children2, v26 = v24:GetChildren()

						for _, v27 in v25, children2, v26 do
							if v27:IsA("TextLabel") and (string.find(v27.Text, "Task completed!") or string.find(v27.Text, "Head back to the Dojo")) then
								return true
							end
						end
					end
				end

				return false
			end,
			IsEntityAttacking = function(arg, arg2)
				if not arg2 or not arg2.Parent then
					return false
				end
				local humanoid2 = arg2:FindFirstChildOfClass("Humanoid") or arg2:FindFirstChildOfClass("AnimationController")
				humanoid2 = humanoid2 and humanoid2:FindFirstChildOfClass("Animator")
				if not humanoid2 then
					return false
				end
				local playingAnimationTracks = humanoid2:GetPlayingAnimationTracks()

				for _, playingAnimationTrack in ipairs(playingAnimationTracks) do
					local isPlaying = playingAnimationTrack.IsPlaying

					if isPlaying then
						isPlaying = (playingAnimationTrack.WeightCurrent or 1) > 0.3
					end

					if isPlaying then
						local str4 = playingAnimationTrack.Name:lower()
						local animation = playingAnimationTrack.Animation
						animation = animation and animation.Name:lower() or ""

						for _, v22 in ipairs(tbl13) do
							if str4:find(v22) or animation:find(v22) then
								return true
							end
						end
					end
				end

				return false
			end,
			DodgeSeabeast = function()
				for _, child in ipairs(seaBeasts:GetChildren()) do
					if child:FindFirstChild("HumanoidRootPart") and tbl14:IsEntityAttacking(child) then
						return true
					end
				end

				for _, child in ipairs(worldOrigin:GetChildren()) do
					if child:IsA("BasePart") then
						local str4 = child.Name:lower()
						local pos = str4:find("lightbullet") or str4:find("waterbeam") or str4:find("beastroar")
						local flag4

						if pos then
							flag4 = pos
						else
							flag4 = child.BrickColor == BrickColor.new("Toothpaste") and child.Size.Magnitude > 15
						end

						if flag4 then
							return true
						end
					end
				end

				for _, child in ipairs(v2:GetChildren()) do
					if child:IsA("BasePart") then
						local str4 = child.Name:lower()
						if str4:find("waterbeam") or str4:find("lightbullet") then
							return true
						end
					end
				end

				return false
			end,
			TerrorDodge = function()
				for _, child in ipairs(worldOrigin:GetChildren()) do
					local str4 = child.Name:lower()
					if str4:find("sharkslam") or str4:find("spin") or str4:find("chargemodel") then
						return true
					end
				end

				return false
			end,
		}

		local tbl15 = {
			["Sea Beast"] = "SeaBeast",
			["Terror Shark"] = "Terrorshark",
			Shark = "Shark",
			Piranha = "Piranha",
			["Fish Crew Member"] = "Fish Crew Member",
			["Pirate Brigade"] = "PirateBrigade",
			["Pirate Grand Brigade"] = "PirateGrandBrigade",
			["Ghost Ship"] = "FishBoat",
		}

		local tbl16 = {}

		tbl14.GetSeaEventTargets = function()
			local seaEventTargets = config.SeaEventTargets
			local v22 = clearNew(tbl16)
			if not seaEventTargets then
				return v22
			end

			if type(seaEventTargets) == "table" then
				for k, seaEventTarget in pairs(seaEventTargets) do
					if seaEventTarget == true then
						table.insert(v22, tbl15[k] or k)
					elseif type(k) == "number" and type(seaEventTarget) == "string" then
						table.insert(v22, tbl15[seaEventTarget] or seaEventTarget)
					end
				end
			elseif type(seaEventTargets) == "string" then
				table.insert(v22, tbl15[seaEventTargets] or seaEventTargets)
			end

			return v22
		end

		tbl14.TyrantEyes = function()
			local islandModel = map:FindFirstChild("TikiOutpost") and map.TikiOutpost:FindFirstChild("IslandModel")
			if not islandModel then
				return 0
			end
			local e = islandModel:FindFirstChild("IslandChunks") and islandModel.IslandChunks:FindFirstChild("E")
			local tbl17 = {}
			local eye1 = islandModel:FindFirstChild("Eye1")
			local eye2 = islandModel:FindFirstChild("Eye2")
			local eye3 = e:FindFirstChild("Eye3")
			local findFirstChild = e.FindFirstChild
			tbl17[1] = eye1
			tbl17[2] = eye2
			tbl17[3] = eye3

			do
				local values = table.pack(findFirstChild(e, "Eye4"))
				table.move(values, 1, values.n, 4, tbl17)
			end

			local n2 = 0

			for _, v22 in ipairs(tbl17) do
				v22 = v22 and v22.Transparency == 0

				if v22 then
					n2 += 1
				end
			end

			return n2
		end

		tbl14.CheckSeaLevel = function()
			local tbl17 = { "Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6", "Infinite" }

			local tbl18 = {
				["Level 1"] = CFrame.new(-21998.375, 30.0006, -682.309),
				["Level 2"] = CFrame.new(-26779.5215, 30.0005, -822.858),
				["Level 3"] = CFrame.new(-31171.957, 30.0001, -2256.9377),
				["Level 4"] = CFrame.new(-34054.6875, 30.2187, -2560.1201),
				["Level 5"] = CFrame.new(-38887.5547, 30.0004, -2162.9902),
				["Level 6"] = CFrame.new(-44541.7617, 30.0003, -1244.8584),
				Infinite = CFrame.new(-10000000, 31, 37016.25),
			}

			local seaLevelSelected = config.SeaLevelSelected

			if typeof(seaLevelSelected) == "number" then
				seaLevelSelected = tbl17[seaLevelSelected] or "Level 6"
			end

			return tbl18[seaLevelSelected] or tbl18["Level 6"] or tbl18["Level 1"]
		end

		tbl14.CheckBerries = function()
			local v22 = next
			local tagged, v23 = v5:GetTagged("BerryBush")

			for _, v24 in v22, tagged, v23 do
				for k, v25 in pairs(v24:GetAttributes()) do
					if k:sub(1, 12) == "_BerryCFrame" and type(v25) == "string" and #v25 > 0 then
						return true
					end
				end

				for _, child in ipairs(v24:GetChildren()) do
					if child:IsA("Model") or child:IsA("BasePart") then
						return true
					end
				end
			end

			return false
		end

		return tbl14
	end

	mods.GameData = fn25()
	local gameData = mods.GameData

	local function fn26()
		local tbl13 = { Attack = function(arg, arg2, arg3)
			if not arg2 then
				return
			end

			if not character then
				return
			end
			local humanoid2 = arg2:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart3 = arg2:FindFirstChild("HumanoidRootPart") or arg2.PrimaryPart
			if not humanoidRootPart3 then
				return
			end

			if arg2:IsDescendantOf(v2) and humanoid2 and humanoid2.Health <= 0 then
				return
			end
			tweenManager:topos(utilities:GetFarmCFrame(humanoidRootPart3), true)

			if arg2:IsDescendantOf(v2) then
				if config.MasteryFarm then
					if humanoid2 and humanoid2.Health / humanoid2.MaxHealth > config.HealthMob / 100 then
						humanoidRootPart2 = nil
						utilities:EquipWeapon()
					else
						humanoidRootPart2 = humanoidRootPart3
						fn14()
						humanoidRootPart2 = nil
					end
				else
					humanoidRootPart2 = nil

					if config.AutoMasterySwords then
						utilities:EquipWeapon("Sword")
					else
						utilities:EquipWeapon()
					end
				end

				utilities:AutoHaki()

				if arg3 ~= false and config.BringMonster then
					utilities:BringEnemies(arg2)
				end
			end
		end }

		local n2 = 0

		BuyBoatSafe = function(arg, arg2)
			local flag4 = not arg2
			if flag4 and tick() - n2 < 3 then
				return
			end
			local boats2 = v2:FindFirstChild("Boats")

			if flag4 and boats2 then
				for _, child in ipairs(boats2:GetChildren()) do
					local owner = child:FindFirstChild("Owner")

					if owner then
						local flag5 = owner.Value == localPlayer or typeof(owner.Value) == "Instance" and owner.Value.Name == localPlayer.Name

						if not flag5 then
							local name2 = localPlayer.Name
							flag5 = tostring(owner.Value) == name2
						end

						if flag5 then
							local humanoid2 = child:FindFirstChild("Humanoid") or child:FindFirstChildOfClass("Humanoid")

							if not (humanoid2 and (humanoid2.Value == 0 or humanoid2:IsA("Humanoid") and humanoid2.Health <= 0) or child:GetAttribute("Dead") == true or child:GetAttribute("Sunk") == true) and child:IsDescendantOf(v2) then
								local vehicleSeat = child:FindFirstChildWhichIsA("VehicleSeat", true) or child:FindFirstChild("VehicleSeat", true) or child:FindFirstChildWhichIsA("BasePart")
								if vehicleSeat and vehicleSeat.Position.Y > -15 then
									return
								end
								continue
							end
						end
					end
				end
			end

			local flag5 = string.find(localPlayer and localPlayer.Team and tostring(localPlayer.Team) or "Pirates", "Marine") ~= nil
			local str4 = arg

			if typeof(str4) == "number" and Data and Data.BoatsList then
				str4 = Data.BoatsList[str4]
			elseif not str4 or str4 == "" then
				str4 = isSea3 and "Beast Hunter" or "PirateBrigade"
			end

			if flag5 then
				if str4 == "PirateSloop" or str4 == "Sloop" then
					str4 = "MarineSloop"
				elseif str4 == "PirateBrigade" or str4 == "Brigade" then
					str4 = "MarineBrigade"
				elseif str4 == "PirateGrandBrigade" or str4 == "Grand Brigade" then
					str4 = "MarineGrandBrigade"
				end
			elseif str4 == "MarineSloop" or str4 == "Sloop" then
				str4 = "PirateSloop"
			elseif str4 == "MarineBrigade" or str4 == "Brigade" then
				str4 = "PirateBrigade"
			elseif str4 == "MarineGrandBrigade" or str4 == "Grand Brigade" then
				str4 = "PirateGrandBrigade"
			end

			local v22 = GetSelectedBoat()

			if v22 then
				pcall(function()
					v22:Destroy()
				end)
			end

			n2 = tick()

			pcall(function()
				mods:FireInvoke("BuyBoat", str4)
			end)
		end

		tbl13.AutoBoatSail = function(arg, arg2)
			local v22 = GetSelectedBoat()

			if not v22 or config.AutoBuyNewBoatWhendies and humanoid.Health <= 0 then
				if fn6() > 1 and config.AutoBuyNewBoatWhendies and humanoid.Health <= 0 then
					if utilities:GetDistance(CFrame.new(-16927.451, 9.086, 433.864)) <= 12 then
						mods:FireInvoke("BuyBoat", config.BoatSelected)
					else
						tweenManager:topos(CFrame.new(-16927.451, 9.086, 433.864))
					end
				end

				tweenManager:StopBoatTween()

				if isSea2 then
					if utilities:GetDistance(CFrame.new(-5330, 5, -714)) <= 12 then
						mods:FireInvoke("BuyBoat", config.BoatSelected)
					else
						tweenManager:topos(CFrame.new(-5330, 5, -714))
					end
				elseif isSea3 then
					if fn6() > 1 and config.ResetPlayerdestroyboat then
						localPlayer.Character.Head:Destroy()
					elseif utilities:GetDistance(CFrame.new(-16927.451, 9.086, 433.864)) <= 12 then
						mods:FireInvoke("BuyBoat", config.BoatSelected)
					else
						tweenManager:topos(CFrame.new(-16927.451, 9.086, 433.864))
					end
				end

				return
			end

			if not humanoid.Sit then
				tweenManager:StopBoatTween()
				local vehicleSeat = v22:FindFirstChild("VehicleSeat")

				if vehicleSeat and v22.Humanoid.Value ~= 0 then
					tweenManager:topos(vehicleSeat.CFrame * CFrame.new(0, 3, 0))
					task.wait(0.5)
				end

				return
			end

			tweenManager:toposboat(arg2 or gameData:CheckSeaLevel())
		end

		tbl13.AttackTree = function()
			local eagleBossArena = map:FindFirstChild("TikiOutpost") and map.TikiOutpost:FindFirstChild("IslandModel") and map.TikiOutpost.IslandModel:FindFirstChild("IslandChunks") and map.TikiOutpost.IslandModel.IslandChunks:FindFirstChild("D") and map.TikiOutpost.IslandModel.IslandChunks.D:FindFirstChild("EagleBossArena")
			if not eagleBossArena then
				return
			end

			for _, child in ipairs(eagleBossArena:GetChildren()) do
				if child.Name == "Tree" and child:IsA("Model") and child:FindFirstChild("Group") then
					local v22 = child.Group:GetChildren()[1]

					if v22 then
						local position2 = v22.CFrame.Position
						tweenManager:topos(v22.CFrame * CFrame.new(0, 15, 0))

						if localPlayer:DistanceFromCharacter(position2) <= 75 then
							if config.ShootGunTyrant then
								local selectGunTyrant = config.SelectGunTyrant or "Skull Guitar"

								if not localPlayer.Character:FindFirstChild(selectGunTyrant) then
									local skullGuitar = localPlayer.Backpack:FindFirstChild(selectGunTyrant) or localPlayer.Backpack:FindFirstChild("Skull Guitar")

									if skullGuitar and localPlayer.Character:FindFirstChild("Humanoid") then
										localPlayer.Character.Humanoid:EquipTool(skullGuitar)
									else
										mods:FireInvoke("LoadItem", selectGunTyrant)
									end

									task.wait(0.2)
								end

								utilities:EquipWeapon("Gun")
								task.wait(0.15)
								customShoot(position2)
								local tool = localPlayer.Character:FindFirstChildOfClass("Tool")

								if tool and tool:FindFirstChild("RemoteEvent") then
									pcall(function()
										tool.RemoteEvent:FireServer("TAP", position2)
									end)
								end
							else
								position = position2
								fn14()
								position = nil
							end

							break
						end
					end
				end
			end
		end

		return tbl13
	end

	mods.SubFunction = fn26()
	local subFunction = mods.SubFunction
	mods.Functions = mods.Functions or {}
	mods.Loops = mods.Loops or {}
	mods.FunctionList = mods.FunctionList or {}
	mods.ActiveFunction = mods.ActiveFunction or nil
	mods.FunctionDisplayNames = mods.FunctionDisplayNames or {}

	local tbl13 = {
		"AutoFactoryRaid",
		"AutoFarmPirateRaid",
		"AutoSoulReaper",
		"AutoTaskEliteHunter",
		"Tweenfruit",
		"AutoBerrySafe",
	}

	mods.IsMultiFunction = function(arg)
		for _, v22 in ipairs(tbl13) do
			if v22 == arg then
				return true
			end
		end

		return false
	end

	mods.GetEnabledFunctionNames = function()
		local tbl14 = {}

		if mods.FunctionList then
			for _, v22 in ipairs(mods.FunctionList) do
				if config and config[v22.Name] then
					table.insert(tbl14, v22.Name)
				end
			end
		end

		return tbl14
	end

	local tbl14 = {
		Greybeard = "Greybeard",
		Darkbeard = "Darkbeard",
		["Cursed Captain"] = "CursedCaptain",
		["rip_indra True Form"] = "Ripindra",
		["Soul Reaper"] = "SoulReaper",
		["Cake Prince"] = "CakePrince",
		["Dough King"] = "DoughKing",
		["Tyrant of the Skies"] = "Tyrant",
	}

	local bossHopNames = {
		"Greybeard",
		"Darkbeard",
		"Cursed Captain",
		"rip_indra True Form",
		"Soul Reaper",
		"Cake Prince",
		"Dough King",
		"Tyrant of the Skies",
	}

	mods.LoadLibrary = function()
		if not lua4 or not lua4.CreateWindow then
			lua4 = lua3 or OnyxUI()
		end

		if not lua4 or not lua4.CreateWindow then
			warn("[Quantum ERROR] Critical: UI Library failed to load!")
			return
		end

		local v22 = lua4:CreateWindow({
			Title = "Quantum Onyx",
			Subtitle = "Blox Fruit",
			Version = "v.Freemium",
			Key = false,
			Theme = "Purple",
			Credits = {
				{ Name = "Vin ", Role = "ServerOwner" },
				{ Name = "Flazhy ", Role = "MainDeveloper" },
				{ Name = "Kiel ", Role = "WebDesigner" },
				{ Name = "CudalPH ", Role = "Tester" },
				{ Name = "Pierce ", Role = "Support" },
			},
			SaveFile = "BloxFruits",
		})

		local tbl15 = {
			Home = v22:AddTab("Home", "home-quantum"),
			Sub = v22:AddTab("Sub Farm", "swords-quantum"),
			Sevent = v22:AddTab("Sea Event", "ship-quantum"),
			Player = v22:AddTab("Player", "user-quantum"),
			Dragon = v22:AddTab("Dragon Update", "visual-quantum"),
			Raid = v22:AddTab("Dungeon", "raid-quantum"),
			Trial = v22:AddTab("Trials", "rabbit-quantum"),
			Travel = v22:AddTab("Travel", "map-quantum"),
			Shop = v22:AddTab("Tiktok Shop", "cart-quantum"),
			Misc = v22:AddTab("Misc", "misc-quantum"),
			Web = v22:AddTab("Webhook", "cat-quantum"),
		}

		local tbl16 = {
			CreateToggle = function(arg, arg2, arg3, arg4, arg5, arg6)
				local tbl16 = arg6 or {}

				if tbl16.global then
					config[arg4] = arg5
				end

				mods.FunctionDisplayNames = mods.FunctionDisplayNames or {}
				mods.FunctionDisplayNames[arg4] = arg3
				mods.Toggles = mods.Toggles or {}
				local flag4 = tbl16.save ~= false and arg4 or nil

				local v23 = arg2:addToggle(arg3, arg5, function(arg7)
					if tbl16.global then
						config[arg4] = arg7
					end

					config[arg4] = arg7

					if arg7 then
						if mods.Functions and mods.Functions[arg4] and mods.Functions[arg4].Start then
							mods.Functions[arg4].Start()
						end

						if mods.Loops and mods.Loops[arg4] and mods.Loops[arg4].Start then
							mods.Loops[arg4].Start()
						end
					else
						if mods.Functions and mods.Functions[arg4] and mods.Functions[arg4].Stop then
							mods.Functions[arg4].Stop()
						elseif mods.Functions and mods.Functions[arg4] then
							mods.Functions[arg4].Running = false
						end

						if mods.Loops and mods.Loops[arg4] and mods.Loops[arg4].Stop then
							mods.Loops[arg4].Stop()
						elseif mods.Loops and mods.Loops[arg4] then
							mods.Loops[arg4].Running = false
						end

						if mods.ActiveFunction == arg4 then
							mods.ActiveFunction = nil
						end

						if tbl16.stop ~= false then
							if tweenManager and tweenManager.StopTween then
								tweenManager:StopTween()
							end

							if not (config.AutoSharkAnchor or config.AutoFindLeviatan or config.AutoSailbacktoTiki or config.AutoSail) then
								if tweenManager and tweenManager.StopBoatTween then
									tweenManager:StopBoatTween()
								end
							end
						end
					end

					if type(tbl16.callback) == "function" then
						tbl16.callback(arg7)
					end
				end, tbl16.locked, tbl16.description, flag4)

				if arg4 then
					mods.Toggles[arg4] = v23
				end

				return v23
			end,
			CreateDropdown = function(arg, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
				arg7 = arg7 or {}

				if arg7.global then
					config[arg4] = arg5
				end

				local flag4 = arg7.save ~= false and arg4 or nil

				return arg2:addDropdown(arg3, arg5, arg6, function(arg9)
					if arg7.global then
						config[arg4] = arg9
					end

					config[arg4] = arg9

					if type(arg7.callback) == "function" then
						arg7.callback(arg9)
					end
				end, arg7.locked, arg8, flag4)
			end,
			CreateSlider = function(arg, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
				local tbl16 = arg8 or {}

				if tbl16.global then
					config[arg4] = arg7
				end

				local flag4 = tbl16.save ~= false and arg4 or nil

				return arg2:addSlider(arg3, arg5, arg6, arg7, function(arg9)
					if tbl16.global then
						config[arg4] = arg9
					end

					config[arg4] = arg9

					if type(tbl16.callback) == "function" then
						tbl16.callback(arg9)
					end
				end, tbl16.locked, tbl16.step, flag4)
			end,
			CreateTextbox = function(arg, arg2, arg3, arg4, arg5)
				local tbl16 = arg5 or {}

				if tbl16.global then
					config[arg4] = tbl16.default or ""
				end

				local flag4 = tbl16.save ~= false and arg4 or nil

				return arg2:addTextbox(arg3, function(arg6)
					if tbl16.global then
						config[arg4] = arg6
					end

					config[arg4] = arg6

					if type(tbl16.callback) == "function" then
						tbl16.callback(arg6)
					end
				end, tbl16.confirmText, flag4)
			end,
		}

		local tbl17 = {}

		if flag then
			tbl17.Materials = { "Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail" }

			tbl17.BossNames = {
				"The Gorilla King",
				"Chief",
				"Yeti",
				"Vice Admiral",
				"Warden",
				"Chief Warden",
				"Swan",
				"Magma Admiral",
				"Fishman Lord",
				"Wysper",
				"Thunder God",
				"Cyborg",
				"Saw",
			}
		elseif isSea2 then
			tbl17.Materials = {
				"Leather + Scrap Metal",
				"Radioactive Material",
				"Ectoplasm",
				"Mystic Droplet",
				"Magma Ore",
				"Vampire Fang",
			}

			tbl17.BossNames = {
				"Diamond",
				"Jeremy",
				"Orbitus",
				"Smoke Admiral",
				"Awakened Ice Admiral",
				"Tide Keeper",
				"Don Swan",
			}
		elseif isSea3 then
			tbl17.Materials = {
				"Leather + Scrap Metal",
				"Demonic Wisp",
				"Conjured Cocoa",
				"Dragon Scale",
				"Gunpowder",
				"Fish Tail",
				"Mini Tusk",
				"Nightmare Catcher",
			}

			tbl17.BossNames = { "Stone", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Cake Queen" }
		else
			tbl17.Materials = { "walang kayo" }
			tbl17.BossNames = {}
		end

		tbl17.BoatsList = {
			"Dinghy",
			"PirateSloop",
			"PirateBrigade",
			"PirateGrandBrigade",
			"MarineSloop",
			"MarineBrigade",
			"MarineGrandBrigade",
			"Beast Hunter",
			"Lantern",
			"Guardian",
			"Grand Brigade",
			"Sloop",
			"The Sentinel",
		}

		tbl17.ZoneList = { "Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6", "Infinite" }

		tbl17.SeaEventTargets = {
			"Terror Shark",
			"Sea Beast",
			"Shark",
			"Piranha",
			"Fish Crew Member",
			"Pirate Brigade",
			"Pirate Grand Brigade",
			"Ghost Ship",
		}

		tbl17.RodsList = {
			"Fishing Rod",
			"Gold Rod",
			"Shark Rod",
			"Shell Rod",
			"Treasure Rod",
			"Shark (Corrupted)",
			"Shell (Celestial)",
		}

		tbl17.BaitsList = {
			"Basic Bait",
			"Kelp Bait",
			"Good Bait",
			"Abyssal Bait",
			"Frozen Bait",
			"Epic Bait",
			"Carnivore Bait",
		}

		local raidsChip = {}

		pcall(function()
			local Raids = require(RS.Raids)

			for _, raid in pairs(Raids.raids) do
				table.insert(raidsChip, raid)
			end

			for _, advancedRaid in pairs(Raids.advancedRaids) do
				table.insert(raidsChip, advancedRaid)
			end
		end)

		tbl17.Raids_Chip = raidsChip

		tbl17.DungeonCards = {
			"Hyper",
			"Overflow",
			"Fortress",
			"Shadow",
			"Sniper",
			"Lifesteal",
			"Unbreakable",
			"Health",
			"Defense",
			"Armor",
			"Melee",
			"Sword",
			"Fruit",
			"Gun",
		}

		tbl17.TrainMethods = { "Bones", "Cakes" }
		local str4 = flag and "Sea 1" or isSea2 and "Sea 2" or isSea3 and "Sea 3" or nil
		tbl17.ActiveIslands = str4 and islands[str4] or {}
		local islandsList = {}

		for k in next, tbl17.ActiveIslands, nil do
			table.insert(islandsList, k)
		end

		tbl17.IslandsList = islandsList
		local npcList = {}
		local tbl18 = { "Quest", "Boat", "Home" }
		local v23 = next
		local children, v24 = RS.NPCs:GetChildren()

		for _, v25 in v23, children, v24 do
			local str5 = v25.Name:lower()
			local flag4 = false

			for _, v26 in next, tbl18, nil do
				if str5:find(v26:lower(), 1, true) then
					flag4 = true
					break
				end
			end

			if not flag4 then
				table.insert(npcList, v25.Name)
			end
		end

		tbl17.NPCList = npcList
		tbl17.LegendarySwordNames = { "Shizu", "Oroshi", "Saishi" }
		tbl17.BossHopNames = bossHopNames

		local function fn27(arg)
			local tbl19 = {}
			local v25 = pairs
			local tbl20 = arg or {}

			for k in v25(tbl20) do
				table.insert(tbl19, k)
			end

			return tbl19
		end

		tbl17.MeleeNames = fn27(melees)
		tbl17.AbilityNames = fn27(itemsToBuy and itemsToBuy.Ability)
		tbl17.GunNames = fn27(itemsToBuy and itemsToBuy.Gun)
		tbl17.AccessoryNames = fn27(itemsToBuy and itemsToBuy.Accessory)

		tbl17.DealerFruitList = {
			"Rocket-Rocket",
			"Spin-Spin",
			"Blade-Blade",
			"Spring-Spring",
			"Bomb-Bomb",
			"Smoke-Smoke",
			"Spike-Spike",
			"Flame-Flame",
			"Ice-Ice",
			"Sand-Sand",
			"Dark-Dark",
			"Eagle-Eagle",
			"Diamond-Diamond",
			"Light-Light",
			"Rubber-Rubber",
			"Ghost-Ghost",
			"Magma-Magma",
			"Quake-Quake",
			"Buddha-Buddha",
			"Love-Love",
			"Creation-Creation",
			"Spider-Spider",
			"Sound-Sound",
			"Phoenix-Phoenix",
			"Portal-Portal",
			"Lightning-Lightning",
			"Pain-Pain",
			"Blizzard-Blizzard",
			"Gravity-Gravity",
			"Mammoth-Mammoth",
			"T-Rex-T-Rex",
			"Dough-Dough",
			"Shadow-Shadow",
			"Venom-Venom",
			"Gas-Gas",
			"Spirit-Spirit",
			"Tiger-Tiger",
			"Yeti-Yeti",
			"Kitsune-Kitsune",
			"Control-Control",
			"Dragon-Dragon",
		}

		tbl17.AdminPanelGrid = {
			{
				Label = "Teleport Tool",
				Callback = function()
					local mouse = localPlayer:GetMouse()
					local teleportTool = localPlayer.Backpack:FindFirstChild("Teleport Tool") or localPlayer.Character and localPlayer.Character:FindFirstChild("Teleport Tool")

					if teleportTool then
						teleportTool:Destroy()
					end

					local tool = Instance.new("Tool")
					tool.RequiresHandle = false
					tool.CanBeDropped = false
					tool.Name = "Teleport Tool"
					tool:SetAttribute("ItemId", 1173)
					tool.ToolTip = "Tool"

					tool.Activated:Connect(function()
						local character2 = localPlayer.Character
						character2 = character2 and character2:FindFirstChild("HumanoidRootPart")

						if character2 and mouse and mouse.Hit then
							local n2 = mouse.Hit.Position + Vector3.new(0, 3.5, 0)
							character2.CFrame = CFrame.new(n2, n2 + character2.CFrame.LookVector)
						end
					end)

					tool.Parent = localPlayer.Backpack
				end,
			},
			{
				Label = "Summon Heaven Dimension",
				Callback = function()
					if lua2 and lua2.SummonIsland then
						lua2:SummonIsland("Heaven Dimension")
					end
				end,
			},
			{
				Label = "Summon Pakistan Dimension",
				Callback = function()
					if lua2 and lua2.SummonIsland then
						lua2:SummonIsland("Pakistan Dimension")
					end
				end,
			},
			{
				Label = "Summon Red Legion Hideout",
				Callback = function()
					if lua2 and lua2.SummonIsland then
						lua2:SummonIsland("Red Legion Hideout")
					end
				end,
			},
			{
				Label = "Summon Rip Family Arena",
				Callback = function()
					if lua2 and lua2.SummonIsland then
						lua2:SummonIsland("Rip Family Arena")
					end
				end,
			},
			{
				Label = "Summon Pocket Dimension",
				Callback = function()
					if lua2 and lua2.SummonIsland then
						lua2:SummonIsland("Pocket Dimension")
					end
				end,
			},
			{
				Label = "Summon Rip Family Hideout",
				Callback = function()
					if lua2 and lua2.SummonIsland then
						lua2:SummonIsland("Rip Family Hideout")
					end
				end,
			},
			{
				Label = "Give Triple DarkBlade",
				Callback = function()
					if lua2 and lua2.GiveDarkBlade then
						lua2:GiveDarkBlade()
					end
				end,
			},
			{
				Label = "Give Celestial Art",
				Callback = function()
					if lua2 and lua2.GiveCelestialArt then
						lua2:GiveCelestialArt()
					end
				end,
			},
			{
				Label = "Give Divine Art",
				Callback = function()
					if lua2 and lua2.GiveDivineArt then
						lua2:GiveDivineArt()
					end
				end,
			},
			{
				Label = "Give Tensei",
				Callback = function()
					if lua2 and lua2.GiveTensei then
						lua2:GiveTensei()
					end
				end,
			},
			{
				Label = "Give All Kamui Tools",
				Callback = function()
					if lua2 and lua2.GiveAllKamuis then
						lua2:GiveAllKamuis()
					end
				end,
			},
			{
				Label = "Rain Fruit New",
				Callback = function()
					if lua2 and lua2.GiveFruitRain then
						lua2:GiveFruitRain()
					end
				end,
			},
			{
				Label = "Give Black Blast",
				Callback = function()
					if lua2 and lua2.GiveBlackBlast then
						lua2:GiveBlackBlast()
					end
				end,
			},
			{
				Label = "Give Black Nuke",
				Callback = function()
					if lua2 and lua2.GiveBlackNuke then
						lua2:GiveBlackNuke()
					end
				end,
			},
			{
				Label = "Give Rogue Fruit",
				Callback = function()
					if lua2 and lua2.GiveRougeFruit then
						lua2:GiveRougeFruit()
					end
				end,
			},
		}

		local thread = nil

		local tbl19 = {
			OnAutoLoadScript = function()
				if config.AutoLoadScriptonLoad then
					local str5 = string.format(" task.wait(1) getgenv().Team = \"%s\" loadstring(game:HttpGet(\"https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua\"))() ", config.TeamSelectLoad or "Pirates")

					if not pcall(function()
						syn.queue_on_teleport(str5)
					end) then
						pcall(function()
							queue_on_teleport(str5)
						end)
					end
				end
			end,
			ToggleDamageCounter = function(arg)
				pcall(function()
					RS.Assets.GUI.DamageCounter.Enabled = not arg
				end)
			end,
			ToggleNotifications = function(arg)
				pcall(function()
					localPlayer.PlayerGui.Notifications.Enabled = not arg
				end)
			end,
			ToggleWalkInWater = function(water)
				config.Water = water

				if water then
					if thread then
						task.cancel(thread)
						thread = nil
					end

					thread = task.spawn(function()
						local map2 = v2:FindFirstChild("Map") or v2:WaitForChild("Map", 5)

						if map2 then
							map2 = map2:FindFirstChild("WaterBase-Plane") or map2:WaitForChild("WaterBase-Plane", 5)
						end

						while config.Water do
							if map2 then
								map2.Size = Vector3.new(1000, 113, 1000)
							end

							task.wait(0.5)
						end

						if map2 then
							map2.Size = Vector3.new(1000, 80, 1000)
						end
					end)
				end
			end,
		}

		local now = os.time()

		tbl19.OnAutoHop30Mins = function(arg)
			if not arg then
				return
			end

			if os.time() - now >= 1800 then
				if mods and mods.SendNotify then
					mods:SendNotify("Server Hop", "30 minutes elapsed. Hopping to a new server...", 4)
				end

				utilities:ServerHop()
			else
				local n2 = 1800 - os.time() - now
				warn(("[AutoHop] Wait %dm %ds"):format(math.floor(n2 / 60), n2 % 60))
			end
		end

		local thread2 = nil

		local tbl20 = {
			"red_game43",
			"rip_indra",
			"Axiore",
			"Polkster",
			"wenlocktoad",
			"Daigrock",
			"toilamvidamme",
			"oofficialnoobie",
			"Uzoth",
			"Azarth",
			"arlthmetic",
			"Death_King",
			"Lunoven",
			"TheGreateAced",
			"rip_fud",
			"drip_mama",
			"layandikit12",
			"Hingoi",
		}

		tbl19.ToggleHopAdmin = function(hopWhenAdmin)
			config.HopWhenAdmin = hopWhenAdmin

			if hopWhenAdmin then
				if thread2 then
					task.cancel(thread2)
					thread2 = nil
				end

				thread2 = task.spawn(function()
					while config.HopWhenAdmin do
						task.wait(1.5)

						for _, player in ipairs(v3:GetPlayers()) do
							if table.find(tbl20, player.Name) then
								if mods and mods.SendNotify then
									mods:SendNotify("Server Hop", "Admin detected (" .. player.Name .. ")! Hopping...", 5)
								end

								utilities:ServerHop(0)
								break
							end
						end
					end
				end)
			end
		end

		local thread3 = nil

		tbl19.ToggleAntiAFK = function(antiAFK)
			config.AntiAFK = antiAFK

			if antiAFK then
				if thread3 then
					task.cancel(thread3)
					thread3 = nil
				end

				thread3 = task.spawn(function()
					while config.AntiAFK do
						if v17 then
							pcall(function()
								v17:CaptureController()
								v17:ClickButton1(Vector2.new(0, 0))
							end)
						end

						task.wait(300)
					end
				end)
			end
		end

		tbl19.RemoveEffects = function()
			if RemoveEffects then
				RemoveEffects()()
			end
		end

		tbl19.BribeLeviathan = function()
			mods:FireInvoke("InfoLeviathan", "2")
		end

		tbl19.GetAllBoats = function()
			local tbl21 = { "My Boat" }

			if v2:FindFirstChild("Boats") then
				for _, child in ipairs(v2.Boats:GetChildren()) do
					if child.Name ~= "Boat" and not table.find(tbl21, child.Name) then
						table.insert(tbl21, child.Name)
					end
				end
			end

			return tbl21
		end

		tbl19.BuyNewBoat = function()
			local boatSelected = config.BoatSelected
			local str5 = typeof(boatSelected) == "number" and tbl17.BoatsList[boatSelected] or typeof(boatSelected) == "string" and boatSelected ~= "" and boatSelected or isSea3 and "Beast Hunter" or "PirateBrigade"
			local cframe = GetNearestBoatDealerCF and GetNearestBoatDealerCF()

			if not cframe then
				cframe = isSea3 and CFrame.new(-16927.451, 9.086, 433.864) or isSea2 and CFrame.new(-5330, 5, -714) or CFrame.new(94, 5, 1374)
			end

			if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and (localPlayer.Character.HumanoidRootPart.Position - cframe.Position).Magnitude > 35 then
				if tweenManager and tweenManager.topos then
					tweenManager:topos(cframe)
				end

				task.wait(0.5)
			end

			BuyBoatSafe(str5, true)

			if mods and mods.SendNotify then
				mods:SendNotify("Boat Dealer", "Requested " .. tostring(str5) .. "!", 4)
			end
		end

		tbl19.OpenFishIndex = function()
			pcall(function()
				localPlayer:WaitForChild("PlayerGui"):SetAttribute("FishIndexVisible", true)
			end)
		end

		tbl19.GetStatsInfo = function()
			if not localPlayer:FindFirstChild("Data") or not data then
				return "Loading..."
			end
			local stats = data.Stats
			local points = data.Points
			if not stats or not points then
				return "No Stats"
			end
			local tbl21 = { "Points Available: " .. tostring(points.Value) }

			for _, v25 in ipairs({ "Melee", "Defense", "Sword", "Gun", "Demon Fruit" }) do
				table.insert(tbl21, v25 .. ": " .. (stats:FindFirstChild(v25) and stats[v25]:FindFirstChild("Level") and stats[v25].Level.Value or 0))
			end

			return table.concat(tbl21, "\n")
		end

		local thread4 = nil

		tbl19.AutoStats = function()
			local function fn28(arg)
				if not data or not data.Points then
					return
				end
				local value = data.Points.Value

				if value >= 1 and config.PointsSlider and config.PointsSlider > 0 then
					local n2 = math.clamp(config.PointsSlider, 1, value)
					mods:FireInvoke("AddPoint", arg, n2)
				end
			end

			if thread4 then
				task.cancel(thread4)
				thread4 = nil
			end

			thread4 = task.spawn(function()
				while config.AutoStats do
					task.wait(0.3)

					if config.Melee then
						fn28("Melee")
					end

					if config.Defense then
						fn28("Defense")
					end

					if config.Sword then
						fn28("Sword")
					end

					if config.Gun then
						fn28("Gun")
					end

					if config.DemonFruit then
						fn28("Demon Fruit")
					end
				end
			end)
		end

		tbl19.GetPlayerList = function()
			local tbl21 = { "Nearest" }

			for _, child in ipairs(v3:GetChildren()) do
				if child.Name ~= localPlayer.Name then
					table.insert(tbl21, child.Name)
				end
			end

			return tbl21
		end

		local connection = nil

		tbl19.OnCamLockToggle = function(camLock)
			config.CamLock = camLock

			if connection then
				connection:Disconnect()
				connection = nil
			end

			if camLock then
				connection = v6.RenderStepped:Connect(function()
					if not config.CamLock then
						if connection then
							connection:Disconnect()
							connection = nil
						end

						return
					end

					pcall(function()
						local nearestPlayer = (config.SelectPlayer == "Nearest" or not config.SelectPlayer) and gameData:GetNearestPlayer() or v3:FindFirstChild(config.SelectPlayer)
						nearestPlayer = nearestPlayer and nearestPlayer.Character
						local humanoid2 = nearestPlayer and nearestPlayer:FindFirstChildOfClass("Humanoid")

						if nearestPlayer then
							nearestPlayer = nearestPlayer:FindFirstChild("Head") or nearestPlayer:FindFirstChild("HumanoidRootPart") or nearestPlayer.PrimaryPart
						end

						if nearestPlayer and humanoid2 and humanoid2.Health > 0 then
							local currentCamera = v2.CurrentCamera or v2.Camera

							if currentCamera then
								currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, nearestPlayer.Position)
							end
						end
					end)
				end)
			end
		end

		local function fn28()
			pcall(function()
				local currentCamera = v2.CurrentCamera or v2.Camera
				local humanoid2 = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

				if currentCamera and humanoid2 then
					currentCamera.CameraSubject = humanoid2
				end
			end)
		end

		local function fn29()
			if not config.SpectatePlayer then
				fn28()
				return
			end

			pcall(function()
				local nearestPlayer = (config.SelectPlayer == "Nearest" or not config.SelectPlayer) and gameData:GetNearestPlayer() or v3:FindFirstChild(config.SelectPlayer)
				local humanoid2 = nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChildOfClass("Humanoid")
				local currentCamera = v2.CurrentCamera or v2.Camera

				if currentCamera then
					if humanoid2 and humanoid2.Health > 0 then
						currentCamera.CameraSubject = humanoid2
					else
						local humanoid3 = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

						if humanoid3 then
							currentCamera.CameraSubject = humanoid3
						end
					end
				end
			end)
		end

		tbl19.OnSpectateToggle = function(spectatePlayer)
			config.SpectatePlayer = spectatePlayer

			if not spectatePlayer then
				fn28()
			else
				fn29()
			end
		end

		tbl19.OnTPPlayerToggle = function(teleporttoPlayer)
			config.TeleporttoPlayer = teleporttoPlayer

			if not teleporttoPlayer then
				tweenManager:StopTween()
			end
		end

		tbl19.GetPlayerHunterQuest = function()
			if isSea3 then
				pcall(function()
					mods:FireInvoke("PlayerHunter")
				end)
			end
		end

		local function fn30()
			local fantasySky = LightingSvc:FindFirstChild("FantasySky") or LightingSvc:FindFirstChild("Sky") or LightingSvc:FindFirstChildWhichIsA("Sky")
			return fantasySky and fantasySky.MoonTextureId or ""
		end

		local function fn31()
			local attribute2 = LightingSvc:GetAttribute("MoonPhase")
			local str5 = tostring(fn30())
			local clockTime = LightingSvc.ClockTime
			local flag4 = clockTime >= 18 or clockTime <= 5.5
			if LightingSvc:GetAttribute("IsBlueMoon") == true then
				return "Blue Moon (Active)"
			end

			if attribute2 == 5 or str5:find("9709149431") then
				return flag4 and "Full Moon (Active)" or "Full Moon (Tonight)"
			end

			if attribute2 == 4 then
				return "Phase 4 (Next Night Full Moon)"
			end

			if attribute2 then
				return string.format("Phase %d (%d nights left)", attribute2, (5 - attribute2) % 8)
			end
			return "Phase 1"
		end

		local function fn32(arg, arg2)
			local attribute2 = LightingSvc:GetAttribute("MoonPhase") or 1
			local flag4 = arg2 >= 18 or arg2 <= 5.5
			if LightingSvc:GetAttribute("IsBlueMoon") == true then
				return "Kitsune Shrine Active"
			end

			if flag4 then
				local n2 = math.max(0, math.floor((arg2 <= 5.5 and 5.5 - arg2 or 24 - arg2 + 5.5) * 60))
				return string.format("Night Ends in %dm %02ds", math.floor(n2 / 60), n2 % 60)
			end
			local n2 = math.max(0, math.floor((18 - arg2) * 60))
			if attribute2 == 5 or arg and arg:find("Full Moon") then
				return string.format("Rises in %dm %02ds", math.floor(n2 / 60), n2 % 60)
			end
			return string.format("Next Night in %dm %02ds", math.floor(n2 / 60), n2 % 60)
		end

		local function fn33()
			if not localPlayer.Character:FindFirstChild("RaceTransformed") then
				return "Not Ready"
			end
			local UpgradeRace, v25, v26 = mods:FireInvoke("UpgradeRace", "Check")
			local tbl21 = { [0] = "Ready For Trial", "Need More Training" }
			tbl21[2] = "Can Buy Gear With " .. (v26 or "?") .. " Fragments"
			tbl21[3] = "Need More Training"
			tbl21[4] = "Can Buy Gear With " .. (v26 or "?") .. " Fragments"
			tbl21[5] = "Race Complete"
			tbl21[6] = (v25 or 2) - 2 .. "/3 Upgrades Done"
			tbl21[7] = "Can Buy Gear With " .. (v26 or "?") .. " Fragments"
			tbl21[8] = 10 - (v25 or 10) .. " Training Sessions Left"
			return tbl21[UpgradeRace] or "Unknown"
		end

		local function fn34()
			local num = tonumber(string.match(mods:FireInvoke("CakePrinceSpawner", true), "%d+"))
			if num then
				return num
			end

			if utilities:CheckMon("Cake Prince") then
				return "Cake Prince"
			end

			if utilities:CheckMon("Dough King") then
				return "Dough King"
			end
			return "None"
		end

		local function fn35()
			local ok, result = pcall(function()
				return mods:FireInvoke("LegendarySwordDealer", "1")
			end)

			return ok and result or "Unknown"
		end

		local function fn36()
			local InfoLeviathan = mods:FireInvoke("InfoLeviathan", "1")
			if not InfoLeviathan or InfoLeviathan == -1 then
				return "I don't know anything yet."
			end

			return ({
				"I haven't heard a thing, mate. It's quiet as a ghost ship out there.",
				"Some citizens claim they heard something strange, I doubt it though..",
				"I heard it's been a bit chilly outside. That's a bit strange..",
				"It's just downright freezing out! What's with these ominous clouds? Something's happening..",
				"The Leviathan is out there! Go find it before it causes more destruction.",
			})[InfoLeviathan] or "No Bribe Data"
		end

		local function fn37()
			return worldOrigin.Locations:FindFirstChild("Mirage Island") and "[Spawned]" or "[None]"
		end

		local function fn38()
			return worldOrigin.Locations:FindFirstChild("Kitsune Island") and "[Spawned]" or "[None]"
		end

		local function fn39()
			return worldOrigin.Locations:FindFirstChild("Frozen Dimension") and "[Spawned]" or "[None]"
		end

		local function fn40()
			return worldOrigin.Locations:FindFirstChild("Prehistoric Island") and "[Spawned]" or "[None]"
		end

		local function fn41(arg)
			local n2 = math.floor(arg / 3600)
			local n3 = math.floor(arg % 3600 / 60)
			local n4 = math.floor(arg % 60)
			return n2 > 0 and string.format("%dh %02dm %02ds", n2, n3, n4) or string.format("%dm %02ds", n3, n4)
		end

		local function fn42()
			local v25 = nil

			for _, child in ipairs(worldOrigin.Locations:GetChildren()) do
				local attribute2 = child:GetAttribute("TimeIn")

				if attribute2 and attribute2 > 1.7e9 then
					if v25 == nil or attribute2 < v25 then
						v25 = attribute2
					end
				end
			end

			if v25 then
				local n2 = os.time() - v25
				local n3 = math.floor(n2 / 3600)
				local n4 = math.floor(n2 % 3600 / 60)
				local n5 = math.floor(n2 % 60)
				return string.format("%dh %dm %ds", n3, n4, n5)
			end

			return "Unknown"
		end

		local function fn43()
			if enemies then
				local v25 = next
				local children2, v26 = enemies:GetChildren()

				for _, v27 in v25, children2, v26 do
					local humanoid2 = v27:FindFirstChildOfClass("Humanoid")

					if humanoid2 and humanoid2.Health > 0 then
						if v27.Name:find("indra") then
							return "[Used - rip_indra Active!]"
						end

						if v27.Name:find("Dough King") then
							return "[Used - Dough King Active!]"
						end

						if v27.Name:find("Darkbeard") then
							return "[Used - Darkbeard Active!]"
						end
					end
				end
			end

			local v25 = next
			local players, v26 = v3:GetPlayers()

			for _, v27 in v25, players, v26 do
				local character2 = v27.Character
				local backpack = v27:FindFirstChild("Backpack")
				if character2 and character2:FindFirstChild("God's Chalice") or backpack and backpack:FindFirstChild("God's Chalice") then
					return "[Spawned - Held by " .. (v27.DisplayName or v27.Name) .. "]"
				end

				if character2 and character2:FindFirstChild("Sweet Chalice") or backpack and backpack:FindFirstChild("Sweet Chalice") then
					return "[Sweet Chalice - Held by " .. (v27.DisplayName or v27.Name) .. "]"
				end

				if character2 and character2:FindFirstChild("Fist of Darkness") or backpack and backpack:FindFirstChild("Fist of Darkness") then
					return "[Fist of Darkness - Held by " .. (v27.DisplayName or v27.Name) .. "]"
				end
			end

			local v27 = nil

			for _, child in ipairs(worldOrigin.Locations:GetChildren()) do
				local attribute2 = child:GetAttribute("TimeIn")

				if attribute2 and attribute2 > 1.7e9 then
					if v27 == nil or attribute2 < v27 then
						v27 = attribute2
					end
				end
			end

			if v27 then
				local n2 = os.time() - v27

				if n2 < 14400 then
					local n3 = 14400 - n2
					local n4 = math.floor(n3 / 3600)
					local n5 = math.floor(n3 % 3600 / 60)
					local n6 = math.floor(n3 % 60)
					return string.format("Not Spawned (Wait %dh %02dm %02ds)", n4, n5, n6)
				end

				local n3 = 14400 - n2 % 14400
				local n4 = math.floor(n3 / 3600)
				local n5 = math.floor(n3 % 3600 / 60)
				return string.format("Available in Chests (Next: %dh %02dm)", n4, n5)
			end

			return "Unknown"
		end

		local function fn44()
			if not isSea3 then
				return "None | 0"
			end

			local ok, result = pcall(function()
				return mods:FireInvoke("EliteHunter", "Progress")
			end)

			ok = ok and tonumber(result)
			local n2 = 0

			if ok then
				n2 = tonumber(result)
			end

			local checkelites = gameData.Checkelites and gameData:Checkelites()
			return string.format("%s | %s", checkelites and tostring(checkelites) or "None", tostring(n2))
		end

		local function statusServer()
			local v25 = fn31()
			local str5 = fn32(v25, LightingSvc.ClockTime)
			local n2 = tick() - now
			local str6 = isSea3 and "God's Chalice: " .. fn43() .. "\n" or isSea2 and "Fist of Darkness: " .. fn43() .. "\n" or ""
			local str7 = isSea3 and "Elite Hunter: " .. fn44() .. "\n" or ""

			local function fn45()
				local distributedGameTime = v2.DistributedGameTime
				local flag4 = os.date("!*t").wday == 1 or os.date("!*t").wday == 7
				local n3 = flag4 and 2700 or 3600
				local n4 = n3 - distributedGameTime % n3
				local n5 = math.floor(n4 / 60)
				local n6 = math.floor(n4 % 60)
				local tbl21 = {}
				local v26 = next
				local children2, v27 = v2:GetChildren()

				for _, v28 in v26, children2, v27 do
					if v28:IsA("Model") and v28.Name:find("Fruit") and v28:FindFirstChild("Handle") then
						table.insert(tbl21, v28.Name == "Fruit" and "Spawned Fruit" or v28.Name)
					end
				end

				if #tbl21 > 0 then
					return string.format("Spawned Now! (%s)", table.concat(tbl21, ", "))
				end
				return string.format("%02dm %02ds (%s)", n5, n6, flag4 and "Weekend Boost" or "Weekday")
			end

			local tbl21 = {}
			local str8 = "Server Uptime: " .. fn42() .. "\n"
			local str9 = "Time in Server: " .. fn41(n2) .. "\n"
			local str10 = "Next Fruit Spawn: " .. fn45() .. "\n"
			str5 = str5 and " | " .. str5 or ""
			local str11 = "Sword: " .. fn35() .. "\n"
			local str12 = "Cake Stats: " .. fn34() .. "\n"
			local str13 = "Ancient One: " .. fn33() .. "\n"
			local str14 = "Bribe: " .. fn36() .. "\n"
			local str15 = "Mirage: " .. fn37() .. "\n"
			local str16 = "Kitsune: " .. fn38() .. "\n"
			local str17 = "Frozen Dimension: " .. fn39() .. "\n"
			local str18 = "Prehistoric: " .. fn40() .. ""
			tbl21[1] = str8
			tbl21[2] = str9
			tbl21[3] = str10
			tbl21[4] = str6
			tbl21[5] = str7
			tbl21[6] = "Moon: " .. v25 .. str5 .. "\n"
			tbl21[7] = str11
			tbl21[8] = str12
			tbl21[9] = str13
			tbl21[10] = str14
			tbl21[11] = str15
			tbl21[12] = str16
			tbl21[13] = str17
			tbl21[14] = str18
			return table.concat(tbl21, "\n")
		end

		tbl19.StatusServer = statusServer
		mods._StatusServer = statusServer

		local function fn45()
			local ok, result, result2, result3 = pcall(function()
				return mods:FireInvoke("Cousin", "Check", "DLCBoxData")
			end)

			if not ok then
				return "Error"
			end

			if tonumber(result2) < 50 then
				return "Need level 50"
			end

			local ok2, result4 = pcall(function()
				return mods:FireInvoke("Cousin", "CheckTime", "DLCBoxData")
			end)

			if ok2 and result4 == true then
				return "Ready ($" .. math.floor(tonumber(result3)) .. ")"
			end
			return ok2 and type(result4) == "string" and result4 or "Unknown"
		end

		local function fn46()
			local ok, result, result2, result3, result4 = pcall(function()
				return mods:FireInvoke("Bones", "Check")
			end)

			local num = nil
			local num2 = nil

			if ok then
				if type(result) == "table" then
					num2 = tonumber(result[3] or result.PurchasesLeft or result.left)
					num = tonumber(result[4] or result.WaitMinutes or result.wait)
				else
					num2 = tonumber(result3)
					num = tonumber(result4)
				end
			end

			if not ok or not num2 then
				return "Error"
			end

			if num2 <= 0 then
				return "No purchases left — wait " .. tostring(num or "?") .. " min"
			end
			return num2 .. " purchase(s) left"
		end

		local function fn47()
			local KenTalk = mods:FireInvoke("KenTalk", "Status")
			local num = tonumber(KenTalk and string.match(tostring(KenTalk), "%d+"))

			if not num then
				num = localPlayer:FindFirstChild("VisionRadius") and localPlayer.VisionRadius.Value or 0
			end

			local attribute2 = localPlayer:GetAttribute("KenMaxDodges") or 0
			local attribute3 = localPlayer:GetAttribute("KenDodgesLeft") or 0
			local str5 = num >= 5000 and "Max" or num >= 4500 and "7" or num >= 3000 and "6" or num >= 1800 and "5"
			local str6

			if str5 then
				str6 = str5
			else
				str6 = num >= 900 and "4"
			end

			local str7

			if str6 then
				str7 = str6
			else
				str7 = num >= 300 and "3"
			end

			local str8

			if str7 then
				str8 = str7
			else
				str8 = num >= 50 and "2"
			end

			str8 = str8 or "1"
			attribute2 = attribute2 > 0 and attribute2

			if not attribute2 then
				local n2 = num >= 4500 and 8
				local n3

				if n2 then
					n3 = n2
				else
					n3 = num >= 3000 and 7
				end

				n3 = n3 or num >= 1800 and 6

				if n3 then
					attribute2 = n3
				else
					attribute2 = num >= 900 and 5
				end

				attribute2 = attribute2 or num >= 300 and 4 or num >= 50 and 3 or 2
			end

			return string.format("%d/5000 (Lvl %s • %d/%d Dodges)", math.floor(num), tostring(str8), attribute3, attribute2)
		end

		tbl19.PlayerStatus = function()
			local tbl21 = {}
			local str5 = "Next Roll: " .. fn45() .. "\n"
			local str6 = "Bone Roll: " .. fn46() .. "\n"
			local str7 = "Observation: " .. fn47() .. "\n"
			local str8 = "Simulation Data: " .. tostring(localPlayer:GetAttribute("SimulationData") or "N/A")
			tbl21[1] = str5
			tbl21[2] = str6
			tbl21[3] = str7
			tbl21[4] = str8
			return table.concat(tbl21, "\n")
		end

		tbl19.GetFruitStock = function()
			return serverStatus and serverStatus:GetFruitStock() or "No fruit stock data"
		end

		tbl19.TPDojoTrainer = function()
			tweenManager:topos(CFrame.new(5867, 1208, 870))
		end

		tbl19.TPDragonHunter = function()
			tweenManager:topos(CFrame.new(5864, 1209, 808))
		end

		tbl19.TPDragonWizard = function()
			tweenManager:topos(CFrame.new(5775, 1209, 806))
		end

		tbl19.ToggleUpgradeDragonTalon = function(autoUpgradeDragonTalon)
			config.AutoUpgradeDragonTalon = autoUpgradeDragonTalon
			if not autoUpgradeDragonTalon then
				return tweenManager:StopTween()
			end

			task.spawn(function()
				while config.AutoUpgradeDragonTalon and task.wait(0.5) do
					local cframe = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)
					tweenManager:topos(cframe)

					if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and (cframe.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
						RS.Modules.Net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Uzoth", Command = "Upgrade" })
					end
				end
			end)
		end

		tbl19.CraftPrehistoricItem = function(arg)
			net:WaitForChild("RF/Craft"):InvokeServer("Craft", arg, 1, {})
		end

		tbl19.ChangeDracoRace = function()
			if localPlayer:DistanceFromCharacter(Vector3.new(5773, 1210, 807)) <= 5 then
				net("RF/InteractDragonQuest"):InvokeServer({ NPC = "Dragon Wizard", Command = "DragonRace" })
			else
				tweenManager:topos(CFrame.new(5773, 1210, 807))
			end
		end

		tbl19.UnlockDungeonDifficulty = function()
			pcall(function()
				RS.DungeonShared.DataRemote:InvokeServer("TryUnlockDifficulty", "Simulation", "Hard")
			end)

			pcall(function()
				RS.DungeonShared.DataRemote:InvokeServer("TryUnlockDifficulty", "Simulation", "Challenge")
			end)

			pcall(function()
				net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockDifficulty")
			end)

			pcall(function()
				net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockNext")
			end)

			mods:SendNotify("Dungeon", "Attempted to unlock difficulty", 4)
		end

		tbl19.TPDungeonHub = function()
			net["RF/DungeonNPCNetworkFunction"]:InvokeServer("TeleportToDungeonHub", false)
		end

		tbl19.TPDungeonBack = function()
			net["RF/DungeonNPCNetworkFunction"]:InvokeServer("TeleportBack")
		end

		tbl19.OpenNormalFruitShop = function()
			require(RS.Controllers.UI.FruitShop):Open()
		end

		tbl19.OpenAdvFruitShop = function()
			require(RS.Controllers.UI.FruitShop):Open("AdvancedFruitDealer")
		end

		tbl19.GetFruitSpawnStatus = function()
			if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character.HumanoidRootPart.Position then
				local v25 = next
				local children2, v26 = v2:GetChildren()
				local n2 = 0
				local huge = math.huge

				for _, v27 in v25, children2, v26 do
					if v27:IsA("Model") and string.find(v27.Name, "Fruit") then
						local handle = v27:FindFirstChild("Handle")

						if handle and handle:IsA("BasePart") then
							n2 += 1
							local v28 = localPlayer:DistanceFromCharacter(handle.Position)

							if v28 < huge then
								huge = v28
							end
						end
					end
				end

				return n2 > 0 and string.format("Fruits Found: %d\nPosition: %.2f Studs Away", n2, huge) or "No fruits detected nearby."
			end

			return "Scanning for fruit..."
		end

		tbl19.TPAdvFruitDealer = function()
			if map:FindFirstChild("MysticIsland") then
				local v25 = getnilinstances()
				local v26 = next
				local children2, v27 = RS.NPCs:GetChildren()

				for _, v28 in v26, children2, v27 do
					table.insert(v25, v28)
				end

				for _, v28 in pairs(v25) do
					if v28.Name == "Advanced Fruit Dealer" then
						tweenManager:topos(v28.PrimaryPart.CFrame)
					end
				end
			end
		end

		local function fn48()
			local tbl21 = {}

			local ok, result = pcall(function()
				return Net:RemoteFunction("GetAllItemValues"):InvokeServer()
			end)

			if ok and result then
				for _, v25 in next, result, nil do
					if v25.Key == "AccessoryType" and v25.Value == "Trinket" or v25.Key == "Type" and v25.Value == "Trinket" then
						if v25.NetworkedUID then
							table.insert(tbl21, v25.NetworkedUID)
						end
					end
				end
			end

			return tbl21
		end

		tbl19.BuyTrinket = function()
			mods:SendNotify("Trinkets", pcall(function()
				return RS.Remotes.AccessoryInteract:InvokeServer("d")
			end) and "Purchased Trinket!" or "Failed to purchase trinket.", 4)
		end

		tbl19.FuseTrinkets = function()
			local v25 = fn48()

			if #v25 >= 3 then
				mods:SendNotify("Trinkets", pcall(function()
					return RS.Remotes.AccessoryInteract:InvokeServer("a", v25[1], v25[2], v25[3])
				end) and "Fused 3 Trinkets successfully!" or "Failed to fuse trinkets.", 4)
			else
				mods:SendNotify("Trinkets", "Need at least 3 trinkets (Found: " .. tostring(#v25) .. ")", 4)
			end
		end

		tbl19.RefineTrinket = function()
			local v25 = fn48()

			if #v25 >= 1 then
				mods:SendNotify("Trinket Refiner", pcall(function()
					return RS.Remotes.AccessoryInteract:InvokeServer("c", v25[1])
				end) and "Refined trinket!" or "Failed to refine trinket.", 4)
			else
				mods:SendNotify("Trinket Refiner", "No trinket available to refine.", 4)
			end
		end

		tbl19.OpenTrinketMergeGUI = function()
			pcall(function()
				localPlayer:WaitForChild("PlayerGui"):WaitForChild("AccessoryMerge").Open:Fire(false)
			end)
		end

		tbl19.OpenTrinketRefineGUI = function()
			pcall(function()
				localPlayer:WaitForChild("PlayerGui"):WaitForChild("AccessoryMerge").Open:Fire(true)
			end)
		end

		tbl19.OpenTrinketScrapGUI = function()
			pcall(function()
				localPlayer:WaitForChild("PlayerGui"):WaitForChild("AccessoryTrasher").Open:Fire()
			end)
		end

		tbl19.InitTempleOfTime = function()
			pcall(function()
				RS:FindFirstChild("MapStash"):FindFirstChild("Temple of Time").Parent = v2:FindFirstChild("Map")
			end)
		end

		tbl19.TPRaceDoor = function()
			if data and data.Race and tbl12[data.Race.Value] then
				tweenManager:topos(tbl12[data.Race.Value])
			end
		end

		tbl19.ResetCharHead = function()
			if localPlayer.Character and localPlayer.Character:FindFirstChild("Head") then
				localPlayer.Character.Head:Destroy()
			end
		end

		local tbl21 = {
			GreatTree = CFrame.new(2948, 2282, -7214),
			TempleOfTime = CFrame.new(28286, 14895, 103),
			AncientOne = CFrame.new(28982, 14888, -120),
			LeverPull = CFrame.new(28575, 14937, 72),
			SafeZone = CFrame.new(28273, 14897, 157),
			PvpZone = CFrame.new(28767, 14967, -164),
			Clock = CFrame.new(29552, 15069, -86),
		}

		tbl19.TPTrialArea = function(arg)
			if tbl21[arg] then
				tweenManager:topos(tbl21[arg])
			end
		end

		tbl19.TeleportJobID = function(arg)
			local str5 = tostring(arg):gsub("`", ""):gsub("lua", ""):gsub("%s+", "")
			RS.__ServerBrowser:InvokeServer("teleport", str5)
		end

		tbl19.TeleportQuantumPremium = function(arg)
			local str5 = tostring(arg):gsub("`", ""):gsub("lua", ""):gsub("QuantumOnyx%-", ""):gsub("%s+", "")

			if fn4 then
				str5 = fn4(str5)
			end

			RS.__ServerBrowser:InvokeServer("teleport", str5)
		end

		tbl19.RejoinServer = function()
			RS.__ServerBrowser:InvokeServer("teleport", RS.__ServerBrowser:InvokeServer("getjob"))
		end

		tbl19.ServerHop = function()
			utilities:ServerHop()
		end

		tbl19.JoinAPI = joinAPI

		tbl19.JoinRaidBossServer = function()
			local selectBosstoHop = config.SelectBosstoHop

			if type(selectBosstoHop) == "number" or not selectBosstoHop or selectBosstoHop == "" then
				selectBosstoHop = bossHopNames[selectBosstoHop] or bossHopNames[1] or "rip_indra True Form"
			end

			selectBosstoHop = tbl14[selectBosstoHop] or selectBosstoHop or "Ripindra"

			if joinAPI then
				joinAPI(tostring(selectBosstoHop))
			end
		end

		tbl19.BuyItem = function(arg, arg2)
			local v25 = itemsToBuy and itemsToBuy[arg2] and itemsToBuy[arg2][arg]
			if not v25 then
				return
			end

			if arg2 == "Frags" or arg2 == "Ability" or arg2 == "Accessory" then
				mods:FireInvoke(unpack(v25))
			elseif arg2 == "Sword" then
				task.wait(0.1)
				mods:FireInvoke(arg == "Pole v.2" and v25 or "BuyItem", v25)
			elseif arg2 == "Gun" then
				task.wait(0.5)

				if arg == "Kabucha" then
					mods:FireInvoke(v25[1], v25[2], v25[3])
					mods:FireInvoke(v25[1], v25[2], "2")
				else
					mods:FireInvoke(unpack(v25))
				end
			end
		end

		tbl19.BuySelectedFruit = function()
			local selectFruitDealerFruit = config.SelectFruitDealerFruit
			if not selectFruitDealerFruit or selectFruitDealerFruit == "" then
				mods:SendNotify("Fruit Dealer", "Please select a fruit first.", 4)
				return
			end

			local ok, result = pcall(function()
				return mods:FireInvoke("GetFruits")
			end)

			if ok and typeof(result) == "table" then
				for _, v25 in next, result, nil do
					if v25 and (v25.Name == selectFruitDealerFruit or v25.Name:match("^(.-)%-") == selectFruitDealerFruit:match("^(.-)%-")) then
						if v25.OnSale then
							local ok2 = pcall(function()
								return mods:FireInvoke("PurchaseRawFruit", v25.Name, false)
							end)

							local v26 = mods
							local sendNotify = v26.SendNotify

							if ok2 then
								ok2 = "Purchased " .. v25.Name .. " for $" .. fn15(v25.Price or 0) .. "!"
							end

							sendNotify(v26, "Fruit Dealer", ok2 or "Failed to purchase " .. v25.Name, 5)
						else
							mods:SendNotify("Fruit Dealer", v25.Name .. " is currently out of stock!", 4)
						end

						return
					end
				end
			end

			mods:SendNotify("Fruit Dealer", "Could not check fruit stock.", 4)
		end

		tbl19.BuyCyborgRace = function()
			mods:FireInvoke("CyborgTrainer", "Buy")
		end

		tbl19.BuyGhoulRace = function()
			mods:FireInvoke("Ectoplasm", "BuyCheck", 4)
			mods:FireInvoke("Ectoplasm", "Change", 4)
		end

		local tbl22 = {
			["Common Scroll"] = "CommonScroll",
			["Rare Scroll"] = "RareScroll",
			["Legendary Scroll"] = "LegendaryScroll",
			["Mythical Scroll"] = "MythicalScroll",
		}

		tbl19.CraftScroll = function()
			local selectScrollType = config.SelectScrollType or "Common Scroll"
			local str5 = tbl22[selectScrollType] or "CommonScroll"
			local n2 = tonumber(config.ScrollCraftAmount) or 1

			mods:SendNotify("Scroll Craft", pcall(function()
				return Net:RemoteFunction("Craft"):InvokeServer(str5, n2)
			end) and "Crafted " .. tostring(n2) .. "x " .. selectScrollType .. "!" or "Failed to craft scroll (check materials)", 5)
		end

		tbl19.OpenTitleNames = function()
			pcall(function()
				localPlayer:WaitForChild("PlayerGui"):WaitForChild("TitlesMenu").Open:Fire()
			end)
		end

		tbl19.OpenAwakenings = function()
			pcall(function()
				localPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
			end)
		end

		tbl19.OpenHakiColors = function()
			pcall(function()
				localPlayer.PlayerGui.Main.Colors.Visible = true
			end)
		end

		tbl19.SetWalkSpeed = function(walkSpeed)
			config.WalkSpeed = walkSpeed

			if config.WalkSpeed and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
				localPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
					localPlayer.Character.Humanoid.WalkSpeed = config.WalkSpeed
				end)

				localPlayer.Character.Humanoid.WalkSpeed = config.WalkSpeed
			end
		end

		tbl19.SetJumpPower = function(jumpPower)
			config.JumpPower = jumpPower

			if config.JumpPower and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
				localPlayer.Character.Humanoid.JumpPower = config.JumpPower
			end
		end

		local function fn49(arg)
			for _, descendant in pairs(v2:GetDescendants()) do
				if descendant:IsA("BasePart") and not descendant.Parent:FindFirstChild("Humanoid") and not descendant.Parent.Parent:FindFirstChild("Humanoid") then
					descendant.LocalTransparencyModifier = arg and 0.7 or 0
				end
			end
		end

		tbl19.ToggleXray = function(arg)
			fn49(arg)
		end

		local cameraMaxZoomDistance = localPlayer.CameraMaxZoomDistance

		tbl19.ToggleInfiniteZoom = function(arg)
			localPlayer.CameraMaxZoomDistance = arg and math.huge or cameraMaxZoomDistance
		end

		tbl19.ToggleWhiteScreen = function(whiteScreen)
			config.White_Screen = whiteScreen
			v6:Set3dRenderingEnabled(not whiteScreen)
		end

		tbl19.ToggleBlackScreen = function(blackScreen)
			config.BlackScreen = blackScreen

			pcall(function()
				if localPlayer.PlayerGui.Main:FindFirstChild("Blackscreen") then
					localPlayer.PlayerGui.Main.Blackscreen.Size = blackScreen and UDim2.new(1000, 0, 1000, 1000) or UDim2.new(1, 0, 1000, 1000)
				end
			end)
		end

		tbl19.RedeemAllCodes = function()
			task.spawn(function()
				if mods and mods.SendNotify then
					mods:SendNotify("Codes", "Fetching working codes from Blox Fruits Wiki...", 3)
				end

				local tbl23 = {}
				local tbl24 = {}

				local function fn50(arg)
					if type(arg) == "string" then
						local str5 = arg:gsub("%s+", ""):gsub("\"", ""):gsub("'", "")

						if str5 ~= "" and not tbl24[str5] then
							tbl24[str5] = true
							table.insert(tbl23, str5)
						end
					end
				end

				if fn2 then
					pcall(function()
						local v25 = fn2({ Url = "https://blox-fruits.fandom.com/wiki/Codes", Method = "GET" })

						if v25 and v25.StatusCode == 200 and v25.Body then
							local body = v25.Body
							local pos = body:find("id=\"Working_Codes\"") or body:find("Working_Codes")
							local pos2 = body:find("id=\"Expired_Codes\"") or body:find("Expired_Codes")

							if pos then
								local str5 = pos2 and body:sub(pos, pos2) or body:sub(pos, pos + 35000)

								for match in str5:gmatch("<td><code>([^<]+)</code>") do
									fn50(match)
								end

								for match in str5:gmatch("data%-tpt%-row%-id=\"([^\"]+)\"") do
									fn50(match)
								end
							end
						end
					end)
				end

				local n2 = #tbl23
				local redeem = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Redeem")
				local n3 = 0

				if redeem then
					for _, v25 in ipairs(tbl23) do
						local ok, result = pcall(function()
							return redeem:InvokeServer(v25)
						end)

						if ok and result and (result == "SUCCESS" or result == true or tostring(result):find("Success")) then
							n3 += 1
						end

						task.wait(0.06)
					end
				end

				if mods and mods.SendNotify then
					mods:SendNotify("Codes", string.format("Checked %d working codes! (%d successfully redeemed)", n2, n3), 4)
				end
			end)
		end

		tbl19.ForceFPSBoost = function()
			local terrain = v2:FindFirstChildOfClass("Terrain")

			if terrain then
				terrain.WaterWaveSize = 0
				terrain.WaterWaveSpeed = 0
				terrain.WaterReflectance = 0
				terrain.WaterTransparency = 0
			end

			LightingSvc.GlobalShadows = false
			LightingSvc.FogEnd = 9e9
			settings().Rendering.QualityLevel = 1

			for _, descendant in pairs(game:GetDescendants()) do
				if descendant:IsA("Part") or descendant:IsA("UnionOperation") or descendant:IsA("MeshPart") or descendant:IsA("CornerWedgePart") or descendant:IsA("TrussPart") then
					descendant.Material = "Plastic"
					descendant.Reflectance = 0
				elseif descendant:IsA("Decal") then
					descendant.Transparency = 1
				elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
					descendant.Lifetime = NumberRange.new(0)
				elseif descendant:IsA("Explosion") then
					descendant.BlastPressure = 1
					descendant.BlastRadius = 1
				end
			end

			for _, descendant in pairs(LightingSvc:GetDescendants()) do
				if descendant:IsA("BlurEffect") or descendant:IsA("SunRaysEffect") or descendant:IsA("ColorCorrectionEffect") or descendant:IsA("BloomEffect") or descendant:IsA("DepthOfFieldEffect") then
					descendant.Enabled = false
				end
			end

			local v25 = next
			local children2, v26 = v2:GetChildren()

			for _, v27 in v25, children2, v26 do
				if v27:IsA("ForceField") or v27:IsA("Sparkles") or v27:IsA("Smoke") or v27:IsA("Fire") then
					pcall(function()
						v27:Destroy()
					end)
				end
			end
		end

		tbl19.OpenDevConsole = function()
			pcall(function()
				game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
			end)
		end

		tbl19.CleanMemory = function()
			if hub and hub.Performance and hub.Performance.CleanMemory then
				hub.Performance.CleanMemory()
			end

			mods:SendNotify("Memory Cleaner", "Garbage collection completed & memory trimmed!", 4)
		end

		tbl19.OnFastModeToggle = function(arg)
			task.spawn(function()
				if hub and hub.Performance and hub.Performance.SetFastMode then
					hub.Performance.SetFastMode(arg)
				end
			end)
		end

		tbl19.SendTestWebhook = function()
			if config.Webhook and config.Webhook ~= "" then
				if PostWebhook and WeeboLogs then
					PostWebhook(config.Webhook, WeeboLogs("Test Notification", {
						Extra = "**Status:** Webhook connection is active & working properly!",
						Field2 = { name = "User", value = localPlayer.Name },
					}))
				end

				mods:SendNotify("Webhook", "Test webhook dispatched!", 4)
			else
				mods:SendNotify("Webhook", "Please enter a valid Webhook URL first.", 4)
			end
		end

		tbl19.SendDataLogNow = function()
			if hub and hub.Webhook and hub.Webhook.SendDataLog then
				hub.Webhook:SendDataLog("Quantum Onyx - Manual Data Log Request", "Triggered manually via UI button.")
			end

			mods:SendNotify("Data Log", "Data Log webhook sent successfully!", 5)
		end

		task.spawn(function()
			while task.wait(3) do
				if config.AutoFastMode and hub and hub.Performance and not hub.Performance.FastMode then
					hub.Performance.SetFastMode(true)
				end
			end
		end)

		local function fn50(arg, arg2)
			local ok, result = xpcall(arg2, function(arg3)
				return tostring(arg3) .. "\n" .. debug.traceback()
			end)

			if not ok then
				warn(string.format("[Quantum ERROR] Error while building UI Tab '%s':\n%s", arg, tostring(result)))
			end

			return ok
		end

		fn50("Home", function()
			local v25 = tbl15.Home:addSection()
			local v26 = v25:addMenu("Main Farm")
			local v27 = v26:addLabel("Debug Functions", "None")

			task.spawn(function()
				local flag4 = false

				while true do
					task.wait(1)
					local v28 = mods.GetEnabledFunctionNames()
					local flag5 = false

					for _, v29 in ipairs(v28) do
						if mods.IsMultiFunction(v29) then
							flag5 = true
							break
						end
					end

					if flag5 and not flag4 and mods.ActiveFunction == nil then
						v27:RefreshDesc("<font color=\"#FFAA00\"><b>Initializing Multifunctions, wait...</b></font>")
						continue
					end

					if flag5 then
						flag4 = true
					end

					local n2 = 0

					for _, v29 in ipairs(v28) do
						local v30 = mods.Functions[v29]

						if v30 and not v30.NoLock and not mods.IsMultiFunction(v29) then
							n2 += 1
						end
					end

					local tbl23 = {}

					for _, v29 in ipairs(v28) do
						local v30 = mods.Functions[v29]

						if v30 and not v30.NoLock then
							local functionDisplayNames = mods.FunctionDisplayNames and mods.FunctionDisplayNames[v29] or v29
							table.insert(tbl23, "<font color=\"" .. ((mods.IsMultiFunction(v29) or n2 < 2) and "#00FF00" or "#FF0000") .. "\"><b>" .. functionDisplayNames .. "</b></font>")
						end
					end

					v27:RefreshDesc(#tbl23 > 0 and table.concat(tbl23, "\n") or "None")
				end
			end)

			tbl16:CreateDropdown(v26, "Weapon", "SelectWeapon", "Melee", { "Melee", "Sword", "Blox Fruit", "Gun" }, { global = true })
			tbl16:CreateDropdown(v26, "Farm Method", "FarmMode", "Quest", { "Quest", "No Quest", "Nearest" }, { global = true })
			tbl16:CreateDropdown(v26, "Quest Farm Mode", "QuestFarmMode", "Double Quest", { "Single Quest", "Double Quest", "Triple Quest" }, { global = true, save = true })
			tbl16:CreateSlider(v26, "Nearest (Distance)", "checknearestdist", 1000, 5000, 1500, { global = true })
			tbl16:CreateToggle(v26, "Auto Farm", "AutoFarm", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v26, "Take Quest", "AcceptQuests", false, { global = true, save = true, description = "Accept Quest for Bones/Cakes" })
			tbl16:CreateToggle(v26, "Auto Bones", "AutoFarmBones", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v26, "Enable Mastery", "MasteryFarm", false, { global = true, save = true })
			tbl16:CreateSlider(v26, "Health Mob%", "HealthMob", 15, 100, 25, { global = true })
			tbl16:CreateToggle(v26, "Auto Random Surprise", "Auto_Random_Surprise", false, { global = true, save = true })
			tbl16:CreateToggle(v26, "Auto Pray", "AutoPray", false, { global = true })
			tbl16:CreateToggle(v26, "Auto Try Luck", "AutoTryLuck", false, { global = true })
			tbl16:CreateToggle(v26, "Auto Katakuri", "AutoFarmPrince", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v26, "Ignore Katakuri", "IgnoreCakePrince", false, { global = true })
			tbl16:CreateToggle(v26, "Auto Dough King", "AutoDoughKing", false, { global = true, save = true, stop = true })

			tbl16:CreateToggle(v26, "Ignore Farm Dough King Item", "IgnoreDoughChaliceFarm", false, {
				global = true,
				save = true,
				description = "this function will make the Auto Dough King only focus on boss and will not try to get chalice",
			})

			tbl16:CreateDropdown(v26, "Select Material", "SelectMaterial", tbl17.Materials and tbl17.Materials[1] or "Leather + Scrap Metal", tbl17.Materials or {}, { global = true })
			tbl16:CreateToggle(v26, "Auto Farm Material", "AutoMaterial", false, { global = true, stop = true })
			local v28 = v25:addMenu("Boss Farm")
			tbl16:CreateDropdown(v28, "Select Boss", "SelectBoss", 1, tbl17.BossNames or {}, { global = true })
			tbl16:CreateToggle(v28, "Auto Farm Boss", "AutoFarmBoss", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Kill All Bosses", "AutoKillAllBosses", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v28, "Get Boss Quest", "GetBossQuest", false, { global = true, save = true, description = "Automatically takes the boss quest before attacking" })
			local v29 = v25:addMenu("Tyrant Farm")

			tbl16:CreateToggle(v29, "Auto Summon Kill Tyrant Of The Skies", "AutoTyrantOfTheSkies", false, {
				global = true,
				save = true,
				stop = true,
				description = "turn on auto skill or gun shooting for destroying vases",
			})

			tbl16:CreateToggle(v29, "Use Skull Guitar for Vases", "ShootGunTyrant", true, {
				global = true,
				save = true,
				description = "Uses Skull Guitar custom shoot to destroy Tyrant vases",
			})

			local v30 = v25:addMenu("Chest Farm")
			tbl16:CreateToggle(v30, "Start Farming Chest", "AutoChest", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v30, "Stop If Items", "StopChest", false, { global = true, save = true })
			tbl16:CreateToggle(v30, "Auto Hop Server On Chests", "AutoHopChest", false, { global = true, save = true })
			tbl16:CreateSlider(v30, "Chest Hop Target Count", "ChestHopCount", 1, 50, 10, { global = true, save = true })
			tbl16:CreateToggle(v30, "Stop Hop If Chalice / Fist", "StopHopChestIfChalice", true, { global = true, save = true })
			local v31 = tbl15.Home:addSection()
			local v32 = v31:addMenu("Farm Settings")
			tbl16:CreateSlider(v32, "Tweening Speed", "TweenSpeed", 10, 250, 250, { global = true })
			tbl16:CreateToggle(v32, "Bypass TP ", "BypassTP", false, { locked = false, save = true, global = true })
			tbl16:CreateSlider(v32, "Farm Distance", "PosY", 0, 30, 18, { global = true })
			tbl16:CreateSlider(v32, "Bring Radius", "BringMonsterRadius", 150, 400, 350, { global = true })
			tbl16:CreateDropdown(v32, "Pos Method", "PosMethod", "Above", { "Above", "Orbit" }, { global = true })
			tbl16:CreateToggle(v32, "Start Bring", "BringMonster", true, { global = true, save = true })
			tbl16:CreateDropdown(v32, "Attack Method", "FastSettings", "Fast Attack", { "Fast Attack", "Legit Attack" }, { global = true })
			tbl16:CreateSlider(v32, "Fast Attack Delay", "FastAttackDelay", 0, 1, 0, { global = true, step = 0.01 })
			tbl16:CreateToggle(v32, "Fast Attack", "AutoAttack", true, { global = true, save = true })
			tbl16:CreateToggle(v32, "Quantum Attack", "QuantumAttack", false, { global = true })
			tbl16:CreateToggle(v32, "Auto Attack Gun", "AutoAttackGun", true, { global = true, save = true })

			tbl16:CreateDropdown(v32, "Dragonstorm Mode", "DragonstormMode", "Spread Damage", { "Spread Damage", "Single Damage" }, {
				global = true,
				save = true,
				description = "Choose between Spread Damage or Single Damage for Dragonstorm gun",
			})

			tbl16:CreateSlider(v32, "Gun Shoot Amount", "ShootAmount", 1, 10, 1, { global = true, save = true, description = "Number of shots to fire per attack cycle" })
			tbl16:CreateToggle(v32, "Remove Fast Attack Animation", "RemoveAnimationFast", true, { global = true, save = true })
			tbl16:CreateToggle(v32, "attack mobs", "attackmobs", true, { global = true, save = true })
			tbl16:CreateToggle(v32, "attack players", "attackplayers", true, { global = true, save = true })
			tbl16:CreateToggle(v32, "Auto Activate Observation Haki", "AutoActivateObservationHaki", false, { global = true, save = true })
			tbl16:CreateToggle(v32, "Auto Set Spawn Point", "AutoSetSpawnPoint", false, { global = true, save = true })
			tbl16:CreateToggle(v32, "Debounce Quests", "QuestDebounce", false, { global = true })
			tbl16:CreateToggle(v32, "Bypass Get Quest", "BypassGetQuest", false, { global = true, save = true, description = "Gets the quest without teleporting to the quest NPC" })
			tbl16:CreateDropdown(v32, "Select Team", "TeamSelectLoad", 1, { "Pirates", "Marines" }, { global = true })

			tbl16:CreateToggle(v32, "Auto Load Script on Load", "AutoLoadScriptonLoad", false, {
				global = true,
				save = true,
				description = "Works on higher unc executors",
				callback = tbl19.OnAutoLoadScript,
			})

			tbl16:CreateToggle(v32, "Disable Damage Counter", "DisableDamageCounter", false, { callback = tbl19.ToggleDamageCounter })
			tbl16:CreateToggle(v32, "Disable Notifications", "DisableNotifications", false, { callback = tbl19.ToggleNotifications })
			tbl16:CreateToggle(v32, "Walk in Water", "Water", true, { callback = tbl19.ToggleWalkInWater })
			tbl16:CreateToggle(v32, "Auto Hop when 30mins", "AutoHopwhen30mins", false, { locked = false, global = true, save = true, callback = tbl19.OnAutoHop30Mins })
			tbl16:CreateToggle(v32, "Auto Hop When Admin Joined", "HopWhenAdmin", true, { callback = tbl19.ToggleHopAdmin })
			tbl16:CreateToggle(v32, "Anti Afk", "AntiAFK", true, { callback = tbl19.ToggleAntiAFK })

			if tbl19.RemoveEffects then
				v32:addButton("Remove Effects", tbl19.RemoveEffects)
			end

			local v33 = v31:addMenu("Farm Settings")
			tbl16:CreateDropdown(v33, "Select Skills", "SelectSkills", "Blox Fruit", { "Blox Fruit", "Melee", "Sword", "Gun" }, { global = true }, true)
			tbl16:CreateDropdown(v33, "Blox Fruit Skills", "BloxFruitKeys", "Z", { "Z", "X", "C", "V", "F" }, { global = true }, true)
			tbl16:CreateDropdown(v33, "Melee Skills", "MeleeKeys", "Z", { "Z", "X", "C" }, { global = true }, true)
			tbl16:CreateDropdown(v33, "Sword Skills", "SwordKeys", "Z", { "Z", "X" }, { global = true }, true)
			tbl16:CreateDropdown(v33, "Gun Skills", "GunKeys", "Z", { "Z", "X" }, { global = true }, true)
			tbl16:CreateToggle(v33, "Auto Use Skills", "AutoSkills", false, { global = true, save = true })
			local v34 = v31:addMenu("Skills Settings")
			tbl16:CreateSlider(v34, "Z Hold Time (ms)", "HoldTime_Z", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "X Hold Time (ms)", "HoldTime_X", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "C Hold Time (ms)", "HoldTime_C", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "V Hold Time (ms)", "HoldTime_V", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "F Hold Time (ms)", "HoldTime_F", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "Blox Fruit Skill Delay (ms)", "BloxFruitDelay", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "Melee Skill Delay (ms)", "MeleeDelay", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "Sword Skill Delay (ms)", "SwordDelay", 0, 5, 0, { global = true, save = true, step = 0.1 })
			tbl16:CreateSlider(v34, "Gun Skill Delay (ms)", "GunDelay", 0, 5, 0, { global = true, save = true, step = 0.1 })
		end)

		fn50("Sub Farm", function()
			task.wait()
			local v25 = tbl15.Sub:addSection()
			local v26 = v25:addMenu("World Farm")
			tbl16:CreateToggle(v26, "Auto Second Sea Quest", "AutoSecondSea", false, { global = true, stop = true })
			tbl16:CreateToggle(v26, "Auto Third Sea Quest", "AutoThirdSea", false, { global = true, stop = true })
			local v27 = v25:addMenu("Quest Farm")
			tbl16:CreateToggle(v27, "Complete Saber Quest", "AutoUnlockSaber", false, { global = true, stop = true })
			tbl16:CreateToggle(v27, "Complete Bartilo Quest", "AutoBartiloQuest", false, { global = true, stop = true })
			tbl16:CreateToggle(v27, "Complete Citizen Quest", "CompleteCitizenQuest", false, { global = true, stop = true })
			tbl16:CreateToggle(v27, "Complete Rainbow Haki Quest", "GetRainbowHaki", false, { global = true, stop = true })
			local v28 = v25:addMenu("Items Farm")
			tbl16:CreateToggle(v28, "Auto Get Yama (Fully)", "AutoYama", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Get Tushita (Fully)", "AutoTushita", false, { global = true, save = true, stop = true })

			tbl16:CreateToggle(v28, "Auto Get CDK (Fully)", "AutoCDKQuest", false, {
				global = true,
				locked = false,
				stop = true,
				save = true,
				description = "don't turn on remove fog while using this function",
			})

			tbl16:CreateToggle(v28, "Auto Get Rengoku (Fully)", "AutoRengoku", false, { global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Get TTK (Fully)", "AutoTTK", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Evolve DarkBlade (V2)", "AutoGetDBV2", false, { locked = false, global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Shark Anchor (Fully)", "AutoSharkAnchor", false, { locked = false, global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Get Skull Guitar (Fully)", "AutoGetSkullGuitar", false, { global = true, locked = false, save = true, stop = true })
			tbl16:CreateToggle(v28, "Ignore Material Farm for Skull Guitar", "IgnoreMaterialFarmGuitar", false, { global = true, locked = false, stop = true })
			local v29 = v25:addMenu("Sword Mastery")
			tbl16:CreateSlider(v29, "Select Sword Mastery", "SelectSwordMastery", 100, 600, 600, { locked = false, global = true })
			tbl16:CreateToggle(v29, "Auto Mastery Swords (Fully)", "AutoMasterySwords", false, { global = true, save = true })
			local v30 = v25:addMenu("Fight Style Obtainment")
			tbl16:CreateToggle(v30, "Auto Death Step", "AutoDeathStep", false, { global = true, stop = true })
			tbl16:CreateToggle(v30, "Auto Sharkman Karate", "AutoSharkmanKarate", false, { global = true, stop = true })
			tbl16:CreateToggle(v30, "Auto Electric Claw", "AutoElectricClaw", false, { global = true, stop = true })
			tbl16:CreateToggle(v30, "Auto Dragon Talon", "AutoDragonTalon", false, { global = true, stop = true })
			local v31 = tbl15.Sub:addSection()
			local v32 = v31:addMenu("Timely Farm")
			tbl16:CreateToggle(v32, "Auto Elite Hunter", "AutoTaskEliteHunter", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v32, "Auto Factory Raid", "AutoFactoryRaid", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v32, "Auto Pirate Raid", "AutoFarmPirateRaid", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v32, "Auto Soul Reaper", "AutoSoulReaper", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v32, "Auto Darkbeard", "AutoDarkbeard", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v32, "Auto Greybeard", "AutoGreybeard", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v32, "Auto Cursed Captain", "AutoCursedCaptain", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v32, "Auto Open Colors Plate", "AutoOpenColorsTask", false, { global = true, save = false, stop = true })
			tbl16:CreateToggle(v32, "Auto True Form Rip Indra", "AutoRipIndra", false, { global = true, save = true, stop = true })
			local v33 = v31:addMenu("Other Farm")
			tbl16:CreateToggle(v33, "Start Farm Observation", "AutoFarmObservation", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v33, "Auto Get Observation V2", "AutoKenV2", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v33, "Farm Observation Hopping", "StartObsHop", false, { global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Dummy Training", "DummyTraining", false, { global = true, save = true, stop = true })
		end)

		fn50("Sea Event", function()
			task.wait()
			local v25 = tbl15.Sevent:addSection()
			local v26 = v25:addMenu("Mirage Event")
			tbl16:CreateToggle(v26, "Auto Find Mirage Island", "AutoFindMirageIsland", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v26, "Teleport to Mirage", "AutoTeleportMirage", false, { global = true, save = true, stop = true })
			local v27 = v25:addMenu("Kitsune Event")
			tbl16:CreateToggle(v27, "Auto Find Kitsune Island", "AutoFindKitsuneIsland", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v27, "Teleport to Shrine", "AutoTeleportKitsune", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v27, "Auto Collect Azure Embers", "CollectAzure", false, { global = true, save = true, stop = true })
			mods._BlueMoonState = "FIND_ISLAND"
			tbl16:CreateToggle(v27, "Auto Kitsune Farm", "AutoBlueMoonFarm", false, { global = true, lock = true, save = true, stop = true })
			tbl16:CreateSlider(v27, "Set Azure Ember", "SetAzureEmber", 1, 25, 1, { global = true })
			tbl16:CreateToggle(v27, "Auto Trade Azure Ember", "TradeAzureEmber", false, { global = true, save = true })
			local v28 = v25:addMenu("Leviathan Hunt")

			v28:addButton("Bribe", tbl19.BribeLeviathan or function()
			end)

			mods._FindLeviathan = tbl16:CreateToggle(v28, "Auto Find Leviathan", "AutoFindLeviatan", false, { locked = false, global = true, stop = true })

			tbl16:CreateToggle(v28, "Ignore Sea Events While Finding", "AutoIgnoreSeaEventsLeviathan", false, {
				global = true,
				save = true,
				description = "Ignores sea beasts, sharks, and ships so boat sails uninterrupted to Leviathan",
			})

			tbl16:CreateToggle(v28, "Auto Kill Leviathan", "AutoKillLeviathan", false, { locked = false, global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Sail back to Tiki", "AutoSailbacktoTiki", false, { locked = false, global = true, stop = true })
			local v29 = tbl15.Sevent:addSection()
			local v30 = v29:addMenu("Sea Farm")
			tbl16:CreateDropdown(v30, "Select Boat", "BoatSelected", "PirateBrigade", tbl17.BoatsList or {}, { global = true, save = true })
			tbl16:CreateDropdown(v30, "Select Zone", "SeaLevelSelected", 6, tbl17.ZoneList or {}, { global = true })
			tbl16:CreateSlider(v30, "Boat Height", "BoatPosY", 0, 150, 31, { locked = false, global = true })
			tbl16:CreateSlider(v30, "Boat Speed", "SpeedBoat", 10, 250, 230, { global = true })
			tbl16:CreateDropdown(v30, "Sea Event Targets", "SeaEventTargets", 1, tbl17.SeaEventTargets or {}, { global = true }, true)
			local getAllBoats = tbl19.GetAllBoats and tbl19.GetAllBoats() or { "My Boat" }
			local v31 = tbl16:CreateDropdown(v30, "Select Owned Boat", "SailTargetBoat", "My Boat", getAllBoats, { global = true })

			v30:addButton("Refresh Boats", function()
				if tbl19.GetAllBoats then
					getAllBoats = tbl19.GetAllBoats()
					v31:Refresh(getAllBoats)
				end
			end)

			tbl16:CreateToggle(v30, "ESP My Boat", "ESPMyBoat", false, {
				global = true,
				callback = function(espMyBoat)
					config.ESPMyBoat = espMyBoat

					if not espMyBoat then
						if ClearESP then
							ClearESP("MyBoat")
						end
					elseif MyBoatESP then
						MyBoatESP()
					end
				end,
			})

			tbl16:CreateToggle(v30, "Auto Drive", "AutoSail", false, { global = true, stop = true })

			v30:addButton("Buy New Boat", tbl19.BuyNewBoat or function()
			end)

			tbl16:CreateToggle(v30, "Auto Farm Sea Events", "AutoFarmSeaEvents", false, { global = true, description = "don't turn off Auto Drive when farming sea events, it's connected" })

			tbl16:CreateToggle(v30, "Protect Boat (Float in Combat)", "ProtectBoat", true, {
				global = true,
				save = true,
				description = "Floats your boat high in the air when fighting sea events to prevent damage",
			})

			tbl16:CreateToggle(v30, "Auto Buy New Boat When dies", "AutoBuyNewBoatWhendies", false, { global = true })
			tbl16:CreateToggle(v30, "Auto Reset Charater if boat destroyed", "ResetPlayerdestroyboat", false, { global = true })
			tbl16:CreateToggle(v30, "Auto Dodge Terror Shark", "DodgeTerror", true, { global = true, save = true })
			tbl16:CreateToggle(v30, "Auto Dodge Seabeast", "DodgefSeabeast", true, { global = true, save = true })
			tbl16:CreateToggle(v30, "Use M1 DragonStorm for Seabeast/ships", "UseDragonSforSeabeasts", false, { global = true })
			tbl16:CreateSlider(v30, "Manual Speed", "ManualBoatSpeed", 20, 250, 150, { global = true, save = true })
			tbl16:CreateToggle(v30, "Manual Increase Boat Speed", "ManualIncreaseBoatSpeed", false, { global = true, save = true })
			local Fishing = v29:addMenu("Fishing")
			tbl16:CreateDropdown(Fishing, "Fishing Rods", "SelectedRod", 1, tbl17.RodsList or {}, { global = true })
			tbl16:CreateDropdown(Fishing, "Baits", "SelectedBait", 1, tbl17.BaitsList or {}, { global = true })

			Fishing:addButton("Open Fish Index", tbl19.OpenFishIndex or function()
			end)

			tbl16:CreateToggle(Fishing, "Auto Fishing", "Auto_Fishing", false, { global = true })
			tbl16:CreateToggle(Fishing, "Auto Catch Chest", "AutoGetChest", false, { global = true })
			tbl16:CreateToggle(Fishing, "Auto Craft Bait", "AutoCraftBait", false, { global = true })
			tbl16:CreateToggle(Fishing, "Auto Get / Complete Angler Quest", "AutoGetAnglerQuest", false, { global = true, save = true })
			tbl16:CreateToggle(Fishing, "Auto Sell Fish", "AutoSellFish", false, { global = true })
			tbl16:CreateToggle(Fishing, "Auto Use Rod Skill", "AutoUseRodSkill", false, { global = true })
			tbl16:CreateToggle(v29:addMenu("FishSlap Minigame"), "Auto Fish Slap", "AutoSlap", false, { global = true })
		end)

		fn50("Player", function()
			task.wait()
			local v25 = tbl15.Player:addSection():addMenu("Player Stats")
			local v26 = v25:addLabel("Player Status", "Scanning for Information...")

			task.spawn(function()
				while task.wait(0.5) do
					if tbl19.GetStatsInfo then
						v26:RefreshDesc(tbl19.GetStatsInfo())
					end
				end
			end)

			tbl16:CreateSlider(v25, "Select Points", "PointsSlider", 0, 1000, 10, { global = true })
			tbl16:CreateToggle(v25, "Melee", "Melee", false, { global = true })
			tbl16:CreateToggle(v25, "Defense", "Defense", false, { global = true })
			tbl16:CreateToggle(v25, "Sword", "Sword", false, { global = true })
			tbl16:CreateToggle(v25, "Gun", "Gun", false, { global = true })
			tbl16:CreateToggle(v25, "Devil Fruit", "DemonFruit", false, { global = true })

			tbl16:CreateToggle(v25, "Start Adding Stats", "AutoStats", false, {
				global = true,
				callback = function(arg)
					if arg and tbl19.AutoStats then
						tbl19.AutoStats()
					end
				end,
			})

			local v27 = tbl15.Player:addSection()
			local v28 = v27:addMenu("ESP Menu")

			for _, v29 in next, {
				{ "Players ESP", "ESPPlayer", "Player", PlayerESP },
				{ "Islands ESP", "ESPIsland", "Island", IslandESP },
				{ "Fruits ESP", "DevilFruitESP", "Fruit", FruitESP },
				{ "Chests ESP", "ESPChest", "Chest", ChestESP },
				{ "Berries ESP", "ESP_Berries", "Berry", BerryESP },
				{ "Natural Fruits ESP (Pineapple, etc.)", "ESP_RealFruits", "RealFruit", RealFruitESP },
			}, nil do
				tbl16:CreateToggle(v28, v29[1], v29[2], false, { callback = function(arg)
					config[v29[2]] = arg

					if not arg then
						if ClearESP then
							ClearESP(v29[3])
						end
					elseif v29[4] then
						v29[4]()
					end
				end })
			end

			local v29 = v27:addMenu("PVP Menu")

			local function fn51()
				return tbl19.GetPlayerList and tbl19.GetPlayerList() or { "Nearest" }
			end

			local v30 = tbl16:CreateDropdown(v29, "Select Player", "SelectPlayer", 1, fn51(), { global = true })

			v29:addButton("Refresh Player List", function()
				if v30 and v30.Refresh then
					v30:Refresh(fn51())
				end
			end)

			tbl16:CreateToggle(v29, "Cam Lock", "CamLock", false, { global = true, callback = tbl19.OnCamLockToggle })
			tbl16:CreateToggle(v29, "Spectate Player", "SpectatePlayer", false, { global = true, callback = tbl19.OnSpectateToggle })
			tbl16:CreateToggle(v29, "Teleport to Player", "TeleporttoPlayer", false, { global = true, stop = true, callback = tbl19.OnTPPlayerToggle })
			tbl16:CreateToggle(v29, "Enable Aimbot ", "EnableAimbot", false, { global = true })

			v29:addButton("Get Player Quest", tbl19.GetPlayerHunterQuest or function()
			end)

			local v31 = v27:addMenu("Server Menu")
			local v32 = v31:addLabel("Server Status", "Loading...")
			mods._ServerInfo = v32

			v31:addButton("Refresh Server Info", function()
				pcall(function()
					if tbl19.StatusServer then
						v32:RefreshDesc(tbl19.StatusServer())
					end
				end)
			end)

			local v33 = v31:addLabel("Player Status", "Loading...")

			v31:addButton("Refresh Player Info", function()
				if tbl19.PlayerStatus then
					v33:RefreshDesc(tbl19.PlayerStatus())
				end
			end)

			local v34 = v31:addLabel("Fruit Stock", "Loading fruit stock...")

			v31:addButton("Refresh Fruit Stock", function()
				if tbl19.GetFruitStock then
					v34:RefreshDesc(tbl19.GetFruitStock())
				end
			end)

			task.spawn(function()
				task.wait(0.5)

				pcall(function()
					if tbl19.StatusServer and v32 then
						v32:RefreshDesc(tbl19.StatusServer())
					end
				end)
			end)
		end)

		fn50("Dragon Update", function()
			task.wait()
			local v25 = tbl15.Dragon:addSection()
			local v26 = v25:addMenu("Berry Farm")
			tbl16:CreateToggle(v26, "Auto Collect Berries", "AutoBerrySafe", false, { global = true, stop = true })
			tbl16:CreateToggle(v26, "Hop If No Berries", "HopIfNoBerries", false, { global = true, save = true })
			local v27 = v25:addMenu("Belt Obtainment")

			v27:addButton("Teleport to Dojo Trainer", tbl19.TPDojoTrainer or function()
			end)

			tbl16:CreateToggle(v27, "Auto White Belt", "AutoWhiteBelt", false, { global = true, stop = true })
			tbl16:CreateToggle(v27, "Auto Purple Belt", "AutoPurpleBelt", false, { global = true, stop = true })
			local v28 = tbl15.Dragon:addSection()
			local v29 = v28:addMenu("Prehistoric Event")
			mods._FindPrehistoricIsland = tbl16:CreateToggle(v29, "Auto Find Prehistoric Island", "AutoFindPrehistoricIsland", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v29, "Teleport to Prehistoric Island", "AutoTeleportPrehistoric", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v29, "Auto Complete Volcanic Event", "AutoVolcanicEvent", false, { global = true, stop = true })
			tbl16:CreateToggle(v29, "Use Skull Guitar for Volcano", "ShootGunVolcano", true, { global = true, save = true, description = "Uses Skull Guitar custom shoot to patch the volcano" })
			tbl16:CreateToggle(v29, "Auto Collect Bones", "AutoCollectBones", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v29, "Auto Collect Dragon Eggs", "AutoCollectEgg", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v29, "Auto Farm Blaze Ember", "AutoQuestBlaze", false, { global = true, save = true, stop = true })
			tbl16:CreateDropdown(v29, "Select Gun", "SelectGunBlaze", 1, { "Skull Guitar", "Bazooka" }, { global = true })
			tbl16:CreateToggle(v29, "Use Shoot Gun for tree quest", "ShootGunBlaze", false, { global = true, save = true })

			v29:addButton("Teleport to Dragon Hunter", tbl19.TPDragonHunter or function()
			end)

			v29:addButton("Teleport to Dragon Wizard", tbl19.TPDragonWizard or function()
			end)

			tbl16:CreateToggle(v29, "Auto Upgrade Dragon Talon", "AutoUpgradeDragonTalon", false, { callback = tbl19.ToggleUpgradeDragonTalon })

			v29:addButton("Craft Volcanic Magnet", function()
				tbl19.CraftPrehistoricItem("Volcanic Magnet")
			end)

			v29:addButton("Craft Dragonheart", function()
				tbl19.CraftPrehistoricItem("Dragonheart")
			end)

			v29:addButton("Craft Dragonstorm", function()
				tbl19.CraftPrehistoricItem("Dragonstorm")
			end)

			v29:addButton("Craft Dino Hood", function()
				tbl19.CraftPrehistoricItem("DinoHood")
			end)

			v29:addButton("Craft T-Rex Skull", function()
				tbl19.CraftPrehistoricItem("TRexSkull")
			end)

			local v30 = v28:addMenu("Draco Race")
			mods._AutoTrialDracoToggle = tbl16:CreateToggle(v30, "Teleport to Draco Trial", "AutoTrialDracoTP", false, { global = true, stop = true })

			v30:addButton("Change to Draco Race", tbl19.ChangeDracoRace or function()
			end)

			tbl16:CreateToggle(v30, "Auto Draco Race V2 ", "AutoCollectFireFlowers", false, { global = true, stop = true })
			tbl16:CreateToggle(v30, "Auto Complete Draco Trial", "AutoCompleteDracoTrial", false, { locked = false, global = true, stop = true })
		end)

		fn50("Dungeon", function()
			task.wait()
			local v25 = tbl15.Raid:addSection()
			local v26 = v25:addMenu("Raid Menu")
			tbl16:CreateDropdown(v26, "Raid Chip", "SelectRaid", 1, tbl17.Raids_Chip or {}, { global = true })
			tbl16:CreateToggle(v26, "Auto Buy Chip", "AutoBuyChip", false, { global = true, save = true })
			mods._AutoRaidToggle = tbl16:CreateToggle(v26, "Auto Complete Raid", "AutoRaidFull", false, { global = true, stop = true })
			tbl16:CreateToggle(v26, "Instant Kill Islands 4-5 ", "InstantKillLateIslands", false, { locked = false, global = true })
			tbl16:CreateToggle(v26, "Auto Unstore Below 1m Fruit", "AutoUnstoreBelowFruit", false, { global = true, save = true, description = "this will ignore fruit skins" })
			tbl16:CreateToggle(v26, "Auto Awaken", "AutoAwaken", false, { global = true, save = true })
			tbl16:CreateSlider(v26, "Frags Cap", "FragsCap", 1000, 1000000, 1000, { global = true })
			tbl16:CreateToggle(v26, "Auto stop raid when fragments reach cap", "Autostopraid", false, { global = true, save = true })
			local v27 = v25:addMenu("Dungeon Menu")

			tbl16:CreateToggle(v27, "Auto Unlock Difficulties", "AutoUnlockDifficulties", false, {
				global = true,
				save = true,
				description = "Automatically unlocks Hard and Challenge difficulties using Simulation Data",
			})

			tbl16:CreateToggle(v27, "Auto Complete Dungeon", "AutoDungeonFull", false, { global = true, stop = true })
			tbl16:CreateToggle(v27, "Auto Destroy Shrines and Vents", "AutoDungeonShrine", false, { global = true, stop = true })
			tbl16:CreateDropdown(v27, "Select Cards", "CardsSelection", 1, tbl17.DungeonCards or {}, { global = true }, true)
			tbl16:CreateToggle(v27, "Auto Select Cards", "AutoCardsDungeon", false, { global = true })

			v27:addButton("Unlock Next Difficulty", tbl19.UnlockDungeonDifficulty or function()
			end)

			v27:addButton("Teleport to Dungeon Map", tbl19.TPDungeonHub or function()
			end)

			v27:addButton("Return to Previous Sea", tbl19.TPDungeonBack or function()
			end)

			tbl16:CreateToggle(v25:addMenu("Law Menu"), "Start Law Raid Farm", "AutoLawRaid", false, { global = true, stop = true, save = true })
			local v28 = tbl15.Raid:addSection()
			local v29 = v28:addMenu("Fruit Menu")

			v29:addButton("Open Normal Shop", tbl19.OpenNormalFruitShop or function()
			end)

			v29:addButton("Open Advanced Shop", tbl19.OpenAdvFruitShop or function()
			end)

			tbl16:CreateToggle(v29, "Auto Roll Fruit", "Random_Auto", false, { global = true, save = true })
			tbl16:CreateToggle(v29, "Auto Store Fruit", "AutoStoreFruit", false, { global = true, save = true })
			local v30 = v29:addLabel("Fruit Spawn Status", "Scanning for fruit...")

			task.spawn(function()
				while task.wait(1.5) do
					if tbl19.GetFruitSpawnStatus then
						v30:RefreshDesc(tbl19.GetFruitSpawnStatus())
					end
				end
			end)

			tbl16:CreateToggle(v29, "Teleport to Fruit", "Tweenfruit", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v29, "Hop If No Fruit In Server", "HopIfNoFruit", false, { global = true, save = true })
			tbl16:CreateToggle(v29, "Fruit Notification", "FruitCheck", false, { global = true, save = true })

			v29:addButton("Teleport To Advanced Fruit Dealer", tbl19.TPAdvFruitDealer or function()
			end)

			local v31 = v28:addMenu("Trinkets & Refiner")

			v31:addButton("Buy Trinket", tbl19.BuyTrinket or function()
			end)

			tbl16:CreateToggle(v31, "Auto Buy Trinkets", "AutoBuyTrinkets", false, {
				global = true,
				save = true,
				description = "Automatically buys trinkets when fragments/currency available",
			})

			v31:addButton("Fuse / Merge 3 Trinkets", tbl19.FuseTrinkets or function()
			end)

			tbl16:CreateToggle(v31, "Auto Fuse / Merge Trinkets", "AutoFuseTrinkets", false, {
				global = true,
				save = true,
				description = "Automatically merges 3 matching trinkets to upgrade grade",
			})

			v31:addButton("Reforge / Refine Trinket", tbl19.RefineTrinket or function()
			end)

			tbl16:CreateToggle(v31, "Auto Refine Trinket", "AutoRefineTrinkets", false, { global = true, save = true, description = "Automatically rerolls/refines trinket stats" })

			v31:addButton("Open Trinket Merge GUI", tbl19.OpenTrinketMergeGUI or function()
			end)

			v31:addButton("Open Trinket Refiner GUI", tbl19.OpenTrinketRefineGUI or function()
			end)

			v31:addButton("Open Trinket Scrap / Trash GUI", tbl19.OpenTrinketScrapGUI or function()
			end)

			tbl16:CreateToggle(v31, "Auto Scrap Junk Trinkets", "AutoScrapTrinkets", false, {
				global = true,
				save = true,
				description = "Automatically scraps surplus trinkets for simulation data",
			})
		end)

		fn50("Trials", function()
			task.wait()
			local v25 = tbl15.Trial:addSection()
			local Trials = v25:addMenu("Trials")

			if tbl19.InitTempleOfTime then
				tbl19.InitTempleOfTime()
			end

			Trials:addButton("Go to Race Door", tbl19.TPRaceDoor or function()
			end)

			tbl16:CreateToggle(Trials, "Auto (Activate) Race", "AutoActiveRacenear", false, {
				global = true,
				description = "instantly activates the race the moment 2+ accounts are ready there",
			})

			tbl16:CreateToggle(Trials, "Auto Complete Trials", "AutoFinishTrial", false, { global = true, stop = true })
			tbl16:CreateToggle(Trials, "Kill Players after Trial", "AutoKillPlayerinTrial", false, { global = true, stop = true })

			Trials:addButton("Reset Character", tbl19.ResetCharHead or function()
			end)

			tbl16:CreateToggle(Trials, "Auto Choose Gear", "AutoChooseGear", false, {
				global = true,
				stop = true,
				description = "Automatically selects and places your gear in the Ancient Clock upon winning the trial",
			})

			tbl16:CreateDropdown(Trials, "Train Method", "TrainMethod", "Bones", tbl17.TrainMethods or { "Bones", "Cakes" }, { global = true })
			tbl16:CreateToggle(Trials, "Start Auto Train", "AutoTrainGear", false, { global = true, stop = true })
			tbl16:CreateToggle(Trials, "Auto Pull Lever (Fully)", "AutoFullyPullLever", false, { locked = false, global = true, save = true, stop = true })
			tbl16:CreateToggle(Trials, "Teleport To Blue Gear", "TweenMGear", false, { global = true })
			local Area = v25:addMenu("Area")

			Area:addButton("Teleport to Top of Great Tree", function()
				tbl19.TPTrialArea("GreatTree")
			end)

			Area:addButton("Teleport to Temple of Time", function()
				tbl19.TPTrialArea("TempleOfTime")
			end)

			Area:addButton("Teleport to Ancient One", function()
				tbl19.TPTrialArea("AncientOne")
			end)

			Area:addButton("Teleport to Lever Pull", function()
				tbl19.TPTrialArea("LeverPull")
			end)

			Area:addButton("Teleport to Safe Zone", function()
				tbl19.TPTrialArea("SafeZone")
			end)

			Area:addButton("Teleport back to Pvp Zone", function()
				tbl19.TPTrialArea("PvpZone")
			end)

			Area:addButton("Teleport to Clock", function()
				tbl19.TPTrialArea("Clock")
			end)

			local v26 = tbl15.Trial:addSection()
			local v27 = v26:addMenu("Misc Trial")
			tbl16:CreateToggle(v27, "Auto Upgrade Gear", "BuyGear", false, { global = true })
			tbl16:CreateToggle(v27, "Auto Activate V3", "AutoAgility", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Auto Activate V4", "AutoActiveRaceV4", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Auto Look Moon", "AutoLookMoon", false, { global = true })
			local Upgrades = v26:addMenu("Upgrades")
			tbl16:CreateToggle(Upgrades, "Auto Race Evolve V2", "AutoStartRaceV2", false, { global = true, stop = true })
			tbl16:CreateToggle(Upgrades, "Auto Race Evolve V3", "AutoStartRaceV3", false, { global = true, stop = true })
			local v28 = v26:addMenu("Race Obtainment")
			tbl16:CreateToggle(v28, "Auto Get Ghoul Race [Fully]", "AutoGetGhoulRace", false, { global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Get Cyborg Race [Fully]", "AutoGetCyborgRace", false, { global = true, stop = true })
		end)

		fn50("Travel", function()
			task.wait()
			local v25 = tbl15.Travel:addSection()
			local v26 = v25:addMenu("World Travel")

			v26:addButton("Teleport to World 1", function()
				mods:FireInvoke("TravelMain")
			end)

			v26:addButton("Teleport to World 2", function()
				mods:FireInvoke("TravelDressrosa")
			end)

			v26:addButton("Teleport to World 3", function()
				mods:FireInvoke("TravelZou")
			end)

			local v27 = v25:addMenu("Island Travel")
			mods._ActiveIslands = tbl17.ActiveIslands or {}
			tbl16:CreateDropdown(v27, "Select Island", "TeleportIslandSelect", "walang kayo sorry", tbl17.IslandsList or {}, { global = true })
			mods._TravelToggle = tbl16:CreateToggle(v27, "Start Traveling", "TeleportToIsland", false, { global = true, stop = true })
			local v28 = v25:addMenu("NPC Travel")
			tbl16:CreateDropdown(v28, "Select Npc", "NpcTween", 1, tbl17.NPCList or {}, { global = true })
			tbl16:CreateToggle(v28, "Start Traveling", "TPtoNPC", false, { global = true, stop = true })
			local v29 = tbl15.Travel:addSection()
			local v30 = v29:addMenu("Server Travel")
			tbl16:CreateTextbox(v30, "JobID [" .. game.PlaceId .. "]", "JobID", { save = false, callback = tbl19.TeleportJobID })
			tbl16:CreateTextbox(v30, "Quantum Premium [" .. game.PlaceId .. "]", "QuantumPremium", { save = false, callback = tbl19.TeleportQuantumPremium })

			v30:addButton("Copy Current Job ID", function()
				setclipboard(tostring(game.JobId))
			end)

			local v31 = v29:addMenu("Misc Travel")

			v31:addButton("Rejoin Server", tbl19.RejoinServer or function()
			end)

			v31:addButton("Server Hop, Random Server", tbl19.ServerHop or function()
			end)

			local v32 = v29:addMenu("Quantum Joiner")

			v32:addButton("Join Full Moon Server", function()
				tbl19.JoinAPI("FullMoon")
			end)

			v32:addButton("Join Near Full Moon Server", function()
				tbl19.JoinAPI("NearFullMoon")
			end)

			v32:addButton("Join Mirage Island Server", function()
				tbl19.JoinAPI("mirage")
			end)

			v32:addButton("Join Elite Hunter Server", function()
				tbl19.JoinAPI("elites")
			end)

			v32:addButton("Join Kitsune Island Server", function()
				tbl19.JoinAPI("kitsune")
			end)

			v32:addButton("Join Prehistoric Island Server", function()
				tbl19.JoinAPI("prehistoric")
			end)

			v32:addButton("Join Factory Raid Server", function()
				tbl19.JoinAPI("factory")
			end)

			v32:addButton("Join 4 Hours Server", function()
				tbl19.JoinAPI("fourhours")
			end)

			v32:addButton("Join Castle Raid Server", function()
				tbl19.JoinAPI("pirate")
			end)

			tbl16:CreateDropdown(v32, "Select Legendary Sword", "SelectLegendarySword", 1, tbl17.LegendarySwordNames or { "Shizu", "Oroshi", "Saishi" }, { global = true })

			v32:addButton("Join Legendary Sword Server", function()
				tbl19.JoinAPI("legendarysword")
			end)

			v32:addButton("Join Fruit Server", function()
				tbl19.JoinAPI("fruit")
			end)

			tbl16:CreateDropdown(v32, "Select Boss", "SelectBosstoHop", 1, tbl17.BossHopNames or {}, { global = true })

			v32:addButton("Join Raid Boss Server", tbl19.JoinRaidBossServer or function()
			end)

			local v33 = v29:addMenu("AFK Quantum Joiner")
			tbl16:CreateSlider(v33, "Hop Delay (s)", "HopDelay", 1, 60, 10, { global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Castle Raid", "AutoAfkJoinCastleRaid", false, { locked = false, save = true, global = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Factory Raid", "AutoAfkJoinFactoryRaid", false, { locked = false, global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Boss Raid", "AutoAfkJoinBossRaid", false, { locked = false, global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Elite Hunter", "AutoAfkJoinEliteHunter", false, { locked = false, global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Fruit", "AutoAfkJoinFruit", false, { locked = false, global = true, save = true })
			tbl16:CreateToggle(v33, "Stop Hop If Chalice / Fist", "StopHopEliteIfChalice", true, { global = true, save = true })
		end)

		fn50("Shop", function()
			task.wait()
			local v25 = tbl15.Shop:addSection()
			local v26 = v25:addMenu("Selection Shop")
			tbl16:CreateDropdown(v26, "Select Melee", "SelectMelee", 1, tbl17.MeleeNames or {}, { global = true })
			tbl16:CreateToggle(v26, "Auto Buy Melee", "AutoBuyMelee", false, { global = true, stop = true })
			tbl16:CreateDropdown(v26, "Abilities", "BuyAbility", "Geppo", tbl17.AbilityNames or {}, { global = true })

			v26:addButton("Buy Ability", function()
				if config.BuyAbility and tbl19.BuyItem then
					tbl19.BuyItem(config.BuyAbility, "Ability")
				end
			end)

			tbl16:CreateDropdown(v26, "Gun list", "GunSelect", "Slingshot", tbl17.GunNames or {}, { global = true })

			v26:addButton("Buy Gun", function()
				if config.GunSelect and tbl19.BuyItem then
					tbl19.BuyItem(config.GunSelect, "Gun")
				end
			end)

			tbl16:CreateDropdown(v26, "Accessories", "BuyAccessories", 1, tbl17.AccessoryNames or {}, { global = true })

			v26:addButton("Buy Accessory", function()
				if config.BuyAccessories and tbl19.BuyItem then
					tbl19.BuyItem(config.BuyAccessories, "Accessory")
				end
			end)

			local v27 = v25:addMenu("Item Shop")
			tbl16:CreateToggle(v27, "Buy Haki Color", "AutoBuyEnchancementColor", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Buy Legendary Sword", "BuyLegendSword", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Buy True Triple Katana", "BuyTTK", false, { global = true, save = true })
			local v28 = tbl15.Shop:addSection()
			local v29 = v28:addMenu("Normal Fruit Dealer")
			tbl16:CreateDropdown(v29, "Select Fruit to Buy", "SelectFruitDealerFruit", "Buddha-Buddha", tbl17.DealerFruitList or {}, { global = true, save = true })
			tbl16:CreateToggle(v29, "Auto Buy Fruit (Normal Dealer)", "AutoBuyFruitDealer", false, { global = true, save = true })

			v29:addButton("Buy Selected Fruit", tbl19.BuySelectedFruit or function()
			end)

			local v30 = v28:addMenu("Race Shop")

			v30:addButton("Cyborg Race", tbl19.BuyCyborgRace or function()
			end)

			v30:addButton("Ghoul Race", tbl19.BuyGhoulRace or function()
			end)

			local v31 = v28:addMenu("Fragment Shop")

			v31:addButton("Reroll Race", function()
				if tbl19.BuyItem then
					tbl19.BuyItem("Race Rerol", "Frags")
				end
			end)

			v31:addButton("Reset Player Stats", function()
				if tbl19.BuyItem then
					tbl19.BuyItem("Reset Stats", "Frags")
				end
			end)

			local v32 = v28:addMenu("Scroll Crafting & Trade")
			tbl16:CreateDropdown(v32, "Select Scroll", "SelectScrollType", "Common Scroll", { "Common Scroll", "Rare Scroll", "Legendary Scroll", "Mythical Scroll" }, { global = true, save = true })
			tbl16:CreateSlider(v32, "Craft Amount", "ScrollCraftAmount", 1, 10, 1, { global = true })

			v32:addButton("Craft Selected Scroll", tbl19.CraftScroll or function()
			end)

			tbl16:CreateToggle(v32, "Auto Craft Selected Scroll", "AutoCraftScrolls", false, {
				global = true,
				save = true,
				description = "Automatically crafts scrolls when you have sufficient materials",
			})
		end)

		fn50("Misc", function()
			task.wait()
			local v25 = tbl15.Misc:addSection()
			local v26 = v25:addMenu("Team Selection")

			v26:addButton("Join Marines Team", function()
				mods:FireInvoke("SetTeam", "Marines")
			end)

			v26:addButton("Join Pirates Team", function()
				mods:FireInvoke("SetTeam", "Pirates")
			end)

			local v27 = v25:addMenu("Menu Openings")

			v27:addButton("Open Title Names", tbl19.OpenTitleNames or function()
			end)

			v27:addButton("Open Awakenings", tbl19.OpenAwakenings or function()
			end)

			v25:addMenu("Fake Admin"):addButtonGrid("Admin Panel", tbl17.AdminPanelGrid or {})
			local v28 = tbl15.Misc:addSection():addMenu("Players Clients")
			tbl16:CreateToggle(v28, "Remove Observation Effect", "RemoveObservationEffect", false, { global = true, save = true })
			tbl16:CreateSlider(v28, "Walk Speed", "WalkSpeed", 50, 500, 50, { callback = tbl19.SetWalkSpeed })
			tbl16:CreateSlider(v28, "Jump Power", "JumpPower", 50, 500, 50, { callback = tbl19.SetJumpPower })
			tbl16:CreateToggle(v28, "X-ray Vision", "XrayVision", false, { callback = tbl19.ToggleXray })
			tbl16:CreateToggle(v28, "Infinite Zoom", "InfiniteZoom", false, { callback = tbl19.ToggleInfiniteZoom })
			tbl16:CreateToggle(v28, "White Screen", "White_Screen", false, { callback = tbl19.ToggleWhiteScreen })
			tbl16:CreateToggle(v28, "Black Screen", "BlackScreen", false, { callback = tbl19.ToggleBlackScreen })

			v28:addButton("Redeem all Codes", tbl19.RedeemAllCodes or function()
			end)

			tbl16:CreateToggle(v28, "Remove Fog", "NoFog", false, { global = true, save = true })

			v28:addButton("Force FPS BOOST", tbl19.ForceFPSBoost or function()
			end)

			v28:addButton("Developer Console", tbl19.OpenDevConsole or function()
			end)

			v28:addButton("Clean Memory / Free RAM (GC)", tbl19.CleanMemory or function()
			end)

			tbl16:CreateToggle(v28, "Auto Memory Cleaner (60s)", "AutoCleanMemory", true, { global = true, save = true })

			tbl16:CreateToggle(v28, "Auto Turn On Fast Mode", "AutoFastMode", false, {
				global = true,
				save = true,
				description = "Automatically enables the game's built-in Fast Mode setting to maximize FPS",
				callback = tbl19.OnFastModeToggle,
			})
		end)

		fn50("Webhook", function()
			task.wait()
			local v25 = tbl15.Web:addSection()
			local v26 = v25:addMenu("General Webhook")
			tbl16:CreateTextbox(v26, "Main Webhook Url", "Webhook", { save = true, global = true })
			tbl16:CreateToggle(v26, "Enable Send Webhook", "AutoWebhook", false, { global = true, save = true })

			v26:addButton("Send Test Webhook", tbl19.SendTestWebhook or function()
			end)

			local v27 = v25:addMenu("World & Fruit Events")
			tbl16:CreateToggle(v27, "Send Webhook Prehistoric", "SendWebhookPrehistoric", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Send Webhook Kitsune", "SendWebhookKitsune", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Send Webhook Mirage", "SendWebhookMirage", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Send Webhook Rolled Fruit", "SendWebhookRolledFruit", false, { global = true, save = true })
			tbl16:CreateToggle(v27, "Send Webhook Store Fruit", "SendWebhookStoreFruit", false, { global = true, save = true })
			local v28 = tbl15.Web:addSection()
			local v29 = v28:addMenu("Data Log & Farm Tracker")
			tbl16:CreateToggle(v29, "Enable Data Log Webhook", "SendWebhookDataLog", false, { global = true, save = true })
			tbl16:CreateTextbox(v29, "DataLog Webhook URL (Optional)", "DataLogWebhookUrl", { save = true, global = true })
			tbl16:CreateSlider(v29, "Data Log Interval (Minutes)", "DataLogInterval", 1, 60, 5, { global = true, save = true })
			tbl16:CreateToggle(v29, "Send on Level Up", "SendWebhookLevelUp", false, { global = true, save = true })
			tbl16:CreateToggle(v29, "Include Inventory in Data Log", "SendWebhookInventory", true, { global = true, save = true })
			tbl16:CreateToggle(v29, "Include Farms All Summary", "SendWebhookFarmsAll", true, { global = true, save = true })

			v29:addButton("Send Data Log Now", tbl19.SendDataLogNow or function()
			end)

			local v30 = v28:addMenu("Webhook Ping & Settings")
			tbl16:CreateTextbox(v30, "Discord User ID (For Ping)", "WebhookPingId", { save = true, global = true })
			tbl16:CreateToggle(v30, "Ping on Mirage / Kitsune", "WebhookPingOnEvents", false, { global = true, save = true })
			tbl16:CreateToggle(v30, "Ping on Mythical Fruit", "WebhookPingOnMythical", false, { global = true, save = true })
		end)
	end

	mods.LoadLoops = function()
		mods.Loops = mods.Loops or {}
		local tbl15 = {}

		local function fn27(arg, arg2, arg3, arg4)
			if not arg or type(arg3) ~= "function" then
				return
			end

			if tbl15[arg] then
				tbl15[arg].Active = false

				if tbl15[arg].Thread then
					task.cancel(tbl15[arg].Thread)
					tbl15[arg].Thread = nil
				end
			end

			local tbl16 = {
				Name = arg,
				Interval = arg2 or 0,
				Func = arg3,
				NoCheck = arg4 or false,
				Running = false,
				Active = true,
				Stop = function()
					if config then
						config[arg] = false
					end

					if mods.Loops[arg] then
						mods.Loops[arg].Running = false
					end
				end,
			}

			mods.Loops[arg] = tbl16
			tbl15[arg] = tbl16

			tbl16.Thread = task.spawn(function()
				local n2 = arg2 and arg2 > 0 and arg2 or 0.03

				while tbl16.Active do
					if tbl16.NoCheck or config and config[arg] then
						tbl16.Running = true
						pcall(arg3)
						tbl16.Running = false
						task.wait(n2)
					else
						task.wait(0.5)
					end
				end
			end)
		end

		fn27("ESPPlayer", 0.5, PlayerESP)
		fn27("ESPIsland", 2, IslandESP)
		fn27("DevilFruitESP", 1, FruitESP)
		fn27("ESPChest", 1.5, ChestESP)
		fn27("ESP_Berries", 1.5, BerryESP)
		fn27("ESP_RealFruits", 1.5, RealFruitESP)
		fn27("ESPMyBoat", 1.5, MyBoatESP)

		fn27("AutoFastMode", 3, function()
			if not hub.Performance.FastMode then
				hub.Performance.SetFastMode(true)
			end
		end)

		local v22 = nil

		fn27("QuantumAttack", 0.5, function()
			if config.QuantumAttack then
				if not v22 then
					v22 = hookfunction(task.delay, function(arg, arg2, ...)
						if arg > 0.1 then
							return v22(0, arg2, ...)
						end
						return v22(arg, arg2, ...)
					end)

					require(RS.Util.CameraShaker):Stop()
				end
			elseif v22 then
				hookfunction(task.delay, v22)
				v22 = nil
			end
		end, true)

		local now = tick()
		local now2 = tick()
		local now3 = tick()
		local now4 = tick()
		local now5 = tick()
		local n2 = 0

		local function fn28(arg)
			local notifications = localPlayer.PlayerGui:FindFirstChild("Notifications")
			if not notifications then
				return false
			end

			for _, child in ipairs(notifications:GetChildren()) do
				for _, child2 in ipairs(child:GetChildren()) do
					if child2:IsA("TextLabel") and string.find(child2.Text, arg) then
						return true
					end
				end
			end

			return false
		end

		fn27("AutoAfkJoinBossRaid", 0.4, function()
			if tick() - now < 2.5 then
				now4 = tick()
			else
				local selectBosstoHop = config.SelectBosstoHop

				if type(selectBosstoHop) == "number" or not selectBosstoHop or selectBosstoHop == "" then
					selectBosstoHop = bossHopNames[selectBosstoHop] or bossHopNames[1] or "rip_indra True Form"
				end

				local str4 = tbl14[selectBosstoHop] or selectBosstoHop or "Ripindra"

				if selectBosstoHop and str4 then
					local connectMon = utilities:GetConnectMon(selectBosstoHop)
					local flag4 = not connectMon
					local flag5

					if flag4 then
						flag5 = selectBosstoHop == "rip_indra True Form" or selectBosstoHop == "Ripindra"
					else
						flag5 = flag4
					end

					if flag5 then
						connectMon = utilities:GetConnectMon("rip_indra") or utilities:GetConnectMon("rip_indra True Form")
					end

					if not connectMon then
						if tick() - now4 >= 3 then
							now4 = tick()
							joinAPI(str4, 0)
						end
					else
						now4 = tick()
					end
				end
			end
		end)

		fn27("AutoAfkJoinEliteHunter", 0.4, function()
			if not isSea3 then
				return
			end

			if tick() - now < 2.5 then
				now5 = tick()
			else
				local stopHopEliteIfChalice = config.StopHopEliteIfChalice
				local v23

				if stopHopEliteIfChalice then
					v23 = utilities:CheckToolName("God's Chalice") or utilities:CheckToolName("Sweet Chalice") or utilities:CheckToolName("Fist of Darkness")
				else
					v23 = stopHopEliteIfChalice
				end

				if v23 then
					config.AutoAfkJoinEliteHunter = false

					if mods and mods.Toggles and mods.Toggles.AutoAfkJoinEliteHunter and mods.Toggles.AutoAfkJoinEliteHunter.Update then
						pcall(function()
							mods.Toggles.AutoAfkJoinEliteHunter.Update(false)
						end)
					end

					if mods and mods.SendNotify then
						mods:SendNotify("Elite Hunter", "Chalice / Fist detected! Stopped auto elite hop.", 5)
					end
				else
					local v24 = gameData:Checkelites()

					if not v24 and tick() - n2 >= 1.5 then
						n2 = tick()

						pcall(function()
							mods:FireInvoke("EliteHunter")
						end)

						task.wait(0.2)
						v24 = gameData:Checkelites()
					end

					if v24 then
						now5 = tick()

						if not VerifyQuest(v24) then
							pcall(function()
								mods:FireInvoke("AbandonQuest")
							end)

							task.wait(0.1)

							pcall(function()
								mods:FireInvoke("EliteHunter")
							end)
						else
							local enemies2 = utilities:GetEnemies(v24)

							if enemies2 then
								subFunction:Attack(enemies2)
							end
						end
					elseif tick() - now5 >= 3 then
						now5 = tick()
						joinAPI("elites", 0)
					end
				end
			end
		end)

		fn27("AutoAfkJoinCastleRaid", 0.4, function()
			if not isSea3 then
				return
			end

			if tick() - now < 2.5 then
				now2 = tick()
			elseif gameData:DetectPirateRaid() then
				now2 = tick()
			elseif fn28("Good job!") or tick() - now2 >= 10 then
				joinAPI("pirate", 0)
				now2 = tick()
			end
		end)

		fn27("AutoAfkJoinFactoryRaid", 0.4, function()
			if not isSea2 then
				return
			end

			if tick() - now < 2.5 then
				now3 = tick()
			elseif utilities:CheckMon("Core") then
				now3 = tick()
			elseif fn28("MALffffUNCtion. END") or tick() - now3 >= 3 then
				joinAPI("factory", 0)
				now3 = tick()
			end
		end)

		local now6 = tick()

		local function fn29()
			for _, child in ipairs(v2:GetChildren()) do
				local isTool = child:IsA("Tool")
				local pos

				if isTool then
					pos = child.ToolTip == "Blox Fruit" or child.Name:find("Fruit") or child:FindFirstChild("Handle")
				else
					pos = isTool
				end

				if pos then
					local handle = child:FindFirstChild("Handle") or child:FindFirstChildWhichIsA("BasePart")
					if handle then
						return child, handle
					end
				end
			end

			return nil, nil
		end

		fn27("AutoAfkJoinFruit", 0.4, function()
			if tick() - now < 2.5 then
				now6 = tick()
				return
			end
			local v23, v24 = fn29()

			if v23 and v24 then
				now6 = tick()

				if humanoidRootPart then
					tweenManager:topos(v24.CFrame)

					if (humanoidRootPart.Position - v24.Position).Magnitude <= 30 then
						firetouchinterest(humanoidRootPart, v24, 0)
						task.wait(0.1)
						firetouchinterest(humanoidRootPart, v24, 1)
					end
				end

				local v25 = localPlayer.Backpack:FindFirstChild(v23.Name)
				local character2

				if v25 then
					character2 = v25
				else
					character2 = localPlayer.Character and localPlayer.Character:FindFirstChild(v23.Name)
				end

				if character2 then
					local attribute2 = character2:GetAttribute("OriginalName") or character2.Name

					pcall(function()
						mods:FireInvoke("StoreFruit", attribute2, character2)
					end)
				end
			elseif tick() - now6 >= 3 then
				now6 = tick()
				joinAPI("fruit", 0)
			end
		end)

		local tbl16 = {}
		local flag4 = false
		local n3 = level and level.Value or 0

		fn27("AutoDataLogWebhook", 5, function()
			if level and level.Value then
				if level.Value > n3 then
					local n4 = level.Value - n3
					n3 = level.Value

					if config.SendWebhookLevelUp and (config.AutoWebhook or config.SendWebhookDataLog) then
						hub.Webhook:SendDataLog("Level Up Detected!", "**New Level Reached:** " .. fn15(level.Value) .. " *(+" .. n4 .. ")*")
					end
				elseif level.Value < n3 then
					n3 = level.Value
				end
			end

			local sendWebhookDataLog = config.SendWebhookDataLog
			local flag5

			if sendWebhookDataLog then
				local autoWebhook = config.AutoWebhook

				if autoWebhook then
					flag5 = autoWebhook
				else
					flag5 = config.DataLogWebhookUrl and config.DataLogWebhookUrl ~= ""
				end
			else
				flag5 = sendWebhookDataLog
			end

			if flag5 then
				local n4 = math.max(60, (tonumber(config.DataLogInterval) or 5) * 60)
				local lastDataLogTick = hub.Runtime.LastDataLogTick

				if n4 <= tick() - lastDataLogTick then
					hub.Webhook:SendDataLog("Quantum Onyx - Periodic Farm Data Log")
				end
			end
		end, true)

		fn27("AutoMemoryCleaner", 60, function()
			if config.AutoCleanMemory ~= false then
				hub.Performance.CleanMemory()
			end
		end, true)

		fn27("AutoDebrisLagCleaner", 15, function()
			if config.AutoClearDebris ~= false then
				hub.Performance.ClearDebris()
			end

			if config.AutoAggressiveGC ~= false then
				hub.Performance.CleanMemory()
			end
		end, true)

		fn27("RemoveObservationEffect", 0.2, function()
			if not config.RemoveObservationEffect then
				return
			end

			pcall(function()
				if localPlayer:GetAttribute("KenActive") then
					local v23 = next
					local children, v24 = LightingSvc:GetChildren()

					for _, v25 in v23, children, v24 do
						if v25:IsA("BlurEffect") and v25.Name == "Blur" then
							v25.Enabled = false
						elseif v25:IsA("ColorCorrectionEffect") and v25.Name == "ColorCorrection" then
							v25.Enabled = false
						end
					end

					local currentCamera = workspace.CurrentCamera

					if currentCamera then
						local v25 = next
						local children2, v26 = currentCamera:GetChildren()

						for _, v27 in v25, children2, v26 do
							if v27:IsA("BasePart") and v27.Name:lower():find("ken") then
								v27.Transparency = 1
							end
						end
					end
				end
			end)
		end, true)

		fn27("AutoWebhook", 1, function()
			if config.SendWebhookPrehistoric or config.SendWebhookKitsune or config.SendWebhookMirage then
				for k, v23 in next, {
					["Prehistoric Island"] = config.SendWebhookPrehistoric,
					["Kitsune Island"] = config.SendWebhookKitsune,
					["Mirage Island"] = config.SendWebhookMirage,
				}, nil do
					if v23 then
						local v24 = worldOrigin.Locations:FindFirstChild(k)

						if v24 and not tbl16[k] then
							tbl16[k] = true
							PostWebhook(config.Webhook, WeeboLogs(k, { Position = v24:GetPivot().Position }))
						elseif not v24 then
							tbl16[k] = false
						end
					end
				end
			end

			if not flag4 then
				flag4 = true

				commE.OnClientEvent:Connect(function(arg, arg2, arg3)
					if arg == "ItemChanged" and arg3 == "stored" and arg2 and arg2.Name then
						if config.SendWebhookStoreFruit then
							local getInventory = mods:FireInvoke("getInventory")
							local tbl17 = {}

							for _, v23 in pairs(getInventory) do
								if v23.Type == "Blox Fruit" then
									table.insert(tbl17, v23.Name)
								end
							end

							PostWebhook(config.Webhook, WeeboLogs("Stored Fruit", {
								Extra = "**Fruit:** " .. arg2.Name,
								Field2 = { name = "Inventory", value = #tbl17 > 0 and table.concat(tbl17, ", ") or "Empty" },
							}))
						end
					end
				end)

				game:GetService("ReplicatedStorage").Modules.Net["RE/SpinGacha"].OnClientEvent:Connect(function(arg)
					if arg and arg.Winners and arg.Winners[1] then
						if config.SendWebhookRolledFruit then
							local v23 = arg.Winners[1]

							if v23.ItemType == "Fruit" and v23.DisplayName then
								PostWebhook(config.Webhook, WeeboLogs("Rolled Fruit", { Extra = "**Fruit:** " .. v23.DisplayName }))
							end
						end
					end
				end)
			end
		end)

		local n4 = 0

		fn27("AutoServerRefresh", 3, function()
			if tick() - n4 < 3 then
				return
			end
			n4 = tick()

			if mods._ServerInfo and type(mods._ServerInfo.RefreshDesc) == "function" and type(mods._StatusServer) == "function" then
				pcall(function()
					local v23 = mods._StatusServer()

					if v23 then
						mods._ServerInfo:RefreshDesc(v23)
					end
				end)
			end
		end, true)

		fn27("TradeAzureEmber", 0.5, function()
			local setAzureEmber = config.SetAzureEmber

			if utilities:CheckInventory("Material", "Azure Ember") >= setAzureEmber then
				net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
				mods:FireInvoke("KitsuneStatuePray")
			end
		end)

		fn27("AutoGetAnglerQuest", 2, function()
			local rfJobsRemoteFunction = net:FindFirstChild("RF/JobsRemoteFunction")

			if rfJobsRemoteFunction then
				pcall(function()
					rfJobsRemoteFunction:InvokeServer("FishingNPC", "Angler", "CheckQuest")
					local response = rfJobsRemoteFunction:InvokeServer("FishingNPC", "Angler", "Speak")

					if response then
						response = response.canAccept or not response.IsInQuest
					end

					if response then
						rfJobsRemoteFunction:InvokeServer("FishingNPC", "Angler", "AskQuest")
					end
				end)
			end
		end)

		fn27("AutoUseRodSkill", 0.5, function()
			net:WaitForChild("RF/JobToolAbilities"):InvokeServer("Z", true)
		end)

		fn27("FruitCheck", 1, function()
			local v23 = next
			local children, v24 = v2:GetChildren()

			for _, v25 in v23, children, v24 do
				if v25:IsA("Model") and string.find(v25.Name, "Fruit") then
					local name2 = v25.Name

					if name2 == "Fruit" then
						name2 = "Spawned Unknown Fruit"
					end

					mods:SendNotify("Blox Fruit Spawned", "" .. name2 .. " has spawned in the map!", 15)
				end
			end
		end)

		fn27("AutoAwaken", 0.5, function()
			mods:FireInvoke("Awakener", "Check")
			mods:FireInvoke("Awakener", "Awaken")
		end)

		local n5 = 0

		fn27("AutoBuyFruitDealer", 5, function()
			if not config.AutoBuyFruitDealer or not config.SelectFruitDealerFruit then
				return
			end

			if tick() - n5 < 10 then
				return
			end
			local selectFruitDealerFruit = config.SelectFruitDealerFruit
			if not selectFruitDealerFruit or selectFruitDealerFruit == "" then
				return
			end

			local ok, result = pcall(function()
				return mods:FireInvoke("GetFruits")
			end)

			if ok and typeof(result) == "table" then
				for k in next, result, nil do
					if f and (f.Name == selectFruitDealerFruit or f.Name:match("^(.-)%-") == selectFruitDealerFruit:match("^(.-)%-")) then
						if f.OnSale == true then
							local n6 = beli and beli.Value or 0
							local n7 = tonumber(f.Price) or 0

							if n6 >= n7 then
								n5 = tick()

								if pcall(function()
									return mods:FireInvoke("PurchaseRawFruit", f.Name, false)
								end) then
									mods:SendNotify("Fruit Dealer", "Auto-bought " .. f.Name .. " for $" .. fn15(n7) .. "!", 6)

									if config.SendWebhookStoreFruit or config.AutoWebhook then
										local dataLogWebhookUrl = config.DataLogWebhookUrl and config.DataLogWebhookUrl ~= "" and config.DataLogWebhookUrl or config.Webhook

										if dataLogWebhookUrl and dataLogWebhookUrl ~= "" then
											PostWebhook(dataLogWebhookUrl, WeeboLogs("Fruit Dealer Purchase", {
												Extra = "**Auto Purchased Fruit:** " .. f.Name .. " ($" .. fn15(n7) .. ")",
												Field2 = {
													name = "Beli Remaining",
													value = "$" .. fn15((beli and beli.Value or 0) - n7),
												},
											}))
										end
									end
								end
							end
						end

						break
					end
				end
			end
		end, true)

		local n6 = 0

		fn27("AutoBuyMirageFruitDealer", 5, function()
			if not config.AutoBuyMirageFruitDealer or not config.SelectMirageDealerFruit then
				return
			end

			if tick() - n6 < 10 then
				return
			end
			local selectMirageDealerFruit = config.SelectMirageDealerFruit
			if not selectMirageDealerFruit or selectMirageDealerFruit == "" then
				return
			end

			local ok, result = pcall(function()
				return mods:FireInvoke("GetFruits", true)
			end)

			if ok and typeof(result) == "table" then
				for k in next, result, nil do
					if f and (f.Name == selectMirageDealerFruit or f.Name:match("^(.-)%-") == selectMirageDealerFruit:match("^(.-)%-")) then
						if f.OnSale == true then
							local n7 = beli and beli.Value or 0
							local n8 = tonumber(f.Price) or 0

							if n7 >= n8 then
								n6 = tick()

								if pcall(function()
									return mods:FireInvoke("PurchaseRawFruit", f.Name, true)
								end) then
									mods:SendNotify("Mirage Dealer", "Auto-bought " .. f.Name .. " for $" .. fn15(n8) .. "!", 6)

									if config.SendWebhookStoreFruit or config.AutoWebhook then
										local dataLogWebhookUrl = config.DataLogWebhookUrl and config.DataLogWebhookUrl ~= "" and config.DataLogWebhookUrl or config.Webhook

										if dataLogWebhookUrl and dataLogWebhookUrl ~= "" then
											PostWebhook(dataLogWebhookUrl, WeeboLogs("Mirage Fruit Dealer Purchase", {
												Extra = "**Auto Purchased Mirage Fruit:** " .. f.Name .. " ($" .. fn15(n8) .. ")",
												Field2 = {
													name = "Beli Remaining",
													value = "$" .. fn15((beli and beli.Value or 0) - n8),
												},
											}))
										end
									end
								end
							end
						end

						break
					end
				end
			end
		end, true)

		local n7 = 0

		fn27("AutoCraftScrolls", 5, function()
			if not config.AutoCraftScrolls then
				return
			end

			if tick() - n7 < 5 then
				return
			end
			n7 = tick()

			local str4 = ({
				["Common Scroll"] = "CommonScroll",
				["Rare Scroll"] = "RareScroll",
				["Legendary Scroll"] = "LegendaryScroll",
				["Mythical Scroll"] = "MythicalScroll",
			})[config.SelectScrollType or "Common Scroll"] or "CommonScroll"

			local n8 = tonumber(config.ScrollCraftAmount) or 1

			pcall(function()
				Net:RemoteFunction("Craft"):InvokeServer(str4, n8)
			end)
		end, true)

		fn27("AutoActivateObservationHaki", 0.5, function()
			remotes.CommE:FireServer("Ken", true)
		end)

		fn27("AutoSellFish", 0.5, function()
			net:WaitForChild("RF/JobsRemoteFunction"):InvokeServer("FishingNPC", "SellFish")
		end)

		fn27("AutoAgility", 0.5, function()
			RS.Remotes.CommE:FireServer("ActivateAbility")
		end)

		fn27("AutoActiveRaceV4", 0.5, function()
			if localPlayer.Character and localPlayer.Character:FindFirstChild("RaceEnergy") and localPlayer.Character:FindFirstChild("RaceTransformed") then
				if localPlayer.Character.RaceEnergy.Value >= 1 and not localPlayer.Character.RaceTransformed.Value then
					localPlayer.Backpack.Awakening.RemoteFunction:InvokeServer({ true })
				end
			end
		end)

		fn27("AutoLookMoon", 0.2, function()
			v2.CurrentCamera.CFrame = CFrame.lookAt(v2.CurrentCamera.CFrame.p, v2.CurrentCamera.CFrame.p + LightingSvc:GetMoonDirection() * 100)
		end)

		fn27("ManualIncreaseBoatSpeed", 0.2, function()
			if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character.Humanoid.Sit then
				local seatPart = localPlayer.Character.Humanoid.SeatPart

				if seatPart and seatPart:IsA("VehicleSeat") then
					seatPart.MaxSpeed = tonumber(config.ManualBoatSpeed) or 150
					seatPart.Torque = 0.2
					seatPart.TurnSpeed = 5
				else
					local v23 = next
					local children, v24 = boats:GetChildren()

					for _, v25 in v23, children, v24 do
						local vehicleSeat = v25:FindFirstChildWhichIsA("VehicleSeat") or v25:FindFirstChild("VehicleSeat")

						if vehicleSeat then
							vehicleSeat.MaxSpeed = tonumber(config.ManualBoatSpeed) or 150
							vehicleSeat.Torque = 0.2
							vehicleSeat.TurnSpeed = 5
						end
					end
				end
			end
		end)

		fn27("BuyGear", 0.5, function()
			mods:FireInvoke("UpgradeRace", "Buy")
		end)

		fn27("AutoBuyEnchancementColor", 0.5, function()
			mods:FireInvoke("ColorsDealer", "1")
			mods:FireInvoke("ColorsDealer", "2")
		end)

		fn27("BuyTTK", 0.5, function()
			mods:FireInvoke("MysteriousMan", "2")
		end)

		fn27("BuyLegendSword", 0.5, function()
			mods:FireInvoke("LegendarySwordDealer", "1")
			mods:FireInvoke("LegendarySwordDealer", "2")
		end)

		fn27("Random_Auto", 0.5, function()
			if mods:FireInvoke("Cousin", "CheckTime", "DLCBoxData") == true then
				local Cousin = mods:FireInvoke("Cousin", "DLCBoxData")

				if Cousin == 1 then
					mods:SendNotify("Random Fruit", "Successfully purchased!", 5)

					if config.SendWebhookRolledFruit then
						task.spawn(function()
							task.wait(0.6)
							local name2 = nil

							for _, v23 in ipairs({ localPlayer.Backpack, localPlayer.Character }) do
								if v23 then
									for _, child in ipairs(v23:GetChildren()) do
										if child:IsA("Tool") and child.Name:find("Fruit") then
											name2 = child.Name
											break
										end
									end
								end

								if not name2 then
									continue
								end
								break
							end

							name2 = name2 or "Unknown Fruit"
							local match = name2:match("^(.-)%-") or name2
							local webhook = config.Webhook

							if webhook and webhook ~= "" then
								PostWebhook(webhook, WeeboLogs("Rolled Fruit", {
									Extra = "**Fruit:** " .. match .. " (" .. name2 .. ")",
									Field2 = { name = "Beli Remaining", value = "$" .. fn15(beli and beli.Value or 0) },
								}))
							end
						end)
					end
				elseif Cousin == 2 then
					mods:SendNotify("Random Fruit", "Not enough money!", 5)
				elseif Cousin == 3 then
					mods:SendNotify("Random Fruit", "Level 50 required!", 5)
				elseif Cousin then
					mods:SendNotify("Random Fruit", tostring(Cousin), 5)
				end
			end

			local spinnerWindow = localPlayer.PlayerGui:FindFirstChild("SpinnerWindow")

			if spinnerWindow then
				local closeButton = spinnerWindow:FindFirstChild("AboveSpinner") and spinnerWindow.AboveSpinner:FindFirstChild("Navigation") and spinnerWindow.AboveSpinner.Navigation:FindFirstChild("CloseButton")

				if closeButton and closeButton.Visible then
					pcall(function()
						firesignal(closeButton.Activated)
					end)
				end
			end
		end)

		local tbl17 = {}

		fn27("AutoStoreFruit", 1, function()
			for _, v23 in ipairs({ localPlayer.Backpack, localPlayer.Character, v2.Characters:FindFirstChild(localPlayer.Name) }) do
				if v23 then
					for _, child in ipairs(v23:GetChildren()) do
						if child:IsA("Tool") and string.find(child.Name, "Fruit") then
							local attribute2 = child:GetAttribute("OriginalName") or child.Name:match("^(.-)%-") or child.Name
							local n8 = tbl17[attribute2] or 0

							if tick() - n8 > 45 then
								local StoreFruit = mods:FireInvoke("StoreFruit", attribute2, child)
								task.wait(0.3)

								if not child:IsDescendantOf(game) or child.Parent == nil or StoreFruit == true then
									tbl17[attribute2] = nil

									if config.SendWebhookStoreFruit then
										local webhook = config.Webhook

										if webhook and webhook ~= "" then
											local tbl18 = {}

											pcall(function()
												local response = Net:RemoteFunction("GetAllItemValues"):InvokeServer()

												if response and typeof(response) == "table" then
													for _, v24 in next, response, nil do
														if v24.Key == "IsOwned" and v24.Value == true then
															local ok, result = pcall(function()
																return ItemConfig.match(v24.ItemId)
															end)

															if ok and result and result.isOk and result:isOk() then
																local v25 = result:unwrap()

																if v25 and v25.Index and v25.Index.DebugLabel then
																	local str4 = tostring(v25.Index.DebugLabel)

																	if str4:find("PhysicalMoveset") or str4:find("Fruit") then
																		local match = str4:match("^(.-)%s*%[") or str4
																		table.insert(tbl18, match:match("^(.-)%-") or match)
																	end
																end
															end
														end
													end
												end
											end)

											PostWebhook(webhook, WeeboLogs("Stored Fruit", {
												Extra = "**Stored Fruit:** " .. attribute2,
												Field2 = {
													name = "Storage Count",
													value = tostring(#tbl18) .. " Fruits Stored",
												},
											}))
										end
									end
								else
									tbl17[attribute2] = tick()
								end
							end
						end
					end
				end
			end
		end)

		fn27("Auto_Random_Surprise", 2, function()
			if utilities:CheckInventory("Material", "Bones") >= 50 then
				mods:FireInvoke("Bones", "Buy", 1, 1)
				task.wait(1.5)
			end
		end)

		fn27("AutoPray", 1, function()
			mods:FireInvoke("gravestoneEvent", 1)
		end)

		fn27("AutoTryLuck", 1, function()
			mods:FireInvoke("gravestoneEvent", 2)
		end)

		fn27("AutoAttack", 0, function()
			if config.AutoAttack ~= false then
				fastAttack()
			end
		end, true)

		fn27("NoFog", 2.5, function()
			if config.NoFog then
				LightingSvc.FogEnd = math.huge

				if LightingSvc:FindFirstChild("FantasySky") then
					LightingSvc.FantasySky:Destroy()
				elseif LightingSvc:FindFirstChild("LightingLayers") then
					LightingSvc.LightingLayers:Destroy()
				elseif LightingSvc:FindFirstChild("Sky") then
					LightingSvc.Sky:Destroy()
				elseif LightingSvc:FindFirstChild("SeaTerrorCC") then
					LightingSvc.SeaTerrorCC:Destroy()
				end
			end
		end)

		fn27("AutoCardsDungeon", 0.3, function()
			local cardsSelection = config.CardsSelection
			if not cardsSelection then
				return
			end
			local tbl18

			if type(cardsSelection) == "string" then
				tbl18 = { cardsSelection }
			else
				tbl18 = cardsSelection
			end

			if #tbl18 == 0 then
				return
			end

			for _, descendant in ipairs(localPlayer.PlayerGui:GetDescendants()) do
				if descendant:IsA("TextLabel") and descendant.Name == "DisplayName" and descendant.Text then
					local v23 = string.lower(descendant.Text:gsub("<[^>]+>", ""))

					for _, v24 in ipairs(tbl18) do
						if string.find(v23, string.lower(v24)) then
							local parent = descendant.Parent
							if parent and parent.Activated then
								firesignal(parent.Activated)
								return true
							end
						end
					end
				end
			end
		end)
	end

	mods.LoadFunctions = function()
		mods.Functions = mods.Functions or {}
		mods.FunctionList = mods.FunctionList or {}
		mods.ActiveFunction = mods.ActiveFunction or nil
		local functions = mods.Functions
		local functionList = mods.FunctionList
		local tbl15 = {}

		local tbl16 = {
			"AutoFactoryRaid",
			"AutoFarmPirateRaid",
			"AutoSoulReaper",
			"AutoTaskEliteHunter",
			"Tweenfruit",
			"AutoBerrySafe",
		}

		mods.IsMultiFunction = function(arg)
			for _, v22 in ipairs(tbl16) do
				if v22 == arg then
					return true
				end
			end

			return false
		end

		local now = nil

		local function fn27()
			if config.AutoFarmPirateRaid and isSea3 then
				if gameData:DetectPirateRaid() then
					now = tick()
					mods.ActiveFunction = "AutoFarmPirateRaid"
					return true
				end

				if now and tick() - now < 8 then
					mods.ActiveFunction = "AutoFarmPirateRaid"
					return true
				end
			end

			if config.AutoFactoryRaid and utilities:CheckMon("Core") and isSea2 then
				mods.ActiveFunction = "AutoFactoryRaid"
				return true
			end

			if config.AutoSoulReaper and isSea3 then
				if utilities:CheckMon("Soul Reaper") or utilities:CheckToolName("Hallow Essence") then
					mods.ActiveFunction = "AutoSoulReaper"
					return true
				end
			end

			if config.AutoTaskEliteHunter and isSea3 then
				if gameData:Checkelites() then
					mods.ActiveFunction = "AutoTaskEliteHunter"
					return true
				end
			end

			if config.Tweenfruit then
				if gameData:GetPathFruit() or config.HopIfNoFruit then
					mods.ActiveFunction = "Tweenfruit"
					return true
				end
			end

			if config.AutoBerrySafe then
				if gameData:CheckBerries() or config.HopIfNoBerries then
					mods.ActiveFunction = "AutoBerrySafe"
					return true
				end
			end

			mods.ActiveFunction = nil
			return false
		end

		local function fn28(activeFunction, func, arg, arg2)
			if not activeFunction or type(func) ~= "function" or not arg then
				return
			end

			if tbl15[activeFunction] then
				if functions[activeFunction] then
					functions[activeFunction]._StopFlag = true
				end

				task.cancel(tbl15[activeFunction])
				tbl15[activeFunction] = nil
			end

			functions[activeFunction] = {
				Enable = arg,
				Running = false,
				Func = func,
				NoLock = arg2 or false,
				_StopFlag = false,
				Stop = function()
					if config then
						config[activeFunction] = false
					end

					functions[activeFunction].Running = false

					if mods.ActiveFunction == activeFunction then
						mods.ActiveFunction = nil
					end

					tweenManager:StopTween()
				end,
				Call = function()
					local activeFunction2 = mods.ActiveFunction
					mods.ActiveFunction = nil
					pcall(func)
					mods.ActiveFunction = activeFunction2
				end,
			}

			local flag4 = false

			for _, v22 in ipairs(functionList) do
				if v22.Name == activeFunction then
					v22.Func = func
					flag4 = true
					break
				end
			end

			if not flag4 then
				table.insert(functionList, { Name = activeFunction, Func = func })
			end

			tbl15[activeFunction] = task.spawn(function()
				local v22 = functions[activeFunction]

				while v22 and not v22._StopFlag do
					if config and config[activeFunction] then
						if v22.NoLock then
							v22.Running = true
							pcall(func)
							task.wait(0.25)
						elseif mods.IsMultiFunction(activeFunction) then
							if fn27() and mods.ActiveFunction == activeFunction then
								v22.Running = true
								pcall(func)
								task.wait(0.25)
							else
								if v22.Running then
									v22.Running = false
								end

								task.wait(0.25)
							end
						elseif fn27() then
							if v22.Running then
								v22.Running = false
							end

							task.wait(0.25)
						elseif mods.ActiveFunction == nil or mods.ActiveFunction == activeFunction then
							mods.ActiveFunction = activeFunction
							v22.Running = true
							pcall(func)
							task.wait(0.25)
							mods.ActiveFunction = nil
						else
							if v22.Running then
								v22.Running = false
							end

							task.wait(0.25)
						end
					else
						if mods.ActiveFunction == activeFunction then
							mods.ActiveFunction = nil
						end

						if v22.Running then
							v22.Running = false
						end

						task.wait(0.5)
					end
				end

				if mods.ActiveFunction == activeFunction then
					mods.ActiveFunction = nil
				end
			end)

			if config and config[activeFunction] then
				functions[activeFunction].Running = true
			end
		end

		mods.GetEnabledFunctionNames = function()
			local tbl17 = {}

			for _, v22 in ipairs(functionList) do
				if config and config[v22.Name] then
					table.insert(tbl17, v22.Name)
				end
			end

			return tbl17
		end

		mods.IsFunctionBlockedByMulti = function(arg)
			local v22 = functions[arg]
			if v22 and v22.NoLock then
				return false
			end

			if mods.IsMultiFunction(arg) then
				return mods.ActiveFunction ~= arg
			end
			return mods.ActiveFunction ~= nil and mods.ActiveFunction ~= arg
		end

		fn28("AutoTaskEliteHunter", function()
			local v22 = gameData:Checkelites()

			if v22 then
				if not VerifyQuest(v22) then
					mods:FireInvoke("AbandonQuest")
					task.wait(0.1)
					mods:FireInvoke("EliteHunter")
				else
					local enemies2 = utilities:GetEnemies(v22)
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
				end
			end
		end, isSea3)

		fn28("AutoFarmBones", function()
			if config.AcceptQuests and not VerifyQuest("Demonic Soul") then
				return utilities:StartQuest("HauntedQuest2", 1, CFrame.new(-9517, 172, 6078))
			end
			local enemies2 = utilities:GetEnemies(mods.DataList.BonesList)
			if enemies2 then
				return subFunction:Attack(enemies2, true)
			end
			utilities:MobsNextSpawn("Reborn Skeleton")
		end, isSea3)

		fn28("AutoFarmBoss", function()
			local v22 = CheckBoss(config.SelectBoss)
			if not v22 then
				return task.wait(1)
			end
			config.SelectBoss = v22[2]
			local flag4 = config.GetBossQuest and not VerifyQuest(v22[2]) and utilities:CheckMon(v22[2])

			if flag4 then
				flag4 = level.Value >= (v22[1] or 0)
			end

			if flag4 then
				return utilities:StartQuest(v22[3], v22[4], v22[5])
			end
			local enemies2 = utilities:GetEnemies(v22[2])

			if enemies2 then
				subFunction:Attack(enemies2)
			else
				utilities:MobsNextSpawn(v22[2])
			end
		end, true)

		fn28("AutoKillAllBosses", function()
			local sea3 = isSea3 and bossList.Sea_3 or isSea2 and bossList.Sea_2 or flag and bossList.Sea_1
			if not sea3 or #sea3 == 0 then
				return task.wait(1)
			end

			for _, v22 in next, sea3, nil do
				local n2 = v22[1] or 0
				local v23 = v22[2]

				if level.Value >= n2 and utilities:CheckMon(v23) then
					local enemies2 = utilities:GetEnemies(v23)

					if enemies2 and mods:IsReady(enemies2) then
						if config.GetBossQuest and not VerifyQuest(v23) then
							if localPlayer.PlayerGui.Main:FindFirstChild("Quest") and localPlayer.PlayerGui.Main.Quest.Visible then
								pcall(function()
									mods:FireInvoke("AbandonQuest")
								end)

								task.wait(0.2)
							end

							return utilities:StartQuest(v22[3], v22[4], v22[5])
						end

						return subFunction:Attack(enemies2)
					end
				end
			end

			for _, v22 in next, sea3, nil do
				local n2 = v22[1] or 0
				local v23 = v22[2]
				if not (n2 <= level.Value) then
					continue
				end

				if v22[5] then
					return utilities:MobsNextSpawn(v23)
				end
			end
		end, true)

		fn28("TeleportToIsland", function()
			for k, v22 in next, mods._ActiveIslands, nil do
				if k == config.TeleportIslandSelect then
					if (character.HumanoidRootPart.Position - Vector3.new(v22.X, v22.Y, v22.Z)).Magnitude <= 10 then
						mods._TravelToggle.Update(false)
					else
						tweenManager:topos(v22)
					end
				end
			end
		end, true)

		fn28("TPtoNPC", function()
			local v22 = next
			local children, v23 = RS.NPCs:GetChildren()

			for _, v24 in v22, children, v23 do
				if v24.Name == config.NpcTween then
					tweenManager:topos(v24:GetPivot())
				end
			end
		end, true)

		fn28("TeleporttoPlayer", function()
			local nearestPlayer = (config.SelectPlayer == "Nearest" or not config.SelectPlayer) and gameData:GetNearestPlayer() or v3:FindFirstChild(config.SelectPlayer)

			if nearestPlayer and nearestPlayer ~= localPlayer and nearestPlayer.Character then
				local humanoidRootPart3 = nearestPlayer.Character:FindFirstChild("HumanoidRootPart") or nearestPlayer.Character.PrimaryPart
				local humanoid2 = nearestPlayer.Character:FindFirstChildOfClass("Humanoid")

				if humanoidRootPart3 and humanoid2 and humanoid2.Health > 0 then
					tweenManager:topos(humanoidRootPart3.CFrame)
				end
			end
		end, true)

		fn28("AutoFarm", function()
			local v22 = CheckQuest()
			if not v22 or not v22[1] or v22[1] == "" then
				return
			end
			local v23 = v22[1]
			local pos = v22[2]
			local enemies2 = utilities:GetEnemies(v23)
			local nearest = gameData:GetNearest()
			local farmMode = config.FarmMode or "Quest"
			pos = pos and pos:lower():find("submerged")

			if not pos then
				if v23 then
					pos = v23 == "Reef Bandit" or v23 == "Coral Pirate" or v23 == "Sea Chanter" or v23 == "High Disciple" or v23 == "Grand Devotee"
				else
					pos = v23
				end
			end

			local v24 = isSea3

			if not isSea3 then
				pos = v24
			end

			if pos and farmMode ~= "Nearest" then
				if (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character.HumanoidRootPart.Position.Y or 0) > -500 then
					if localPlayer:DistanceFromCharacter(Vector3.new(-16269.102, 29.517754, 1372.3204)) > 15 then
						tweenManager:topos(CFrame.new(-16269.1016, 29.5177539, 1372.3204))
						task.wait(0.5)

						for i = 1, 2 do
							net:WaitForChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
						end

						return
					end
				end
			end

			if farmMode == "Quest" then
				if not VerifyQuest(v23) then
					return GetQuest()
				end

				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				return utilities:MobsNextSpawn(v23)
			end

			if farmMode == "No Quest" then
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				return utilities:MobsNextSpawn(v23)
			end

			if farmMode == "Nearest" then
				if nearest then
					return subFunction:Attack(nearest, true)
				end
			end
		end, true)

		local n2 = 0
		local str4 = ""

		fn28("AutoFarmPrince", function()
			if not config.IgnoreCakePrince and utilities:CheckMon("Cake Prince") then
				local enemies2 = utilities:GetEnemies("Cake Prince")

				if enemies2 then
					if localPlayer:GetAttribute("CurrentLocation") ~= "Dimensional Shift" then
						tweenManager:topos(CFrame.new(-2168, 84, -12397))
						task.wait(1)
						return
					end

					return subFunction:Attack(enemies2)
				end
			end

			local now2 = tick()

			if now2 - n2 > 4 then
				n2 = now2

				local ok, result = pcall(function()
					return mods:FireInvoke("CakePrinceSpawner")
				end)

				if ok and type(result) == "string" then
					str4 = result
				end
			end

			if string.find(str4, "open the portal now") then
				mods:FireInvoke("CakePrinceSpawner")
				task.wait(1)
				return
			end

			if config.AcceptQuests and not VerifyQuest("Cookie Crafter") then
				return utilities:StartQuest("CakeQuest1", 1, CFrame.new(-2021, 38, -12029))
			end
			local enemies2 = utilities:GetEnemies(mods.DataList.CakesList)
			if enemies2 then
				return subFunction:Attack(enemies2, true)
			end
			tweenManager:topos(CFrame.new(-2304, 228, -12240))
		end, isSea3)

		fn28("AutoTeleportMirage", function()
			if config.AutoTeleportMirage then
				for _, child in pairs(v2._WorldOrigin.Locations:GetChildren()) do
					if child.Name == "Mirage Island" then
						tweenManager:topos(child.CFrame * CFrame.new(0, 333, 0), true)
					end
				end
			end
		end, isSea3)

		fn28("AutoTeleportPrehistoric", function()
			if config.AutoTeleportPrehistoric then
				for _, child in pairs(v2._WorldOrigin.Locations:GetChildren()) do
					if child.Name == "Prehistoric Island" then
						tweenManager:topos(child.CFrame * CFrame.new(0, 333, 0), true)
					end
				end
			end
		end, isSea3)

		fn28("AutoTeleportKitsune", function()
			if config.AutoTeleportKitsune then
				for _, child in pairs(v2._WorldOrigin.Locations:GetChildren()) do
					if child.Name == "Kitsune Island" then
						tweenManager:topos(child.CFrame * CFrame.new(0, 300, 0), true)
					end
				end
			end
		end, isSea3)

		fn28("AutoBlueMoonFarm", function()
			if not config.AutoBlueMoonFarm then
				mods._BlueMoonState = "FIND_ISLAND"
				tweenManager:StopBoatTween()
				return
			end

			IsBlueMoonActive = function()
				return LightingSvc:GetAttribute("IsBlueMoon") == true
			end

			HasBlueMoonEnded = function()
				return LightingSvc:GetAttribute("BlueMoonEnded") == true
			end

			local function fn29()
				return map:FindFirstChild("KitsuneIsland") or worldOrigin and worldOrigin:FindFirstChild("Locations") and worldOrigin.Locations:FindFirstChild("Kitsune Island") or v2:FindFirstChild("KitsuneIsland")
			end

			local function fn30(arg)
				if not arg then
					return nil
				end
				return arg:FindFirstChild("optimizedcylinder", true) or arg:FindFirstChild("Shrine", true) or arg:FindFirstChild("Statue", true) or arg.PrimaryPart
			end

			local function fn31()
				pcall(function()
					mods:FireInvoke("TouchKitsuneStatue")
				end)
			end

			local function fn32()
				local position2 = localPlayer.Character and localPlayer.Character:GetPivot().Position
				if not position2 then
					return nil
				end
				local huge = math.huge
				local v22 = nil

				for _, child in ipairs(v2:GetChildren()) do
					if child:IsA("Model") and child.Name == "EmberTemplate" then
						local basePart = child:FindFirstChildWhichIsA("BasePart") or child.PrimaryPart

						if basePart and basePart:GetAttribute("IsPlayerEmber") ~= true then
							local magnitude = (basePart.Position - position2).Magnitude

							if magnitude < huge then
								huge = magnitude
								v22 = basePart
							end
						end
					end
				end

				return v22
			end

			if IsBlueMoonActive() then
				mods._BlueMoonState = "COLLECT_EMBERS"
			end

			local v22 = fn29()
			local v23 = fn30(v22)

			if (v22 or v23) and mods._BlueMoonState == "FIND_ISLAND" and not IsBlueMoonActive() then
				tweenManager:StopBoatTween()

				if humanoid and humanoid.Sit then
					humanoid.Sit = false
				end

				mods._BlueMoonState = "GO_TO_SHRINE"
			end

			if mods._BlueMoonState == "FIND_ISLAND" then
				if IsBlueMoonActive() then
					mods._BlueMoonState = "COLLECT_EMBERS"
					return
				end

				if v22 then
					tweenManager:StopBoatTween()

					if humanoid and humanoid.Sit then
						humanoid.Sit = false
					end

					mods._BlueMoonState = "GO_TO_SHRINE"
				else
					subFunction:AutoBoatSail(CFrame.new(-10000000, 31, 37016.25))
				end
			elseif mods._BlueMoonState == "GO_TO_SHRINE" then
				if v23 and humanoidRootPart then
					if (v23.Position - humanoidRootPart.Position).Magnitude > 30 then
						tweenManager:topos(v23.CFrame * CFrame.new(0, 5, 0), true)
					else
						fn31()
						task.wait(0.3)

						if IsBlueMoonActive() then
							mods._BlueMoonState = "COLLECT_EMBERS"
						end
					end
				else
					mods._BlueMoonState = "FIND_ISLAND"
				end
			elseif mods._BlueMoonState == "COLLECT_EMBERS" then
				if HasBlueMoonEnded() or not IsBlueMoonActive() then
					mods._BlueMoonState = "FIND_ISLAND"
					return
				end
				local v24 = fn32()

				if v24 then
					tweenManager:topos(v24.CFrame)
				end
			end
		end, isSea3)

		fn28("AutoDoughKing", function()
			if utilities:CheckMon("Dough King") then
				local enemies2 = utilities:GetEnemies("Dough King")

				if enemies2 then
					if localPlayer:GetAttribute("CurrentLocation") ~= "Dimensional Shift" then
						tweenManager:topos(CFrame.new(-2168, 84, -12397))
						task.wait(1)
						return
					end

					return subFunction:Attack(enemies2)
				end
			elseif not config.IgnoreDoughChaliceFarm then
				if not utilities:CheckToolName("Sweet Chalice") then
					if mods:FireInvoke("SweetChaliceNpc") == "Where are the items?" then
						if utilities:CheckInventory("Material", "Conjured Cocoa") < 10 then
							local enemies2 = utilities:GetEnemies({ "Chocolate Bar Battler", "Cocoa Warrior" })

							if enemies2 then
								subFunction:Attack(enemies2, true)
							else
								utilities:MobsNextSpawn("Chocolate Bar Battler")
							end
						elseif not utilities:CheckToolName("God's Chalice") then
							local v22 = gameData:Checkelites()

							if v22 then
								if not VerifyQuest(v22) then
									mods:FireInvoke("AbandonQuest")
									task.wait(0.1)
									mods:FireInvoke("EliteHunter")
								else
									local enemies2 = utilities:GetEnemies(v22)

									if enemies2 then
										subFunction:Attack(enemies2)
									end
								end
							else
								functions.AutoChest.Call()
							end
						end
					end
				else
					local now2 = tick()

					if now2 - n2 > 4 then
						n2 = now2

						local ok, result = pcall(function()
							return mods:FireInvoke("CakePrinceSpawner")
						end)

						if ok and type(result) == "string" then
							str4 = result
						end
					end

					if string.find(str4, "open the portal now") then
						mods:FireInvoke("CakePrinceSpawner")
						task.wait(1)
					else
						local enemies2 = utilities:GetEnemies(mods.DataList.CakesList)
						if enemies2 then
							return subFunction:Attack(enemies2, true)
						end
						utilities:MobsNextSpawn("Head Baker")
					end
				end
			end
		end, isSea3)

		fn28("AutoTyrantOfTheSkies", function()
			local enemies2 = utilities:GetEnemies("Tyrant of the Skies")
			local enemies3 = utilities:GetEnemies(mods.DataList.TyrantList)
			if utilities:CheckMon("Tyrant of the Skies") then
				return subFunction:Attack(enemies2)
			end

			if gameData:TyrantEyes() >= 4 then
				subFunction:AttackTree()
			else
				if enemies3 then
					return subFunction:Attack(enemies3, true)
				end
				tweenManager:topos(CFrame.new(-16257, 22, 1062))
			end
		end, isSea3)

		fn28("AutoMaterial", function()
			local selectMaterial = config.SelectMaterial
			local v22

			if flag then
				v22 = materialEnemies.Sea_1[selectMaterial]
			elseif isSea2 then
				v22 = materialEnemies.Sea_2[selectMaterial]
			else
				v22 = nil

				if isSea3 then
					v22 = materialEnemies.Sea_3[selectMaterial]
				end
			end

			if v22 and #v22 > 0 then
				local enemies2 = utilities:GetEnemies(v22)
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				return utilities:MobsNextSpawn(v22[1])
			end
		end, true)

		fn28("AutoSecondSea", function()
			if not (flag and level.Value >= 700) then
				return nil
			end

			if mods:FireInvoke("DressrosaQuestProgress").KilledIceBoss then
				mods:FireInvoke("TravelDressrosa")
			elseif map.Ice.Door.CanCollide then
				if not utilities:CheckToolName("Key") then
					if localPlayer:DistanceFromCharacter(Vector3.new(4852, 6, 719)) < 5 then
						mods:FireInvoke("DressrosaQuestProgress", "Detective")
					else
						tweenManager:topos(CFrame.new(4852, 6, 719))
					end
				else
					utilities:EquipTool("Key")

					if utilities:CheckToolName("Key") then
						tweenManager:topos(map.Ice.Door.CFrame)
					end
				end
			else
				local enemies2 = utilities:GetEnemies("Ice Admiral")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
			end
		end, flag)

		fn28("AutoThirdSea", function()
			if level.Value >= 1500 then
				if mods:FireInvoke("BartiloQuestProgress", "Bartilo") == 3 then
					if mods:FireInvoke("TalkTrevor", "1") ~= 0 then
						if mods:FireInvoke("GetUnlockables").FlamingoAccess == nil then
							if not utilities:Checkfruit() and getfruitstore() then
								mods:FireInvoke("LoadFruit", getfruitstore())
								task.wait(0.1)
							else
								mods:FireInvoke("TalkTrevor", "1")
								mods:FireInvoke("TalkTrevor", "2")
								mods:FireInvoke("TalkTrevor", "3")
							end
						end
					elseif not mods:FireInvoke("ZQuestProgress", "Check") then
						if utilities:CheckMon("Don Swan") then
							local enemies2 = utilities:GetEnemies("Don Swan")
							if enemies2 then
								return subFunction:Attack(enemies2)
							end
							utilities:MobsNextSpawn("Don Swan")
						end
					elseif mods:FireInvoke("ZQuestProgress", "Check") == 0 then
						if (localPlayer.Character.HumanoidRootPart.Position - v2.Map.IndraIsland.Part.Position).Magnitude > 1000 then
							tweenManager:topos(CFrame.new(-1926.78772, 12.1678171, 1739.80884, 0.956294656, 0, -0.292404652, 0, 1, 0, 0.292404652, 0, 0.956294656))

							if (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(-1926.78772, 12.1678171, 1739.80884, 0.956294656, 0, -0.292404652, 0, 1, 0, 0.292404652, 0, 0.956294656).Position).Magnitude <= 5 then
								mods:FireInvoke("ZQuestProgress", "Begin")
							end
						else
							local enemies2 = utilities:GetEnemies("rip_indra")
							if enemies2 then
								return subFunction:Attack(enemies2)
							end
						end
					elseif mods:FireInvoke("TalkTrevor", "1") == 0 and mods:FireInvoke("ZQuestProgress", "Check") == 1 and mods:FireInvoke("ZQuestProgress", "Zou") == 0 then
						mods:FireInvoke("TravelZou")
					end
				end
			end
		end, isSea2)

		fn28("AutoTushita", function()
			if utilities:CheckInventory("Moveset", "Tushita") then
				return
			end
			local TushitaProgress = mods:FireInvoke("TushitaProgress")

			if typeof(TushitaProgress) ~= "table" then
				TushitaProgress = { Torches = { false, false, false, false, false } }
			end

			if TushitaProgress.OpenedDoor then
				local enemies2 = utilities:GetEnemies("Longma")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
				tweenManager:topos(CFrame.new(-10237, 339, 8758))
				return
			end

			if utilities:CheckMon("rip_indra True Form") or utilities:CheckToolName("Holy Torch") then
				if not utilities:CheckToolName("Holy Torch") then
					return tweenManager:topos(CFrame.new(5713, 19, 255))
				end
				utilities:EquipTool("Holy Torch")
				local torches = TushitaProgress.Torches or {}

				for i = 1, #torches do
					if not torches[i] then
						mods:FireInvoke("TushitaProgress", "Torch", i)
					end
				end

				return true
			end

			if utilities:CheckToolName("God's Chalice") then
				utilities:EquipTool("God's Chalice")
				return tweenManager:topos(CFrame.new(-5561, 314, -2663))
			end
			local v22 = gameData:Checkelites()

			if v22 then
				if not VerifyQuest(v22) then
					mods:FireInvoke("AbandonQuest")
					task.wait(0.1)
					mods:FireInvoke("EliteHunter")
				else
					local enemies2 = utilities:GetEnemies(v22)
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
				end
			else
				functions.AutoChest.Call()
			end
		end, isSea3)

		fn28("AutoYama", function()
			if utilities:CheckInventory("Moveset", "Yama") then
				return nil
			end

			if (tonumber(mods:FireInvoke("EliteHunter", "Progress")) or 0) < 30 then
				local v22 = gameData:Checkelites()

				if v22 then
					if not VerifyQuest(v22) then
						mods:FireInvoke("AbandonQuest")
						task.wait(0.1)
						mods:FireInvoke("EliteHunter")
					else
						local enemies2 = utilities:GetEnemies(v22)
						if enemies2 then
							return subFunction:Attack(enemies2)
						end
					end
				else
					joinAPI("elites", 1)
				end
			else
				local sealedKatana = map:FindFirstChild("Waterfall") and map.Waterfall:FindFirstChild("SealedKatana")
				sealedKatana = sealedKatana and sealedKatana:FindFirstChild("Hitbox")

				if sealedKatana then
					if localPlayer:DistanceFromCharacter(sealedKatana.Position) > 10 then
						tweenManager:topos(sealedKatana.CFrame * CFrame.new(0, 3, 0))
					else
						local clickDetector = sealedKatana:FindFirstChildOfClass("ClickDetector") or sealedKatana:FindFirstChildWhichIsA("ClickDetector", true)

						if clickDetector then
							fireclickdetector(clickDetector)
						end
					end
				else
					tweenManager:topos(CFrame.new(5289, 1005, 393))
				end
			end
		end, isSea3)

		fn28("AutoRengoku", function()
			if utilities:CheckMon("Awakened Ice Admiral") then
				local enemies2 = utilities:GetEnemies({ "Awakened Ice Admiral" })
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
			end

			if utilities:CheckToolName("Hidden Key") then
				if localPlayer:DistanceFromCharacter(CFrame.new(6571, 299, -6968).Position) > 2 then
					tweenManager:topos(CFrame.new(6571, 299, -6968))
				else
					utilities:EquipTool("Hidden Key")
				end
			elseif utilities:CheckToolName("Library Key") then
				if localPlayer:DistanceFromCharacter(CFrame.new(6373, 293, -6839).Position) > 2 then
					tweenManager:topos(CFrame.new(6571, 299, -6968))
				else
					utilities:EquipTool("Library Key")
				end
			else
				local enemies2 = utilities:GetEnemies({ "Arctic Warrior", "Snow Lurker" })
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				utilities:MobsNextSpawn("Arctic Warrior")
			end
		end, isSea2)

		fn28("AutoUnlockSaber", function()
			if data.Level.Value >= 200 then
				if v2.Map.Jungle.Final.Part.CanCollide then
					if v2.Map.Jungle.QuestPlates.Door.CanCollide then
						local v22 = next
						local children, v23 = v2.Map.Jungle.QuestPlates:GetChildren()

						for _, v24 in v22, children, v23 do
							if v24:FindFirstChild("Button") and v24.Button:FindFirstChild("TouchInterest") then
								tweenManager:topos(v24.Button.CFrame)
							end
						end
					elseif not v2.Map.Desert.Burn.Part.CanCollide then
						if mods:FireInvoke("ProQuestProgress", "RichSon") ~= 0 and mods:FireInvoke("ProQuestProgress", "RichSon") ~= 1 then
							if not utilities:CheckToolName("Cup") then
								if (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(1112, 5, 4365).Position).Magnitude < 5 then
									tweenManager:topos(CFrame.new(1114, 8, 4365))
									firetouchinterest(v2.Map.Desert.Cup, localPlayer.Character.HumanoidRootPart, 0)
									firetouchinterest(v2.Map.Desert.Cup, localPlayer.Character.HumanoidRootPart, 1)
									return
								end

								tweenManager:topos(CFrame.new(1112, 5, 4365))
							else
								utilities:EquipTool("Cup")

								if utilities:CheckToolName("Cup") and utilities:CheckToolName("Cup").Handle:FindFirstChild("TouchInterest") then
									mods:FireInvoke("ProQuestProgress", "FillCup", localPlayer.Character:FindFirstChild("Cup"))
									mods:FireInvoke("ProQuestProgress", "SickMan")
								end
							end
						elseif mods:FireInvoke("ProQuestProgress", "RichSon") == 0 then
							local enemies2 = utilities:GetEnemies("Mob Leader")
							if enemies2 then
								return subFunction:Attack(enemies2)
							end
						elseif mods:FireInvoke("ProQuestProgress", "RichSon") == 1 then
							if not utilities:CheckToolName("Relic") then
								if (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(-1404, 30, 5)).Magnitude > 8 then
									tweenManager:topos(CFrame.new(-1404, 30, 5))
								else
									mods:FireInvoke("ProQuestProgress", "RichSon")
								end
							else
								utilities:EquipTool("Relic")
								tweenManager:topos(CFrame.new(-1405, 30, 5))
							end
						end
					elseif not utilities:CheckToolName("Torch") and v2.Map.Desert.Burn.Part.CanCollide then
						tweenManager:topos(v2.Map.Jungle.Torch.CFrame)
					else
						utilities:EquipTool("Torch")

						if (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(1115, 5, 4349).Position).Magnitude < 5 then
							tweenManager:topos(CFrame.new(1115, 5, 4351))
							firetouchinterest(localPlayer.Character.Torch.Handle, v2.Map.Desert.Burn.Fire, 0)
							firetouchinterest(localPlayer.Character.Torch.Handle, v2.Map.Desert.Burn.Fire, 1)
							return
						end

						tweenManager:topos(CFrame.new(1115, 5, 4349))
					end
				else
					local enemies2 = utilities:GetEnemies("Saber Expert")
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
				end
			end
		end, flag)

		fn28("AutoBartiloQuest", function()
			if level.Value >= 850 then
				if mods:FireInvoke("BartiloQuestProgress", "Bartilo") == 0 then
					if VerifyQuest("Swan Pirates") and VerifyQuest("50") and localPlayer.PlayerGui.Main.Quest.Visible then
						local enemies2 = utilities:GetEnemies("Swan Pirate")
						if enemies2 then
							return subFunction:Attack(enemies2, true)
						end
						utilities:MobsNextSpawn("Swan Pirate")
					elseif (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(-456.28952, 73.0200958, 299.895966).Position).Magnitude > 8 then
						tweenManager:topos(CFrame.new(-456.28952, 73.0200958, 299.895966))
					else
						mods:FireInvoke("StartQuest", "BartiloQuest", 1)
					end
				elseif mods:FireInvoke("BartiloQuestProgress", "Bartilo") == 1 then
					if utilities:CheckMon("Jeremy") then
						local enemies2 = utilities:GetEnemies("Jeremy")
						if enemies2 then
							return subFunction:Attack(enemies2)
						end
					else
						mods:SendNotify("Bartilo Quest", "boss jeremy, not spawned", 8)
					end
				elseif mods:FireInvoke("BartiloQuestProgress", "Bartilo") == 2 then
					if (localPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1835.65, 10.4325, 1679.75)).Magnitude > 100 then
						tweenManager:topos(CFrame.new(-1835.65, 10.4325, 1679.75))
					else
						localPlayer.Character.HumanoidRootPart.CFrame = map.Dressrosa.BartiloPlates[gameData:PlatesBartilo()].CFrame
						task.wait()
						firetouchinterest(map.Dressrosa.BartiloPlates[gameData:PlatesBartilo()], localPlayer.Character.HumanoidRootPart, 0)
						firetouchinterest(map.Dressrosa.BartiloPlates[gameData:PlatesBartilo()], localPlayer.Character.HumanoidRootPart, 1)
					end
				elseif mods:FireInvoke("BartiloQuestProgress", "Bartilo") == 3 then
					mods:SendNotify("Bartilo Quest", "Quest Completed", 8)
				end
			end
		end, isSea2)

		fn28("AutoGetDBV2", function()
			if data.Value < 350 and localPlayer:GetAttribute("YoruEvolution") then
				return nil
			end
			local IndraTalk = mods:FireInvoke("IndraTalk")
			local RobotTalk = mods:FireInvoke("RobotTalk")

			if RobotTalk == 3 or RobotTalk == 4 then
				if localPlayer:DistanceFromCharacter(Vector3.new(1421, 87, -1281)) > 5 then
					tweenManager:topos(CFrame.new(1421, 87, -1281))
				else
					mods:FireInvoke("IndraTalk")

					if IndraTalk == 0 then
						local tbl17 = {}
						local cframe = CFrame.new(1002, 6, -1354)
						local cframe2 = CFrame.new(-4941, 719, -2650)
						local cframe3 = CFrame.new
						tbl17[1] = cframe
						tbl17[2] = cframe2

						do
							local values = table.pack(cframe3(-5232, 26, 4395))
							table.move(values, 1, values.n, 3, tbl17)
						end

						for i = 1, 3 do
							tweenManager:topos(tbl17[i])
							mods:FireInvoke("LoveLetter", i)
							task.wait(0.5)
						end
					else
						tweenManager:topos(CFrame.new(-1037, 10, 1800))
						mods:FireInvoke("RobotTalk")
					end
				end
			end
		end, flag)

		local function fn29()
			local GuitarPuzzleProgress = mods:FireInvoke("GuitarPuzzleProgress", "Check")

			if GuitarPuzzleProgress and GuitarPuzzleProgress.Pipes then
				if not config.IgnoreMaterialFarmGuitar then
					if utilities:CheckInventory("Material", "Ectoplasm") < 250 then
						if not isSea2 then
							mods:FireInvoke("TravelDressrosa")
							return
						end
						local enemies2 = utilities:GetEnemies({ "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer" })
						if enemies2 then
							return subFunction:Attack(enemies2, true)
						end
						return utilities:MobsNextSpawn("Ship Deckhand")
					end

					if utilities:CheckInventory("Material", "Dark Fragment") < 1 then
						if not isSea2 then
							mods:FireInvoke("TravelDressrosa")
						else
							if utilities:CheckMon("Darkbeard") then
								local enemies2 = utilities:GetEnemies("Darkbeard")
								if enemies2 then
									return subFunction:Attack(enemies2)
								end
								return utilities:MobsNextSpawn("Darkbeard")
							end

							if utilities:CheckToolName("Fist of Darkness") then
								utilities:EquipTool("Fist of Darkness")
								return tweenManager:topos(CFrame.new(3777, 14, -3499))
							end
							joinAPI("Darkbeard", 5)
						end

						return
					end
				end
			end

			if level.Value < 2300 or LightingSvc:GetAttribute("MoonPhase") ~= 5 then
				return nil
			end

			if GuitarPuzzleProgress then
				local pipes = GuitarPuzzleProgress.Pipes
				local swamp = GuitarPuzzleProgress.Swamp
				local trophies = GuitarPuzzleProgress.Trophies
				local gravestones = GuitarPuzzleProgress.Gravestones
				local ghost = GuitarPuzzleProgress.Ghost

				if pipes then
					if localPlayer:DistanceFromCharacter(Vector3.new(-9680, 6, 6346)) < 5 then
						mods:FireInvoke("soulGuitarBuy", true)
					else
						tweenManager:topos(CFrame.new(-9680, 6, 6346))
					end

					return true
				end

				if not swamp then
					local enemies2 = utilities:GetEnemies("Living Zombie")
					if enemies2 then
						return subFunction:Attack(enemies2, true)
					end
					return utilities:MobsNextSpawn("Living Zombie")
				end

				if not gravestones then
					if localPlayer:DistanceFromCharacter(Vector3.new(-8800, 178, 6033)) > 10 then
						tweenManager:topos(CFrame.new(-8800, 178, 6033))
					else
						for k, v22 in pairs({
							Placard1 = "Right",
							Placard2 = "Right",
							Placard3 = "Left",
							Placard4 = "Right",
							Placard5 = "Left",
							Placard6 = "Left",
							Placard7 = "Left",
						}) do
							local clickDetector = map["Haunted Castle"][k][v22]:FindFirstChild("ClickDetector")

							if clickDetector then
								fireclickdetector(clickDetector)
							end
						end
					end
				elseif not ghost then
					if localPlayer:DistanceFromCharacter(Vector3.new(-9758, 270, 6291)) > 10 then
						tweenManager:topos(CFrame.new(-9758, 270, 6291))
					else
						mods:FireInvoke("GuitarPuzzleProgress", "Ghost")
						mods:FireInvoke("GuitarPuzzleProgress", "Ghost", true)
						task.wait(0.1)
						mods:FireInvoke("GuitarPuzzleProgress", "Check")
					end
				elseif not trophies then
					if localPlayer:DistanceFromCharacter(Vector3.new(-9529, 6, 6039)) > 10 then
						tweenManager:topos(CFrame.new(-9529, 6, 6039))
					else
						local tbl17 = {
							Segment1 = "Trophy1",
							Segment3 = "Trophy2",
							Segment4 = "Trophy3",
							Segment7 = "Trophy4",
							Segment10 = "Trophy5",
						}

						for _, v22 in pairs({ "Segment6", "Segment2", "Segment8", "Segment9", "Segment5" }) do
							local v23 = map["Haunted Castle"].Tablet[v22]

							if v23.Line.Rotation.Z ~= 0 then
								repeat
									task.wait()
									fireclickdetector(v23.ClickDetector)
								until v23.Line.Rotation.Z == 0
							end
						end

						for k, v22 in pairs(tbl17) do
							local v23 = tostring(map["Haunted Castle"].Trophies.Quest[v22].Handle.CFrame):split(", ")[4]
							local flag4 = v23 == "1" or v23 == "-1"
							local str5 = "180"

							if flag4 then
								str5 = "90"
							end

							if not string.find(tostring(map["Haunted Castle"].Tablet[k].Line.Rotation.Z), str5) then
								repeat
									task.wait()
									fireclickdetector(map["Haunted Castle"].Tablet[k].ClickDetector)
								until string.find(tostring(map["Haunted Castle"].Tablet[k].Line.Rotation.Z), str5)
							end
						end
					end
				elseif not pipes then
					if localPlayer:DistanceFromCharacter(Vector3.new(-9576, 6, 6230)) > 10 then
						tweenManager:topos(CFrame.new(-9576, 6, 6230))
					else
						for k, v22 in pairs({
							Part1 = "Really black",
							Part2 = "Really black",
							Part3 = "Dusty Rose",
							Part4 = "Storm blue",
							Part5 = "Really black",
							Part6 = "Parsley green",
							Part7 = "Really black",
							Part8 = "Dusty Rose",
							Part9 = "Really black",
							Part10 = "Storm blue",
						}) do
							pcall(function()
								local v23 = map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[k]

								if v23.BrickColor.Name ~= v22 then
									repeat
										task.wait()
										fireclickdetector(v23.ClickDetector)
									until v23.BrickColor.Name == v22
								end
							end)
						end
					end
				end

				return true
			end

			if localPlayer:DistanceFromCharacter(Vector3.new(-8654, 141, 6169)) < 10 then
				mods:FireInvoke("gravestoneEvent", 2, true)
			else
				tweenManager:topos(CFrame.new(-8654, 141, 6169))
			end

			return true
		end

		fn28("AutoGetSkullGuitar", fn29, isSea3 or isSea2)
		local n3 = 0

		fn28("AutoChest", function()
			local v22 = gameData:DetectChest()

			if v22 then
				if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character.Humanoid.Sit == true then
					localPlayer.Character.Humanoid.Sit = false
				end

				tweenManager:topos(v22.CFrame * CFrame.new(0, 3, 2))
				n3 += 1
				task.wait(0.1)
			elseif config.AutoHopChest or config.HopIfNoChest then
				if n3 >= (tonumber(config.ChestHopCount) or 10) or not v22 then
					n3 = 0
					local n4 = config and tonumber(config.HopDelay) or 10

					if mods and mods.SendNotify then
						local min = math.min
						mods:SendNotify("Chest Farm", "Target chests reached or no chests found. Hopping in " .. tostring(math.floor(n4)) .. "s...", min(math.floor(n4), 5))
					end

					utilities:ServerHop(n4)
					task.wait(n4 + 5)
				end
			end

			if config.StopChest or config.StopHopChestIfChalice then
				if utilities:CheckToolName("God's Chalice") or utilities:CheckToolName("Fist of Darkness") or utilities:CheckToolName("Sweet Chalice") then
					config.AutoChest = false
					config.AutoHopChest = false
				end
			end
		end, true)

		fn28("AutoFactoryRaid", function()
			if utilities:CheckMon("Core") then
				local enemies2 = utilities:GetEnemies("Core")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
			end
		end, isSea2)

		fn28("AutoFarmPirateRaid", function()
			local v22 = nil

			for _, child in pairs(v2.Enemies:GetChildren()) do
				if child.Name ~= "rip_indra True Form" then
					local humanoid2 = child:FindFirstChild("Humanoid")

					if humanoid2 and humanoid2.Health > 0 then
						if child and child.PrimaryPart and (child.PrimaryPart.Position - Vector3.new(-5556, 314, -2988)).Magnitude < 700 then
							v22 = child
						end
					end
				end
			end

			if v22 then
				return subFunction:Attack(v22, true)
			end
		end, isSea3)

		fn28("AutoSoulReaper", function()
			local enemies2 = utilities:GetEnemies("Soul Reaper")
			if enemies2 then
				return subFunction:Attack(enemies2)
			end

			if utilities:CheckToolName("Hallow Essence") then
				utilities:EquipTool("Hallow Essence")
				return tweenManager:topos(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
			end
		end, isSea3)

		fn28("AutoGreybeard", function()
			if utilities:CheckMon("Greybeard") then
				local enemies2 = utilities:GetEnemies("Greybeard")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
			end
		end, flag)

		fn28("AutoDarkbeard", function()
			if utilities:CheckMon("Darkbeard") then
				local enemies2 = utilities:GetEnemies("Darkbeard")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
			end

			if utilities:CheckToolName("Fist of Darkness") then
				utilities:EquipTool("Fist of Darkness")
				return tweenManager:topos(CFrame.new(3777, 14, -3499))
			end
		end, isSea2)

		fn28("AutoCursedCaptain", function()
			if utilities:CheckMon("Cursed Captain") then
				local enemies2 = utilities:GetEnemies("Cursed Captain")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
			end
		end, isSea2)

		fn28("AutoRipIndra", function()
			if utilities:CheckMon("rip_indra True Form") then
				local enemies2 = utilities:GetEnemies("rip_indra True Form")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end

				if utilities:CheckToolName("God's Chalice") then
					utilities:EquipTool("God's Chalice")
					return tweenManager:topos(CFrame.new(-5561, 314, -2663))
				end
				return
			end

			return tweenManager:topos(CFrame.new(-5333, 424, -2673))
		end, isSea3)

		fn28("AutoFarmObservation", function()
			if not v5:HasTag(localPlayer.Character, "Ken") then
				return nil
			end

			if localPlayer:GetAttribute("KenDodgesLeft") > 1 then
				remotes.CommE:FireServer("Ken", true)
			end

			local visionRadius = localPlayer:FindFirstChild("VisionRadius")
			local attribute2 = localPlayer:GetAttribute("KenMaxDodges") or 8
			local attribute3 = localPlayer:GetAttribute("KenDodgesLeft") or 0

			if visionRadius and not (attribute3 <= 0) then
				local enemies2, cframe

				if flag then
					enemies2 = utilities:GetEnemies({ "Galley Captain" })
					cframe = CFrame.new(5533, 88, 4852)
				elseif isSea2 then
					enemies2 = utilities:GetEnemies({ "Lava Pirate" })
					cframe = CFrame.new(-5478, 16, -5247)
				else
					enemies2 = nil
					cframe = nil

					if isSea3 then
						enemies2 = utilities:GetEnemies({ "Venomous Assailant" })
						cframe = CFrame.new(4731.2719, 1090.178, 1078.1713)
					end
				end

				if enemies2 and enemies2:FindFirstChild("HumanoidRootPart") then
					if attribute3 >= 1 then
						tweenManager:topos(enemies2.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0), true)
					else
						tweenManager:topos(enemies2.HumanoidRootPart.CFrame * CFrame.new(0, 50, 10), true)

						if attribute3 == 0.5 and config.StartObsHop then
							RS.__ServerBrowser:InvokeServer("teleport", RS.__ServerBrowser:InvokeServer("getjob"))
						end
					end

					if attribute3 <= 0.5 then
						remotes.CommE:FireServer("Ken", true)
						mods:SendNotify("Observation", "Dodges low! (" .. attribute3 .. "/" .. attribute2 .. ")", 10)
					end
				else
					tweenManager:topos(cframe, true)
				end
			else
				mods:SendNotify("Observation", "Max Vision reached!", 10)
			end
		end, true)

		fn28("DummyTraining", function()
			if not VerifyQuest("Training Dummy") and not localPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then
				return mods:FireInvoke("ArenaTrainer")
			end
			local enemies2 = utilities:GetEnemies("Training Dummy")
			if enemies2 then
				return subFunction:Attack(enemies2)
			end
			utilities:MobsNextSpawn("Training Dummy")
		end, isSea3)

		fn28("AutoStartRaceV2", function()
			if not data.Race:FindFirstChild("Evolved") then
				local Alchemist = mods:FireInvoke("Alchemist", "1")

				if Alchemist == 0 or Alchemist == 2 then
					if localPlayer:DistanceFromCharacter(Vector3.new(-2777, 73, -3570)) <= 4 then
						mods:FireInvoke("Alchemist", Alchemist == 0 and "2" or "3")
					else
						tweenManager:topos(CFrame.new(-2777, 73, -3570))
					end
				elseif Alchemist == 1 then
					local tbl17 = { "Flower 1", "Flower 2", "Flower 3" }

					for i, v22 in ipairs(tbl17) do
						if not utilities:CheckToolName(v22) then
							if i == 3 then
								local flower1 = v2:FindFirstChild("Flower1")
								local flower2 = v2:FindFirstChild("Flower2")
								local flag4 = (not flower1 or flower1.Transparency == 1) and (not flower2 or flower2.Transparency == 1)

								if utilities:CheckToolName("Flower 1") and utilities:CheckToolName("Flower 2") or flag4 then
									local enemies2 = utilities:GetEnemies("Swan Pirate")

									if enemies2 then
										subFunction:Attack(enemies2, true)
									else
										utilities:MobsNextSpawn("Swan Pirate")
									end

									return
								end

								continue
							end

							local v23 = v2:FindFirstChild("Flower" .. i)

							if v23 and v23.Transparency ~= 1 then
								tweenManager:topos(v23.CFrame)
								task.wait(0.5)
								return
							end

							local flag4 = false

							for i2 = i + 1, 2 do
								if not utilities:CheckToolName(tbl17[i2]) then
									local v24 = v2:FindFirstChild("Flower" .. i2)
									if v24 and v24.Transparency ~= 1 then
										flag4 = true
										break
									end
								end
							end

							if not flag4 then
								tweenManager:topos(CFrame.new(-382, 73, 290))
								mods:SendNotify("Race V1-V2 Quest", "Waiting for night time", 8)
								return
							end
						end
					end
				end
			end
		end, isSea2)

		fn28("AutoStartRaceV3", function()
			if not data.Race:FindFirstChild("Evolved") then
				return nil
			end
			local Wenlocktoad = mods:FireInvoke("Wenlocktoad", "1")

			if Wenlocktoad == 0 or Wenlocktoad == 2 then
				if localPlayer:DistanceFromCharacter(Vector3.new(-1992, 125, -73)) <= 4 then
					mods:FireInvoke("Wenlocktoad", Wenlocktoad == 0 and "2" or "3")
				else
					tweenManager:topos(Vector3.new(-1992, 125, -73))
				end
			elseif Wenlocktoad == 1 then
				if data.Race.Value == "Mink" then
					functions.AutoChest.Call()
				elseif data.Race.Value == "Human" then
					if checkv3boss() then
						local enemies2 = utilities:GetEnemies({ "Diamond", "Orbitus", "Jeremy" })
						if enemies2 then
							return subFunction:Attack(enemies2)
						end
					else
						tweenManager:topos(CFrame.new(-382, 73, 290))
						mods:SendNotify("Human V3 Quest", "Diamond, Orbitus, or Jeremy not currently spawned.", 8)
					end
				elseif data.Race.Value == "Ghoul" then
					local huge = math.huge
					local v22 = nil

					for _, child in pairs(v3:GetChildren()) do
						if child.Name ~= localPlayer.Name and not child:GetAttribute("IslandRaiding") and not child:GetAttribute("PvpDisabled") then
							local v23 = v2.Characters:FindFirstChild(child.Name)

							if v23 then
								local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart")
								local humanoid2 = v23:FindFirstChildOfClass("Humanoid")

								if humanoidRootPart3 and humanoid2 and humanoid2.Health > 0 then
									local n4 = child.Data.Level.Value - localPlayer.Data.Level.Value

									if n4 < 500 and n4 > -500 then
										if not fn23(v23) then
											local magnitude = (humanoidRootPart3.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude

											if magnitude < huge then
												huge = magnitude
												v22 = humanoidRootPart3
											end
										end
									end
								end
							end
						end
					end

					if v22 then
						local parent = v22.Parent
						local humanoid2 = parent:FindFirstChildOfClass("Humanoid")

						while true do
							task.wait()
							utilities:AutoHaki()
							utilities:EquipWeapon()
							tweenManager:topos(v22.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(-0.78539816339744828, 0, 0), true)

							if v22.Parent and humanoid2 and humanoid2.Health > 0 then
								AimbotTargetInstance = parent
								position = v22.Position
								fn14()
								if not (not config.AutoStartRaceV3 or not humanoid2 or humanoid2.Health <= 0 or not v22.Parent) then
									continue
								end
							else
								AimbotTargetInstance = nil
								position = nil
								break
							end

							break
						end

						AimbotTargetInstance = nil
						position = nil
					end
				elseif data.Race.Value == "Skypiea" then
					local huge = math.huge
					local v22 = nil

					for _, child in pairs(v3:GetChildren()) do
						if child.Name ~= localPlayer.Name and not child:GetAttribute("IslandRaiding") and not child:GetAttribute("PvpDisabled") and tostring(child.Data.Race.Value) == "Skypiea" then
							local v23 = v2.Characters:FindFirstChild(child.Name)

							if v23 then
								local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart")
								local humanoid2 = v23:FindFirstChildOfClass("Humanoid")

								if humanoidRootPart3 and humanoid2 and humanoid2.Health > 0 then
									local n4 = child.Data.Level.Value - localPlayer.Data.Level.Value

									if n4 < 500 and n4 > -500 then
										if not fn23(v23) then
											local magnitude = (humanoidRootPart3.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude

											if magnitude < huge then
												huge = magnitude
												v22 = humanoidRootPart3
											end
										end
									end
								end
							end
						end
					end

					if v22 then
						local parent = v22.Parent
						local humanoid2 = parent:FindFirstChildOfClass("Humanoid")

						while true do
							task.wait()
							utilities:AutoHaki()
							utilities:EquipWeapon()
							tweenManager:topos(v22.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(-0.78539816339744828, 0, 0), true)

							if v22.Parent and humanoid2 and humanoid2.Health > 0 then
								AimbotTargetInstance = parent
								position = v22.Position
								fn14()
								if not (not config.AutoStartRaceV3 or not humanoid2 or humanoid2.Health <= 0 or not v22.Parent) then
									continue
								end
							else
								AimbotTargetInstance = nil
								position = nil
								break
							end

							break
						end

						AimbotTargetInstance = nil
						position = nil
					end
				else
					mods:SendNotify("Supports Rabbit/Human/Sky V3", "wait for me to update all v3, love from flazhy...", 8)
				end
			end
		end, isSea2)

		local function fn30()
			if config.Autostopraid then
				if fragments.Value >= (tonumber(config.FragsCap) or 10000) then
					mods._AutoRaidToggle.Update(false)
					return
				end
			end

			if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and localPlayer:GetAttribute("IslandRaiding") then
				local tbl17 = {}

				for _, child in ipairs(v2.Enemies:GetChildren()) do
					if child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 and localPlayer:DistanceFromCharacter(child.HumanoidRootPart.Position) < 500 then
						table.insert(tbl17, child)
					end
				end

				if #tbl17 > 0 then
					local currentRaidIslandIndex = gameData:GetCurrentRaidIslandIndex()

					if config.InstantKillLateIslands and currentRaidIslandIndex and (currentRaidIslandIndex == 4 or currentRaidIslandIndex == 5) then
						fn19(tbl17)
						task.wait(0.2)
					else
						local v22 = tbl17[1]

						if v22 then
							subFunction:Attack(v22, true)
						end
					end
				else
					local raidIslands = gameData:GetRaidIslands()

					if raidIslands then
						tweenManager:topos(CFrame.new(raidIslands.Position + Vector3.new(0, 80, 0)), true)
					end
				end
			end

			if utilities:CheckToolName("Special Microchip") and not localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not gameData:GetRaidIslands() and not localPlayer:GetAttribute("IslandRaiding") then
				if isSea2 then
					tweenManager:topos(CFrame.new(Vector3.new(-6522, 308, -4658)))

					if (humanoidRootPart.Position - Vector3.new(-6522, 308, -4658)).Magnitude <= 5 then
						fireclickdetector(map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
					end
				elseif isSea3 then
					tweenManager:topos(CFrame.new(Vector3.new(-5073, 315, -3153)))

					if (humanoidRootPart.Position - Vector3.new(-5073, 315, -3153)).Magnitude <= 5 then
						fireclickdetector(map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
					end
				end
			elseif config.SelectRaid and config.AutoBuyChip and not utilities:CheckToolName("Special Microchip") then
				if config.AutoUnstoreBelowFruit and not utilities:Checkfruit() and not localPlayer:GetAttribute("IslandRaiding") then
					local lowestFruit = utilities:GetLowestFruit()

					if lowestFruit then
						mods:FireInvoke("LoadFruit", lowestFruit.StorageKey or lowestFruit.Name)
						task.wait(0.5)
						local v22 = utilities:Checkfruit()

						if v22 and localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
							local v23 = localPlayer.Backpack:FindFirstChild(v22)

							if v23 then
								localPlayer.Character.Humanoid:EquipTool(v23)
							end
						end
					end
				elseif not localPlayer:GetAttribute("IslandRaiding") then
					local v22 = utilities:Checkfruit()

					if v22 and localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
						local v23 = localPlayer.Backpack:FindFirstChild(v22)

						if v23 then
							localPlayer.Character.Humanoid:EquipTool(v23)
						end
					end

					mods:FireInvoke("RaidsNpc", "Select", config.SelectRaid)
					task.wait(1)
				else
					task.wait(1)
				end
			end
		end

		fn28("AutoRaidFull", fn30, isSea2 or isSea3)
		local n4 = 0

		fn28("AutoDungeonFull", function()
			local dungeon = map:FindFirstChild("Dungeon")
			if not dungeon then
				return
			end

			local function fn31()
				local position2 = humanoidRootPart.Position
				local huge = math.huge
				local v22 = nil
				local n5 = 0

				for i = 1, 100 do
					local v23 = dungeon:FindFirstChild(tostring(i))

					if v23 then
						local position3 = v23:GetPivot().Position
						local v24 = math.sqrt((position2.X - position3.X) ^ 2 + (position2.Z - position3.Z) ^ 2)
						local extentsSize = v23:GetExtentsSize()

						if v24 < math.max(extentsSize.X, extentsSize.Z) / 2 + 300 and v24 < huge then
							huge = v24
							v22 = v23
							n5 = i
						end
					end
				end

				return v22, n5
			end

			local function fn32(arg)
				local tbl17 = {}
				if not arg then
					return tbl17
				end
				local extentsSize = arg:GetExtentsSize()
				local n5 = math.max(extentsSize.X, extentsSize.Z) / 2 + 300
				local position2 = arg:GetPivot().Position

				for _, child in ipairs(v2.Enemies:GetChildren()) do
					if child:IsDescendantOf(v2) and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 and child:FindFirstChild("HumanoidRootPart") and child.Name ~= "Blank Buddy" and not string.find(string.lower(child.Name), "shadow") then
						local position3 = child.HumanoidRootPart.Position

						if math.sqrt((position2.X - position3.X) ^ 2 + (position2.Z - position3.Z) ^ 2) < n5 then
							table.insert(tbl17, child)
						end
					end
				end

				return tbl17
			end

			local position2, v22 = fn31()
			local v23 = fn32(position2)

			if config.AutoDungeonShrine and v22 == n4 then
				local dungeonProps = gameData:GetDungeonProps(position2)

				if dungeonProps then
					local position3 = dungeonProps:GetPivot().Position

					if localPlayer:DistanceFromCharacter(position3) > 10 then
						tweenManager:topos(CFrame.new(position3 + Vector3.new(0, 5, 0)), true)
					else
						fn14()
					end

					return
				end
			end

			if #v23 == 0 then
				local now2 = tick()

				while true do
					task.wait(0.5)
					position2, v22 = fn31()
					v23 = fn32(position2)
					if not (#v23 > 0 or tick() - now2 > 2) then
						continue
					end
					break
				end
			end

			if #v23 > 0 then
				n4 = v22
				local v24 = v23[1]
				local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
				local position3 = v24 and v24:FindFirstChild("HumanoidRootPart") and v24.HumanoidRootPart.Position
				position2 = position2 and position2:GetPivot().Position or position3 or Vector3.zero
				local n5 = v24 and position3 and position3.Y > position2.Y + 100 and 0 or config.DoubleAttack and 20 or tool and tool.ToolTip == "Blox Fruit" and tool.Name ~= "Ice-Ice" and tool.Name ~= "Light-Light" and 20 or 30

				if v24 and v24.Parent and v24:FindFirstChild("HumanoidRootPart") then
					tweenManager:topos(CFrame.new(v24.HumanoidRootPart.Position + Vector3.new(0, n5, 0)), true)
					utilities:EquipWeapon()
					utilities:AutoHaki()
					utilities:BringEnemies(v24)
					subFunction:Attack(v24, true)
				end
			elseif v22 <= n4 then
				local dungeonIslands = gameData:GetDungeonIslands()

				if dungeonIslands and localPlayer:DistanceFromCharacter(dungeonIslands.Position) > 20 then
					tweenManager:topos(CFrame.new(dungeonIslands.Position + Vector3.new(0, 10, 0)), true)
					task.wait(1)
				end
			end
		end, true)

		fn28("AutoUnlockDifficulties", function()
			if map:FindFirstChild("Dungeon") then
				return
			end

			pcall(function()
				game.ReplicatedStorage.DungeonShared.DataRemote:InvokeServer("TryUnlockDifficulty", "Simulation", "Hard")
			end)

			pcall(function()
				game.ReplicatedStorage.DungeonShared.DataRemote:InvokeServer("TryUnlockDifficulty", "Simulation", "Challenge")
			end)

			pcall(function()
				net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockDifficulty")
			end)

			pcall(function()
				net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockNext")
			end)

			pcall(function()
				net["RF/DungeonNPCNetworkFunction"]:InvokeServer("Unlock")
			end)

			task.wait(5)
		end, true, true)

		fn28("AutoBuyTrinkets", function()
			pcall(function()
				RS.Remotes.AccessoryInteract:InvokeServer("d")
			end)

			task.wait(1.5)
		end, true, true)

		fn28("AutoFuseTrinkets", function()
			local tbl17 = {}

			local ok, result = pcall(function()
				return Net:RemoteFunction("GetAllItemValues"):InvokeServer()
			end)

			if ok and result then
				for _, v22 in next, result, nil do
					local flag4 = v22.Key == "AccessoryType" and v22.Value == "Trinket"
					local flag5

					if flag4 then
						flag5 = flag4
					else
						flag5 = v22.Key == "Type" and v22.Value == "Trinket"
					end

					if flag5 then
						if v22.NetworkedUID then
							table.insert(tbl17, v22.NetworkedUID)
						end
					end
				end
			end

			if #tbl17 >= 3 then
				pcall(function()
					RS.Remotes.AccessoryInteract:InvokeServer("a", tbl17[1], tbl17[2], tbl17[3])
				end)
			end

			task.wait(2)
		end, true, true)

		fn28("AutoRefineTrinkets", function()
			local tbl17 = {}

			local ok, result = pcall(function()
				return Net:RemoteFunction("GetAllItemValues"):InvokeServer()
			end)

			if ok and result then
				for _, v22 in next, result, nil do
					local flag4 = v22.Key == "AccessoryType" and v22.Value == "Trinket"
					local flag5

					if flag4 then
						flag5 = flag4
					else
						flag5 = v22.Key == "Type" and v22.Value == "Trinket"
					end

					if flag5 then
						if v22.NetworkedUID then
							table.insert(tbl17, v22.NetworkedUID)
						end
					end
				end
			end

			if #tbl17 >= 1 then
				pcall(function()
					RS.Remotes.AccessoryInteract:InvokeServer("c", tbl17[1])
				end)
			end

			task.wait(2)
		end, true, true)

		fn28("AutoScrapTrinkets", function()
			local tbl17 = GetPlayerTrinketUIDs and GetPlayerTrinketUIDs() or {}

			if #tbl17 > 3 then
				local tbl18 = {}

				for i = 4, math.min(#tbl17, 10) do
					table.insert(tbl18, tbl17[i])
				end

				if #tbl18 > 0 then
					pcall(function()
						RS.Remotes.AccessoryInteract:InvokeServer("b", tbl18)
					end)
				end
			end

			task.wait(3)
		end, true, true)

		fn28("AutoOpenColorsTask", function()
			if localPlayer.Character and localPlayer.Character.PrimaryPart then
				for _, v22 in next, {
					{ pos = Vector3.new(-5415, 314, -2212), color = "Pure Red" },
					{ pos = Vector3.new(-4972, 336, -3720), color = "Snow White" },
					{ pos = Vector3.new(-5420, 1089, -2667), color = "Winter Sky" },
				}, nil do
					if localPlayer:DistanceFromCharacter(v22.pos) < 5 then
						RS.Modules.Net["RF/FruitCustomizerRF"]:InvokeServer({ StorageName = v22.color, Type = "AuraSkin", Context = "Equip" })
						break
					end
				end
			end

			if not config.AutoFarm and not config.AutoFarmBones and not config.AutoFarmPrince then
				local pathButton = gameData:GetPathButton()

				if pathButton then
					tweenManager:topos(pathButton.CFrame)
				elseif not config.AutoRipIndra then
					tweenManager:topos(CFrame.new(-5119, 315, -2964))
				end
			end
		end, isSea3)

		fn28("AutoVolcanicEvent", function()
			local prehistoricIsland = map:FindFirstChild("PrehistoricIsland")
			if not prehistoricIsland then
				return
			end
			local core = prehistoricIsland:FindFirstChild("Core")
			if not core then
				return
			end
			local interiorLava = core:FindFirstChild("InteriorLava")

			if interiorLava then
				local parent = interiorLava.Parent
				interiorLava:Destroy()

				if parent and parent ~= core then
					parent:Destroy()
				end
			end

			local volcanoRocks = core:FindFirstChild("VolcanoRocks")

			if volcanoRocks and prehistoricIsland then
				for _, descendant in ipairs(prehistoricIsland:GetDescendants()) do
					local v22 = string.lower(descendant.Name)

					if v22:find("lava") or v22:find("beam") then
						pcall(function()
							descendant:Destroy()
						end)
					end
				end
			end

			local activationPrompt = core:FindFirstChild("ActivationPrompt")
			local proximityPrompt = activationPrompt and activationPrompt:FindFirstChildOfClass("ProximityPrompt")

			if proximityPrompt and proximityPrompt.Enabled then
				if localPlayer:DistanceFromCharacter(activationPrompt.CFrame.Position) <= 50 then
					fireproximityprompt(activationPrompt.ProximityPrompt, math.huge)
				else
					tweenManager:topos(activationPrompt.CFrame)
				end

				return
			end

			if utilities:CheckMon("Lava Golem") then
				local enemies2 = utilities:GetEnemies("Lava Golem")

				if enemies2 then
					local humanoidRootPart3 = enemies2:FindFirstChild("HumanoidRootPart")
					local humanoid2 = enemies2:FindFirstChildOfClass("Humanoid")

					if humanoidRootPart3 then
						humanoidRootPart3.Velocity = Vector3.zero
						humanoidRootPart3.AssemblyLinearVelocity = Vector3.zero
					end

					if humanoid2 then
						humanoid2.WalkSpeed = 0
						humanoid2.JumpPower = 0
					end

					return subFunction:Attack(enemies2, true)
				end
			end

			if volcanoRocks then
				for _, child in pairs(volcanoRocks:GetChildren()) do
					if child:FindFirstChild("VFXLayer") and child.VFXLayer.At0.Glow.Enabled == true then
						local position2 = child.VFXLayer.CFrame.Position
						local meshesVolcanoislandPlane005 = prehistoricIsland:FindFirstChild("Meshes/volcanoisland_Plane.005", true)
						local unit = meshesVolcanoislandPlane005 and (position2 - meshesVolcanoislandPlane005.Position).Unit
						local n5 = position2 + unit * 30

						if meshesVolcanoislandPlane005 and (n5 - meshesVolcanoislandPlane005.Position).Magnitude < 40 then
							local n6 = math.atan(unit.Z, unit.X) + tick() * 0.5
							n5 = position2 + Vector3.new(math.cos(n6) * 30, 5, math.sin(n6) * 30)
						end

						tweenManager:topos(CFrame.new(n5), true)

						if localPlayer:DistanceFromCharacter(position2) <= 150 then
							if config.ShootGunVolcano then
								local selectGunVolcano = config.SelectGunVolcano or "Skull Guitar"

								if not localPlayer.Character:FindFirstChild(selectGunVolcano) then
									local skullGuitar = localPlayer.Backpack:FindFirstChild(selectGunVolcano) or localPlayer.Backpack:FindFirstChild("Skull Guitar")

									if skullGuitar and localPlayer.Character:FindFirstChild("Humanoid") then
										localPlayer.Character.Humanoid:EquipTool(skullGuitar)
									else
										mods:FireInvoke("LoadItem", selectGunVolcano)
									end

									task.wait(0.2)
								end

								utilities:EquipWeapon("Gun")
								task.wait(0.15)
								customShoot(position2)
								local tool = localPlayer.Character:FindFirstChildOfClass("Tool")

								if tool and tool:FindFirstChild("RemoteEvent") then
									pcall(function()
										tool.RemoteEvent:FireServer("TAP", position2)
									end)
								end
							else
								position = position2
								fn14()
								position = nil
							end
						end

						return
					end
				end
			end

			local prehistoricRelic = core:FindFirstChild("PrehistoricRelic")
			if prehistoricRelic and prehistoricRelic:FindFirstChild("Shield") then
				tweenManager:topos(prehistoricRelic.Shield.CFrame + Vector3.new(0, 3, 0), true)
				return
			end
		end, isSea3)

		fn28("AutoWhiteBelt", function()
			if localPlayer:DistanceFromCharacter(Vector3.new(5867, 1208, 870)) <= 5 then
				net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dojo Trainer", Command = "ClaimQuest" })
				task.wait(1)
				net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dojo Trainer", Command = "RequestQuest" })
				task.wait(1)
			else
				tweenManager:topos(CFrame.new(5867, 1208, 870))
			end

			local enemies2 = utilities:GetEnemies(CheckQuest()[2])
			if enemies2 then
				return subFunction:Attack(enemies2)
			end
			utilities:MobsNextSpawn(CheckQuest()[2])
		end, isSea3)

		fn28("AutoPurpleBelt", function()
			if localPlayer:DistanceFromCharacter(Vector3.new(5867, 1208, 870)) <= 5 then
				net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dojo Trainer", Command = "ClaimQuest" })
				task.wait(1)
				net["RF/InteractDragonQuest"]:InvokeServer({ NPC = "Dojo Trainer", Command = "RequestQuest" })
				task.wait(1)
			else
				tweenManager:topos(CFrame.new(5867, 1208, 870))
			end

			functions.AutoTaskEliteHunter.Call()
		end, isSea3)

		fn28("AutoCollectBones", function()
			if localPlayer:GetAttribute("PrehistoricIslandParticipant") then
				if v2:FindFirstChild("DinoBone") then
					for _, child in pairs(v2:GetChildren()) do
						if child.Name == "DinoBone" then
							tweenManager:topos(child.CFrame)
						end
					end
				end
			end
		end, isSea3)

		fn28("AutoCollectEgg", function()
			local prehistoricIsland = map:FindFirstChild("PrehistoricIsland")

			if prehistoricIsland then
				local core = prehistoricIsland:FindFirstChild("Core")
				core = core and core:FindFirstChild("SpawnedDragonEggs")

				if core and #core:GetChildren() > 0 then
					local v22 = next
					local children, v23 = core:GetChildren()

					for _, v24 in v22, children, v23 do
						if v24.Name == "DragonEgg" then
							local molten = v24:FindFirstChild("Molten")

							if molten and molten:FindFirstChild("ProximityPrompt") then
								local proximityPrompt = molten.ProximityPrompt

								if proximityPrompt.Enabled then
									tweenManager:topos(molten.CFrame)
									fireproximityprompt(proximityPrompt)
								end
							end
						end
					end
				end
			end
		end, isSea3)

		local n5 = 1
		local now2 = tick()

		fn28("AutoQuestBlaze", function()
			local emberTemplate = v2:FindFirstChild("EmberTemplate")
			if emberTemplate and emberTemplate:FindFirstChild("Part") and emberTemplate.Part.Position.Y > 10 then
				tweenManager:topos(emberTemplate.Part.CFrame * CFrame.new(0, 3, 0), true)
				return
			end

			if not gameData.CurrentQuest or gameData:TaskDone() then
				local v22, v23, v24, v25 = gameData:CheckQuestStatus()
				gameData.CurrentQuest = v22 and { HasQuest = v22, Mobs = v23, Progress = v24, QuestType = v25 } or nil
			end

			if not gameData.CurrentQuest then
				tweenManager:topos(CFrame.new(5864, 1209, 808))
				return
			end

			if gameData.CurrentQuest.QuestType == 1 and (gameData.CurrentQuest.Mobs == "Hydra Enforcer" or gameData.CurrentQuest.Mobs == "Venomous Assailant") then
				local enemies2 = utilities:GetEnemies(gameData.CurrentQuest.Mobs)
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				utilities:MobsNextSpawn(gameData.CurrentQuest.Mobs)
			elseif gameData.CurrentQuest.QuestType == 2 then
				local tbl17 = {
					Vector3.new(5326, 1000.5, 441.52),
					Vector3.new(5344.88, 1000.5, 359.94),
					Vector3.new(5260.73, 1000.5, 345.5),
					Vector3.new(5237.99, 1000.5, 429.64),
				}

				if tick() - now2 >= 2 then
					n5 = n5 % #tbl17 + 1
					now2 = tick()
				end

				local v22 = tbl17[n5]
				local humanoidRootPart3 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart3 then
					return
				end
				local magnitude = (humanoidRootPart3.Position - v22).Magnitude
				tweenManager:topos(CFrame.new(v22 + Vector3.new(0, 15, 0)), true)
				if magnitude > 150 then
					return
				end
				local selectGunBlaze = config.SelectGunBlaze or "Skull Guitar"
				local flag4 = not localPlayer.Character:FindFirstChild(selectGunBlaze)

				if flag4 then
					flag4 = not (localPlayer.Character:FindFirstChildOfClass("Tool") and localPlayer.Character:FindFirstChildOfClass("Tool").ToolTip == "Gun")
				end

				if flag4 then
					local soulGuitar = localPlayer.Backpack:FindFirstChild(selectGunBlaze) or localPlayer.Backpack:FindFirstChild("Soul Guitar") or localPlayer.Backpack:FindFirstChild("Skull Guitar")

					if soulGuitar and localPlayer.Character:FindFirstChild("Humanoid") then
						localPlayer.Character.Humanoid:EquipTool(soulGuitar)
					else
						mods:FireInvoke("LoadItem", selectGunBlaze)
					end

					task.wait(0.05)
				end

				utilities:EquipWeapon("Gun")
				customShoot(v22)

				if not config.ShootGunBlaze then
					position = v22
					fn14()
					position = nil
				end
			end
		end, isSea3)

		fn28("AutoCollectFireFlowers", function()
			local fireFlowers = v2:FindFirstChild("FireFlowers")

			if fireFlowers then
				local children = fireFlowers:GetChildren()

				for i = 1, #children do
					local v22 = children[i]
					local primaryPart = v22:IsA("Model") and (v22.PrimaryPart or v22:FindFirstChildOfClass("MeshPart"))

					if primaryPart then
						if localPlayer:DistanceFromCharacter(primaryPart.Position) > 3 then
							tweenManager:topos(primaryPart.CFrame)
						else
							fireproximityprompt(v22.ProximityPrompt, math.huge)
							task.wait(0.5)
						end

						return
					end
				end
			end

			local enemies2 = utilities:GetEnemies("Forest Pirate")
			if enemies2 then
				return subFunction:Attack(enemies2, true)
			end
			utilities:MobsNextSpawn("Forest Pirate")
		end, isSea3)

		fn28("AutoTrainGear", function()
			if localPlayer.Character:FindFirstChild("RaceEnergy") and localPlayer.Character:FindFirstChild("RaceTransformed") then
				if localPlayer.Character.RaceEnergy.Value >= 1 and not localPlayer.Character.RaceTransformed.Value then
					localPlayer.Backpack.Awakening.RemoteFunction:InvokeServer({ true })
				end
			end

			if data.Race.Value == "Draco" then
				mods:FireInvoke("UpgradeRace", "Buy", 2)
			else
				mods:FireInvoke("UpgradeRace", "Buy")
			end

			if config.TrainMethod == "Bones" then
				local enemies2 = utilities:GetEnemies(mods.DataList.BonesList)
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				utilities:MobsNextSpawn("Reborn Skeleton")
			elseif config.TrainMethod == "Cakes" then
				local enemies2 = utilities:GetEnemies(mods.DataList.CakesList)
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				utilities:MobsNextSpawn("Baking Staff")
			end
		end, isSea3)

		fn28("TweenMGear", function()
			local mysticIsland = map:FindFirstChild("MysticIsland")

			if mysticIsland then
				local v22 = next
				local children, v23 = mysticIsland:GetChildren()

				for _, v24 in v22, children, v23 do
					if v24.Name == "Part" and v24:IsA("MeshPart") then
						tweenManager:topos(v24.CFrame)
					end
				end
			end
		end, isSea3)

		fn28("AutoGetGhoulRace", function()
			if localPlayer.Data.Race.Value == "Ghoul" then
				return nil
			end

			if utilities:CheckInventory("Material", "Ectoplasm") < 100 then
				local enemies2 = utilities:GetEnemies({ "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer" })
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				return utilities:MobsNextSpawn("Ship Deckhand")
			end

			if utilities:CheckToolName("Hellfire Torch") then
				if localPlayer:DistanceFromCharacter(Vector3.new(921, 125, 33453)) < 10 then
					mods:FireInvoke("Ectoplasm", "BuyCheck", 4)
					task.wait()
					mods:FireInvoke("Ectoplasm", "Buy", 4)
				else
					tweenManager:topos(CFrame.new(921, 125, 33453))
				end
			else
				if utilities:CheckMon("Cursed Captain") then
					local enemies2 = utilities:GetEnemies("Cursed Captain")
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
					return utilities:MobsNextSpawn("Cursed Captain")
				end

				joinAPI("CursedCaptain", 5)
			end
		end, isSea2)

		fn28("AutoGetCyborgRace", function()
			if data.Race.Value == "Cyborg" and mods:FireInvoke("CyborgTrainer", "Check") == 2 then
				return nil
			end
			local flag4 = mods:FireInvoke("CyborgTrainer", "Check") == 1
			local flag5

			if flag4 then
				flag5 = flag4
			else
				flag5 = map.CircleIsland and map.CircleIsland:FindFirstChild("RaidSummon") and map.CircleIsland.RaidSummon:FindFirstChild("Button") and map.CircleIsland.RaidSummon.Button:FindFirstChild("Main") and not map.CircleIsland.RaidSummon.Button.Main.CanCollide
			end

			if flag5 then
				if fragments.Value >= 2500 then
					mods:FireInvoke("CyborgTrainer", "Buy")
				else
					mods:SendNotify("Auto Cyborg Race", "Not enough fragments to buy Cyborg", 10)
				end

				return
			end

			local str5 = "Quantum Onyx Hub/" .. localPlayer.Name .. "CyborgRace.json"

			if isfolder and makefolder and not isfolder("Quantum Onyx Hub") then
				makefolder("Quantum Onyx Hub")
			end

			local v22 = isfile and isfile(str5)
			local result = nil

			if v22 then
				local ok
				ok, result = pcall(readfile, str5)
				ok = ok and result and result ~= ""
				local v23 = nil

				if not ok then
					result = v23
				end
			end

			local function fn31(arg)
				if writefile then
					pcall(writefile, str5, tostring(arg))
				end
			end

			if utilities:CheckToolName("Core Brain") then
				fn31("Unlocked")
				local coreBrain = localPlayer.Backpack:FindFirstChild("Core Brain") or localPlayer.Character and localPlayer.Character:FindFirstChild("Core Brain")

				if coreBrain and coreBrain.Parent == localPlayer.Backpack and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
					localPlayer.Character.Humanoid:EquipTool(coreBrain)
				end

				tweenManager:topos(CFrame.new(Vector3.new(-5544, 229, -5938)))

				if (humanoidRootPart.Position - Vector3.new(-5544, 229, -5938)).Magnitude <= 8 then
					fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
					task.wait(0.5)
				end

				return
			end

			if result == nil and not utilities:CheckToolName("Fist of Darkness") then
				tweenManager:topos(CFrame.new(Vector3.new(-5544, 229, -5938)))

				if (humanoidRootPart.Position - Vector3.new(-5544, 229, -5938)).Magnitude <= 8 then
					fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
					task.wait(0.5)

					if localPlayer.PlayerGui:FindFirstChild("Notifications") then
						for _, child in ipairs(localPlayer.PlayerGui.Notifications:GetChildren()) do
							if child:IsA("TextLabel") and child.Text and child.Text ~= "" then
								local v23 = string.lower(child.Text)

								if v23:find("core brain") or v23:find("supply a <core brain>") or v23:find("has been processed") then
									fn31("Unlocked")
									break
								elseif v23:find("microchip not found") then
									fn31("Chest")
									break
								end
							end
						end
					end
				end

				return
			end

			if localPlayer.PlayerGui:FindFirstChild("Notifications") then
				for _, child in ipairs(localPlayer.PlayerGui.Notifications:GetChildren()) do
					if child:IsA("TextLabel") and child.Text and child.Text ~= "" then
						local v23 = string.lower(child.Text)

						if v23:find("core brain") or v23:find("supply a <core brain>") or v23:find("has been processed") then
							fn31("Unlocked")
							result = "Unlocked"
						end
					end
				end
			end

			local secretLabDoors = map.CircleIsland and map.CircleIsland:FindFirstChild("SecretLabDoors")

			if not (result == "Unlocked" or secretLabDoors and secretLabDoors:FindFirstChild("colormodel") and secretLabDoors.colormodel.Color.G > secretLabDoors.colormodel.Color.R) then
				if not utilities:CheckToolName("Fist of Darkness") then
					functions.AutoChest.Call()
				else
					local fistOfDarkness = localPlayer.Backpack:FindFirstChild("Fist of Darkness") or localPlayer.Character and localPlayer.Character:FindFirstChild("Fist of Darkness")

					if fistOfDarkness and fistOfDarkness.Parent == localPlayer.Backpack and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
						localPlayer.Character.Humanoid:EquipTool(fistOfDarkness)
					end

					tweenManager:topos(CFrame.new(Vector3.new(-5544, 229, -5938)))

					if (humanoidRootPart.Position - Vector3.new(-5544, 229, -5938)).Magnitude <= 8 then
						fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
						fn31("Unlocked")
						task.wait(0.5)
					end
				end
			elseif utilities:CheckMon("Order") then
				local enemies2 = utilities:GetEnemies("Order")
				if enemies2 then
					return subFunction:Attack(enemies2)
				end
				tweenManager:topos(CFrame.new(-6300, 16, -4997))
			elseif utilities:CheckToolName("Microchip") then
				local microchip = localPlayer.Backpack:FindFirstChild("Microchip") or localPlayer.Character and localPlayer.Character:FindFirstChild("Microchip")

				if microchip and microchip.Parent == localPlayer.Backpack and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
					localPlayer.Character.Humanoid:EquipTool(microchip)
				end

				tweenManager:topos(CFrame.new(Vector3.new(-5544, 229, -5938)))

				if (humanoidRootPart.Position - Vector3.new(-5544, 229, -5938)).Magnitude <= 8 then
					fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
					task.wait(1)
				end
			elseif fragments.Value >= 1000 then
				mods:FireInvoke("BlackbeardReward", "Microchip", "2")
				task.wait(1)
			else
				mods:SendNotify("Auto Cyborg Race", "Not enough fragments to buy Microchip", 10)
			end
		end, isSea2)

		fn28("AutoLawRaid", function()
			if utilities:CheckMon("Order") then
				local enemies2 = utilities:GetEnemies("Order")

				if enemies2 then
					subFunction:Attack(enemies2)
				else
					tweenManager:topos(CFrame.new(-6300, 16, -4997))
				end

				return
			end

			if not utilities:CheckMon("Order") and not utilities:CheckToolName("Microchip") then
				mods:FireInvoke("BlackbeardReward", "Microchip", "2")
			elseif not utilities:CheckMon("Order") and utilities:CheckToolName("Microchip") then
				tweenManager:topos(CFrame.new(Vector3.new(-5544, 229, -5938)))

				if (humanoidRootPart.Position - Vector3.new(-5544, 229, -5938)).Magnitude <= 5 then
					fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
				end
			elseif not mods:FireInvoke("BlackbeardReward", "Microchip", "1") then
				mods:SendNotify("Auto Law Raid", "Not Enough Frags", 8)
			end
		end, isSea2)

		fn28("AutoBuyMelee", function()
			local v22 = melees[config.SelectMelee]

			if v22 then
				local v23 = workspace:FindFirstChild(v22.npc, true) or game:GetService("ReplicatedStorage").NPCs:FindFirstChild(v22.npc, true)
				local character2 = localPlayer.Character
				character2 = character2 and character2:FindFirstChild("HumanoidRootPart")

				if v23 and character2 then
					local humanoidRootPart3 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart or v23:FindFirstChildWhichIsA("BasePart")

					if humanoidRootPart3 then
						if (character2.Position - humanoidRootPart3.Position).Magnitude > 10 then
							tweenManager:topos(humanoidRootPart3.CFrame * CFrame.new(0, 0, -5))
							task.wait(0.5)
						elseif typeof(v22.remote[1]) == "table" then
							for k in next, v22.remote, nil do
								mods:FireInvoke(unpack(args))
							end
						else
							mods:FireInvoke(unpack(v22.remote))
						end
					end
				end
			end
		end, true)

		fn28("Auto_Fishing", function()
			local selectedRod = config.SelectedRod
			if not selectedRod then
				return
			end

			if not utilities:CheckToolName(selectedRod) then
				pcall(function()
					net:FindFirstChild("RF/JobsRemoteFunction"):InvokeServer("FishingNPC", "FirstTimeFreeRod")
				end)

				mods:FireInvoke("LoadItem", selectedRod, { "Gear" })
			end

			if config.AutoCraftBait and config.SelectedBait then
				local ok, result = pcall(function()
					return Net:RemoteFunction("GetAllItemValues"):InvokeServer()
				end)

				ok = ok and result
				local flag4 = false

				if ok then
					local tbl17 = {}

					for _, v22 in next, result, nil do
						local str5 = tostring(v22.ItemId) .. "_" .. tostring(v22.NetworkedUID)
						tbl17[str5] = tbl17[str5] or { ItemId = v22.ItemId, Attributes = {} }

						if v22.Value ~= nil then
							tbl17[str5].Attributes[v22.Key] = v22.Value
						end
					end

					for _, v22 in next, tbl17, nil do
						local ok2, result2 = pcall(function()
							return ItemConfig.match(v22.ItemId)
						end)

						ok2 = ok2 and result2 and result2:isOk()
						local str5 = nil

						if ok2 then
							local v23 = result2:unwrap()
							local debugLabel = v23 and v23.Index and v23.Index.DebugLabel
							str5 = nil

							if debugLabel then
								str5 = tostring(v23.Index.DebugLabel)
							end
						end

						local match = str5 and (str5:match("^(.-)%s*%[") or str5)
						local attributes = v22.Attributes
						local flag5 = match == config.SelectedBait and attributes.IsOwned == true

						if flag5 then
							flag5 = (attributes.Quantity or 0) > 0
						end

						if flag5 then
							mods:FireInvoke("LoadItem", match, { "Usables" })
							task.wait(0.5)
							flag4 = true
							break
						end
					end
				end

				if not flag4 then
					if net["RF/Craft"] and net["RF/Craft"]:InvokeServer("Check", config.SelectedBait) then
						net["RF/Craft"]:InvokeServer("Craft", config.SelectedBait, 1, {})
						task.wait(1.5)
						mods:FireInvoke("LoadItem", config.SelectedBait, { "Usables" })
						task.wait(0.5)
					end
				end
			end

			utilities:EquipTool(selectedRod)
			local character2 = localPlayer.Character or character
			local humanoidRootPart3 = character2 and character2:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart3 then
				return
			end
			local v22 = GetWaterHeightAtLocation(humanoidRootPart3.Position)
			local Config = require(RS.FishReplicated.FishingClient.Config)
			local maxLaunchDistance = Config and Config.Rod and Config.Rod.MaxLaunchDistance or 150
			local lookVector = humanoidRootPart3.CFrame.LookVector
			local v23, v24 = v2:FindPartOnRayWithIgnoreList(Ray.new(character2:FindFirstChild("Head") and character2.Head.Position or humanoidRootPart3.Position + Vector3.new(0, 2, 0), lookVector * maxLaunchDistance * 0.99751243781094523), { character2, v2.Characters, v2.Enemies })
			local v25, v26 = v2:FindPartOnRayWithIgnoreList(Ray.new((v24 or humanoidRootPart3.Position + lookVector * 40) + Vector3.new(0, 3, 0), Vector3.new(0, -500, 0)), { character2, v2.Characters, v2.Enemies })
			config.LastCastLocation = Vector3.new(v24 and v24.X or (humanoidRootPart3.Position + lookVector * 40).X, math.max(v26 and v26.Y or v22, v22), v24 and v24.Z or (humanoidRootPart3.Position + lookVector * 40).Z)
			local v27 = character2:FindFirstChild(selectedRod)
			if not v27 then
				return
			end
			local attribute2 = v27:GetAttribute("ServerState")
			local attribute3 = v27:GetAttribute("State")
			local fishingReeling = localPlayer.PlayerGui:FindFirstChild("Fishing_Reeling")
			local flag4 = attribute2 == "Biting" or attribute3 == "Biting"

			if fishingReeling and fishingReeling.Enabled then
				local minigame = fishingReeling:FindFirstChild("Minigame")
				minigame = minigame and minigame:FindFirstChild("Container")
				local reelZone = minigame and minigame:FindFirstChild("ReelZone")
				local fish = minigame and minigame:FindFirstChild("Fish")
				minigame = minigame and minigame:FindFirstChild("Treasure")
				fish = config.AutoGetChest and minigame and minigame.Visible and minigame or fish

				if reelZone and fish and fish.Visible then
					local n6 = fish.Position.X.Scale + fish.Size.X.Scale * 0.5 - reelZone.Position.X.Scale + reelZone.Size.X.Scale * 0.5

					if n6 > 0.03 then
						v8:SendMouseButtonEvent(0, 0, 0, true, game, 1)
					elseif n6 < -0.03 then
						v8:SendMouseButtonEvent(0, 0, 0, false, game, 1)
					else
						v8:SendMouseButtonEvent(0, 0, 0, true, game, 1)
						task.wait(0.02)
						v8:SendMouseButtonEvent(0, 0, 0, false, game, 1)
					end
				else
					v8:SendMouseButtonEvent(0, 0, 0, true, game, 1)
					task.wait(0.05)
					v8:SendMouseButtonEvent(0, 0, 0, false, game, 1)
				end

				local fishingRequest = RS:FindFirstChild("FishReplicated") and RS.FishReplicated:FindFirstChild("FishingRequest")

				if fishingRequest then
					if config.AutoGetChest then
						pcall(function()
							fishingRequest:InvokeServer("Catch", 1, 1)
						end)
					else
						pcall(function()
							fishingRequest:InvokeServer("Catch", 1)
						end)
					end
				end
			elseif flag4 then
				v8:SendMouseButtonEvent(0, 0, 0, true, game, 1)
				task.wait(0.08)
				v8:SendMouseButtonEvent(0, 0, 0, false, game, 1)
				task.wait(0.15)
			elseif attribute3 == "ReeledIn" or attribute2 == "ReeledIn" or not attribute2 or attribute2 == "Waiting" then
				v8:SendMouseButtonEvent(0, 0, 0, true, game, 1)
				local now3 = tick()

				while true do
					task.wait(0.015)
					local fishingCastMeter = localPlayer.Character and localPlayer.Character:FindFirstChild("Fishing_Cast Meter") or v2:FindFirstChild("Fishing_Cast Meter")
					local bar = fishingCastMeter and fishingCastMeter:FindFirstChild("CastMeter") and fishingCastMeter.CastMeter:FindFirstChild("Bar")
					local frame = bar and bar:FindFirstChild("Frame")

					if not (frame and frame.Size.Y.Scale >= 0.95) then
						if not (tick() - now3 >= 1.2) then
							continue
						end
					end

					break
				end

				v8:SendMouseButtonEvent(0, 0, 0, false, game, 1)
				task.wait(0.3)
			end
		end, true)

		local n6 = 0

		fn28("AutoSlap", function()
			local fishSlapMinigame = localPlayer.PlayerGui:FindFirstChild("FishSlapMinigame")

			if fishSlapMinigame and fishSlapMinigame.Enabled then
				local bar = fishSlapMinigame:FindFirstChild("Bar")
				local greenZone = bar and bar:FindFirstChild("GreenZone")
				bar = bar and bar:FindFirstChild("Tick")
				local slapButton = fishSlapMinigame:FindFirstChild("SlapButton")

				if greenZone and bar and slapButton and tick() - n6 >= 0.1 then
					local n7 = bar.AbsolutePosition.Y + bar.AbsoluteSize.Y * 0.5
					local n8 = greenZone.AbsoluteSize.Y * 0.45

					if math.abs(n7 - greenZone.AbsolutePosition.Y + greenZone.AbsoluteSize.Y * 0.5) <= n8 then
						n6 = tick()

						if firesignal then
							firesignal(slapButton.Activated)
						end
					end
				end
			end
		end, true)

		fn28("AutoMasterySwords", function()
			local ok, result = pcall(function()
				return Net:RemoteFunction("GetAllItemValues"):InvokeServer()
			end)

			if not ok or not result then
				return
			end
			local tbl17 = {}

			for _, v22 in next, result, nil do
				local str5 = tostring(v22.ItemId) .. "_" .. tostring(v22.NetworkedUID)
				tbl17[str5] = tbl17[str5] or { ItemId = v22.ItemId, Attributes = {} }

				if v22.Value ~= nil then
					tbl17[str5].Attributes[v22.Key] = v22.Value
				end
			end

			local tbl18 = {}

			for _, v22 in next, tbl17, nil do
				local attributes = v22.Attributes

				if attributes.IsOwned == true and attributes.Mastery ~= nil then
					local ok2, result2 = pcall(function()
						return ItemConfig.match(v22.ItemId)
					end)

					if ok2 and result2 and result2:isOk() then
						local str5 = tostring(result2:unwrap().Index.DebugLabel)
						local match = str5:match("^(.-)%s*%[") or str5
						local v23 = swordData[match]

						if v23 then
							table.insert(tbl18, { Name = match, Mastery = attributes.Mastery, Order = v23.Order })
						end
					end
				end
			end

			table.sort(tbl18, function(arg, arg2)
				if arg.Order == arg2.Order then
					return arg.Mastery < arg2.Mastery
				end
				return arg.Order < arg2.Order
			end)

			for _, v22 in next, tbl18, nil do
				if utilities:CheckToolName(v22.Name) then
					if v22.Mastery < config.SelectSwordMastery then
						return
					end
				end
			end

			for _, v22 in next, tbl18, nil do
				if v22.Mastery < config.SelectSwordMastery then
					if not utilities:CheckToolName(v22.Name) then
						mods:FireInvoke("LoadItem", v22.Name)
						task.wait(0.5)
					end

					return
				end
			end
		end, true, true)

		local n7 = 0
		local n8 = 1
		local n9 = 0
		local tbl17 = {}
		local cframe = CFrame.new(-4602, 16, -2881)
		local cframe2 = CFrame.new(-6126, 16, -2250)
		local cframe3 = CFrame.new(3911, 7, -2582)
		local cframe4 = CFrame.new
		tbl17[1] = cframe
		tbl17[2] = cframe2
		tbl17[3] = cframe3

		do
			local values = table.pack(cframe4(-426, 11, 5301))
			table.move(values, 1, values.n, 4, tbl17)
		end

		fn28("AutoCDKQuest", function()
			local v22 = mods:CDKProgress()

			if v22 == "Start Yama" then
				if not utilities:CheckToolName("Yama") then
					mods:FireInvoke("LoadItem", "Yama")
				end

				local cursed = map:FindFirstChild("Turtle") and map.Turtle:FindFirstChild("Cursed")
				local pedestal2 = cursed and cursed:FindFirstChild("Pedestal2")

				if pedestal2 then
					if localPlayer:DistanceFromCharacter(pedestal2.Position) <= 12 then
						if pedestal2:FindFirstChild("ProximityPrompt") and pedestal2.ProximityPrompt.Enabled then
							fireproximityprompt(pedestal2.ProximityPrompt, math.huge)
						end

						mods:FireInvoke("CDKQuest", "StartTrial", "Evil")
						task.wait(0.5)
					else
						tweenManager:topos(pedestal2.CFrame)
					end
				else
					mods:FireInvoke("CDKQuest", "StartTrial", "Evil")
					tweenManager:topos(CFrame.new(-12391.56, 600.24, -6500.53))
				end
			elseif v22 == "Pain Quest" then
				if not utilities:CheckToolName("Yama") then
					mods:FireInvoke("LoadItem", "Yama")
				end

				if tick() - n7 > 10 then
					n7 = tick()
					mods:FireInvoke("CDKQuest", "StartTrial", "Evil")
				end

				local enemies2 = utilities:GetEnemies("Forest Pirate") or utilities:GetEnemies("Jungle Pirate") or utilities:GetEnemies("Pirate Millionaire")

				if enemies2 and enemies2:FindFirstChild("HumanoidRootPart") then
					tweenManager:topos(enemies2.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
				else
					tweenManager:topos(CFrame.new(-13234, 520, -6800))
				end
			elseif v22 == "Haze Quest" then
				if not utilities:CheckToolName("Yama") then
					mods:FireInvoke("LoadItem", "Yama")
				end

				local questHaze = localPlayer:FindFirstChild("QuestHaze")

				if not questHaze then
					mods:FireInvoke("CDKQuest", "StartTrial", "Evil")
					local now3 = tick()

					while true do
						task.wait(0.3)
						questHaze = localPlayer:FindFirstChild("QuestHaze")
						if not (questHaze or tick() - now3 > 4 or not config.AutoGetCDK) then
							continue
						end
						break
					end
				end

				if questHaze then
					local v23 = gameData:HazeMobs()

					if v23 then
						subFunction:Attack(v23, true)
					else
						local v24 = gameData:HazePosition()

						if v24 then
							tweenManager:topos(CFrame.new(v24 + Vector3.new(0, 20, 0)))
						else
							tweenManager:topos(CFrame.new(-12391.56, 600.24, -6500.53))
						end
					end
				end
			elseif v22 == "Hell Quest" then
				if not utilities:CheckToolName("Yama") then
					mods:FireInvoke("LoadItem", "Yama")
				end

				if tick() - n7 > 10 then
					n7 = tick()
					mods:FireInvoke("CDKQuest", "StartTrial", "Evil")
				end

				local hellDimension = v2._WorldOrigin.Locations:FindFirstChild("Hell Dimension")
				local hellDimension2 = map:FindFirstChild("HellDimension")

				if hellDimension and localPlayer:DistanceFromCharacter(hellDimension.Position) <= 1000 or hellDimension2 and hellDimension2:FindFirstChild("Exit") and localPlayer:DistanceFromCharacter(hellDimension2.Exit.Position) <= 1000 then
					if hellDimension2 and hellDimension2:FindFirstChild("Exit") and hellDimension2.Exit.BrickColor == BrickColor.new("Olivine") then
						if localPlayer:DistanceFromCharacter(hellDimension2.Exit.Position) <= 25 then
							pcall(function()
								firetouchinterest(humanoidRootPart, hellDimension2.Exit, 0)
								firetouchinterest(humanoidRootPart, hellDimension2.Exit, 1)
							end)
						end

						tweenManager:topos(hellDimension2.Exit.CFrame)
						return
					end

					local nearest = gameData:GetNearest(150)

					if nearest then
						tweenManager:topos(nearest.HumanoidRootPart.CFrame * Vector3.new(0, 30, 0), true)
						utilities:AutoHaki()
						utilities:EquipWeapon()
					elseif hellDimension2 then
						for _, child in ipairs(hellDimension2:GetChildren()) do
							if child.Name:find("Torch") and child:IsA("MeshPart") then
								local proximityPrompt = child:FindFirstChildOfClass("ProximityPrompt")

								if proximityPrompt and proximityPrompt.Enabled then
									if localPlayer:DistanceFromCharacter(child.Position) > 15 then
										tweenManager:topos(child.CFrame, true)
										task.wait(0.2)
									end

									fireproximityprompt(proximityPrompt, math.huge)
									task.wait(0.1)
									tweenManager:topos(child.CFrame * CFrame.new(0, 30, 0), true)
									task.wait(0.3)
									break
								end
							end
						end
					end
				elseif utilities:CheckMon("Soul Reaper") then
					local enemies2 = utilities:GetEnemies("Soul Reaper")

					if enemies2 and enemies2:FindFirstChild("HumanoidRootPart") then
						tweenManager:topos(enemies2.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
					end
				else
					local Bones, v23, v24, v25 = mods:FireInvoke("Bones", "Check")

					if v25 ~= nil and v25 ~= "00:00" then
					end

					if v24 and v24 > 0 and Bones and Bones >= 50 then
						if utilities:CheckToolName("Hallow Essence") then
							utilities:EquipTool("Hallow Essence")
							tweenManager:topos(CFrame.new(-8932, 142, 6063))
						elseif localPlayer:DistanceFromCharacter(Vector3.new(-8934, 142, 6036)) <= 50 then
							mods:FireInvoke("Bones", "Buy", 1, 1)
						else
							tweenManager:topos(CFrame.new(-8934, 142, 6036))
						end
					elseif utilities:CheckToolName("Hallow Essence") then
						utilities:EquipTool("Hallow Essence")
						tweenManager:topos(CFrame.new(-8932, 142, 6063))
					else
						joinAPI("SoulReaper", 2)
					end
				end
			elseif v22 == "Burn Yama Scroll" then
				local cursed = map:FindFirstChild("Turtle") and map.Turtle:FindFirstChild("Cursed")
				cursed = cursed and cursed:FindFirstChild("Pedestal2")

				if cursed then
					if localPlayer:DistanceFromCharacter(cursed.Position) <= 12 then
						if cursed:FindFirstChild("ProximityPrompt") and cursed.ProximityPrompt.Enabled then
							fireproximityprompt(cursed.ProximityPrompt, math.huge)
							RS.DialogueController._Close:Fire()
						end

						mods:FireInvoke("CDKQuest", "StartTrial", "Evil")
						task.wait(0.5)
					else
						tweenManager:topos(cursed.CFrame)
					end
				else
					tweenManager:topos(CFrame.new(-12391.56, 600.24, -6500.53))
				end
			elseif v22 == "Start Tushita" then
				if not utilities:CheckToolName("Tushita") then
					mods:FireInvoke("LoadItem", "Tushita")
				end

				local cursed = map:FindFirstChild("Turtle") and map.Turtle:FindFirstChild("Cursed")
				local pedestal1 = cursed and cursed:FindFirstChild("Pedestal1")

				if pedestal1 then
					if localPlayer:DistanceFromCharacter(pedestal1.Position) <= 12 then
						if pedestal1:FindFirstChild("ProximityPrompt") and pedestal1.ProximityPrompt.Enabled then
							fireproximityprompt(pedestal1.ProximityPrompt, math.huge)
						end

						mods:FireInvoke("CDKQuest", "StartTrial", "Good")
						task.wait(0.5)
					else
						tweenManager:topos(pedestal1.CFrame)
					end
				else
					mods:FireInvoke("CDKQuest", "StartTrial", "Good")
					tweenManager:topos(CFrame.new(-12391.07, 600.24, -6599.23))
				end
			elseif v22 == "Boat Quest" then
				if not utilities:CheckToolName("Tushita") then
					mods:FireInvoke("LoadItem", "Tushita")
				end

				if tick() - n7 > 10 then
					n7 = tick()
					mods:FireInvoke("CDKQuest", "StartTrial", "Good")
				end

				local v23 = tbl17[n8] or tbl17[1]

				if localPlayer:DistanceFromCharacter(v23.Position) > 15 then
					tweenManager:topos(v23)
					local luxuryBoatDealer = v2.NPCs:FindFirstChild("Luxury Boat Dealer")

					if luxuryBoatDealer and localPlayer:DistanceFromCharacter(luxuryBoatDealer:GetPivot().Position) <= 25 then
						pcall(function()
							mods:FireInvoke("CDKQuest", "BoatQuest", luxuryBoatDealer, "Check")
							mods:FireInvoke("CDKQuest", "BoatQuest", luxuryBoatDealer)
							mods:FireInvoke("CDKQuest", "BoatQuest", luxuryBoatDealer, "Pardon me...")
							RS.DialogueController._Close:Fire()
						end)
					end
				else
					local luxuryBoatDealer = v2.NPCs:FindFirstChild("Luxury Boat Dealer")

					if luxuryBoatDealer then
						pcall(function()
							mods:FireInvoke("CDKQuest", "BoatQuest", luxuryBoatDealer, "Check")
							mods:FireInvoke("CDKQuest", "BoatQuest", luxuryBoatDealer)
							mods:FireInvoke("CDKQuest", "BoatQuest", luxuryBoatDealer, "Pardon me...")
							RS.DialogueController._Close:Fire()
						end)
					end

					task.wait(1.5)
					n8 = n8 % #tbl17 + 1
				end
			elseif v22 == "Raid Quest" then
				if not utilities:CheckToolName("Tushita") then
					mods:FireInvoke("LoadItem", "Tushita")
				end

				if tick() - n7 > 10 then
					n7 = tick()
					mods:FireInvoke("CDKQuest", "StartTrial", "Good")
				end

				local v23 = gameData:DetectPirateRaid()

				if v23 then
					n9 = tick()
					subFunction:Attack(v23, true)
				else
					tweenManager:topos(CFrame.new(-5542, 330, -2971))

					if n9 == 0 then
						n9 = tick()
					end

					if tick() - n9 > 35 then
						joinAPI("pirate", 2)
						n9 = tick()
					end
				end
			elseif v22 == "Heavenly Quest" then
				if not utilities:CheckToolName("Tushita") then
					mods:FireInvoke("LoadItem", "Tushita")
				end

				if tick() - n7 > 10 then
					n7 = tick()
					mods:FireInvoke("CDKQuest", "StartTrial", "Good")
				end

				local heavenlyDimension = worldOrigin.Locations:FindFirstChild("Heavenly Dimension")
				local heavenlyDimension2 = map:FindFirstChild("HeavenlyDimension")

				if heavenlyDimension and localPlayer:DistanceFromCharacter(heavenlyDimension.Position) <= 1000 or heavenlyDimension2 and heavenlyDimension2:FindFirstChild("Exit") and localPlayer:DistanceFromCharacter(heavenlyDimension2.Exit.Position) <= 1000 then
					if heavenlyDimension2 and heavenlyDimension2:FindFirstChild("Exit") and heavenlyDimension2.Exit.BrickColor == BrickColor.new("Cloudy grey") then
						if localPlayer:DistanceFromCharacter(heavenlyDimension2.Exit.Position) <= 25 then
							pcall(function()
								firetouchinterest(humanoidRootPart, heavenlyDimension2.Exit, 0)
								firetouchinterest(humanoidRootPart, heavenlyDimension2.Exit, 1)
							end)
						end

						tweenManager:topos(heavenlyDimension2.Exit.CFrame)
						return
					end

					local nearest = gameData:GetNearest(150)

					if nearest then
						tweenManager:topos(nearest.HumanoidRootPart.CFrame * Vector3.new(0, 30, 0), true)
						utilities:AutoHaki()
						utilities:EquipWeapon()
					elseif heavenlyDimension2 then
						for _, child in ipairs(heavenlyDimension2:GetChildren()) do
							if child.Name:find("Torch") and child:IsA("MeshPart") then
								local proximityPrompt = child:FindFirstChildOfClass("ProximityPrompt")

								if proximityPrompt and proximityPrompt.Enabled then
									if localPlayer:DistanceFromCharacter(child.Position) > 15 then
										tweenManager:topos(child.CFrame, true)
										task.wait(0.2)
									end

									fireproximityprompt(proximityPrompt, math.huge)
									task.wait(0.1)
									tweenManager:topos(child.CFrame * CFrame.new(0, 30, 0), true)
									task.wait(0.3)
									break
								end
							end
						end
					end
				elseif utilities:CheckMon("Cake Queen") then
					local enemies2 = utilities:GetEnemies("Cake Queen")

					if enemies2 then
						subFunction:Attack(enemies2, true)
					end
				else
					utilities:MobsNextSpawn("Cake Queen")
				end
			elseif v22 == "Burn Tushita Scroll" then
				local cursed = map:FindFirstChild("Turtle") and map.Turtle:FindFirstChild("Cursed")
				cursed = cursed and cursed:FindFirstChild("Pedestal1")

				if cursed then
					if localPlayer:DistanceFromCharacter(cursed.Position) <= 12 then
						if cursed:FindFirstChild("ProximityPrompt") and cursed.ProximityPrompt.Enabled then
							fireproximityprompt(cursed.ProximityPrompt, math.huge)
						end

						mods:FireInvoke("CDKQuest", "StartTrial", "Good")
						task.wait(0.5)
					else
						tweenManager:topos(cursed.CFrame)
					end
				else
					tweenManager:topos(CFrame.new(-12391.07, 600.24, -6599.23))
				end
			elseif v22 == "Alucard Boss" then
				local cursed = map:FindFirstChild("Turtle") and map.Turtle:FindFirstChild("Cursed")

				if not cursed then
					tweenManager:topos(CFrame.new(-12389, 601, -6548))
				elseif cursed:FindFirstChild("PlacedGem") and cursed.PlacedGem.Transparency == 0 then
					if not utilities:CheckMon("Cursed Skeleton Boss") then
						tweenManager:topos(CFrame.new(-12341.67, 603.35, -6550.61))
					else
						local enemies2 = utilities:GetEnemies("Cursed Skeleton Boss")

						if enemies2 then
							subFunction:Attack(enemies2, true)
						end
					end
				else
					local pedestal3 = cursed:FindFirstChild("Pedestal3")

					if pedestal3 and pedestal3:FindFirstChild("ProximityPrompt") then
						if localPlayer:DistanceFromCharacter(pedestal3.Position) <= 12 then
							fireproximityprompt(pedestal3.ProximityPrompt, math.huge)
							RS.DialogueController._Close:Fire()
						else
							tweenManager:topos(pedestal3.CFrame)
						end
					else
						mods:FireInvoke("CDKQuest", "Alucard")
						tweenManager:topos(CFrame.new(-12356.77, 600.24, -6551.03))
					end
				end
			end
		end, isSea3)

		local cframe5 = CFrame.new(-11892, 931, -8761)

		fn28("GetRainbowHaki", function()
			for _, v22 in ipairs({ "Stone", "Hydra Leader", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate" }) do
				if VerifyQuest(v22) then
					local enemies2 = utilities:GetEnemies(v22)
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
					utilities:MobsNextSpawn(v22)
					return
				end
			end

			if localPlayer:DistanceFromCharacter(cframe5.Position) <= 10 then
				mods:FireInvoke("HornedMan", "Bet")
			else
				tweenManager:topos(cframe5)
			end
		end, isSea3)

		fn28("CompleteCitizenQuest", function()
			local CitizenQuestProgress = mods:FireInvoke("CitizenQuestProgress")

			if CitizenQuestProgress then
				local killedBandits = CitizenQuestProgress.KilledBandits
				local killedBoss = CitizenQuestProgress.KilledBoss
				if CitizenQuestProgress.FoundTreasure then
					return nil
				end

				if killedBoss then
					tweenManager:topos(CFrame.new(-12512, 340, -9872))
					return true
				end

				if not killedBandits then
					if VerifyQuest("Forest Pirate") and VerifyQuest("50") then
						local enemies2 = utilities:GetEnemies("Forest Pirate")
						if enemies2 then
							return subFunction:Attack(enemies2, true)
						end
						tweenManager:topos(CFrame.new(-13497, 391, -7909))
					elseif localPlayer:DistanceFromCharacter(Vector3.new(-12445, 332, -7676)) <= 8 then
						mods:FireInvoke("StartQuest", "CitizenQuest", 1)
					else
						tweenManager:topos(CFrame.new(-12445, 332, -7676))
					end
				else
					local enemies2 = utilities:GetEnemies("Captain Elephant")

					if VerifyQuest("Captain Elephant") then
						if enemies2 then
							return subFunction:Attack(enemies2)
						end
						tweenManager:topos(CFrame.new(-13382, 367, -8539))
					elseif localPlayer:DistanceFromCharacter(Vector3.new(-12445, 332, -7676)) <= 8 then
						mods:FireInvoke("CitizenQuestProgress", "Citizen")
					else
						tweenManager:topos(CFrame.new(-12445, 332, -7676))
					end
				end
			end
		end, isSea3)

		fn28("AutoFullyPullLever", function()
			local RaceV4Progress = mods:FireInvoke("RaceV4Progress", "Check")

			if RaceV4Progress == 1 then
				mods:FireInvoke("RaceV4Progress", "Begin")
			else
				if RaceV4Progress == 2 then
					if utilities:GetDistance(CFrame.new(28610, 14897, 106)) > 500 then
						mods:FireInvoke("requestEntrance", Vector3.new(28283, 14897, 105))
						tweenManager:topos(CFrame.new(28610, 14897, 106))
						return
					end

					if utilities:GetDistance(CFrame.new(28610, 14897, 107)) < 20 then
						wait(1)
						mods:FireInvoke("RaceV4Progress", "TeleportBack")
						wait(0.5)
						tweenManager:topos(CFrame.new(2956, 2282, -7216))
						mods:FireInvoke("RaceV4Progress", "Teleport")
					end

					return
				end

				if RaceV4Progress == 3 then
					mods:FireInvoke("RaceV4Progress", "Continue")
				elseif map:FindFirstChild("MysticIsland") and not mods:FireInvoke("CheckTempleDoor") then
					if LightingSvc.ClockTime > 16 or LightingSvc.ClockTime < 5 then
						local cframe6 = CFrame.new(map.MysticIsland.Center.Position.X, 500, map.MysticIsland.Center.Position.Z)
						tweenManager:topos(cframe6, true)
						local flag4 = false

						for _, child in pairs(map.MysticIsland:GetChildren()) do
							if child.Name == "Part" and child:IsA("MeshPart") and child.Transparency == 0 then
								flag4 = child
							end
						end

						if not flag4 then
							if utilities:GetDistance(cframe6) < 200 then
								v2.CurrentCamera.CFrame = CFrame.lookAt(v2.CurrentCamera.CFrame.p, v2.CurrentCamera.CFrame.p + LightingSvc:GetMoonDirection() * 100)
								wait(0.5)
								RS.Remotes.CommE:FireServer("ActivateAbility")
							end
						else
							tweenManager:topos(flag4.CFrame)
						end
					end
				elseif mods:FireInvoke("CheckTempleDoor") then
					if utilities:GetDistance(CFrame.new(28575, 14937, 72)) > 10 then
						tweenManager:topos(CFrame.new(28575, 14937, 72))
					else
						fireproximityprompt(map["Temple of Time"].Lever.Prompt.ProximityPrompt, math.huge)
					end
				end
			end
		end, isSea3)

		fn28("AutoKenV2", function()
			if not mods:FireInvoke("CitizenQuestProgress").FoundTreasure then
				functions.CompleteCitizenQuest.Call()
			end

			if not utilities:CheckToolName("Fruit Bowl") then
				if not utilities:CheckToolName("Apple") then
					for _, child in pairs(v2:GetChildren()) do
						if child.Name == "Apple" then
							tweenManager:topos(CFrame.new(child.Handle.Position))
							task.wait()
						end
					end
				elseif not utilities:CheckToolName("Banana") then
					for _, child in pairs(v2:GetChildren()) do
						if child.Name == "Banana" then
							tweenManager:topos(CFrame.new(child.Handle.Position))
							task.wait()
						end
					end
				elseif not utilities:CheckToolName("Pineapple") then
					for _, child in pairs(v2:GetChildren()) do
						if child.Name == "Pineapple" then
							tweenManager:topos(CFrame.new(child.Handle.Position))
						end
					end
				end

				if utilities:CheckToolName("Banana") and utilities:CheckToolName("Apple") and utilities:CheckToolName("Pineapple") then
					tweenManager:topos(CFrame.new(-12445, 332, -7673))
					mods:FireInvoke("CitizenQuestProgress", "Citizen")
				end
			end

			if utilities:CheckToolName("Fruit Bowl") then
				tweenManager:topos(CFrame.new(-10920, 624, -10267))
				task.wait(0.5)
				mods:FireInvoke("KenTalk2", "Start")
				task.wait(0.1)
				mods:FireInvoke("KenTalk2", "Buy")
			end
		end, isSea3)

		fn28("AutoDeathStep", function()
			if utilities:CheckToolName("Death Step") then
				return
			end
			local v22 = utilities:CheckToolName("Black Leg")

			if not v22 or v22.Level.Value < 400 then
				config.SelectMelee = "Black Leg"
				functions.AutoBuyMelee.Call()

				if v22 and v22.Level.Value < 400 then
					local enemies2 = utilities:GetEnemies({ "Arctic Warrior", "Snow Lurker" })
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
					utilities:MobsNextSpawn("Arctic Warrior")
				end

				return
			end

			config.SelectMelee = "Death Step"
			functions.AutoBuyMelee.Call()

			if v2.Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
				if utilities:CheckToolName("Library Key") then
					tweenManager:topos(CFrame.new(6371, 297, -6841))
					task.wait(0.3)
					mods:FireInvoke("BuyDeathStep")
				else
					local enemies2 = utilities:GetEnemies("Awakened Ice Admiral")
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
					tweenManager:topos(CFrame.new(5669, 29, -6483))
				end
			end
		end, isSea2)

		fn28("AutoSharkmanKarate", function()
			if utilities:CheckToolName("Sharkman Karate") then
				return
			end
			local v22 = utilities:CheckToolName("Fishman Karate")

			if not v22 or v22.Level.Value < 400 then
				config.SelectMelee = "Fishman Karate"
				functions.AutoBuyMelee.Call()

				if v22 and v22.Level.Value < 400 then
					local enemies2 = utilities:GetEnemies("Water Fighter")
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
					utilities:MobsNextSpawn("Water Fighter")
				end

				return
			end

			local BuySharkmanKarate = mods:FireInvoke("BuySharkmanKarate")

			if type(BuySharkmanKarate) == "string" and BuySharkmanKarate:find("keys") then
				if utilities:CheckToolName("Water Key") then
					tweenManager:topos(CFrame.new(-2605, 239, -10315))
					task.wait(0.3)
					mods:FireInvoke("BuySharkmanKarate")
				else
					local enemies2 = utilities:GetEnemies("Tide Keeper")
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
					tweenManager:topos(CFrame.new(-3054, 237, -10145))
				end
			else
				config.SelectMelee = "Sharkman Karate"
				functions.AutoBuyMelee.Call()
			end
		end, isSea2)

		fn28("AutoElectricClaw", function()
			if utilities:CheckToolName("Electric Claw") then
				return
			end
			local Electro = utilities:CheckToolName("Electro")

			if not Electro or Electro.Level.Value < 400 then
				config.SelectMelee = "Electro"
				functions.AutoBuyMelee.Call()

				if Electro and Electro.Level.Value < 400 then
					local enemies2 = utilities:GetEnemies("Fishman Raider")
					if enemies2 then
						return subFunction:Attack(enemies2)
					end
					utilities:MobsNextSpawn("Fishman Raider")
				end

				return
			end

			if mods:FireInvoke("BuyElectricClaw", "Start") == nil then
				tweenManager:topos(CFrame.new(-12548, 337, -7481))
				task.wait(0.3)
			else
				config.SelectMelee = "Electric Claw"
				functions.AutoBuyMelee.Call()
			end
		end, isSea3)

		fn28("AutoDragonTalon", function()
			if utilities:CheckToolName("Dragon Talon") then
				return
			end
			local v22 = utilities:CheckToolName("Dragon Claw")

			if not v22 or v22.Level.Value < 400 then
				config.SelectMelee = "Dragon Claw"
				functions.AutoBuyMelee.Call()

				if v22 and v22.Level.Value < 400 then
					local enemies2 = utilities:GetEnemies("Reborn Skeleton")
					if enemies2 then
						return subFunction:Attack(enemies2, true)
					end
					utilities:MobsNextSpawn("Reborn Skeleton")
				end

				return
			end

			if not utilities:CheckToolName("Fire Essence") then
				mods:FireInvoke("Bones", "Buy", 1, 1)
				task.wait(0.1)
			else
				config.SelectMelee = "Dragon Talon"
				functions.AutoBuyMelee.Call()
			end
		end, isSea3)

		fn28("AutoSharkAnchor", function()
			if enemies:FindFirstChild("Terrorshark") then
				for _, child in pairs(enemies:GetChildren()) do
					if child.Name == "Terrorshark" then
						if child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
							while true do
								task.wait()
								local tool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")
								local n10 = tool and tool.ToolTip == "Blox Fruit" and tool.Name ~= "Ice-Ice" and tool.Name ~= "Light-Light" and 16 or 40
								task.wait()
								utilities:AutoHaki()
								utilities:EquipWeapon()
								local cframe6

								if child.HumanoidRootPart.CFrame.Y > -3 then
									cframe6 = CFrame.new(0, 250, 0)
								elseif gameData:TerrorDodge() then
									cframe6 = CFrame.new(0, 150, 30)
								else
									cframe6 = CFrame.new(0, n10, 0)
								end

								tweenManager:topos(child.HumanoidRootPart.CFrame * cframe6, true)
								subFunction:Attack(child)
								if not (not config.AutoSharkAnchor or not child.Parent or child.Humanoid.Health <= 0) then
									continue
								end
								break
							end
						end
					end
				end
			else
				local v22 = GetSelectedBoat()
				local character2 = localPlayer.Character
				character2 = character2 and character2:FindFirstChildOfClass("Humanoid")

				if not v22 then
					tweenManager:StopBoatTween()

					if utilities:GetDistance(CFrame.new(-16927.451, 9.086, 433.864)) <= 12 then
						BuyBoatSafe(config.BoatSelected)
					else
						tweenManager:topos(CFrame.new(-16927.451, 9.086, 433.864))
					end
				elseif not character2.Sit then
					tweenManager:StopBoatTween()
					local vehicleSeat = v22:FindFirstChildWhichIsA("VehicleSeat", true) or v22:FindFirstChild("VehicleSeat", true) or v22:FindFirstChildWhichIsA("Seat", true)

					if vehicleSeat and vehicleSeat:IsA("BasePart") then
						tweenManager:topos(vehicleSeat.CFrame * CFrame.new(0, 1.5, 0))
						task.wait(0.3)
					end
				else
					tweenManager:toposboat(CFrame.new(-10000000, 31, 37016.25))
				end
			end
		end, isSea3)

		fn28("Tweenfruit", function()
			local huge = math.huge
			local v22 = nil

			for _, child in ipairs(v2:GetChildren()) do
				if child:IsA("Model") and child.Name:find("Fruit") then
					local handle = child:FindFirstChild("Handle") or child:FindFirstChildWhichIsA("BasePart")

					if handle then
						local magnitude = humanoidRootPart and (handle.Position - humanoidRootPart.Position).Magnitude or 0

						if magnitude < huge then
							huge = magnitude
							v22 = handle
						end
					end
				end
			end

			if v22 then
				tweenManager:topos(v22.CFrame)
			elseif config.HopIfNoFruit then
				utilities:ServerHop()
			end
		end, true)

		local now3 = nil

		fn28("AutoBerrySafe", function()
			local v22 = nil
			local v23 = nil
			local huge = math.huge
			local v24 = nil

			for _, v25 in ipairs(v5:GetTagged("BerryBush")) do
				local parent = v25.Parent

				if parent and parent:IsDescendantOf(v2) then
					local attribute2 = parent:GetAttribute("CFrame") or parent:IsA("Model") and parent:GetPivot()

					for k, v26 in pairs(v25:GetAttributes()) do
						if type(v26) == "string" and #v26 > 0 and k:sub(1, 12) == "_BerryCFrame" then
							local attribute3 = parent:GetAttribute(k)
							local v27 = attribute2 and attribute3 and attribute2:ToWorldSpace(attribute3)

							if v27 then
								local magnitude = humanoidRootPart and (v27.Position - humanoidRootPart.Position).Magnitude or 0

								if magnitude < huge then
									v22 = parent
									v23 = k
									huge = magnitude
									v24 = v27
								end
							end
						end
					end
				end
			end

			if v22 and v23 and v24 then
				now3 = nil
				tweenManager:topos(v24)

				if humanoidRootPart and (v24.Position - humanoidRootPart.Position).Magnitude <= 60 then
					task.spawn(function()
						local rfClaimBerry = net:FindFirstChild("RF/ClaimBerry")

						if rfClaimBerry then
							rfClaimBerry:InvokeServer(v22.Name, v23)
						end
					end)
				end
			elseif config.HopIfNoBerries then
				if not now3 then
					now3 = tick()
				elseif tick() - now3 >= 5 then
					local n10 = config and tonumber(config.HopDelay) or 10

					if mods and mods.SendNotify then
						local min = math.min
						mods:SendNotify("Berry Farm", "No Berries found in server. Hopping in " .. tostring(math.floor(n10)) .. "s...", min(math.floor(n10), 5))
					end

					utilities:ServerHop(n10)
					task.wait(n10 + 5)
				end
			else
				now3 = nil
			end
		end, true)

		fn28("AutoKillLeviathan", function()
			for _, child in ipairs(seaBeasts:GetChildren()) do
				if child.Name == "Leviathan Segment" and child:FindFirstChild("HumanoidRootPart") then
					tweenManager:topos(child.HumanoidRootPart.CFrame * CFrame.new(0, 21, 0), true)
					utilities:AutoHaki()

					if (localPlayer.Character.HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude < 150 then
						humanoidRootPart2 = child.HumanoidRootPart
						fn14()
						humanoidRootPart2 = nil
					end

					return
				end
			end

			for _, child in ipairs(seaBeasts:GetChildren()) do
				if child.Name == "Leviathan" and child:FindFirstChild("Head") then
					tweenManager:topos(CFrame.new(child.Head.Position.X, 60, child.Head.Position.Z), true)
					utilities:AutoHaki()

					if (localPlayer.Character.HumanoidRootPart.Position - child.Head.Position).Magnitude < 150 then
						humanoidRootPart2 = child.Head
						fn14()
						humanoidRootPart2 = nil
					end

					return
				end
			end
		end, isSea3)

		local function fn31()
			local seaEventTargets = gameData:GetSeaEventTargets() or {}
			local flag4 = config.AutoFarmSeaEvents and not (config.AutoFindLeviatan and config.AutoIgnoreSeaEventsLeviathan) and #seaEventTargets > 0
			local v22 = nil
			local str5 = nil

			if flag4 then
				local flag5 = table.find(seaEventTargets, "SeaBeast") ~= nil or table.find(seaEventTargets, "Sea Beast") ~= nil
				v22 = nil
				str5 = nil

				if flag5 then
					v22 = nil
					str5 = nil

					for _, child in ipairs(seaBeasts:GetChildren()) do
						if mods:IsReady(child) then
							local humanoidRootPart3 = child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")

							if humanoidRootPart3 and localPlayer:DistanceFromCharacter(humanoidRootPart3.Position) <= 1500 then
								str5 = "SeaBeast"
								v22 = child
								break
							else
								v22 = nil
								str5 = nil
							end
						else
							v22 = nil
							str5 = nil
						end
					end
				end

				if not v22 then
					for _, child in ipairs(enemies:GetChildren()) do
						if mods:IsReady(child) then
							for _, seaEventTarget in ipairs(seaEventTargets) do
								if seaEventTarget ~= "SeaBeast" and (string.find(child.Name, seaEventTarget) or seaEventTarget == "FishBoat" and child.Name:find("FishBoat")) then
									local humanoidRootPart3 = child:FindFirstChild("HumanoidRootPart") or child:FindFirstChild("Engine") or child:FindFirstChildWhichIsA("BasePart")

									if humanoidRootPart3 and localPlayer:DistanceFromCharacter(humanoidRootPart3.Position) <= 1500 then
										v22 = child
										str5 = seaEventTarget
										break
									end
								end
							end

							if not v22 then
								continue
							end
						else
							continue
						end

						break
					end
				end
			end

			if v22 then
				tweenManager:StopBoatTween()
				local v23 = GetSelectedBoat()

				if config.ProtectBoat and v23 then
					fn21(v23, 450)
				end

				if humanoid and humanoid.Sit then
					humanoid.Sit = false
					task.wait(0.05)
				end

				utilities:AutoHaki()

				if str5 == "SeaBeast" then
					if config.UseDragonSforSeabeasts then
						utilities:EquipWeapon("Gun")
					else
						utilities:EquipWeapon()
					end

					local humanoidRootPart3 = v22:FindFirstChild("HumanoidRootPart") or v22:FindFirstChildWhichIsA("BasePart")

					if humanoidRootPart3 then
						local waterBasePlane = workspace.Map:FindFirstChild("WaterBase-Plane")
						waterBasePlane = waterBasePlane and waterBasePlane.Position.Y or 0
						local dodgefSeabeast = config.DodgefSeabeast and gameData:DodgeSeabeast()
						local n10 = dodgefSeabeast and 400 or 250
						dodgefSeabeast = dodgefSeabeast and 20 or 2

						if (Vector3.new(0, humanoidRootPart3.Position.Y, 0) - Vector3.new(0, waterBasePlane, 0)).Magnitude <= 175 then
							tweenManager:topos(humanoidRootPart3.CFrame * CFrame.new(0, n10, dodgefSeabeast), true)
						else
							tweenManager:topos(CFrame.new(humanoidRootPart3.Position.X, waterBasePlane + n10, humanoidRootPart3.Position.Z), true)
						end

						if config.UseDragonSforSeabeasts then
							shootGun()
						else
							fn14()
						end
					end
				elseif str5 == "PirateBrigade" or str5 == "Pirate Grand Brigade" or str5 == "Ghost Ship" or str5 == "FishBoat" or v22:FindFirstChild("Engine") then
					local health = v22:FindFirstChild("Health")
					local humanoid2 = v22:FindFirstChildOfClass("Humanoid") or v22:FindFirstChild("Humanoid")

					if health then
						local flag5 = health:IsA("ValueBase") and health.Value <= 0

						if flag5 then
							health = flag5
						else
							health = type(health.Value) == "number" and health.Value <= 0
						end
					end

					local flag5

					if health then
						flag5 = health
					elseif humanoid2 then
						local flag6 = humanoid2:IsA("Humanoid") and humanoid2.Health <= 0

						if flag6 then
							flag5 = flag6
						else
							flag5 = humanoid2:IsA("ValueBase") and humanoid2.Value <= 0
						end
					else
						flag5 = humanoid2
					end

					local flag6 = flag5 or v22:GetAttribute("Dead") == true or v22:GetAttribute("Sunk") == true
					local engine = v22:FindFirstChild("Engine") or v22.PrimaryPart or v22:FindFirstChildWhichIsA("BasePart")

					if engine and engine.Position.Y < -15 then
						flag6 = true
					end

					if not flag6 and engine then
						if config.UseDragonSforSeabeasts then
							utilities:EquipWeapon("Gun")
							shootGun()
						else
							utilities:EquipWeapon()
						end

						tweenManager:topos(engine.CFrame * CFrame.new(0, 25, 0), true)
						position = engine.Position
						fn14()
						position = nil
					end
				else
					local humanoidRootPart3 = v22:FindFirstChild("HumanoidRootPart") or v22.PrimaryPart

					if humanoidRootPart3 then
						if str5 == "Terror Shark" or str5 == "Terrorshark" or v22.Name:find("Terror") then
							task.wait()
							utilities:AutoHaki()
							utilities:EquipWeapon()
							local cframe6

							if humanoidRootPart3.CFrame.Y > -3 then
								cframe6 = CFrame.new(0, 250, 0)
							elseif gameData:TerrorDodge() then
								cframe6 = CFrame.new(0, 150, 30)
							else
								cframe6 = CFrame.new(0, 40, 0)
							end

							tweenManager:topos(humanoidRootPart3.CFrame * cframe6, true)
							subFunction:Attack(v22)
						else
							utilities:EquipWeapon()
							tweenManager:topos(humanoidRootPart3.CFrame * CFrame.new(0, 20, 0), true)
							subFunction:Attack(v22)
						end
					end
				end
			else
				local v23 = GetSelectedBoat()

				if v23 then
					fn22(v23)
				end

				subFunction:AutoBoatSail()
				task.wait(0.4)
			end
		end

		fn28("AutoSail", fn31, isSea2 or isSea3)

		fn28("AutoFindMirageIsland", function()
			if map:FindFirstChild("MysticIsland") or worldOrigin.Locations:FindFirstChild("Mirage Island") then
				tweenManager:StopBoatTween()
			else
				subFunction:AutoBoatSail(CFrame.new(-10000000, 31, 37016.25))
			end
		end, isSea3)

		fn28("AutoFindKitsuneIsland", function()
			if map:FindFirstChild("KitsuneIsland") or worldOrigin.Locations:FindFirstChild("Kitsune Island") then
				tweenManager:StopBoatTween()

				if humanoid.Sit then
					humanoid.Sit = false
				end
			else
				subFunction:AutoBoatSail(CFrame.new(-10000000, 31, 37016.25))
			end
		end, isSea3)

		fn28("AutoFindPrehistoricIsland", function()
			if map:FindFirstChild("PrehistoricIsland") or worldOrigin.Locations:FindFirstChild("Prehistoric Island") then
				tweenManager:StopBoatTween()

				if humanoid.Sit then
					humanoid.Sit = false
				end

				mods._FindPrehistoricIsland.Update(false)
			else
				subFunction:AutoBoatSail(CFrame.new(-10000000, 31, 37016.25))
			end
		end, isSea3)

		fn28("CollectAzure", function()
			local emberTemplate = v2:FindFirstChild("EmberTemplate")

			if emberTemplate and emberTemplate:FindFirstChild("Part") then
				tweenManager:topos(emberTemplate.Part.CFrame)
			end
		end, isSea3)

		fn28("AutoFinishTrial", function()
			if config and config.AutoCompleteDracoTrial then
				return
			end
			local value = data.Race.Value
			if value == "Draco" or not tbl12[value] then
				return
			end

			if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				if value == "Mink" and map:FindFirstChild("MinkTrial") then
					local ceiling = map.MinkTrial.Ceiling

					if (ceiling.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
						tweenManager:topos(ceiling.CFrame * CFrame.new(0, -5, 0))
					end
				elseif value == "Human" and map:FindFirstChild("HumanTrial") then
					if (localPlayer.Character.HumanoidRootPart.Position - map.HumanTrial.BossSpawn.Position).Magnitude <= 250 then
						for _, child in ipairs(enemies:GetChildren()) do
							if child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
								if (child.HumanoidRootPart.Position - map.HumanTrial.BossSpawn.Position).Magnitude <= 200 then
									subFunction:Attack(child)
									break
								end
							end
						end
					end
				elseif value == "Ghoul" and map:FindFirstChild("GhoulTrial") then
					if (localPlayer.Character.HumanoidRootPart.Position - map.GhoulTrial.BossSpawn.Position).Magnitude <= 250 then
						for _, child in ipairs(enemies:GetChildren()) do
							if child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
								if (child.HumanoidRootPart.Position - map.GhoulTrial.BossSpawn.Position).Magnitude <= 200 then
									subFunction:Attack(child, true)
									break
								end
							end
						end
					end
				elseif value == "Cyborg" and map:FindFirstChild("CyborgTrial") then
					if (localPlayer.Character.HumanoidRootPart.Position - map.CyborgTrial.Floor.Position).Magnitude <= 250 then
						tweenManager:topos(map.CyborgTrial.Floor.CFrame * CFrame.new(0, 180, 0), true)
					end
				elseif value == "Skypiea" and map:FindFirstChild("SkyTrial") then
					local finishPart = map.SkyTrial.Model.FinishPart

					if (finishPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
						tweenManager:topos(finishPart.CFrame, true)
					end
				elseif value == "Fishman" and map:FindFirstChild("FishmanTrial") then
					if (localPlayer.Character.HumanoidRootPart.Position - map.FishmanTrial:GetPivot().Position).Magnitude < 1000 then
						local trialOfWater = worldOrigin.Locations:FindFirstChild("Trial of Water")

						if trialOfWater then
							local v22 = next
							local children, v23 = v2.SeaBeasts:GetChildren()

							for _, v24 in v22, children, v23 do
								if string.find(v24.Name, "SeaBeast") and v24:FindFirstChild("HumanoidRootPart") then
									if (v24.HumanoidRootPart.Position - trialOfWater.Position).Magnitude <= 1500 then
										if v24.Health.Value > 0 then
											utilities:AutoHaki()
											utilities:EquipWeapon()
											local dodgefSeabeast = config.DodgefSeabeast and gameData:DodgeSeabeast()
											local n10 = 150
											local n11 = 5

											if dodgefSeabeast then
												n11 = math.random(-30, 30)
												n10 = 400
											end

											tweenManager:topos(v24.HumanoidRootPart.CFrame * CFrame.new(0, n10, n11), true)
											position = v24.HumanoidRootPart.CFrame.Position
											fn14()
											position = nil
											break
										end
									end
								end
							end
						end
					end
				end
			elseif tbl12[value] then
				tweenManager:topos(tbl12[value], true)
			end
		end, isSea3)

		fn28("AutoKillPlayerinTrial", function()
			if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				for _, child in pairs(workspace.Characters:GetChildren()) do
					if child.Name ~= localPlayer.Name and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
						if (child.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude < 300 then
							tweenManager:topos(child.HumanoidRootPart.CFrame * CFrame.new(0, 20, 10), true)
							utilities:EquipWeapon()
							utilities:AutoHaki()
							break
						end
					end
				end
			end
		end, isSea3)

		fn28("AutoChooseGear", function()
			local ok, result = pcall(function()
				return mods:FireInvoke("TempleClock", "Check")
			end)

			if ok and result and result.HadPoint == true or not result then
				local str5 = result and result.RaceDetails and result.RaceDetails.B == 2 and "Omega" or "Alpha"

				for _, v22 in ipairs({
					{},
					{ "Gear1" },
					{ "Gear2", "Omega" },
					{ "Gear2", "Alpha" },
					{ "Gear2", true },
					{ "Gear2", false },
					{ "Gear3", "Alpha" },
					{ "Gear3", "Omega" },
					{ "Gear3", true },
					{ "Gear3", false },
					{ "Gear4", str5 },
					{ "Gear4", true },
					{ "Gear4", false },
					{ "Gear5", "Default" },
					{ "Gear5", true },
					{ "Gear5", false },
				}) do
					pcall(function()
						mods:FireInvoke("TempleClock", "SpendPoint", table.unpack(v22))
					end)
				end
			end
		end, isSea3)

		fn28("AutoFindLeviatan", function()
			local v22 = GetSelectedBoat()

			if not v22 then
				tweenManager:StopBoatTween()

				if utilities:GetDistance(CFrame.new(-16927.451, 9.086, 433.864)) <= 12 then
					BuyBoatSafe("Beast Hunter")
				else
					tweenManager:topos(CFrame.new(-16927.451, 9.086, 433.864))
				end
			elseif not config.AutoIgnoreSeaEventsLeviathan and config.AutoFarmSeaEvents and not humanoid.Sit then
				local seaEventTargets = gameData:GetSeaEventTargets() or {}
				local flag4 = false

				for _, v23 in next, seaEventTargets, nil do
					local flag5 = v23 == "SeaBeast" and seaBeasts or enemies
					local v24 = next
					local children, v25 = flag5:GetChildren()

					for _, v26 in v24, children, v25 do
						if v26 and v26.Parent and string.find(v26.Name, v23) then
							local humanoidRootPart3 = v26:FindFirstChild("HumanoidRootPart") or v26:FindFirstChildWhichIsA("BasePart")
							if humanoidRootPart3 and localPlayer:DistanceFromCharacter(humanoidRootPart3.Position) <= 1500 then
								flag4 = true
								break
							end
						end
					end

					if not flag4 then
						continue
					end
					break
				end

				if flag4 then
					return
				end
			elseif not humanoid.Sit then
				tweenManager:StopBoatTween()
				local vehicleSeat = v22:FindFirstChildWhichIsA("VehicleSeat", true) or v22:FindFirstChild("VehicleSeat", true) or v22:FindFirstChildWhichIsA("Seat", true)

				if vehicleSeat and vehicleSeat:IsA("BasePart") then
					tweenManager:topos(vehicleSeat.CFrame * CFrame.new(0, 1.5, 0))
					task.wait(0.3)
				end
			elseif map:FindFirstChild("LeviathanGate") or worldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				tweenManager:StopBoatTween()

				if humanoid.Sit then
					humanoid.Sit = false
				end

				mods._FindLeviathan.Update(false)
			else
				tweenManager:toposboat(CFrame.new(-10000000, 30.0003, -1244.8584), true)
			end
		end, isSea3)

		fn28("AutoSailbacktoTiki", function()
			local v22 = GetSelectedBoat()
			local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")

			if v22 and not humanoid2.Sit then
				tweenManager:StopBoatTween()
				local vehicleSeat = v22:FindFirstChildWhichIsA("VehicleSeat", true) or v22:FindFirstChild("VehicleSeat", true) or v22:FindFirstChildWhichIsA("Seat", true)

				if vehicleSeat and vehicleSeat:IsA("BasePart") then
					tweenManager:topos(vehicleSeat.CFrame * CFrame.new(0, 1.5, 0))
					task.wait(0.3)
				end
			else
				tweenManager:toposboat(CFrame.new(-16892, 37, 384))
			end
		end, isSea3)

		fn28("AutoCompleteDracoTrial", function()
			local topHUDList = localPlayer.PlayerGui:FindFirstChild("Main") and localPlayer.PlayerGui.Main:FindFirstChild("TopHUDList")
			topHUDList = topHUDList and topHUDList:FindFirstChild("RaidTimer")

			if topHUDList and topHUDList.Visible then
				local dracoTrial = map:FindFirstChild("DracoTrial") or v2:FindFirstChild("DracoTrial", true)
				if not dracoTrial then
					return
				end

				for i = state.CurrentDracoStage, 6 do
					local v22 = dracoTrial:FindFirstChild(state.DracoSequence[i], true)
					local proximityPrompt = v22 and (v22:FindFirstChildOfClass("ProximityPrompt") or v22:FindFirstChildWhichIsA("ProximityPrompt", true))

					if proximityPrompt and proximityPrompt.Enabled then
						state.CurrentDracoStage = i
						local parent = proximityPrompt.Parent:IsA("BasePart") and proximityPrompt.Parent or v22:IsA("BasePart") and v22 or v22.PrimaryPart

						if parent then
							tweenManager:topos(parent.CFrame, true)

							if humanoidRootPart and (parent.Position - humanoidRootPart.Position).Magnitude <= 20 then
								fireproximityprompt(proximityPrompt, math.huge)
								task.wait(0.3)

								if not proximityPrompt.Enabled then
									state.CurrentDracoStage = i + 1
								end
							end
						end

						return
					end
				end

				local trialDoor = dracoTrial:FindFirstChild("TrialDoor", true)
				local doorTouch

				if trialDoor then
					doorTouch = trialDoor:FindFirstChild("DoorTouch", true) or trialDoor:FindFirstChildWhichIsA("BasePart", true)
				else
					doorTouch = trialDoor
				end

				if doorTouch then
					tweenManager:topos(doorTouch.CFrame, true)
				end
			else
				state.CurrentDracoStage = 1

				pcall(function()
					remotes.DracoTrial:InvokeServer()
				end)
			end
		end, isSea3)

		fn28("AutoTrialDracoTP", function()
			local trialTeleport = map.PrehistoricIsland:FindFirstChild("TrialTeleport")
			if trialTeleport and trialTeleport:IsA("Part") and (humanoidRootPart.Position - trialTeleport.Position).Magnitude <= 10 then
				mods._AutoTrialDracoToggle.Update(false)
				return
			end

			if trialTeleport and trialTeleport:IsA("Part") then
				tweenManager:topos(CFrame.new(trialTeleport:GetPivot().Position + Vector3.zero), true)
			end
		end, isSea3)

		fn28("AutoTTK", function()
			state.ActiveSword = nil

			for _, v22 in ipairs(state.SwordList) do
				local Moveset = utilities:CheckInventory("Moveset", v22)
				if Moveset ~= nil and Moveset > 0 and Moveset < 300 then
					state.ActiveSword = v22
					break
				end
			end

			if state.ActiveSword then
				if not localPlayer.Character:FindFirstChild(state.ActiveSword) then
					mods:FireInvoke("LoadItem", state.ActiveSword)
				end

				utilities:EquipWeapon("Sword")
				local enemies2 = utilities:GetEnemies({ "Water Fighter", "Sea Soldier" })
				if enemies2 then
					return subFunction:Attack(enemies2, true)
				end
				return utilities:MobsNextSpawn("Water Fighter")
			end

			local Moveset = utilities:CheckInventory("Moveset", "Shizu")
			local Moveset2 = utilities:CheckInventory("Moveset", "Saishi")
			local Moveset3 = utilities:CheckInventory("Moveset", "Oroshi")

			if Moveset and Moveset >= 300 and Moveset2 and Moveset2 >= 300 and Moveset3 and Moveset3 >= 300 then
				mods:FireInvoke("MysteriousMan", "2")
			elseif mods:FireInvoke("LegendarySwordDealer", "1") then
				print("Buy")
				mods:FireInvoke("LegendarySwordDealer", "2")
			else
				print("Hop")
				joinAPI("legendarysword", 2)
			end
		end, isSea2)
	end

	mods.CoreSetup = function(arg)
		if arg.SetupData then
			arg:SetupData()
		end
	end

	mods.CombatHooks = function(arg)
		if arg.LoadFunctions then
			arg:LoadFunctions()
		end
	end

	mods.RuntimeServices = function(arg)
		if arg.LoadLoops then
			arg:LoadLoops()
		end
	end

	local function fn27(arg, ...)
		local now = tick()
		local v22 = mods[arg]

		if v22 then
			v22(mods, ...)
		end

		print(string.format("[Quantum Onyx] %s initialized in %.4fs", arg, tick() - now))
	end

	fn27("CoreSetup")
	fn27("CombatHooks")
	fn27("RuntimeServices")
	task.spawn(fn27, "LoadLibrary")

	task.spawn(function()
		task.wait(1.5)
		mods:SendNotify("Quantum Fully Loaded", "All Functions, Modules, Dependencies, Successfully loaded.", 8)
		task.wait(1)
		mods:SendNotify("Quantum (INFO)", "Quantum Onyx Script is 100% Free and Keyless", 8)

		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Util/BloxFruitModule/Preload/Weebo.lua"))()
		end)
	end)

	return
end
