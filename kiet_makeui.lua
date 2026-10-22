do -- [patched] bo guard chong tamper, chay thang than script
	local fn = cloneref or function(arg)
		return arg
	end

	-- [patched] getgenv fallback so startup never dies on limited executors
	local GG = (getgenv and getgenv()) or {}

	while true do
		task.wait()
		if not (game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")) then
			continue
		end
		break
	end

	local v = fn(game:GetService("Players"))

	if v.LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
		if not GG.Team or GG.Team == "" then
			GG.Team = "Pirates"
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

	-- [patched] timeout so the UI still loads even if the game's Main menu
	-- never appears (old code hung here forever -> nothing was displayed)
	local __onyxMainWait = tick()
	repeat
		task.wait()
	until v.LocalPlayer.PlayerGui:FindFirstChild("Main") or (tick() - __onyxMainWait) > 25

	-- [patched] bo chan "already running"
	GG.KietNikaActive = true
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

	-- =====================================================================
	-- [OFFLINE PATCH] Toan bo module cua QuantumOnyx duoc nhung san vao file.
	-- Khong con bat ky request nao toi raw.githubusercontent.com.
	-- Nguon: https://github.com/flazhy/QuantumOnyx (commit 17f576a, 2026-10-18)
	-- Giu nguyen chu ky fn5(path, retries) nhu ban goc.
	-- =====================================================================
	local OFFLINE_MODULES = {}
	do
		OFFLINE_MODULES["Util/BloxFruitModule/Preload/Data.lua"] = [[return {
	QUESTS = {
		Sea_1 = {
			{1, 9, "Team-dependent", "Team-dependent", 1},
			{10, 14, "Monkey", "JungleQuest", 1},
			{15, 29, "Gorilla", "JungleQuest", 2, "The Gorilla King", 20},
			{30, 39, "Pirate", "BuggyQuest1", 1},
			{40, 59, "Brute", "BuggyQuest1", 2, "Chief", 55},
			{60, 74, "Desert Bandit", "DesertQuest", 1},
			{75, 89, "Desert Officer", "DesertQuest", 2},
			{90, 99, "Snow Bandit", "SnowQuest", 1},
			{100, 119, "Snowman", "SnowQuest", 2, "Yeti", 105},
			{120, 149, "Chief Petty Officer", "MarineQuest2", 1, "Vice Admiral", 130},
			{150, 174, "Sky Bandit", "SkyQuest", 1},
			{175, 189, "Dark Master", "SkyQuest", 2},
			{190, 209, "Prisoner", "PrisonerQuest", 1},
			{210, 249, "Dangerous Prisoner", "PrisonerQuest", 2, {"Warden", 220, "ImpelQuest", 1}, {"Chief Warden", 230, "ImpelQuest", 2}, {"Swan", 240, "ImpelQuest", 3}},
			{250, 274, "Toga Warrior", "ColosseumQuest", 1},
			{275, 299, "Gladiator", "ColosseumQuest", 2},
			{300, 324, "Military Soldier", "MagmaQuest", 1},
			{325, 374, "Military Spy", "MagmaQuest", 2, "Magma Admiral", 350},
			{375, 399, "Fishman Warrior", "FishmanQuest", 1},
			{400, 449, "Fishman Commando", "FishmanQuest", 2, "Fishman Lord", 425},
			{450, 474, "God's Guard", "SkyExp1Quest", 1},
			{475, 524, "Shanda", "SkyExp1Quest", 2, "Wysper", 500},
			{525, 549, "Royal Squad", "SkyExp2Quest", 1},
			{550, 624, "Royal Soldier", "SkyExp2Quest", 2, "Thunder God", 575},
			{625, 649, "Galley Pirate", "FountainQuest", 1},
			{650, 9999, "Galley Captain", "FountainQuest", 2, "Cyborg", 675},
		},
		Sea_2 = {
			{700, 724, "Raider", "Area1Quest", 1},
			{725, 774, "Mercenary", "Area1Quest", 2, "Diamond", 750},
			{775, 799, "Swan Pirate", "Area2Quest", 1},
			{800, 874, "Factory Staff", "Area2Quest", 2, "Jeremy", 850},
			{875, 899, "Marine Lieutenant", "MarineQuest3", 1},
			{900, 949, "Marine Captain", "MarineQuest3", 2, "Orbitus", 925},
			{950, 974, "Zombie", "ZombieQuest", 1},
			{975, 999, "Vampire", "ZombieQuest", 2},
			{1000, 1049, "Snow Trooper", "SnowMountainQuest", 1},
			{1050, 1099, "Winter Warrior", "SnowMountainQuest", 2},
			{1100, 1124, "Lab Subordinate", "IceSideQuest", 1},
			{1125, 1174, "Horned Warrior", "IceSideQuest", 2, "Smoke Admiral", 1150},
			{1175, 1199, "Magma Ninja", "FireSideQuest", 1},
			{1200, 1249, "Lava Pirate", "FireSideQuest", 2},
			{1250, 1274, "Ship Deckhand", "ShipQuest1", 1},
			{1275, 1299, "Ship Engineer", "ShipQuest1", 2},
			{1300, 1324, "Ship Steward", "ShipQuest2", 1},
			{1325, 1349, "Ship Officer", "ShipQuest2", 2},
			{1350, 1374, "Arctic Warrior", "FrostQuest", 1},
			{1375, 1424, "Snow Lurker", "FrostQuest", 2, "Awakened Ice Admiral", 1400},
			{1425, 1449, "Sea Soldier", "ForgottenQuest", 1},
			{1450, 9999, "Water Fighter", "ForgottenQuest", 2, "Tide Keeper", 1475},
		},
		Sea_3 = {
			{1500, 1524, "Pirate Millionaire", "PiratePortQuest", 1},
			{1525, 1574, "Pistol Billionaire", "PiratePortQuest", 2},
			{1575, 1599, "Dragon Crew Warrior", "DragonCrewQuest", 1},
			{1600, 1624, "Dragon Crew Archer", "DragonCrewQuest", 2},
			{1625, 1649, "Hydra Enforcer", "VenomCrewQuest", 1},
			{1650, 1699, "Venomous Assailant", "VenomCrewQuest", 2},
			{1700, 1724, "Marine Commodore", "MarineTreeIsland", 1},
			{1725, 1774, "Marine Rear Admiral", "MarineTreeIsland", 2},
			{1775, 1799, "Fishman Raider", "DeepForestIsland3", 1},
			{1800, 1824, "Fishman Captain", "DeepForestIsland3", 2},
			{1825, 1849, "Forest Pirate", "DeepForestIsland", 1},
			{1850, 1899, "Mythological Pirate", "DeepForestIsland", 2},
			{1900, 1924, "Jungle Pirate", "DeepForestIsland2", 1},
			{1925, 1974, "Musketeer Pirate", "DeepForestIsland2", 2},
			{1975, 1999, "Reborn Skeleton", "HauntedQuest1", 1},
			{2000, 2024, "Living Zombie", "HauntedQuest1", 2},
			{2025, 2049, "Demonic Soul", "HauntedQuest2", 1},
			{2050, 2074, "Posessed Mummy", "HauntedQuest2", 2},
			{2075, 2099, "Peanut Scout", "NutsIslandQuest", 1},
			{2100, 2124, "Peanut President", "NutsIslandQuest", 2},
			{2125, 2149, "Ice Cream Chef", "IceCreamIslandQuest", 1},
			{2150, 2199, "Ice Cream Commander", "IceCreamIslandQuest", 2},
			{2200, 2224, "Cookie Crafter", "CakeQuest1", 1},
			{2225, 2249, "Cake Guard", "CakeQuest1", 2},
			{2250, 2274, "Baking Staff", "CakeQuest2", 1},
			{2275, 2299, "Head Baker", "CakeQuest2", 2},
			{2300, 2324, "Cocoa Warrior", "ChocQuest1", 1},
			{2325, 2349, "Chocolate Bar Battler", "ChocQuest1", 2},
			{2350, 2374, "Sweet Thief", "ChocQuest2", 1},
			{2375, 2399, "Candy Rebel", "ChocQuest2", 2},
			{2400, 2424, "Candy Pirate", "CandyQuest1", 1},
			{2425, 2449, "Snow Demon", "CandyQuest1", 2},
			{2450, 2474, "Isle Outlaw", "TikiQuest1", 1},
			{2475, 2499, "Island Boy", "TikiQuest1", 2},
			{2500, 2524, "Sun-kissed Warrior", "TikiQuest2", 1},
			{2525, 2549, "Isle Champion", "TikiQuest2", 2},
			{2550, 2574, "Serpent Hunter", "TikiQuest3", 1},
			{2575, 2599, "Skull Slayer", "TikiQuest3", 2},
			{2600, 2624, "Reef Bandit", "SubmergedQuest1", 1},
			{2625, 2649, "Coral Pirate", "SubmergedQuest1", 2},
			{2650, 2674, "Sea Chanter", "SubmergedQuest2", 1},
			{2675, 2699, "High Disciple", "SubmergedQuest3", 1},
			{2700, 9999, "Grand Devotee", "SubmergedQuest3", 2},
		}
	},
	BossList = {
		Sea_1 = {
			{20, "The Gorilla King", "JungleQuest", 3, CFrame.new(-1602, 37, 153)},
			{55, "Chief", "BuggyQuest1", 2, CFrame.new(-1140, 5, 3827)},
			{105, "Yeti", "SnowQuest", 3, CFrame.new(1387, 87, -1298)},
			{130, "Vice Admiral", "MarineQuest2", 2, CFrame.new(-5036, 29, 4325)},
			{220, "Warden", "ImpelQuest", 1, CFrame.new(5192, 3, 686)},
			{230, "Chief Warden", "ImpelQuest", 2, CFrame.new(5192, 3, 686)},
			{240, "Swan", "ImpelQuest", 3, CFrame.new(5192, 3, 686)},
			{350, "Magma Admiral", "MagmaQuest", 3, CFrame.new(-5315, 12, 8517)},
			{425, "Fishman Lord", "FishmanQuest", 3, CFrame.new(61123, 18, 1569)},
			{500, "Wysper", "SkyExp1Quest", 3, CFrame.new(-7862, 5546, -380)},
			{575, "Thunder God", "SkyExp2Quest", 3, CFrame.new(-7903, 5636, -1411)},
			{675, "Cyborg", "FountainQuest", 3, CFrame.new(5258, 39, 4050)},
		},
		Sea_2 = {
			{750, "Diamond", "Area1Quest", 3, CFrame.new(-428, 73, 1835)},
			{850, "Jeremy", "Area2Quest", 3, CFrame.new(637, 73, 918)},
			{925, "Orbitus", "MarineQuest3", 3, CFrame.new(-2442, 73, -3218)},
			{1150, "Smoke Admiral", "IceSideQuest", 3, CFrame.new(-5429, 16, -5298)},
			{1400, "Awakened Ice Admiral", "FrostQuest", 3, CFrame.new(5669, 29, -6483)},
			{1475, "Tide Keeper", "ForgottenQuest", 3, CFrame.new(-3054, 237, -10145)},
		},
		Sea_3 = {
			{1575, "Stone", "PiratePortQuest", 3, CFrame.new(-290, 44, 5580)},
			{1775, "Kilo Admiral", "MarineTreeIsland", 3, CFrame.new(2179, 29, -6740)},
			{1875, "Captain Elephant", "DeepForestIsland", 3, CFrame.new(-13233, 332, -7626)},
			{1950, "Beautiful Pirate", "DeepForestIsland2", 3, CFrame.new(-12682, 391, -9902)},
			{2175, "Cake Queen", "IceCreamIslandQuest", 3, CFrame.new(-819, 65, -10967)},
		}
	},
	MaterialEnemies = {
		Sea_1 = {
			["Angel Wings"] = { "Shanda", "Royal Squad", "Royal Soldier", "Wysper", "Thunder God" },
			["Leather + Scrap Metal"] = { "Brute", "Pirate" },
			["Magma Ore"] = { "Military Soldier", "Military Spy", "Magma Admiral" },
			["Fish Tail"] = { "Fishman Warrior", "Fishman Commando", "Fishman Lord" },
		},
		Sea_2 = {
			["Leather + Scrap Metal"] = { "Marine Captain" },
			["Magma Ore"] = { "Magma Ninja", "Lava Pirate" },
			["Ectoplasm"] = { "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer" },
			["Mystic Droplet"] = { "Water Fighter" },
			["Radioactive Material"] = { "Factory Staff" },
			["Vampire Fang"] = { "Vampire" },
		},
		Sea_3 = {
			["Leather + Scrap Metal"] = { "Jungle Pirate" },
			["Demonic Wisp"] = { "Demonic Soul" },
			["Fish Tail"] = { "Fishman Raider", "Fishman Captain" },
			["Conjured Cocoa"] = { "Chocolate Bar Battler", "Cocoa Warrior" },
			["Dragon Scale"] = { "Dragon Crew Archer", "Dragon Crew Warrior" },
			["Gunpowder"] = { "Pistol Billionaire" },
			["Mini Tusk"] = { "Mythological Pirate" },
			["Nightmare Catcher"] = { "Reborn Skeleton", "Living Zombie" },
		}
	},
	Materials = {
		Sea_1 = { "Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail" },
		Sea_2 = { "Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang" },
		Sea_3 = { "Leather + Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk", "Nightmare Catcher" }
	},
	BossNames = {
		Sea_1 = { "The Gorilla King", "Chief", "Yeti", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Saw" },
		Sea_2 = { "Diamond", "Jeremy", "Orbitus", "Smoke Admiral", "Awakened Ice Admiral", "Tide Keeper", "Don Swan" },
		Sea_3 = { "Stone", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Cake Queen" }
	},
	MeleeNames = {
		Sea_1 = { "Black Leg", "Electro", "Fishman Karate" },
		Sea_2 = { "Death Step", "Dragon Claw", "Sharkman Karate", "Superhuman" },
		Sea_3 = { "Dragon Talon", "Electric Claw", "Godhuman", "Sanguine Art" }
	},
	Melees = {
		["Black Leg"] = {
			Model = "Dark Step Teacher",
			Npc = "Dark Step Teacher",
			npc = "Dark Step Teacher",
			CFrame = CFrame.new(-1147.284, 4.752, 3816.326),
			cframe = CFrame.new(-1147.284, 4.752, 3816.326),
			Remote = { "BuyBlackLeg" },
			remote = { "BuyBlackLeg" },
			Sea = 1
		},
		["Electro"] = {
			Model = "Mad Scientist",
			Npc = "Mad Scientist",
			npc = "Mad Scientist",
			CFrame = CFrame.new(-4842.112, 717.670, -2623.149),
			cframe = CFrame.new(-4842.112, 717.670, -2623.149),
			Remote = { "BuyElectro" },
			remote = { "BuyElectro" },
			Sea = 1
		},
		["Fishman Karate"] = {
			Model = "Water Kung-fu Teacher",
			Npc = "Water Kung-fu Teacher",
			npc = "Water Kung-fu Teacher",
			CFrame = CFrame.new(61122.652, 18.497, 1568.351),
			cframe = CFrame.new(61122.652, 18.497, 1568.351),
			Remote = { "BuyFishmanKarate" },
			remote = { "BuyFishmanKarate" },
			Sea = 1
		},
		["Dragon Claw"] = {
			Model = "Sabi",
			Npc = "Sabi",
			npc = "Sabi",
			CFrame = CFrame.new(699.029, 185.661, 654.895),
			cframe = CFrame.new(699.029, 185.661, 654.895),
			CFrames = {
				Sea_2 = CFrame.new(699.029, 185.661, 654.895),
			},
			cframes = {
				Sea_2 = CFrame.new(699.029, 185.661, 654.895),
			},
			Remote = { { "BlackbeardReward", "DragonClaw", "1" }, { "BlackbeardReward", "DragonClaw", "2" } },
			remote = { { "BlackbeardReward", "DragonClaw", "1" }, { "BlackbeardReward", "DragonClaw", "2" } },
			Sea = 2
		},
		["Superhuman"] = {
			Model = "Martial Arts Master",
			Npc = "Martial Arts Master",
			npc = "Martial Arts Master",
			CFrame = CFrame.new(1377.125, 246.542, -5189.951),
			cframe = CFrame.new(1377.125, 246.542, -5189.951),
			CFrames = {
				Sea_2 = CFrame.new(1377.125, 246.542, -5189.951),
			},
			cframes = {
				Sea_2 = CFrame.new(1377.125, 246.542, -5189.951),
			},
			Remote = { "BuySuperhuman" },
			remote = { "BuySuperhuman" },
			Sea = 2
		},
		["Death Step"] = {
			Model = "Phoeyu, the Reformed",
			Npc = "Phoeyu, the Reformed",
			npc = "Phoeyu, the Reformed",
			CFrame = CFrame.new(6356.472, 296.100, -6762.771),
			cframe = CFrame.new(6356.472, 296.100, -6762.771),
			CFrames = {
				Sea_2 = CFrame.new(6356.472, 296.100, -6762.771),
			},
			cframes = {
				Sea_2 = CFrame.new(6356.472, 296.100, -6762.771),
			},
			Remote = { "BuyDeathStep" },
			remote = { "BuyDeathStep" },
			Sea = 2
		},
		["Sharkman Karate"] = {
			Model = "Sharkman Teacher",
			Npc = "Sharkman Teacher",
			npc = "Sharkman Teacher",
			CFrame = CFrame.new(-2599.622, 238.198, -10315.998),
			cframe = CFrame.new(-2599.622, 238.198, -10315.998),
			CFrames = {
				Sea_2 = CFrame.new(-2599.622, 238.198, -10315.998),
			},
			cframes = {
				Sea_2 = CFrame.new(-2599.622, 238.198, -10315.998),
			},
			Remote = { "BuySharkmanKarate" },
			remote = { "BuySharkmanKarate" },
			Sea = 2
		},
		["Electric Claw"] = {
			Model = "Previous Hero",
			Npc = "Previous Hero",
			npc = "Previous Hero",
			CFrame = CFrame.new(-10368.514, 331.788, -10134.120),
			cframe = CFrame.new(-10368.514, 331.788, -10134.120),
			CFrames = {
				Sea_3 = CFrame.new(-10368.514, 331.788, -10134.120),
			},
			cframes = {
				Sea_3 = CFrame.new(-10368.514, 331.788, -10134.120),
			},
			Remote = { "BuyElectricClaw" },
			remote = { "BuyElectricClaw" },
			Sea = 3
		},
		["Dragon Talon"] = {
			Model = "Uzoth",
			Npc = "Uzoth",
			npc = "Uzoth",
			CFrame = CFrame.new(-9515.372, 142.130, 5535.089),
			cframe = CFrame.new(-9515.372, 142.130, 5535.089),
			CFrames = {
				Sea_3 = CFrame.new(-9515.372, 142.130, 5535.089),
			},
			cframes = {
				Sea_3 = CFrame.new(-9515.372, 142.130, 5535.089),
			},
			Remote = { "BuyDragonTalon" },
			remote = { "BuyDragonTalon" },
			Sea = 3
		},
		["Godhuman"] = {
			Model = "Ancient Monk",
			Npc = "Ancient Monk",
			npc = "Ancient Monk",
			CFrame = CFrame.new(-12463.870, 374.910, -7523.770),
			cframe = CFrame.new(-12463.870, 374.910, -7523.770),
			CFrames = {
				Sea_3 = CFrame.new(-12463.870, 374.910, -7523.770),
			},
			cframes = {
				Sea_3 = CFrame.new(-12463.870, 374.910, -7523.770),
			},
			Remote = { "BuyGodhuman" },
			remote = { "BuyGodhuman" },
			Sea = 3
		},
		["Sanguine Art"] = {
			Model = "Shafi",
			Npc = "Shafi",
			npc = "Shafi",
			CFrame = CFrame.new(-16548.800, 12.000, 412.300),
			cframe = CFrame.new(-16548.800, 12.000, 412.300),
			CFrames = {
				Sea_3 = CFrame.new(-16548.800, 12.000, 412.300),
			},
			cframes = {
				Sea_3 = CFrame.new(-16548.800, 12.000, 412.300),
			},
			Remote = { { "BuySanguineArt", true }, { "BuySanguineArt" } },
			remote = { { "BuySanguineArt", true }, { "BuySanguineArt" } },
			Sea = 3
		},
	},
	ItemsToBuy = {
		["Frags"] = {
			["Race Rerol"] = { "BlackbeardReward", "Reroll", "2" },
			["Reset Stats"] = { "BlackbeardReward", "Refund", "2" }
		},
		["Ability"] = {
			["Geppo"] = { "BuyHaki", "Geppo" },
			["Buso Haki"] = { "BuyHaki", "Buso" },
			["Soru"] = { "BuyHaki", "Soru" },
			["Observation Haki"] = { "KenTalk", "Buy" }
		},
		["Gun"] = {
			["Slingshot"] = { "BuyItem", "Slingshot" },
			["Musket"] = { "BuyItem", "Musket" },
			["Flintlock"] = { "BuyItem", "Flintlock" },
			["Refined Slingshot"] = { "BuyItem", "Refined Flintlock" },
			["Refined Flintlock"] = { "BuyItem", "Refined Flintlock" },
			["Cannon"] = { "BuyItem", "Cannon" },
			["Kabucha"] = { "BlackbeardReward", "Slingshot", "1" },
			["Bizarre Rifle"] = { "Ectoplasm", "Buy", 1 }
		},
		["Accessory"] = {
			["Black Cape"] = { "Black Cape" },
			["Swordsman Hat"] = { "Swordsman Hat" },
			["Tomoe Ring"] = { "Tomoe Ring" }
		},
		["Sword"] = {
			["Cutlass"] = { "Cutlass" },
			["Katana"] = { "Katana" },
			["Iron Mace"] = { "Iron Mace" },
			["Dual Katana"] = { "Duel Katana" },
			["Triple Katana"] = { "Triple Katana" },
			["Pipe"] = { "Pipe" },
			["Dual-Headed Blade"] = { "Dual-Headed Blade" },
			["Bisento"] = { "Bisento" },
			["Soul Cane"] = { "Soul Cane" },
			["Pole v.2"] = { "ThunderGodTalk" }
		}
	},
	Islands = {
		["Sea 1"] = {
			["Pirate Starter"] = CFrame.new(1047, 15, 1506),
			["Marine Starter"] = CFrame.new(-2728, 25, 2056),
			["Middle Town"] = CFrame.new(-688, 15, 1585),
			["Jungle"] = CFrame.new(-1614, 37, 146),
			["Pirate Village"] = CFrame.new(-1173, 45, 3837),
			["Desert"] = CFrame.new(944, 21, 4373),
			["Frozen Village"] = CFrame.new(1298, 87, -1344),
			["Marine Fortress"] = CFrame.new(-4810, 21, 4359),
			["Colosseum"] = CFrame.new(-1535, 7, -3014),
			["Lower Skylands"] = CFrame.new(-4814, 718, -2551),
			["Skylands"] = CFrame.new(-4652, 873, -1754),
			["Upper Skylands"] = CFrame.new(-7895, 5547, -380),
			["Prison"] = CFrame.new(4870, 6, 736),
			["Magma Village"] = CFrame.new(-5290, 9, 8349),
			["Underwater City"] = CFrame.new(61164, 5, 1820),
			["Fountain City"] = CFrame.new(5757, 91, 4017),
			["Jean-Luc Island"] = CFrame.new(-2850, 7, 5355),
		},
		["Sea 2"] = {
			["The Cafe"] = CFrame.new(-382, 73, 290),
			["First Spot"] = CFrame.new(-11, 29, 2771),
			["Dark Arena"] = CFrame.new(3494, 13, -3259),
			["Don Swan Mansion"] = CFrame.new(-317, 331, 597),
			["Don Swan Room"] = CFrame.new(2285, 15, 905),
			["Green Zone"] = CFrame.new(-2258, 73, -2696),
			["Graveyard"] = CFrame.new(-5552, 194, -776),
			["Snow Mountain"] = CFrame.new(752, 408, -5277),
			["Hot and Cold"] = CFrame.new(-6008, 29, -5018),
			["Cursed Ship"] = CFrame.new(919, 125, 32869),
			["Ice Castle"] = CFrame.new(5505, 40, -6178),
			["Forgotten Island"] = CFrame.new(-3050, 240, -10178),
			["Remote Island"] = CFrame.new(4816, 8, 2863),
		},
		["Sea 3"] = {
			["Mansion"] = CFrame.new(-12471, 374, -7551),
			["Port Town"] = CFrame.new(-340, 21, 5524),
			["Great Tree"] = CFrame.new(2205, 22, -6766),
			["Castle On The Sea"] = CFrame.new(-4980, 314, -3018),
			["Hydra Island"] = CFrame.new(5294, 1005, 391),
			["Floating Turtle"] = CFrame.new(-12528, 332, -8658),
			["Haunted Castle"] = CFrame.new(-9517, 142, 5528),
			["Ice Cream Land"] = CFrame.new(-843, 66, -10944),
			["Peanut Land"] = CFrame.new(-2082, 38, -10190),
			["Cake Land"] = CFrame.new(-1897, 14, -11576),
			["Candy Cane Land"] = CFrame.new(-1094, 64, -14519),
			["Chocolate Land"] = CFrame.new(219, 127, -12604),
			["Tiki Outpost"] = CFrame.new(-16224, 9, 439),
		}
	},
	PortalLocations = {
		Sea_1 = {
			Vector3.new(-7894.62, 5545.49, -380.25),
			Vector3.new(-4607.82, 872.54, -1667.56),
			Vector3.new(61163.85, 11.76, 1819.78),
			Vector3.new(3876.28, 35.11, -1939.32)
		},
		Sea_2 = {
			Vector3.new(-288.46, 306.13, 598),
			Vector3.new(2284.91, 15.15, 905.48),
			Vector3.new(923.21, 126.98, 32852.83),
			Vector3.new(-6508.56, 89.03, -132.84)
		},
		Sea_3 = {
			Vector3.new(-5058.77, 314.52, -3155.88),
			Vector3.new(-12463.87, 374.91, -7523.77),
			Vector3.new(28282.57, 14896.85, 105.1),
			Vector3.new(5661.53, 1013.09, -334.96),
			Vector3.new(5319, 23, -93),
			Vector3.new(5651, 1018, -350),
			Vector3.new(28286, 14897, 103)
		}
	},
	SwordData = {
		["Dark Blade"] = { Rarity = "Mythical", Order = 1 },
		["True Triple Katana"] = { Rarity = "Mythical", Order = 1 },
		["Cursed Dual Katana"] = { Rarity = "Mythical", Order = 1 },
		["Hallow Scythe"] = { Rarity = "Mythical", Order = 1 },
		["Triple Dark Blade"] = { Rarity = "Mythical", Order = 1 },
		["Dog Blade"] = { Rarity = "Mythical", Order = 1 },

		["Rengoku"] = { Rarity = "Legendary", Order = 2 },
		["Yama"] = { Rarity = "Legendary", Order = 2 },
		["Tushita"] = { Rarity = "Legendary", Order = 2 },
		["Buddy Sword"] = { Rarity = "Legendary", Order = 2 },
		["Shark Anchor"] = { Rarity = "Legendary", Order = 2 },
		["Fox Lamp"] = { Rarity = "Legendary", Order = 2 },
		["Dragon Trident"] = { Rarity = "Legendary", Order = 2 },
		["Saber"] = { Rarity = "Legendary", Order = 2 },
		["Canvander"] = { Rarity = "Legendary", Order = 2 },
		["Dark Dagger"] = { Rarity = "Legendary", Order = 2 },
		["Dragonheart"] = { Rarity = "Legendary", Order = 2 },
		["Koko"] = { Rarity = "Legendary", Order = 2 },
		["Midnight Blade"] = { Rarity = "Legendary", Order = 2 },
		["Oroshi"] = { Rarity = "Legendary", Order = 2 },
		["Pole (1st Form)"] = { Rarity = "Legendary", Order = 2 },
		["Pole (2nd Form)"] = { Rarity = "Legendary", Order = 2 },
		["Saishi"] = { Rarity = "Legendary", Order = 2 },
		["Shizu"] = { Rarity = "Legendary", Order = 2 },
		["Longsword"] = { Rarity = "Legendary", Order = 2 },
		["Pipe"] = { Rarity = "Legendary", Order = 2 },
		["Soul Cane"] = { Rarity = "Legendary", Order = 2 },
		["Trident"] = { Rarity = "Legendary", Order = 2 },
		["Wardens Sword"] = { Rarity = "Legendary", Order = 2 },
		["Bisento"] = { Rarity = "Legendary", Order = 2 },
		["Triple Katana"] = { Rarity = "Legendary", Order = 2 },
		["Twin Hooks"] = { Rarity = "Legendary", Order = 2 },
		["Dual-Headed Blade"] = { Rarity = "Legendary", Order = 2 },
		["Flail"] = { Rarity = "Legendary", Order = 2 },
		["Gravity Blade"] = { Rarity = "Legendary", Order = 2 },

		["Spikey Trident"] = { Rarity = "Rare", Order = 3 },
		["Fishing Trophy"] = { Rarity = "Rare", Order = 3 },
		["Shark Saw"] = { Rarity = "Rare", Order = 3 },

		["Iron Mace"] = { Rarity = "Uncommon", Order = 4 },

		["Cutlass"] = { Rarity = "Common", Order = 5 },
		["Katana"] = { Rarity = "Common", Order = 5 },
		["Dual Katana"] = { Rarity = "Common", Order = 5 },
	},
	BoatsList = {
		'Dinghy',
		'PirateSloop',
		'PirateBrigade',
		'PirateGrandBrigade',
		'MarineSloop',
		'MarineBrigade',
		'MarineGrandBrigade',
		'Beast Hunter',
		'Lantern',
		'Guardian',
		'Grand Brigade',
		'Sloop',
		'The Sentinel'
	},
	ZoneList = {
		'Level 1',
		'Level 2',
		'Level 3',
		'Level 4',
		'Level 5',
		'Level 6',
		'Infinite'
	},
	SeaEventTargets = {
		"Terror Shark",
		"Sea Beast",
		"Shark",
		"Piranha",
		"Fish Crew Member",
		"Pirate Brigade",
		"Pirate Grand Brigade",
		"Ghost Ship"
	},
	RodsList = {
		"Fishing Rod",
		"Gold Rod",
		"Shark Rod",
		"Shell Rod",
		"Treasure Rod",
		"Shark (Corrupted)",
		"Shell (Celestial)"
	},
	BaitsList = {
		"Basic Bait",
		"Kelp Bait",
		"Good Bait",
		"Abyssal Bait",
		"Frozen Bait",
		"Epic Bait",
		"Carnivore Bait"
	},
	DungeonCards = {
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
		"Gun"
	},
	TrainMethods = {
		"Bones",
		"Cakes"
	},
	LegendarySwordNames = {
		"Shizu",
		"Oroshi",
		"Saishi"
	},
	BossHopNames = {
		"Greybeard",
		"Darkbeard",
		"Cursed Captain",
		"rip_indra True Form",
		"Soul Reaper",
		"Cake Prince",
		"Dough King",
		"Tyrant of the Skies"
	},
	BossMap = {
		["Greybeard"] = "Greybeard",
		["Darkbeard"] = "Darkbeard",
		["Cursed Captain"] = "CursedCaptain",
		["rip_indra True Form"] = "Ripindra",
		["Soul Reaper"] = "SoulReaper",
		["Cake Prince"] = "CakePrince",
		["Dough King"] = "DoughKing",
		["Tyrant of the Skies"] = "Tyrant"
	},
	ScrollList = {
		"Common Scroll",
		"Rare Scroll",
		"Legendary Scroll",
		"Mythical Scroll"
	},
	ChestTiers = {
		"Diamond",
		"Gold",
		"Silver"
	},
	IgnoreNPC = {
		"Quest",
		"Boat",
		"Home"
	},
	DracoSequence = {
		"Relic1",
		"EndRelic1",
		"Relic2",
		"EndRelic2",
		"Relic3",
		"EndRelic3"
	},
	SwordList = {
		"Shizu",
		"Saishi",
		"Oroshi"
	},
	DealerFruitList = {
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
		"Dragon-Dragon"
	}
}
]]
		OFFLINE_MODULES["Util/BloxFruitModule/Preload/Visuals.lua"] = [=[return(function(...)local u,p,o,s,x,r,G,w,I,z,C,e,Z,k=string.byte,string.sub,string.char,string.gsub,string.rep,setmetatable,pcall,type,tostring,assert,loadstring,unpack,string.pack,{}local N={}local c=bit32 local y,L,O,J,B=_ENV,getfenv,metatable,unpack,"!!!"local U,d,S="-",true,nil local K,j=nil,0 local l={YaaPvbh7V="v!!!"}local u={";djcjEaa\'(Df,";"6Z6j[ARff";"FCB3&ATR";"49";"7qm-X6#:@1@;U.$Er","@UX:XE\\KFoA5+pM0er","@VfI`AH","7QG9Q2E3]jB2:=(;0`","8pFok2*kq1:JNfJ0E";";f4s9A5d2D6qp$Z;GI";"BhCBo9PA\'1CM5Y<","F`)/,@qu";"4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm0iASbq!FD50\"+@1$i4@=%\'DfRuo4o";"7;d6b","7!3NYFD5Z2","B3A/B1I=`ZGVi8SAjH";"@q]:k@:OCjEW";"EbTK)@;T^pH!t`)DIE","Bl.9kAP$D";"CLM(&Beo";"Ajf7%B5gF1CfkOV","9P%gX+@1$b";"8p+ui:iCPhEW";"11EmoEGeHnBN%K7",";fH/hD?","Anc9s6tpZ","1i[Op=@HA1E-Gf61N*","Df^%j=#P(b:JH(2","?XIMbA7]u";":I/bP7W)uq";"G&DU\\;+GqJChP_+","De*O\'2aq_\'G\\BNU63","E&KXf2agA0@V%K3EW","2HF<W:,,C@G\\ffAA,";"BQ[s!","A9Da+Gl";"@rH7,Ec5a";"6tp^PDf0H(@rq","@R=XFEC+MQAiDVf",":N^bjE^Ob]DfP";"<G43WCM,>\'>#7V*";";flGgF8","<b5\\t2F9lJ;KcVIG5","@<,ps@3B>oD09O","7<*HaE)^aoC]";"7;c[RBk;>","Eaj9%F)to7Bk07X0/57B0f:X=3&<HI0JGLH","H<PSrE(WboF(AolEW","9OVCAC]","Eaj9%F)to7Bk07X0/54<1,gmG0JkaI1GgjH";"8TR^E@<lR)B)";"E-\"H[B2<h.CMmZm75t","GB6G\\6>]Y)=`#iN","G@>N0","<+ouUCMm^)Er";"Eaj9%F)to7Bk07X0/5FE1GLmK1,q0H";":18!N";"AlN\\<7UgX!8To,G7Q:";"6#L=OATI";"B5KtV=`&\"96\"P._;u","8SqmKAQ3\\YDKBc*Eb0,uGl",";JBcWF<EkiD#";"E+*Hu","6!.hm>\"rpRH>.5A8H","<,Z\\k<,$:","5seU_EFi[#:,?TMEr","6#L=HC]","CbY","6t(+O6>U(@AOpBKA,";"=>=T(AMc5?8P2<g83m";"Eb065Bl[b";"2Fg/Z9hSYKB37W!";"6YKnKB4V";"6Z6jaEaa$2";"3(J4+=F!5%;cbh1";"2KDVo8Qfgq2G-DaBE","EctPfGu]/cE\\VMjE-M","6>U(?CEQApCLm","DgH&1Ec3p03D=!u1B";"=E8C`F\\kh\'96Ol:";"BOQ$eA9W-:9N+MS=%<",":i\'Q^AoD^,;flGcA,","=@6b1EbAq","6#L=HC`l(s+@0mXAS`JYCgh0lEr";"4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm0gCht4e@;U.$4@=%\'DfRuo4o";"Eaj9%F)to7Bk07X0/57B1c7$J3AEKO1bpjH";"Eaj9%F)to7Bk07X0/5.?2).\'F1,La?";"6#L=HC`l%r+@1*k@:O\'";"8O[;MG>W*S9Li/M";"8SqmKAH";"6Z6ja@;0UjEW","<affeAH",":3:S[F[Im%7Rh\'\"=]#","CLM(&B`","FE9BS8kF#(DcCU68iQ";"?XIGU","F)YQ3D?";"9jpP;<`\"$,=*$cL:&","88i<TBl7P";"<,ZnhBE","6t(1G9lFQRC]";"8T&]_EcYd","A79Lo","1Km^Q8Oc$j@S_2c",":3CD_ATC^\\EHPi1@qA;EH#R\\9DKG","6Z6dWARfgrDf/KbEcu/,AH";"@q]:k";"Eaj9%F)to7Bk07X0/57B3&EKM1GUjH3ArcM","6#L=HC`l\"q+@0mXAS`JeASbpdF(J]6";"<H)ngE`?stF)M";"FYnATFZ)Q@3I+4U8H","6YKnK@:OCjE^=5HARk","6Z6dZEW","8Qot/0R.&+3G:oZ7n!","H8nSnB2*#+79\"S,:JU",";Isf`Bk(RnARn_]DfT9!AH";"7qm-X6t(+O6>U(@AH";"B45Xg","F$iB2<b>oP@;StF","9kA-PAH",";fHD]Eb/0cBk(^q<\\a","75./0D.@f`6:+7R","4A]I%BleB)DBM>]D.RU+Bl@lQ";"FDl5BEbTE(";"@;f7I8h`4^BR+fB<W";"CGfX69P7pQ9K?6M:&","882UFASq";"<CCP<1&","DfTQ)Bl3";"7qHc","6Y\'^p7sRmGA5$er2+.","EG/3@BLcuV;,(n<","6#L=HCg\'2>@;0V#";";flG\\AH";"F[p.?:f:7LAlEG%AH","A4&q.H=;)-3,V_`H:e",":NC/^Bl3";"9PJ*MFD5T\'";"8MW(k:h=;tGZnQ4=&T","FEqh:De8";"G>:kV@9QT)Bl6aA";"8T&EWE^Ob]DfP","CLM(&Bf#";"@5DLn<&$.E7U^IL8Rq";":3CD_ATC[WDJ*M","F\\Gh(E\'d/R3+k]XH=6","0Mb7oF&ke)GC\"4;8ot";"FCB6+","Ao_g,;Fa%";"CghC,F%1(g","6>pdY<affeAH","E+*I$Er";"6#L=HC`l(s+@Bj`@r,^!88i<T";"Bk\'MLDg=0O:/G,/DZ",":N^a","CG9jF6T6u@3+5lJ","6o[t;GrJW4B2s+D7VV","<+0f[ATR";"2De2c=>aYJ0m[JH";"Bl7HmGQ";"2KV\\J2_o,fG\\MJ;G5";"Eaj9%F)to7Bk07X00(^H2`WlV1H@?N3AEA","3-&Lt>\'\"CSCLqF$E<","CfX5,3-fLb@9>fl","H>Rd`3AG5KDG<_sFo";"6tp^]CghS","=(l#a+CoC5H#IgJGA2,3+EVNEA8`T7Bln#2FD,B0+@9m_GT]IrF_Pq^","G%GQ0D#","@ps7L0`";"=&W4)Bjk[16SM\\$";"Bk2$k<,uDWCB","<GlAfF_PeoDf9H5";"9P&*SFD(","FD56#";"2-3sX;ccn32FqV#","Ao(mmAH",":dSi90NV%QE`6L<6SS","4o","6=WefGtD^n6qVB6<<","Eaj9%F)to7Bk07X00(mM2*!TU2E!BK2`ES";"EbTJ8CLM(&B`";"5uKC/7r27OCIDTSBk%","8Pj(WH=]ijC.`>aGAd";"6#LCR@<?F.";"=^ar];ctneCKP49";"2.KKeFDEQj@:E&6<W","<C_(-H?F@R7l<(uAc";"1Ic[W12gtc@qTjU","9PJ-QFD5W*","Eaj9%F)to7Bk07X0/5181c[QN0Jk[C3&riP";"9jq[PBlnK.AH","GXGCs8l[lI<A8Jk","4A]s+CLqT16tpLLDKBN1DE\\","CH+%jE-!`k9N#:Q3AC";"AnOe;G^<7i@qKUNBk[","0em*-@sMp;3I#=A";"6YL1MA3ja:ARk";"BQ%]t>\"3=:B)","F(\\#","3H%SnDE)3?:h+$/";"88i<U","D..NrBE","C1T2\"<c0p2854;\"";"5qt_aGXGmuH\"UT\"","@qRc@@7G0M6UXR6";"6>Udb7:p.C@rq";"=T","94`B9De*D";"Ci=K.";"8MG!SAMu>;<]!fD:K[",";K$YUE+NTk";"G@>3-";":dJ)VCKYaH@mY&k6pq";";fFWRBPD!Z@P^D-A,";";flqs","6Z6g\\Ch7^\"A,","EDeK8=][I8H?+\"&6@&";"BLHuZCLp78@;0Ri=T","0ekF;0f^sE0JkXD1H.,";"D_O+HAhZ54ECr-!";"F)Y]#Bjkf","Ecki#AT@","@:F9","F*(i2FAm!i@qB^XDf]W7Bl@k";"4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm0jBm+3.AKX9ZF?Dp/Ci=>W00T","H<3j1A3soa1i6bq<r","CLM(&Bf,","F(TX","6?5ObChn?BA8a=q",":iCDhFD5Z2","BQ%]t=o";"8T&6aBjkgVCghBu","6oIY<6V;Yb@;9=uD?";"Ap7?YD.@I)0K;sJEW";"<,Z\\k8Rl[V";"BLkrd;`@?`H\"^W)";"@8\'\'aA4oZ`=&im6:c8",":G>d`BJaBi8PrE42/3","DIn\"",".67";":..g\"DF.$@6W7nX<<";"7qm-X<+TrgASD";"Eaj9%F)to7Bk07X0/54=1cR6N0f1Z","CN<?t=>NEe7Up1E8,","6?HgX1O(oi770OI@V,","ApHg\"@T$/n:N83`AH";"6Xak3DfoQ\'";"Eaj9%F)to7Bk07X0/5.?3AN9D2E<HN3AWWT";"=(PfZDf/HaGAhM;Er";":M+3[ATR";"89JcXDJs6\";K$Jq:gnBd";":gn-RF*(i.+@Kp\\ASuR\'Df,","ASu$WCh[BjF&6drBln\'-D?";"88rB%Bjksq8T8<>DJ0","7qm-X6>U(?CI2iGF*%","9PA`l3)aWOH\"(2_","Bl8!\'Ec_";"6=FqH:gnBd","AT;j,E,]B!";"Eaj9%F)to7Bk07X0/tjK2DI3J3B.";"DGjt$=uKGU79*$#F8";"Eaj9%F)to7Bk07X0)",":N1DiDf.9";"1Li^`ED/]/@5g&$GA.","8T\\N\\8Rq";"@l.+t2,uS.G\"t@j";"9N+8uG\'H_>7;c^_";"F*)>>+EM=4A7TClB-8cKAo(n%BR\'","<HNOjGq`o613$0;";"<(\'&[=%,DQ","F),K+Cb\\IlCh*","87tk<=&rg!@Tc!+";"3Disn;KcPp7rC+<5l","7;c[RGuAR!F8";"8830TDg4TeFEDG<";"<(\'&[78[&V:]","CghC,6$.3W@qu","B4Z1,BQ@ZmA8,RcDKKT7Gl","4Aom4?UeI@Bl&&;882UGDfp.c";"Eaj9%F)to7Bk07X0/t^F1GUXE1,UdE2_Zr",":fM4T:GXk<3G;SQGXV","6Y1(FF*),)C`l#aF8";"<,ZeuDZ","7VQaN7VQmaF@0_UCh-=R6Yp1PEr","Bk(]","0f(LD0JkL@0ebC>1Gq/","6Xak\"Des6(A7Y","4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm0hCgggh+AR&pANW=uCi=>W00T","7qm-X6>U(?CJK\"fAH","<+U;rF`M$";"4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m;IO9W+@^BoBlnDY6Z6dZE]l\'>";"3E8d^6\"k@AFa5fC<-8";"Eaj9%F)to7Bk07X0/57A1GLjE3&W]Q3&*BM","4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m;fuqoDf-[`@q0(kF$)g.Ci=>W00T";"7;cXIA,";"6um3b","<,uDbF)YQ.ASu\"\'",";f#l`BN?k","D)G<l6r?Nu<,k8]0M)";"+=KfL3Zn";":iBiZATURRD09O","ApS;L;Jf!@8iLj;6i";":i^8e@<-Wi@<-G";"6>URb+@^BoBlj","8RaJU9JT.S;)`PjCeO","7qm-X;K$\\jAO^]_Blj";"F*(tZGYMam898`,","G==>]@o,H_<,c8U9)","G&\'T685=.Y8pYGhE``","<b5c_DfRW";"1,(Oq6#T25BPVQF","6t(+O6>U(@AOl";"@rc-hFD5Z2";":h**Q:,-ob;H?=H1ir","BQ%]t=9","EHOZqAhn$m6UXa-B64","BgkQ_78#HmDa?\'G","6#pOS@7t$GF_L","<,YQAC1Ums;fH/TAH","=o";"87c4?";":gnBdBk(sj0`","@r,^bEW";"7s/NA@VTIaF8";"6Xak!AOLQWE,]B!";"7S%/h:MX\'!:fTGJ9)";"6#L=HC`l\"q+@0mXAS`J[Derq","<,ZnhBLQfLARk","F*)G:DJ&";"B6@n","87?:BB`";"<*Ed!:,Q`R7lX-","7qm-X6Y1(FF*),)CdE)`","DK0W?@:`#>=#4l*7f","A7]RcGl","6Z6dZE^ObcEb/a&Bl@lXAnGUaF8";"7qHd0BPD9nEb0+","6Z6dZE`6OhF_,H#AH","<HMqk";"E,m[57R:j\'2H4d%7f";"AmoLcDf,";"<bZ&cBl.n";"1iIS9@n015H\"gbcAlA";"Eaj9%F)to7Bk07X0/5.@3AWQP2DI\'K2)dBQ";"@Vfb)H=:i)";"6#pOS@/";"@r#[ZF_jB31jD`@","<&.?eGXOo:FDt>c","8TR/","G%=Wl@SSh+:e#8:<FG","CdLa9=uUG(<d6VYB3,","EcFE5G?%[G6;gN;G&.";"9Q+igARk";":i\'QcATDh";"4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm1%ASuR#Bfnb$Ci=>W00T";"Ch[NqFDbf1B)","Eaj9%F)to7Bk07X0/5.92`*9K3&ruW1GCL;";">?5HZF^]*->p)^[Cgh3l+Du+>+D,P7DIal%DfRl]";"FCf?2ASD";"8T&W]DKBN6Gl";":iBiZATT%_Bl.F!F(oQ1","<(0_b+B)?;;FC","=@6M6ATD3HBOPUmEr";"DIIBn";";g3/#A,","=Z/*03,UKTCf*YrAc","H=_,8";"F(KH1ATV@&@:F%a";"6Yp[NCK,\"bAH","9jqQm1/i.4H#cJb5um";"Bk.";"6tp(GDeF3(6Z6jaEc5c1AT@","Ea`J",";)D3O;)h\'V92n]$2,=","1i@;)3+6`GF@1+81]";"Eaj9%F)to7Bk07X0/5.?3A`QP0K;!F0fD!N","7<icfDf]W2DGY7m","7qHd3De!p2ARnbOG]Z8jGQ";"F)Y]#BjkgD@ruF.@<?\'k";"8NA_2Bk1%>1e_Uq@f";";fH/hDK\'N8";"3(HAS<FJj1Cdg3T<_i";":i\'QcATC:`B`";"BOtUqASrW+@;U.$","<cKifEai!l1O!SX1NW";"8hamLG^++,CKYI.","C2J&^BN6ra0ks\'SFDC";"E+<<mC]","Cg\'PGG&0QX<DldS",":dIZ?;J]0);KbWV7f","","Ci=N/EW";"@rH6p@<;","7SS#\"FA5\\HG;W\')95\"",";K$2jAM$euB6@b","7<*HaE,]B!","4Aoa$?VG$DBl@l3882UGDfp.c";";e:&IEbTB!Ed:JiEcaZ<Ea`fr","DfT:","1hgW8;,M(#2)T>VC]","ARTY%";"8n)7M912Bn=Di\"5DZ",";e:&:FEDP;@Wcd(","Eaj9%F)to7Bk07X0/kaB2`<EL0f([A0K:r";"B6%F(BlnV","G#)sN=thm<0hG5&";"AlNM8DH1+^85DrW<r",";K?SI7<(4h0Q&g?<d+";">%r8!;)W<*@S0$[AH","<+^#::.%j\"CIg<q";"3W";"6Z6dZE\\d";">:\">t,qWC";"D`C3AEI)@gBgjaH<W";"=E-rHG]mV,2+q(a7;W";"8830TDg4TW@qu";"9l=unGsc(4=\'.dYBMJ","8830TDg4`lDf0X","87c4GFD(";"6>U(?CEPr[@<6M","8p+ui<,V","@l$eFE`cF_2ed&N";"Eaj9%F)to7Bk07X00)!J1GgmA0JPL@0fLu","7:C7ODJ)miH#.$";"Bm3?EH8[TZ7SR;b","DIl7FG\"GP/C/[!!9lL","0ekLC1c$pJ2)$^C0ebE","B6/3)","CKOP(=$eT21Mg,j85T",";fH/hDIm?MF)59&A9.","0f1R<3B8uQ2)d3C2`<M";"FEqh:",":3CD_ATC^\\EHPi1@q>";"Eaj9%F)to7Bk07X0/51>2_m9H3&`TP1c@3N","G@kH)7V6mDGstbDFu\'",";JBcWF@]hXA,";"3I+SI;bKe]Ed)Ok",";fHbg@:VZAB5D,",">?5HZF^]*->p*\'gD/F3/8TS]VDIal1AT;j,Eb0;7@3B`%Ch[E&Ble*!DIal-@;TQuF*)G:DJ(R","6#L=HC`l%r+@U0ZD0[6kBOPUmEr";"7VQaN7VQmaF@0_UCh-U\\Bk(gJF$T","7qHd<@VTIaFE7","Eb0<\'FAuskAT@";"8o77@=$g%I2H3dXEr";"@q]:kB4Y%VD.N","CI\'^E76,U+7rN9\\FT","77qB3De^t-B1dA+8c";"?XIV\\D?","+CSc%Bm*p,ARmDU6Z6dZE]l\'>","D,<oH<Hhkm=a=\"?;u","@Wc3lBOL";"Ci<`m9lFQRCdDrL<+TlWE,Tc=";"=YXhrC2Q%6G=F;]>#P";"Eaj9%F)to7Bk07X00(jC1c-pF2Dd0F2`NJ";"E,8s.AT@","=DL2X:bc$OD0SWc;,R","De<U&ATR",":N1DiDf.<";"8p=<Q82<_T3EJL*8l,","9Q+ib<b5c_DfP","<HD_l8T&KiFB!O)AH",";IsA]9P%jNDf-[gBk1dnF`[";":iCDhFD5Z20`";"6tpLLDKBN1D?","6\"F_QF*(?\"AS#B","F]:8!3HT\".>#/j,C]","DJ<j);-?P%@UjChC]";"Gu@(C1M/F92,@CG@5e","7Puo72J[JF2ebfuFo","@l?k6Ce[i#6;om37f";"7W`-59l)^D@PLb^9m?","FCB3&ATU:/";"1MTHq>&8@Z;/L/J";"G?.%#2Ip`J2.CD\\F(#","91h\'/;fb9&D+$Zb1dM","6Z,ReC,%DG95Rg-@/";"9P%gX87?CH",">#/aBF(KF";"E+*NrF*(i.+DYD&F_L","Eaj9%F)to7Bk07X0/54<0f_6J1,1I:2`EEN";"6t(+O6>U(@APr","7:C9","1NlJgGsa<39l\"ckBE";"Eaj9%F)to7Bk07X0/54:3&!$A2`3TL2Dd3E";";fH;ZA,";";flqsE+NP",">%(lBDGi/J8U)sKEW","D/!k";"D/;%)7X80S@7>ES9`";":iC&cFB!0S@VTIaFAm-e@q>","3)hS\'9m/Eb@mNUU69t","<,$GjAH";"Eaj9%F)to7Bk07X0/57B2DR!D1c-pC3B/fP";"6Yp[YAH","7ojOaD/M^eBP(b#";"Eaj9%F)to7Bk07X0/5.:1,L^A1c$gB2E<HG","F)Q2=A,";"GrKeHFa$D[6oSdsFT","G=bP#8kO4s1.sPn@9N","=(,o\\;fH;ZA,";"8oIjFBlS6@Fu)*G","3-Ir32cjF$CK!lACg$","FC]5D2E4<C6V]XD";"6t(+O6>U(@AP<","7qHd2G][M7FE:ApH=[",";JC(m7U^.JCj@-hEb0,s";"BlcRMFD5o0";"0PO[\"7p&T*91q04","Fa81LF]1RoA8an(Fo";"G\\9N$7QFmhAn<eeBm\'","87?CHCh3","D)\"CG","8830TDg4W\\DKKH1","8o.\"5ARn,!6#h\'(1e%";"6#LCR@<?4%D?",";.r<f2)%osAhmO_","6:kuIF`\'`?6:XU7GVK","E+j0$DJ==";"3(%S$EC+=oDJh0g9`","=\'\'QVC3)sb0fXGE";"7WNWcFE7","6Z5k48T[F)Cftn$=#B";"H?`)+G>p@R6t9);=9";"6#L1GDfSZmBl8\"","6#L=HCg\'5@F(\'$,ARTU7";"CM@m3F`(a",";flSiE+NP","G]-ML:2Xi:FAbY2AkN";">=*.EGT]IrF_Pq?A9)U-E+NQ4>l","82<eP2KO%!B1bT[","6t(+O6>U(@AMO";":,t12<&\\At3EK$M=9",";IOZY";"96j\'SDc1(76:P^!","6#L=HC`l\"q+@0mXAS`JeASbpdF(G";"9PJ-QF@g@^Cis<,@q>";"8T&KiF@C(XARk","1efeaC,g$&:N&c]";"91sCnF?\"G9;e\\a$G@^";"Eaa0)ATR";"87c4MFCJfiF8";"<)uV.BOjG&AjSFeGl","FE1r;","82Opp9iP%Z=*@_@63";"4@=%\'DfS!2Eb/g\"5!j((GT]IrF_Pq?","6\">\"NG%#K(A,";"<cN8-A2m:dBMg]I";"6:aU79l!F;G#*-s","Eaj9%F)to7Bk07X0/5:?2E3TR1,psF","E)LR^1IP2OCf<\\iBE";"6$bJ)@n\'FC=@Q_>BJT","G@bi;";"6ZQaHFCb","<,u\\lCh4_W@<--+6>U(@AH";"Eaj9%F)to7Bk07X0/kX?1H.0H1GUjG3&r_";"<,ZnhBOt]",">?5HZF^]*->p)UFBl%?k+EVNECi<`m+A6-[F_Mt8De*Eq+CT>4ATTs","3[c:b.OdC","ART4fAH";"6YKnK@:OCjEW";"ATDg0EW","=YWs#8TmR\"<EM8%82L";"?6sYB-n[)#-$(O]",";flquAH";"0h+Z16uOk<68:cH";";f?erA,";"6#L=HC`l(s;IsZU@<5u";";JC(m7U^.JCj@-oBk1dnF`[","H\"BlA92S#cF^\\uE1&";"Eaj9%F)to7Bk07X0/5:?0f(L?0JbF>","4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm0hCgggh+@9mQF*\'N3Des?44YJu";":iCDhFD5Z20E","6?u4M7n$-cGVi\';D+=";"EG9E&@l@FtH?_/CF@u";";/A]uDb#+h920(T:1X";"EE6Lf9lFoM3DF]W","<G6Y<2cNpHH?4(,","6#LCR@<?4%DFn@","Eaj9%F)to7Bk07X0/kjK2DmKT2`EKN3&3;";"9lFQRC]";"E_:1FCNjMnD-0SCC&";"A8+goBeX^@C3`ob6N";"@<ca+<b,`d2E527<(?";"87c4QASrVYBl.F!F(oQ1";"8830TDg5/oB4uA","<-MnbDFn_XDZ";"6r-]h=_M5cG=Y#%";"89JcXDJs6\"";"7VQaN7VQmaF@0_UCh*";"B6@o`@;TQ";"G%Ptq@<-G","3ANEL1c6sI1c.3K1be";"=`8>\'1&","9ec","6Yp1PF&$.\\AH";";K$YcFD5Z2","@W-*m";"=(Q2Y6Z6j`FE1f(DKG","Eaj9%F)to7Bk07X0/57C1,q3L0f(UB3B/rT";";,V\"\'BeV5N;,M9j";"<+U;rF`M%bA,","3Fkd\':N://1IGbL:Nc";"6>URYD+/&KARff";"H<3Tq0M6%G2fEt@>$(";">&-ZD8S2\"K>$!J*;JZ","F)Yi(AT@";"9Q+?M6#LCR@<?4%D?";"B45i";"F(eumDg)","6#L=HCg\'8PE,9H6Bl@k","D/=8gB0o\".2f<nDED?","BL,\'@A40?RBjt!t=>g";";K$Jq";"6oe.YG?SHG=A30X@f","@ngrT=Ct]ZCe.](=9","7:C7ODJ)@OEb/a&Bl@k",":fD77<FJs+1g\"rj70","7qHd:De*Eq6Ul*)D.N","6#L=HC`l\"q+@UNoCi=B/Df,","2f!8P=B\\-O8k)-A3<";"CLM(&Bef","6t\\tgD/=)g7rW0<";"B6@o[D..\'g","3&`j.<F],j6rRZ3;u";"6t(+O6>U(@AMF";"6=FA>E+*6l";"6?RBlDf.9tDg-(";";GUj_G#W@!0k5<;Aha","<b5c_DfRT","@WZa31M(lQ@RXd8";"9iG&.A2&0pEA;9?";"6N","0ebF?1-%\'E3&EP";"7U^@[9PJ-QFDbf1B/0","@<>1S@<6NdDIlj_@ruF%","GAhM;F)YPtAH","0iU&2CLUpH78e+oH?f";"@q\\S.7qP>):f;1)H8k",";fuqoDf/-fCgh3l";"DaI$?G;O/(=]ACA";";JC)>@;T^pGt;X[AT)^5","77UL%1,X)<3DVVFE_Z","CjBndBi\\#L6W-ftAc";"=9","7VQj[EAVB!E_(IJDb^";"8TR:2F(8d!A79@t:M\'";"1dt/J7WCmu:igSP<,V","1M_8=FDO]O3E\\=`Du";"G\\p)RDD>(26T-Z5C]",":,R)_GqjOu@Ralb@K","<,Z\\k";"=\'BBPF_3U11KnR<";"BOtUqASu$mD.RU+Bl@k";":i\'Qc";"F(KH8BQ@ZmA8,RcDKKT7Gl";"4B#g\"4o";"4Aom4?UeI@Bl&&;GT]mqA7&#AB5):%+@1$ZDIG^";":gnBUDKG";"6#L=HC`l\"q+@:!WGp#LhF(\'$,ARTT","8830TDg2";":3C>`","87c4QASt.LD09O","=)0Nb1g\"6iA54sj;#","=(,fb7W3<7BPD9n","E,T6%ATVHsD.RU+Bl@k","BMNP,C,et$8kX5\'";"?Uk","1i?)F<C\\f4<GleM2d-";"A8cU\'BE";"1ic62Gr][s5snF^",";HZXi9L`u0Anc*k","F[8Dn3)XC$<+SWpECB";"=(,fb","BQ%]t=@R+8B)";"=\\`-pF&dO-6npB1","BlIKpEcV","6Ul*)D.N","<+U)j@;0T","DcTamCbfX\"BfU<M","6?QgLGl","Eaj9%F)to7Bk07X0/5.<3&NBL1GCR>2D[\'E";"6#L=HC`l%r+@UNoCi=B/Df,";"Eaj9%F)to7Bk07X0/kRA2E3NM2*!BN1,Ui","=uLC[=(QVB8S)\'k";";0?;X";"2-\"3b;.aZGDerEK","1eW\'[AkG(+E(Oqh";"H=Bll7s\\!/:NgnKC&","D..9uDffX","0ed9<3GLlk2JmXo7TT";"@l._\"9MeMoBlZsP","6#L=HC`l\"q+@:!WGp#LhF(\'$,ARTUd1&","Eaj9%F)to7Bk07X0/5.72)70O0JYF<3ANQM";"8U\"Zf=`6kcG;r\'42Fd";"@rH3nDc:ahDu";"6#L=HC`l(s+B3&lAKX<JCht4\\Eb/Zp";"8830TDg56\"Du";"B4u4)F8","7qHd@ATDs*E`?aiAPR/f";"@ps7bAS_","Eaj9%F)to7Bk07X0/51<1GC^F3AE6B2`WZS","7qHd@ATDs.@q>","FDl&>D.7\'s";":2b5gAnba`FD5Z2";";e\'6PAH";"Cbb";">=*.EGT]IrF_Pq?F*)>@ARmE!","9efao1.?@Q9Q\"9A8H";"AQWeMAn*Y`Bgm#RB2S";";*dcECemVuGZ]9*";";KZkUATDs.@q>","Eaj9%F)to7Bk07X0/GRE3&!<H3B8h";";IsijBl[d+87?CHCh3","1NkKU;aNf12ecrA","BQA%","<,ZnhBN/DZ";"8T&Tk@;]Rd";"6\"FM*@:o",";e^Ph","<c;esD.N","Ea`irDf#";"@5Ku^<\'aW#85_6&C&",":gnBd";":et-";"@5W@U:/4>S6Zl@FC&";"FAXr7CMlFa7lb\':","6YKnMFCet","@;di<E\'[)pFYl$F";"BmOGZA2SU?H\"1>S;d\'","8SqmKAQ!)LFAln\"AH","1GEQa:j,Z9D0S!T","7<iBRF`_0","7:p.C@rq","<+p;`F(fK.A,";"AP+b\'7q#S@Bi/P2";"H\"D)3";"+CSc%Bm*p,ARmD94@=%\'DfRuo4o","=)CnmF@8eX8pGQ$";"D..\'o@/","-$(P?7V5qHF_PqDF\"/F","C3N68@o#]j9lONTAOQ";"Eaj9%F)to7Bk07X00(pH2`3KP0ekR@1c[A";"Anc-n","3GUHQ;b9JV1.$\"tAc";"=@6b1E^OMKBl7t","2I\\scG%+9W:,#+<1&","7qm-X7WNWcFAcO]D?","<b6)c@qg%1;fHbg@:T","8T&KiF@\'PO@;Z";";Iso\\FAHdQE+*s.";"9l<^=2)B?!@X2C-=&f","883/","FCB3&ATUaeEr";"GYi9J=\"m&t7Vke$:Mp";":N1DiDf.?";"E(;d2G]uYI<,kKJ8TX";"<HD_l8T&KiFAlakG%kGt";"7;cOCCh7,","Ao)0mF%1(g","DaJ1n=]Im\\Eb]?7EDQ";"Eb/ctAS5^qDJ3`pAT)^5","<-MnbDGt+eG%kGt";":L[sGDG*?>7;c[=D#","6#L=HC`l(s+B3&lAKXonDf>";";f#l`BN?n","B0p0+@o,sD6:G@%CB";"6tpgYDIjqVEc_";"6#L=HC`l(s+@1$gDg*<nBl[b","2_eJi:.eDNCI^=/",">?5HZF^]*->p)UFBl%?k+EVNECi<`m+DGn5@;]TuD/WrrC`m>.EZb",";d*0Y=\\^u%CiW0)C&",";KZj","Ch[NqF8",">=DtBBl7Q+6>URb+@^BoBlks[/mS";"EHP]*AH","9lG/qAO:N]FDl%O";"EbTK)@;T^pH\"^o&AT)^5";"6?6dQBQS-\'F)q";"6#L1GDfTE\"",";IMmm3Abee7WV+:Gl","3([jA:jP#[@rua0C&","7ri$I","8SqmKAP?NAAS_","E^=S!=DLo:@8LSo9go";"8830TDg4reAon";"E+*NrF*(i.A8,mlDKBN1D?","F(o9)","<HDhq@Rr4oH;/Hl";"<bZVt@;JDRF_Pp",";f?erA4^;";"FCAWpAH";"9Q!<W;b1k+E-ZV>";"6t(+O6>U(@AMX";"8Qe&^=[b;DB2rJ[";"<,X[\'E)17\'8k:[KA,",";e\'iZASt\"\\B`","D..O\"";"87?R=@:o","6#L=HCbb";"7qm-X6tpgYDIl+SF8";"F^m*^137SXE_]G\'>#t";"A4]gGGq_]`DK\\ld";"B4Z0tASuY","B4Z1%ATV@&@:F%a","B1ZcZ79\"AHH#6JQBE";"9OW-6CjLAJ;DWPjEH;";":iC&cFA-C]BQO","88i<T7!3NYFD5Z2","Ec6)<A,","9P$M%;0Q)b@8D,>:]";";JBcWF8","@rFYQ=DMJB3+6NAFT","A8,IhDf0(";"Eaj9%F)to7Bk07X00(^@1c.*J1,h*G2)@/","<cr(Y93\"eDG\\0B28n@";"7qHd1ATM?mDId0nFE7";"0hF/YAO1>m0M5hP",":gnBdBk(sj1&";"F)Yi6Blj";"9N!WH9j\'kCC3=<$","A9Dp$FD5Z2",":gnBd0E";":hb)kFB!/","7lP%$3Djg787tI^","0Q286BQ@p\'G\\pDk","9Q+ELCf\"qVH\"D!";"G$&lV2b.pDA7fOI5l","GskVQ3I*VU@9>F\'","D00r8De*Tk13>?jGQ";"9LW#O0QKd/DGWrA7f","A2J-uCH-0/=]@.kD?";"<+U;r","B6J\'$6o/Fk;+4?\"","G%Pu7@;U.$";"7W_OL@Sf\'P@9>L\"";"4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm1#Dfo](+@^BoBllI)Des?44YJu","4@=%\'DfS!;F`MG;ANit6@;^10D\'2VlH$D@m7qlRWARlp/Dfm1%EbTK/AKXBLEbf-#@:Wq36Z6dZE]l\'>","6tLF]Ec64";"<GlAfF_Pf6ARk";"7ScHF<]Ei`1e:A.";">\"rp;7qR$::/=hlA,";"B5M(!@qY",";c%I.84GI7A9(Fi9`","Eaj9%F)to7Bk07X0/t^I0ekCC0JG:=1,gr";"2_[s-9fR5a12&F47lU","<bZVt@;L!Z";"6tLFLASu$eDKJcfD/XT3DJ&","6YL1MA5ZuUDg#]&";"6?P:cH<GN+D*_WP";"<,$)H;)gp4H8o#J@f",":gn-RF*(i.94;[[B`";"7qHd=CghU\'DJ)7QBl.:#Bl@lgEa`HnEr";"DF.5Y;/.t.@:Mkr","Eaa05ATR","@s)g4ASuTUDJ<q";"Dg+K96tTV3BP;O\"";"G#_\"P=B0<b=DK]`";"@S07;ATLRU8m+k[","6=FA>B6%p5DIc^e@;^.*@<,ps@sJ",";IsB4AS5^qDFeJPAT)^5",":O4rZ<GXL:Df92gF8","=`8F*6#pNZ9Q+uo+T";";JC)C@;U.$";"0etXE3&<KL0K:aH2`NS","0h4u)88*$09km\'t","CJ-WD;IWa<6Xk@b";"=BA@&2.Kg#8ht6l","7qHd:Dfp,4","G^4+CFuaP_6u5[u<<";":g%C41.4l\'F\\ZUfB2&","<,$5l6Z6dZEW";"H>I\\==&*XR;,g+sEW";"@l%Or=EJS#3(He6";"<*3%;E%k:$>\"M1d","2b7jh0fa/k3,hf+";"D..Y","8SqmKAQ!)LFAHL\\F(KF",":gnBdBk(sj7;Za\\FCfI";"CeRH$EB$ol8S_6s@f"}for p,o in ipairs({{1,879},{1,578},{579,879}})do while o[1]<o[2]do u[o[1]],u[o[2]],o[1],o[2]=u[o[2]],u[o[1]],o[1]+1,o[2]-1 end end local function p(p)return u[p-11993]end do local p=u local o={}local function s(u)local p={}local o=1 local s=#u while o<=s do local x=string.sub(u,o,o)if x=="z"then table.insert(p,string.char(0,0,0,0))o=o+1 elseif x:match("%s")then o=o+1 else local x={}local r=0 while r<5 and o+r<=s do local p=string.sub(u,o+r,o+r)if p=="z"or p==" "or p=="\n"or p=="\r"then break end x[#x+1]=p r=r+1 end local G=#x for u=G+1,5,1 do x[#x+1]="u"end local w=0 for u=1,5,1 do w=w*85+(string.byte(x[u])-33)end local I=G-1 for u=3,3-(I-1),-1 do local o=math.floor(w/256^u)%256 table.insert(p,string.char(o))end o=o+G end end return table.concat(p)end for u=1,#p,1 do local o=p[u]if type(o)=="string"then p[u]=s(o)end end end return(function(u,s,x,r,G,w,I,j,C,d,S,J,k,o,y,K,O,N,e,z,U,L,B,Z,c)d,J,e,U,O,c,z,y,K,N,o,S,C,L,k,j,B,Z=function(u,p)local s=k(p)local x=function(x,r,G,w,I)return o(u,{x;r;G;w,I},p,s)end return x end,function(u,p)local s=k(p)local x=function(x,r,G,w)return o(u,{x;r;G,w},p,s)end return x end,function()Z=Z+1 C[Z]=1 return Z end,function(u,p)local s=k(p)local x=function(x,r,G,w,I,z)return o(u,{x;r;G;w,I,z},p,s)end return x end,function(u,p)local s=k(p)local x=function(x)return o(u,{x},p,s)end return x end,function(u)C[u]=C[u]-1 if C[u]==0 then C[u],z[u]=nil,nil end end,{},function(u,p)local s=k(p)local x=function(...)return o(u,{...},p,s)end return x end,function(u,p)local s=k(p)local x=function(x,r,G,w,I,z,C)return o(u,{x;r,G,w,I;z,C},p,s)end return x end,function(u)local p,o=1,u[1]while o do C[o],p=C[o]-1,p+1 if 0==C[o]then C[o],z[o]=nil,nil end o=u[p]end end,function(o,x,r,G)local Oy={}local Ly,g,H,wy,Z,q,Ny,ry,l,i,a,V,F,W,N,xy,I,cy,h,f,C,M,E,v,zy,P,n,oy,Cy,sy,ky,Iy,X,Zy,R,y,b,t,D,py,T,k,Gy,Y,yy,m,Q,uy,ey,A while o do if o<8448061 then if o<4397623 then if o<2088268 then if o<988605 then if o<494986 then if o<225975 then if o<108156 then if o<38057 then if o<24636 then if o<15025 then if o<14758 then o=7872311 C=z[r[2]]I=C else o=u[p(12127)]I={}end else if o<17106 then I=C o=Z o=5567558 else o=I and 16332665 or 582324 end end else if o<36494 then if o<32303 then o=z[r[1]]o=o and 13128075 or 10567974 else I={}o=u[p(12077)]end else g=p(12711)a=o X=u[g]Y=X l=o o=X and 2115447 or 16656001 end end else if o<73634 then if o<72853 then if o<52804 then o=0 z[r[1]]=o I=z[r[2]]o=I and 11837449 or 8497679 else o=z[r[1]]I=p(12530)I=o[I]I=I(o)o=9802922 end else k=p(12281)N=p(12755)k=Z[k]k=k(Z,N)o=k and 16252701 or 14747357 I=k end else if o<94483 then if o<81292 then o=false I={o}o=u[p(12009)]else I={}o=u[p(12214)]end else I=z[C]Y=p(12369)Z=p(12801)o=I[Z]Z=e()N=p(12369)z[Z]=o k=z[C]I=k[N]X=p(12002)k=p(12152)o=I[k]N=e()I=p(12328)k=o o=u[I]I=p(12391)I=o[I]I=I(o)z[N]=I l=u[Y]Y=p(12810)W=l[Y]a=u[X]X=p(12059)Y=a[X]V=p(12489)a=p(12369)l=W(Y,k)Y=u[a]a=p(12630)W=Y[a]a=0 g=u[V]V=p(12065)X=g[V]V=-35 g=X(V)X=0 Y=W(a,g,X)a=p(12369)D=p(12489)W=p(12152)y=l*Y I=y[W]Y=u[a]a=p(12810)l=Y[a]g=p(12002)X=u[g]g=p(12059)a=X[g]X=p(12369)Y=l(a,k)a=u[X]X=p(12630)l=a[X]V=u[D]X=0 D=p(12065)g=V[D]D=35 V=g(D)g=0 a=l(X,V,g)W=Y*a l=p(12152)y=W[l]o={k;I;y}y=o I=p(12368)o=u[I]Y={o(y)}W=Y[2]l=Y[3]I=Y[1]o=3521123 Y=I end end end else if o<187831 then if o<152100 then if o<124005 then if o<118483 then o=u[p(12603)]I={}else N=p(12801)C=p(12132)o=z[r[1]]k=z[r[2]]I=p(12346)y=.5 I=o[I]Z=k[N]N=.7 k=nil I=I(o,C,Z,k,N,y)o=u[p(12334)]I={}end else o=I and 2482412 or 7854997 end else if o<182932 then if o<166436 then o=I and 5364801 or 2290790 else sy=I o=sy and 7000464 or 497659 end else Z=p(12628)C=x[1]I=C[Z]Z=p(12246)o=I==Z o=o and 8482220 or 15145305 end end else if o<200561 then if o<194996 then if o<193254 then m=g==V o=6718182 Q=m else o=u[p(12162)]I={}end else o=u[p(12161)]I={}C=nil end else if o<221182 then if o<209463 then P=1 N=z[r[9]]l=z[r[13]]Y=true g=p(12460)W=N(l,Y)Y=p(12483)z[r[8]]=W l=u[Y]Y=p(12828)t=p(12801)N=l[Y]Q=p(12346)Y=z[r[11]]a=z[r[12]]o=13267786 D=z[Z]V=D[t]t=.8 D=nil Q=a[Q]X={Q(a,g,V,D,t,P)}l=N(Y,s(X))else o=z[r[3]]I={}N=false k=o(Z,N)k=p(12802)Z=nil N=false o=z[r[1]]o[k]=N N=p(12769)k=z[r[1]]o=k[N]N=false k=p(12663)o[k]=N C=nil o=z[r[1]]k=p(12007)N=false o[k]=N N=p(12366)k=z[r[1]]o=k[N]k=p(12663)N=false o[k]=N o=u[p(12102)]end else I=z[r[1]]C=x[1]Z=x[2]o=not I o=o and 10177511 or 15059832 end end end end else if o<393600 then if o<324077 then if o<261465 then if o<255217 then if o<238971 then Q=z[C]m=p(12022)o=Q[m]Q=p(12530)Q=o[Q]Q=Q(o)o=15607685 else I=z[r[5]]N=z[Z]k=I(N)Y=p(12801)N=e()z[N]=k V=p(12369)l=p(12424)I=z[r[6]]k=I()I=z[r[7]]a=1 W=z[r[8]]y=W[l]W=false k=I(y,W)I=z[r[9]]l=z[Z]y=p(12227)W=l[Y]k=p(12346)P=-5 Y=.75 l=nil t=0 k=I[k]k=k(I,y,W,l,Y,a)Y=p(12801)k=p(12346)I=z[r[9]]y=p(12680)l=z[Z]a=1.2 W=l[Y]Y=.7 k=I[k]n=o l=nil k=k(I,y,W,l,Y,a)y=p(12719)k=u[y]y=p(12027)I=k[y]y=.3 W=O(11140300,{r[9],N;Z})k=I(y,W)M=o y=p(12719)k=u[y]W=J(14390499,{r[9];Z})y=p(12027)I=k[y]y=.5 k=I(y,W)Y=p(12369)W=p(12305)I=z[r[10]]l=z[Z]D=p(12369)g=z[Z]X=g[V]V=u[D]D=p(12810)g=V[D]D=0 V=g(D,t,P)Q=p(12069)a=X*V X=p(12845)V=p(12670)t=p(12023)g=z[N]v=z[N]R=v o=v and 6778083 or 15738842 P=true D=nil end else if o<257002 then k=z[r[1]]N=p(12683)o=15397495 Z=k[N]k=p(12365)k=Z[k]k=k(Z)I=k else o=z[r[5]]I=o()o=4360275 end end else if o<282449 then if o<277063 then R=o V=P M=e()m=p(12281)m=W[m]m=m(W,V)z[M]=m n=z[M]o=n and 4856617 or 1887626 m=n else o=t()g=c(g)N=c(N)t=nil V=c(V)X=c(X)o=P()D=c(D)P=nil k=c(k)y=c(y)l=c(l)v=nil o=Q()o=m()C=nil W=c(W)a=c(a)Y=c(Y)m=nil o=M()o=u[p(12139)]I={}Q=nil M=nil n=nil Z=c(Z)R=c(R)end else o=3320111 a=1 Y=W[a]l=not Y I=l end end else if o<347800 then if o<338528 then if o<332726 then P=p(12801)t=p(12801)D=X[t]t=C[P]V=D-t D=p(12762)o=V[D]V=o t=V<N o=t and 4242286 or 9327085 D=t else o=u[p(12595)]I={}C=nil end else o=u[p(12458)]I={}end else if o<386411 then if o<355447 then I={}o=u[p(12844)]else Z=o N=z[r[2]]k=not N C=k o=k and 5332569 or 15104 end else k=p(12663)o=z[r[4]]I=o()o=true N=true z[r[2]]=o I=z[r[5]]I[k]=N I=z[r[6]]k=I()I=z[r[7]]o=I and 6364779 or 15168623 end end end else if o<453573 then if o<428810 then if o<409972 then if o<399807 then o=p(12310)Y=p(12801)o=C[o]X=p(12801)o=o(C)k=o N=p(12369)o=p(12011)o=k[o]I=Z[N]o=o(k,I)N=o y=p(12369)I=u[y]y=p(12810)o=I[y]l=z[r[1]]W=l[Y]l=p(12336)y=W[l]a=z[r[1]]Y=a[X]a=p(12778)l=Y[a]Y=99999 W=l+Y a=z[r[1]]X=p(12801)Y=a[X]a=p(12012)l=Y[a]I=o(y,W,l)o=p(12515)y=I o=C[o]W=p(12673)W=N[W]W=W(N)I=y*W o=o(C,I)W=3 l=W W=1 Y=W W=0 a=Y<W I=1 W=I-Y o=6221113 else k=nil C=nil y=p(12719)W=L(13375221,{r[1],r[12];r[2];r[13];r[14]})o=u[p(12224)]N=u[y]y=p(12027)I=N[y]y=.5 N=I(y,W)I={}Z=c(Z)end else Z=e()I=p(12822)o=p(12281)o=C[o]o=o(C,I)z[Z]=o I=z[Z]o=not I o=o and 16199107 or 393415 end else if o<437761 then if o<431627 then I=z[r[5]]k=I()I=z[r[6]]y=false N=z[r[7]]k=I(N,y)Y=1 I=z[r[8]]W=z[Z]l=p(12801)N=p(12659)y=W[l]k=p(12346)l=.8 W=nil k=I[k]k=k(I,N,y,W,l,Y)N=p(12719)k=u[N]N=p(12027)I=k[N]N=.2 y=J(7749944,{r[8],Z})k=I(N,y)N=p(12719)k=u[N]y=B(123417,{r[8],Z})N=p(12027)I=k[N]N=.5 k=I(N,y)I=z[r[9]]y=120 N=z[Z]k=I(N,y)y=0 N=#k I=N>y o=I and 11709046 or 3064051 else Z=z[r[4]]k=Z()Z=z[r[5]]k=Z()Z=z[r[2]]k=p(12560)k=Z[k]k=k(Z)Z=z[r[6]]o=Z and 5815616 or 14251323 end else o=9904938 y=p(12801)N=Z[y]Y=p(12369)l=Z[Y]Y=p(12152)W=l[Y]l=50 y=W*l k=N+y I=k end end else if o<468308 then if o<467432 then if o<464013 then o=Y o=l and 6196878 or 11453768 else C=k o=N o=4342232 end else o=u[p(12165)]I={}C=nil Z=nil end else if o<483008 then if o<476765 then I={}o=u[p(12797)]else o=14654313 k=1 z[r[5]]=k end else N=p(12719)I=u[N]N=p(12783)o=I[N]I=o()o=14493117 end end end end end else if o<738364 then if o<617843 then if o<553617 then if o<534719 then if o<515729 then if o<504512 then yy=e()ry=603 xy=p(12409)Oy[1]=e()I=u[xy]xy=p(12810)o=I[xy]Ly=e()xy=p(12343)I=o(xy)o=p(12628)Zy=e()xy=I I=p(12853)xy[o]=I I=false o=p(12405)Gy=p(12318)xy[o]=I I=p(12836)C=nil o=p(12095)o=xy[o]o=o(xy,I,ry)o=p(12636)I=p(12691)xy[o]=I I=p(12679)Cy=e()o=p(12293)Iy=e()xy[o]=I cy=e()ry=z[r[3]]o=p(12350)I=ry[Gy]ry=e()wy=e()xy[o]=I o=O(4391649,{T})ey=e()Gy=e()zy=e()z[ry]=o o=O(2787169,{g;D})z[Gy]=o o=J(12212290,{D;g})z[wy]=o o=J(11102172,{H;r[3]})z[Iy]=o o=J(7722218,{Iy;q})ky=e()z[zy]=o o=O(3192623,{Iy,E,oy})I=p(12238)z[Cy]=o Ny=e()o=O(12861849,{E})z[ey]=o Oy[2]=J(12615410,{t;Zy})o=J(2081294,{t;V,r[3],D,g,ey;f,zy;Q;y,i,b;h,Cy;wy})z[Zy]=o o=J(9905013,{t,i,r[3];py,ey,f;zy,m,Z,W})z[ky]=o o=d(5272890,{t,i;py;r[3];k,ey,zy;m;Z;W;b;h,Cy})sy=nil z[Ny]=o o=d(5493637,{t,b,r[3];A,ey,f;zy,M,l})z[cy]=o o=L(11325595,{t,b;A,r[3],ey;zy,R,Z;N;Y,a,i;h;Cy})z[yy]=o o=L(16103789,{t,h,r[3];ry;uy,ey,f;F,zy;v;T,Z,n,X})z[Ly]=o o=d(4977525,{t,h;uy;r[3],ey;F,ry,N;zy,m,Z;X;i,b,Cy,v})z[Oy[1]]=o zy=c(zy)o=xy[I]W=c(W)E=c(E)I=p(12573)R=c(R)I=o[I]I=I(o,Oy[2])Oy[2]=J(3030631,{t,r[3];H;Cy,Gy;P;Zy})I=p(12088)o=xy[I]I=p(12573)I=o[I]Iy=c(Iy)I=I(o,Oy[2])n=c(n)I=p(12531)X=c(X)o=xy[I]Oy[2]=J(2847001,{t;ey,q,f;F,ry;Gy,V,P;i,py,b;A;h;uy})I=p(12573)q=c(q)I=o[I]I=I(o,Oy[2])Q=c(Q)i=c(i)I=z[r[4]]N=c(N)Oy[2]=p(12441)Cy=c(Cy)Gy=c(Gy)Y=c(Y)T=c(T)l=c(l)a=c(a)wy=c(wy)f=c(f)A=c(A)o=I[Oy[2]]Z=c(Z)I=p(12573)V=c(V)xy=nil m=c(m)uy=c(uy)I=o[I]M=c(M)b=c(b)Oy[2]=J(11241093,{r[4],t,ky;cy;Ly,Zy})I=I(o,Oy[2])ky=c(ky)I=z[r[4]]Zy=c(Zy)v=c(v)Oy[2]=p(12229)o=I[Oy[2]]ey=c(ey)P=c(P)oy=c(oy)Oy[2]=S(12122137,{t;Ny;yy;Oy[1]})py=c(py)h=c(h)D=c(D)t=c(t)cy=c(cy)F=c(F)yy=c(yy)ry=c(ry)Ly=c(Ly)I=p(12573)Ny=c(Ny)H=c(H)Oy[1]=c(Oy[1])I=o[I]y=c(y)I=I(o,Oy[2])g=c(g)o=u[p(12486)]k=c(k)I={}else X=p(12829)o=13348680 a=p(12041)a=l[a]a=a(l,X)Y=a end else if o<523426 then o=true z[r[2]]=o Z=p(12801)I=C[Z]Z=e()z[Z]=I k=3 N=k k=1 y=k o=2143981 I=1 k=0 W=y<k k=I-y else o=z[r[1]]l=nil Y=p(12397)W=p(12034)N=p(12670)k=z[r[2]]a=1 Z=p(12305)y=z[r[3]]C={[Z]=k,[N]=y;[W]=l,[Y]=a}I=o(C)o=u[p(12521)]I={}end end else if o<541893 then if o<538137 then I={}o=u[p(12484)]else m=p(12111)Q=g[m]m=0 o=13209860 P=Q>m D=P end else y={[W]=l;[Y]=a,[X]=g,[V]=D,[t]=P;[Q]=m}o=M N=c(N)o=u[p(12035)]k=I(y)y=p(12719)k=u[y]y=p(12027)I=k[y]W=B(14568638,{r[1],r[2];r[11],r[12],r[7],r[8]})y=.3 k=I(y,W)y=p(12719)k=u[y]W=O(13777705,{r[1];r[2];r[11],r[12];r[13]})y=p(12027)I=k[y]C=nil Z=c(Z)y=.8 k=I(y,W)I={}end end else if o<597675 then if o<589907 then if o<580831 then o=15256356 else o=u[p(12018)]I={}C=nil end else o=u[p(12527)]I={}end else if o<607435 then if o<601360 then o=z[r[1]]o=o and 6526712 or 952156 else Z=o N=z[r[2]]k=not N o=k and 7265255 or 6088140 C=k end else n=I o=z[Q]v=false I=o(n,v)I=p(12723)H=p(12318)o=u[I]F=z[r[4]]f=F[H]H=p(12029)H=f[H]F={H(f)}f={o(s(F))}I=f[1]v=f[2]q=f[3]f=I o=12088784 end end end else if o<684520 then if o<672747 then if o<667825 then if o<655630 then o=u[p(12294)]I={}else C=p(12554)I=p(12253)o=u[I]I=o(C)o=u[p(12337)]I={}end else o=3955959 v=l end else if o<679526 then if o<675871 then k=z[r[1]]N=p(12007)Z=k[N]C=not Z I=C o=14804145 else o=not k o=o and 6946666 or 11789850 end else X=p(12080)o=u[X]g=L(3160280,{a,Y})X=o(g)o=2021881 end end else if o<724619 then if o<709012 then if o<688056 then o=z[r[5]]I=o()o=2178564 else I={}o=u[p(12363)]end else Z=x[2]o=z[r[1]]I=o()k=I o=not k o=o and 11575848 or 12729681 C=x[1]end else if o<736217 then if o<732849 then N=o W=z[r[4]]y=not W k=y o=y and 10687102 or 5430568 else N=z[r[1]]y=p(12547)k=N[y]o=k and 16138737 or 14870124 I=k end else y=16 N=p(12192)k=z[r[9]]k[N]=y o=2556080 N=p(12594)k=z[r[9]]y=50 k[N]=y k=z[r[9]]N=p(12653)y=false k[N]=y end end end end else if o<884655 then if o<789252 then if o<760101 then if o<752070 then if o<749408 then Y=W V=p(12272)g=p(12041)g=a[g]g=g(a,V)o=g and 12693533 or 4656881 X=g else Z=p(12719)C=u[Z]Z=p(12783)o=C[Z]Z=.1 C=o(Z)o=4324148 end else if o<755684 then o=false I={}z[r[1]]=o o=u[p(12624)]else o=10046512 W=z[r[4]]y=not W k=y end end else if o<779635 then if o<775773 then i,py=F(H,i)o=i and 6129564 or 15592471 else I=p(12281)Z=p(12822)I=C[I]I=I(C,Z)Z=e()z[Z]=I k=z[Z]I=not k o=I and 6040186 or 1550753 end else Y=I o=Y and 9284220 or 11523058 end end else if o<821813 then if o<808387 then if o<803766 then I=z[r[11]]o=I and 4842699 or 406984 else o=I and 13506045 or 4390994 end else o=15318185 f=nil py=nil end else if o<863193 then if o<831678 then o=14026734 else k=y o=W o=14262663 end else o=p(12858)b=true py[o]=b b=true o=p(12818)py[o]=b o=3820612 end end end else if o<914356 then if o<904148 then if o<901547 then if o<888470 then Z=z[r[2]]k=p(12252)C=Z[k]o=C and 16153468 or 16114086 I=C else o=u[p(12118)]I={}end else I=C o=Z o=10258046 end else if o<909620 then if o<908335 then I={}o=u[p(12304)]else Z=z[r[1]]C=not Z I=C o=C and 4419387 or 13572235 end else o=true k=p(12663)z[r[2]]=o N=true I=z[r[4]]I[k]=N I=z[r[5]]k=I()I=z[r[6]]o=I and 13871789 or 8626194 end end else if o<940696 then if o<926141 then if o<921161 then k=z[r[8]]o=8863246 N=p(12786)N=k[N]N=N(k)k=nil z[r[8]]=k else y=nil N=nil o=9930241 end else a=p(12719)l=k l=nil o=15034608 Y=u[a]a=p(12668)I=Y[a]a=L(12216091,{r[5],Z})Y=I(a)end else if o<980414 then if o<961133 then I={}o=u[p(12812)]else o=I and 7843983 or 8119206 end else o=z[r[2]]I=o()o=9907230 end end end end end end else if o<1612627 then if o<1392279 then if o<1237236 then if o<1095469 then if o<1064490 then if o<1015897 then if o<1004233 then k=z[r[7]]y=z[r[8]]W=true N=k(y,W)y=p(12719)N=u[y]I={}Z=nil y=p(12668)k=N[y]y=L(14766355,{r[9];C;r[4]})o=u[p(12765)]C=c(C)N=k(y)else o=9035532 end else if o<1030982 then y=true z[r[2]]=y a=z[r[1]]Y=o l=a o=a and 11536776 or 13386609 else k=p(12490)N=p(12481)Z=z[r[1]]k=Z[k]o=5204090 k=k(Z,C,N)I=k end end else if o<1088961 then if o<1066285 then I=p(12723)o=p(12084)Z=x[2]o=Z[o]C=x[1]o=o(Z)k=o o=u[I]W=z[r[1]]l={o(W)}y=l[3]N=l[2]I=l[1]o=3842108 W=I else y=p(12021)I=u[y]y=p(12084)o=I[y]I=o(Z)y=p(12105)W=p(12083)o=p(12120)o=I[o]o=o(I,y,W)y=o o=N[y]W=o o=not W o=o and 7337328 or 13622503 end else l=p(12343)y=k o=p(12041)o=W[o]o=o(W,l)o=o and 10244182 or 8793759 end end else if o<1155149 then if o<1153342 then if o<1096876 then X=nil R=0 D=p(12397)g=p(12034)Q=p(12147)a=p(12670)P=p(12252)V=nil o=5524033 N=z[r[12]]M=p(12500)Y=p(12305)t=1 m=z[r[4]]l={[Y]=Z,[a]=X;[g]=V,[D]=t,[P]=C,[Q]=m,[M]=R}W=N(l)else Z=z[r[2]]o=1556758 C=not Z I=C end else I={}o=true z[r[1]]=o o=u[p(12167)]end else if o<1201949 then if o<1186637 then l=false o=p(12450)W[o]=l o=9893355 else C=p(12252)I=z[r[2]]o=I[C]C=o o=C and 7193092 or 2092894 I=C end else Y=p(12041)Y=W[Y]a=p(12028)y=k Y=Y(W,a)o=Y and 4401379 or 13459163 l=Y end end end else if o<1311842 then if o<1279418 then if o<1269648 then if o<1261091 then R=p(12398)o=u[R]R=p(12639)u[R]=o o=14415075 else I=p(12530)o=z[r[1]]I=o[I]I=I(o)o=6377534 end else C=p(12252)I=z[r[3]]o=I[C]C=o o=not C o=o and 625378 or 427568 end else if o<1301811 then if o<1286365 then Z=x[2]k=e()C=e()z[C]=x[1]z[k]=x[3]o=z[r[1]]I=o()y=J(9092697,{C;k,r[3]})C=c(C)N=1.2647101806872e+14 o=z[r[2]]Z=nil k=c(k)I=o(N,y)I={}o=u[p(12364)]else t=p(12801)D=g[t]P=p(12801)t=C[P]V=D-t D=p(12762)o=V[D]V=o o=V<Z o=o and 9414142 or 8446497 end else D=g o=13231153 end end else if o<1354571 then if o<1353681 then if o<1352692 then o=z[r[3]]I=o()o=14302543 else I=p(12398)C=p(12639)o=u[I]I=u[C]C=p(12639)u[C]=o C=p(12398)u[C]=I C=z[r[1]]Z=C()o=1871212 end else a=1 X=p(12822)l=W I=Y[a]a=I I=p(12281)I=a[I]I=I(a,X)X=e()z[X]=I I=z[X]o=I and 7046223 or 13199167 end else if o<1372167 then if o<1358214 then o=5730661 k=p(12786)Z=z[r[5]]k=Z[k]k=k(Z)Z=nil z[r[5]]=Z else W=z[r[3]]N=o y=not W o=y and 6264272 or 11971155 k=y end else C=p(12719)I=u[C]C=p(12783)o=I[C]I=o()C=p(12318)o=z[r[4]]I=p(12281)I=o[I]I=I(o,C)C=I o=C and 4179580 or 8174942 end end end end else if o<1515975 then if o<1467904 then if o<1409789 then if o<1404582 then if o<1403674 then k=p(12281)N=p(12755)k=Z[k]k=k(Z,N)I=k o=k and 10095924 or 14959196 else Z=z[r[2]]k=p(12252)C=Z[k]k=p(12822)Z=p(12281)Z=C[Z]o=2073789 Z=Z(C,k)I=Z end else if o<1406257 then I=false o=false z[r[1]]=o z[r[2]]=I I={}o=u[p(12329)]else o=z[r[1]]k=p(12609)z[r[2]]=o I=z[r[3]]k=I[k]k=k(I)I=z[r[4]]o=I and 4965374 or 4265822 end end else if o<1432235 then if o<1415801 then Z=nil C=nil o=u[p(12222)]I={}else C=p(12742)I=z[r[1]]o=I[C]I=p(12786)I=o[I]I=I(o)o=5722280 end else Y=false y=false z[r[10]]=y W=z[r[11]]l=p(12663)I={}X=false W[l]=Y W=false Y=p(12663)z[r[12]]=W a=false l=z[r[13]]o=u[p(12001)]l[Y]=a l=false z[r[14]]=l Y=z[r[15]]a=p(12663)Y[a]=X end end else if o<1488425 then if o<1481332 then if o<1475412 then l=p(12489)W=p(12489)y=u[W]W=p(12479)N=y[W]y=N(Z)W=u[l]l=p(12180)N=W[l]Y=z[r[11]]l=Y*C X=p(12489)a=u[X]X=p(12794)Y=a[X]a={Y(Z)}W=N(l,s(a))k=y*W y=z[r[2]]N=y+k W=o z[r[2]]=N l=z[r[5]]y=l o=l and 10225584 or 12674431 else y=k o=p(12786)o=W[o]o=o(W)W=nil y=nil o=12359853 end else N=p(12723)I=u[N]l={I(k)}o=7863369 N=l[1]W=l[3]y=l[2]end else if o<1509872 then if o<1504641 then Y=p(12801)l=z[r[2]]o=14758888 W=l[Y]N=W else R=M o=2571427 end else I=p(12281)o=z[C]I=o[I]Z=p(12822)I=I(o,Z)Z=I o=not Z o=o and 4319653 or 2145309 end end end else if o<1551472 then if o<1532511 then if o<1530095 then if o<1528211 then o=z[r[2]]I=o()o=8319667 else o=I and 8359173 or 10883424 end else o=W o=y and 1959586 or 578163 end else if o<1546219 then if o<1544385 then o=n P={[Q]=m,[M]=R}M=p(12607)Q=p(12004)n=p(12013)R=p(12281)q=o o=X and 3955959 or 669965 v=X R=W[R]R=R(W,n)n=p(12574)else o=z[r[2]]o=o and 10663899 or 10308051 end else I=z[r[5]]N=z[Z]Y=p(12801)n=o k=I(N)N=e()z[N]=k P=-5 I=z[r[6]]l=p(12424)k=I()I=z[r[7]]W=z[r[8]]y=W[l]W=false k=I(y,W)k=p(12346)y=p(12227)I=z[r[9]]k=I[k]l=z[Z]W=l[Y]Y=.75 a=1 l=nil V=p(12369)k=k(I,y,W,l,Y,a)D=p(12369)k=p(12346)I=z[r[9]]l=z[Z]Y=p(12801)y=p(12680)W=l[Y]a=1.2 l=nil k=I[k]Y=.7 k=k(I,y,W,l,Y,a)y=p(12719)k=u[y]Y=p(12369)y=p(12027)I=k[y]y=.3 Q=p(12069)W=d(9408164,{r[9];N;Z})k=I(y,W)y=p(12719)t=0 k=u[y]W=S(1738821,{r[9];Z})y=p(12027)I=k[y]y=.5 k=I(y,W)I=z[r[10]]l=z[Z]g=z[Z]W=p(12305)X=g[V]V=u[D]D=p(12810)g=V[D]D=0 V=g(D,t,P)a=X*V P=true t=p(12023)V=p(12670)M=o X=p(12845)D=nil g=z[N]v=z[N]o=v and 8211507 or 14095388 R=v end end else if o<1566443 then if o<1559292 then if o<1556649 then I={}o=u[p(12541)]else o=I and 9922711 or 13158031 end else C=z[r[1]]o=C and 11306759 or 4978944 I=C end else if o<1604914 then if o<1577733 then l=l+a g=not X I=l<=Y I=g and I g=l>=Y g=X and g I=g or I g=13310591 o=I and g I=16019185 o=o or I else o=I and 11077233 or 10702089 end else N=p(12347)o=9662168 k=u[N]I=k end end end end end else if o<1858924 then if o<1726364 then if o<1698951 then if o<1656237 then if o<1637320 then if o<1620161 then Z=z[r[4]]k=Z()Z=z[r[5]]k=Z()k=p(12560)Z=z[r[2]]k=Z[k]k=k(Z)Z=z[r[6]]o=Z and 5268617 or 11720857 else l=z[r[2]]o=4024025 Y=p(12801)W=l[Y]N=W end else if o<1655464 then Z=I k=p(12409)I=u[k]k=p(12810)o=I[k]N=p(12833)a=p(12387)k=p(12207)I=o(k)W=z[r[3]]o=p(12270)k=I Y=z[r[1]]l=Y[a]y=W[l]I=N..y k[o]=I o=p(12299)o=Z[o]o=o(Z,k)N=o I=false o=p(12045)N[o]=I k=nil o=p(12346)o=N[o]o=o(N)I=p(12547)Z=nil y=N N=nil o=z[r[1]]o[I]=y o=14986178 else k=p(12779)W=p(12585)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12324)k=N[y]o=I==k o=o and 2649973 or 6450450 end end else if o<1668979 then if o<1659414 then y=p(12045)W=true I=z[r[2]]o=8412406 I[y]=W else o=u[p(12816)]I={}end else Z=z[r[2]]o=6660722 C=not Z I=C end end else if o<1718463 then if o<1707331 then if o<1699333 then Z=p(12350)I=C[Z]Z=z[r[2]]o=I==Z o=o and 8540796 or 11216460 else o=8055400 W=z[r[4]]y=not W k=y end else I=z[r[2]]k=p(12719)C=p(12628)o=I[C]C=e()z[C]=o Z=e()o=z[r[3]]N=p(12466)I=o()z[Z]=I I=u[k]k=p(12668)o=I[k]k=d(6666863,{Z,r[4],r[2];r[5],C,r[6],r[7]})I=o(k)k={N}I=p(12524)o={[I]=k}I={o}o=u[p(12067)]end else if o<1725655 then if o<1723780 then o=u[p(12641)]I={}else o=z[r[1]]C=x[1]I=p(12070)I=o[I]Z=x[2]I=I(o)o=I and 7444696 or 6325667 end else o=z[r[1]]C=z[r[2]]I=o(C)o=u[p(12436)]I={}end end end else if o<1775358 then if o<1740450 then if o<1738551 then if o<1734669 then o=z[r[2]]I=o()o=10616035 else o=I and 11451405 or 1277542 end else o=z[r[1]]k=z[r[2]]C=p(12217)N=p(12801)y=1 Z=k[N]N=.6 k=nil I=p(12346)I=o[I]I=I(o,C,Z,k,N,y)y=1 N=p(12801)o=z[r[1]]k=z[r[2]]Z=k[N]N=.65 C=p(12351)k=nil I=p(12346)I=o[I]I=I(o,C,Z,k,N,y)N=p(12801)o=z[r[1]]I=p(12346)C=p(12384)k=z[r[2]]Z=k[N]I=o[I]y=1.1 N=.6 k=nil I=I(o,C,Z,k,N,y)I={}o=u[p(12577)]end else if o<1772117 then if o<1765167 then a=p(12621)l=p(12354)N=p(12315)I=p(12199)Z=p(12022)Y=p(12590)y=nil C=false k=nil W=p(12282)o={[I]=C,[Z]=k;[N]=y;[W]=l,[Y]=a}Z=K(11604779,{r[1],r[2];r[3]})I=p(12144)k=p(12591)C=e()z[C]=o o=z[C]N=S(12188237,{r[5];C})C=c(C)o[I]=Z Z=p(12076)o=z[r[4]]I=o(Z,k,N)o=u[p(12710)]I={}else o=nil I={o}o=u[p(12382)]end else o=z[r[1]]I=o()C=I o=not C o=o and 16085960 or 1544994 end end else if o<1810967 then if o<1793777 then if o<1786384 then o=Z o=8310046 I=C else I=z[r[1]]C=p(12252)o=I[C]C=o I=C o=C and 13741959 or 15188877 end else I=z[r[1]]Z=p(12547)o=I[Z]I=p(12786)I=o[I]I=I(o)o=11588383 end else if o<1857458 then if o<1835651 then o=I and 7580267 or 9035214 else I=z[r[2]]o=not I o=o and 535881 or 14764092 end else a=p(12719)Y=u[a]a=p(12668)I=Y[a]l=k a=S(15107752,{r[4];Z})o=2143981 l=nil Y=I(a)end end end end else if o<1967197 then if o<1893395 then if o<1880011 then if o<1871631 then if o<1865733 then I={}o=u[p(12494)]else o=true o=o and 1353680 or 7270716 end else I={}o=u[p(12316)]end else if o<1890884 then if o<1887534 then m=z[Z]Q=m o=m and 190801 or 6718182 else o=R n=o v=z[M]R=v o=v and 13039379 or 4800009 end else Y=z[r[6]]o=840107 l=not Y y=l end end else if o<1921040 then if o<1914950 then if o<1895565 then k=p(12830)I=z[r[2]]o=I[k]o=o and 14970287 or 9209607 else Q=Q+M n=not R I=Q<=m I=n and I n=Q>=m n=R and n I=n or I n=14385176 o=I and n I=1887489 o=o or I end else o=p(12530)o=sy[o]o=o(sy)o=12700040 end else if o<1960825 then if o<1956694 then o=u[p(12756)]I={}else a=p(12369)y=z[r[8]]Y=z[r[5]]l=Y[a]W=p(12369)o=578163 y[W]=l end else I=p(12625)y=p(12249)o=u[I]I=o(y,C,k)o=3808717 end end end else if o<2050025 then if o<2002149 then if o<1991402 then if o<1972021 then l=p(12368)W=u[l]X={W(y)}l=X[1]Y=X[2]o=12853252 a=X[3]else I={}o=u[p(12582)]end else o=13607845 end else if o<2022919 then if o<2020844 then k=o W=p(12742)Z=I y=z[r[1]]N=y[W]o=N and 3393860 or 12781384 I=N else o=2476577 a=c(a)Y=c(Y)l=nil end else F=q F=nil o=m(H)H=nil o=12088784 end end else if o<2078173 then if o<2073831 then if o<2066260 then C=p(12252)I=z[r[3]]o=I[C]C=o o=not C o=o and 691757 or 9959251 else C=e()z[C]=I o=z[C]o=o and 10855724 or 11127517 end else D=p(12723)M=p(12223)m=p(12317)V=u[D]R=p(12485)Q={m;M;R}m={V(Q)}P=m[3]t=m[2]D=m[1]o=8070368 end else if o<2085444 then if o<2082331 then Z=z[r[1]]C=not Z I=C o=C and 13480117 or 4099364 else o=X and 3403011 or 7734167 end else N=o W=z[r[4]]y=not W k=y o=y and 16339766 or 14262663 end end end end end end end else if o<3195887 then if o<2664482 then if o<2377992 then if o<2198579 then if o<2146653 then if o<2138108 then if o<2114389 then if o<2099505 then Z=I o=Z and 72905 or 6152094 else N=W o=l o=13407808 end else if o<2120505 then V=p(12711)P=p(12689)g=u[V]t=u[P]P=p(12046)D=t[P]o=16656001 V=g(D)g=p(12409)X=V~=g Y=X else i=p(12574)H=Q[i]o=9597955 f=H end end else if o<2145026 then if o<2140027 then C=x[1]Z=p(12409)o=z[r[1]]I=o(C)y=80 W=80 I=u[Z]Z=p(12810)o=I[Z]Z=p(12028)I=o(Z)N=p(12104)o=p(12350)Z=I I=z[r[2]]Z[o]=I k=u[N]o=p(12563)N=p(12720)I=k[N]N=255 k=I(N,y,W)I=.3 Z[o]=k o=p(12470)Z[o]=I k=p(12483)o=p(12645)I=.5 Z[o]=I I=1 o=p(12572)Z[o]=I I=u[k]k=p(12828)o=I[k]I=o(C,Z)N=p(12483)k=p(12409)Z=nil I=u[k]k=p(12810)o=I[k]k=p(12777)I=o(k)k=I o=p(12350)I=z[r[2]]k[o]=I I=10 o=p(12411)k[o]=I I=u[N]N=p(12828)o=I[N]I=o(C,k)N=p(12409)I=u[N]N=p(12810)o=I[N]N=p(12295)I=o(N)o=p(12350)y=p(12483)N=I I=z[r[2]]N[o]=I o=p(12052)I=1 N[o]=I o=p(12411)I=24 k=nil N[o]=I o=p(12426)I=0 N[o]=I I=u[y]y=p(12828)o=I[y]I=o(C,N)C=nil N=nil o=u[p(12208)]I={}else l=not W k=k+y I=k<=N I=l and I l=k>=N l=W and l I=l or I l=1858175 o=I and l I=16097462 o=o or I end else k=p(12663)o=true z[r[2]]=o I=z[r[4]]N=true I[k]=N I=z[r[5]]k=I()I=z[r[6]]o=I and 14412218 or 990650 end end else if o<2178255 then if o<2162446 then if o<2150855 then o=X and 4505394 or 10647327 else k=p(12719)I=u[k]k=p(12392)o=I[k]k=z[r[4]]I=o(k)o=nil z[r[4]]=o o=7126354 end else Z=z[r[1]]k=p(12503)C=Z[k]o=10021455 Z=p(12281)k=p(12698)Z=C[Z]Z=Z(C,k)I=Z end else if o<2194810 then if o<2179257 then I={}o=u[p(12685)]else I=p(12661)o=z[r[1]]C=z[r[2]]o[I]=C I={}o=u[p(12360)]end else I=C o=Z o=9301455 end end end else if o<2289673 then if o<2266902 then if o<2251662 then if o<2228887 then o=z[r[1]]Z=p(12305)N=p(12670)Y=p(12397)a=1 l=nil k=z[r[2]]y=z[r[3]]W=p(12034)C={[Z]=k,[N]=y,[W]=l,[Y]=a}I=o(C)I={}o=u[p(12669)]else C=p(12368)W=p(12029)o=u[C]N=z[r[2]]W=N[W]y={W(N)}N={o(s(y))}Z=N[2]k=N[3]C=N[1]o=15237716 end else l=p(12350)o=8789196 W=z[r[5]]y=W[l]k=y end else if o<2288695 then if o<2274691 then Z=o N=z[r[2]]k=not N o=k and 4383785 or 901666 C=k else o=9209607 end else I={}o=u[p(12420)]end end else if o<2339972 then if o<2328700 then if o<2294437 then C=p(12252)I=z[r[3]]o=I[C]C=e()z[C]=o I=z[C]o=not I o=o and 15285929 or 1512324 else Z=x[2]o=z[r[1]]I=p(12070)C=x[1]I=o[I]I=I(o)o=I and 10348473 or 14457203 end else o=u[p(12519)]I={}end else if o<2376460 then if o<2362209 then Z=p(12022)y=nil C=false Y=p(12590)a=p(12621)k=nil W=p(12282)I=p(12199)l=p(12010)N=p(12315)o={[I]=C,[Z]=k,[N]=y,[W]=l,[Y]=a}Z=B(4800048,{r[1],r[2];r[3]})C=e()k=p(12714)z[C]=o o=z[C]N=O(1725874,{r[5],C})I=p(12144)o[I]=Z o=z[r[4]]Z=p(12615)C=c(C)I=o(Z,k,N)o=u[p(12371)]I={}else o=I and 3424170 or 12172162 end else N=p(12689)C=e()z[C]=x[1]I=p(12642)o=u[I]k=u[N]N=p(12394)N=k[N]y=p(12687)N=N(k,y)k=p(12064)Z=N[k]I=o(Z)Z=I I=z[r[1]]k=p(12252)o=I[k]k=o I=k o=k and 9782330 or 4196410 end end end end else if o<2538518 then if o<2476954 then if o<2453813 then if o<2419978 then if o<2383087 then I=p(12281)C=p(12822)o=z[r[4]]I=o[I]I=I(o,C)C=I o=C and 9876362 or 2480494 else o=W o=N and 204187 or 13267786 end else if o<2438630 then o=1734903 C=z[r[2]]I=C else V=nil o=12399565 end end else if o<2474200 then if o<2461790 then Y=p(12343)N=k l=p(12041)l=y[l]l=l(y,Y)W=l o=l and 4414824 or 2876039 else g=not X l=l+a W=l<=Y W=g and W g=l>=Y g=X and g W=g or W g=11818316 o=W and g W=1968920 o=o or W end else C=nil I={}Z=nil o=u[p(12480)]k=nil end end else if o<2491344 then if o<2486015 then if o<2481685 then o=3328818 C=nil else I=false o=true z[r[3]]=o z[r[2]]=I k=z[r[5]]o=k and 16763380 or 3688600 end else A=p(12290)b=p(12041)b=py[b]f=i b=b(py,A)o=b and 3302388 or 4551589 end else if o<2525046 then if o<2498622 then o=z[r[5]]k=p(12474)Z=z[r[6]]C=Z[k]Z=false I=o(C,Z)o=8859931 else o=11332021 m=l end else o=I and 2496999 or 8859931 end end end else if o<2600740 then if o<2575979 then if o<2561382 then if o<2541154 then l=p(12872)Z=p(12022)Y=p(12590)C=false I=p(12199)N=p(12315)a=p(12146)W=p(12282)k=nil y=nil o={[I]=C,[Z]=k;[N]=y,[W]=l,[Y]=a}I=p(12144)Z=B(1280184,{r[1];r[2],r[3]})C=e()z[C]=o N=J(12744206,{r[5];C})k=p(12665)o=z[C]o[I]=Z C=c(C)Z=p(12665)o=z[r[4]]I=o(Z,k,N)I={}o=u[p(12400)]else y=false N=p(12199)k=z[r[10]]o=8676261 k[N]=y end else o=n o=R and 3753651 or 10328770 end else if o<2593128 then if o<2588982 then I={}C=nil o=u[p(12717)]Z=nil else k=z[r[1]]N=p(12742)Z=k[N]k=p(12622)o=16147353 C=Z[k]I=C end else I=p(12822)o=p(12281)o=C[o]o=o(C,I)Z=o o=not Z o=o and 9313211 or 10026164 end end else if o<2615140 then if o<2614532 then if o<2608616 then I={}o=u[p(12268)]else k=x[3]Z=x[2]C=x[1]N=p(12409)I=u[N]N=p(12810)o=I[N]N=p(12415)I=o(N)N=I I=C o=p(12628)N[o]=I I=k o=p(12411)k=nil N[o]=I I=Z o=p(12369)N[o]=I o=p(12471)I=true N[o]=I o=p(12858)I=false N[o]=I y=O(12411238,{r[2];r[3];r[4],r[5]})I=1 o=p(12868)N[o]=I o=p(12350)I=z[r[1]]N[o]=I I=p(12248)o=N[I]I=p(12573)I=o[I]I=I(o,y)I=p(12020)y=B(11717197,{r[2],r[3];r[4],r[6],r[7]})C=nil Z=nil o=N[I]I=p(12573)N=nil I=o[I]I=I(o,y)I={}o=u[p(12809)]end else W,a=l(y,W)o=W and 14204680 or 4772932 end else if o<2644789 then if o<2630524 then W=N o=p(12281)o=C[o]o=o(C,l)Y=o o=Y and 3471223 or 5882350 else o=X and 10613614 or 4722861 end else o=z[r[5]]I=o()o=6450450 end end end end end else if o<2892713 then if o<2786961 then if o<2723617 then if o<2711889 then if o<2689844 then if o<2682943 then C=z[r[1]]Z=p(12503)I=C[Z]C=p(12698)o=I[C]I=p(12530)I=o[I]I=I(o)o=4686636 else o=7516661 C=z[r[7]]Z=C()end else if o<2705589 then o=1011218 else I={}o=p(12122)C[o]=I o=1066504 end end else if o<2717668 then if o<2716074 then C=z[r[2]]o=6416324 I=C else o=u[p(12342)]I={}end else C=p(12719)I=u[C]C=p(12783)o=I[C]C=.5 I=o(C)C=z[r[1]]I=C o=C and 12239682 or 15235745 end end else if o<2753199 then if o<2737731 then if o<2734457 then o=W k=y o=5430568 else C=p(12719)I=u[C]C=p(12027)o=I[C]C=1.5 Z=J(16048417,{r[2];r[1]})I=o(C,Z)z[r[1]]=I I={}o=u[p(12748)]end else I=p(12054)o=p(12628)l[o]=I I=z[r[2]]o=p(12350)l[o]=I o=11683063 end else if o<2768134 then if o<2760623 then k=p(12755)Z=p(12281)Z=C[Z]Z=Z(C,k)o=Z and 2016341 or 11371751 I=Z else o=14647186 end else I={}o=u[p(12322)]end end end else if o<2828424 then if o<2806473 then if o<2797708 then if o<2792534 then o=0 z[r[1]]=o I=z[r[2]]o=I and 6887794 or 2607744 else o=z[r[2]]I=o()o=7385504 end else I={}o=u[p(12058)]end else if o<2820075 then if o<2811584 then I={}o=u[p(12092)]else k=z[r[2]]I=k o=130029 end else N=z[r[1]]y=p(12007)o=15016010 k=N[y]I=k end end else if o<2869489 then if o<2849848 then if o<2846707 then I={}o=u[p(12550)]else o=false z[r[1]]=o I=z[r[2]]C=I()I=z[r[3]]o=I and 3548321 or 9943388 end else o=z[r[2]]I=o()o=8517285 end else if o<2883598 then if o<2877884 then o=W and 5134305 or 4641911 else o=p(12350)Z=p(12328)C=x[1]I=u[Z]Z=true C[o]=I o=p(12281)o=C[o]I=p(12596)o=o(C,I,Z)Z=o o=Z and 10100675 or 14206787 end else o=z[r[5]]I=o()o=7160233 end end end end else if o<3057840 then if o<3004127 then if o<2971906 then if o<2934007 then if o<2893198 then o=Z I=C o=2537710 else C=z[r[7]]Z=C()o=6057518 end else if o<2946632 then y=p(12409)N=u[y]y=p(12810)k=N[y]o=4985926 y=p(12755)N=k(y,Z)I=N else o=V and 13829438 or 8140342 end end else if o<2990859 then if o<2986195 then I={}o=u[p(12239)]else y=p(12779)Y=p(12585)N=C[y]l=u[Y]Y=p(12779)W=l[Y]l=p(12336)y=W[l]k=N==y o=k and 2827922 or 15016010 I=k end else b=p(12514)A=l o=5109516 py[b]=A end end else if o<3029548 then if o<3022291 then if o<3012041 then Y=p(12281)I=z[r[3]]a=p(12806)Y=I[Y]Y=Y(I,a)a=e()z[a]=Y X=z[a]I=X Y=o o=X and 10814182 or 16069870 else Z=false o=z[r[1]]C=z[r[2]]I=o(C,Z)o=z[r[3]]o=o and 12761595 or 10687013 end else o=z[r[10]]Z=z[r[11]]C[o]=Z o=z[r[12]]Z={o(C)}I={s(Z)}o=u[p(12100)]end else if o<3044625 then if o<3030517 then Z=p(12786)C=z[r[4]]Z=C[Z]Z=Z(C)C=nil z[r[4]]=C o=7258045 else o=true z[r[1]]=o Z=p(12252)C=z[r[2]]I=C[Z]C=I o=C and 10605796 or 432236 end else y,Y=W(N,y)o=y and 5521664 or 12954181 end end end else if o<3103864 then if o<3064807 then if o<3064119 then if o<3062606 then t=nil k=c(k)P=c(P)X=c(X)k=o a=c(a)Y=nil Z=c(Z)Y=p(12689)g=nil W=nil N=c(N)D=nil V=nil y=c(y)y=o l=c(l)l=u[Y]W=not l o=W and 7963762 or 15820569 N=W else I=z[r[10]]o=I and 8558433 or 801157 end else o=I and 4227696 or 8522985 end else if o<3099240 then if o<3090020 then o=y o=N and 7582383 or 3340162 Z=N else i,py=F(H,i)o=i and 2486366 or 10798030 end else V=nil o=16518275 m=nil Q=nil end end else if o<3158292 then if o<3155794 then if o<3134149 then I=z[r[1]]C=z[r[2]]o=I[C]o=o and 9653211 or 1718128 else o=nil C=e()z[C]=x[1]N=p(12849)Z=e()z[Z]=o k=u[N]I=k o=k and 1612394 or 9662168 end else y=p(12153)N=C[y]Y=p(12585)l=u[Y]Y=p(12153)W=l[Y]l=p(12468)y=W[l]k=N==y o=1829389 I=k end else if o<3191118 then if o<3176543 then o=z[r[1]]I=p(12661)k=p(12063)Z=z[r[2]]C=Z[k]o[I]=C I=p(12569)o=z[r[1]]Z=z[r[2]]k=p(12149)C=Z[k]k=p(12321)o[I]=C o=z[r[1]]I=p(12422)N=150 Z=u[k]k=p(12810)C=Z[k]k=150 Z=C(k,N)o[I]=Z o=u[p(12448)]I={}else I=C o=Z o=4687556 end else o=z[r[1]]I=o()C=I o=not C o=o and 1987983 or 16329219 end end end end end end else if o<3806261 then if o<3487072 then if o<3392180 then if o<3306627 then if o<3267428 then if o<3226882 then if o<3223358 then C=p(12252)I=z[r[3]]o=I[C]C=o o=not C o=o and 5668439 or 2593918 else I=z[r[5]]k=I()I=z[r[6]]o=I and 5614547 or 5355963 end else if o<3236819 then t=z[r[13]]o=5913060 D=not t g=D else y=p(12153)N=C[y]Y=p(12585)l=u[Y]Y=p(12153)W=l[Y]l=p(12671)o=6885120 y=W[l]k=N==y I=k end end else if o<3298504 then if o<3294635 then g=p(12369)W=p(12369)P=p(12489)y=z[r[5]]X=p(12369)a=u[X]X=p(12810)Y=a[X]X=z[r[6]]V=0 a=Y(X)X=u[g]g=p(12630)Y=X[g]t=u[P]g=0 P=p(12065)D=t[P]P=z[r[2]]t={D(P)}X=Y(g,V,s(t))l=a*X y[W]=l W=o l=z[r[8]]y=l o=l and 8506868 or 1532475 else I={}o=u[p(12675)]end else A=false b=p(12450)py[b]=A h=p(12483)A=u[h]h=p(12828)b=A[h]A=b(q,py)uy=p(12350)h=py[uy]uy=p(12628)A=h[uy]h=p(12203)b=A==h o=b and 6707750 or 5556294 end end else if o<3349331 then if o<3339781 then if o<3328330 then o=I and 4940440 or 14841659 else I=p(12524)Z=p(12221)C={Z}o={[I]=C}I={o}o=u[p(12706)]end else W=p(12801)y=z[r[3]]o=7582383 N=y[W]Z=N end else if o<3359645 then if o<3357828 then o=12774559 n=nil F=p(12080)q=nil R=nil f=u[F]H=S(11208725,{M})v=nil F=f(H)else o=z[r[2]]I=p(12786)I=o[I]I=I(o)o=10492821 end else o=12465175 C=z[r[2]]I=C end end end else if o<3425450 then if o<3412043 then if o<3404575 then if o<3399820 then o=12781384 W=z[r[1]]l=p(12742)y=W[l]W=p(12622)N=y[W]I=N else X=p(12822)o=p(12281)o=a[o]o=o(a,X)X=o g=p(12280)V=X o=p(12855)o=a[o]o=o(a,g)g=o o=X and 15800836 or 13951903 end else o=5524033 N=z[r[9]]Y=p(12424)l=z[r[10]]W=l[Y]t=1.5 l=false y=N(W,l)W=p(12409)l=p(12327)y=u[W]W=p(12810)N=y[W]W=p(12722)y=N(W)W=p(12628)g=1 D=p(12397)N=e()z[N]=y y=z[N]y[W]=l R=3 l=true y=z[N]W=p(12663)y[W]=l l=Z y=z[N]W=p(12350)X=.75 P=p(12252)y[W]=l l=p(12719)W=u[l]Y=L(7309160,{N})l=p(12027)y=W[l]l=10 W=y(l,Y)y=z[r[11]]W=p(12346)l=p(12259)a=p(12801)M=p(12500)Y=Z[a]a=nil W=y[W]W=W(y,l,Y,a,X,g)l=p(12456)y=z[r[11]]Q=p(12147)a=p(12801)W=p(12346)Y=Z[a]W=y[W]X=.7 g=1.2 a=nil W=W(y,l,Y,a,X,g)g=1 y=z[r[11]]N=c(N)X=.65 l=p(12388)a=p(12801)Y=Z[a]a=nil W=p(12346)W=y[W]W=W(y,l,Y,a,X,g)l=p(12719)g=p(12034)W=u[l]l=p(12027)X=nil a=p(12670)y=W[l]Y=B(15210239,{k,r[11]})l=2.5 W=y(l,Y)Y=p(12305)y=z[r[12]]V=z[k]m=z[r[4]]l={[Y]=Z;[a]=X,[g]=V,[D]=t;[P]=C,[Q]=m,[M]=R}W=y(l)l=p(12719)W=u[l]l=p(12027)y=W[l]Y=J(3461679,{r[1],r[13];r[14];r[2];r[15]})l=.5 W=y(l,Y)end else if o<3422203 then if o<3412752 then o=u[p(12648)]I={}else I={}o=u[p(12194)]end else o=u[p(12835)]I={}end end else if o<3461888 then if o<3459346 then if o<3434043 then o=u[p(11994)]I={}else o=11695744 k=p(12133)N=p(12829)Z=z[C]k=Z[k]k=k(Z,N)I=k end else C=z[r[1]]o=C and 5821186 or 6358250 I=C end else if o<3474322 then if o<3470869 then k=p(12281)k=Z[k]N=p(12755)k=k(Z,N)o=k and 8849495 or 12265338 I=k else o=p(12530)o=Y[o]o=o(Y)o=5882350 end else I={}o=u[p(12559)]end end end end else if o<3648192 then if o<3598038 then if o<3562317 then if o<3540173 then if o<3521068 then o=N and 11246302 or 15351032 I=N else l,X=Y(W,l)o=l and 3892342 or 12971964 end else if o<3553851 then I=z[r[3]]o=9943388 C=p(12786)C=I[C]C=C(I)I=nil z[r[3]]=I else o=z[r[1]]k=z[r[2]]N=p(12801)Z=p(12708)y=z[r[3]]C={[Z]=k,[N]=y}I=o(C)I={}o=u[p(12265)]end end else if o<3597234 then if o<3593331 then o=n(v)o=279625 else I=z[r[1]]C=p(12252)o=I[C]C=o I=C o=C and 6364016 or 12490829 end else X=p(12628)a=l[X]W=N X=p(12435)X=a[X]g=p(12352)X=X(a,g)o=X and 505373 or 13348680 Y=X end end else if o<3612427 then if o<3605458 then if o<3599488 then C=z[r[1]]I=C o=C and 374839 or 5567558 else k=z[r[3]]o=968693 I=k end else o=15588665 end else if o<3644762 then if o<3620492 then k,W=N(Z,k)o=k and 1202239 or 14339885 else I={}o=u[p(12158)]end else g=p(12633)X=p(12281)X=C[X]X=X(C,g)o=15565833 Y=X end end end else if o<3708998 then if o<3695662 then if o<3689029 then if o<3659941 then I={}o=u[p(12367)]C=nil else y=p(12719)N=u[y]y=p(12027)k=N[y]o=7854997 y=.5 W=O(14942740,{r[3]})N=k(y,W)end else g=e()W=a z[g]=X D=p(12719)o=12853252 V=u[D]D=p(12668)X=g W=nil g=V[D]D=O(8357970,{r[6],r[7],Z,k;X,r[8],N})X=c(X)V=g(D)end else if o<3705130 then if o<3698066 then o=V D=X N=o o=2451651 k=D else Z=p(12822)I=p(12281)o=z[C]I=o[I]I=I(o,Z)Z=I o=not Z o=o and 10211392 or 910492 end else C=p(12252)I=z[r[3]]o=I[C]C=e()z[C]=o I=z[C]o=not I o=o and 5165783 or 3704920 end end else if o<3752961 then if o<3736246 then if o<3714042 then g=l t=p(12369)o=z[r[1]]I=p(12369)P=p(12801)D=u[t]t=p(12810)V=D[t]t=Z[P]D=V(t)V=p(12719)g=nil o[I]=D I=u[V]V=p(12783)o=I[V]V=.05 I=o(V)o=6996066 else I={}o=u[p(12732)]end else C=nil o=u[p(12463)]Z=nil I={}end else if o<3789029 then if o<3767107 then q=p(12369)n=p(12369)f=p(12369)R=g[n]v=M[q]q=p(12369)n=p(12011)n=R[n]n=n(R,v)F=p(12723)b=p(12508)v=l[q]R=v*n q=M[f]o=3877213 f=p(12673)f=q[f]f=f(q)q={}v=R*f b=m[b]f=u[F]py={b(m)}b={f(s(py))}i=b[3]H=b[2]F=b[1]else wy=p(12252)Gy=z[r[3]]ry=Gy[wy]wy=p(12459)Gy=p(12281)Gy=ry[Gy]Gy=Gy(ry,wy)o=11415223 sy=Gy end else o=u[p(12098)]I={}end end end end end else if o<4174824 then if o<3965886 then if o<3887400 then if o<3848252 then if o<3813451 then if o<3808007 then I=p(12328)Z=p(12617)C=x[1]o=u[I]I=p(12281)I=o[I]I=I(o,Z)Z=I o=not Z o=o and 12268798 or 11785784 else N=nil o=u[p(12383)]C=nil k=nil Z=nil I={}end else if o<3831690 then o=13602586 i=nil py=nil else y,Y=W(N,y)o=y and 8719784 or 2476577 end end else if o<3881927 then if o<3876886 then t=z[r[13]]o=6391540 D=not t g=D else i,py=F(H,i)o=i and 10075995 or 10951759 end else o=z[r[5]]W=o()o=11267730 end end else if o<3936016 then if o<3906380 then if o<3896161 then o=e()z[o]=X X=o a=l V=p(12719)g=u[V]V=p(12668)o=g[V]V=L(6008282,{r[3],r[2],C;Z,X,r[4],N})g=o(V)a=nil o=3521123 X=c(X)else Z=x[2]Z=nil N=87737109817581 C=e()z[C]=x[1]k=e()z[k]=x[3]y=S(2879891,{C,k;r[3]})k=c(k)o=z[r[1]]I=o()o=z[r[2]]I=o(N,y)C=c(C)o=u[p(12086)]I={}end else I={}C=nil k=c(k)Z=nil o=u[p(12804)]end else if o<3957461 then if o<3955816 then I={}o=u[p(12504)]else m={[M]=R,[n]=v}o=q g={[V]=D;[t]=P,[Q]=m}D=p(12723)V=u[D]Q={V(g)}t=Q[2]P=Q[3]D=Q[1]o=7171792 end else I={}o=u[p(12190)]end end end else if o<4087431 then if o<4013063 then if o<4006048 then if o<3991924 then o=I and 7102563 or 15293320 else I=z[r[4]]Z=e()C=I()z[Z]=C C=z[Z]I=not C o=I and 3644233 or 5388169 end else o=true k=p(12663)z[r[2]]=o N=true I=z[r[4]]I[k]=N I=z[r[5]]k=I()I=z[r[6]]o=I and 9430466 or 16575307 end else if o<4039930 then if o<4027582 then o=y Z=N o=N and 15914899 or 13282874 else W,a=l(y,W)o=W and 745721 or 13112137 end else o=u[p(12163)]I={}end end else if o<4146317 then if o<4105326 then if o<4098303 then k=e()o=false z[k]=o W=J(13938108,{k;r[2],C,r[3],r[4],r[5],r[6]})y=p(12248)o=z[r[1]]I=z[C]k=c(k)C=c(C)N=Z[y]y=p(12573)y=N[y]y=y(N,W)Z=nil o[I]=y o=u[p(12461)]I={}else Z=z[r[2]]C=not Z o=13480117 I=C end else y=o a=p(12689)Y=u[a]a=p(12287)l=Y[a]Y=p(12672)W=l~=Y N=W o=W and 13407808 or 36734 end else if o<4152658 then if o<4150899 then o=907842 else C=x[1]I=p(12368)o=u[I]y=p(12029)y=C[y]N={y(C)}y={o(s(N))}I=y[1]Z=y[2]k=y[3]N=I o=7660696 end else D=p(12723)m=p(12128)n=p(12681)M=p(12169)V=u[D]R=p(12013)Q={m,M;R;n}m={V(Q)}P=m[3]t=m[2]o=16518275 D=m[1]end end end end else if o<4314983 then if o<4236607 then if o<4190297 then if o<4181760 then if o<4178168 then W=z[r[3]]y=not W k=y N=o o=y and 8922960 or 5743483 else o=z[r[2]]I=p(12350)Z=C o[I]=Z k=true o=z[r[1]]Z=z[r[2]]I=o(Z,k)o=8174942 end else y=p(12742)N=z[r[1]]k=N[y]N=p(12622)o=5138140 Z=k[N]I=Z end else if o<4228021 then if o<4212882 then W=p(12701)N=e()z[N]=I l=B(10694052,{r[2],C;r[3];r[4],r[5];r[6],r[7];r[8];N,r[9];r[10];r[1]})y=p(11996)I=p(12184)k=nil o={[I]=y;[W]=l}y=o o=p(12613)o=Z[o]N=c(N)C=c(C)o=o(Z,y)I={}y=nil Z=nil o=u[p(12376)]else o=u[p(12863)]I={}end else o=X g=p(12013)X=p(12281)X=C[X]X=X(C,g)o=Z and 13448867 or 11332683 end end else if o<4264751 then if o<4242539 then if o<4241804 then k=p(12252)Z=z[r[2]]C=Z[k]I=C o=C and 1403904 or 2073789 else P=80 o=9327085 t=V<P D=t end else I={}o=u[p(12791)]end else if o<4268487 then if o<4266886 then N=o y=z[r[5]]k=y o=y and 2258840 or 8789196 else N=Z W=1 o=y[W]l=p(12822)W=o o=p(12281)o=W[o]o=o(W,l)l=o o=l and 8743930 or 5559095 end else W=9897434364 I=9897433972 Y=9897435626 a=1 py=nil V=p(12135)b=p(12769)F=p(12547)H=nil R=.5 l=9897435270 Q=p(12740)o={I;W;l;Y}X=p(12848)W=e()uy=p(12409)M=p(12204)D=nil z[W]=o q=p(12007)i=p(12742)o=p(12325)l=e()t=p(12830)g=0 P=false m=true Y=p(12054)z[l]=o o=z[r[2]]I=p(12281)I=o[I]v=false E=p(12409)I=I(o,Y)Y=e()f=false n=p(12802)z[Y]=I I=p(12387)h=u[uy]uy=p(12810)A=h[uy]uy=p(12722)h=A(uy)T=u[E]E=p(12810)A=p(12366)uy=T[E]E=p(12722)T=uy(E)o={[I]=a,[X]=g,[V]=D,[t]=P,[Q]=m;[M]=R,[n]=v;[q]=f;[F]=H;[i]=py,[b]=h;[A]=T}D=e()X=e()a=e()V=e()z[a]=o o=O(12953164,{a;r[4];l})t=e()g=e()z[X]=o o=L(6709368,{a,r[4];W;r[5],X})z[g]=o o=O(12607426,{a;r[4];X;Z})z[V]=o o=d(10558533,{a;X})z[D]=o Q=p(12441)P=e()o=O(5073583,{a,r[4],X;k})z[t]=o o=d(13963726,{a;r[4];y;N,X})z[P]=o I=z[r[6]]o=I[Q]Q=J(8892740,{r[6],a,V;t,g})I=p(12573)I=o[I]I=I(o,Q)Q=p(12229)I=z[r[6]]o=I[Q]I=p(12573)Q=S(8328013,{a;D;P})I=o[I]I=I(o,Q)o=K(4533242,{r[2],Y})Q=e()z[Q]=o n=p(12318)o=d(184449,{a;g,r[4],Q;X})R=z[r[4]]M=R[n]m=o R=p(12281)n=p(12246)R=M[R]R=R(M,n)o=R and 8674891 or 11402020 I=R end end end else if o<4360580 then if o<4341390 then if o<4329115 then if o<4322212 then o=u[p(12472)]I={}else C=z[r[1]]o=C and 10941097 or 9784201 I=C end else k=p(12280)Z=p(12855)o=10112786 Z=C[Z]Z=Z(C,k)I=Z end else if o<4359276 then if o<4356081 then I=C o=Z o=6358250 else o=9482830 W=z[r[4]]y=not W k=y end else o=u[p(12647)]I={}end end else if o<4387583 then if o<4382789 then if o<4367856 then I=p(12801)o=Z[I]N=p(12801)I=p(12310)a=p(12801)k=o I=C[I]g=p(12801)I=I(C)W=p(12002)o=I[N]N=o o=N-k I=u[W]W=p(12810)y=o o=I[W]Y=z[r[1]]l=Y[a]Y=p(12336)W=l[Y]X=z[r[1]]a=X[g]X=p(12778)Y=a[X]a=99999 g=p(12801)l=Y+a X=z[r[1]]a=X[g]X=p(12012)Y=a[X]I=o(W,l,Y)Y=p(12369)W=I l=u[Y]Y=p(12810)o=p(12515)I=l[Y]o=C[o]Y=W+y l={I(Y)}o=o(C,s(l))o=1570727 l=3 I=1 Y=l l=1 a=l l=0 X=a<l l=I-a else k=p(12719)I=u[k]k=p(12783)o=I[k]k=.15 I=o(k)N=z[r[4]]y=N()k=not y I=k o=k and 2819443 or 130029 end else W=z[r[3]]N=o y=not W k=y o=y and 758493 or 10046512 end else if o<4393019 then if o<4391097 then C=nil I={}Z=nil o=u[p(12006)]else I=p(12723)o=u[I]k=z[r[1]]N={o(k)}I=N[1]C=N[2]o=5907269 k=I Z=N[3]end else Z=nil o=11216647 C=nil end end end end end end end end else if o<6293328 then if o<5382684 then if o<4855139 then if o<4599826 then if o<4498919 then if o<4422002 then if o<4413399 then if o<4403382 then if o<4398776 then k=p(12490)o=11132711 N=p(12481)Z=z[r[1]]k=Z[k]k=k(Z,C,N)I=k else o=l and 6938523 or 12179136 end else if o<4408691 then I=p(12723)Y=p(12029)o=u[I]Y=N[Y]l={Y(N)}Y={o(s(l))}y=Y[2]W=Y[3]o=12112628 I=Y[1]l=I else o=14323680 N=p(12547)k=z[r[1]]Z=k[N]k=p(12622)C=Z[k]I=C end end else if o<4419119 then if o<4415485 then a=p(12636)Y=y[a]o=2876039 a=p(11996)l=Y==a W=l else q=p(12719)o=z[r[6]]v=o(P)v=u[q]q=p(12783)o=v[q]q=1 v=o(q)o=D and 15298257 or 9396756 end else o=I and 348644 or 3705188 end end else if o<4446794 then if o<4439364 then if o<4435211 then V=D o=t o=15837471 else o=I and 12825429 or 1966439 end else W=L(753402,{r[3]})o=u[p(12160)]y=p(12719)I={}N=u[y]y=p(12027)k=N[y]y=.5 C=nil Z=nil N=k(y,W)end else if o<4496388 then if o<4450603 then Z=z[r[1]]C=not Z o=C and 2368394 or 10770597 I=C else o=p(12530)o=W[o]o=o(W)g=nil o=10086353 X=nil end else o=z[r[2]]C=p(12719)I=o()I=u[C]C=p(12783)o=I[C]C=.5 I=o(C)o=z[r[3]]I=p(12530)I=o[I]I=I(o)k=p(12237)o=z[r[4]]y=p(12429)Z=p(12810)C=z[r[5]]I=o(C)C=I I=z[r[6]]o=I[Z]N=C..y Z=k..N I=o(Z)o=p(12737)o=I[o]C=nil o=o(I)o=16716293 end end end else if o<4524901 then if o<4513930 then if o<4508728 then if o<4504656 then z[r[3]]=I o=k o=7300726 else o=true I={o}o=u[p(12517)]end else C=z[r[1]]o=C and 10984917 or 8310046 I=C end else if o<4523763 then if o<4521580 then y=nil Y=p(12801)o=z[r[2]]l=Z[Y]I=o(l)a=nil o=z[r[3]]Y=p(12348)X=nil k=nil l=p(12694)W=nil N=nil I=o(C,l,Y,a,X)o=14206787 else k=p(12779)I=C[k]W=p(12585)y=u[W]W=p(12779)N=y[W]y=p(12324)k=N[y]o=I==k o=o and 8891576 or 13168451 end else o=z[r[6]]I=o()o=10815690 end end else if o<4561838 then if o<4549820 then if o<4541753 then I=p(12723)o=u[I]Z=x[2]C=x[1]l=p(12847)W=p(12841)y={W,l}W={o(y)}N=W[3]I=W[1]y=I o=9381864 k=W[2]else Z=false o=false z[r[2]]=o I=z[r[3]]C=p(12663)I[C]=Z Z=p(12252)C=z[r[4]]I=C[Z]C=I I=not C o=I and 15793582 or 16217915 end else py=nil o=3090304 f=nil end else if o<4588037 then if o<4587197 then N=p(12369)l=p(12369)k=z[r[5]]o=12787016 W=u[l]l=p(12810)y=W[l]l=z[r[6]]W=y(l)k[N]=W else y=120 k=z[r[7]]N=k()k=z[r[8]]N=k(Z,y)k=e()z[k]=N W=z[k]y=#W W=0 N=y>W o=N and 11615801 or 5547437 end else o=z[r[1]]o=o and 2850408 or 8517285 end end end end else if o<4686372 then if o<4634916 then if o<4611277 then if o<4604178 then if o<4601207 then C=1 I=p(12387)o=z[r[1]]o[I]=C C=p(12135)I=z[r[1]]o=I[C]I=p(12609)I=o[I]I=I(o)C=nil I=p(12135)o=z[r[1]]o[I]=C o=3716075 else o=z[r[4]]o=o and 2157291 or 7126354 end else if o<4607489 then o=nil I=true Z=o z[r[1]]=o z[r[2]]=I k=z[r[3]]o=k and 730881 or 9580642 C=k else o=D and 3697690 or 2451651 end end else if o<4626883 then if o<4618050 then o=p(12786)o=y[o]o=o(y)o=921818 else k=z[r[4]]o=4445178 N=k()end else o=I and 9703542 or 16652759 end end else if o<4657327 then if o<4650047 then if o<4645240 then y=nil N=nil o=15237716 else g=nil X=nil o=8477026 end else o=X and 10327527 or 8477026 end else if o<4675546 then if o<4660810 then o=Z I=C o=9751263 else y=p(12153)N=C[y]Y=p(12585)l=u[Y]Y=p(12153)W=l[Y]o=805959 l=p(12671)y=W[l]k=N==y I=k end else I=py o=b o=5574877 end end end else if o<4795470 then if o<4704808 then if o<4687727 then if o<4687480 then o=u[p(12335)]I={}else o=I and 687426 or 2178564 end else W=p(12585)k=p(12779)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12324)k=N[y]o=I==k o=o and 7206893 or 468241 end else if o<4734849 then if o<4721249 then I=k o=N o=k and 9904938 or 451563 else Y=nil a=nil o=2614865 end else o=u[p(12558)]I={k}end end else if o<4819101 then if o<4804662 then if o<4800033 then o=n o=R and 7203825 or 12774559 else C=e()N=95297968392131 k=e()Z=x[2]Z=nil z[C]=x[1]z[k]=x[3]o=z[r[1]]y=J(11166869,{C,k,r[3]})I=o()o=z[r[2]]I=o(N,y)o=u[p(12142)]k=c(k)C=c(C)I={}end else b=p(12450)h=p(12483)A=false py[b]=A uy=p(12350)A=u[h]h=p(12828)b=A[h]A=b(q,py)h=py[uy]uy=p(12628)A=h[uy]h=p(12203)b=A==h o=b and 2991929 or 5109516 end else if o<4840925 then if o<4828917 then l=I o=l and 6976169 or 16253561 else o=4324148 end else W=p(12407)I=z[r[11]]l=z[Z]Y=p(12721)a=2 y={[W]=l,[Y]=a}o=406984 N=I(y)end end end end end else if o<5134288 then if o<4985067 then if o<4941295 then if o<4934111 then if o<4916902 then if o<4862412 then o=1887626 n=z[M]q=p(12203)v=p(12281)f=true v=n[v]v=v(n,q,f)m=v else l=z[r[14]]o=8672786 Y=l()end else if o<4927870 then Y=p(12585)y=p(12153)N=C[y]l=u[Y]Y=p(12153)W=l[Y]l=p(12468)y=W[l]k=N==y I=k o=k and 13176767 or 10251574 else o=u[p(12580)]I={}end end else if o<4940470 then if o<4936922 then o=765037 f=nil py=nil else I={}o=u[p(12542)]end else g=z[r[3]]o=5015304 V=p(12252)X=g[V]V=p(12649)g=p(12281)g=X[g]g=g(X,V)Y=g end end else if o<4962334 then if o<4954380 then if o<4947448 then N=p(12203)C=e()z[C]=x[1]Z=z[C]k=p(12281)k=Z[k]k=k(Z,N)I=k o=k and 11695744 or 3455093 else o=12525875 y=z[r[3]]W=p(12350)N=y[W]Z=N end else I=z[r[1]]C=x[1]o=I[C]o=o and 5434125 or 5539856 end else if o<4978062 then if o<4969566 then I=z[r[4]]k=p(12609)k=I[k]k=k(I)I=nil o=4265822 z[r[4]]=I else Z=z[r[1]]C=not Z o=C and 9295218 or 5788271 I=C end else o=I and 1266425 or 6377534 end end end else if o<5055385 then if o<5029983 then if o<5007006 then if o<5003791 then N=p(12409)k=I I=u[N]N=p(12810)o=I[N]N=p(12207)I=o(N)o=p(12270)N=I I=p(12262)N[o]=I o=p(12299)o=k[o]I=false o=o(k,N)y=o o=p(12045)y[o]=I o=p(12346)I=p(12547)o=y[o]k=nil o=o(y)W=y N=nil o=z[r[1]]o[I]=W W=O(15555300,{r[1];r[3]})I=p(12178)o=y[I]y=nil I=p(12573)I=o[I]I=I(o,W)o=13950171 else o=I and 10984650 or 3419034 end else I=Y o=a o=787038 end else if o<5041925 then if o<5039256 then F=o i=p(12607)H=Q[i]o=H and 2131244 or 9597955 f=H else I=z[r[6]]k=p(12786)k=I[k]k=k(I)I=nil o=16654105 z[r[6]]=I end else W=p(12745)y=u[W]Y=p(12848)W=y()l=z[r[1]]y=l[Y]N=W-y l=p(12204)W=z[r[1]]y=W[l]k=N>=y o=7839452 C=k end end else if o<5097177 then if o<5077131 then if o<5060291 then o=u[p(12592)]I={}else Z=z[r[1]]k=p(12830)C=Z[k]I=C o=C and 674077 or 14804145 end else k=p(12252)Z=z[r[2]]o=16766561 C=Z[k]k=p(12822)Z=p(12281)Z=C[Z]Z=Z(C,k)I=Z end else if o<5124763 then if o<5100705 then o=false z[r[1]]=o o=u[p(12226)]I=false z[r[2]]=I C=false I={}z[r[3]]=C else o=16060070 end else I={k}o=u[p(12042)]end end end end else if o<5261541 then if o<5206485 then if o<5160653 then if o<5137877 then if o<5136824 then I={y}o=u[p(12843)]else k=p(12779)I=C[k]W=p(12585)y=u[W]W=p(12779)N=y[W]y=p(12012)k=N[y]o=I==k o=o and 1727119 or 2989919 end else if o<5141968 then o=I and 10592749 or 7856780 else l=a o=X o=13386609 end end else if o<5201158 then if o<5171153 then o=u[p(12771)]I={}else W=115 y=p(12002)N=u[y]y=p(12810)I=N[y]y=0 l=0 N=I(y,W,l)o=k+N N=o W=p(12369)l=p(12369)y=u[W]W=p(12810)I=y[W]y=I(N)W=u[l]a=p(12489)l=p(12630)I=W[l]Y=u[a]D=p(12729)a=p(12065)l=Y[a]a=-90 Y=l(a)a=0 l=0 W=I(Y,l,a)Y=p(12574)o=y*W l=p(12678)y=o o=z[r[4]]V=z[r[3]]X=o g=V[D]a=g o=g and 8172360 or 10142699 end else o=I and 1699140 or 9035532 end end else if o<5254947 then if o<5234907 then if o<5216905 then C=k o=N o=6088140 else b=z[Z]o=b and 5759099 or 5411756 py=b end else a=o V=p(12252)g=z[r[3]]X=g[V]Y=X o=X and 4940492 or 5015304 end else if o<5261148 then if o<5259477 then Z=nil o=432236 else Y=W V=p(12272)g=p(12041)g=a[g]g=g(a,V)X=g o=g and 8922998 or 11846565 end else q=p(12801)v=z[Z]H=p(12369)n=v[q]F=z[Z]f=F[H]F=p(12152)q=f[F]f=10 v=q*f R=n+v m=R o=543324 end end end else if o<5326995 then if o<5292999 then if o<5273711 then if o<5268757 then N=p(12609)Z=z[r[6]]o=11720857 N=Z[N]N=N(Z)else Z=z[r[1]]C=not Z o=C and 3064338 or 12963887 I=C end else o=true z[r[1]]=o Z=z[r[3]]k=p(12628)I=Z[k]Z=p(12084)o=11330117 Z=I[Z]Z=Z(I)k=p(12723)I=u[k]W=z[r[4]]l={I(W)}y=l[3]k=l[1]N=l[2]end else if o<5312616 then if o<5297776 then k=p(12252)Z=z[r[2]]C=Z[k]k=p(12822)Z=p(12281)Z=C[Z]Z=Z(C,k)I=Z o=16735398 else I=z[r[11]]o=I and 11827104 or 14174613 end else k=p(12343)C=x[1]Z=p(12041)Z=C[Z]Z=Z(C,k)I=Z o=Z and 4398229 or 11132711 end end else if o<5356920 then if o<5356250 then if o<5337886 then W=z[r[3]]y=not W N=o k=y o=y and 5443835 or 15077882 else y=120 k=z[r[7]]N=k()k=z[r[8]]N=k(Z,y)k=e()z[k]=N W=z[k]y=#W W=0 N=y>W o=N and 3411896 or 14479419 end else o=z[r[1]]I=o()o=u[p(12193)]I={}end else if o<5371165 then if o<5365195 then I={}o=u[p(12650)]else Z=z[r[1]]k=p(12490)N=p(12481)k=Z[k]k=k(Z,C,N)I=k o=9921423 end else Q=160 N=z[r[9]]W=z[r[10]]X=p(12655)l=false y=N(W,l)l=p(12483)t=p(12801)z[r[8]]=y W=u[l]l=p(12828)N=W[l]l=z[r[11]]Y=z[r[12]]P=p(12002)D=z[Z]V=D[t]t=u[P]P=p(12810)D=t[P]m=0 P=0 t=D(P,Q,m)D=.65 P=p(12346)g=V+t V=nil P=Y[P]t=1.5 a={P(Y,X,g,V,D,t)}W=N(l,s(a))l=p(12483)W=u[l]l=p(12828)D=p(12801)N=W[l]l=z[r[11]]X=p(12724)Y=z[r[12]]t=1 V=z[Z]g=V[D]D=.7 V=nil P=p(12346)P=Y[P]a={P(Y,X,g,V,D,t)}W=N(l,s(a))l=p(12719)W=u[l]l=p(12783)N=W[l]l=.5 W=N(l)W=o l=z[r[2]]N=l o=l and 12560960 or 7970444 end end end end end end else if o<5748805 then if o<5537913 then if o<5433764 then if o<5410458 then if o<5397325 then if o<5387759 then if o<5384645 then k=13677122 I=12789678 Z=p(12776)C=Z^k o=I-C C=o I=p(12024)o=I/C I={o}o=u[p(12267)]else Z=z[r[2]]k=p(12252)C=Z[k]I=C o=C and 14422439 or 16643586 end else if o<5389616 then I=true N=p(12801)z[r[2]]=I l=5 k=z[Z]o=2463715 C=k[N]W=p(12369)Y=l k=e()z[k]=C y=z[Z]N=y[W]W=1 y=p(12152)C=N[y]y=p(12328)N=u[y]y=p(12391)y=N[y]y=y(N)l=1 N=e()z[N]=y a=l y={C}l=0 X=a<l l=W-a else o=4722861 X=nil g=nil end end else if o<5405787 then if o<5400312 then I=p(12368)o=u[I]y=z[r[2]]l=p(12508)l=y[l]W={l(y)}y={o(s(W))}k=y[2]N=y[3]I=y[1]o=12520123 y=I else o=1871212 end else o=false z[r[2]]=o Z=false I=z[r[3]]C=p(12663)I[C]=Z Z=p(12252)C=z[r[4]]I=C[Z]C=I I=not C o=I and 3298000 or 13470490 end end else if o<5422926 then if o<5416134 then if o<5413636 then z[Z]=py T=1 uy=z[f]h=uy+T A=i[h]b=g+A A=256 o=b%A h=z[q]g=o A=V+h h=256 o=8006201 b=A%h V=b else Y=not a o=X W=Y o=2111409 end else o=z[r[5]]I=o()o=4925922 end else if o<5433700 then if o<5428993 then N=p(12409)k=u[N]N=p(12810)Z=k[N]N=p(12755)k=Z(N,C)I=k o=1655444 else C=k o=N o=9580642 end else o=z[r[2]]l=p(12801)W=Z[l]a=nil I=o(W)Y=nil l=p(12348)W=p(12089)y=nil k=nil o=z[r[3]]I=o(C,W,l,Y,a)o=10452875 N=nil end end end else if o<5488470 then if o<5444603 then if o<5439677 then if o<5434955 then I=z[r[1]]o=I[C]I=p(12609)I=o[I]I=I(o)I=nil o=z[r[1]]o[C]=I o=5539856 else k=z[r[8]]o=k and 918379 or 8863246 end else W=z[r[4]]y=not W k=y o=15077882 end else if o<5463345 then if o<5446395 then Y=p(12080)I=p(12395)N=p(12695)o=u[I]C=z[r[4]]k=u[N]l=u[Y]a=L(5382754,{})Y={l(a)}W={s(Y)}l=2 y=W[l]N=k(y)k=p(12250)Z=C(N,k)C={Z()}I=o(s(C))Z=z[r[5]]C=I o=Z and 10219258 or 15520058 I=Z else I={}o=u[p(12039)]end else l=a o=X o=457163 end end else if o<5522356 then if o<5506495 then if o<5495889 then Z=z[r[1]]C=not Z I=C o=C and 156663 or 9548511 else D=z[r[1]]t=p(12252)V=D[t]g=a~=V o=2084761 X=g end else l=y o=Y k[l]=o o=3051187 l=nil Y=nil end else if o<5525522 then if o<5522622 then o=I and 9288617 or 347588 else k=c(k)I={}o=u[p(12497)]Z=nil C=nil end else k=p(12409)I=u[k]k=p(12810)N=p(12833)o=I[k]k=p(12207)I=o(k)o=p(12270)y=z[r[3]]k=I I=N..y k[o]=I o=p(12299)o=Z[o]I=true o=o(Z,k)N=o o=p(12045)N[o]=I o=p(12346)o=N[o]o=o(N)I=p(12742)o=z[r[1]]y=N k=nil N=nil o[I]=y o=8207424 end end end end else if o<5637472 then if o<5590312 then if o<5558842 then if o<5544807 then if o<5541889 then C=nil o=u[p(12629)]I={}else N,l=y(k,N)o=N and 14220105 or 1409824 end else if o<5552521 then N=z[r[9]]l=false W=z[r[16]]y=N(W,l)z[r[6]]=y N=z[r[6]]o=N and 7339432 or 16348443 else o=4551589 end end else if o<5568820 then if o<5559432 then o=10590436 l=nil y=nil W=nil N=nil else o=I and 7640363 or 2829777 end else z[Z]=I o=8006201 end end else if o<5612449 then if o<5605343 then if o<5599988 then g=p(12822)X=p(12280)o=p(12855)o=a[o]o=o(a,X)X=o o=p(12281)o=a[o]o=o(a,g)V=X g=o o=X and 7854233 or 2948979 else Z=p(12719)I=u[Z]Z=p(12783)o=I[Z]C=nil Z=.2 I=o(Z)o=z[r[4]]I=o()I={}o=u[p(12766)]end else a=p(12806)o=p(12281)o=C[o]o=o(C,a)a=e()z[a]=o g=z[a]o=g and 16759756 or 16694559 X=g end else if o<5619756 then if o<5615676 then k=p(12786)I=z[r[6]]k=I[k]o=5355963 k=k(I)I=nil z[r[6]]=I else I=z[r[1]]Z=p(12135)o=I[Z]I=p(12609)I=o[I]I=I(o)o=7956505 end else o=z[r[4]]I=o(Z)o=2581514 end end end else if o<5713053 then if o<5672298 then if o<5654361 then if o<5644590 then l=z[r[7]]Y=p(12178)o=11783440 y=l[Y]l=p(12573)l=y[l]Y=S(11351784,{r[7],r[2];r[1];r[11];r[12];r[13],r[14],r[15]})l=l(y,Y)else xy=o Gy=z[r[3]]wy=p(12252)ry=Gy[wy]o=ry and 3771298 or 11415223 sy=ry end else C=nil Z=nil o=900421 end else if o<5696350 then if o<5678133 then I=p(12849)o=u[I]I=o()z[r[1]]=I C=p(12347)o=u[C]Z=8 C=o(Z)o=u[p(12610)]I={}else y=p(12153)Y=p(12585)N=C[y]l=u[Y]Y=p(12153)W=l[Y]l=p(12671)y=W[l]k=N==y I=k o=k and 1829389 or 3156537 end else k=p(12663)N=true o=z[r[4]]I=o()o=true z[r[2]]=o I=z[r[5]]I[k]=N I=z[r[6]]k=I()I=z[r[7]]o=I and 6179541 or 5439313 end end else if o<5730071 then if o<5723791 then if o<5722424 then k=p(12252)Z=z[r[2]]C=Z[k]I=C o=C and 15778837 or 6252198 else R=6 o=z[l]M=1 m=o(M,R)o=p(12398)u[o]=m R=p(12398)M=u[R]R=2 o=M>R o=o and 10045393 or 1255018 end else o=I and 8057392 or 4548215 end else if o<5743954 then if o<5739107 then k=z[r[6]]N=k()k=z[r[7]]N=k()k=true z[r[8]]=k N=z[r[9]]o=N and 7470711 or 1461147 else o=N o=9078436 C=k end else I={I}o=u[p(12587)]end end end end end else if o<6020818 then if o<5867045 then if o<5815816 then if o<5802031 then if o<5759172 then if o<5758601 then Z=p(12041)C=x[1]k=p(12343)Z=C[Z]Z=Z(C,k)I=Z o=Z and 7816538 or 17589 else A=1 b=i[A]py=b o=5411756 end else if o<5769175 then D=p(12483)V=u[D]D=p(12583)g=V[D]o=11095337 a=g else o=9295218 Z=z[r[2]]C=not Z I=C end end else if o<5814158 then if o<5804499 then N=p(12490)k=z[r[3]]N=k[N]y=p(12481)N=N(k,Z,y)I=N o=7183744 else t=z[r[12]]D=not t g=D V=o o=D and 3855641 or 6391540 end else N=p(12609)Z=z[r[6]]o=14251323 N=Z[N]N=N(Z)end end else if o<5829638 then if o<5827094 then if o<5823399 then N=z[r[2]]Z=o k=not N o=k and 15658635 or 4342232 C=k else I=z[r[1]]k=p(12810)o=I[k]k=p(12865)I=o(k)W=p(12790)y=p(12063)M=p(12260)o=p(12737)o=I[o]Y=p(12276)o=o(I)t=p(12198)a=p(12056)P=p(12056)o=1200 V=p(12154)k=o m=p(12056)l=p(12056)D=p(12056)I=p(12345)N={[y]=W;[l]=Y}l=p(12063)g=p(12056)X=p(12823)y=p(12478)Y=p(12119)W={[l]=Y,[a]=X}X=p(12284)l=p(12453)a=p(12063)Y={[a]=X;[g]=V}a=p(12589)g=p(12063)Q=p(12053)V=p(12556)X={[g]=V,[D]=t}t=p(12123)g=p(12357)D=p(12063)V={[D]=t;[P]=Q}Q=p(12857)P=p(12063)t={[P]=Q,[m]=M}D=p(12469)o={[I]=N;[y]=W;[l]=Y;[a]=X;[g]=V;[D]=t}N=o y=p(12122)I=C[y]o=not I o=o and 2707070 or 1066504 end else C=x[1]Z=p(12810)I=z[r[1]]o=I[Z]Z=p(12862)I=o(Z)o=p(12737)Z=p(12719)o=I[o]o=o(I)I=u[Z]Z=p(12668)o=I[Z]Z=S(11961173,{r[2];r[3];r[1];r[4]})C=nil I=o(Z)I={}o=u[p(12817)]end else if o<5861057 then if o<5851763 then o=8699030 else N=p(12489)o=nil I=u[N]N=p(12606)k=o Y=p(12029)o=I[N]N=o Y=Z[Y]I=p(12723)o=u[I]l={Y(Z)}Y={o(s(l))}y=Y[2]W=Y[3]I=Y[1]l=I o=2614865 end else I=p(12786)o=z[r[1]]I=o[I]I=I(o)o=nil z[r[1]]=o o=110134 end end end else if o<5912974 then if o<5890179 then if o<5878262 then if o<5877022 then N=p(12802)k=z[r[1]]o=1529440 Z=k[N]C=not Z I=C else y=z[r[7]]o=12113221 W=p(12786)W=y[W]W=W(y)end else Y=nil W=nil l=nil o=9381864 end else if o<5906899 then if o<5906507 then N=z[r[2]]Z=o k=not N C=k o=k and 1362053 or 3188629 else I={}o=u[p(12330)]end else Z,y=k(C,Z)o=Z and 9964937 or 6055939 end end else if o<5932005 then if o<5923620 then if o<5919739 then a=g o=V o=5464828 else C=false I=p(12830)o=z[r[1]]o[I]=C Z=z[r[1]]k=p(12742)C=Z[k]o=C and 2590486 or 16147353 I=C end else I=z[r[2]]o=not I o=o and 12225093 or 12488094 end else if o<5991001 then if o<5946444 then C=z[r[2]]I=C o=6457284 else o=p(12350)Z=p(12328)C=x[1]I=u[Z]Z=true C[o]=I o=p(12281)o=C[o]I=p(12073)o=o(C,I,Z)Z=o o=Z and 4361465 or 3751785 end else g=2 N=p(12407)o=z[r[1]]W=p(12700)m=false Z=p(12147)k=z[r[2]]y=z[r[3]]X=p(12705)Q=p(12071)l=z[r[4]]Y=p(12597)a=z[r[5]]C={[Z]=k;[N]=y,[W]=l;[Y]=a;[X]=g}I=o(C)o=z[r[6]]k=z[r[2]]Z=p(12147)X=p(12445)Y=p(12597)N=p(12407)y=z[r[3]]l=z[r[4]]a=z[r[5]]V=z[r[4]]t=z[r[5]]P=800 W=p(12700)D=t*P g=V+D D=2.5 t=p(12061)V=p(12451)P=z[r[7]]C={[Z]=k;[N]=y;[W]=l,[Y]=a,[X]=g,[V]=D;[t]=P;[Q]=m}I=o(C)o=u[p(12735)]I={}end end end end else if o<6176755 then if o<6107022 then if o<6050177 then if o<6047143 then if o<6036730 then Z=z[r[2]]C=not Z o=12891257 I=C else I={}o=u[p(12525)]end else uy=p(12369)b=p(12369)h=py[uy]A=v*h py[b]=A o=808419 end else if o<6059108 then if o<6057240 then o={}z[r[1]]=o I={}o=u[p(12175)]else C=z[r[8]]Z=C()I={}o=u[p(12195)]end else o=Z o=7988369 I=C end end else if o<6151843 then if o<6141673 then if o<6119928 then o=z[r[1]]C=z[r[2]]I=o(C)I={}o=u[p(12523)]else b=p(12041)A=p(12829)f=i b=py[b]b=b(py,A)o=b and 7406655 or 4936528 end else a,g=l(Y,a)o=a and 11476379 or 10086353 end else if o<6164279 then if o<6152067 then o=z[r[3]]I=o()o=10616035 else o=15384465 Z=nil C=nil end else W=1 y=N[W]I=y o=4435317 end end end else if o<6231976 then if o<6214455 then if o<6198079 then if o<6180386 then k=p(12786)I=z[r[7]]o=5439313 k=I[k]k=k(I)I=nil z[r[7]]=I else l=z[r[14]]o=11453768 Y=l()end else o=u[p(12168)]I={}end else if o<6229110 then if o<6222329 then X=not a W=W+Y I=W<=l I=X and I X=W>=l X=a and X I=X or I X=14801138 o=I and X I=12785633 o=o or I else y=nil W=p(12282)I=p(12199)Y=p(12590)N=p(12315)C=false k=nil a=p(12621)Z=p(12022)l=p(12543)o={[I]=C;[Z]=k;[N]=y;[W]=l;[Y]=a}k=p(12798)C=e()z[C]=o I=p(12144)Z=U(3904939,{r[1],r[2],r[3]})N=O(6119322,{r[5];C})o=z[C]o[I]=Z o=z[r[4]]Z=p(12171)I=o(Z,k,N)C=c(C)I={}o=u[p(12800)]end else y=p(12670)N=p(12305)o=z[r[4]]W=z[r[5]]k={[N]=Z,[y]=W}I=o(k)C=nil k=p(12719)Z=nil I=u[k]k=p(12783)o=I[k]I=o()o=8699030 end end else if o<6259852 then if o<6256029 then if o<6252148 then o=15368357 k=1 z[r[5]]=k else C=I o=C and 10836020 or 6377126 end else I={}o=u[p(12697)]end else if o<6281526 then if o<6265589 then W=z[r[4]]o=11971155 y=not W k=y else b=p(12450)f=i A=true f=nil py[b]=A py=nil o=13319929 end else o=false z[r[1]]=o o=u[p(12240)]I={}end end end end end end end else if o<7314518 then if o<6885436 then if o<6458711 then if o<6377432 then if o<6359656 then if o<6352414 then if o<6330809 then if o<6326897 then I=z[r[2]]o=not I o=o and 13223676 or 15924794 else o=I and 13203579 or 7142786 end else if o<6342563 then o=I and 8454527 or 3426940 else V=p(12063)X=p(12833)o=z[r[2]]g=W[V]a=X..g X={o(a)}I=X[1]a=I Y=X[2]X=not a o=X and 16400155 or 11691518 I=X end end else if o<6358188 then if o<6356548 then o=u[p(12358)]I={}else o=u[p(12117)]I={}end else o=I and 16203015 or 12184091 end end else if o<6368275 then if o<6365418 then if o<6364470 then o=12490829 Z=p(12281)Z=C[Z]k=p(12822)Z=Z(C,k)I=Z else I=z[r[7]]k=p(12786)k=I[k]o=15168623 k=k(I)I=nil z[r[7]]=I end else o=14595478 q=p(12252)v=z[r[4]]n=v[q]v=p(12281)q=p(12246)v=n[v]v=v(n,q)M=v end else if o<6377015 then if o<6369376 then C=x[1]I=z[r[1]]k=z[r[2]]Z=k*C o=I+Z z[r[1]]=o Z=z[r[3]]N=z[r[2]]k=N*C I=Z+k N=p(12315)z[r[3]]=I k=z[r[4]]Z=k[N]o=Z and 13202649 or 3649669 else k=p(12719)Z=u[k]k=p(12027)N=B(1564376,{C})o=Z[k]k=1.5 Z=o(k,N)o=11640006 end else k=nil o=z[r[1]]Z=p(12547)o[Z]=k o=z[r[1]]y=p(12252)k=nil Z=p(12742)o[Z]=k N=z[r[2]]k=N[y]Z=k o=k and 220018 or 11622162 end end end else if o<6407456 then if o<6390839 then if o<6383457 then if o<6382345 then I={}o=u[p(12306)]else b=p(12829)o=p(12041)o=py[o]i=H o=o(py,b)o=o and 867691 or 3820612 end else I={}o=u[p(12754)]end else if o<6403302 then if o<6393284 then o=V o=5157502 a=g else o=2635347 D=z[r[1]]t=p(12252)V=D[t]g=a~=V X=g end else Z=false o=z[r[2]]k=p(12328)I=o(C,Z)Z=p(12350)I=C[Z]Z=u[k]o=I==Z o=o and 12859143 or 10138307 end end else if o<6441588 then if o<6432841 then if o<6425668 then o=I and 14084578 or 10012848 else o=z[r[5]]I=o()o=2286953 end else I=z[r[2]]o=not I o=o and 6997603 or 11926816 end else if o<6452778 then if o<6448953 then Z=z[r[1]]k=p(12007)o=15623557 C=Z[k]I=C else y=p(12153)N=C[y]Y=p(12585)l=u[Y]Y=p(12153)W=l[Y]l=p(12468)y=W[l]k=N==y I=k o=k and 805959 or 4666850 end else o=I and 11911532 or 11216647 end end end end else if o<6652190 then if o<6520349 then if o<6499200 then if o<6479891 then if o<6477157 then sy=I o=sy and 1920222 or 12700040 else o=3064051 end else if o<6488501 then X=not a W=W+Y I=W<=l I=X and I X=W>=l X=a and X I=X or I X=13368730 o=I and X I=5433760 o=o or I else q=p(12252)R=p(12409)I=u[R]R=p(12810)o=I[R]R=p(12343)I=o(R)R=I I=p(12246)n=1190 o=p(12628)R[o]=I I=false o=p(12405)R[o]=I I=p(12836)o=p(12095)o=R[o]o=o(R,I,n)o=p(12636)I=p(12057)R[o]=I v=p(12318)n=z[r[4]]o=p(12350)I=n[v]R[o]=I o=m(R)v=z[r[4]]n=v[q]I=n o=n and 617816 or 15283177 end end else if o<6514100 then if o<6504870 then Z=p(12745)N=p(12848)C=u[Z]Z=C()k=z[r[1]]C=k[N]I=Z-C C=1.5 o=I>=C o=o and 4599916 or 3716075 else o=z[r[1]]C=z[r[2]]I=o(C)I={}o=u[p(12512)]end else o=V D=X k=D N=o o=13707115 end end else if o<6541677 then if o<6533229 then if o<6531741 then o=z[r[1]]Z=p(12407)y=3 k=z[r[2]]N=p(12721)C={[Z]=k;[N]=y}I=o(C)o=952156 else o=z[r[4]]o=o and 14905019 or 11695730 end else W=z[r[4]]o=466342 y=not W k=y end else if o<6650160 then if o<6583413 then Z=z[r[1]]C=not Z o=C and 15891998 or 8195603 I=C else Z=p(12810)Y=p(12425)I=z[r[1]]o=I[Z]C=x[1]Z=p(12529)I=o(Z)o=p(12737)o=I[o]o=o(I)I=p(12642)l=p(12425)o=u[I]W=z[r[2]]y=W[l]W=p(12662)N=y[W]y=p(12285)k=N[y]N=p(12692)Z=k[N]I=o(Z)Z=e()z[Z]=I I=p(12642)o=u[I]l=z[r[2]]a=p(12425)W=l[Y]l=p(12662)y=W[l]W=p(12820)N=y[W]y=p(12640)k=N[y]I=o(k)k=e()z[k]=I X=p(12425)I=p(12642)o=u[I]Y=z[r[2]]l=Y[a]Y=p(12662)W=l[Y]l=p(12285)y=W[l]W=p(12869)N=y[W]I=o(N)N=e()z[N]=I I=p(12642)o=u[I]a=z[r[2]]Y=a[X]a=p(12662)l=Y[a]Y=p(12285)W=l[Y]l=p(12803)y=W[l]I=o(y)y=e()W=p(12281)l=p(12054)z[y]=I I=z[r[2]]W=I[W]W=W(I,l)o=not W o=o and 15318646 or 4306036 end else Z=z[r[5]]o=Z and 15951580 or 14495562 end end end else if o<6708968 then if o<6660440 then if o<6655264 then if o<6653689 then o=p(12786)o=y[o]o=o(y)o=11457700 else V=l o=11787007 end else V=p(12719)g=u[V]V=p(12668)I=g[V]V=O(10964996,{r[10];X})g=I(V)o=8252109 end else if o<6676923 then if o<6662800 then o=I and 16027772 or 12201475 else o=z[r[1]]o=o and 8368993 or 4498111 end else h=p(12574)A=Q[h]o=5556294 b=p(12514)py[b]=A end end else if o<6753386 then if o<6732951 then if o<6715356 then k=p(12830)Z=z[r[1]]C=Z[k]o=C and 9535207 or 6332238 I=C else z[Z]=Q o=z[Z]o=o and 9718529 or 2767388 end else o=3842108 l=nil Y=c(Y)end else if o<6841265 then if o<6787881 then f=p(12801)q=z[N]v=q[f]o=15738842 R=v else o=u[p(12220)]I={}end else o=I and 6432244 or 2286953 end end end end end else if o<7130300 then if o<6975347 then if o<6911232 then if o<6896627 then if o<6889625 then if o<6888910 then Z=p(12719)C=u[Z]Z=p(12392)o=2607744 I=C[Z]Z=z[r[2]]C=I(Z)I=nil z[r[2]]=I else I={}o=true z[r[1]]=o o=u[p(12602)]end else if o<6894482 then o=14058253 N=nil l=nil y=nil W=nil else C=z[r[1]]I=C o=C and 601498 or 7988369 end end else if o<6904508 then if o<6899359 then Z=nil o=13033508 C=nil else I={}o=u[p(12261)]end else W=z[r[3]]N=o y=not W k=y o=y and 1699533 or 8055400 end end else if o<6945976 then if o<6940584 then if o<6930429 then C=x[1]Z=p(12617)I=p(12328)o=u[I]I=p(12281)I=o[I]I=I(o,Z)Z=I o=not Z o=o and 15846317 or 5854769 else o=p(12530)o=W[o]o=o(W)o=12179136 end else k=p(12683)Z=z[r[1]]C=Z[k]Z=p(12365)o=7314955 Z=C[Z]Z=Z(C)I=Z end else if o<6973928 then if o<6947455 then o=u[p(12423)]I={}else V=p(12530)o=15820080 V=g[V]V=V(g)end else N=z[r[2]]Z=o k=not N C=k o=k and 4177650 or 9078436 end end end else if o<7015352 then if o<6995539 then if o<6993187 then if o<6986454 then o=p(12530)o=l[o]o=o(l)o=16253561 else I=p(12786)o=z[r[1]]I=o[I]I=I(o)o=nil z[r[1]]=o o=10695112 end else o=z[r[1]]o=o and 11024127 or 2736396 end else if o<6997958 then if o<6996249 then l=l+a g=not X I=l<=Y I=g and I g=l>=Y g=X and g I=g or I g=3711613 o=I and g I=9271523 o=o or I else I={}o=u[p(12548)]end else o=p(12530)o=sy[o]o=o(sy)o=497659 end end else if o<7084547 then if o<7068120 then if o<7041387 then Z=p(12350)I=C[Z]Z=z[r[4]]o=I~=Z o=o and 6404585 or 3610442 else V=p(12719)g=u[V]V=p(12668)I=g[V]V=S(600869,{r[10];X})g=I(V)o=13199167 end else Y=p(12585)y=p(12153)N=C[y]l=u[Y]Y=p(12153)o=3966693 W=l[Y]l=p(12468)y=W[l]k=N==y I=k end else if o<7124604 then if o<7109011 then o=z[r[3]]I=o()o=15293320 else W=p(12186)W=y[W]W=W(y)Y=N X=p(12681)a=p(12281)a=C[a]l=p(12628)W[l]=Y a=a(C,X)l=a Y=o o=a and 9720170 or 7336477 end else k=z[r[5]]y=4 N=1 I=k+N z[r[5]]=I N=z[r[5]]k=N>y o=k and 6251112 or 15368357 end end end end else if o<7210760 then if o<7172261 then if o<7153516 then if o<7136819 then if o<7133635 then o=z[r[1]]o=o and 9002624 or 4263888 else N=Z o=y and 4615663 or 921818 end else if o<7146308 then o=u[p(12121)]C=nil Z=nil I={}else I=1 g=p(12328)V=p(12369)o=a[I]X=o I=u[g]o=p(12350)X[o]=I g=u[V]V=p(12810)D=0 o=p(12515)I=g[V]o=X[o]V=0 g={I(V,k,D)}I=p(12122)o=o(X,s(g))o=C[I]I=X o[l]=I I={X}o=u[p(12567)]end end else if o<7171757 then if o<7157309 then o=u[p(12243)]I={}else I={}o=u[p(12832)]end else P,Q=D(t,P)o=P and 273621 or 4155921 end end else if o<7196502 then if o<7193675 then if o<7185644 then o=I and 5622671 or 2581514 else Z=p(12855)k=p(12280)o=2092894 Z=C[Z]Z=Z(C,k)I=Z end else b=o uy=1 h=i[uy]uy=false A=h==uy o=A and 8091475 or 4685592 py=A end else if o<7203868 then if o<7202311 then a=1 o=10292527 Y=W[a]a=p(12029)a=Y[a]a=a(Y)Y=1 l=a[Y]I=l else q=p(12369)v=p(12607)n=Q[v]v=p(12369)f=p(12574)A=p(12508)R=n[v]o=3090304 n=p(12011)v=m[q]n=R[n]n=n(R,v)q=Q[f]f=p(12369)v=q[f]R=v*n f=p(12369)q=m[f]f=p(12673)F=p(12723)f=q[f]f=f(q)q={}v=R*f f=u[F]py=z[M]A=py[A]b={A(py)}py={f(s(b))}H=py[2]i=py[3]F=py[1]end else o=z[r[4]]I=o()o=468241 end end end else if o<7269612 then if o<7230330 then if o<7212810 then if o<7212699 then o=z[r[1]]C=z[r[2]]Z=false I=o(C,Z)o=z[r[3]]o=o and 14835226 or 1378526 else y=z[r[3]]o=7311581 W=p(12801)N=y[W]Z=N end else I=p(12530)o=z[r[1]]I=o[I]I=I(o)I={}o=u[p(12402)]end else if o<7261156 then if o<7240488 then n=nil v=nil q=nil o=10328770 R=nil else Z=z[r[5]]o=Z and 1354891 or 5730661 end else W=z[r[3]]y=not W k=y N=o o=y and 10848484 or 5210820 end end else if o<7297698 then if o<7294477 then if o<7275304 then I={}o=u[p(12549)]else I=C o=Z o=5006771 end else Z=true I=p(12802)o=z[r[1]]o[I]=Z I=z[r[1]]Z=p(12769)o=I[Z]Z=true I=p(12663)o[I]=Z I=z[r[2]]Z=p(12252)o=I[Z]Z=p(12280)I=p(12855)I=o[I]I=I(o,Z)Z=I o=Z and 14981713 or 13950171 end else if o<7310923 then if o<7305517 then Z=nil o=1615894 else o=z[r[1]]o=o and 8578855 or 15078876 end else I=p(12346)y=1 o=k I=o[I]k=nil N=.8 I=I(o,C,Z,k,N,y)C=p(12302)o=z[r[1]]k=o W=z[r[2]]y=o N=W o=W and 9014640 or 3069128 end end end end end end else if o<7887759 then if o<7591384 then if o<7467300 then if o<7416183 then if o<7374016 then if o<7336711 then if o<7324625 then Z=p(12822)C=e()k=p(12280)z[C]=I y=e()I=p(12356)o=z[C]I=o[I]W=p(12434)I=I(o,Z)o=z[C]Z=I N=p(12318)I=p(12356)I=o[I]I=I(o,k)k=e()z[k]=I I=p(12356)o=z[r[1]]I=o[I]I=I(o,N)N=e()z[N]=I o=z[r[1]]I=p(12560)I=o[I]I=I(o)z[y]=I o=z[r[2]]I=o(W)W=I l=not W I=l o=l and 3320111 or 292646 else X=p(12854)a=p(12281)a=C[a]o=9720170 a=a(C,X)l=a end else if o<7339361 then X=p(12695)I=p(12625)o=u[I]a=u[X]X=a(Z)Y=p(12050)l=Y..X I=o(l)o=u[p(12296)]I={}else W=z[r[6]]l=p(12178)N=W[l]l=d(10637317,{r[1];r[13];r[14],r[2],r[15]})W=p(12573)o=16348443 W=N[W]W=W(N,l)end end else if o<7407434 then if o<7390288 then I={}o=u[p(12533)]else b=p(12369)uy=p(12369)h=py[uy]A=v*h o=4936528 py[b]=A end else o=z[r[1]]o=o and 5862216 or 110134 end end else if o<7444023 then if o<7438155 then if o<7425803 then y=p(12508)I=p(12368)o=u[I]k=z[r[2]]y=k[y]N={y(k)}k={o(s(N))}C=k[2]Z=k[3]I=k[1]o=7885078 k=I else o=z[r[3]]I=o()C=I o=not C o=o and 9879550 or 14981111 end else C=x[1]I=p(12070)Z=x[2]o=z[r[1]]I=o[I]I=I(o)o=I and 1718759 or 9568905 end else if o<7456875 then if o<7448122 then o=u[p(12520)]I={}else o=I and 16630213 or 1873297 end else o=8402758 a=c(a)l=c(l)W=nil end end end else if o<7516784 then if o<7499892 then if o<7489727 then if o<7473364 then y=p(12609)N=z[r[9]]y=N[y]y=y(N)o=1461147 N=nil z[r[9]]=N else W=p(12409)o=10217832 y=u[W]W=p(12810)N=y[W]W=p(12755)y=N(W,Z)I=y end else I={Z}V=p(12359)a=c(a)y=nil N=c(N)W=c(W)l=c(l)k=c(k)g=u[V]D=Z V=p(12538)o=u[p(12166)]g[V]=D X=c(X)Y=c(Y)end else if o<7511949 then if o<7505244 then o=t o=13951903 V=D else C=x[1]I=z[r[1]]k=e()Z=p(12810)y=p(12356)o=I[Z]Z=p(12528)I=o(Z)o=p(12737)o=I[o]o=o(I)W=p(12425)Z=e()I=p(12642)o=false z[Z]=o o=false z[k]=o o=u[I]N=z[r[2]]l=p(12356)y=N[y]y=y(N,W)W=p(12662)N=p(12356)N=y[N]N=N(y,W)W=p(12372)y=p(12356)y=N[y]y=y(N,W)a=p(12318)W=p(12336)l=y[l]N={l(y,W)}I=o(s(N))N=e()y=e()o=B(12395948,{r[3]})z[N]=I W=e()z[y]=o o=d(9787445,{k,Z;y,N})z[W]=o I=z[r[4]]l=p(12441)o=I[l]l=B(7443731,{r[4];k;W})I=p(12573)I=o[I]I=I(o,l)Y=z[r[3]]l=Y[a]Y=p(12281)a=p(12087)Y=l[Y]Y=Y(l,a)I=Y o=Y and 4821949 or 13966955 end else C=z[r[8]]Z=C()I={}o=u[p(12612)]end end else if o<7554704 then if o<7538722 then if o<7517450 then k=p(12779)I=C[k]W=p(12585)y=u[W]W=p(12779)N=y[W]y=p(12336)k=N[y]o=I==k o=o and 12512251 or 4699070 else o=Z o=14843267 I=C end else k=x[3]C=e()g=e()Z=x[2]N=e()z[C]=x[1]z[N]=x[4]I=p(12197)Q=p(12369)y=e()a=e()z[y]=x[5]R=p(12778)X=e()o=z[C]I=o[I]I=I(o)W=I o=z[C]I=p(12310)I=o[I]I=I(o)l=I I=2 o=W/I Y=o o=false z[a]=o o=false I=p(12205)n=p(12012)z[X]=o o=L(3597013,{r[1];C})z[g]=o o=B(2609264,{C;r[1];a,X,N,g,y})V=o o=V(I,l,W)I=p(12389)P=u[Q]Q=p(12810)t=P[Q]M=p(12778)Q=0 m=Y[M]M=0 P=t(Q,m,M)Q=p(12002)D=l*P P=u[Q]m=p(12336)Q=p(12810)t=P[Q]Q=W[m]M=W[R]R=2 m=M/R R=p(12012)M=W[R]P={t(Q,m,M)}X=c(X)o=V(I,D,s(P))Q=p(12369)P=u[Q]Q=p(12810)R=p(12778)I=p(12846)t=P[Q]Q=0 M=Y[R]m=-M M=0 P=t(Q,m,M)m=p(12336)D=l*P Q=p(12002)P=u[Q]Q=p(12810)t=P[Q]Q=W[m]R=p(12778)M=W[R]R=2 m=M/R R=p(12012)M=W[R]P={t(Q,m,M)}Q=p(12369)M=p(12336)o=V(I,D,s(P))P=u[Q]I=p(12477)Q=p(12810)t=P[Q]m=Y[M]Q=-m M=0 m=0 P=t(Q,m,M)D=l*P Q=p(12002)M=p(12336)P=u[Q]R=p(12012)Q=p(12810)t=P[Q]m=W[M]M=2 Q=m/M M=p(12778)m=W[M]M=W[R]P={t(Q,m,M)}o=V(I,D,s(P))M=0 I=p(12277)m=p(12336)Q=p(12369)P=u[Q]Q=p(12810)t=P[Q]Q=Y[m]m=0 P=t(Q,m,M)Q=p(12002)D=l*P P=u[Q]Q=p(12810)R=p(12012)t=P[Q]M=p(12336)m=W[M]M=2 Q=m/M y=c(y)k=nil M=p(12778)m=W[M]g=c(g)Z=nil M=W[R]P={t(Q,m,M)}o=V(I,D,s(P))I=p(12110)Q=p(12369)P=u[Q]Q=p(12810)t=P[Q]Q=0 R=Y[n]C=c(C)M=-R m=0 P=t(Q,m,M)Q=p(12002)m=p(12336)D=l*P P=u[Q]Q=p(12810)t=P[Q]M=p(12778)Q=W[m]n=p(12012)m=W[M]R=W[n]n=2 a=c(a)M=R/n P={t(Q,m,M)}Q=p(12369)o=V(I,D,s(P))I=p(12108)P=u[Q]Q=p(12810)m=0 t=P[Q]R=p(12012)Q=0 N=c(N)M=Y[R]P=t(Q,m,M)m=p(12336)Q=p(12002)M=p(12778)D=l*P P=u[Q]Q=p(12810)t=P[Q]Q=W[m]m=W[M]l=nil n=p(12012)R=W[n]n=2 M=R/n Y=nil W=nil P={t(Q,m,M)}o=V(I,D,s(P))V=nil I={}o=u[p(12026)]end else if o<7581558 then if o<7564748 then o=u[p(12274)]I={}else o=z[r[3]]I=o()o=9035214 end else I=p(12346)o=k I=o[I]k=nil y=1.1 N=.75 I=I(o,C,Z,k,N,y)o=u[p(12784)]I={}end end end end else if o<7777927 then if o<7684085 then if o<7659716 then if o<7614411 then if o<7595751 then o={}Z=x[2]N=p(12617)k=o C=x[1]I=p(12328)o=u[I]I=p(12281)I=o[I]I=I(o,N)N=I o=not N o=o and 9738154 or 4404389 else o=8446016 k=nil end else if o<7652792 then o=z[r[5]]k=p(12474)Z=z[r[6]]C=Z[k]Z=false I=o(C,Z)o=2829777 else I=p(12041)k=p(12343)o=z[r[2]]I=o[I]I=I(o,k)o=I and 9472575 or 8446016 end end else if o<7675089 then if o<7665791 then k,W=N(Z,k)o=k and 1093002 or 7686902 else o=5906573 C=nil end else a=g o=V o=5415928 end end else if o<7735677 then if o<7729826 then if o<7699726 then I={}o=u[p(12571)]C=nil else C=x[1]Z=x[2]o=z[r[1]]I=o()k=I o=not k o=o and 1771676 or 12162116 end else Y=nil a=nil o=14299492 end else if o<7773002 then if o<7761729 then o=z[r[1]]C=p(12374)N=p(12801)k=z[r[2]]Z=k[N]y=1 I=p(12346)k=nil N=.75 I=o[I]I=I(o,C,Z,k,N,y)I={}o=u[p(12455)]else C=p(12409)I=u[C]C=p(12810)o=I[C]k=e()C=p(12207)I=o(C)C=I o=p(12270)I=p(12658)C[o]=I I=p(12299)o=z[r[1]]I=o[I]I=I(o,C)o=p(12157)Z=I I=2 o=Z[o]o=o(Z,I)o=p(12346)I=p(12178)o=Z[o]o=o(Z)o=false z[k]=o N=S(12319794,{k})o=Z[I]I=p(12573)I=o[I]I=I(o,N)o=14493117 end else o=I and 1201811 or 15384465 end end end else if o<7854646 then if o<7835011 then if o<7819670 then if o<7808114 then Z=x[2]k=not Z o=k and 12176526 or 16205844 C=x[1]I=k else Z=z[r[1]]N=p(12481)k=p(12490)o=17589 k=Z[k]k=k(Z,C,N)I=k end else o=z[r[2]]I=o()o=14772180 end else if o<7849676 then if o<7842247 then o=Z I=C o=6332238 else I={}o=u[p(12712)]end else m=p(12111)Q=X[m]m=0 t=o P=Q>m o=P and 1304829 or 13231153 D=P end end else if o<7865479 then if o<7861271 then if o<7855186 then Z=nil C=nil o=u[p(12101)]I={}else I=z[r[1]]Z=p(12547)o=I[Z]o=o and 1793862 or 11588383 end else W,Y=N(y,W)o=W and 1353770 or 7986804 end else if o<7883309 then if o<7870878 then o=z[r[1]]N=p(12801)k=z[r[2]]C=p(12374)Z=k[N]N=.75 y=1 k=nil I=p(12346)I=o[I]I=I(o,C,Z,k,N,y)o=u[p(12181)]I={}else o=I and 8347129 or 7437991 end else Z,y=k(C,Z)o=Z and 11731901 or 751376 end end end end end else if o<8190346 then if o<8053315 then if o<7987854 then if o<7959635 then if o<7897379 then if o<7891354 then o=p(12281)I=p(12822)o=C[o]Z=e()o=o(C,I)z[Z]=o I=z[Z]o=not I o=o and 6358000 or 13132038 else I=p(12801)o=Z[I]I=p(12310)N=p(12801)I=C[I]g=p(12801)I=I(C)k=o o=I[N]W=p(12002)N=o o=N-k y=o I=u[W]W=p(12810)o=I[W]Y=z[r[1]]a=p(12801)l=Y[a]Y=p(12336)W=l[Y]X=z[r[1]]a=X[g]g=p(12801)X=p(12778)Y=a[X]a=99999 l=Y+a X=z[r[1]]a=X[g]X=p(12012)Y=a[X]I=o(W,l,Y)o=p(12515)W=I Y=p(12369)l=u[Y]Y=p(12810)I=l[Y]Y=W+y o=C[o]l={I(Y)}I=1 o=o(C,s(l))l=3 Y=l l=1 o=6996066 a=l l=0 X=a<l l=I-a end else if o<7911357 then C=I o=C and 8687642 or 14986178 else I=p(12135)o=z[r[1]]N=p(12219)k=z[r[4]]Z=k[N]N=B(6503268,{r[1]})k=p(12573)k=Z[k]C=nil k=k(Z,N)o[I]=k Z=p(12719)I=u[Z]Z=p(12027)N=p(12204)o=I[Z]k=z[r[1]]Z=k[N]k=B(12278709,{r[1];r[5]})I=o(Z,k)o=3426940 end end else if o<7984789 then if o<7966865 then X=p(12689)l=o a=u[X]X=p(12394)Y=a[X]o=Y and 11306566 or 15069327 W=Y else o=W o=N and 12208850 or 16052739 end else o=9847392 end end else if o<8020356 then if o<7994447 then if o<7989165 then o=I and 2892687 or 7160233 else Z=z[r[1]]C=not Z o=C and 1556758 or 1106468 I=C end else f=c(f)o=1906874 F=c(F)i=nil n=c(n)H=c(H)v=c(v)q=c(q)end else if o<8047849 then if o<8039808 then py=z[Z]o=py and 7196173 or 5574877 I=py else C=false I=p(12802)o=z[r[1]]o[I]=C C=p(12769)I=z[r[1]]o=I[C]C=false I=p(12663)o[I]=C o=z[r[2]]I=o()o=2800161 end else o=u[p(12254)]I={}end end end else if o<8105343 then if o<8087787 then if o<8068357 then if o<8056015 then o=N o=7284632 C=k else I={}o=u[p(12279)]end else P,Q=D(t,P)o=P and 8611471 or 6966503 end else if o<8091952 then if o<8090152 then k=p(12252)Z=z[r[2]]C=Z[k]o=C and 12971072 or 7897678 I=C else uy=2 h=i[uy]uy=z[H]A=h==uy o=4685592 py=A end else Y=p(12369)o=l[Y]Y=p(12182)X=p(12801)Y=o[Y]a=Z[X]t=p(12489)Y=Y(o,a)X=p(12411)a=l[X]P=p(12336)X=2 o=a/X a=o D=u[t]t=p(12794)V=D[t]t=Y[P]D=V(t)t=p(12336)V=a[t]g=D<V o=g and 13276683 or 2146777 X=g end end else if o<8146210 then if o<8140098 then if o<8121041 then I=true o=true z[r[3]]=o z[r[2]]=I k=z[r[4]]o=k and 4619865 or 4445178 else Z=nil I={}C=nil o=u[p(12750)]end else X=nil g=nil o=14633786 end else if o<8173770 then if o<8166539 then N=nil y=nil o=7885078 else k=nil Z=nil g=20 o=X N=nil V=p(12164)X=p(12568)W={[l]=C,[Y]=a;[X]=g;[V]=y}I=o(W)C=nil o=u[p(12078)]y=nil I={}end else I=p(12524)k=p(12399)Z={k}o={[I]=Z}I={o}o=u[p(12201)]end end end end else if o<8322576 then if o<8251722 then if o<8209107 then if o<8200085 then if o<8194961 then o={}I={}z[r[1]]=o o=u[p(12079)]else C=z[r[2]]I=C o=15891998 end else Z=nil o=10289638 end else if o<8251079 then if o<8211654 then q=z[N]f=p(12801)v=q[f]R=v o=14095388 else o=true o=o and 5722482 or 10653942 end else Z=p(12822)I=p(12281)I=C[I]I=I(C,Z)Z=I I=not Z o=I and 13026132 or 3225925 end end else if o<8277438 then if o<8258492 then if o<8253066 then a=nil o=8373558 X=c(X)Y=nil l=nil else W=p(12347)o=8609855 y=u[W]I=y end else Y=p(12483)l=p(12489)W=I I=u[l]l=p(12413)o=I[l]l=e()z[l]=o I=u[Y]Y=p(12085)V=p(12483)o=I[Y]g=u[V]a=g Y=o X=o o=g and 5759234 or 11095337 end else if o<8317079 then if o<8289433 then o=15741668 W=true I=z[r[2]]y=p(12045)I[y]=W else o=I and 11228235 or 4083076 end else I={}o=u[p(12309)]end end end else if o<8372556 then if o<8349985 then if o<8346689 then if o<8327912 then I=z[r[1]]Z=p(12810)C=x[1]P=1236 y=e()o=I[Z]Z=p(12656)I=o(Z)o=p(12737)o=I[o]R=1173 o=o(I)g=1191 I=p(12689)o=u[I]a=e()V=p(12615)I=p(12394)Q=p(12171)Z=p(12760)X=e()n=p(12076)I=o[I]I=I(o,Z)o=B(14588281,{})N=e()k=e()Y=e()Z=e()z[Z]=I z[k]=o o=S(12630103,{})I=p(12752)z[N]=o o=J(13606350,{})l=e()W=e()z[y]=o o=B(8483278,{})m=1173 M=p(12665)z[W]=o o=J(12242496,{Z})D=1235 z[l]=o o=J(2139882,{l,Z})z[Y]=o t=p(12076)o=j(7553312,{r[2]})v=p(12752)z[a]=o o=U(10318022,{r[3]})z[X]=o o={[I]=g;[V]=D;[t]=P,[Q]=m;[M]=R}V=e()g=e()D=e()z[g]=o o=j(10727573,{g;r[2]})z[V]=o o=O(10882556,{r[2];N;r[4];Y;W;l,y})z[D]=o q=p(12665)o=S(16186008,{k,X;a;V,D})t=o o=d(2344435,{k,X;a,V,D})P=o o=L(1760779,{k,X,a,V;D})Q=o I=p(12171)o=J(6224170,{k;X,a;V;D})m=o R=p(12615)o=B(2541063,{k;X;a,V,D})M=o o={I;R,n;v;q}R=e()q=p(12318)z[R]=o o=S(4150923,{R})n=o v=z[r[2]]I=v[q]o=n(I)I=z[r[2]]v=p(12252)o=I[v]v=o o=v and 3570676 or 279625 else Z=x[2]C=x[1]k=p(12830)I=z[r[1]]o=I[k]o=o and 5137589 or 15117914 end else o=u[p(12066)]I={}end else if o<8368819 then if o<8359089 then o=z[r[1]]W=p(12700)N=p(12407)m=false Q=p(12071)Z=p(12147)k=z[r[2]]Y=p(12597)y=z[r[3]]l=z[r[4]]a=z[r[5]]X=p(12705)g=3 C={[Z]=k;[N]=y;[W]=l;[Y]=a;[X]=g}I=o(C)o=z[r[6]]X=p(12445)Y=p(12597)N=p(12407)k=z[r[2]]W=p(12700)Z=p(12147)P=800 y=z[r[3]]l=z[r[4]]a=z[r[5]]V=z[r[4]]t=z[r[5]]D=t*P g=V+D t=p(12061)D=3.5 V=p(12451)P=z[r[7]]C={[Z]=k;[N]=y;[W]=l,[Y]=a;[X]=g,[V]=D,[t]=P;[Q]=m}I=o(C)I={}o=u[p(12215)]else o=z[r[2]]I=o()o=10883424 end else o=z[r[2]]Z=p(12810)y=p(12141)I=o()o=z[r[3]]I=p(12530)I=o[I]k=p(12237)I=I(o)o=z[r[4]]C=z[r[5]]I=o(C)C=I I=z[r[6]]o=I[Z]N=C..y Z=k..N C=nil I=o(Z)Z=p(12719)o=p(12737)o=I[o]o=o(I)I=u[Z]Z=p(12783)o=I[Z]Z=.5 I=o(Z)o=z[r[7]]Z=z[r[1]]k=z[r[5]]I=o(Z,k)o=16716293 end end else if o<8405698 then if o<8393342 then if o<8387353 then W,Y=N(y,W)o=W and 14423784 or 6477249 else y=0 I=p(12192)o=z[N]o[I]=y y=0 o=z[N]I=p(12594)o[I]=y I=p(12653)y=true o=z[N]o[I]=y o=13939516 end else I=z[r[3]]k=p(12350)N=z[r[5]]y=true o=u[p(12379)]I[k]=N I=z[r[6]]N=z[r[3]]k=I(N,y)N=p(12719)k=u[N]N=p(12783)I=k[N]k=I()I=z[r[7]]k=p(12616)k=I[k]N=z[r[3]]k=k(I,N)N=p(12719)C=nil k=u[N]N=p(12783)Z=nil I=k[N]N=1 k=I(N)I=false z[r[1]]=I I={}end else if o<8446159 then if o<8439163 then o=u[p(12339)]I=z[r[2]]I={I}else o=z[r[5]]Z=nil k=z[r[2]]I=o(k)o=2480494 end else o=4649275 V=nil end end end end end end end end end else if o<12314089 then if o<10365393 then if o<9560522 then if o<8921225 then if o<8673325 then if o<8558464 then if o<8504454 then if o<8480475 then if o<8453083 then if o<8450098 then k=z[r[2]]C=k o=2196080 else C=z[r[1]]o=C and 10019982 or 5006771 I=C end else if o<8473511 then C=false o=z[r[1]]k=p(12742)I=p(12740)Z=p(12745)o[I]=C I=p(12848)o=z[r[1]]C=u[Z]Z=C()o[I]=Z Z=z[r[1]]C=Z[k]I=C o=C and 15347099 or 4634155 else o=4028957 Y=nil a=nil end end else if o<8493404 then if o<8482753 then I=p(12238)Z=d(12079565,{r[1],r[2]})o=C[I]I=p(12573)I=o[I]I=I(o,Z)I=p(12088)o=C[I]Z=O(9081373,{r[1];r[3],r[4],r[5]})I=p(12573)I=o[I]I=I(o,Z)I=p(12531)Z=J(5923408,{r[1];r[3];r[4]})o=C[I]I=p(12573)I=o[I]I=I(o,Z)o=15145305 else C=p(12409)I=u[C]C=p(12810)o=I[C]C=p(12258)Z=p(12751)I=o(C)C=e()z[C]=I o=z[C]I=p(12482)o[I]=Z o=z[C]Z=10 I=p(12412)o[I]=Z o=z[C]k=p(12328)I=p(12350)Z=u[k]o[I]=Z o=z[C]I=p(12346)I=o[I]I=I(o)I=z[C]Z=p(12866)o=I[Z]Z=J(7216738,{C})I=p(12573)I=o[I]C=c(C)I=I(o,Z)o=u[p(12043)]I={}end else o=u[p(12827)]I={}end end else if o<8521936 then if o<8516562 then if o<8508304 then Y=z[r[8]]a=p(12350)l=Y[a]o=1532475 y=l else t=p(12871)I=p(12625)o=u[I]m=p(12063)g=p(12462)Q=W[m]m=p(12811)P=Q..m D=t..P V=l..D X=g..V I=o(X,Y)I={}o=u[p(12159)]end else I={}o=u[p(12312)]end else if o<8551473 then if o<8530118 then o=false Z=false C=p(12663)z[r[2]]=o I=z[r[3]]I[C]=Z Z=p(12252)C=z[r[4]]I=C[Z]C=I I=not C o=I and 6258760 or 776168 else o=z[r[3]]Z=true I=o(C,Z)o=1011218 end else a=2 Y=p(12721)I=z[r[10]]W=p(12407)l=z[Z]y={[W]=l;[Y]=a}N=I(y)o=801157 end end end else if o<8601663 then if o<8579207 then if o<8577216 then if o<8561328 then k=p(12779)W=p(12585)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12012)k=N[y]o=I==k o=o and 13359352 or 7517424 else I={}o=false z[r[3]]=o o=u[p(12417)]end else I=p(12530)o=z[r[1]]I=o[I]I=I(o)o=15078876 end else if o<8589122 then if o<8584203 then I=z[r[1]]Z=p(12742)o=I[Z]I=p(12786)I=o[I]I=I(o)o=z[r[1]]Z=nil I=p(12742)o[I]=Z o=15562782 else Y=p(12029)Y=N[Y]I=p(12723)o=u[I]l={Y(N)}Y={o(s(l))}o=4028957 W=Y[3]I=Y[1]y=Y[2]l=I end else i,py=F(H,i)o=i and 11167345 or 7233254 end end else if o<8623650 then if o<8611229 then if o<8606799 then k=p(12822)I=p(12281)I=Z[I]I=I(Z,k)o=C~=I o=o and 3412289 or 13654860 else o=I and 13983190 or 3520909 end else m=p(12281)R=o m=W[m]m=m(W,Q)V=P M=m o=m and 11630291 or 12795478 end else if o<8667796 then if o<8635701 then k=z[r[7]]W=true y=z[r[8]]N=k(y,W)y=p(12719)N=u[y]o=u[p(12566)]y=p(12668)k=N[y]y=B(16137764,{r[9];C;r[4]})N=k(y)I={}C=c(C)Z=nil else Z=p(12280)I=p(12281)I=C[I]I=I(C,Z)Z=I o=Z and 9223558 or 7300726 end else o=11783440 l=z[r[15]]Y=l()end end end end else if o<8793405 then if o<8719534 then if o<8683075 then if o<8676359 then if o<8675689 then M=I o=M and 16082463 or 6498252 else I={}C=nil o=u[p(12703)]Z=nil end else if o<8678977 then k=p(12822)Z=p(12281)Z=C[Z]Z=Z(C,k)o=5744718 I=Z else Z=nil o=15692446 W=nil end end else if o<8715723 then if o<8697548 then Z=p(12281)k=p(12755)Z=C[Z]Z=Z(C,k)I=Z o=Z and 1655444 or 5423917 else C=z[r[1]]o=C and 5932262 or 6457284 I=C end else I={}o=u[p(12257)]end end else if o<8768092 then if o<8743699 then if o<8721150 then g=true l=y o=e()z[o]=Y Y=o X=p(12021)a=u[X]X=p(12435)o=a[X]X=1 a=o(k,l,X,g)o=a and 5611368 or 6746405 else y=.5 o=z[r[1]]C=p(12132)I=p(12346)k=z[r[2]]N=p(12801)I=o[I]Z=k[N]k=nil N=.7 I=I(o,C,Z,k,N,y)o=u[p(12599)]I={}end else o=z[r[2]]a=p(12132)Y=p(12346)g=p(12801)X=l[g]Y=o[Y]D=1 g=nil V=1.1 Y=Y(o,a,X,g,V,D)o=5559095 end else if o<8789229 then if o<8773898 then o=8251036 else o=N o=k and 4587144 or 12787016 end else I={}o=u[p(12815)]C=nil end end end else if o<8856402 then if o<8810541 then if o<8796376 then if o<8793860 then o=7660696 y=nil W=nil else I={}o=u[p(12421)]end else C=x[1]I=z[r[1]]N=p(12489)Z=z[r[2]]o=I-Z k=u[N]N=p(12794)Z=o I=k[N]k=I(Z)I=1 o=k<I o=o and 1409314 or 1473640 end else if o<8844648 then if o<8841826 then o=0 z[r[1]]=o I=nil o=u[p(12106)]z[r[2]]=I I={}else I=p(12281)k=p(12822)I=Z[I]I=I(Z,k)o=C~=I o=o and 8796177 or 10653768 end else z[r[1]]=I o=6897612 end end else if o<8892651 then if o<8873930 then if o<8861634 then I={}o=u[p(12808)]else X=p(12655)Q=160 m=0 l=false N=z[r[9]]W=z[r[10]]y=N(W,l)z[r[8]]=y l=p(12483)W=u[l]l=p(12828)N=W[l]l=z[r[11]]Y=z[r[12]]D=z[Z]P=p(12002)t=p(12801)V=D[t]t=u[P]P=p(12810)D=t[P]P=0 t=D(P,Q,m)g=V+t V=nil t=1.5 P=p(12346)D=.65 P=Y[P]a={P(Y,X,g,V,D,t)}t=1 W=N(l,s(a))l=p(12483)W=u[l]l=p(12828)N=W[l]l=z[r[11]]X=p(12724)Y=z[r[12]]D=p(12801)V=z[Z]g=V[D]V=nil D=.7 P=p(12346)P=Y[P]a={P(Y,X,g,V,D,t)}W=N(l,s(a))l=p(12719)W=u[l]l=p(12783)N=W[l]l=.5 W=N(l)l=z[r[2]]N=l W=o o=l and 14931986 or 2415955 end else o=z[r[4]]I=o()o=13168451 end else if o<8918398 then if o<8903561 then C=x[1]I=p(12070)Z=x[2]o=z[r[1]]I=o[I]I=I(o)o=I and 1556523 or 1894908 else k=p(12719)I=u[k]k=p(12668)o=I[k]k=L(11339547,{r[4],r[2];C;r[1]})Z=nil I=o(k)o=11127517 end else o=k o=Z and 9819307 or 13607845 end end end end end else if o<9287442 then if o<9077363 then if o<9026111 then if o<9013484 then if o<8929101 then if o<8922994 then W=z[r[4]]y=not W o=5743483 k=y else t=p(12252)o=11846565 D=z[r[1]]V=D[t]g=a~=V X=g end else if o<8936758 then Z=o y=z[r[1]]W=p(12547)N=y[W]k=not N C=k o=k and 7518063 or 13499771 else o=z[r[2]]I=o()o=4263888 end end else if o<9020314 then if o<9017525 then l=z[r[2]]o=3069128 Y=p(12801)W=l[Y]N=W else o=p(12299)I=z[r[3]]o=C[o]o=o(C,I)Z=p(12346)z[r[2]]=o I=z[r[2]]k=true Z=I[Z]Z=Z(I)Z=p(12045)o=u[p(12727)]I=z[r[2]]C=nil I[Z]=k I={}end else f=i b=p(12041)A=p(12829)b=py[b]b=b(py,A)o=b and 6050102 or 808419 end end else if o<9044173 then if o<9035462 then if o<9033360 then g=nil o=12936501 else C=nil I={}o=u[p(12715)]Z=nil end else C=nil I={}o=u[p(12303)]end else if o<9064391 then if o<9058506 then I={I}o=u[p(12825)]else k=p(12409)I=u[k]C=x[1]k=p(12810)Z=x[2]o=I[k]k=p(12570)I=o(k)o=p(12628)k=I I=C k[o]=I I=p(12723)o=u[I]W={o(Z)}I=W[1]y=W[3]N=W[2]o=3051187 W=I end else o=z[r[2]]Z=true I=o(C,Z)o=195546 end end end else if o<9176942 then if o<9094501 then if o<9086324 then if o<9078568 then I=C o=Z o=5522507 else o=z[r[1]]k=p(12252)I=p(12830)C=true o[I]=C Z=z[r[2]]C=Z[k]I=C o=C and 13397962 or 9617442 end else Z=p(12328)o=p(12350)I=u[Z]C=x[1]C[o]=I Z=true o=p(12281)I=p(12073)o=C[o]o=o(C,I,Z)Z=o o=Z and 7892927 or 8139159 end else if o<9164652 then if o<9150879 then I=p(12625)k=p(12131)o=u[I]I=o(k)o=u[p(12498)]I={}else y=3 Z=p(12407)o=z[r[1]]N=p(12721)k=z[r[2]]C={[Z]=k;[N]=y}I=o(C)o=10706113 end else k=p(12343)C=x[1]Z=p(12041)Z=C[Z]Z=Z(C,k)I=Z o=Z and 5365291 or 9921423 end end else if o<9253513 then if o<9219001 then if o<9198981 then Z=z[r[1]]C=not Z o=C and 12891257 or 6034518 I=C else C=nil o=u[p(12344)]I={}Z=nil end else y=p(12755)N=p(12281)N=Z[N]N=N(Z,y)k=o I=N o=N and 4503471 or 15576738 end else if o<9280802 then if o<9266150 then C=c(C)o=9549860 else W=nil Y=p(12801)k=nil o=z[r[2]]a=nil l=Z[Y]y=nil N=nil X=nil I=o(l)l=p(12764)o=z[r[3]]Y=p(12348)I=o(C,l,Y,a,X)o=8139159 end else o=p(12530)o=Y[o]o=o(Y)o=11523058 end end end end else if o<9425951 then if o<9379216 then if o<9311452 then if o<9289966 then if o<9288246 then V=z[r[11]]g=not V X=o a=g o=g and 13800529 or 5464828 else o=z[r[5]]I=o()o=347588 end else if o<9295801 then o=I and 6791155 or 16147067 else o=I and 15716703 or 907842 end end else if o<9329252 then if o<9323947 then Z=nil o=900421 C=nil else o=D and 6516375 or 13707115 end else l=p(12178)W=z[r[6]]N=W[l]o=1096487 W=p(12573)l=O(4511625,{r[1],r[13],r[14];r[2],r[15]})W=N[W]W=W(N,l)end end else if o<9408900 then if o<9400168 then if o<9388940 then N,l=y(k,N)o=N and 2627122 or 13371989 else V=c(V)R=nil F=p(12489)i=360 f=u[F]F=p(12501)Q=nil q=f[F]n=nil I={}M=nil H=z[Y]Z=c(Z)F=H/i f=q(F)q=360 H=p(12233)g=c(g)P=nil v=f*q f=e()q=e()z[q]=v v=nil z[f]=v m=nil F=z[r[3]]v=F[H]F=p(12573)H=d(8798047,{q;Y,f,X;k;l,r[7];W,N;C;a})o=u[p(12604)]q=c(q)k=c(k)W=c(W)F=v[F]l=c(l)y=nil a=c(a)X=c(X)C=c(C)Y=c(Y)D=nil N=c(N)F=F(v,H)z[f]=F f=c(f)end else C=p(12311)o=z[r[1]]W=z[r[2]]N=W k=o y=o o=W and 14731884 or 9441769 end else if o<9415766 then if o<9411447 then R=v o=q o=4800009 else t=p(12483)D=u[t]t=p(12828)Q=p(12801)o=D[t]P=g[Q]t={a;P}D=o(k,t)o=8446497 end else I=z[r[1]]C=p(12729)o=I[C]C=o o=C and 14214682 or 14784866 I=C end end end else if o<9478632 then if o<9462089 then if o<9445129 then if o<9434118 then k=p(12786)o=16575307 I=z[r[6]]k=I[k]k=k(I)I=nil z[r[6]]=I else o=y Z=N o=N and 7311581 or 7212767 end else o=z[r[3]]o=o and 8576327 or 3996158 end else if o<9470507 then if o<9468742 then Z=O(8832294,{r[2];r[1]})C=p(12719)I=u[C]C=p(12027)o=I[C]C=1.5 I=o(C,Z)o=u[p(12725)]z[r[1]]=I I={}else o=z[r[1]]I=o()o=u[p(12406)]I={}end else k=p(12203)o=z[r[2]]I=p(12281)I=o[I]I=I(o,k)k=I o=k and 11906513 or 11482363 end end else if o<9546552 then if o<9535662 then if o<9484330 then o=N C=k o=4658083 else Z=o y=p(12740)N=z[r[1]]k=N[y]o=k and 5042598 or 7839452 C=k end else P=n o=v o=13400056 end else if o<9554797 then if o<9549816 then C=z[r[2]]I=C o=156663 else I={}o=u[p(12598)]end else I={}o=false z[r[1]]=o o=u[p(12565)]end end end end end end else if o<9941118 then if o<9789430 then if o<9696799 then if o<9653249 then if o<9616949 then if o<9589527 then if o<9570958 then I=z[r[2]]o=not I o=o and 15249235 or 15872701 else o=Z o=C and 2688354 or 7516661 end else if o<9600554 then o=F v=f o=9409343 else I={}o=true z[r[1]]=o o=u[p(12637)]end end else if o<9651713 then if o<9617475 then k=p(12683)Z=z[r[2]]o=13397962 C=Z[k]Z=p(12365)Z=C[Z]Z=Z(C)I=Z else N=p(12719)k=u[N]N=p(12783)Z=k[N]k=Z()k=p(12625)N=p(12839)Z=u[k]k=Z(N)Z=false o=Z and 1993181 or 9619230 end else I=z[r[1]]C=z[r[2]]o=I[C]I=p(12609)I=o[I]I=I(o)o=z[r[1]]C=nil I=z[r[2]]o[I]=C o=1718128 end end else if o<9666789 then if o<9661442 then if o<9658213 then V=p(12272)g=p(12041)g=a[g]g=g(a,V)X=g Y=W o=g and 5498851 or 2084761 else o=2734252 Y=z[r[6]]l=not Y y=l end else o=I and 10929810 or 14147827 end else if o<9682672 then if o<9670775 then N=p(12670)o=z[r[1]]k=z[r[2]]y=z[r[3]]Z=p(12252)C={[Z]=k,[N]=y}I=o(C)o=10841915 else o=k N=.75 k=nil y=1.1 I=p(12346)I=o[I]I=I(o,C,Z,k,N,y)o=u[p(12581)]I={}end else I=z[r[1]]k=p(12547)o=I[k]I=p(12786)I=o[I]I=I(o)o=5533142 end end end else if o<9751223 then if o<9719473 then if o<9716236 then if o<9707561 then I=z[r[1]]C=p(12742)o=I[C]I=p(12786)I=o[I]I=I(o)I=p(12742)o=z[r[1]]C=nil o[I]=C o=16652759 else W=z[r[3]]N=o y=not W k=y o=y and 4358880 or 9482830 end else o=3061995 end else if o<9744920 then if o<9728909 then o=Y a=o X=p(12281)X=C[X]g=p(12128)X=X(C,g)o=X and 15565833 or 3645659 Y=X else I={k}o=u[p(12775)]end else o={}Z=1 k=z[r[9]]C=o N=k k=1 y=k k=0 W=y<k k=Z-y o=9848705 end end else if o<9780817 then if o<9758007 then if o<9751245 then m=p(12111)Q=X[m]m=0 P=Q>m D=P t=o o=P and 12360064 or 4425927 else o=I and 15335637 or 10943395 end else Y=p(12721)W=p(12407)I=z[r[10]]a=2 l=z[Z]y={[W]=l,[Y]=a}N=I(y)o=5300216 end else if o<9784649 then if o<9783740 then N=p(12281)y=p(12280)o=4196410 N=k[N]N=N(k,y)I=N else o=I and 7419343 or 15026911 end else Z=z[r[1]]C=not Z o=C and 7872311 or 13117 I=C end end end end else if o<9883235 then if o<9832121 then if o<9804989 then if o<9797651 then if o<9794689 then o=p(12310)o=C[o]o=o(C)N=p(12369)X=p(12801)k=o I=Z[N]Y=p(12801)o=p(12011)y=p(12369)o=k[o]o=o(k,I)I=u[y]y=p(12810)N=o o=I[y]l=z[r[1]]W=l[Y]l=p(12336)y=W[l]a=z[r[1]]Y=a[X]a=p(12778)l=Y[a]Y=99999 W=l+Y a=z[r[1]]X=p(12801)Y=a[X]a=p(12012)l=Y[a]I=o(y,W,l)W=p(12673)W=N[W]y=I o=p(12515)W=W(N)o=C[o]I=y*W o=o(C,I)I=1 W=3 l=W o=6484622 W=1 Y=W W=0 a=Y<W W=I-Y else y=p(12609)N=z[r[9]]y=N[y]o=13756135 y=y(N)N=nil z[r[9]]=N end else if o<9800947 then N=p(12409)I=u[N]N=p(12810)o=I[N]y=p(12833)N=p(12207)I=o(N)o=p(12270)N=I I=y..C y=p(12346)N[o]=I o=p(12299)o=k[o]o=o(k,N)z[r[2]]=o I=z[r[2]]y=I[y]o=Z and 1658216 or 8412406 y=y(I)else I={}o=u[p(12234)]end end else if o<9822910 then if o<9819634 then o=9619230 else g=p(12122)X=C[g]o=15815186 a=X[l]X=p(12350)Y=a[X]I=Y end else Z,y=k(C,Z)o=Z and 10386192 or 2241669 end end else if o<9848765 then if o<9847479 then if o<9846838 then o=z[r[2]]I=p(12786)I=o[I]I=I(o)o=9799630 else I=z[r[10]]o=I and 9780481 or 5300216 end else k=k+y Z=k<=N l=not W Z=l and Z l=k>=N l=W and l Z=l or Z l=12385572 o=Z and l Z=3029476 o=o or Z end else if o<9877262 then if o<9854966 then o=xy o=173055 I=sy else W=0 o=z[r[2]]k=p(12328)I=p(12350)Z=u[k]o[I]=Z y=3 N=p(12002)Z=p(12801)I=C[Z]k=u[N]N=p(12810)Z=k[N]N=0 k=Z(N,y,W)o=I+k Z=o I=p(12041)o=z[r[2]]I=o[I]k=p(12272)I=I(o,k)o=I and 11979230 or 7657874 end else o=u[p(12427)]I={}end end end else if o<9914000 then if o<9904941 then if o<9901703 then if o<9890310 then I=z[r[1]]C=x[1]Z=p(12810)o=I[Z]Z=p(12796)I=o(Z)o=p(12737)o=I[o]Z=p(12642)W=p(12356)y=p(12031)py=p(12409)o=o(I)q=p(12474)I=u[Z]k=z[r[2]]X=p(12425)W=k[W]N={W(k,y)}Z=I(s(N))I=p(12258)k=e()o=Z[I]V=p(12425)I=p(12642)N=e()F=e()Z=e()z[Z]=o o=B(6911457,{r[3]})z[k]=o o=d(10365583,{r[3]})M=18699545564 z[N]=o D=p(12425)o=u[I]a=z[r[2]]Y=a[X]a=p(12662)l=Y[a]Y=p(12638)i=e()W=l[Y]g=p(12425)l=p(12286)y=W[l]I=o(y)y=e()z[y]=I I=p(12642)P=p(12425)o=u[I]X=z[r[2]]a=X[g]X=p(12662)Y=a[X]a=p(12638)l=Y[a]Y=p(12012)W=l[Y]I=o(W)W=e()z[W]=I I=p(12642)o=u[I]g=z[r[2]]X=g[V]Q=18699541378 g=p(12662)a=X[g]sy=p(12049)X=p(12638)Y=a[X]a=p(12654)H=e()l=Y[a]I=o(l)l=e()z[l]=I I=p(12642)o=u[I]V=z[r[2]]g=V[D]V=p(12662)X=g[V]g=p(12638)oy=p(12409)a=X[g]X=p(12437)Y=a[X]I=o(Y)Y=e()m=18699542775 z[Y]=I I=p(12642)t=p(12425)o=u[I]D=z[r[2]]V=D[t]D=p(12662)g=V[D]V=p(12638)X=g[V]g=p(12055)a=X[g]I=o(a)a=e()z[a]=I I=p(12642)o=u[I]t=z[r[2]]h=e()D=t[P]t=p(12662)V=D[t]D=p(12638)g=V[D]A=p(12409)V=p(12324)n=p(12424)X=g[V]D=e()V=e()t=e()I=o(X)o=0 X=e()z[X]=I g=e()z[g]=o o=true z[V]=o o=nil z[D]=o o=false f=18637217215 I=18699539486 z[t]=o o=nil P=e()v=18637209873 z[P]=o o={I;Q;m;M}Q=e()I=p(12012)z[Q]=o R=18686496907 m=18637207623 M=p(12644)o={[I]=m,[M]=R,[n]=v,[q]=f}R=e()E=e()m=e()z[m]=o n=e()o=18686500373 uy=p(12409)b=e()M=e()z[M]=o o=18686502223 z[R]=o v=e()q=e()o=18637214138 z[n]=o o=18637218777 f=e()z[v]=o o=nil z[q]=o o=nil z[f]=o o=nil z[F]=o o=nil z[H]=o o=false z[i]=o I=u[py]ry=p(12318)py=p(12810)o=I[py]py=p(12722)I=o(py)py=e()o=false T=e()z[py]=I z[b]=o I=u[A]A=p(12810)o=I[A]A=p(12722)I=o(A)o=false A=e()z[A]=I z[h]=o I=u[uy]uy=p(12810)o=I[uy]uy=p(12722)I=o(uy)o={}uy=e()z[uy]=I z[T]=o o=nil z[E]=o I=u[oy]oy=p(12810)o=I[oy]oy=p(12207)I=o(oy)oy=e()z[oy]=I o=z[oy]I=p(12270)o[I]=sy xy=z[r[3]]sy=xy[ry]ry=p(12459)xy=p(12281)xy=sy[xy]xy=xy(sy,ry)I=xy o=xy and 6476768 or 5646628 else y=nil W=nil o=13976442 end else W=p(12801)y=Z[W]k=I N=k-y y=p(12762)I=N[y]N=450 o=I>N o=o and 12650093 or 5180926 end else if o<9908234 then if o<9905610 then Z=z[r[1]]C=not Z o=C and 13558364 or 16641492 I=C else I={}o=u[p(12561)]end else o=z[r[4]]I=o()o=2286953 end end else if o<9930759 then if o<9927027 then if o<9921832 then o=I and 16513794 or 15588665 else I={}o=u[p(12535)]end else Z,y=k(C,Z)o=Z and 7134538 or 8194826 end else if o<9936676 then if o<9933749 then I=z[r[1]]C=x[1]Z=p(12810)W=p(12425)o=I[Z]Z=p(12047)I=o(Z)o=p(12737)o=I[o]o=o(I)y=z[r[2]]N=y[W]y=p(12662)k=N[y]N=p(12051)Z=k[N]k=p(12091)I=Z[k]Z=p(12415)k=p(12799)o=I[Z]Z=o I=p(12281)I=Z[I]I=I(Z,k)o=not I o=o and 11808853 or 14175829 else Z=z[r[1]]C=not Z o=C and 13463477 or 11347836 I=C end else D=g t=o o=g and 538758 or 13209860 end end end end end else if o<10141301 then if o<10045505 then if o<10015056 then if o<9966115 then if o<9958262 then if o<9943702 then C=z[r[4]]o=C and 11002651 or 6651407 else I={k}o=u[p(12040)]end else if o<9963501 then Z=e()I=p(12822)o=p(12281)o=C[o]o=o(C,I)z[Z]=o I=z[Z]o=not I o=o and 2809975 or 5706341 else o=y and 6653350 or 11457700 N=Z end end else if o<10005430 then if o<9983849 then I=p(12822)o=p(12281)o=C[o]o=o(C,I)Z=o o=not Z o=o and 4397257 or 6229837 else I={}o=u[p(12635)]end else I={}o=u[p(12275)]end end else if o<10023045 then if o<10020520 then if o<10019940 then l=c(l)o=11330117 W=nil else Z=o N=z[r[2]]k=not N C=k o=k and 6904918 or 7284632 end else o=I and 2677233 or 4686636 end else if o<10033947 then if o<10025961 then o=7449725 k=z[r[1]]N=p(12007)Z=k[N]C=not Z I=C else y=p(12670)o=z[r[4]]N=p(12305)W=z[r[5]]k={[N]=Z;[y]=W}C=nil I=o(k)k=p(12719)I=u[k]k=p(12783)o=I[k]I=o()Z=nil o=14026734 end else n=p(12639)M=p(12695)o=u[M]R=u[n]M=o(R)o=p(12398)u[o]=M o=14415075 end end end else if o<10077702 then if o<10061218 then if o<10048022 then if o<10045954 then Z=z[r[1]]C=not Z I=C o=C and 1588701 or 13636067 else C=k o=N o=901666 end else I=z[r[1]]k=z[C]o=I[k]o=o and 15096276 or 4089702 end else if o<10074258 then if o<10072941 then xy=o Gy=z[r[3]]wy=p(12252)ry=Gy[wy]o=ry and 14841628 or 9848862 sy=ry else I=z[r[1]]C=p(12252)o=I[C]C=o I=C o=C and 15072882 or 9053538 end else f=i A=p(12290)b=p(12041)b=py[b]b=b(py,A)o=b and 4808057 or 16060070 end end else if o<10102304 then if o<10098992 then if o<10092453 then o=8793759 else N=p(12409)k=I I=u[N]N=p(12810)o=I[N]N=p(12207)I=o(N)o=p(12270)N=I I=p(12241)N[o]=I o=p(12299)o=k[o]o=o(k,N)k=nil y=o o=p(12045)I=false y[o]=I o=p(12346)o=y[o]o=o(y)W=y I=p(12547)o=z[r[1]]o[I]=W W=J(15232284,{r[1];r[3]})I=p(12178)o=y[I]N=nil I=p(12573)I=o[I]y=nil I=I(o,W)o=8908141 end else I=p(12801)o=Z[I]k=o I=p(12310)W=p(12002)I=C[I]I=I(C)a=p(12801)g=p(12801)N=p(12801)o=I[N]N=o o=N-k I=u[W]y=o W=p(12810)o=I[W]Y=z[r[1]]l=Y[a]Y=p(12336)W=l[Y]X=z[r[1]]a=X[g]g=p(12801)X=p(12778)Y=a[X]a=99999 l=Y+a X=z[r[1]]a=X[g]X=p(12012)Y=a[X]I=o(W,l,Y)Y=p(12369)l=u[Y]W=I Y=p(12810)I=l[Y]Y=W+y o=p(12515)o=C[o]l={I(Y)}I=1 o=o(C,s(l))l=3 Y=l l=1 a=l o=10648057 l=0 X=a<l l=I-a end else if o<10135169 then if o<10118803 then Z=I o=Z and 3463704 or 6897612 else N=p(12802)k=z[r[1]]Z=k[N]o=11156953 C=not Z I=C end else o=3610442 end end end end else if o<10263067 then if o<10216929 then if o<10177741 then if o<10173341 then if o<10146693 then D=p(12328)V=u[D]D=p(12370)g=V[D]a=g o=8172360 else Z=p(12252)o=z[r[1]]k=z[r[2]]y=z[r[3]]N=p(12670)C={[Z]=k,[N]=y}I=o(C)o=16463870 end else o=u[p(12516)]I={}end else if o<10215354 then if o<10201677 then o=u[p(12443)]I={}else I={}o=u[p(12183)]end else y=p(12153)N=C[y]Y=p(12585)l=u[Y]o=6327781 Y=p(12153)W=l[Y]l=p(12468)y=W[l]k=N==y I=k end end else if o<10232285 then if o<10221461 then if o<10219244 then o=k z[r[3]]=I o=5256345 else o=15520058 k=z[r[6]]Z=k==C I=Z end else a=p(12350)o=12674431 Y=z[r[5]]l=Y[a]y=l end else if o<10256333 then if o<10248455 then l=p(12368)o=u[l]X=z[r[1]]g={o(X)}l=g[1]o=6151608 Y=g[2]a=g[3]else o=13176767 y=p(12153)Y=p(12585)N=C[y]l=u[Y]Y=p(12153)W=l[Y]l=p(12671)y=W[l]k=N==y I=k end else o=I and 257226 or 4360275 end end end else if o<10322291 then if o<10300202 then if o<10290940 then if o<10270031 then o=7773285 k=z[r[1]]N=p(12350)Z=k[N]C=not Z I=C else o=3805161 C=nil end else l=I o=not l o=o and 6354312 or 13654174 end else if o<10308816 then if o<10308416 then I=z[r[3]]o=p(12299)o=C[o]o=o(C,I)z[r[2]]=o o=u[p(12696)]I=z[r[2]]k=true Z=p(12346)Z=I[Z]Z=Z(I)Z=p(12045)I=z[r[2]]C=nil I[Z]=k I={}else o=u[p(12230)]I={y}end else y=p(12833)C=x[1]l=p(12695)o=z[r[1]]W=u[l]Z=x[2]l=W(C)N=y..l y={o(N)}k=y[2]I=y[1]N=I I=N o=N and 6166727 or 4435317 end end else if o<10340599 then if o<10328199 then if o<10327557 then X=p(12280)o=p(12855)o=a[o]o=o(a,X)g=p(12822)X=o o=p(12281)o=a[o]V=X o=o(a,g)g=o o=X and 9751232 or 15837471 else o=W and 10308648 or 11623445 end else M=nil o=8070368 V=nil Q=nil m=nil end else if o<10359105 then if o<10354317 then o=u[p(12476)]I={}else I=p(12368)C=x[1]Z=x[2]o=u[I]W=p(12508)W=C[W]y={W(C)}W={o(s(y))}I=W[1]k=W[2]N=W[3]o=5544655 y=I end else o=nil I={o;k}o=u[p(12297)]end end end end end end end else if o<11331776 then if o<10832122 then if o<10658948 then if o<10569343 then if o<10439681 then if o<10387997 then if o<10371490 then if o<10367591 then C=x[1]o={}Z=x[2]I=p(12328)k=o o=u[I]N=p(12617)I=p(12281)I=o[I]I=I(o,N)N=I o=not N o=o and 14660365 or 8585092 else M=p(12530)M=m[M]M=M(m)o=3100483 end else if o<10386191 then o=I and 8583793 or 15562782 else Y=p(12343)N=Z l=p(12041)l=y[l]l=l(y,Y)W=l o=l and 14377013 or 10328109 end end else if o<10420161 then if o<10393794 then R,q=n(M,R)o=R and 10699453 or 15285547 else Y=p(12444)l=z[r[3]]W=l[Y]l=p(12801)o=4718382 y=W[l]k=y end else v=nil py=p(12801)f=p(12410)uy=p(12489)F=p(12481)o=z[r[4]]f=o[f]f=f(o,q,F)A=p(12002)F=20 o=p(12095)f=p(12836)oy=50 o=q[o]H=p(12369)o=o(q,f,F)o=p(12636)f=p(11996)F=p(12328)q[o]=f o=p(12350)f=u[F]q[o]=f F=u[H]H=p(12810)f=F[H]i=Z[py]b=u[A]A=p(12810)E=p(12489)py=b[A]T=50 h=u[uy]uy=p(12413)A=h[uy]uy=-50 h=A(uy,T)A=10 T=u[E]E=p(12413)uy=T[E]E=-50 T={uy(E,oy)}b=py(h,A,s(T))H=i+b o=p(12515)F={f(H)}o=q[o]o=o(q,s(F))o=z[V]f=o(q)q=nil o=10392801 end end else if o<10491226 then if o<10479902 then if o<10479594 then I={}C=nil o=u[p(12564)]Z=nil else I=p(12070)o=z[r[1]]I=o[I]I=I(o)o=I and 16086083 or 5931922 Z=x[2]C=x[1]end else F=p(12368)f=u[F]o=8590604 py={f(q)}i=py[3]F=py[1]H=py[2]end else if o<10565864 then if o<10506634 then y=p(12833)N=p(12409)I=u[N]N=p(12810)o=I[N]N=p(12207)I=o(N)N=I I=y..C o=p(12270)N[o]=I o=p(12299)o=k[o]o=o(k,N)y=p(12346)z[r[2]]=o I=z[r[2]]y=I[y]o=Z and 8279685 or 15741668 y=y(I)else C=p(12830)I=z[r[1]]o=I[C]o=o and 8042379 or 2800161 end else o=u[p(12664)]I={}end end end else if o<10633798 then if o<10596205 then if o<10590903 then if o<10589935 then Z=p(12810)I=z[r[1]]C=x[1]l=p(12425)o=I[Z]Z=p(12263)I=o(Z)o=p(12737)o=I[o]o=o(I)I=p(12642)C=nil o=u[I]W=z[r[2]]y=W[l]Y=p(12425)W=p(12662)N=y[W]y=p(12285)k=N[y]N=p(12457)Z=k[N]I=o(Z)Z=e()z[Z]=I I=p(12642)o=u[I]l=z[r[2]]W=l[Y]l=p(12662)y=W[l]W=p(12285)l=e()N=y[W]y=p(12803)g=1166 W=e()k=N[y]I=o(k)X=p(12441)N=e()o=false k=e()z[k]=I z[N]=o y=e()o=false z[y]=o o=false z[W]=o o=L(1793715,{r[3]})Y=e()a=e()z[l]=o o=S(15818332,{})z[Y]=o o=J(9935381,{y;N;W;l,Y,k,r[3];Z})z[a]=o I=z[r[4]]o=I[X]I=p(12573)X=S(2297598,{r[4];y,a})k=c(k)I=o[I]I=I(o,X)X=p(12408)I=z[r[4]]o=I[X]X=d(10479635,{r[4];y,a})I=p(12573)I=o[I]I=I(o,X)X=p(12409)I=u[X]X=p(12810)o=I[X]X=p(12343)I=o(X)X=I I=p(12112)o=p(12628)Y=c(Y)X[o]=I I=false o=p(12405)X[o]=I o=p(12095)I=p(12836)o=X[o]o=o(X,I,g)I=p(12343)l=c(l)o=p(12636)X[o]=I I=p(12238)o=X[I]g=L(12112391,{y,a})I=p(12573)a=c(a)I=o[I]I=I(o,g)I=p(12088)g=J(15429099,{y,W})o=X[I]I=p(12573)Z=c(Z)V=p(12318)I=o[I]I=I(o,g)g=B(5097914,{y;N,W})N=c(N)I=p(12531)W=c(W)o=X[I]I=p(12573)I=o[I]I=I(o,g)g=z[r[3]]I=g[V]o=p(12350)X[o]=I y=c(y)I={}X=nil o=u[p(12062)]else Z,y=k(C,Z)o=Z and 4266893 or 3477572 end else Z=p(12742)I=z[r[1]]o=I[Z]I=p(12786)I=o[I]Z=nil I=I(o)I=p(12742)o=z[r[1]]o[I]=Z o=7856780 end else if o<10614502 then if o<10611380 then I=p(12281)I=C[I]Z=p(12280)I=I(C,Z)Z=I o=Z and 10904479 or 5256345 else o=p(12281)o=a[o]X=p(12822)g=p(12280)o=o(a,X)X=o o=p(12855)V=X o=a[o]o=o(a,g)g=o o=X and 9937606 or 10756048 end else o=15117914 end end else if o<10650620 then if o<10647725 then if o<10643006 then C=z[r[1]]I=C o=C and 11756040 or 9751263 else o=16204961 Y=nil a=nil end else g=not X l=l+a I=l<=Y I=g and I g=l>=Y g=X and g I=g or I g=12292190 o=I and g I=4519145 o=o or I end else if o<10653815 then if o<10653569 then y=p(12029)I=p(12368)o=u[I]k=z[r[1]]y=k[y]N={y(k)}k={o(s(N))}C=k[2]I=k[1]o=9827727 Z=k[3]k=I else k=z[r[2]]I=k o=k and 968693 or 3600776 end else o=u[p(12145)]I={}end end end end else if o<10719355 then if o<10694322 then if o<10683545 then if o<10672229 then if o<10661624 then o=z[r[4]]I=p(12369)Z=z[r[1]]k=p(12369)C=Z[k]o[I]=C o=4150827 else o=z[r[2]]I=p(12786)I=o[I]I=I(o)o=10308051 end else if o<10682400 then y=p(12153)Y=p(12585)N=C[y]l=u[Y]Y=p(12153)W=l[Y]l=p(12468)y=W[l]k=N==y o=k and 6885120 or 3256119 I=k else o=z[r[4]]I=o()o=1655528 end end else if o<10687579 then if o<10687042 then C=p(12719)I=u[C]C=p(12783)o=I[C]I=o()o=z[r[4]]o=o and 2378114 or 3328818 else Y=z[r[5]]l=not Y W=o o=l and 9661412 or 2734252 y=l end else I=p(12524)N=p(12620)W=p(12113)Z=p(12738)g=L(7212686,{r[8];r[2];r[9],r[12]})y=p(12174)C={Z}Z=p(12834)l=B(3114090,{r[1];r[2];r[3];r[4],r[5],r[6],r[7]})a=B(3019704,{r[8];r[2],r[9],r[10];r[11]})k={[N]=y;[W]=l}W=p(12620)N=p(12150)X=p(12113)l=p(12867)Y=p(12113)y={[W]=l;[Y]=a}Y=p(12620)W=p(12447)a=p(12256)l={[Y]=a,[X]=g}o={[I]=C;[Z]=k;[N]=y;[W]=l}I={o}o=u[p(12537)]end end else if o<10705870 then if o<10701504 then if o<10698949 then I={}o=u[p(12605)]else v=R py=p(12508)f=p(12368)py=q[py]o=u[f]i={py(q)}py={o(s(i))}H=py[3]f=py[1]F=py[2]o=13602586 end else o=z[r[3]]I=o()C=I o=not C o=o and 7154515 or 521094 end else if o<10717494 then if o<10713801 then o=u[p(12522)]I={}else W=p(12585)k=p(12779)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12336)k=N[y]o=I==k o=o and 9910766 or 10682225 end else l=nil W=nil o=13682357 y=nil end end end else if o<10806698 then if o<10764788 then if o<10753553 then if o<10726724 then o=N C=k o=1779981 else l=p(12084)Z=e()Y=p(12318)k=e()z[Z]=x[2]C=x[1]z[k]=x[3]N=p(12409)I=u[N]N=p(12810)o=I[N]N=p(12343)I=o(N)N=I I=C o=p(12628)N[o]=I l=C[l]o=p(12405)I=false N[o]=I W=z[r[1]]l=l(C)y=W[l]W=1173 I=y or W y=I W=p(12836)I=p(12095)I=N[I]I=I(N,W,y)W=p(12343)I=p(12636)N[I]=W l=z[r[2]]I=p(12350)W=l[Y]l=p(12088)N[I]=W W=e()I=false Y=O(9605210,{W})z[W]=I I=N[l]l=p(12573)l=I[l]l=l(I,Y)Y=L(6283375,{W})l=p(12531)I=N[l]l=p(12573)l=I[l]l=l(I,Y)l=p(12238)Y=O(12040362,{W,k})I=N[l]l=p(12573)l=I[l]l=l(I,Y)l=z[r[2]]o=u[p(12805)]Y=p(12419)I=l[Y]Y=J(10809066,{Z,k})l=p(12573)l=I[l]l=l(I,Y)I={N}end else o=V and 330748 or 5390353 end else if o<10799027 then if o<10796117 then Z=z[r[2]]o=2368394 C=not Z I=C else A=p(12508)F=p(12723)f=u[F]py=z[M]A=py[A]b={A(py)}py={f(s(b))}i=py[3]H=py[2]F=py[1]o=765037 end else N=o W=z[r[3]]y=not W o=y and 11741602 or 14509572 k=y end end else if o<10816044 then if o<10814604 then if o<10809551 then C=x[1]I=p(12084)I=C[I]I=I(C)Z=z[r[1]]o=I==Z o=o and 12556761 or 11195294 else g=p(12041)V=p(12475)X=z[a]g=X[g]g=g(X,V)o=16069870 I=g end else Z=nil o=u[p(12579)]C=nil I={}end else if o<10831499 then if o<10822575 then a=e()g=65 D=p(12080)M=p(12695)z[a]=I X=3 t=L(14579412,{})o=z[l]I=o(X,g)X=e()o=0 g=o z[X]=I o=0 I=u[D]D={I(t)}V=o I=2 o={s(D)}D=o o=D[I]t=o I=p(12395)o=u[I]P=z[k]m=u[M]M=m(t)m=p(12250)Q=P(M,m)P={Q()}I=o(s(P))P=e()z[P]=I I=1 Q=z[X]m=Q Q=1 M=Q Q=0 R=M<Q Q=I-M o=1906874 else y=p(12742)o=10386098 N=z[r[1]]k=N[y]N=p(12622)Z=k[N]I=Z end else N=z[r[1]]y=p(12350)Z=o k=N[y]o=k and 8449704 or 2196080 C=k end end end end end else if o<11100632 then if o<10950679 then if o<10898432 then if o<10855152 then if o<10836254 then if o<10833448 then o=z[r[3]]I=o()o=12590321 else y=p(12544)I=p(12723)y=C[y]o=u[I]N={y(C)}y={o(s(N))}o=12359853 I=y[1]N=I Z=y[2]k=y[3]end else if o<10844859 then o=u[p(12651)]I={}else o=5210820 W=z[r[4]]y=not W k=y end end else if o<10882993 then if o<10872499 then N=p(12742)k=z[r[1]]Z=k[N]o=Z and 4185644 or 5138140 I=Z else C=e()Z=p(12199)z[C]=x[1]I=z[C]o=I[Z]o=o and 3942701 or 14609582 end else I={}o=u[p(12081)]end end else if o<10924590 then if o<10915428 then if o<10904778 then N=p(12281)N=Z[N]k=o y=p(12755)N=N(Z,y)I=N o=N and 10217832 or 7486764 else Z=z[r[1]]C=not Z I=C o=C and 7773285 or 10263162 end else Z=z[r[2]]k=z[r[3]]C=Z==k I=C o=15504397 end else if o<10942239 then if o<10937597 then I=p(12080)k=B(5676351,{Z})o=u[I]I=o(k)o=14147827 else k=z[r[2]]C=k Z=o o=k and 12001169 or 15482421 end else o=u[p(12553)]I={}end end end else if o<11002812 then if o<10972455 then if o<10965968 then if o<10959659 then o=15318185 b=p(12508)F=p(12723)f=u[F]b=m[b]py={b(m)}b={f(s(py))}F=b[1]H=b[2]i=b[3]else o=z[r[1]]o=o and 9161563 or 10706113 end else Z=false o=z[r[2]]I=o(C,Z)o=z[r[3]]I=o(C)o=3610442 end else if o<10986234 then if o<10984790 then o=z[r[5]]I=o()o=3419034 else N=z[r[2]]Z=o k=not N C=k o=k and 14223571 or 1779981 end else Z=p(12786)o=6651407 C=z[r[4]]Z=C[Z]Z=Z(C)C=nil z[r[4]]=C end end else if o<11054336 then if o<11028053 then if o<11020512 then W=z[y]I=W o=8273476 else C=p(12719)I=u[C]C=p(12392)o=I[C]C=z[r[1]]I=o(C)o=2736396 end else R=l o=1544205 end else if o<11086064 then if o<11068445 then o=p(12530)o=l[o]o=o(l)o=10718255 else o=u[p(12000)]I={}end else o=X o=a and 10820724 or 15963149 I=a end end end end else if o<11210281 then if o<11156522 then if o<11133461 then if o<11126733 then if o<11110175 then Z=z[r[1]]C=not Z o=C and 15663186 or 12895097 I=C else I=p(12689)Z=p(12134)o=u[I]C=z[r[1]]Z=o[Z]I={Z(o,C)}I={s(I)}o=u[p(12099)]end else if o<11127721 then o=1922192 C=c(C)else o=I and 9065599 or 195546 end end else if o<11154348 then if o<11139559 then o=u[p(12446)]I={}else o=z[r[1]]y=o W=z[r[2]]k=o o=W and 1632619 or 4024025 N=W C=p(12311)end else Z=p(12822)I=p(12281)I=C[I]I=I(C,Z)Z=e()z[Z]=I k=z[Z]I=not k o=I and 15193707 or 12379055 end end else if o<11182032 then if o<11167242 then if o<11162551 then o=I and 12039168 or 5906573 else C=x[1]o=not C o=o and 14170172 or 16758769 end else f=i f=nil A=true o=8590604 b=p(12450)py[b]=A py=nil end else if o<11204534 then if o<11195605 then o=u[p(12236)]C=nil I={}else I=p(12368)o=u[I]N=z[C]W=p(12029)W=N[W]y={W(N)}N={o(s(y))}I=N[1]k=N[3]Z=N[2]N=I o=13976442 end else k=p(12503)C=z[r[1]]Z=p(12281)Z=C[Z]Z=Z(C,k)I=Z o=Z and 2178064 or 10021455 end end end else if o<11261394 then if o<11224827 then if o<11216470 then if o<11211514 then I={}o=u[p(12736)]else Z=false o=z[r[3]]I=o(C,Z)Z=p(12350)k=p(12328)I=C[Z]Z=u[k]o=I==Z o=o and 15739731 or 2703492 end else o=u[p(12187)]I={}end else if o<11245621 then if o<11237533 then o=z[r[5]]I=o()o=4083076 else o=z[r[1]]I=p(12070)C=x[1]I=o[I]I=I(o)Z=x[2]o=I and 13157705 or 6433763 end else y=k W=o o=k and 13440961 or 11977351 end end else if o<11307730 then if o<11306604 then if o<11287476 then k=nil N=c(N)y=nil o=9263650 Z=c(Z)else a=p(12689)Y=u[a]X=p(12403)o=15069327 a=p(12394)a=Y[a]a=a(Y,X)W=a end else k=p(12350)o=4978944 Z=z[r[1]]C=Z[k]I=C end else if o<11328219 then if o<11323004 then Y=p(12719)l=u[Y]Y=p(12783)y=nil k=c(k)W=l[Y]I={}Z=c(Z)Y=.5 N=c(N)l=W(Y)W=false o=u[p(12072)]z[r[2]]=W C=nil else Z=z[r[1]]C=not Z o=C and 6660722 or 1696326 I=C end else y,l=k(N,y)o=y and 12269229 or 8402758 end end end end end end else if o<11834480 then if o<11608387 then if o<11453499 then if o<11367463 then if o<11340806 then if o<11334151 then if o<11332540 then R=a D={[t]=P;[Q]=m}t=p(12196)o=M Q=p(12607)M=p(12169)m=p(12281)m=W[m]n=o m=m(W,M)M=p(12574)o=a and 1544205 or 11034067 else D=o g=p(12281)g=W[g]V=p(12681)g=g(W,V)V=g o=g and 6654397 or 11787007 end else if o<11337762 then I={}o=u[p(12557)]else a=false N=p(12407)l=1.5 o=z[r[1]]k=z[r[2]]X=p(12842)Y=p(12792)Z=p(12147)D=p(12366)y=z[r[3]]W=p(12137)V=z[r[4]]g=V[D]C={[Z]=k;[N]=y;[W]=l;[Y]=a,[X]=g}I=o(C)I={}o=u[p(12211)]end end else if o<11351938 then if o<11347857 then o=13463477 C=z[r[2]]I=C else I=true o=nil Z=o z[r[1]]=o z[r[2]]=I k=z[r[3]]C=k o=k and 2086556 or 12129108 end else X=o V=p(12496)g=u[V]o=g and 15899941 or 5415928 a=g end end else if o<11401507 then if o<11382762 then if o<11371510 then Z=p(12135)I=z[r[1]]o=I[Z]I=p(12609)I=o[I]Z=nil I=I(o)o=z[r[1]]I=p(12135)o[I]=Z o=5603215 else N=p(12409)k=u[N]N=p(12810)Z=k[N]N=p(12755)o=2016341 k=Z(N,C)I=k end else f=p(12232)v=o q=u[f]o=q and 16643111 or 9541837 n=q end else if o<11438717 then if o<11410308 then v=z[r[4]]q=p(12252)R=o n=v[q]M=n o=n and 6366955 or 14595478 else o=xy o=6476768 I=sy end else o=u[p(12380)]I={}end end end else if o<11486203 then if o<11474328 then if o<11459476 then if o<11455968 then l=z[r[15]]o=15402550 Y=l()else o=5907269 N=nil y=nil end else Z=p(12252)o=true z[r[1]]=o C=z[r[2]]I=C[Z]C=I o=C and 8658715 or 1615894 end else if o<11482867 then if o<11481505 then D=p(12628)V=W[D]D=p(12084)D=V[D]X=a D=D(V)o=D==g o=o and 4451840 or 14771064 else k=nil o=8446016 end else o=p(12281)o=C[o]I=p(12822)o=o(C,I)Z=o o=not Z o=o and 33027 or 4603789 end end else if o<11560766 then if o<11533923 then if o<11496248 then o=z[r[3]]I=o()o=2286953 else X=1164 a=p(12409)I=u[a]a=p(12810)o=I[a]a=p(12343)I=o(a)o=p(12628)a=I I=p(12649)a[o]=I I=false o=p(12405)a[o]=I o=p(12095)N=c(N)y=c(y)o=a[o]I=p(12836)o=o(a,I,X)X=O(4599621,{k;l})o=p(12636)C=nil g=p(12318)I=p(12343)a[o]=I I=p(12238)o=a[I]I=p(12573)I=o[I]I=I(o,X)I=p(12088)X=S(6889221,{k})o=a[I]l=c(l)W=c(W)I=p(12573)I=o[I]I=I(o,X)I=p(12531)X=J(1404969,{k;Z})o=a[I]I=p(12573)I=o[I]k=c(k)I=I(o,X)X=z[r[3]]Z=c(Z)o=p(12350)Y=nil I=X[g]a[o]=I o=u[p(12269)]I={}a=nil end else V=z[r[11]]g=not V a=g X=o o=g and 5813843 or 5157502 end else if o<11591529 then if o<11580500 then o=nil I={o}o=u[p(12340)]else o=z[r[1]]I=p(12007)Z=true o[I]=Z Z=p(12366)I=z[r[1]]o=I[Z]Z=true I=p(12663)o[I]=Z I=z[r[2]]Z=p(12252)o=I[Z]I=p(12855)Z=p(12280)I=o[I]I=I(o,Z)Z=I o=Z and 1394600 or 8908141 end else k=e()Z=x[2]C=e()z[C]=x[1]z[k]=x[3]y=O(16547607,{C;k,r[3]})o=z[r[1]]C=c(C)k=c(k)I=o()N=83204770964519 o=z[r[2]]Z=nil I=o(N,y)o=u[p(12129)]I={}end end end end else if o<11718157 then if o<11691277 then if o<11635821 then if o<11623081 then if o<11620916 then N=z[r[9]]a=p(12801)Y=p(12424)l=z[r[10]]W=l[Y]l=false y=N(W,l)W=p(12409)y=u[W]W=p(12810)N=y[W]l=p(12327)W=p(12722)g=1 y=N(W)N=e()W=p(12628)z[N]=y y=z[N]X=.75 y[W]=l t=1.5 Y=O(15848207,{N})y=z[N]W=p(12663)l=true y[W]=l W=p(12350)l=Z y=z[N]y[W]=l l=p(12719)W=u[l]l=p(12027)y=W[l]l=10 W=y(l,Y)P=p(12252)W=p(12346)l=p(12259)y=z[r[11]]W=y[W]Y=Z[a]a=nil W=W(y,l,Y,a,X,g)a=p(12801)l=p(12456)y=z[r[11]]Y=Z[a]g=1.2 a=nil X=.7 W=p(12346)W=y[W]W=W(y,l,Y,a,X,g)a=p(12801)y=z[r[11]]Y=Z[a]a=nil g=1 X=.65 l=p(12388)R=3 Q=p(12147)W=p(12346)W=y[W]W=W(y,l,Y,a,X,g)l=p(12719)W=u[l]l=p(12027)o=3906897 D=p(12397)y=W[l]a=p(12670)l=2.5 Y=d(12546043,{k;r[11]})W=y(l,Y)X=nil M=p(12500)Y=p(12305)g=p(12034)y=z[r[12]]N=c(N)V=z[k]m=z[r[4]]l={[Y]=Z;[a]=X,[g]=V;[D]=t,[P]=C,[Q]=m,[M]=R}Y=L(6894577,{r[1],r[13];r[14],r[2];r[15]})W=y(l)l=p(12719)W=u[l]l=p(12027)y=W[l]l=.5 W=y(l,Y)else y=p(12683)N=z[r[2]]k=N[y]N=p(12365)N=k[N]o=220018 N=N(k)Z=N end else if o<11627640 then y=nil N=nil o=9827727 else v=p(12203)q=true n=p(12281)n=m[n]n=n(m,v,q)M=n o=12795478 end end else if o<11679364 then if o<11661083 then I={}C=c(C)o=u[p(12206)]else C=nil q=z[r[4]]Z=c(Z)Q=c(Q)N=c(N)f=p(12318)R=nil l=c(l)Y=c(Y)I={}n=nil g=c(g)X=c(X)v=q[f]W=c(W)y=c(y)q=p(12768)o=v[q]M=nil k=c(k)D=c(D)a=c(a)V=c(V)v=p(12573)v=o[v]P=c(P)v=v(o,m)o=u[p(12473)]m=nil t=c(t)end else o=4306036 l=nil W=nil end end else if o<11697046 then if o<11695738 then if o<11695382 then V=1 g=a[V]X=not g o=16400155 I=X else y=4 k=z[r[5]]N=1 I=k+N z[r[5]]=I N=z[r[5]]k=N>y o=k and 480428 or 14654313 end else Z=I o=not Z o=o and 468340 or 10060316 end else if o<11716253 then if o<11711340 then o=8373558 N=p(12723)I=u[N]l={I(k)}N=l[1]W=l[3]y=l[2]else Y=true o=8681521 l=p(12858)W[l]=Y end else I=z[r[1]]Z=p(12252)C=x[1]o=I[Z]Z=o o=not Z o=o and 12040697 or 8603357 end end end else if o<11784706 then if o<11748493 then if o<11741035 then if o<11723074 then y=S(9469173,{r[7]})o=u[p(12003)]N=p(12319)Z=k[N]N=p(12573)N=Z[N]I={}N=N(Z,y)k=nil z[r[6]]=N C=nil else N=Z W=p(12829)o=p(12041)o=y[o]o=o(y,W)o=o and 14443222 or 8152462 end else o=14509572 W=z[r[4]]y=not W k=y end else if o<11776033 then if o<11766168 then Z=o N=z[r[2]]k=not N C=k o=k and 9710591 or 4658083 else I={}o=true z[r[1]]=o o=u[p(12136)]end else I={}Z=nil o=u[p(12074)]C=nil end end else if o<11799123 then if o<11787428 then if o<11786275 then N=p(12489)o=nil k=o Y=p(12029)I=u[N]N=p(12606)o=I[N]N=o Y=Z[Y]I=p(12723)o=u[I]l={Y(Z)}Y={o(s(l))}W=Y[3]o=14299492 I=Y[1]l=I y=Y[2]else o=D o=V and 2073838 or 15820080 end else W=o l=p(12847)W=p(12841)y=Z and l N=y or W y=p(12281)y=k[y]y=y(k,N)W=not y o=W and 2289191 or 7112320 end else if o<11824993 then if o<11812350 then k=p(12409)I=u[k]k=p(12810)o=I[k]k=p(12258)I=o(k)k=I I=p(12799)o=p(12628)k[o]=I o=p(12482)I=p(12404)k[o]=I I=Z o=p(12350)k[o]=I k=nil o=14175829 else W=l D=p(12483)Q=10 V=u[D]D=p(12828)g=V[D]D=z[r[5]]P=Q*W t={D(C,P)}D=p(12483)V=g(y,s(t))V=u[D]D=p(12828)Q=-10 g=V[D]D=z[r[5]]P=Q*W W=nil t={D(C,P)}V=g(y,s(t))o=2463715 end else W=p(12407)Y=p(12721)I=z[r[11]]o=14174613 l=z[Z]a=2 y={[W]=l,[Y]=a}N=I(y)end end end end end else if o<12113654 then if o<12008347 then if o<11944787 then if o<11911493 then if o<11850674 then if o<11845047 then Z=p(12719)C=u[Z]Z=p(12392)I=C[Z]Z=z[r[2]]C=I(Z)I=nil o=8497679 z[r[2]]=I else o=X and 5596287 or 14633786 end else if o<11866215 then o=false I={o}o=u[p(12355)]else y=p(12369)N=u[y]o=p(12369)y=p(12810)I=N[y]N=I(Z)k[o]=N o=11482363 end end else if o<11925073 then if o<11915463 then I=z[r[3]]C=p(12252)o=I[C]C=o o=not C o=o and 12328538 or 9973425 else o=z[r[2]]I=o()o=8052525 end else k=p(12779)I=C[k]W=p(12585)y=u[W]W=p(12779)N=y[W]y=p(12012)k=N[y]o=I==k o=o and 10832229 or 12590321 end end else if o<11973043 then if o<11967125 then if o<11962180 then k=p(12252)Z=z[r[1]]C=Z[k]o=C and 7314955 or 6942703 I=C else C=p(12252)I=z[r[3]]o=I[C]C=o o=not C o=o and 2333370 or 11485031 end else C=k o=N o=3188629 end else if o<11993338 then if o<11978831 then I=y o=W o=15351032 else I=z[r[2]]k=p(11995)o=I[k]k=o o=k and 14505769 or 7603581 end else y=p(12350)N=z[r[2]]o=15482421 k=N[y]C=k end end end else if o<12059188 then if o<12039446 then if o<12030503 then if o<12009504 then o=u[p(12452)]I={}else I={}o=u[p(12314)]end else k=p(12252)Z=z[r[2]]C=Z[k]I=C o=C and 5296982 or 16735398 end else if o<12057317 then if o<12040646 then o=z[r[1]]o=o and 7827363 or 14772180 else o=u[p(12231)]I={}end else I=z[r[3]]C=p(12252)o=I[C]C=o o=not C o=o and 1859689 or 7888974 end end else if o<12103202 then if o<12080873 then if o<12063420 then o=p(12530)o=Z[o]o=o(Z)o=p(12530)k=c(k)o=C[o]I={}Z=nil o=o(C)C=nil o=u[p(12332)]else C=p(12830)I=z[r[1]]o=I[C]o=o and 2795983 or 7385504 end else q,H=f(v,q)o=q and 2023252 or 11670097 end else if o<12112810 then if o<12112408 then o=z[r[1]]o=o and 982229 or 9907230 else W,a=l(y,W)o=W and 5259740 or 9953635 end else X=p(12731)y=z[r[8]]Y=z[r[9]]a=z[r[5]]l=Y[a]a=p(12407)Y=false W=y(l,Y)z[r[7]]=W y=z[r[10]]g=z[r[5]]Y={[a]=Z,[X]=g}l=y(Y)y=z[r[7]]o=y and 5638983 or 1025536 end end end end else if o<12210902 then if o<12176896 then if o<12151473 then if o<12128409 then if o<12119034 then o=false z[r[1]]=o I={}o=u[p(12438)]else I=z[r[1]]C=x[1]Z=x[2]o=not I o=o and 5446591 or 8558598 end else o=Z o=C and 2899468 or 6057518 end else if o<12174529 then if o<12167402 then o=z[r[2]]o=o and 9846593 or 9799630 else C=p(12252)I=z[r[3]]o=I[C]C=o o=not C o=o and 14911 or 14376204 end else o=I and 9148623 or 5823820 end end else if o<12188620 then if o<12188109 then if o<12183783 then W=nil o=3616587 y=nil else o=u[p(12008)]I={}end else o=z[r[1]]C=z[r[2]]I=o(C)I={}o=u[p(12734)]end else if o<12203120 then if o<12196969 then V=p(12593)g=p(12281)g=C[g]g=g(C,V)a=g o=4231535 else o=false z[r[2]]=o I=z[r[3]]Z=false C=p(12663)I[C]=Z Z=p(12252)C=z[r[4]]I=C[Z]C=I I=not C o=I and 194765 or 16174062 end else t=p(12801)Y=true o=16052739 N=z[r[9]]l=z[r[13]]g=p(12460)W=N(l,Y)z[r[8]]=W Y=p(12483)l=u[Y]Y=p(12828)Q=p(12346)N=l[Y]Y=z[r[11]]P=1 a=z[r[12]]D=z[Z]Q=a[Q]V=D[t]t=.8 D=nil X={Q(a,g,V,D,t,P)}l=N(Y,s(X))end end end else if o<12262420 then if o<12237246 then if o<12220113 then if o<12213148 then o=z[r[1]]o=o and 15555631 or 9467858 else M=0 C=p(12719)Y=p(12411)I=u[C]C=p(12783)N=p(12489)o=I[C]k=u[N]m=p(12104)N=p(12413)P=0 Z=k[N]k=Z()Z=.2 C=k*Z I=o(C)t=0 Z=p(12369)C=p(12810)I=z[r[1]]o=I[C]y=p(12369)W=p(12416)N=u[y]X=p(12713)a=650 D=p(12104)y=p(12810)l=2.5 k=N[y]y=z[r[2]]N=k(y)k=p(12586)n=80 y=3 V=u[D]D=p(12720)g=V[D]D=0 V=g(D,t,P)g=p(12611)P=p(12030)t=u[P]P=p(12810)D=t[P]Q=u[m]m=p(12720)P=Q[m]m=0 R=0 Q=P(m,M,R)M=p(12104)m=u[M]M=p(12720)R=80 P=m[M]M=80 m={P(M,R,n)}t=D(Q,s(m))C={[Z]=N;[k]=y,[W]=l;[Y]=a,[X]=V,[g]=t}I=o(C)o=p(12464)o=I[o]o=o(I)o=u[p(12807)]I={}end else o=u[p(12728)]I={}end else if o<12245843 then if o<12240499 then C=z[r[2]]I=C o=15235745 else C=x[1]I=p(12723)o=u[I]N=z[r[1]]W=p(12029)W=N[W]y={W(N)}N={o(s(y))}k=N[3]Z=N[2]o=3616587 I=N[1]N=I end else I=p(12855)Z=p(12343)o=z[r[2]]I=o[I]I=I(o,Z)Z=I o=Z and 5802793 or 7183744 I=Z end end else if o<12271005 then if o<12269144 then if o<12267121 then y=p(12409)N=u[y]y=p(12810)k=N[y]o=8849495 y=p(12755)N=k(y,Z)I=N else o=nil I={o}o=u[p(12273)]end else I=e()a=p(12021)W=y z[I]=l Y=u[a]a=p(12435)l=I I=Y[a]Y=I(Z,W)o=Y and 3008455 or 10019807 end else if o<12288999 then if o<12283521 then k=p(12830)I=p(12740)C=true o=z[r[1]]o[I]=C Z=z[r[1]]C=Z[k]I=C o=C and 8931412 or 14843267 else C=z[r[4]]o=C and 3030469 or 7258045 end else o=z[r[1]]I=p(12369)g=l t=p(12369)D=u[t]t=p(12810)P=p(12801)V=D[t]t=Z[P]D=V(t)o[I]=D V=p(12719)I=u[V]V=p(12783)o=I[V]V=.05 g=nil I=o(V)o=10648057 end end end end end end end end else if o<14600372 then if o<13373210 then if o<12833643 then if o<12558765 then if o<12409535 then if o<12370284 then if o<12334303 then if o<12327806 then if o<12321320 then o=true z[r[1]]=o o=u[p(12652)]I={}else o=V o=2146777 X=g end else if o<12332576 then o=11216647 C=nil Z=nil else k=p(12644)o=z[r[3]]N=p(12801)Z=z[r[4]]C=Z[k]Z=true y=.5 I=o(C,Z)o=z[r[5]]k=z[r[6]]Z=k[N]C=p(12704)N=.7 I=p(12346)I=o[I]k=nil I=I(o,C,Z,k,N,y)o=6385332 end end else if o<12360030 then if o<12345840 then Z=p(12547)I=z[r[1]]o=I[Z]I=p(12786)I=o[I]I=I(o)o=7296560 else k,W=N(Z,k)o=k and 1477084 or 16045924 end else D=g o=4425927 end end else if o<12389967 then if o<12383941 then if o<12379893 then y=false Y=1 I=z[r[5]]k=I()l=p(12801)I=z[r[6]]N=z[r[7]]k=I(N,y)I=z[r[8]]W=z[Z]y=W[l]W=nil k=p(12346)k=I[k]N=p(12659)l=.8 k=k(I,N,y,W,l,Y)N=p(12719)k=u[N]N=p(12027)I=k[N]y=O(7868574,{r[8],Z})N=.2 k=I(N,y)N=p(12719)y=O(8742599,{r[8];Z})k=u[N]N=p(12027)I=k[N]N=.5 k=I(N,y)I=z[r[9]]N=z[Z]y=120 k=I(N,y)y=0 N=#k I=N>y o=I and 1486776 or 9847392 else o=z[r[1]]I=p(12070)I=o[I]I=I(o)Z=x[2]o=I and 10178903 or 1855060 C=x[1]end else o=z[r[1]]Z=k a=255 Y=0 l=o(Y,a)C[Z]=l Z=nil o=9848705 end else if o<12400765 then if o<12397184 then I=z[r[1]]C=p(12252)o=I[C]C=o o=C and 8676951 or 5744718 I=C else o=7734167 X=nil g=nil end else Y=p(12346)D=1 g=p(12801)o=z[r[2]]Y=o[Y]a=p(12132)X=l[g]g=nil V=1.1 Y=Y(o,a,X,g,V,D)o=6894372 end end end else if o<12515907 then if o<12482901 then if o<12462484 then if o<12415787 then C=x[1]I=z[r[1]]Z=p(12252)o=I[Z]Z=o o=not Z o=o and 10001167 or 8843186 else Z=z[r[2]]C=not Z o=5729569 I=C end else o=I and 2786895 or 2065117 end else if o<12503663 then if o<12489682 then C=nil Z=nil o=z[r[3]]I=o()o=u[p(12767)]I={}else Z=I o=not Z o=o and 11853435 or 5398181 end else o=z[r[3]]I=o()o=4699070 end end else if o<12530455 then if o<12527088 then if o<12521340 then N,l=y(k,N)o=N and 3597289 or 73751 else o=k o=Z and 16732768 or 336783 end else o=z[r[1]]C=false I=p(12007)o[I]=C k=p(12252)I=z[r[1]]C=p(12366)o=I[C]I=p(12663)C=false o[I]=C Z=z[r[2]]C=Z[k]I=C o=C and 5094957 or 16766561 end else if o<12552634 then if o<12540336 then P=p(12801)t=p(12801)D=X[t]t=C[P]V=D-t D=p(12762)o=V[D]V=o t=V<N D=t o=t and 13339045 or 4610700 else I=p(12723)o=u[I]k=z[r[1]]N={o(k)}C=N[2]I=N[1]o=10590436 Z=N[3]k=I end else o=z[r[2]]I=o()o=11195294 end end end end else if o<12709618 then if o<12626327 then if o<12586978 then if o<12562049 then if o<12560288 then q=p(12801)v=z[Z]n=v[q]H=p(12369)F=z[Z]o=13318427 f=F[H]F=p(12152)q=f[F]f=10 v=q*f R=n+v m=R else o=7970444 l=z[r[1]]N=l end else if o<12580793 then l=p(12041)l=W[l]Z=y Y=p(12829)l=l(W,Y)o=l and 11711761 or 8681521 else o=8140342 V=nil end end else if o<12614225 then if o<12596287 then k=p(12779)I=C[k]W=p(12585)y=u[W]W=p(12779)N=y[W]y=p(12336)k=N[y]o=I==k o=o and 16622914 or 13940619 else k=p(12830)Z=z[r[1]]C=Z[k]I=C o=C and 10125991 or 11156953 end else o=z[r[1]]o=o and 1525734 or 8319667 end end else if o<12682463 then if o<12662265 then if o<12641321 then Z=p(12526)N=p(12002)C=p(12409)I=u[C]C=p(12810)o=I[C]W=1 C=p(12415)a=p(12716)I=o(C)C=e()z[C]=I o=z[C]I=p(12628)o[I]=Z Z=1 I=p(12868)y=1 o=z[C]o[I]=Z I=p(12411)o=z[C]k=u[N]N=p(12810)Z=k[N]N=1 k=Z(N,y,W)Z=true o[I]=k o=z[C]l=p(12716)D=p(12104)v=1 i=30 I=p(12471)o[I]=Z o=z[C]k=p(12328)X=360 Z=false n=0 I=p(12858)o[I]=Z Y=0 M=p(12676)N=p(12177)o=z[C]g=p(12030)Z=u[k]I=p(12350)o[I]=Z I=p(12772)o=J(9060279,{C})Z=o W=u[l]l=p(12810)y=W[l]P=.564706 l=0 W=y(l,Y)Y=u[a]a=p(12810)l=Y[a]q=.4 R=1 a=-360 Y=l(a,X)X=u[g]y=p(12288)g=p(12810)l=p(12684)a=X[g]V=u[D]D=p(12810)g=V[D]t=0 D=.509804 V={g(D,t,P)}g=p(12814)H=p(12716)X=a(s(V))a=p(12861)V=p(12868)P=p(12125)t=u[P]P=p(12810)D=t[P]m=u[M]M=p(12810)Q=m[M]M=0 m=Q(M,R)R=p(12676)M=u[R]R=p(12810)Q=M[R]R=.5 M=Q(R,n)n=p(12676)R=u[n]n=p(12810)Q=R[n]n=1 R={Q(n,v)}P={m;M;s(R)}t=D(P)R=p(12125)v=p(12716)M=u[R]D=p(12170)P=1 n=0 Q=p(12411)R=p(12810)m=M[R]R=4.6875 M=m(R,n)m=p(12709)n=u[v]v=p(12810)R=n[v]v=.4 n=R(v,q)v=60 R=p(12225)F=u[H]H=p(12810)f=F[H]H=30 q=p(12782)F=f(H,i)k={[N]=W;[y]=Y;[l]=X;[a]=g,[V]=t;[D]=P;[Q]=M,[m]=n;[R]=v;[q]=F}Q=.1875 o=Z(I,k)D=.584314 P=p(12125)l=p(12716)N=p(12177)I=p(12014)W=u[l]Y=10 g=p(12104)v=p(12321)m=p(12716)q=-180 l=p(12810)y=W[l]a=p(12030)l=10 W=y(l,Y)Y=u[a]a=p(12810)y=p(12684)l=Y[a]X=u[g]g=p(12810)a=X[g]V=0 g=.388235 X={a(g,V,D)}g=p(12831)V=p(12411)Y=l(s(X))X=p(12861)l=p(12228)t=u[P]a=1 P=p(12810)D=t[P]P=0 t=D(P,Q)Q=u[m]m=p(12810)P=Q[m]m=.25 M=1 D=p(12709)Q=P(m,M)m=100 n=u[v]v=p(12810)P=p(12225)R=n[v]v=180 n=R(v,q)M=p(12130)v=180 R=p(12440)k={[N]=W;[y]=Y;[l]=a,[X]=g;[V]=t;[D]=Q;[P]=m;[M]=n,[R]=v}a=p(12030)q=-170 N=p(12177)o=Z(I,k)Q=.3 g=p(12104)P=p(12125)Y=10 l=p(12716)I=p(12510)W=u[l]V=0 l=p(12810)y=W[l]l=10 W=y(l,Y)y=p(12684)Y=u[a]a=p(12810)l=Y[a]X=u[g]g=p(12810)a=X[g]D=.407843 g=.266667 X={a(g,V,D)}M=1 Y=l(s(X))l=p(12228)v=p(12321)t=u[P]g=p(12831)X=p(12861)V=p(12411)P=p(12810)a=1 D=t[P]P=0 t=D(P,Q)m=p(12716)D=p(12709)Q=u[m]m=p(12810)P=Q[m]m=.25 Q=P(m,M)n=u[v]m=100 M=p(12130)P=p(12225)v=p(12810)R=n[v]v=170 n=R(v,q)R=p(12440)v=170 k={[N]=W;[y]=Y,[l]=a;[X]=g,[V]=t;[D]=Q;[P]=m,[M]=n;[R]=v}o=Z(I,k)k=p(12409)I=u[k]k=p(12810)o=I[k]k=p(12499)I=o(k)k=z[C]o=p(12350)I[o]=k o=z[C]I={o}o=u[p(12418)]else I={}o=u[p(12693)]end else o=W o=y and 3278533 or 15256356 end else if o<12700293 then if o<12696701 then D=z[r[1]]t=p(12252)V=D[t]g=a~=V X=g o=4656881 else C=nil Gy=p(12318)xy=p(12409)I=u[xy]xy=p(12810)ry=1262 o=I[xy]xy=p(12343)I=o(xy)o=p(12628)xy=I ey=e()I=p(12459)xy[o]=I Iy=e()Oy[1]=e()o=p(12405)cy=e()I=false xy[o]=I o=p(12095)I=p(12836)o=xy[o]o=o(xy,I,ry)wy=e()zy=e()I=p(12691)o=p(12636)xy[o]=I I=p(12271)ky=e()o=p(12293)xy[o]=I o=p(12350)ry=z[r[3]]I=ry[Gy]xy[o]=I o=L(15085195,{T})ry=e()Gy=e()z[ry]=o Zy=e()o=S(51664,{g;D})z[Gy]=o Ny=e()o=d(6993561,{D;g})z[wy]=o o=O(10913597,{H,r[3]})Cy=e()z[Iy]=o o=d(720178,{Iy,q})z[zy]=o o=O(1772123,{Iy;E;oy})z[Cy]=o Iy=c(Iy)I=p(12238)o=O(7408010,{E})z[ey]=o o=B(4448004,{t;V,r[3];D;g;ey,f,zy,Q,y,i;b,h;Cy,wy})Oy[2]=L(7131762,{t,Zy})Ly=e()z[Zy]=o y=c(y)yy=e()o=d(6551129,{t;i,r[3],py,ey,f;zy;m,Z,W})z[ky]=o o=S(9184326,{t,i;py;r[3];k,ey,zy,m,Z;W,b,h;Cy})z[Ny]=o D=c(D)o=O(909028,{t;b,r[3];A,ey,f;zy,M,l})z[cy]=o wy=c(wy)l=c(l)o=L(7989471,{t,b,A;r[3];ey;zy,R,Z,N;Y;a,i,h;Cy})z[yy]=o o=J(12702450,{t;h,r[3];ry,uy,ey;f;F;zy;v,T,Z,n,X})z[Ly]=o o=d(15852574,{t,h,uy,r[3];ey,F,ry;N;zy,m,Z,X;i,b,Cy,v})z[Oy[1]]=o n=c(n)R=c(R)o=xy[I]Y=c(Y)I=p(12573)I=o[I]N=c(N)I=I(o,Oy[2])I=p(12088)Oy[2]=L(11460671,{t,r[3];H,Cy,Gy;P,Zy})o=xy[I]I=p(12573)X=c(X)I=o[I]oy=c(oy)v=c(v)I=I(o,Oy[2])sy=nil T=c(T)W=c(W)Oy[2]=L(16219111,{t,ey,q,f;F;ry;Gy;V;P;i,py;b,A,h;uy})I=p(12531)Gy=c(Gy)o=xy[I]Z=c(Z)I=p(12573)I=o[I]M=c(M)I=I(o,Oy[2])I=z[r[4]]Oy[2]=p(12441)A=c(A)k=c(k)ry=c(ry)o=I[Oy[2]]b=c(b)q=c(q)E=c(E)I=p(12573)I=o[I]Oy[2]=B(1725083,{r[4],t;ky,cy,Ly;Zy})P=c(P)h=c(h)I=I(o,Oy[2])m=c(m)H=c(H)g=c(g)ey=c(ey)zy=c(zy)Ly=c(Ly)I=z[r[4]]i=c(i)py=c(py)Oy[2]=p(12229)F=c(F)V=c(V)uy=c(uy)xy=nil o=I[Oy[2]]Oy[2]=K(222474,{t;Ny;yy,Oy[1]})Ny=c(Ny)ky=c(ky)a=c(a)f=c(f)I=p(12573)t=c(t)Oy[1]=c(Oy[1])I=o[I]I=I(o,Oy[2])Cy=c(Cy)cy=c(cy)Q=c(Q)o=u[p(12148)]I={}yy=c(yy)Zy=c(Zy)end else Z=z[r[1]]C=not Z I=C o=C and 1734903 or 2421069 end end end else if o<12768188 then if o<12743411 then if o<12734569 then if o<12729224 then o=u[p(12414)]I={}else o=z[r[2]]o=o and 3358014 or 10492821 end else C=p(12252)I=z[r[3]]o=I[C]C=o o=not C o=o and 92115 or 16125698 end else if o<12751416 then if o<12746243 then o=z[r[1]]C=z[r[2]]I=o(C)I={}o=u[p(12507)]else N=p(12742)k=z[r[1]]Z=k[N]I=Z o=Z and 10823438 or 10386098 end else o=z[r[3]]I=p(12743)I=o[I]I=I(o)o=10687013 end end else if o<12786635 then if o<12782319 then if o<12776985 then Q=nil o=7171792 m=nil M=c(M)V=nil else o=k o=not I o=o and 733461 or 8207424 end else l=p(12801)o=z[r[2]]W=Z[l]I=o(W)N=nil W=p(12349)o=z[r[3]]l=p(12348)a=nil y=nil Z=nil Y=nil I=o(C,W,l,Y,a)k=nil I={}o=u[p(12702)]C=nil end else if o<12820308 then if o<12795234 then k=z[r[7]]y=z[r[8]]N=k(y)k=z[r[9]]o=k and 736805 or 2556080 else o=R R=m n=o o=m and 1506128 or 2571427 end else y=1 I=N[y]o=Z(I)o=3808717 end end end end end else if o<13131856 then if o<12968908 then if o<12919648 then if o<12878598 then if o<12856138 then if o<12850335 then I=false C=x[1]o=C z[r[1]]=o N=p(12719)z[r[2]]=I k=u[N]N=p(12783)Z=k[N]N=.15 k=Z(N)k=o N=z[r[3]]o=N and 4950885 or 12525875 Z=N else a,X=l(Y,a)o=a and 3689956 or 11316004 end else if o<12860620 then o=z[r[3]]I=o(C)o=10138307 else o=z[r[1]]o=o and 6993174 or 10695112 end end else if o<12910180 then if o<12891713 then o=I and 3963983 or 5407689 else k=z[r[1]]o=15663186 N=p(12350)Z=k[N]C=not Z I=C end else Y=p(12122)I=C[Y]o=I[l]I={o}o=u[p(11999)]end end else if o<12945128 then if o<12939191 then if o<12937123 then I={W}V=C g=p(12350)W[g]=V o=u[p(12362)]else l=z[r[7]]Y=p(12178)y=l[Y]Y=O(4604597,{r[7],r[2],r[1];r[11],r[12];r[13];r[14];r[15]})l=p(12573)l=y[l]o=15402550 l=l(y,Y)end else Z=p(12041)k=p(12343)C=x[1]Z=C[Z]Z=Z(C,k)I=Z o=Z and 1060311 or 5204090 end else if o<12960653 then if o<12953838 then I=z[r[1]]C=p(12830)o=I[C]o=o and 5387298 or 3805161 else N=z[r[1]]o=p(12350)k[o]=N Z=nil C=nil o=u[p(12433)]k=nil I={}end else o=3064338 Z=z[r[2]]C=not Z I=C end end end else if o<13036822 then if o<13000589 then if o<12974823 then if o<12971212 then Z=z[r[2]]o=7897678 k=p(12252)C=Z[k]k=p(12280)Z=p(12855)Z=C[Z]Z=Z(C,k)I=Z else l=p(12719)W=u[l]l=p(12783)o=W[l]l=.2 W=o(l)l=p(12830)W=z[r[1]]o=W[l]o=o and 3882579 or 11267730 end else l=I o=l and 2747478 or 11683063 end else if o<13033240 then if o<13008883 then C=p(12719)I=u[C]C=p(12783)o=I[C]C=.5 I=o(C)C=z[r[1]]I=C o=C and 2715505 or 6416324 else I={}o=u[p(12502)]end else o=z[r[1]]I={o}o=u[p(12032)]end end else if o<13093826 then if o<13060037 then if o<13039380 then v=m q=o o=m and 5036249 or 9409343 else g=p(12252)X=z[r[3]]a=X[g]g=p(12087)o=13653726 X=p(12281)X=a[X]X=X(a,g)l=X end else k=e()W=p(12425)C=x[1]I=z[r[1]]Z=p(12810)o=I[Z]Z=p(12859)I=o(Z)o=p(12737)o=I[o]o=o(I)I=p(12642)Z=e()o=false z[Z]=o o=false z[k]=o o=u[I]N=z[r[2]]y=p(12356)y=N[y]y=y(N,W)l=p(12356)W=p(12662)N=p(12356)N=y[N]N=N(y,W)W=p(12326)l=N[l]y={l(N,W)}N=e()I=o(s(y))z[N]=I I=p(12642)o=u[I]l=p(12425)Y=p(12356)W=p(12356)y=z[r[2]]W=y[W]W=W(y,l)y=p(12356)y=W[y]l=p(12662)X=p(12318)y=y(W,l)Y=y[Y]l=p(12353)W={Y(y,l)}y=e()I=o(s(W))o=L(10074015,{r[3]})z[y]=I W=e()z[W]=o o=L(10045506,{k,Z,W;N;y})l=e()Y=p(12441)z[l]=o I=z[r[4]]o=I[Y]I=p(12573)Y=d(12381926,{r[4];k;l})I=o[I]I=I(o,Y)a=z[r[3]]Y=a[X]a=p(12281)X=p(12649)a=Y[a]a=a(Y,X)o=a and 787038 or 5243408 I=a end else if o<13119567 then if o<13114859 then I={k}o=u[p(12493)]else o=I and 8715799 or 4382239 end else o=z[r[2]]I=o()o=10567974 end end end end else if o<13277266 then if o<13203122 then if o<13169905 then if o<13157917 then if o<13156478 then o=true N=true z[r[2]]=o k=p(12663)I=z[r[4]]I[k]=N I=z[r[5]]k=I()I=z[r[6]]o=I and 5040810 or 16654105 else I={}o=u[p(11997)]end else if o<13160815 then o=false z[r[2]]=o I=z[r[3]]C=p(12663)Z=false I[C]=Z C=z[r[4]]Z=p(12252)I=C[Z]C=I I=not C o=I and 2975379 or 11155346 else I={}C=nil Z=nil o=u[p(12191)]end end else if o<13201358 then if o<13178408 then o=I and 4523824 or 10815690 else o=7863369 l=nil a=nil Y=nil X=c(X)end else k=z[r[4]]N=p(12315)Z=k[N]o=3649669 N=z[r[3]]k=p(12288)Z[k]=N end end else if o<13227461 then if o<13210768 then if o<13209089 then o=z[r[3]]I=o()o=7142786 else V=D o=t o=10756048 end else I={}o=u[p(12320)]end else if o<13276135 then if o<13234875 then V=D o=t o=2948979 else Y=p(12719)I={}l=u[Y]Y=p(12668)o=u[p(12292)]N=l[Y]C=nil Y=B(2213586,{r[14],Z;r[5]})Z=c(Z)l=N(Y)end else V=o Q=p(12489)P=u[Q]m=p(12778)Q=p(12794)t=P[Q]Q=Y[m]P=t(Q)Q=p(12778)t=a[Q]D=P<t g=D o=D and 15964632 or 12321434 end end end else if o<13325052 then if o<13310612 then if o<13285518 then if o<13281457 then o=z[r[2]]I=o()o=15707944 else W=p(12801)y=z[r[3]]o=15914899 N=y[W]Z=N end else o=z[r[1]]g=l I=p(12369)t=p(12369)D=u[t]t=p(12810)P=p(12801)V=D[t]t=Z[P]D=V(t)o[I]=D V=p(12719)I=u[V]g=nil V=p(12783)o=I[V]V=.05 I=o(V)o=1570727 end else if o<13319760 then if o<13317094 then v=p(12080)R=o n=u[v]P=n o=n and 11400361 or 13400056 else o=M y={[W]=l;[Y]=a,[X]=g;[V]=D,[t]=P;[Q]=m}k=I(y)y=p(12719)N=c(N)k=u[y]W=O(3599399,{r[1],r[2],r[11],r[12],r[7],r[8]})y=p(12027)I=k[y]y=.3 k=I(y,W)y=p(12719)k=u[y]y=p(12027)o=u[p(12838)]I=k[y]y=.8 Z=c(Z)W=B(8451571,{r[1];r[2];r[11],r[12];r[13]})k=I(y,W)C=nil I={}end else i,py=F(H,i)o=i and 6266771 or 3357770 end end else if o<13350791 then if o<13344292 then if o<13328235 then C=x[1]I=z[r[1]]V=p(12425)Z=p(12810)t=p(12425)o=I[Z]Z=p(12584)I=o(Z)v=18637209873 o=p(12737)y=p(12031)X=p(12425)Z=p(12642)o=I[o]o=o(I)I=u[Z]g=p(12425)W=p(12356)k=z[r[2]]W=k[W]N={W(k,y)}k=e()Z=I(s(N))I=p(12258)N=e()o=Z[I]Z=e()z[Z]=o o=S(3807782,{r[3]})z[k]=o I=p(12642)D=p(12425)o=B(7594827,{r[3]})z[N]=o o=u[I]a=z[r[2]]Y=a[X]a=p(12662)l=Y[a]Y=p(12491)W=l[Y]l=p(12286)y=W[l]I=o(y)y=e()z[y]=I I=p(12642)oy=p(12409)o=u[I]X=z[r[2]]a=X[g]m=18699542775 X=p(12662)h=e()Y=a[X]a=p(12491)l=Y[a]Y=p(12012)W=l[Y]I=o(W)W=e()z[W]=I I=p(12642)n=p(12424)o=u[I]R=18686496907 g=z[r[2]]X=g[V]g=p(12662)a=X[g]X=p(12491)Y=a[X]a=p(12654)l=Y[a]I=o(l)l=e()b=e()M=18699545564 z[l]=I I=p(12642)o=u[I]V=z[r[2]]g=V[D]py=p(12409)V=p(12662)X=g[V]g=p(12491)a=X[g]X=p(12437)Y=a[X]I=o(Y)P=p(12425)Y=e()H=e()z[Y]=I E=e()sy=p(12049)I=p(12642)o=u[I]D=z[r[2]]V=D[t]D=p(12662)g=V[D]q=p(12474)Q=18699541378 V=p(12491)X=g[V]g=p(12055)a=X[g]I=o(a)a=e()z[a]=I I=p(12642)o=u[I]t=z[r[2]]D=t[P]t=p(12662)f=18637217215 V=D[t]D=p(12491)t=e()g=V[D]V=p(12324)X=g[V]I=o(X)D=e()X=e()o=0 g=e()z[X]=I V=e()z[g]=o o=true z[V]=o o=nil z[D]=o o=false z[t]=o P=e()I=18699539486 o=nil uy=p(12409)z[P]=o o={I,Q,m,M}I=p(12012)m=18637207623 M=p(12644)Q=e()z[Q]=o o={[I]=m;[M]=R;[n]=v;[q]=f}m=e()M=e()R=e()z[m]=o o=18686500373 z[M]=o o=18686502223 v=e()z[R]=o o=18637214138 f=e()i=e()n=e()z[n]=o o=18637218777 z[v]=o o=nil F=e()q=e()z[q]=o o=nil z[f]=o o=nil z[F]=o o=nil z[H]=o o=false z[i]=o I=u[py]py=p(12810)o=I[py]py=p(12722)I=o(py)o=false A=p(12409)T=e()py=e()z[py]=I z[b]=o I=u[A]A=p(12810)o=I[A]A=p(12722)I=o(A)o=false A=e()z[A]=I z[h]=o I=u[uy]uy=p(12810)ry=p(12318)o=I[uy]uy=p(12722)I=o(uy)uy=e()o={}z[uy]=I z[T]=o o=nil z[E]=o I=u[oy]oy=p(12810)o=I[oy]oy=p(12207)I=o(oy)oy=e()z[oy]=I o=z[oy]I=p(12270)o[I]=sy xy=z[r[3]]sy=xy[ry]ry=p(12853)xy=p(12281)xy=sy[xy]xy=xy(sy,ry)I=xy o=xy and 173055 or 10072627 else P=80 t=V<P D=t o=4610700 end else o=Y and 8097263 or 16204961 end else if o<13371072 then if o<13360878 then o=z[r[2]]I=o()o=7517424 else o=z[r[1]]X=W X=nil I=p(12369)D=p(12369)V=u[D]D=p(12810)t=p(12801)g=V[D]D=Z[t]V=g(D)g=p(12719)o[I]=V I=u[g]g=p(12783)o=I[g]g=.05 I=o(g)o=6484622 end else N=z[r[1]]y=p(12281)y=N[y]W=p(12054)y=y(N,W)k=y o=y and 676882 or 15211535 end end end end end end else if o<13966386 then if o<13645198 then if o<13488728 then if o<13425619 then if o<13406931 then if o<13388124 then if o<13384055 then C=z[r[1]]I=C o=C and 2272486 or 10258046 else o=Y o=l and 4909473 or 8672786 end else if o<13399373 then C=I o=z[r[3]]Z=true I=o(C,Z)o=z[r[1]]Z=1 I=p(12387)o[I]=Z I=z[r[1]]Z=p(12135)o=I[Z]o=o and 11371360 or 5603215 else o=R o=14098905 D=P end end else if o<13409816 then if o<13407606 then C=z[r[1]]I=C o=C and 5903779 or 4687556 else Z=N o=y o=8919117 end else y=z[r[7]]o=15878459 W=p(12786)W=y[W]W=W(y)end end else if o<13462463 then if o<13456700 then if o<13441232 then Y=#k a=0 l=Y>a y=l o=11977351 else Q=p(12128)V=p(12173)P=p(12281)M=o m=Y P=W[P]o=Y and 11332021 or 2510435 P=P(W,Q)t=p(12607)Q=p(12574)end else X=p(12041)a=o X=W[X]g=p(12777)X=X(W,g)Y=X o=X and 14648013 or 16376456 end else if o<13478484 then if o<13468523 then o=I and 11210943 or 9448481 else I=p(12281)I=C[I]Z=p(12822)I=I(C,Z)Z=e()z[Z]=I k=z[Z]I=not k o=I and 14562363 or 254539 end else o=I and 12028459 or 11962629 end end end else if o<13584245 then if o<13548632 then if o<13512262 then if o<13504127 then l=p(12547)W=z[r[1]]y=W[l]W=p(12622)N=y[W]o=7518063 k=not N C=k else o=z[r[6]]I=o()o=4390994 end else I=p(12347)o=u[I]C=z[r[1]]I=o(C)I={}o=u[p(12266)]end else if o<13579827 then if o<13565604 then o=I and 7555887 or 12058875 else o=4419387 C=z[r[2]]I=C end else t=o R=p(12124)P=u[R]D=P o=P and 13310654 or 14098905 end end else if o<13606891 then if o<13604602 then if o<13593067 then o=z[r[7]]o=o and 14722651 or 9747162 else H,py=f(F,H)o=H and 6382506 or 10435875 end else C=e()z[C]=x[1]o=z[C]o=o and 11199402 or 11640006 end else if o<13630450 then if o<13615951 then g=U(3148917,{})N=p(12642)Z={}k=u[N]Y=p(12687)V=p(12688)l=p(12689)W=u[l]l=p(12394)l=W[l]l=l(W,Y)W=p(12396)a=p(12687)y=l[W]N=k(y)W=p(12046)k=e()y=p(12689)z[k]=N N=u[y]l=p(12403)y=p(12394)y=N[y]y=y(N,W)W=p(12689)N=u[W]Y=p(12449)W=p(12394)W=N[W]W=W(N,l)N=e()l=p(12689)z[N]=W W=u[l]l=p(12394)l=W[l]l=l(W,Y)Y=p(12689)W=e()z[W]=l l=u[Y]Y=p(12394)Y=l[Y]Y=Y(l,a)l=e()z[l]=Y a=p(12689)X=p(12677)Y=u[a]a=p(12394)a=Y[a]a=a(Y,X)Y=e()X=p(12518)z[Y]=a a=y[X]X=e()z[X]=a a=e()z[a]=g g=U(6648710,{k;l,a,X,N,W})Z[V]=g V=p(12492)g=J(9888486,{k,l,X,W})Z[V]=g V=p(12025)g=O(13327479,{k,l;X;W})Z[V]=g V=p(12439)g=S(5828991,{k,X,a,Y})Z[V]=g V=p(12576)g=J(8327861,{k,X,a,N})Z[V]=g g=O(9931154,{k;l,X})V=p(12813)Z[V]=g V=p(12826)g=J(10580638,{k;l;X,W})Z[V]=g g=O(13087922,{k;l;X;W})V=p(12860)Z[V]=g g=d(7509338,{k,l;X,W})V=p(11998)Z[V]=g V=p(12331)g=J(7804891,{k;a})Z[V]=g V=p(12495)g=u[V]o=g and 16202725 or 7493438 else I=p(12056)o=W[I]l=o X=p(12122)a=C[X]Y=a[l]I=Y o=Y and 9821129 or 15815186 end else C=z[r[2]]o=1588701 I=C end end end end else if o<13818999 then if o<13742867 then if o<13660281 then if o<13654144 then if o<13651234 then l=p(12570)o=p(12041)o=W[o]y=k o=o(W,l)o=o and 1163778 or 9893355 else o=Y o=4821949 I=l end else if o<13654582 then Oy[4]=p(12321)A=p(12747)t=p(12375)uy=p(12033)Cy=p(12172)h=p(12385)g=p(12289)Gy=p(12536)zy=p(12218)Iy=p(12618)T=p(12247)Zy=p(12115)Ly=p(12431)b=p(12506)E=p(12300)M=p(12733)oy=p(12126)F=p(12864)Q=p(12657)a=p(12037)Oy[1]=p(12761)wy=p(12856)m=p(12005)X=p(12291)v=p(12505)n=p(12373)Ny=p(12096)yy=p(12176)I=p(12578)py=p(12244)P=p(12608)i=p(12851)H=p(12093)Oy[5]=609 cy=p(12780)f=p(12361)Y=p(12819)q=p(12185)V=p(12036)ky=p(12760)ry=p(12097)sy=p(12390)R=p(12674)D=p(12143)ey=p(12465)xy=p(12188)Oy[11]=761 Oy[7]=305 o={[I]=Y,[a]=X;[g]=V,[D]=t;[P]=Q,[m]=M;[R]=n,[v]=q,[f]=F;[H]=i,[py]=b,[A]=h,[uy]=T,[E]=oy,[sy]=xy;[ry]=Gy;[wy]=Iy;[zy]=Cy,[ey]=Zy,[ky]=Ny,[cy]=yy,[Ly]=Oy[1]}P=p(12321)M=1 m=p(12321)Q=457 X=p(12063)Y=e()I=p(12674)n=609 V=p(12149)z[Y]=o g=p(12068)h=305 v=p(12321)t=u[P]py=p(12321)P=p(12810)Zy=153 D=t[P]i=305 P=1 t=D(P,Q)a={[X]=g;[V]=t}t=p(12149)Q=u[m]f=p(12321)q=153 V=p(12063)R=p(12321)m=p(12810)P=Q[m]Oy[18]=p(12321)m=457 E=p(12321)yy=609 Oy[1]=457 A=p(12321)xy=305 X=p(12251)D=p(12068)Q=P(m,M)M=u[R]R=p(12810)F=1 P=p(12068)H=p(12321)g={[V]=D;[t]=Q}t=p(12063)T=153 m=M[R]V=p(12505)R=1 ey=p(12321)Oy[12]=p(12321)Q=p(12149)M=m(R,n)D={[t]=P;[Q]=M}m=p(12068)M=p(12149)Q=p(12063)Oy[13]=153 t=p(12465)n=u[v]v=p(12810)uy=p(12321)R=n[v]v=609 n=R(v,q)R=p(12393)q=u[f]P={[Q]=m,[M]=n}M=p(12063)Q=p(12793)f=p(12810)n=p(12149)v=q[f]f=609 q=v(f,F)Oy[22]=p(12321)m={[M]=R;[n]=q}q=p(12149)n=p(12063)v=p(12068)M=p(12390)F=u[H]H=p(12810)f=F[H]H=153 b=457 F=f(H,i)R={[n]=v;[q]=F}q=p(12063)ky=p(12321)i=u[py]F=p(12149)py=p(12810)f=p(12068)n=p(12431)H=i[py]py=305 i=H(py,b)v={[q]=f;[F]=i}ry=p(12321)b=u[A]q=p(12467)F=p(12063)A=p(12810)Oy[6]=p(12321)i=p(12149)py=b[A]A=609 H=p(12068)Oy[2]=p(12321)b=py(A,h)cy=p(12321)f={[F]=H,[i]=b}b=p(12149)i=p(12063)py=p(12068)h=u[uy]uy=p(12810)A=h[uy]F=p(12143)uy=1 h=A(uy,T)H={[i]=py,[b]=h}sy=p(12321)b=p(12063)Gy=457 h=p(12149)i=p(12780)wy=p(12321)A=p(12068)T=u[E]E=p(12810)oy=305 uy=T[E]E=305 Oy[25]=153 T=uy(E,oy)uy=p(12068)py={[b]=A;[h]=T}h=p(12063)oy=u[sy]T=p(12149)b=p(12005)sy=p(12810)E=oy[sy]sy=1 Oy[19]=1 oy=E(sy,xy)A={[h]=uy;[T]=oy}xy=u[ry]h=p(12298)E=p(12068)ry=p(12810)Iy=305 oy=p(12149)sy=xy[ry]ry=457 Oy[3]=457 T=p(12063)xy=sy(ry,Gy)uy={[T]=E,[oy]=xy}Gy=u[wy]T=p(12189)xy=p(12149)sy=p(12068)oy=p(12063)wy=p(12810)ry=Gy[wy]wy=761 Gy=ry(wy,Iy)Cy=457 E={[oy]=sy,[xy]=Gy}zy=p(12321)ry=p(12393)oy=p(12210)xy=p(12063)Gy=p(12149)Iy=u[zy]zy=p(12810)wy=Iy[zy]zy=457 Iy=wy(zy,Cy)sy={[xy]=ry;[Gy]=Iy}xy=p(12048)Cy=u[ey]Iy=p(12149)ey=p(12810)zy=Cy[ey]Ny=761 Gy=p(12063)wy=p(12068)ey=761 Cy=zy(ey,Zy)ry={[Gy]=wy;[Iy]=Cy}zy=p(12068)Ly=p(12321)Cy=p(12149)Gy=p(12634)Zy=u[ky]ky=p(12810)Iy=p(12063)ey=Zy[ky]ky=305 Zy=ey(ky,Ny)ey=p(12068)wy={[Iy]=zy,[Cy]=Zy}Iy=p(12381)Ny=u[cy]Oy[20]=p(12321)Zy=p(12149)cy=p(12810)ky=Ny[cy]cy=305 Ny=ky(cy,yy)Oy[23]=609 Cy=p(12063)ky=p(12393)zy={[Cy]=ey;[Zy]=Ny}Ny=p(12149)Cy=p(12037)Zy=p(12063)yy=u[Ly]Ly=p(12810)cy=yy[Ly]Ly=1 yy=cy(Ly,Oy[1])ey={[Zy]=ky;[Ny]=yy}Zy=p(12097)cy=p(12068)Ny=p(12063)Oy[1]=u[Oy[2]]yy=p(12149)Oy[2]=p(12810)Ly=Oy[1][Oy[2]]Oy[15]=457 Oy[2]=153 Oy[1]=Ly(Oy[2],Oy[3])ky={[Ny]=cy,[yy]=Oy[1]}yy=p(12063)Oy[3]=u[Oy[4]]Ly=p(12068)Oy[10]=p(12321)Oy[4]=p(12810)Oy[8]=p(12321)Oy[2]=Oy[3][Oy[4]]Oy[9]=761 Oy[4]=609 Ny=p(12235)Oy[3]=Oy[2](Oy[4],Oy[5])Oy[1]=p(12149)Oy[24]=p(12321)cy={[yy]=Ly,[Oy[1]]=Oy[3]}Oy[21]=1 yy=p(12301)Oy[1]=p(12063)Oy[2]=p(12393)Oy[5]=u[Oy[6]]Oy[6]=p(12810)Oy[4]=Oy[5][Oy[6]]Oy[3]=p(12149)Oy[6]=609 Oy[17]=761 Oy[5]=Oy[4](Oy[6],Oy[7])Ly={[Oy[1]]=Oy[2],[Oy[3]]=Oy[5]}Oy[5]=p(12149)Oy[1]=p(12361)Oy[4]=p(12068)Oy[7]=u[Oy[8]]Oy[3]=p(12063)Oy[8]=p(12810)Oy[6]=Oy[7][Oy[8]]Oy[8]=1 Oy[7]=Oy[6](Oy[8],Oy[9])Oy[2]={[Oy[3]]=Oy[4];[Oy[5]]=Oy[7]}Oy[7]=p(12149)Oy[9]=u[Oy[10]]Oy[5]=p(12063)Oy[3]=p(12739)Oy[10]=p(12810)Oy[8]=Oy[9][Oy[10]]Oy[14]=p(12321)Oy[6]=p(12068)Oy[10]=609 Oy[9]=Oy[8](Oy[10],Oy[11])Oy[4]={[Oy[5]]=Oy[6],[Oy[7]]=Oy[9]}Oy[9]=p(12149)Oy[11]=u[Oy[12]]Oy[5]=p(12300)Oy[8]=p(12068)Oy[7]=p(12063)Oy[12]=p(12810)Oy[10]=Oy[11][Oy[12]]Oy[12]=153 Oy[11]=Oy[10](Oy[12],Oy[13])Oy[6]={[Oy[7]]=Oy[8],[Oy[9]]=Oy[11]}Oy[13]=u[Oy[14]]Oy[10]=p(12068)Oy[7]=p(12511)Oy[14]=p(12810)Oy[12]=Oy[13][Oy[14]]Oy[9]=p(12063)Oy[14]=609 Oy[11]=p(12149)Oy[13]=Oy[12](Oy[14],Oy[15])Oy[8]={[Oy[9]]=Oy[10],[Oy[11]]=Oy[13]}Oy[12]=p(12393)Oy[11]=p(12063)Oy[16]=p(12321)Oy[13]=p(12149)Oy[15]=u[Oy[16]]Oy[16]=p(12810)Oy[9]=p(12608)Oy[14]=Oy[15][Oy[16]]Oy[16]=1 Oy[15]=Oy[14](Oy[16],Oy[17])Oy[10]={[Oy[11]]=Oy[12],[Oy[13]]=Oy[15]}Oy[11]=p(12093)Oy[13]=p(12063)Oy[15]=p(12149)Oy[17]=u[Oy[18]]Oy[18]=p(12810)Oy[14]=p(12068)Oy[16]=Oy[17][Oy[18]]Oy[18]=153 Oy[17]=Oy[16](Oy[18],Oy[19])Oy[16]=p(12068)Oy[12]={[Oy[13]]=Oy[14],[Oy[15]]=Oy[17]}Oy[15]=p(12063)Oy[17]=p(12149)Oy[19]=u[Oy[20]]Oy[13]=p(12244)Oy[20]=p(12810)Oy[18]=Oy[19][Oy[20]]Oy[20]=305 Oy[19]=Oy[18](Oy[20],Oy[21])Oy[14]={[Oy[15]]=Oy[16],[Oy[17]]=Oy[19]}Oy[21]=u[Oy[22]]Oy[22]=p(12810)Oy[17]=p(12063)Oy[20]=Oy[21][Oy[22]]Oy[18]=p(12068)Oy[22]=761 Oy[15]=p(12428)Oy[19]=p(12149)Oy[21]=Oy[20](Oy[22],Oy[23])Oy[23]=u[Oy[24]]Oy[16]={[Oy[17]]=Oy[18];[Oy[19]]=Oy[21]}Oy[21]=p(12149)Oy[20]=p(12068)Oy[17]=p(12218)Oy[19]=p(12063)Oy[24]=p(12810)Oy[22]=Oy[23][Oy[24]]Oy[24]=305 Oy[23]=Oy[22](Oy[24],Oy[25])Oy[18]={[Oy[19]]=Oy[20],[Oy[21]]=Oy[23]}o={[I]=a;[X]=g;[V]=D;[t]=P;[Q]=m,[M]=R,[n]=v,[q]=f,[F]=H;[i]=py;[b]=A,[h]=uy;[T]=E,[oy]=sy;[xy]=ry;[Gy]=wy,[Iy]=zy,[Cy]=ey;[Zy]=ky;[Ny]=cy,[yy]=Ly,[Oy[1]]=Oy[2];[Oy[3]]=Oy[4],[Oy[5]]=Oy[6],[Oy[7]]=Oy[8];[Oy[9]]=Oy[10],[Oy[11]]=Oy[12];[Oy[13]]=Oy[14];[Oy[15]]=Oy[16];[Oy[17]]=Oy[18]}a=e()z[a]=o o={}P=e()V=e()X=e()g=e()Q=e()M=p(12319)z[X]=o D=e()o=K(10355287,{})z[g]=o o=d(4943347,{X,C;Y;N,g;k})m=e()t=e()z[V]=o o=B(15517569,{})z[D]=o o=O(10650910,{N,C})z[t]=o o=J(7772757,{k})z[P]=o o=S(1065245,{a})v=p(12029)v=l[v]z[Q]=o o=B(2377519,{r[1];X,t,P;D,r[3],Q,g,C,V})z[m]=o I=z[y]o=I[M]M=S(9416892,{y;C;r[4],m})I=p(12573)I=o[I]I=I(o,M)I=p(12368)o=u[I]n={v(l)}v={o(s(n))}M=v[2]I=v[1]n=I o=10392801 R=v[3]else N=z[r[2]]k=not N I=k o=k and 13115637 or 14719971 end end else if o<13721462 then if o<13697074 then k,W=N(Z,k)o=k and 16163039 or 8789274 else o=5390353 V=nil end else o=15188877 Z=p(12281)Z=C[Z]k=p(12822)Z=Z(C,k)I=Z end end else if o<13791104 then if o<13777315 then if o<13756282 then Y=false o=u[p(12646)]y=false I={}z[r[10]]=y W=z[r[11]]l=p(12663)W[l]=Y W=false z[r[12]]=W l=z[r[13]]Y=p(12663)X=false a=false l[Y]=a l=false z[r[14]]=l a=p(12663)Y=z[r[15]]Y[a]=X else o=4587956 k=p(12786)I=z[r[6]]k=I[k]k=k(I)I=nil z[r[6]]=I end else C=z[r[1]]o=C and 6974479 or 5522507 I=C end else if o<13808319 then if o<13799479 then N=p(12719)y=O(12115406,{r[2]})k=u[N]N=p(12027)I=k[N]N=4 o=u[p(12643)]k=I(N,y)C=nil I={}Z=c(Z)else V=o t=z[r[12]]D=not t o=D and 3228609 or 5913060 g=D end else C=nil I={}o=u[p(12487)]end end end else if o<13938394 then if o<13871015 then if o<13836616 then if o<13825614 then I=C o=Z o=6252198 else t=p(12801)P=p(12801)D=g[t]t=C[P]V=D-t D=p(12762)o=V[D]V=o o=V<Z o=o and 16193781 or 12584962 end else I=z[r[5]]k=I()I=z[r[6]]o=I and 13756404 or 4587956 end else if o<13928835 then if o<13894444 then k=p(12786)I=z[r[6]]k=I[k]o=8626194 k=k(I)I=nil z[r[6]]=I else o=false z[r[1]]=o I=false z[r[2]]=I I={}o=u[p(12746)]end else o=z[r[1]]o=o and 14844262 or 14685537 C=x[1]end end else if o<13948433 then if o<13941139 then if o<13940207 then y=z[k]l=p(12002)W=p(12801)I=y[W]W=u[l]l=p(12810)a=0 y=W[l]l=0 Y=2 W=y(l,Y,a)o=I+W y=o o=z[k]I=p(12369)Y=p(12369)l=u[Y]Y=p(12810)a=e()W=l[Y]l=W(y)Y=e()o[I]=l o=z[r[2]]I=o()W=e()z[W]=I I=p(12283)P=p(12233)o=z[C]l=z[W]m=J(15705515,{a})g=p(12233)o[I]=l l=e()z[l]=y Q=p(12719)o=0 X=e()z[Y]=o o=200 z[a]=o o=nil z[X]=o D=p(12719)I=z[r[3]]o=I[g]I=p(12573)I=o[I]g=d(14475830,{k,l,Y;W})I=I(o,g)z[X]=I o=true g=e()z[g]=o V=u[D]D=p(12668)o=V[D]D=J(4838029,{g,Z})V=o(D)o=0 V=e()z[V]=o t=z[r[3]]o=nil D=o o=t[P]P=U(6368438,{Y;a,V;C})t=p(12573)t=o[t]t=t(o,P)D=t P=u[Q]Q=p(12027)o=P[Q]Q=.5 P=o(Q,m)o={}P=o o=z[r[4]]m=p(12022)Q=o(P)o=z[r[5]]Q=o()Q=z[C]o=Q[m]o=o and 237835 or 15607685 else W=p(12585)k=p(12779)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12324)k=N[y]o=I==k o=o and 5416933 or 4925922 end else I=z[r[2]]C=p(12252)o=I[C]C=o I=C o=C and 4333896 or 10112786 end else if o<13953479 then if o<13951848 then N=p(12147)V=p(12801)l=p(12795)W=p(12407)o=z[r[4]]y=z[r[2]]P=p(12369)a=p(12801)Y=C[a]a=p(12824)g=C[V]t=C[P]P=p(12152)D=t[P]t=60 V=D*t X=g+V g=p(12513)V=1 k={[N]=y;[W]=C;[l]=Y;[a]=X,[g]=V}I=o(k)Z=nil o=7666236 else o=V and 12531518 or 12399565 end else Z=z[r[1]]k=p(12830)C=Z[k]o=C and 6447518 or 15623557 I=C end end end end end else if o<14330514 then if o<14174853 then if o<14081745 then if o<13993666 then if o<13978761 then if o<13970249 then g=p(12252)X=z[r[3]]Y=o a=X[g]l=a o=a and 13042229 or 13653726 else k,W=N(Z,k)o=k and 13646164 or 6372566 end else if o<13983752 then I=p(12080)o=u[I]y=L(13515166,{Z})I=o(y)o=3520909 else N=1.2577049825842e+14 k=e()C=e()z[C]=x[1]y=O(5980848,{C;k,r[3]})z[k]=x[3]C=c(C)k=c(k)o=z[r[1]]I=o()o=z[r[2]]Z=x[2]Z=nil I=o(N,y)I={}o=u[p(12631)]end end else if o<14067994 then if o<14056354 then C=z[r[1]]I=C o=C and 16284847 or 15394835 else Z,y=k(C,Z)o=Z and 16569335 or 4933140 end else y=z[r[3]]o=9676383 W=p(12801)N=y[W]Z=N end end else if o<14121048 then if o<14098321 then if o<14094292 then o=z[r[3]]k=p(12644)Z=z[r[4]]C=Z[k]y=.5 Z=true N=p(12801)I=o(C,Z)C=p(12704)o=z[r[5]]k=z[r[6]]Z=k[N]k=nil I=p(12346)I=o[I]N=.7 I=I(o,C,Z,k,N,y)o=10012848 else m=R o=n o=R and 13318427 or 12559808 end else g=D o=t o=7675736 end else if o<14172878 then if o<14161836 then I=p(12080)N=J(11124431,{C})o=u[I]y={o(N)}k=y[2]I=y[1]y=z[Z]o=y and 8256998 or 8609855 N=I I=y else I={}o=u[p(12323)]end else y=p(12719)C=nil Z=c(Z)N=u[y]y=p(12027)I=N[y]k=nil o=u[p(12741)]y=.5 W=B(13407531,{r[1];r[12],r[2];r[13],r[14]})N=I(y,W)I={}end end end else if o<14234950 then if o<14210261 then if o<14206633 then if o<14189874 then I=p(12642)l=p(12425)C=nil o=u[I]W=z[r[2]]y=W[l]W=p(12662)N=y[W]y=p(12051)k=N[y]I=o(k)k=e()N=p(12409)z[k]=I I=u[N]N=p(12810)o=I[N]N=p(12343)I=o(N)N=I y=1183 o=p(12628)I=p(12051)N[o]=I I=false o=p(12405)N[o]=I I=false W=p(12318)o=p(12017)N[o]=I I=p(12836)o=p(12095)o=N[o]o=o(N,I,y)o=p(12636)Z=nil I=p(12343)N[o]=I o=p(12350)y=z[r[3]]I=y[W]N[o]=I o=z[r[3]]I=p(12560)I=o[I]y=e()I=I(o)W=e()z[y]=I l=J(16278437,{W})I=p(12088)o=false z[W]=o o=N[I]I=p(12573)I=o[I]I=I(o,l)l=S(9558439,{W})I=p(12531)o=N[I]I=p(12573)I=o[I]I=I(o,l)I=p(12238)o=N[I]I=p(12573)N=nil I=o[I]l=J(14300506,{W,r[3],y,k})W=c(W)I=I(o,l)k=c(k)I={}o=u[p(12109)]y=c(y)else g=p(12041)V=p(12272)g=a[g]Y=W g=g(a,V)o=g and 6394549 or 2635347 X=g end else C=nil Z=nil o=u[p(12785)]I={}end else if o<14221930 then if o<14217891 then k=p(12016)Z=p(12041)o=14784866 Z=C[Z]Z=Z(C,k)I=Z else W=N o=p(12041)Y=p(12829)o=l[o]o=o(l,Y)o=o and 14814780 or 15641476 end else W=z[r[3]]N=o y=not W k=y o=y and 16171265 or 10725692 end end else if o<14299850 then if o<14293131 then if o<14251482 then C=nil N=p(12319)y=S(5356422,{r[7]})Z=k[N]N=p(12573)N=Z[N]k=nil o=u[p(12212)]N=N(Z,y)I={}z[r[6]]=N else o=N C=k o=12129108 end else W,a=l(y,W)o=W and 9655634 or 5129300 end else if o<14309250 then if o<14301376 then I=z[r[1]]o=not I o=o and 2717192 or 886443 else k=p(12779)I=C[k]W=p(12585)y=u[W]W=p(12779)N=y[W]y=p(12336)k=N[y]o=I==k o=o and 10683102 or 1655528 end else o=I and 15282307 or 8089525 end end end end else if o<14478904 then if o<14414507 then if o<14378877 then if o<14376749 then if o<14345454 then o=C and 14642479 or 13808565 else I=p(12822)o=p(12281)o=C[o]o=o(C,I)Z=o o=not Z o=o and 15775963 or 6533074 end else o=10328109 a=p(12636)Y=y[a]a=p(11996)l=Y==a W=l end else if o<14411501 then if o<14388209 then A=p(12695)n=e()E=10000 v=p(12489)q=100 z[n]=Q I=u[v]v=p(12413)o=I[v]v=1 I=o(v,q)i=2 f=255 q=0 v=e()T=0 H=1 z[v]=I o=z[l]I=o(q,f)q=e()f=1 z[q]=I o=z[l]F=z[v]I=o(f,F)f=e()z[f]=I I=z[l]F=I(H,i)I=1 o=F==I F=e()I=p(12250)i=p(12103)z[F]=o b=u[A]h=z[l]uy={h(T,E)}A=b(s(uy))b=p(12103)o=p(12120)py=A..b H=i..py o=t[o]o=o(t,I,H)H=e()z[H]=o i=p(12080)I=u[i]py=O(14493219,{l,n,X;k;Z;P,F,H;v,f,q,a})i={I(py)}o={s(i)}i=o o=z[F]o=o and 8034687 or 5219455 else I=p(12346)C=p(12217)o=z[r[1]]I=o[I]k=z[r[2]]y=1 N=p(12801)Z=k[N]k=nil N=.6 I=I(o,C,Z,k,N,y)I=p(12346)C=p(12351)N=p(12801)o=z[r[1]]k=z[r[2]]y=1 Z=k[N]k=nil N=.65 I=o[I]I=I(o,C,Z,k,N,y)I=p(12346)o=z[r[1]]k=z[r[2]]C=p(12384)N=p(12801)Z=k[N]I=o[I]y=1.1 N=.6 k=nil I=I(o,C,Z,k,N,y)o=u[p(12179)]I={}end else I=z[r[6]]o=990650 k=p(12786)k=I[k]k=k(I)I=nil z[r[6]]=I end end else if o<14438053 then if o<14422757 then if o<14420084 then o=8251036 else Z=z[r[2]]k=p(12252)C=Z[k]Z=p(12855)k=p(12280)o=16643586 Z=C[Z]Z=Z(C,k)I=Z end else l=W X=p(12822)a=1 I=Y[a]a=I I=p(12281)I=a[I]I=I(a,X)X=e()z[X]=I I=z[X]o=I and 6657064 or 8252109 end else if o<14462327 then if o<14456630 then W=false o=p(12858)y[o]=W o=8152462 else I=z[r[2]]o=not I o=o and 11335705 or 5686269 end else C=z[r[1]]I=C o=C and 10832105 or 9301455 end end end else if o<14516441 then if o<14493429 then if o<14493209 then if o<14484815 then N=z[r[9]]W=z[r[16]]l=false y=N(W,l)z[r[6]]=y N=z[r[6]]o=N and 9334893 or 1096487 else I=z[k]o=not I o=o and 484415 or 12062718 end else y=2 N=1 Z=z[r[1]]k=Z(N,y)Z=1 C=k==Z I=C o=C and 15504397 or 10918140 end else if o<14508383 then if o<14498617 then k=z[r[6]]N=k()k=z[r[7]]N=k()k=true z[r[8]]=k N=z[r[9]]o=N and 9795762 or 13756135 else W=p(12369)o=z[r[2]]I=p(12090)y=u[W]I=o[I]W=p(12810)N=y[W]y={N(Z)}I=I(o,s(y))o=7603581 end else o=N o=2892823 C=k end end else if o<14580235 then if o<14577602 then if o<14566603 then I={}o=u[p(12209)]else C=z[r[1]]o=C and 14883107 or 2537710 I=C end else I=13391740 k=5556669 Z=p(12601)C=Z^k o=I-C C=o I=p(12770)o=I/C I={o}o=u[p(12870)]end else if o<14592622 then if o<14587678 then o=z[r[3]]I=o()o=4523737 else k=p(12823)Z=p(12038)C=p(12156)I=p(12333)N=p(12552)o={I,C,Z;k;N}I=p(12368)C=o o=u[I]N={o(C)}k=N[3]I=N[1]Z=N[2]N=I o=13682357 end else o=R o=8674891 I=M end end end end end end end else if o<15650100 then if o<15093390 then if o<14842799 then if o<14759218 then if o<14675086 then if o<14647784 then if o<14640716 then if o<14619798 then I=p(12199)o=z[C]Z=true o[I]=Z N=p(12252)k=z[r[1]]Z=k[N]I=Z o=Z and 15397495 or 256726 else Y=nil o=12112628 a=nil end else if o<14644514 then k=p(12483)Z=u[k]k=p(12015)o=Z[k]Z=o(C)o=13808565 else o=J(5405770,{N})m={o()}I={s(m)}o=u[p(12757)]end end else if o<14656114 then if o<14649089 then o=a l=Y o=4401379 else N=z[r[6]]y=N()N=false z[r[2]]=N y=z[r[7]]o=y and 13412365 or 15878459 end else o=u[p(12774)]I={k}end end else if o<14723798 then if o<14721698 then if o<14714249 then I=p(12338)I=C[I]Z=z[r[2]]I=I(C,Z)o=not I o=o and 11139008 or 5288413 else o=13115637 k=z[r[3]]I=k end else C=p(12253)k=0 o=u[C]Z=z[r[8]]C=o(Z,k)o=9747162 end else if o<14752670 then if o<14746904 then Y=p(12801)l=z[r[2]]W=l[Y]o=9441769 N=W else y=p(12409)N=u[y]y=p(12810)k=N[y]o=16252701 y=p(12755)N=k(y,Z)I=N end else o=y Z=N o=N and 9676383 or 14080365 end end end else if o<14787120 then if o<14770462 then if o<14765896 then if o<14761936 then o=12998673 Y=1 l=W[Y]I=l else Y=p(12585)y=p(12153)N=C[y]l=u[Y]Y=p(12153)W=l[Y]l=p(12671)y=W[l]k=N==y I=k o=k and 6327781 or 10215406 end else o=z[r[1]]o=o and 9668727 or 10841915 end else if o<14773834 then if o<14771310 then o=6151608 X=nil g=nil else o=u[p(12753)]I={}end else o=I and 15075709 or 12248869 end end else if o<14815537 then if o<14805812 then if o<14801488 then D=p(12369)X=W I=p(12369)o=z[r[1]]t=p(12801)V=u[D]X=nil D=p(12810)g=V[D]D=Z[t]V=g(D)g=p(12719)o[I]=V I=u[g]g=p(12783)o=I[g]g=.05 I=o(g)o=6221113 else o=I and 4240443 or 1922192 end else o=p(12858)Y=not Z l[o]=Y o=15641476 end else if o<14841654 then if o<14836662 then o=z[r[3]]I=p(12743)I=o[I]I=I(o)o=1378526 else wy=p(12252)Gy=z[r[3]]ry=Gy[wy]Gy=p(12281)wy=p(12853)Gy=ry[Gy]Gy=Gy(ry,wy)sy=Gy o=9848862 end else a=p(12213)Y=1 l=W[Y]Y=p(12281)Y=l[Y]Y=Y(l,a)I=Y o=Y and 10292527 or 7197144 end end end end else if o<14981693 then if o<14931467 then if o<14884839 then if o<14869283 then if o<14843892 then o=I and 11923722 or 8052525 else o=u[p(12044)]I={}end else if o<14882149 then o=I and 9686407 or 5533142 else N=z[r[2]]Z=o k=not N C=k o=k and 10801762 or 2892823 end end else if o<14926069 then if o<14891743 then o=u[p(12686)]I={k}else k=p(12719)I=u[k]k=p(12392)o=I[k]k=z[r[4]]I=o(k)o=nil z[r[4]]=o o=11695730 end else N=z[r[2]]y=p(12252)k=N[y]N=p(12855)y=p(12280)N=k[N]N=N(k,y)y=p(12755)k=p(12281)o=13823429 k=N[k]k=k(N,y)C=k end end else if o<14952416 then if o<14934969 then if o<14932360 then o=2415955 l=z[r[1]]N=l else N=p(12786)k=z[r[8]]o=5381746 N=k[N]N=N(k)k=nil z[r[8]]=k end else I={}o=false z[r[1]]=o o=u[p(12532)]end else if o<14977006 then if o<14962477 then y=p(12409)N=u[y]y=p(12810)k=N[y]y=p(12755)N=k(y,Z)I=N o=10095924 else k=p(12779)W=p(12585)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12012)k=N[y]o=I==k o=o and 11486519 or 10714522 end else l=p(12369)o=true z[r[2]]=o Z=p(12801)I=C[Z]Z=e()z[Z]=I k=z[Z]W=C[l]l=p(12152)y=W[l]W=600 N=y*W I=k+N k=e()y=p(12719)z[k]=I o=u[p(12341)]N=u[y]y=p(12668)I=N[y]y=O(3559885,{r[4];Z,k})N=I(y)I=false C=nil z[r[2]]=I k=c(k)Z=c(Z)I={}end end end else if o<15063956 then if o<15024339 then if o<14991216 then if o<14983278 then k=p(12281)N=p(12755)k=Z[k]k=k(Z,N)I=k o=k and 4985926 or 2942734 else I=p(12387)W=p(12387)o=z[r[1]]y=z[r[1]]N=y[W]y=4 k=N%y N=1 Z=k+N o[I]=Z Z=p(12135)I=z[r[1]]o=I[Z]o=o and 5615752 or 7956505 end else o=I and 6151936 or 10616035 end else if o<15055092 then if o<15029521 then o=u[p(12082)]I={}else k=k+y l=not W I=k<=N I=l and I l=k>=N l=W and l I=l or I l=928859 o=I and l I=13798450 o=o or I end else k=p(12779)W=p(12585)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12012)k=N[y]o=I==k o=o and 13279514 or 15707944 end end else if o<15076514 then if o<15074250 then if o<15072524 then o=l N=W o=15820569 else Z=p(12281)k=p(12822)Z=C[Z]Z=Z(C,k)o=9053538 I=Z end else o=u[p(12386)]I={}end else if o<15085117 then if o<15078483 then C=k o=N o=15104 else o=u[p(12138)]I={}end else I=p(12723)o=u[I]k=z[r[1]]N={o(k)}I=N[1]k=I Z=N[3]C=N[2]o=9930241 end end end end end else if o<15349823 then if o<15241626 then if o<15201641 then if o<15164083 then if o<15114756 then if o<15101111 then I=z[r[1]]k=z[C]o=I[k]k=nil I=p(12609)I=o[I]I=I(o)o=z[r[1]]I=z[C]o[I]=k o=4089702 else W=p(12744)o=z[r[1]]Y=p(12821)m=p(12104)a=80 Z=p(12264)g=16 k=z[r[2]]N=p(12155)X=p(12626)l=60 M=255 V=p(12709)y=z[r[2]]D=.3 Q=u[m]m=p(12720)t=p(12684)P=Q[m]m=255 R=255 Q=P(m,M,R)C={[Z]=k,[N]=y,[W]=l;[Y]=a;[X]=g;[V]=D,[t]=Q}I=o(C)o=u[p(12759)]I={}end else if o<15132854 then o=u[p(12707)]C=nil I={}Z=nil else o=u[p(12614)]C=nil I={}end end else if o<15191019 then if o<15181173 then k=z[r[8]]o=k and 14932694 or 5381746 else I={I}o=u[p(12730)]end else o=u[p(12852)]I={}end end else if o<15231289 then if o<15218927 then if o<15210689 then I=p(12723)o=u[I]k=z[r[1]]N={o(k)}C=N[2]I=N[1]Z=N[3]k=I o=14058253 else N=z[r[2]]o=676882 k=N end else I=z[r[3]]C=p(12786)C=I[C]C=C(I)I=nil z[r[3]]=I o=12287834 end else if o<15236546 then if o<15234891 then Z=z[r[1]]k=p(12830)C=Z[k]o=C and 10023058 or 7449725 I=C else o=I and 12332607 or 6385332 end else k,y=C(Z,k)o=k and 2460311 or 6902637 end end end else if o<15288120 then if o<15282764 then if o<15279547 then if o<15255628 then I={}o=u[p(12666)]else k=nil o=8676261 end else I=z[r[1]]C=p(12547)o=I[C]C=0 I=p(12786)I=o[I]I=I(o,C)o=8089525 end else if o<15285841 then if o<15284462 then v=z[r[4]]o=617816 q=p(12683)n=v[q]v=p(12365)v=n[v]v=v(n)I=v else R=p(12689)M=u[R]l=nil R=p(12539)Q=c(Q)o=M[R]R=J(4958596,{X})Z=nil t=c(t)M=p(12573)M=o[M]M=M(o,R)M=z[C]I={}a=c(a)R=p(12768)o=M[R]D=c(D)M=p(12573)k=c(k)P=c(P)M=o[M]R=S(5757503,{r[4];g})M=M(o,R)M=z[C]R=p(12540)W=nil o=M[R]R=S(12940717,{r[4],N,g;V})M=p(12573)M=o[M]Y=c(Y)M=M(o,R)M=z[N]y=c(y)R=p(12768)o=M[R]R=B(5318191,{r[4];g})M=p(12573)M=o[M]M=M(o,R)R=p(12540)M=z[N]X=c(X)N=c(N)m=c(m)o=M[R]M=p(12573)M=o[M]R=U(9164832,{r[4],g,V;C})C=c(C)M=M(o,R)o=u[p(12763)]V=c(V)g=c(g)end else I={}o=u[p(12202)]end end else if o<15318269 then if o<15301444 then if o<15293417 then C=nil I={}o=u[p(12781)]Z=nil else o=p(12609)o=D[o]o=o(D)o=nil D=o o=9396756 end else i,py=F(H,i)o=i and 9026034 or 10480851 end else if o<15340851 then if o<15333006 then W=p(12627)o=z[r[3]]I=o(W)W=I o=W and 14760510 or 12998673 I=W else o=z[r[5]]I=o()o=10943395 end else k=z[r[1]]N=p(12742)Z=k[N]k=p(12622)C=Z[k]o=4634155 I=C end end end end else if o<15523668 then if o<15412896 then if o<15389599 then if o<15360952 then if o<15355845 then o=I and 14885132 or 10364925 else I=p(12786)o=z[r[2]]I=o[I]I=I(o)o=9019068 end else if o<15373598 then N=z[r[6]]y=N()N=false z[r[2]]=N y=z[r[7]]o=y and 5877337 or 12113221 else o=z[r[1]]I={o}o=u[p(12840)]end end else if o<15398511 then if o<15397409 then o=I and 3214815 or 900421 else k=p(12822)Z=e()z[Z]=I I=p(12356)o=z[Z]I=o[I]I=I(o,k)k=e()z[k]=I o=z[C]I=p(12588)N=z[Z]o[I]=N o=z[C]N=z[k]I=p(12407)o[I]=N o=z[Z]N=p(12280)I=p(12281)I=o[I]I=I(o,N)N=e()z[N]=I o=z[N]o=o and 8392525 or 13939516 end else o=u[p(12242)]I={}Z=nil C=nil end end else if o<15514759 then if o<15494394 then if o<15446306 then I=true o=true z[r[1]]=o z[r[2]]=I o=u[p(12682)]I={}else o=Z o=9784201 I=C end else o=I and 5446007 or 13587473 end else if o<15520180 then if o<15519042 then I=p(12575)C=x[1]N=p(12432)y=p(12083)k=p(12120)k=C[k]k=k(C,N,y)N=p(12773)N=k[N]y=p(12255)N=N(k,y)k=p(12749)Z=N..k o=I..Z I={o}o=u[p(12718)]else C=nil o=13587473 z[r[5]]=I end else o=336783 end end end else if o<15583812 then if o<15559220 then if o<15555425 then if o<15545085 then o=I and 10661289 or 4150827 else Z=z[r[1]]k=p(12830)C=Z[k]o=C and 5872031 or 1529440 I=C end else C=p(12719)I=u[C]C=p(12392)o=I[C]C=z[r[1]]I=o(C)o=9467858 end else if o<15571811 then if o<15563251 then Z=p(12547)I=z[r[1]]o=I[Z]o=o and 12334403 or 7296560 else o=a g=p(12281)V=p(12169)g=C[g]g=g(C,V)X=o o=g and 4231535 or 12192271 a=g end else W=p(12409)y=u[W]W=p(12810)N=y[W]o=4503471 W=p(12755)y=N(W,Z)I=y end end else if o<15608268 then if o<15601042 then if o<15588878 then I={}o=u[p(12094)]C=nil else F=p(12368)f=u[F]py={f(q)}H=py[2]i=py[3]F=py[1]o=13319929 end else m=p(12409)Q=u[m]R=p(12282)m=p(12810)o=Q[m]n=p(12321)m=p(12488)Q=o(m)M=z[C]o=p(12628)m=M[R]Q[o]=m m=false o=p(12442)q=.45 M=p(12356)i=p(12585)R=p(12075)Q[o]=m o=p(12350)m=z[r[1]]M=m[M]M=M(m,R)Q[o]=M M=p(12409)m=u[M]M=p(12810)o=m[M]M=p(12475)F=0 m=o(M)o=p(12551)M=1 m[o]=M M=Q o=p(12350)m[o]=M R=u[n]o=p(12216)n=p(12810)M=R[n]v=.5 n=.5 R=M(n,v)H=350 n=p(12699)f=0 m[o]=R o=p(12801)R=u[n]n=p(12810)M=R[n]v=0 n=.5 R=M(n,v,q,f)m[o]=R o=p(12411)n=p(12699)v=250 q=0 R=u[n]n=p(12810)M=R[n]n=0 f=250 R=M(n,v,q,f)m[o]=R n=p(12590)R=z[C]o=p(12661)M=R[n]m[o]=M R=p(12454)M=p(12689)o=u[M]M=p(12394)f=350 q=p(12699)M=o[M]M=M(o,R)v=u[q]q=p(12810)R=p(12411)n=v[q]q=0 v=n(q,f,F,H)o={[R]=v}v=p(12278)n=u[v]R=o v=p(12810)o=n[v]H=p(12585)v=.5 F=u[H]H=p(12116)f=F[H]F=p(12377)q=f[F]H=u[i]i=p(12308)F=H[i]H=p(12726)f=F[H]n=o(v,q,f)F=O(12842116,{l;g;Z})q=Q o=p(12245)o=M[o]v=p(12346)o=o(M,m,n,R)v=o[v]v=v(o)v=p(12022)o=z[C]o[v]=q o=z[C]v=p(12315)q=m o[v]=q q=p(12719)v=u[q]q=p(12783)o=v[q]q=1 v=o(q)v=z[C]q=p(12144)o=v[q]q=z[k]f=z[Z]v=o(q,f,F)q=p(12719)v=u[q]q=p(12783)o=v[q]q=.5 v=o(q)v=z[C]q=p(12315)o=v[q]o=o and 15943623 or 4418458 end else if o<15642290 then if o<15627514 then o=I and 12529521 or 9549860 else l=nil o=5544655 W=nil end else m=p(12111)Q=g[m]m=0 P=Q>m o=7503427 D=P end end end end end end else if o<16158735 then if o<15900868 then if o<15803113 then if o<15739043 then if o<15707202 then if o<15677603 then if o<15660648 then N=o W=z[r[3]]y=not W o=y and 6533369 or 466342 k=y else o=I and 13947596 or 13033508 end else if o<15693731 then y,W=k(N,y)o=y and 12578204 or 15521383 else o=400 z[r[1]]=o I={}o=u[p(12307)]end end else if o<15729778 then if o<15715266 then k=p(12779)W=p(12585)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12336)k=N[y]o=I==k o=o and 14586985 or 4523737 else o=z[r[1]]I=p(12369)N=p(12369)k=u[N]y=p(12369)N=p(12810)Z=k[N]a=p(12489)W=0 N=z[r[2]]k=Z(N)N=u[y]y=p(12630)Z=N[y]y=0 Y=u[a]a=p(12065)l=Y[a]a=z[r[3]]Y={l(a)}N=Z(y,W,s(Y))C=k*N o[I]=C C=z[r[4]]I=C o=C and 16405528 or 15540597 end else m=R o=n o=R and 543324 or 5261219 end end else if o<15777733 then if o<15749149 then if o<15741600 then o=z[r[4]]I=o(C)o=2703492 else o=u[p(12788)]I=z[r[2]]I={I}end else o=u[p(12151)]I={}end else if o<15795986 then if o<15782019 then N=z[r[2]]y=p(12252)k=N[y]y=p(12280)Z=o N=p(12855)N=k[N]N=N(k,y)C=N o=N and 14928251 or 13823429 else o=u[p(12378)]I={}end else t=o o=g and 15649868 or 7503427 D=g end end end else if o<15847208 then if o<15820557 then if o<15818374 then if o<15815454 then o=I and 12918822 or 6352224 else y=p(12369)C=x[1]N=u[y]Z=x[2]l=p(12002)y=p(12810)k=N[y]a=p(12489)W=u[l]l=p(12059)y=W[l]N=k(y,C)W=p(12369)y=u[W]W=p(12630)k=y[W]Y=u[a]a=p(12065)l=Y[a]Y=l(Z)W=0 l=0 y=k(W,Y,l)I=N*y k=p(12152)o=I[k]I={o}o=u[p(12837)]end else o=12936501 g=nil end else if o<15842103 then if o<15828752 then Z=N o=y o=N and 8919117 or 4141289 else o=V and 1301566 or 4649275 end else o=nil I={o}o=u[p(12430)]end end else if o<15877789 then if o<15872422 then if o<15852424 then o=z[r[1]]o=o and 72831 or 9802922 else Z=z[r[1]]C=not Z I=C o=C and 5729569 or 12461109 end else y=p(12153)Y=p(12585)N=C[y]l=u[Y]Y=p(12153)W=l[Y]l=p(12671)y=W[l]k=N==y I=k o=k and 3966693 or 7077489 end else if o<15899487 then if o<15891972 then y=z[r[8]]Y=z[r[9]]a=z[r[5]]l=Y[a]Y=false W=y(l,Y)a=p(12407)z[r[7]]=W X=p(12731)y=z[r[10]]g=z[r[5]]Y={[a]=Z;[X]=g}l=y(Y)y=z[r[7]]o=y and 12937659 or 16266641 else o=I and 12728923 or 12740279 end else t=p(12060)V=o D=u[t]o=D and 13583300 or 7675736 g=D end end end end else if o<16080127 then if o<16024193 then if o<15953177 then if o<15936283 then if o<15915969 then o=k N=.8 y=1 k=nil I=p(12346)I=o[I]I=I(o,C,Z,k,N,y)o=z[r[1]]y=o k=o C=p(12302)W=z[r[2]]o=W and 1497938 or 14758888 N=W else W=p(12585)k=p(12779)I=C[k]y=u[W]W=p(12779)N=y[W]y=p(12012)k=N[y]o=I==k o=o and 1351958 or 14302543 end else if o<15951178 then F=p(12699)f=u[F]H=250 F=p(12810)b=p(12585)q=f[F]v=p(12411)py=250 F=0 i=0 f=q(F,H,i,py)F=1 q=p(12632)o={[v]=f;[q]=F}v=o f=p(12278)q=u[f]f=p(12810)o=q[f]f=.3 py=p(12585)i=u[py]py=p(12116)H=i[py]i=p(12377)F=H[i]py=u[b]b=p(12308)i=py[b]py=p(12726)H=i[py]q=o(f,F,H)f=p(12689)o=u[f]F=p(12454)f=p(12394)f=o[f]f=f(o,F)H=z[C]i=p(12315)o=p(12245)o=f[o]F=H[i]o=o(f,F,q,v)f=o o=p(12346)v=nil o=f[o]o=o(f)F=p(12787)q=nil o=f[F]f=nil F=p(12365)F=o[F]F=F(o)o=4418458 else k=p(12786)Z=z[r[5]]k=Z[k]o=14495562 k=k(Z)Z=nil z[r[5]]=Z end end else if o<15993927 then if o<15963166 then o=10820724 X=p(12583)a=u[X]I=a else Q=p(12489)o=12321434 P=u[Q]Q=p(12794)t=P[Q]m=p(12012)Q=Y[m]P=t(Q)Q=p(12012)t=a[Q]D=P<t g=D end else Y=p(12801)o=z[r[2]]X=nil y=nil l=Z[Y]Y=p(12348)I=o(l)o=z[r[3]]k=nil a=nil N=nil l=p(12850)W=nil I=o(C,l,Y,a,X)o=3751785 end end else if o<16050738 then if o<16048026 then if o<16045667 then I={}o=u[p(12200)]else o=6377126 end else o=0 I=nil z[r[1]]=o z[r[2]]=I o=u[p(12509)]I={}end else if o<16064797 then if o<16057152 then o=u[p(12660)]C=nil Y=p(12719)l=u[Y]Y=p(12668)N=l[Y]Y=S(533669,{r[14],Z,r[5]})l=N(Y)Z=c(Z)I={}else py=nil f=nil o=3877213 end else o=Y o=I and 16372636 or 7465918 end end end else if o<16125227 then if o<16097223 then if o<16086082 then if o<16085505 then o=p(12530)o=M[o]o=o(M)o=6498252 else o=u[p(12401)]I={}end else I={}o=u[p(12690)]end else if o<16112719 then if o<16098946 then k=7 N=k k=1 I=1 y=k k=0 o=15034608 W=y<k k=I-y else Z=z[r[1]]C=not Z I=C o=C and 12465175 or 3364854 end else Z=z[r[2]]o=16153468 k=p(12683)C=Z[k]Z=p(12365)Z=C[Z]Z=Z(C)I=Z end end else if o<16138798 then if o<16138035 then if o<16131191 then o=p(12281)I=p(12822)o=C[o]o=o(C,I)Z=e()z[Z]=o I=z[Z]o=not I o=o and 1660235 or 4008432 else o=z[r[1]]o=o and 10157313 or 16463870 end else W=p(12547)o=14870124 y=z[r[1]]N=y[W]y=p(12622)k=N[y]I=k end else if o<16148099 then if o<16147084 then Z=false o=false C=p(12663)z[r[2]]=o I=z[r[3]]I[C]=Z Z=p(12252)C=z[r[4]]I=C[Z]C=I I=not C o=I and 5056648 or 8251088 else o=I and 1429843 or 5722280 end else C=I I=p(12822)o=p(12356)o=C[o]o=o(C,I)W=z[r[3]]l=p(12444)N=o y=W[l]Z=o o=y and 10396687 or 4718382 k=y end end end end end else if o<16418495 then if o<16253398 then if o<16202987 then if o<16188694 then if o<16171936 then if o<16166520 then y=k l=p(12328)o=u[l]l=p(12281)l=o[l]l=l(o,W)o=l and 11065565 or 10718255 else W=z[r[4]]y=not W o=10725692 k=y end else if o<16174168 then Z=p(12822)I=p(12281)I=C[I]I=I(C,Z)Z=e()z[Z]=I k=z[Z]I=not k o=I and 6201734 or 429835 else l=p(12555)N=p(12315)I=p(12199)C=false Y=p(12590)Z=p(12022)y=nil W=p(12282)a=p(12621)k=nil o={[I]=C,[Z]=k,[N]=y;[W]=l,[Y]=a}C=e()z[C]=o I=p(12144)Z=U(13983923,{r[1];r[2],r[3]})k=p(12313)o=z[C]o[I]=Z N=d(6513213,{r[5],C})o=z[r[4]]Z=p(12752)C=c(C)I=o(Z,k,N)I={}o=u[p(12545)]end end else if o<16200201 then if o<16198369 then t=p(12483)Q=p(12801)D=u[t]t=p(12828)o=D[t]P=g[Q]t={a;P}D=o(k,t)o=12584962 else o=u[p(12619)]I={}end else V=p(12495)g=u[V]V=g()o=7493438 g=p(12538)D=Z V[g]=D end end else if o<16214510 then if o<16205661 then if o<16204549 then o=z[r[5]]I=o()o=12184091 else l=nil o=12520123 W=nil end else y=p(12124)N=u[y]y=N(Z)o=12176526 N=p(12021)k=y~=N I=k end else if o<16223791 then if o<16218181 then Z=p(12822)I=p(12281)I=C[I]I=I(C,Z)Z=I I=not Z o=I and 12008566 or 13865511 else o=false z[r[1]]=o I=z[r[2]]C=I()I=z[r[3]]o=I and 15229822 or 12287834 end else o=6152094 z[r[1]]=I end end end else if o<16336511 then if o<16284771 then if o<16274026 then if o<16258240 then Y=p(12409)I=u[Y]Y=p(12810)o=I[Y]Y=p(12343)I=o(Y)Y=I o=p(12628)I=p(12087)l=nil Y[o]=I a=1165 I=false o=p(12405)Y[o]=I o=p(12095)o=Y[o]X=p(12318)I=p(12836)o=o(Y,I,a)I=p(11996)o=p(12636)Y[o]=I I=p(12238)o=Y[I]I=p(12573)I=o[I]a=B(29517,{k,W})I=I(o,a)C=nil I=p(12088)a=O(1153783,{k})o=Y[I]I=p(12573)I=o[I]I=I(o,a)I=p(12531)o=Y[I]I=p(12573)a=B(13908668,{k;Z})I=o[I]Z=c(Z)I=I(o,a)y=c(y)o=p(12350)a=z[r[3]]W=c(W)N=c(N)I=a[X]Y[o]=I o=u[p(12758)]k=c(k)I={}Y=nil else y=true z[r[2]]=y a=z[r[1]]Y=o o=a and 9287800 or 457163 l=a end else o=true z[r[1]]=o o=u[p(12789)]I={}end else if o<16329250 then if o<16296211 then C=z[r[2]]o=15394835 I=C else o=z[r[2]]o=o and 15357273 or 9019068 end else o=z[r[2]]Z=true I=o(C,Z)o=582324 end end else if o<16374557 then if o<16349091 then if o<16346576 then W=o Y=z[r[5]]l=not Y o=l and 1891401 or 840107 y=l else X=nil g=p(12034)a=p(12670)M=p(12500)V=nil Q=p(12147)o=3906897 D=p(12397)t=1 Y=p(12305)P=p(12252)N=z[r[12]]m=z[r[4]]R=0 l={[Y]=Z,[a]=X;[g]=V,[D]=t;[P]=C;[Q]=m,[M]=R}W=N(l)end else X=O(2181190,{a;l})Y=p(12080)I=u[Y]Y=I(X)o=7465918 end else if o<16400501 then if o<16399683 then g=p(12295)X=p(12041)X=W[X]o=14648013 X=X(W,g)Y=X else o=I and 8515446 or 7152526 end else Z=z[r[4]]k=p(12350)o=15540597 C=Z[k]I=C end end end end else if o<16643527 then if o<16576059 then if o<16547166 then if o<16517782 then if o<16487336 then I={}o=u[p(12107)]else k=p(12328)Z=p(12350)I=C[Z]Z=u[k]o=I==Z o=o and 10968553 or 7023835 end else P,Q=D(t,P)o=P and 16636833 or 9026128 end else if o<16571838 then if o<16560115 then o=p(12350)Z=p(12328)C=x[1]I=u[Z]C[o]=I o=p(12281)I=p(12596)Z=true o=C[o]o=o(C,I,Z)Z=o o=Z and 9792160 or 10452875 else N=Z W=1 o=y[W]l=p(12822)W=o o=p(12281)o=W[o]o=o(W,l)l=o o=l and 12402094 or 6894372 end else a=1 k=z[r[7]]W=z[r[8]]l=p(12012)y=W[l]W=false N=k(y,W)C=nil k=z[r[9]]N=p(12346)Y=p(12801)l=z[Z]W=l[Y]l=nil N=k[N]o=u[p(12623)]Y=.8 y=p(12019)N=N(k,y,W,l,Y,a)y=p(12719)N=u[y]y=p(12668)k=N[y]y=S(821993,{r[2],r[1];r[3];r[10],r[4]})N=k(y)I={}y=p(12719)N=u[y]y=p(12668)k=N[y]y=B(2722459,{r[2];r[1],r[7],r[8];r[9];Z})N=k(y)Z=c(Z)end end else if o<16630503 then if o<16626582 then if o<16585245 then y=e()l=p(12080)C=x o=true Y=O(11770827,{y})Z=e()N=e()k=p(12021)z[Z]=o I=u[k]k=p(12534)o=I[k]k=e()z[k]=o o=L(667383,{})z[N]=o o=false z[y]=o W=u[l]l=W(Y)I=l o=l and 11018049 or 8273476 else o=z[r[4]]I=o()o=13940619 end else o=z[r[2]]I=o()o=1873297 end else if o<16642460 then if o<16639047 then m=p(12281)V=P m=W[m]m=m(W,Q)o=m and 10369004 or 3100483 else C=z[r[2]]I=C o=13558364 end else o=9541837 f=p(12546)q=u[f]n=q end end end else if o<16725329 then if o<16655721 then if o<16653543 then if o<16645364 then C=I o=C and 2759719 or 10289638 else k=p(12547)Z=z[r[1]]C=Z[k]I=C o=C and 4411113 or 14323680 end else k=z[r[7]]a=1 l=p(12012)W=z[r[8]]y=W[l]W=false Y=p(12801)N=k(y,W)N=p(12346)k=z[r[9]]y=p(12019)l=z[Z]W=l[Y]Y=.8 N=k[N]l=nil N=N(k,y,W,l,Y,a)y=p(12719)o=u[p(12114)]I={}N=u[y]y=p(12668)C=nil k=N[y]y=B(5829867,{r[2];r[1],r[3],r[10];r[4]})N=k(y)y=p(12719)N=u[y]y=p(12668)k=N[y]y=B(13002105,{r[2];r[1],r[7];r[8],r[9],Z})N=k(y)Z=c(Z)end else if o<16713974 then if o<16680699 then o=a o=Y and 2111409 or 11351964 W=Y else o=X and 682704 or 2021881 end else I={}o=u[p(12562)]end end else if o<16759643 then if o<16744207 then if o<16734164 then k=p(12368)Y=p(12508)Z=u[k]W=z[r[3]]Y=W[Y]o=15692446 l={Y(W)}W={Z(s(l))}y=W[3]N=W[2]k=W[1]else C=I o=C and 12749911 or 7666236 end else o=p(12350)Z=p(12328)I=u[Z]C[o]=I I=p(12596)o=p(12281)Z=true o=C[o]o=o(C,I,Z)Z=o o=not Z o=o and 590688 or 393852 end else if o<16766228 then if o<16761689 then o=16694559 D=p(12475)g=z[a]V=p(12041)V=g[V]V=V(g,D)X=V else o=3688600 k=z[r[5]]N=k()end else C=e()z[C]=I o=z[C]o=o and 106381 or 9263650 end end end end end end end end end end end o=#G return s(I)end,function(u,p)local s=k(p)local x=function(x,r)return o(u,{x,r},p,s)end return x end,{},function(u,p)local s=k(p)local x=function()return o(u,{},p,s)end return x end,function(u)for p=1,#u,1 do C[u[p]]=C[u[p]]+1 end if x then local o=x(true)local s=G(o)s[p(12600)],s[p(12667)],s[p(12140)]=u,N,function()return 316242 end return o else return r({},{[p(12667)]=N,[p(12600)]=u;[p(12140)]=function()return 316242 end})end end,function(u,p)local s=k(p)local x=function(x,r,G,w,I,z,C,e)return o(u,{x,r;G,w,I;z;C;e},p,s)end return x end,function(u,p)local s=k(p)local x=function(x,r,G)return o(u,{x,r;G},p,s)end return x end,0 return(y(16577149,{}))(s(I))end)(getfenv and getfenv()or _ENV,unpack or table[p(12583)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
]=]
		OFFLINE_MODULES["Util/BloxFruitModule/Preload/Weebo.lua"] = [===[-- This file was protected using Luraph Obfuscator v15.0 [https://lura.ph/]

return setmetatable({[36]=table.create,[25]=buffer.create,R=function(C,K,D)local _,j,W,M,R,Y,e,x,r,v,U,F,q,z,o,i=4,6,64,4,14,4,16,3,3,8,8,8,256,2,32,2048;local Z,l,Q=i/2,0,0;local y=Q*256;l+=1;local p=C[34];Q=y+p(K,l-1);y=Q*256;l+=1;Q=y+p(K,l-1);y=Q*256;l+=1;Q=y+p(K,l-1);y=Q*256;l+=1;Q=y+p(K,l-1);y=Q*256;l+=1;Q=y+p(K,l-1);local d=4294967295;local function w(N)local A=0;for m=N,1,-1 do d/=2;d-=d%1;A*=2;if not(Q<d)then Q-=d;A+=1;end;if d<=16777215 then d*=256;m=Q*256;l+=1;Q=m+p(K,l-1);end;end;return A;end;local function N(A,m)local O,h=A[m],d/i;local S,n=(h-h%1)*O;if Q<S then d=S;h=(i-O)/o;O,n=O+(h-h%1),0;else d-=S;Q-=S;local i=O/o;O,n=O-(i-i%1),1;end;A[m]=O;if d<=16777215 then d*=256;O=Q*256;l+=1;Q=O+p(K,l-1);end;return n;end;local function K(o,i,l)local Q=1;for d=1,i,1 do Q=Q*2+N(o,Q);end;return Q-l;end;local function o(i,l,Q)local d,A=1,0;for m=0,Q-1,1 do local Q=N(i,l+d);d,A=d*2+Q,A+Q*C.X[m];end;return A;end;local function i(l,Q)local d=1;for A=7,0,-1 do local m=Q/C.X[A]%2;m-=m%1;A=N(l,d+m*256+256);local Q=d*2+A;if m~=A then d=Q;while d<256 do d=d*2+N(l,d);end;break;end;d=Q;end;return d%256;end;local l,Q,d,A=C[25](D),{[0]=0,0,0,0,1,2,3,4,5,6,4,5},7,C[36];y=A(d);for m=0,d,1 do local O=A(767,Z);O[0]=Z;y[m]=O;end;d=A(11,Z);d[0]=Z;local m=A(11,Z);m[0]=Z;local O=A(11,Z);O[0]=Z;local h=A(11,Z);h[0]=Z;local S=A(11,Z);S[0]=Z;local n=A(11,Z);n[0]=Z;local X=3;local b=A(X);for J=0,X,1 do local P=A(63,Z);P[0]=Z;b[J]=P;end;X=A(114,Z);X[0]=Z;local J=A(15,Z);J[0]=Z;local P,s={},A(7,Z);s[0]=Z;local L=A(7,Z);L[0]=Z;local k=A(255,Z);k[0]=Z;C:a(P,0,Z,Z,s,L,k);s,L={},A(7,Z);L[0]=Z;k=A(7,Z);k[0]=Z;local g=A(255,Z);g[0]=Z;C:a(s,0,Z,Z,L,k,g);local I,H,E,c,t,u,B,V,a,T=C[51],C[118],0,0,0,0,0,0,0,0;while V<D do if N(d,a)==0 then g=nil;if not B then Z=V-0;g=if Z==0 then 0 else(p(l,Z-1));else g=B;end;k=g/C.X[5];A,L=y[k-k%1];if a<7 then L=(K(A,8,256));else local D=V-E;L=(i(A,if D==0 then 0 else(p(l,D-1))));end;I(l,V,L);B,V,a=L,V+1,Q[a];else local D,i;if N(m,a)~=0 then if N(O,a)==0 then if N(n,a)==0 then i,a=1,if a<7 then 9 else 11;else i=D;end;else local Z;if N(h,a)==0 then Z=c;else if N(S,a)==0 then Z=t;else Z,u=u,t;end;t=c;end;E,i,c=Z,D,E;end;if not i then a=if a<7 then 8 else 11;local Z;repeat if N(s,1)==0 then Z=(K(s[3],x,U));break;elseif N(s,2)==0 then Z=U+K(s[4],r,F);break;end;Z=16+K(s[5],v,q);until true;i=z+Z;end;else local Z;repeat if N(P,1)==0 then Z=(K(P[3],x,U));break;elseif N(P,2)==0 then Z=U+K(P[4],r,F);break;end;Z=16+K(P[5],v,q);until true;D=z+Z;Z=D-z;local x=K(b[if _<=Z then 3 else Z],j,W);Z=nil;if x>=M then local _=x/2-1;_-=_%1;local j=x;x=(2+x%2)*C.X[_];Z=if j<R then x+o(X,x-j,_)else x+w(_-Y)*e+o(J,0,Y);else Z=x;end;x=a;a=if a<7 then 7 else 10;if Z>=V then a,T=x,1;break;end;E,i,c,t,u=Z,D,E,c,t;end;if i<=E+1 then H(l,V,l,V-E-1,i);B,V=nil,V+i;else for C=1,i,1 do D=p(l,V-E-1);I(l,V,D);B,V=D,V+1;end;end;end;end;K=T==1;return l;end,X={[0]=1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296},[97]=buffer.readu32,[76]=buffer.tostring,[59]=pcall,[51]=buffer.writeu8,H=function(C)local K,D,_,j,W,M,R,Y,e,x,r,v,U,F,q,z,o,i,Z,l,Q,y,p,d,w,N,A,m,O=C[93],C[24],C[23],C.M,C[10],C[97],C[34],C.R,C[76],C[59],C[94],C.l,C[37],C[64],C[31],C.u,0;while true do if o<=7 then if o<=3 then if o<=1 then if o<=0 then local h=K(D(C.J,5),C.p,C.k);local S,n,X=_(h),#h-1,5+0;h=0-X;o,i,Z,l,Q=6,{n+0,nil,h,X,i},0,{},S;else local h,S=i[5],K(D(C.U,5),C.p,C.k);local K,D,n=_(S),#S-1,5+0;o,i,Z,l,y=9,{n,0-n,h,nil,D+0},0,{},K;end;elseif o<=2 then y(Z,j..W(Q).." (does your environment support load/loadstring?)");o,Z=15,(Q(l));else local K=m+(p-O)*7225+(N-40)*85+(A-40)*1+(d-40)*52200625;l[w]=K;o,p=11,K;end;elseif o<=5 then if o<=4 then local K,D=M(Q,y),R(Q,y+4);local _=K+D*4294967296;local j=l[_];if not j then o,y,p,d=14,K,D,_;else o,y=13,j;end;else local K,D,_=i[3],Y(C,Q,150373),Y(C,y,114734);local C,j=x(r,e(D),v,nil);if C then o,i,Z,l,Q,y=10,K,j,_,j,U;else o,i,Z,l,Q,y=10,K,C,_,j,U;end;end;elseif o<=6 then local C,K,D=i[3],i[4],i[1];local _,j=C+K,K<=0;local C,K,W=not j,_>=D,_<=D;D=j and K or C and W;i[3]=_;if D then o,y=4,_;else o=1;end;else local C=p%256;local K=(p-C)/256;local D=K%256;K=(K-D)/256;local _=K%256;o,p,N,A,m,O=3,D,_,(K-_)/256,(C-40)*614125,40;end;elseif o<=11 then if o<=9 then if o<=8 then local C,K=M(y,p),R(y,p+4);local D=C+K*4294967296;local _=l[D];if not _ then o,p,d,w=7,C,K,D;else o,p=11,_;end;else local C,K,D=i[2],i[1],i[5];local _,j=C+K,K<=0;local K,W,M=not j,_>=D,_<=D;C=j and W or K and M;i[2]=_;if C then o,p=8,_;else o=5;end;end;elseif o<=10 then o=Z and 12 or 2;else F(y,Z,p);o,Z=9,Z+4;end;elseif o<=13 then if o<=12 then o,Z=2,q(Q)==z;else F(Q,Z,y);o,Z=6,Z+4;end;elseif o<=14 then local C=y%256;local K=(y-C)/256;local D=K%256;K=(K-D)/256;local _=K%256;o,y,w,N,A,m=16,D,_,(K-_)/256,(C-40)*614125,40;elseif o<=15 then return Z;else local C=A+(y-m)*7225+(w-40)*85+(N-40)*1+(p-40)*52200625;l[d]=C;o,y=13,C;end;end;end,J=[=[LPH+" '!&%}$~#1rF>XIXW=6yoXZ.YdOPuJ*,Psq3Yc:24),MXE[?DTZXrA_=pmr(r8q4VJgIDppe[,*e4o]HQ@YseKRxDr_b`4K^8tEFaZ;JPG)R*`]dNFneIR=aHL;Ry_S/*pZy1K3xLuz@]Z{D`O*wLJsVnNe<YIE0@h@@/R<O7V|S8H\xYQ0`qn]?lGn,BD-(8Rzw.YMut[NtE5+-[7^>YTgJxZ>Dz8Yq*|G]kRY(w]U,7<yQbkg+YQTE^e*HPRxwWXO?gZJ,(hCzEpi.)he/o-Hu?sKu;eMj;clVhN/y7M*2Tk`a\0=D3-kH`@h>3-R,yn`(>dH.::\0+XYrRsHy86]Bq9(^r(]Wa/x+g,C/[Canx=[irS2>qpw805?lR6NPp|3Z]sILKHbj[Z2eD`9*;tj1jcBzHOGwkT\-xlhz8xXpwFif/Tam{H1ldpo=;Hn7Y4,?ojnyR\VTMq):D0EkaP+N[`PBZm<epkx,c_1>[QEE.8_k1Y/)@B2MFdOIyRf1hq1p^2)|)9A>]4hxHO+VtO7DkekgVT\>J|==Sh/s<_S,7?K;S;4RjJO\DtLj(Lfrw|@cjLgp4bt*pXFEws[cU+-;uKGWFy_K2eL^0.jMfw]hc)gG7GqWi[_Z<oxd2>`I`:IX5Tw?h:KiZ9|d8n[k3iSZOu,5Bl08Vb]q\Yd78*0U+/kHWHit_-K[k^kw9/./c*_9Y[l<,ySe(n(VD3v1OY@C[6*,@2-7GtPR5Virg<\TP`aem>LciASvYfsW+q[e(nZ@{/ag?bOTdCVO6iab@5Zz<-0p\VX0\_(Z3Gs2xk3I7bVl476Fj_M=m1p4@eiupe445NpR?ts2JdcVKZwy.ELt?UV;Z6^kc4KWf44djO,p<Hq]xjUri(G;Vs=C7aj,E|>8Pcf.9zVcNI:hmKgq>G>tR*1aAl8Zl+FIg-]]j>otU;5c?TV,/=>7\dQb1.1aRg(VRB)C,k>EmkAbVvQ2J_7l1G0s?\vA>/E(Fp;uVD_kv,sJ[{bMm8`=^2IQy=RHr7EHQLHZ/rNWL<471)DO9\gB9U(CK+XJ*2(G0bdcQo+6IK*e=<3@,?sRz3?8[HjO?+,U+FN<FAE[.OuZ(qvaXco5ggjpOGe,)w=dPE`Bd|d<VTz9dZ6?]yBnhK06Yd/|72:A*Y9nrk@9r=dnH<@:\Lg)(ckZdY)kGy.=L=9GELkEJ<f?l-D[N+gbl;|(nzCDoGC/6-12i1IZ[P0ZM)JXUIMj)q]>hrDXoQAe]oz@nK<KQ_jl9wK_;J]dUeu6eSyBz0ZcbEN,Nj1*R;P*G_H0kn@nlTN;v+Srv,[)bO6Ro9Zhjwu4Uae@Vsk]*8NXYv(](ygOXiES:[^|W/?UGhG/YvApVZhM\^I1{?Y4;fMMJMH9L-Z9iOs;Y3g`Bt]shU>T+zRELB)N7^3{W8\@N9Iz*:3bqiZ2q{p,qadIaO@=DWI<uN6YgIAc)z,+,T-+M)CuF\iF:78b+8jv5tE:st*\\eAT36NHoD`U0MH+7nuAY):Jnq*-zlJSD]DAVOl:HZ/Rx2gELZ4FbFw9)r==JaMDLi4uSZ83jTrCdf|xnNv=t4Bhlv6iH-tuWG\oFhWPfm3<f?l2+bnyOUj|WinoZAs^G4P*@5\@94<\_gyc0+XeS.Rce:QNeNtB|e7g5\22|(beYpXHiD.:EfZsV0k1z2H/jpKa1b;4r7f[FEb*,W(vMGP5O)iFEwpIn*n(PEGQK6o5cG|<fu:,PuGBToAPtGII*.Bu\kf*y_+(YcWn=YuC3HS=V/>EAf*M3QQq;Dth799,[K*6H0cm9_^olvpX5GO:WoZQNnKq?EV/6uPvXYtSNhDw^mneNcPL.8bA^5Q061c,7kiefW3`1{@NNv`Cre3qjQ4bsPY:R;j07SqyeQlVe],,M`4h`m+4Qwzq/<>2sGnbbgg=L:<HtyulHPfuMMl2)Oz*+j84`1,KCHeLI_PT>=8@)Yw?G{0l)FHwX0TX0/=u)6u|-MGzt[|pa/5K5Qz4xJW14fw1=X0h1(4T@D>(gd@qS]u:+cK/4;Nw|D+exLPs_*M)beQzK6ia>_S@=g+48s0<4fu_9pgFru),3YCQyc>|?*j4ih[wMTeuZhijc/OrmwX]FsY`G,V*>09vQButS?cYaB>oJr^m8g[bV3cc4CzY\]g|HP_WH:0zEjwN.Zrknq)@nimgCy3L>2QOV6t]5a2L-NZ-JojM*bg|p0y5OYl`)?D1malboEjIGyL391fX8Dn]@P.Kc-|gs8C?Yb\-EG.JE?c15YJNeoY\Op4rT4,0;CA)>ct[T)S.rskVv*auMrZa`>E0z(I+@ZmfQmK1LXsAed>l/-@i)*.U=DGIKdk^[*X5wk^TaqJK]U])6iq51)i4.*^VbRP6b1vxK*l{Iz<5/?0h@0^X^(eM|]{OYL=bEs?*c\dCS>FsPn+;4A|.]9rvFWOUc_e34:cKp(ANlbx2fBi[Cuh1DEeA:2Kj1@KJa7nvHBvvTB4,OvtW-*TB+iPc.L{6L6;HECRuVl-CY.<Bf/oBCiyA0I]vfJ4?;AShNcj;]lY),B6)LwPgva02p0N5:S6*jdsoh?pH4_iB9(vY-:5<vymYD@S?@Bf@E_St+P8ABn.*pF(vm,d{kpqJ:5x7aMGv+x>;mEZQA2c;CnKp8L@AtPLN=J2I2WqQV@x.-zH\oTjTUS)CCHfs82Auhh@q[M]`ngT7]d(DOKkYYyxQ@9HX+iHv;M_\QGg4r8{zPl`VW9=Kz8JcvoM7\j:Gedspof8GPiy;7CB+_-pifLdM,@W=y/|HoCj+Y`_oYThY>Lp<[.U6>Pds6-s,o>;n=+x,,ik5,i?Ksk[1:nc-3Gw7\Zfv^JJ0:)\0DgWNc]iyEv>8XT]/W<nR9C:M[`7oGIkukzUWo<KttHu,D97L;4j.0_YsauL(0)^63yFOsqTO6\6n@`mz^`SQgQm`:RId0^]wVq@=)0u`?jda_cIF;je^^`=2;_gF@-W30OMhNErVh,]a,H43-IkzuD4DSPrnv5D,HbVAG+5i:<8Mh6@RcX+i`0UK4TudUjnEkfw0Q-A|19\=>(JVCqFLNq,sb)o:Oox[Yj]?@,p_[je>B6ol8J1fN\TVs;=N[0M*r^/[,SVe:IRi.{Hw@NH]:X8B?_\2p{8sEKfRc_ag+Af1rSpR]ei{Xvx+zX/md_G;|A:zxcpkMJ`c6w-<6>+:Qo;9)5k@b>?XKZRZQ*5dX=ihGUTZG@B_=v>l=@?ED)91tD:x0Y32Z+@iDzV?t@/nwZ,t0Msk):qIkT4M?l7Xlq9LXqOqE2[:a{,({^hm3E?7@T9f_+-j,I\nYs[;JT7GZY=tw7_k3{rb3==8Dw`-A62a/j2{mxoE<;A7)FqDQhQyAX0wbCV=.Y?enMj(N^XE=0P1Bl?5Me>{F4+^YUChVc*IcE-5t8WW.;iL5b5t:VsK07[0HP6,(VzA;e;R4D*[PxXN`TIl_pwSov+\.ftPSYj?wb^jl5h(ToPP0-[nb=54cl[ig*Ja+)0@x(Wvpcunbn{Wz{CNN0Q_ynFxtH\?Uws9\HbR/?b96MAis<2_dv`g<PBQ2j^A9Ru2iw|bLwLd,MgMRPl6o:j6unp7hl:,IT?U.soY5\PVPZ55ix5@+`?mz@dQU7*_s]8L:L]<svhEiY@We7vzoH_|O[EZjJqou||8VI2?QIkku+B/-FBcalmQ@5]kDBl|7g4m(.g2H/1A:gHPWT2`dEdHc<kHY<dqV\KK7.*EULTbcp?RX;6(ooj{Y.m,DV,EVx:44-CY78/2N0o\ipbX6(V][J|`,O^teoJ[:;1JaM>iVG8bNEaT^YnbavbI87ZL.=dTLOqahAhCfE.qCZd-`x:3-QvW.dHI_daiX5mW|2F(D0x2fq)sjsxq,uP30sHb{c6|\WpNF:qDX<m]?UN=8=^RYiAKt]Ez`fRaNka3fpfU()>c<rgut\SK{MxuD_rb2\yn4JlL=ItmkHW((5|/6ycQ0AdV@>>pOj:lryy^Bmm;,AW2:[IG93<e@{>9hvs<rq0w*6@/UDVvwF{rX<,7K5Ax_N:>|`JAHBnwrGG/TaVHpdRUe4hVI3(*fz\=4,8{kFsKh_YXN+s/H4U_<[D3|b5>BLXvvnEzU2T_x`+l4-P_W9yVFJ2rSg`R?Y\*HwWUh]cuvl]?ZaD@ND-^TtgQrE]jHWXaN/)^_.-qtzNT4PI)m/-dQe4b{W>BQ1GBd6l1bESuTt|SF1j\-ij=LEIdt|O1*a>Zu`M+0\<NQat`7y)P*^:\+eY8)E9r1XTwLH]^8xq.*GWN[Wk]@Ka]\qlmp^h27eP5R>(R:Q|nb;q)vQH<4cyASfY:1wXlkPlk=;8hhc[;_uUZkB/f@_P4cy/rzFet{.W>;HOH0s>7_tKAd_<a+l?R,mdlIrxxS?blzGVmb.fyTuqI1C+96IAI.^7/;cu5.PR-McN0aK1A7\F.]2F,N(h4tqC1d?DLEt+\ax*hZzj^Vsaqr:]e@Fa9BJrDUDDuAFeM-{J5R6J:wEaJke9E4(Y1zLN-0MzHwgByd44l9ALf`\8qWisAVI5WLy?.15wvr|?Nt[rjy+)J6RJw]dSsysXhswkmLGyv<h[E^cLnA{F?;ar+qYt)FJR+Y`.q@lyv/\yD9]3uoLL2B751MBdb6?J<O-4RhssN)a?qBab_TNhQL@uzeoR^<FzcMGrh]EigXIA4w8so.{g[7QwZhJ:7yfLTPrK_v14[0Xk,d8U2_3_@lKX6kNTk,GanZH;[c0.Jy<E=)K::k[jy>,i=Kkwb*z^qqYk/f=ot3bOIqtoDQhK:U?zf522F^9yE<O8(z.-y)I=H^yv-Lgxk2n8raD.)/nW75V|p19)bL\OX3\aWk5@2_9qogpsH.dY<7.Q_/(>mfFs-xQnW-9Jko-E99G)nl0ge2[R<hpZ>Lo(yVm<Z4;Cjm:]?1gx._Q]T=,8|A8NT>0=f1u1//8?qn7Vqei?:z4^)K6JIVRO[PzuR(8N]zU?EozI,sFn3hIvnL1`2*f8dxPvdytzBK2]y2vG0@.Jg0OZbl6M+eMhB*Y,?r0rGcRQA9:JFl-0e2;<Pu+50q5ps5tS3M*ab>7vW5oh;5dp^<cF9UeGQ?N1r.fCv_JGB]X|RKEDGvl->HS)Hc/WLNwZUv\IN0P_ab4;CN64|3o3Vs2y=jZ<4G\6[1`,dh1[:klUJKe0>2s@A.^J38>mzPDmRPZ[3N_sIXf9oOE9Ep-gf*|]>UF.S2p,evaHx]?1X92a5t7VqJc;6]=9sO=Dm5y1mS4gHOu=01y^H,Bh-;jd4oFe(51)]KNFmkp,TFVs/X-zJ,d8fPWK:,N(?nNLEb^Ljvz:fh5IFi\S,.;y?9Vl-b?K(oQKzT7cfyYY8?^/G|rB5Z:5:>i(mbjNMa[9*ZGiWB0nG^J`G4HXY\ATL[GIZ5vEL/sefAy_J@_49k<1vQAEvy`Yun.{-A[)2,[0]m5>QQx,h(w(u;F_s@LKwn1Y);=bEszMb+w(WImi\;Y;1_<)gRh4,wLI9?g;>8li)S1d(xv1X2A*FYEC<xTpxSJtWefDU]1S@F:qQBu*Bs(TPy]r0f\`)`KTo0^I-n|+M5*ut<@I9^DAan=mFfUqdZsw;EuD?`rD^uY/BR/W-)RM,ZWe3aM=Qiinye^>[`1:,Tz?>\@r;Bv{r-r-pxJYlkDO4`z1ohblF*j[Vt8R{9Ou>\|^E8[n\9|2H=cioWFe0xLd5=qE)BdEj:@d6QU[-2NtFcJ?tFz2N7MjCIk.iVQ_836mn@s?BJ/tsRt4abK\rmdxHRlXHa,9@EImxTX`TZGEXWh]DaS6l,1mx2Zm8v_Q4uN[qw3L26ANlvw(ia|W21W+43p0JWWL?WI[f?nGQ6h]WP>6-gAYQW6Qrp7;tBxX<n5][X;oWC[bMk|]?JJYMdKwcETCgGW]`9FiF_e[|uEeS+T8O,LDjon|(qmK1g/hS(jpU\:ccJ>xgwGtAGnPYos:|@\m\>q{D:B7)1HEw5IKEq*SgdPb[4?wRU:Ft.S.4lDpfR9YnY/BHyz6K;CiF=e4jI=e[gjXhF,92`Nd)<>0|X7Iq{*,DWPOr<sBeVwxzps?VbQ1{V>?\[Mq=bQU_l>gbq*VR(/xr]=P`OLbDqq,Bbw)`jVotfao^9^q-V^Oo(Y6JCK=V/.v.M|l6lQyaM93SPp:jub6s{9(z.|Ak27LlY/U1(6i,LCwv+FIFDP.M8<)VgzBfyUTY/:4lHmSPc[,/HbQx2-_EB]ObPD1W=h0qQjZj7V9i9Ur]\DdzKXDtjU1T<yq0ThmlQk`?KZ|V5JctIgjRugRvA?uPxY4VGdpQ=\Q:HEnUlZjDbE=Ng`@R-JW`Zu1`RwhvP0lC,ns,KdeY@N]/kDcsw,4PRp[=dPrsCBS_Osth-Ven-S`usOFg?bE0DF0CB^znnyCJEqaj/r9iW5D<IzDzRor-cWEPXP/+<7:lDT/QMjab`_c7=TZ(B0GMT4ZV)[JLC9\*1|rC.oDU55XnwIi.)l<=d-B8VElK4c+NBqSZlhh3qsa/S9|)3m6StW.QmTeTHAb5E40B9pK4EvY.a/o{k_X=T7UjKqboOF2>=E-Nkm)R>/E.e)SBmf6/>E?0AkwWho=gHtfKdS3B@HQQdb^K(W`h(\nMA-ODGN@x,cEYouM;fk>+LpXlIe*Bg|QwI*Yt5^\rZK2@t=Tabda6q@MJsP;f)=L@QJxs]4)DdfZ-]_Y?9<homdkuG*NZd+8fpb85W?aBbc_m{@l-5=D7\X3KREJ1V[1clo,0Au4K5,a1M8?_`qdZJT06_ZpVZa(oVef@5JnuMo_EYF8<;<veo(0z]wp^AuN20aE=fvu,]0Nj+CKl1Cdv3qkH\@H\gVt3e/:WN>CcU(|C9/@7.5WM]6Jzdj)B).(LvFmw|R:lp/rmBi|^WK/|D[z{N);XzQUtkj4U{eki7zGSjJu.jNtx<.]a/w3SZSiI3_]tx_x[Nn,KEP9uDw?F.MAtt35mYvHH({e<M{u/O*mV|BudYTSy9,P)RdNqbd_hFZ]zg;n\gA3q*<ZuhYn2VD\WP:)+qtP>m23_)vN[3fC2BK3/|{Uy)O@(:ic;Vf;F@hft/*o/X+<oro[lw|BFiSvEhMYDdIn+hT{Xa?PKR@xsg(0g+otGl4/vHdf,QTx6,RrZ_bq[.s_Fa_FD=(mYmSd;euyP;[:v<QY9AHu+b4_tq/U_:V3Vns,JOMBunvn[U0Z*DrkNIL,{xruo(0]AVWaN\Ib=\FKbm/;xtR156<)1.uvf{i?9*4T3/Kk4]J/t48.aDO*M|v4PF{k8Lsze*6R[]FkxIYRfV;Z_QK/@0p4kW+oF(Sro)Ox(C[a4Q,u:?@d.y1FaFKx^QIibPW[<NIrc|I98O7y`Z)dEjA[wWs>7H\O]dN`_3B?Ma+j\@bqH.N,CV]>J1;2/iL=ePcC@t2E:kGc]3wy.Mk?bC5>Qfntjjb.k,jzYT0)Rp)z(tEU7i4*nJ<=`p]B{|z@,vz1TZpL@4,d{T5Zz\oNO.-glH,zfq5vNW5bkN]]zI/pMk<Dqa)YI*1fRGYy(h6gqhl<hjv0JYv10^89-A(D5o_r7F12nFuhlmc`]vVWYs|d.G[j[GJ{2t[*.B=^I1Sow]\ieypEk`i__3>[CC*i\[oJYh)KQZ4+|({R,56BkdB?klptD`1saW-OIu//briL6Tkk5LOWL.ob7XXA81M\w-IO*L17y1kKo{:6?x.c{RjSOntIHm@zsgp?K/602+GRR|Hxslk|3N]=7kzTQZef/DWZM.TAjBvdI(xkk@?2zYDpN=<2a[3|yI_:rEKV:O(J3gpz])a0X5\R6ofB-_NR)`?v/4T6x2ij0,H-thal3hcBxSp5y.nG;<v/.v?uu\QORWBs+ZuIE\CJN.a-b+5lGV(\wLn4WFCg`1>^xPS]>xywjacW/0\]m{ze<W942mzDuo>ZIZF:*?zN`{31`ei;J_|)vdK*@*[t4=,.8q@7chx:Yhsy406jP1ns+R1{AG8aYLBdVPVL0-o;53>q^AHJ<JG@H+yx92@fz,5{Zqsa;Ru_S_;hxk9oU-wft-{P0m9xCh`Ml-BsrJrkkAQlbc-f-cbd(vRk;M0ons`xkvE*oiZW@jY]RRg|Sr55]Q-dOQX_HF[Z>.i^>]N]{Cw|4o2YVX0Qe@KvVl>zV.[-jyu8zqonve1.^e;?f\JT:4+ZYF0qJU43,t8_dDLDc6+Td7YS;VjF:WK+*O7fbQu`2C|OeZ/`7INaecA2j?>M^)vWWl)@C\Ph*JU-2M0]i]D21Ko[HxMf+qv@o.tHeCs;O_l(pTn.dah7UH)SeD4k2Q-r6?>BQE-{z(F)N;(c8(TRuRFwGabwPcDpXN];3:-MkDQ4I3l@^_eq/zg5oSQ|4U*F?RE>DVp<uN8]4Bet,_8[pL?acg`-2RIG>(K4dg)Uf|?vS\JNI=Q{Jr[5SKrv@)o1MKdTS/v|92<1^R4fC]K\TVFe>xm4p=U@=1\XoQfRsZ1ucPCd`G39SFT:IuVf2*H`vM`,\)[t;TuX\W)LI0<CqYEm+ucR{jz(Q-cgoJB9ItdMqE(/9s,)Pcaj[NijkfZ[sf@_asYvkb)6SGEccP>Gl/{)Bc?ItkSsWCC]SR\99RUGbxY(lrVysX[rQXaXvDpj@A4BTt@131SKO|w\P{2JqG:fZ28_lO4@Gg{1tHLBdLs]MtVZBbL/pIH*+[xw]</z0862(h?]PemW\*>C.:O1:O]jMl2tf/w43Bv?-Ydi7|ZuZ)Xj`S/U``Eo)E.B[:=|V;oK57bJU]lKVSI,NXRf`8Ao+sBwz?`I*=+x;`\k@kcWHs,m/{{KNF)PSdv5@Hn3+A*?n7tBfwRP.A\pagS]C`Ma<OFU5IL3B0jM.p0H.OI[U@[LgRlj[gX8LaWM(RUuNX)dWMac<ax[X2c0?rIIjhY.7x?(X8jOTy0<__ky)U4|/]c,Uo4\@nFj1WU**fLM`ZaerQnyWF`mH|ZiE[4nEx`982+6,aeBK/V\J7tLOe{-`^W7r*Ey3_.oaiV`|.L{0<gG_;latS+\8Y;jm?*DVQTC382MKOQ>Ud/Gp/]CtTICwgpRd2qhU58MKAez;>Gm3s]kfRUggXZ(eF3KEh(6^KcmJ*I(\M(.1(Ek*f5a(JV+v-MZj5_I4y:C:onJSNGT*_kbo3Tp=wp).-M12?@w.X[B)QXK1qOaA],vQqH`+Vm:-\]FUllkM4Yh5UTPHX)16`<(nvPp^@15PW[;IvQWvtf1=kGd=+@BG^i:-B.8BDaZ,eWZYvZJo),d7^ZPMh0FT;GgmjlPpQx4X<tcLD`WOco^^hhp2_mfziE/twgRREc`PY(REI?thF;h(fwK/gQ(g02`2O*mt1`xTB>3WS._uNv@Y=1hf_{v0vunYxw_xv/vD8e*nihMivW[fERDFsRg>dG9;D4zDxkFOmLP4O[:pbpey:).^S:C8[e_+Ko4a*Y4U,x7-fckq3-<nqvU3p-(WS|VwTG,9-aHv{-N^obQxep):D5nqbV/|X69)SM(=Jl+-@ID+bba<^5fC<\jQkqR-]*D6gW=wY+wXV<ocHsLgc.LG`HjNt\PQT6?y^QPNIYpNMcuSkJx8vdV9Cp|v:w+H*BAZHiME\bReK.awWBd[lvGZ3hctI3@*35Os2,bQXhfey?|TT5]QAZI+2yLH\`tGvN*0BS6X4k7qp45?CZV/Vvk/;UapfhM95VP3bn|c>)(r<`x-{+O_(0gFtvsr(wR=++L]1pbcYEvkj_z3FpE54p-<PDD+s?rUln3Km^aH=:5I.8mH]ET)Zp;?x(aC0IQ1ppKsXQg-yT=;A+M4>ZixF_xQP<Up<^i`O,Q\wz(e2sS1e{[+]Y)W/kA,F^4w?[u8C]{>FXuXx6GVLKZ>|`Fyjf`A,z1vvDK_65^Wb/{M<{9j-VrYVVMl5kM{NE<EaN|o\O5PmfkYwudpfAFkrzw3NOHF]`?>oy3mZNWM6<dt\HhPPxBAkR.GoMl8x_.X_SWCzUyzU)vE=u_TuwH`(D`V-98fA7vmySj4e5(x6{BO6xjSUNao2kI+H7OX2yazi\21LT,)VTD3*RI>K@?DrwM.q>`ZarSqIWwyu]wX-fr@{w7?afjMTE5X?jIqzJae,G),f[,fHfx.-finWVInalnfYo\-Whm]l,kBUY06pSBHsRY+{),>=-nTV-O7_t(l]To=U9d.y7Rp@GajJ(1>+bkTe[,im2250@zh-s<gjg4nH4>mI*[?*rkw9DM`mwqb,@k,2OF\p,fFRSRvuk[]eTrbf:<dPTaE+f)+(/UX:zK:L<.H:UyTlxUBIjD*LkFbD4)5vpyFKRJO1x2v/qH,8{Bf.PPk;MVumk,o/A{]/3Z9,r(@z_5nEM1D8{AnT?TzZ*^U,Go6\O,9:)T*Rma<QC`pku87lb:T-kaGXG`.c[_A_]KdfAL3xifWju8Z>.9hNtZsQPyIu:drYG?*;bKVrsO0irDc6twkbmkZh`^A,edilCW)W9RGf.\JU6K5O2Ji1`ga2VaOIkq-.;QRxEP\bExNW\H@1tOlre=9aCFzN\F8::e-IqJ*9t[O{7*;6PzfeX1(sdHWJ5G;D*Y+@3(Y9Ft*F?kc+W,Q(N/_Tu?cP3u_FprL:f0BE1p2uwk^d<l]FdHx<PejzA.r5u,;hYd:+aec<j)U?cz|AU/S*/S075-zVJ<?cN<zEKeQB?(`=^f,Y6qm77(D*vk4NKjN`5bz{3]wSG3F]PonzP|dK_Aw`pyJ*hnya|JS,vO+=\+Wdno7/U/Q*jKBs=P-az<LT5e1(Tu*oWFZ7peK=[l=8`nqIOL>kWYyF2\,ivGjE,Cl29HDK/-YLk9TAA^IA*WCj\H7xGd^+CN_h_PSs1\,EaLgeY\G[1PD\=2J6cgtXqVJym1lFMNJE.WnIUbER|ek4Eh45C>OTCk6.,dA?S-*I3aEf)fmeJjP5xeed6ugYwJ[o^=^oYX-M3G{@>O(CZ.uR\[9uS7|6_K1:;pYDeh[[D9EFGHLfJoM*B@,mEP).CnPFj?)Wo|/Ze1Emr]ng5n=^]oY>T-2l->K1A0yK6JGn\{m;j+;xYGzVVd+]N;mP(S:/K,oTbx\),V6-/IqPIz^].j`NJ5+.Y`\Qj58O2*;f[>z>QD4x-8<cIF^))V.msjqemy/A^gA\aj]LQc*)9D\,lteM3SYDVsle1w<f`Ru8U3<AWy,E_^^mXx2G0v<ljj(*P(Sj<p)BBO/5nK2_mxnhbmi^X2Su1.uzOKw38ksuI7ht>7m^Ng>|S)LFUz:2f`jv85yk0y*Pb)-79Y=URlF1jfkY{y8DHvQ1/>qO]CLi4>/LlGknI<VQgp@S3*[;Al2WCb8L]NR)>ZR]L9s*D.*9wcScS3N<//@Mdb30U,:EkNbUw*Jk5WpDWz,AO623L7[[`_CIArFw[-g16{;=jOW948:;bJ9BuH3Md2W6:{Dqd[`qJ>E+k0,?{CfK{Msx3)YIVIW3AsvCv(|<R|B0Wi:i+L[L5W>Uhdl[0fDdJz8m2,.,xCrMs)Y(Qoj7NOb^zdJcjU)p>u0NRY:yY_*dw`{ubkI)h@lg@3XNQ^/W5q{*E6C|n)b<YNsMLFZp8b.R9X:6utRY|rqMJc<j?`]i_RHdsBR?,jlVWDs\Sszy6OXd@pd0=4(VRR,Y>yiKZ0IIFN|Weu7byF;[|C5NSaXWPxiidhQoi3\@_?Ai3;?vajhIH)eo7[U=,SkEDzIcvys8w+50(]B6?pJc*T_OUAtymI,w_f7pEB{.n|PEGkh<dcWdQWf{A1YT,X@V_fVP0;H0sP_P@k+=A:x.xIBc(2HyBOdYEG]G[ddS.(-TO8*nw]j2e?7yTl8AX^EL:bp:Em0twsS;wdrqmJ.i<j|,fyk-a3(w6b;5`uIvG2ZD/(RgT,eXrdO*h:bxe6UdvNh52<b5bXV.OGj`9KvDrNK\9AYPoOsW]<:.ma]|?<GpBw7-H@y=eJbk,Z=JhC;O@3O4|nv6z;[?Z]5n1wWhXSh4eT0zoudtd]{p+LLOxRsgftnxfy:G(AC2?if1ZpvJWa9R{]UJy|1ze@{Vo6XsbDhjc\iw|0o0XGZWH\klsY9)SE{)RSq9<zPTPs/=-E;pfnwAhbXntfBnx0BNy;KLFD@?.C3GV[f<cxVk>7k+)``RDkB[00[uWg>Yy\>Qk81BJhkYFcvNIvSFol.dj)`Ko:PVfaQ=c@zgZtoLw;?IGoFU2{+|HVHK0a3bS5xJY?l;M<D9rdyxwc*Ki>=kb1LNY7ra6aKx/AcX0O@DO\b@>eUhyZWWM/@6jW27XY`AWrRSj9@7ffUKmaXlpz7Q05Gu6L{j2fd4hiHCD+{|/GoaP`]+_2dP1z3]hVjr+W@Dfv.LhD>I^Y8JX]H*pB{Y/yW,QjYrf^U_72ydT6*HyhGX8YMl[+*n@Q=cl[dOuHL^sAeT`ZDQ0q?glq?tjK|4u0mK\Z^oa^0___v,WRR_na(@STlhc*1fe)llo3eqYn=h-|.<leXqA2oO7\K-@Xaaf3?AZ1l+uk7>5gfOk<msK43K(Occ5Jt)u1c;-F]3?dqACnTt`_CJ3xH:T((qMV,8TM5pr^7oM+{(v\+ZFJfajrvFF3[uCh{*^v8Zu,2CqjOTfM-r)FM8e2(bB7k(KOG|@dQN4=`z3m-=n_Lf+{VMYr|CLE_sX/wNmHY.D`.dICaJ+.^i9_e)x(f;6J:>J_0@c[f{fnXJ*x;>[[6GmQX.hvu^8Q]ZB{XlCrTqbrH4=B{4\zr`:K>6T\bOwT.L3.[nzx`*HRdMri`WX:x[PeXqE:_p`IWG/Q|wtc<ZYLyyTY`hr;wpx@BrZEoawkRsNV1tfrQy[q*kOn|o_hs`/FwYzz0oaik;3B]84MATAO_+7Da`fVjqMmf4cZ<Sr6W:-i|aTd^Yr2q7C;d+BZZR(-P/CItBgtZC_bek72`Ju(9?O|myj1OrA+RSf\xm[gJFOJQlG|pE0Ioa/b[o{(k)al*\g(G`d._`g<3(:9`<VSS]iJ1>5C@S.8\T7[b9;8a?l+>Q*sYfU^3L)gQJQ;9xP[l9R[)i\AlWt<+Azh)Qxgomyb,V0FKbUMZ(VLgXKXJ;r^yHDJm1?|lMuc95xD[TYS<{SHe,(W+s`QYw9uOWMp/zdg]F3b{l4l5=;3m.?Ddy3skS;eZr3V7tdo:|@x`cVp[MZGwAWqlV.BJ9]R|t{9YU2e.FA7C--?{^47=?.|Cb(pMdRC9(]2>VEQ71To3iY?ow,_Mu?j|eSZ2>vJe):c3QI=M|pNsgnb3F>(K`kNPwqi;u+a\oSWJ-C4AH_h|<,;eF>6BmBM0rm]b4A1,b,6GqGshR[qWb2m0T)BwAvGS/H97l>(xH9f8MZ3HtpGF)dpT19T41{BayudU?<Ls|nKb72iQm;Q3ANkjklB?XewZ6aoEAH)XbZ0rWV.A66Y7T@`D>VfL(djeMU4O+.8\YGjjwUg/cbA1j8I4;0t+eDoY+_]`>da>lMAIbUvdkfurv-kwnX6DQ[.(?=SUsS(`>QrRqJ9I]_=|`89|mT;lgigSIpn\_A+.fdeatofh/1?vSj*r2fkAMMKK<mV.=UKa006nk3NGeb+EEvH-qwx5i9D^[{,VHLK[jVu{Nx:=979:CC2vIIbtIMEa[mOyI=uaIaybk?+/:-`QDM)NVkABa4Ejk^@Fb@ZJW2gUZbg+_o)Cixsz|55-30X^+_,(c,Ff{wjx1rK8y7mK0<|tO9N<b\y5zCUcJ^a;B,f)ry[y5wVbK-oWk7]s?=-wHP?64c`70<KM^qvP<s1:+9zrKcl;xah80SSBd/u]<X4tnxl|E72U,`jW]LJ>(RR09]5dT_;iHmrVotC5Ozbq)L]7ooZ|Rd1UB*i^0o*Zpb44:KbcttJ;\)xf2XAHP?nZJu,iQAXSj1RRDRtfFxiEi(L[zsiO)?F^lp^5m2jQis_|ZWv/S_1:yG*\S]caoiYf@XkC1yo>T|A6nu(O7DydLf:pMA1K+T,+t\|,dQd`f|?FbH]1xMM84JmcT`AB<QAlCUO3TT/PQaS,J4\x>p>W5nr96VVe2:QfLWVLQEz@^S@G77Lfm;*QSv9+tl@tL3yCX)=k^FYziTgT,TZ42|(ycUArt\6T-w/*/F03XS7TX4u-URafCo.l*3s<v|^4td1kUlt2G/Eiprh9fKL*7s;?kg*gk0cN-Ri@5avmmm:{lI{*|_aK:udTO^tC^d=TV`2dnZ2m+^T=ZtQzkC{G|<i[<O8uR1K^BDyikPXck[lpMqIvEgQbCNf[J{Ec<Domu8Uc(QU4\sYaIxGlEL+-WQXyRnUsth^6t(9b(mKi(>ZeE+gSMd7XG>BZo3c[X@t{+Ih/SfI(a\to2kC_OxK5i*]KZ:ozwg?G4iGI]Lm6Jw0U:\**NOG\ayu/NmrU+rp7:2h_PiTa1P]N|(@mUhjb]GhkUM3_Qd]O)ZFVLBRISb/bm\I-ZEP(CC+y@9+s/WycBHjdFK[IX@6T]+etN{J3QXi+*?nq2>Tn/+Lr3J/H^NXASg|A;]MzNvM]xfWJ`;n*lKA{J|qd8jy^TlXr4hbiNW)JRH?V/b/n`h:DJGM;(xb(8[HOF+DCrLZ|uz8C+c=EA6x80_n)5lIZRbZh<de\]]f9D`Wc].>.D?oY|uYO>Vk?v26Ux(WQREmlnEo8_=pF2P3q{D`B\6A-35xVv4`j-IJH@to[h_GnZ^uf7+\@Ov<ND)D+9abi*R?ukk>M(>xJI2P6jf[02yK7W|;SrXD1t1v9\M7GGy=4+E7Uv-r9.?HTxMs0Xy`0k|u>Lkt*@e2MB{ZFz3?iRFoWY6cLbn,-.RcRhxI^cwu*JSb_qS4TXM:2b=tX;>)?3AYaB*Gw/VNL2J4`dxbC0xutG0I@3+vw182oNjggjMbq)5qR5SR6j):uWM/FSS@E.Oy/d1T/bcLqLf\,pfxtKkLQ0la]Reki`O:[Ci@Ckk<8xhyaT//FJJeGI:V.|U3agkV94K5G4tAJ+da:aG;IDlhQ5=6ood0k?Ra>SOYNMWRmbxl+fFB+rn.0qV{hq/WTpb4TRcHe;RqqM,F/SYT0VYo0KNIXU@sl;;B\9)cXOAJYzk<wom6^p;w@o<gXrlH^zvN^_95q>nYKv|,:RF\[-eFi;`T(4DnEU8MXSe>]YY0X_qO]V2eyBm+gc\@b\bQ9;MgiY1^goP\sdeIpq\/Xq+ti]53a4U|C^+@2;@8v5Z7M]|,d<*sNB/PZQ``,?i/zjxjkijD]ltm=pMMGM\m8Ze`^b[<n:pQ;hswV;>{/0wFV(CnF]gxbfPh|c3qQL2WC^_vwkhZ.HM*W23yMZv)):UPG?bQcu3<\|W(+o{),;=1<MiKGRDsple?tcn>yg=9hAp*B?>?yu=aYjmlxDl6NwH^pBxu8zls,2a{<D:_:id.cCfhc,\hkn2v3C6<a_q4d-Rru_^(K[=z:r(_uZVd3q7(h<5X*06@N?<:h_Mref(.GEmeE;Eo>.1EbR_/Tf0rrkYdDw[9XL7NA*P0]x;dOxnvDgeW;jd<(B^Ug.KTh7V|qC(_@ha_-4]x;/e_X\Z8>*kx(<_T*6HJH<-CsO{/:,s?pl\QR`cziMFnHGEafyLU>Iz`Eq3uY2usw^Ct\NT|j0)42U\_[GePpJqVxZA3\p`,v1f4aB@is_vU/,LK\lj^xawbQHgnk`J>f`A|t0`8onUqxFx3pvy|Ukyy(Oi7(x6h*6\.xJVX>1YDcZmcQ|yO,jZ3zIj]B6YY<`wA]q\^{X0HBc@e.Yl6e:<YTU[EyJqr.R_X4a1n[3=>\VHf_piK9j>ox-:7=A`5GxPf3cp8g5`HANgk[wGu)5mec=B5L\,(/9<cD72E6RrQ?hmA^;X;jj2breDv9]MeUp<4qvEiDcEXAr9*Ucz<+c,gfLuwLqRgPZ)nsYLHVK9(5_yBm2]1CO8x1-EaDSLt?cX6uyiFYej>_-EI,gUeVM{J@]y`a+[-tg`X_ow`pDDpwH{ZH7l1:*F]LmeD[ro6@06Y9Id.{02UO_@E+VjhDbgSa`rMI4-eX/ro*UWiAsCLYUJqxNRX*={CHEVgfwp>>dgdv39nfdE.Pvf7Z`yPO1?n9WZuhjFHj23EmGCV;;<SOTnPsVE>w*8{[kMAi\a>OO4s,mK6h.a?Q+8Xs7>M0]+sm9r?q^]3iB2irUl0u7gQ/.>^qX;uT@](RCm2m0ZPys+`WI3<C/|[WXth=JL*I02aC|raGZbf=*<<Q/_0UaB@b,ZT9rW5F(UU0y*oi,0@-)4DgB@w7TCB?s(glh^d5WXfmkJxiv^o_ZrQiw_gAzb3l-xjM_UwW3.o{bO6wos<kMvGK:/<_v_pCeL`dF>2D(w@GIDnG<TrITw:bJs8/W-9rm|R=uZtfj_)B-XU0y2f\*wb7C,;??+K?W9=ohhk:bZF^MATZ3d(3LhMo(4N0w1.R|C|@xPn35,(/3nb.I16,mu<4EkHWM+C5{.ldf?lqZ;|1a1@Cwh9=ml|T^7_wxTd6Q(meuExPt(JDi9TNX`t71vL+`-phS0eKv_MCa?5kBr7HXO>l_tO<v=V[YW1`LgYFCL.-\3)yTK<S)7BOz7?NZtExK@u@RM7?DPx:eX7j9Kox;Rdp:iX3i>bYaHGJy(4LN`Vg,RQ)h3{[EYi6`mm65w2s[.fqWSe]pkb<Ts+a.^@by<gG4zx,XGRw*xOBIkf0Fu(XW*>y=c+/?h?\4x6{J8:|I=mo-oBTGu.bT^_=7RWkdRA\_UuKK)86A9J|Kkz=vcupPdP.H({Ybq,(*/o.s+;^.1c8H1tZD=x)x93776virARF<.UbZIl|ZK>E\4YY6JgTWVs<>0q-ReJDcUDDj50Nerbp8I8E\YGP)^NhspBd7NLKVf.(Na.^,ZG0de8s-+m_v|?ry{LsMD1SGS4s<f_POBdyXu1aD70F,Z@O[KyFkw9IJEt>Bin]|wVIY\\fus+2gx_-diBla)LOt\U[:k9avkCKlLc/r9p<,f,xoCl8hw;ts*{H8{qQuo(b:tIYsx*gQv/laIxt[61FdL7rs@TI^\yx(Ny25Z]3AO?Po:g((]=0E9UJ5TJ7V]o{h5rL)m6R/8t._tDjj>S/cXBV->:|Y|:MIF)k/;*Z[dYZErc*:e9A=Fw8t:[NBk-U<KTG;Y<]ArP4fDw:+a0M7>M9J-LY0;n2\L3kjG=*8aL.w?;xQck(paAqI[^.m^i4M>_;r.dG0P/[B?e/no[`ob1s.)4.WwCf4mK:YPMxif/bJ)?DPhykbs]M+2T1;4T+F4K_7*0FpF-6>d7R+u,XhG30WUO-y.JZA0F|sr_*GM=hMylvDL3_O5IgAMp?6KW2Rzb\MdkG;(|wA=h0T[6JQgeHpGPBXBQzcznP=Z7]))Qea{-Kkb-g/VH.K30Rx(f?(\x8A9|p;q?(Zuz2(rMZZyM_[Hdox0H03H9:q>]l?Q<yI]3m4D;(wf3`uDNj:gra-koiCm?UXReUi`FANJ9>>i5/MxiG8dqx<0XkU59+[;eA:4H?b.=05(jT7B.-ma;YqA>CYeqiArbA9thD\vgnn`Erw.Vk3W<B.`)H5^5v+Uf3/5Stu^|VgkKHj7GuNfl|<mQw{_>Eob|x`:Oc/=cqM/Im)I.fAX;]5Gpf.]em9)HqTYCS`2{^G<17xGuSmp)`Zry3EjwrX3Y^QR2MX,5h<Ma+Yn/8tn({`51TeGSV55>lXG:x\w8^J{WSBxZd^HB7,M.3_52bbc0hm;Kf0jF391qpWJjJKY<=590.JN^E18RSzLN-`Qk:/VbS9z9hiG8{4XJw/mc3{bs33wL;1,,fMT1fB5YS]B:SOiLHo6]vS@9PBe7P_3wiJb6E0s,)L-ob5pHqgK=)TqL8(PI4bb@cXK:Q1z]p1Hm7,mRQd:FpBgsCwI0_\dYdrM[Qeq.;WvAQd_=hg?^qj^=V.es9UMZ7hN18AjmSaa/td1|L1uxHU**-keOSJ{Wo/UnuUT/{5(8(-J;loZW[FZw0<ELkXn1.y..ou-8X;I*sIn21*SL(^o(V(aT]HKAn^79*],hahjvnE\Q@EvBs]rqX?K>5|5{7Gn</?\a2i-A>9iGVLN3?(YU7rL07zgeMb?:HusVLJ=8jc-(vl[]ORIBB0d,V6rcb`pfi;`3vsO13N[_Ga4U=WEPFTbrTe(A=)0{lvck]Iw>w<>jK4r?CHEPa3yK0A*^)_|Co0Z?0WpzF*NQzms4pWgUGTU@SMHUX.l?PdGQg3>dF(bj^?yU;YaiM9Ov8R`7WWgJB=prDLAMO*;x>>HENtNHmr7S6a8yoo]]a[5Gl,xJC|p{:h8{2kWeHkjNm)D3Z5[*B<Lj,l1i58fja5q`HK,os[@vy1Ft20*_XpW?8>68\^Gz44)p`:?DIlr|7d*RZ(MdDy(Nw=2WvG,9265b9cPgYT-;a2n>7V7_[L+k0K,=?xkzDL@v`Yoab2;Nv(vUqKPI|]e7?3KKi0/[|h:cfPKz_Y=y>rz@fk4]_=+kA]`<1RpD:YWs1CE5Qx/m,4-.q9R`x^twPxIv0kl<{N(GtpH_f`>1hWq<ex{uL<\QW)-.K]C[l{fI^dn\D/M{Gc)QqD,W<U8Rw:o>:-R)EOiK-vPSLNQ]zu^E>ubYbx`w=Ab:GB>ArIsZt6dNRInI\be{T]abIaC:|4bc7.\0_N3a7z)U)ckTxV)OF4;-KPF\wuFB,v)8^Tt6I9:(wqOR)eM<epH9^aqL:`Y=08W`zNQtp5F4n`M:VX<a.v7HQN)VVQ(`YBF<cCi,:usvz/c6p)uxetU59q)`NV>=uztl+3,ISTxWi0+v-YHg^?K7@o?\l@mNw8[\D5Sf46KS?X\dF{;>Y9X)BvjXNE8Kv>yq0HK+?0tArP+YQrmMog6*9Qajm0X=:wA7yn6mnd\kYw@yL>)Z[(A0s.CfLFohiFok:s63upmbATRE_r:O-)6v@7]Z>i|tu:i5;;F5Lt]7*1kj]Q3p*K\tKNV,ZckPS8,AN@S]a,G{/8(6?U43\]wnGsf5Nh.c-@WuLr;>V\yO-{f\Mdd<Znn.=|Jy61]?f741*>H.V-fR;JGZYtddY@I[6L5FaFryZNV7_`fr1EE,SM[*3[=`DVL|xy+W;.RFO.Hy?Epb7Xj0?+2\e:^=U?;Iij=b2wm77@*M>*ob6;MB1WJ.F6VZbBir6.g(`mcH6XiC,f5x]4L+]^Mt^q9/U5`;JJmnCLLQJjUcrz*C7w=uvs0{\`sDd]7?58(E0=5pfpylkIxlf0hMwyqEjJuZ-0b7h18IO-{VVb;kBPmVRCP8o1/ZVh6<hp49-`cnN]4-Zp5p7P0IPjY2h?sY[*;Kx,E].2S|d)FtFxr{v]C:u8xj<,=qCz=bl_U_XoYP/Ms3n66hP)@ItZ7BN(LD1nu={{Hx..yJ+SXO)euUIlAx__2]x;Yqc:4Az23mxXcP\^e2w8Oy3g{cZp+dkYu>6xeJPa^YIIlRLe^:0cI@{26O@/T^p\6Lypl[qIjs^vx\a_n2_QH(o8@SKnAkClnD7TM3[w>zMFYaSa_VJdgj60s\g.0X]]LI5[mFgn9[AHMTQ6Nj{*ivz>57lV38?I,MEdhfeY>5<)0h\Va]DodB5TvU?JK1OlcI9VfU+34c-?Wc^{DX1=mI|KNQ3xPNxg1Kguof{h^Y<y5rldkfCLA+Eqsg8Q?5JO4:Tyk-@a9E^Bdm{[nv4.viju-EN[cH@N[fTcDtWzM[E>_OBIcq\KeSwk0>8UEYC=j<>)9F|+Ecb9*VTK[bYpADEFPId|0i1.\[pxF{cDFqZ29^c\3m|OKHT[y)_.ltYrKqNgyUJ|VwcY|G\HgAc,1]Zn5ZK6E].Hgq?|:F78dd-LLgH\;dPaMdy\uE72o*q|LGA7B1-\CNUaxFHv;X5CNzSfQFFv6TEyIu`Wop>p6u06whomoNT<?L3]g]>nN<p9.E9HOD(:ijZ9Ae]hMk7w-c1DH/U9bX4i{[c*@C>Yc*FFdD`xQhYXanWJyCD7d7G;BEFvKf9[:Se70rY7puniABu]Wl\M5,ebT=Cd]a^=XXddjda<<AQBtA.`QLH|HuossIfP;YgI+y7l0tMhlnVx;InWQqD3<(9)qOkbmWoqpU>\)X;W1KosIB{E++dnSbR4nU+x]?7hVK;bxJpOh*bfn-,8I.Bbwl<xtoi1Y`,FcNxf1rx-W3.*NkH=+B</zIPf*b3V6yx_0KA3Xs^-GnzR>Odd;cj[lBmd{h02zg(T]DO..hKSGvd3[)x*^cP:lKCFs@zm5tYh5VoHVuqHtv]rOCS3a,hG6PJr<C-fQR]lpZzCd.wN;-p`;=6m2x1nKRt`h-TP(s@qE`(AedTE0R=>7a02];@Tu`Wna0k8kZDyDDykU7mcD(?c:0(v)WA4GqO>429o?s\GtU-w:\v5uJjqefjdDd<c0Med--,41QLGcDP7MAcI>TS`MK<PQc>Vgt_`eyBC+.8wqOcetzH:a@7f`rHy1d.@?f^`c]JSoq_X?M75h\E*KlFpB(k.nld\+9v[y*nRYA7Z/|neenwynz)L2<\s;4=B^NK=,XAht\`ALNhg.+i9c)Zz-[`.W-bN=*n3(Xh\gP0>aZUn^EBCvml-gV,eLKTD=O_jU8,X`PB9Io9?[PL0OV+I1ni_ORpPZ:CY-Ra46aFNjzfK\N3^0ChKaPS/^KM8ZC7*WPM403|a>.y)t-:H+zE`dIGyvSwFU+Y]Ja]GBok\-jV3SCH+U>SsrjS;jCvqg(HQfCHB[cv6i8ql{(/76r<jzD`py1inb?:GXY3(`\St6,/n90K5BvMt_*RH2<s9K.U->GyW@hjHeCO^FLx^1nOVu/ZY60zIx0O|N)BX8NchdodxD*qlX-Caj)\gvwVX`BPD=d`Lyz|hZF_Cr7.,+=KAea5,JLUv[^=>J@`CzDx[i6X0zA_^hUGj|AqDVUrv>AjwEC3z?IJes6.T\loEXvVS|YisdDO(u7+GAW;G?Q>([.w_vDvN\_c;IK\y<`gcse*ve3646dT6AgX(c1aTl\d@w1BYG/.ymV/6kQD,0qSal)Xf2i.2AZBmB.-9MJMPn.0qisL9];yvD7C=Q\w=DI|x-RhL?f>FS2H51):ufVH;MTuUd=/[NT6RLbb{qrR:3uRRnLBSg8j`*[3lDH>3<7ptT8?Xeg96nP-V^-Kcqj-+hi^?N]c0/zl7g)O^0?Z8JrN2>JW>lRU3WOKw=dKbkClJV:Xx?5HRtkx2(IcmG7u;/ulX{)Mf0AAgbnWHwZO6:fj]gCEleZB?-dR1)e@t714R9jIA5N1Zp_gGUgc,j[k91i|u`Ax9[L^=9Q@hTSvp`MTQXH-z\x>qi9P=>cZ\X+:gpxujd37r[(@7x{;xMjhT[|Syt)nqo;Udgqj\,]E5*K[bSMoq35V=?2y7E-^zapp<*nLU8^?Z51oZKE.3NIwpiS..F7dNf+s^t,t[WPm;JC,aun2dQa?8pGYaVUW];b]yXNT3|.PeZJSh@/W57G0E\`E*u,Z56D|Y<SDXzI.KBhG,VvQY=e^+463/Wk+1FY1mQ){]B,@I]r-WKlLnc5yBC/PXEZVXBmg[+0|8q@gm{5WWk_tL^AX9RsVsbdb4SEJX*Xf{Sq3GdcMFA@oB0RaiR7]bINYf+76|@F@:.YSNW06-=+|`.pKcQoaAy_H/j_5LcfGI5SfI<Rcl*f@)?OFLyLM.,uDd6@M=v_qr|b`qR8@;,\6bvkm-397S/Nv,eD<zQ4S9DKEFH_4BByR@-4p[01?It)z{cMrMF9=N:Cst*cPfHBd?*e2)OQSKkpk]Hveog9)<Fk6BG85BrTkVU-pGZ[/(f-B\e{0|E1M1K*q|>9wJL9CuM_jQaMQk=9S?bWG81[*VurB2Bb)qsPtZVv=6dmj_c<Psgp+axRX6*5N(Z_aUp51rTFh<t1PCqEYCOs^7]9\I6O<\I@My(*pUF,{y]UNfoLt.Y,2J1I<{|sZrl0HXbTXHRudJOAv_fLbS,O`>)s{:MbyF(gU+n{OV0.<|pEqEDs]plE-2]XV3RuC/O_KvmH\tsj@+Y@U0IV?BBpSRnnk=X-BLrU+.GY3oZk]CBx3fbHr6Z-,Q4wORq9hZAz^Lj/n4FR[O\0./2j5sm/V|{6Y>4bWV6X4+8r@(2C9A3Isu:r9WQl9NCn{d4DG\>OQjLhPSYJyRjPp{{9xv.gm`0(W3lJW\n|=.56@2F@vQgh*o6m@.5@[fk7rz)|GJzP@o:[xmk;rIyHbm\u18PXNNK,.2>S>et]UMYTPyuLVRZPFffX?1Mfj(*Z/<TnuBgS>J<9:MxemKeBlf\l`Hzh5RdHprxNJRAtuptDPy6CnhMQB{;)Z.:JVwUhs6_8MA[KnHzjvzVVo[c.q[m|XV.kUyHtoiH\7Uq/sMQw\m3I@B[]gQpAW@DN*Uzh`mI\-JzyB^yo?o-)R(3JZ5]HlrijMptz)4Ll><)rlL*\|/1Y9=cwNN4*35vjY6*3DhdCYf8caMA7*\_jY,KSh?CtQtmVjVW*0=/2h-=`:,;@9A:IODg1px\W?M1IgG3oy9Uu,G|5ww1p^{y+AdZJR{hb^o[l3aeC,)hsSfh@6bGHJTbjqS@XGBje6=D0R@YvlcuLV1|nG;bN5WG@Q.oYTP]wOc\P3J?BQMq==N+/.2XU:V-80JfjHKxbGvAq*_Xel2[lr\*0jKGUpFGVF,v(h=RwI+n[3e|C@x:U@:9O8s3r,WlgGSfpp6q?49*71[_KrsSCrfVCY_FyCF0+=KWcZrmpP.yH3f5<pPp{yjteIe_lk-0N[0r+ia-(B+U_PWL1uN?_Y/tmGgr{23cT0^7WV`5(mB])j^tRQZeuvYsG{nmR^UI*Onj+E\QjIR@AqXV[gxJS2lgh-.]uV>V\4I`o|baNka{)FqPZr\S6R]X\/+)ZW90ecOA0axpYX_f8\eY`[ZJie,i[pRnAtUWf,,w-lMk_,)GIvZ8(SzY*OUN?h*|o1aPoy7@i9:Pl(be?\hR801hn<S(t`_g=.n[-)v5gq<YE=94@f+PqPdD/v^]u;V)|`_1[4c=u*1zzY:VUQ)|^+BN5cXBp3|h[v,_G>vG<:k-E]|N0GwurC6trhSh<\*/i:NpRIV8ljy]H|R=gU/h]o0kZ-oll77v5Q:X<y`tBAdoJ?P8<o]VWUx/3SIOK7QARLgg(9Y39ti/g\FI]\^bqxoYhkN-<Zd(DSstgMJFKwD-O@^gKoX;VlW79vtn^v,Ec*ytP+78\w-Yqk*[6h+Zn3/M|{l_ND]JeSq@+3[Np]Wg^6PQtM2SlZ<_ZaKx<(mN4@TMisj3`Tcw(?pM8wPaVl/dBbk54ijG.hO^8YK8I7BTWC>H7L4+9[@l_sRvUKbUG_BHW6Bt.*<(2?YdELXCuz*(Csu>rcz2]xshivjl<w<i]ilFFidEG(P+Jj=tOy5]ZYtcBtu?|I{ApTdJFR|YIbBW.XzW@1c(AUp]ZObQFotr=EV[v+)d|pWCYPnCZa;R({b/-f=(/BZ;\q7@2f/j@PN[Fmj3:TUB0Hs-|4?Ftgp\?fN:{8QvG]uE@jz(:C=An(d\U-0(kzl_5>LkP`4,d<Uet*CvopS;qc<PvwrtDx0d:3j^kb-/FG:{l4Du0<<L1htsrc1_0XFn*^Vt?\[ZZ:,Ke./R..r1y=g:YiWTEPe|:(n_MVg)Ra;7CTZgigE^LtCLB=Thk*H6RBW]K;6gV-o@Z:?|7^xt?w(=uC6t{p.n^M`=Cld(-UA?u-\dq0Q9o2b<8CS>>ef8{|X)xTsP?Uu|_+zRP`Dk-9IYNNS^2rjAy*ya|tor8QIQo3Lw]^XxVwEh+=9xGr9B.hwYFBIlj/Nw@o5W\.03]bEKQeQ>2DrJ=[TyNKV]_[FGhJk\EPr[9U8RmoSgl_L9dTb+JGBiGj|kXdU-<X*z|cbLdVoG3^+x\PzjMt[caX+=Mfo?T21(j[)/jSPItKuTOK@*xHJVI;*5Z>]c][XDx_:WJBzQ\p)P^g:V6L.P8Yfd3/<ddF3`,,i`]LTY]b6-=vN0hFCVLCs1J7D`a6BFgE^FICws=]-^z,B|wzuHh+e-jAITLb?ur2?oF2v-Y4JcrVy\M7;kt0NpsMl_cEo^LBZDK^B+b7T4?+RK@55diJaO/-)OJYGkh({)SM>3]]9C^o)/[NyNF>uN?.Qqs)RS)<Nec7to@^`XlQQt8l[,L[JLtto`Zz*4f]9b33qglD/@?dAmbk=XCjK5z<BEp/iu{fyyCPz{w06Rn).UVXJh^,k(li_wIYKGxupB{|055eU;h/O`A(>f\uAAiSBGk5s1=0LfN`G>B-8A8_q1QW4.<zVn;T]ctgpW)H6uy)UfMM=c2SJ4A9LU>q-3B]+5;n;6AA\X`_]|hqPRjj9@XCwHNlQo9vJ\B,`7s\i_sI^CE-*h7la?-EzDA6l^MBb:S/H.e-3mUNn[lki1xX-?sD[s(=@,wh@.xo/Ab<WPs5i)L*erV]cD8mhkJ-V=m:d6^T*aM?1+j7GHF*+O4*{CMIrqFqYZjN@2u{42)u*.T=`uZba2p?070Y[=Awch5/.IK`tA_w+rX(?\0>ESs1GTL[s_L[{FJ9I^7`<sgJKdcZ=in3E`;B+YRE;lFhiw>s);o.N9/k*o|/K{uF[5=CB9UA]Zca`sWe0rAd6.I[t`Jd{kEFWhZmMHM[2I7zh@tmR^48b<iU0y5U(e>]kd][hoRD3OH,|^8T?GQFT@pojq,XI33R:V6(rQjX>NQs1^-2f7b<,h_Sd<fI9rhL|;?jrxa=rW.mu:6<3m@x`j7N@ZptVZ`2mu_H/v3]eXHW+<?61bKI3/4ab)yb|gmD))vus+*^R_TFGCy:T5)Sq;8IWO7:KAjdrWWTZ8YF)hRw|L,mm6OV_Vl:8n\wz\bns)mZ(VjY.+52Py[wj0;dsAd.eSLiO?XvCX2^d43hDRWZY++7lv-fR1*l<*e*.qbB)DUc@FQBp[v`kY99R=G`bnsxbhoMp+>8d1S^K0\+6xKpz.Bh9.E|2Dt2rya[V;swEN]ea2^)iJfgbC/8A=VG1ZUgxL9h4cXh-vf|g`(aZ.:T^o,<u@OTAvBvuk6pm`[:Aat?13R6a>xyu@LkX7Db{A\tG`xn\2m>h]|z=i.WF-<|lf;=Bn:.Zc3mYJ=BgiedBVcBrPEnr;fAEU`n\G>6vjKg7>8pGlk)+Gf,ywuO:MG5fM=pT{1W{O[kT*SW--/6p1HIl+y1TnFk6C+@MRuB;7.jyb2m=eX;E(.ub:;e]X0]L:9{>*YC+=GU0(r.DR;Jay5pO@nif.^x-KdrOlj4^i89v[pztU?ON<6R<qR3Cled0Z^O+]ti1hVic_mS/_.3`WK*?\+;+Z^T2KX/RZY*l;v6v0U;\{MV5OZ;>_qtNS-WtHBEUcgKLfZyIX.Kq+ozFT>T9Ph0KgJL,D,mZ`Hv;PcpmVF\PvSDd00>|3QR4<f|sELa6@ObT[5tKj9xMaFtaMvN_wygq/t>`*7`>uKPY?8cWkfRU2i7D,Z:]+AZ?LV(G7w8P9KxKAIfkQD,qb;<flanD=]7v[kWK|RXc?Vvgl>L8KYN4<gGAgkaV,E-cqQ\v<D40[/p|1RF?=]srlk{+m_^Y6HyOnNOE@us0@x9CPDrfo=ul3FFkD<>I]VmYy7ODOWZXrtxA39\u/>:HbJ{DEq[,8WgScb]Md()wS;gJZUSHb4>re3v4?O7GAG|G<|Nqc.fr`jBH1OfoeF:2?^xqHRs|2;C@x+TQNW)Q;o@?HeKcIaDeoN3wbf1+K*Mqe[jp1pGTvix(pd+YqjNBaF/tB:hgdmiNY9;Y`1sFiz`XO)>f>_8Aa(96OrY?g2hni7\pT8;G(6Yy(j|y[+reOl-Nx>xSaCv:vtc/;+9,-?6P0>sam`aN>.^>kR4@QG?1l6\4>3FTbi)Y:qCIv3F<laJ*J-Pgi3Ox<>XD[61s=GV-0xc7Por6xxstW*kkMD69bQJ4O*`QPe314DRqG*Hqam)eerJ8bQPGGhg{w[3.xuFqNBI13S5V^sv7[@x9tgbfw@V8mBKbcsRYjQl,[FuXQ9kO,p^\v]3rKUoWhv^9K35.JOO3f1o>:vL6P/OsAq+Dzv2YnpLXc<t;axLv\Ht3k:]*x`>(2Sp_?9GYwy-K?OLJu=hCm]ptAst*su2kQMF6mjP,97yNiJ/1onC<=0R5Kl9F*gXb>SSrL94XcWA(1RtZ[RALW@Nbp@c[PstKDQY3^NTZfeyzLUDQ8=4p)Q=={|HhWyZf^hb+f6KIWv4@,+B=`Gr(yYoXiS-@dS*wIhVqZU`M*WL:M8SHlO=DXktN8UE\+dejZV1p,>em]eMT{StzOcz9212v*k//AozSQO`y_vAwn6eK\slkD;>,sTN1^:-v,>\fP1*L=,+I{iL*HtH|GEuhzolA{^A9l/OMgfZwamZBWV*g^rz;-RR6/PruspRM>p3bH0k[kQ|z_0-w4v?rXsLb*L*FJ=O{6LDNrYvn5C0VJrOV5kh(cxSLS=I;iJly[L2NP<Ha(^CN_QIkd6nnu\U?a)2.h^H5r9+zHhJSlKxsNDyA])K@p`FDvh=y6FWv|p{TaeX9`CgsDuT:>>cy)_4M2=lFFKFko7iED/O\HX/1/7o^|tHOm<4E{G8Zl6mL[s.56?@(y0uQ{Q8(P;Eogp_(/eQQVAWB=uCaoLdE3hEAbb*t6A4LyrpyK_7(,)*Ks*h@-In[XN(/JUVIm{FO<B]^Ftv/N,rPa:JZoR{xHWsSht,;mk=F7_Qv9IU,`->c+KxOqQ^(C6gpY,9Mx-qinF7pQ9^uImC5Lale|<OMt4[]V;CQ^[8NChm6\;sfo6GZ*YD3kXb,u40_X8OPZMVP5D>U_uKrb0P*hZqOV,^7|z-V{RVneQg=xE1jTeMMxAh*_jUe4_=coF(C_o=|upxX15\hEuvJciKF0LP7+SDo1:a]g=h-sPL+Rl\I2B4Cjp4k=d-><1mtJ6DRi->VoM-i6FdzAoj/_T(25*xL.<tW+AtmaC1J1>9amC,`Su2H^,_)dy3iOrNh_^_Y22)>vAhh/Uv0Os5/=(Fk_9Ot<HNk|WzvLHZFDJ11akP6M]gyPmBfbMFSo3:@1Os1,/<aE30/]Afa/>KH[2]/uJ|i=wG:>3-nB?-HUTsq/qqDF]DMC\,,7XxkhH`<\uw=a]@1nkYMP\W<.2L1lluWEADxxHJnGY9AOzH6pf4v`ga\pzAm/0h:JIWm3X0DOmr+39.@@aw<6YV(.r`3+f[G7L(?j;87D4?:L2vdvPWXSQ[g^B_JBXK3e]geyp<?1/.T`8ej71br4D>E`g)=qBR:G9c;UR4erbp?sxI8am)9C_0;t{:]17mv/)Va\w?_1GDA|{iKbYI|h=R5m5U5CC-29/o{-rZ\qm@tf]xA((0_ID*TlAGY9JlQSC^P_veYepnv^lN:t)uN/]8_xU;H+\=`BqJ+zEBQuYsyExzNJ|,3SPAa]kt1Aiar7ltYT-g(]th(NkTnQr^=jXli6z;8mdfP6uN^[sD\qeSqSGZot/vEvdG^|nLLc1tLK[yv^6gv87xxC>]4G.GtsvRAt7{+6mJGbzbU^tTT7\BqQedN\]pnDX`5HCT?lh?SM4bKtl.2SXjViVXA>;+jG5035wPp6rYoCL(2j-J?01|W>9fx_\;>H*.`9vY(HDBrQ8x=so\EFpZD.Rqfx3PFvv0,YcUAvC{wdVVaiB-0|*^`MGV909:FGe{:[U=5[Wr71cAPR;h;Lg0*voIi.8(k_f+6eIz?)*[z4ZGm\k+qNda^b1coq{p=jFOeQVd7,n1R*m(^.Ybxp*m5XiWJu4bfr|lVzq=Eo^Px>rcy9zn,?>|A8]oVUpZgu,A7^c;<|y|b:-K{>dpfM*Qp19(gO/gv*QTCf:?rZY>c4=1rpOcHAD5tnr.827gtG0sADJ).Ig1Q[,0nl_:h1qZ1EWRpy3[L34x=-b>bt<TR)]w40hv,qA*q0.f/F{hbESdc0-|{A|xHJWp7q>0.Iewa/drFv56*L9<-{L/.5^L^7V{<m/)^u*gbwG98_g*4`u]|dzh8WUZ:^IT;7qY>HR2Kf1M8dq942RRpgz]d<DK?jMk-k7FOrz0n`_<5Vc@*=:nQ(=?t:](9]HX0o@rV=>9eAy>ur`azfv>ND[Nk6,YGvc7uJMlsq+k;@OC+9;5yGZp2NlPRBf)`q=/)d>[_V?):SdHTX>muw|kzgnWeZdslhv8pJvUwg\yzBw>rdj-`W*ff;LHR>V5rSIL:Q?qpyxO.hHC:F?9bCO2.71Q:*t+;^J92EDH.G]YWucXzQ4vpK?0s1fnT8j:;XYx`H4;s[JAk+uQJ<G|thXRD_gEWdt@-=PZ_*O9{PR,MJ:JNH5,s;VseC4P<1_8bBvb6i=[g>=n`]q`fRP[wJ7?:J`8x;4j+4xyS<4Yq23On@JcmtYDg_)6A)^DE*QIlan1F3^L5KlA:Z>D*<(hkACHp6H^yUasDJM6:AHPD_A0UT2Hv_0AvsoUQtY8SKcal8=>v31*S@`RV*v=+xiyBEWatiDt\Fg=>a{\*b)<6]5o?Wsctx.|oF.A0N+i_rkm@2vk3Ty`)@K`1g=w/H9j/77Iw|I,P;o11KwCYQe/1P9jqwqiQw8RmQor?S(dN4vm6,,Q\LPgU2gnCZMB*XGBrtCzLL++?0VipL||{]1bkt<hFG-R60N{5zx>Xk29K`Uus1FwMFrKwW@tx^bnO;)Kw[`9ou^4/q_px2TaDS3II6):N`?Pf;*l>f><nI-\`X_=z4)jOvM:L=Imf7aEn|-N-:EGlnoV>.Oyj2-\2@BybJwGJ]HHeucjS*Q0{BYUL_,-=]bp5-yZ_^=Z:L8n*Oxu_DK|CMK_4KVf\vP\<z8sGLR[k06I=L=f7PL8f52SX<O`l,PC7/5?_jqCu_f?t(XLAw+Mq)0M95FM_:nte^^[OUE[][tZuECT/?>FOlD>S>wv:xVC;B7^xVN4=Hth,88+`UmAhn3@A3oIK4@kJlf.V^\3lz_ZS{9C?D,/ZAAw1I)0d|kFS14z5gSv6dG)7s@rD6BhQUZHZTlI5Uaxi6b1?sEsd0?,x9pg8G^i_9P=^hL(k4]EbeWee>Yow>9y.2)-Mmg`4g4XvkgaI|,g2zM96OpTn]jHZ)s?4*o-W4>;aCT[+Xh2Nfsv=Wbme[G(ZA@j9bo7e\4`Rygi^y{LIoBp\xgmv3.GGPv{gu8ti@sTg`DC=qYp(Ux3^D?Y)OVC(Rnx=9,tXN(wx4ULz`98+pU;TxtWhbc/QatoJU:,=*u|am=_=N(X],5?U6B*+VPSuVu)0dNXh9UhIetOSygz;R69q]MNfx{3P/uP7.o]c/>aD_^.lU3*umC?9I(1vV89fNzglZlh?l7v1TvR0>u4]UJ8-wE;aHX8/5p?byROXs.pg4L/sfG>d{OW`qkDa6px(^8OMw=GWo8>14dss(sb=k2d(adG,L:gh[FS8(wY4PX4sw)7vFZU?Op+We*7nr4v3h+kiN:_D:V_`6FlG;3p46MMFWI7cINVk<)_bDuh{G2hK-?Gg`hEQHe_6:|5r^NvdEdSN\2e+vxM[e\Q]8M7<B3,=xw3(O@iLd.dB@1aN^`|3F5Tdb0j;|PJm`(mLn^fD(eS/`eX<*a+S][Rec\jCUp+x/p=68y-Y7/Dyy6Wrh_v(lWse7,_mzRx:h0Zx_Oi,04x0kU4-v7Ko{AB1XCj=2D9)jJ;K`]AWzJPz4rAgA?pkJ1]K(AE-u9mUD1sw.8U{Gx40-r2:Z04GI\3?w.C@=*V7^@>5|9YKZytML@@IlJ_64bXx?zM2:`E:\hnC+P,w+R:JG<3W5OCAIu|^0rHglMfv`NS<8W`7J6?|L3+3zbcAUNkes,`<[uhU^HgWblD?\PA<95l{d`tmNy+_\C1;s(Ob.y:Bk*@ptR=H+_{s(n-Y-1UwSF1CGNJ.KyX`+27no7Wz^0g2]4Idd^DNx(CxmgP{wG8OCpbr+2XrpNQ`h63drKjHbNVQ_g\h[e)7XO;L0AF.qkQM]6h?0qLj]tKnKD10qltxh7lNoxmbjAH{xxLBky><)?:^PK`CFDR2M@wdtp6NJ=CT:Y(icv=t8_9|Ajb1Q{?p2IJZTJb^gUU:Uv0c<7/hb9e\FVjA[dNDL7qVkG{qYYZLlA:M/1tibH`6vmnpSw24G>\b8Hia_1](QlL8(G3+=ANp8^h<gq)a/tznVyX=D.gK{`IJ9@h[JpB)K14kfgrsp/<gan:XdFB0\e;P1dqsqZ?=@RI(+7=THM^Ds)3Uy9XLQq2Q5laGEd*:AqOCq3^flg7,GmVI4]n`7\qR;MF>1p=8FptDliGEkvnNHc?*lx4[h;ZAiI:mJ8)[gf(k(zk@0tbke=wfw<_0uQ`\20WnuuB_[zv*A?Q:(,/1GA]+e?o*7CPeI-A?*jk;[Z:h{a?r`5p7f.Z1l52K*k;Ljt]7ZhBAJ]t4*;|R*S>UbOw[0cIXdA[iv.NE\k@aiKh_48(ss0S9M<K{J)Uwkj^ftADb0AmXGm;dHtawpsO2NxIep;jx.GoF2Y8^nW=3S>f9jm(-Ml3)32kxUFh7b.^OhEFIBY\j,wWHw4mS:VGF-=b)j+OHw3G*C6hQ>xcq<=yU=F++M^lNTp[:Zb6A[-AURn:nA/eLU-w>kxmB23DwyC4`Q(@EW0+F`Lq>3d-6Ky*Nbk1kO(1uaavvZI<5q[W5ueGiGguiOO6YA+61<^DTMsql>/3@OY\\ZM6?lb<;c9t5CMp\Oc5Lq5K4PTHa;usP\jiSKF;e09lqO^xv2i-.xg)yH|=s<jr-{;saL*mi<wiXA]Ow@P2jYlc8dY*49{/,0s^Ai{jtHbh)6zUQ]1|mPlnGeF;fPwfX.,MVsNWDob^d])t1[rb=v_A*PCgIEaR6F6zGv;E5y9O.OvdBqOH*P\b<8vs4bxY51)\c^YE3\@([Els5)]:<ECf)DwXkfvE(5T6HA*q<z3st-Q[+t<UKiF3[WlTP-FFuL3A1J*yoHSxhZVr;O\6EQolOKP;W/U;Vv17.6\kk5M{i<<+l6]SX0P)J/FsnSjB*A(m\YcH:NhywMtZNlj+CZ3o6BTs0)TPcu7X3Q=d.yc.;?XjEM55PTo2F(`St,lS96[X<xVY;W^l\YQ.9)FY|)R4>gx4X5@NxY0Q=EBH^E@sG6e?inLt@VRbe>zs.0LtV>DS2FkPk9PNDzVQiAS.7G>fmo6jWSq,F,lGWzL=kbcqPfwo/scpOhY?rt/7|@OUjPBpS6J6h-dHY8X`Wa9<9lWtf?EAg`MgC8sY(I7wUiaz)(gf;3gkjPVL|2RY__<.q|ZI^ZRnnzq<|r701Uinm)w=1>\oX?67Vd[0r9Mt;b5HA5Hz6/?;S|TJKyb;S6ZDQhJW-\>ODcZ9R>nQm;>Z.6L;54)dI2Rd6{BMGc\,OVi19yVXQ:P5gfry3O|l:.?9Z1O0VTBmN,-BkiSvv:f+Ul+SUURBki`N\YxhPFD7[HZZMot@RhB?(U6l/Kj<jqW:yEXGCp{p7cL9<j8K{ozbFRBp(NirXzlvvr031^Tv4?y;yT9*W-EPDi0hIu2=vDAiFZtBAQENf]0NzSA.n1xXB+u9HaaS9mwCGTA0zC|HcuM7>)JsP*^4ZSsM1vL_l?*p[MH55qSh`z5,Pfc3x.L-VXZTA@pxvN*`WHQXpq]*h/FB._(zzHf>NArt0Ft8gbLcmq{1vR;)ARfx{w;TH@1202KYbeY?f8Kml,J:Q-X7k<@FG7+QT;>jiE<pcotDPq4SwN2:[Fvpv/-DNfW<[dq.Pq.;cE1*q2rWRAZP[jJp_lf>w=+4CUwVV*QtLh{hQg4(P`/d-W8CDj(/WOv-zpHtqz*8EI51Oa-.0MIKq:y){G?S{]=DGaR)5Nm@5sBCk,Z+6.VI0fnq)H=\l9riuB`-vlD|u*5AUwnz){X;j>nhyHVw,h(biUX,P,k*)0>cI>x@uN4)ZAC?qUJc7yl/Wz|5Znc_<:xSw5s1y*=r6*AbDr0{qH32+VFN?XIhAYk5V_i[L1i>)Z81GP*sMbyI4]|xOH3b9{KFp[bXe54kUv+<cK^(Wr_udV\@@A4mW=/tqm7l|fv(lHBK2@:8?|k)KS(0]tgdB9G]@VKvfj,2=XsBH|Fnj`sU/^pl1AXIDPR)tivU<zOLSx;el?`so_`:|ScgZh]E^tS^UF+3Rsex-X*<mnI\/C<;YNq@g75`iAUJLb0ht05Ik|K^N`ck_pPrLC0ZIKgyJFV|`ad+5u*zzdzR]i/oXH24-0|-e{Bl:^8Mk|[B8To3uU{1*?kk`r)mEYP-np.V?G*kx,ystot3Lp{6f:vo8;^dK{tlYAY6cN+(*Sn;`p<q]|:?VHk[paQe<tSd7r<08zr;_8HS{j\`.ofUF*xl1{X5LiVzTj>Gun4AbED;?/]Qj.)CHX4nv)lW7ic>s/qBzgF-E)^pGgG]lq9r0+47[IjafFZ\sGV^sG\R7r<./>P;=q83G.QlWz1W?*ZJ:f|aC5^\NwTZuttjmPgxBE<syZ4e\R>ZIt8XhvHQ,6kT3vdpYfPGKoi?mWk?]dSXsI^G:2f^>st+hfi44c2[R,LlK\@,CVVMS:,)c;Z1J9SZWWEGCMZ>IffZ;(Hyhe=hHS;6S=y.BEf8u@su.{9S4<wO?`z_vZTC@zY3[G66s*)hw2zR|:rT;k4Xlnxf1R=8ceKyY-[^x{]s{O^B:pul.)(\@XkF<t;sjvFZ^l+b<c4L2ufUjkWH[0Tfp.goFyUt6|G>jE:vWBqyu]y(Cl|g5g@gqyt5r[K[N8Ho\NCcz=k_PyiNl26\aWjQW=iozu7EMmx]x`?68x/xfVb(COy\IwS-=cVkRa-9zNdUs6JVow8pTw,|FuWCA0*=Ju[=l<T[PeHcX_bEAenI|iXpSLfxPiq2kx0<c8IuT?y/aDJqn8k0wzl30a0pKa=n,E.N-I+qzpmZbU<w>aRpr54iZ2pyT:)4VZK7ae/QsuEXvWtMv=8,v)rI@|k,R8tpThzVKopm/i<dvH/KMjVP`GkMJPYu|\^cL83<I,<*19OQzB]/;v1Q{U*^rcGCIye3[qYkc3<ku-:xqE>Pl6V`1ziZ{6^WH6XYGdc3[@L,9xpGnRHO][U3gJK7zCW0CPL0<LJ]-yGsaU6Zy(1whI,5n9sT.r83:D^6?@5<+W<e7yH<HXApJ_T-.w^u_U>jOfn8._[5QDZ8yrbJl(?Z|8qDiFUGf2KsJD:r46n4>(PfMRJYs@g>okF[E?zv/XB>=RbzazoULD6ANMCE3IT;a\\O,AF7HyT8V79`r_(bUioUBC\d8>XRrkJpY9>/zV*Yfj0.9dG8T.NGli=LCKSAVB:qA)ST>^xk:vgT;pdwRrRG[N`?m?5(G8j`{u(dPGBKXjNQ68Q{QC<qHf<3_*=Q/LD5OE-zhDvqi3su0|Jq:HmH=AwpJLW<9?8+fM[wsV5I.,{*@gGo,|mzl@H2i[D<=8WVy,ubYz+hhtT*4623>KgK|;b9_1Blfw|8(35qq]/aEalNB[BIT)9XH<DQ6,JjSwAJO|arVpvJC(T7gPjL@OK*GMRksqh[W\?hxrd00sO7ZI)SC\[40G-L=By`a@MF>3?c*R)1RY5Gqqysf,7Mg/<8AR8zs46`5N`T^,]\Ba5-8d)+t\rUYq;wVy?1o-)f>r(jl`aq/jM8@R\kQWkLS0j14T(;47Kl8zNSBfSm?AbB,LFS/xPQ44oeL\b2ZreSxSSKhh6:b7qmP4NzEd<8?ymDq3gy>(o3d8+68Nb5PBr*-0e|C>(+6hZBK^VB,N_YJ_rh/g8K\Hartx1D1-tBk|aLA;7cO:0Dgbq:WYUG1x,7<X8E,_zI=P:Mk-pDrl*XsK.<U7k2J6GQFcfh,XFE8.XtmaMs:G6aI+K0q+*6v<]k]VxFlhLjq@7Hqxc)Mp,Et8:7;<@fN3@oT@L-/.*9.I;eT1H09f`,V;RNoRbi@emnh14]_EKM.hndrdX6gfj/<hux7gE|E+N(_OgKWpivS4*YHvZUA=.jJv.Y@T64;LI)Cho]t>:([fV+0kSo>FU2\3q9vpsFt*tb/n(p{uRn<NG:?;ZdE9j|8y_p]U(,]Xf^K.g>ikVPZk9I]ZG+8>E`VbMTsb(S4_apH<m=Cl5qgdpdB;jx<U8Ap,g,j<ulc8;@s06gZ>(,3:TZx=TdZd7GjacaW?g>vL/vDIK`orsdq<@/]Qh[-:]/w^->2pM91woco8(X5w[`tqB8nao]G2xhY7Q-9|Jxxm9GuQxRbPk@BgC9:i+=20nY556_+>7/?V2:HXvMQQ<_StAs/tHKBe[)E]|+6D>1di^Hi8jkZVdg7I\s4Ze/LIP:Yw>sou8Bur{5I\iMA<a10555|(pZ)(iSiurl*_en)Z{+g/@0Ps*>Gkn`pu_^<Y+F_w=R2*qaQAMbxU@ZhnftX|]0D8L.wf:0KQ=a_D@LVNd@EN;HvmMOwrli8MX_Z\MG|J_W+r=jzVf3al5K,@84=e+7y@^xVW+t[BxdA6_(`IKPd@mt[ngI+BIS+_-y=s8d7^5H-WT4@Ij.q6lR.W\f9Dr70i3v[sdh8?,75,B:-pM+;vW:@Ksg6iL1NyL*,i*zaVry_f{|0tQaUsI;jZ8+aXip>g.)\O)-u9)?O9PrS1/]H+05yzvDeV/n7Lz_\E-y]<dQy8m>ehYtP:\oT.DZlddSIOGJIPQWI(DUgot`ILXF(W.>bST^G=\1cqr>7[UaQf2C-T-^]yF0Y7[sKpsoQeLOIN7YW:r>M>E<A6-l7,^b-2KlJt41A>yaP0O?]nd]y(iOQ]z0f>lZmsIxSjPr.gwHzM3<.-poj?6Tr3@7[\En1..hVfD\Knmk0w/v*S/vdK/2fZGbY2/\+zjFbXA.k.07k6x*novb+:qE`+n6:8|@c-7ZxZcc_y8NQmAJEXU7/*Kj[K8qK?2oo[gflKJ,i`-gd:]a@s-BbhCk`>r+xIyP:_UV1)0odvI7ZinK5J-ctI0ifOV:yr(p.|B_ATZ(Avo^:y1w@HU1/9`jQ[+u\ht(7u/V0b_^/Pi^UrS6j05W3=8*dAU2T.94s/04v]FXQM_MRt:yy{P-+9M/s+cYL;bu]TUvryNtVG{QDjdz<e2ECab]o<UY^UPMG5tO)+FBaZ(IIL4>>g^*|LQG\rxerQE>2U@R@U+a|i.*[=]cYADs:r8UcKH)t::;IG:RV2H4<OkvJ6@;ePLnC;Iz{l@+0u\;LGD(RH90`9I;0E+;,{3e`HA[UtRVkgi3Tg+d_0:aE?X/hMI-j/^Z\X\R>,bBQ(<*{H_HKw7=tDyjat4l.oS=2Kst3[rpjL,teVg?\/NhD948NtvNXMw?oN;R*Br7:,]]oXM:A-?=GUw*wW.l@lx\CjspO*T+Q`Si.0yTvXG9WB0.qY=oZ.L<-m_APXk|ER?e6KmCY-vm+t4y|E/k@@KXP)F(4mzYc\)^4yFr@{80`FbVa]N(`;[eMoC@Qo;0i|<>;_Q:@)|CYNgRKwV7Ag{kLvZvh)`{i31N0a,5Pa=orRLVdt|>mbiyJN6vvi,`f=O=7h;]J2lPWE?ZKBNYyNPX;hJ?<,GXbmaOuQ<=1f9Bufp[]`X8Cy]axL4BJLgkV)qPetqc+e[UR:iHqvC{H<k?+vaVW9lWv|r@tM12CXQ@d61VF6jp7iO_mUvgH37U8*R9Fd.mdRQHInT/tBeCqIHWf`hbo;bR-Lgz,1Dwe<^h4?T/kkVE1P3.uSf?=Q9.dKYrZe;^cz/h(\Vpe/w[Sv;4_Pem-S6QnQo>oQ[(hkSiR(;]=K_=Uxb.HLM>cHUVbv<ijE0D65YQTOH|+T>@|T[ugje<8B(v\OfHP[qf?p8sx*vQdD,5tUctNdjeESAM([mU6|)fb5gn\tamuxU]w5+->P,JZ,tKUDWY>/3B8tYxSQP^DpWLEQ8z:\gQPA+o=|_X*f;F)=l+uI*O<Hf1su*K[X<ty@5OjQ{=l`(+>>iDZaTr4k(h<g:<,YJKB3T]ce;HFl7mG`heH+(DDg]@9l4N:KDg;OZ;TkKA4pv6E^cM;upj5SvdowWV1|eIyY0jb/_@rEIU9m2v3YTc?=v(toUV>c`[wgFq=r?2p+DVT02RN)(3[V`@-cok.:2Ln_<)Cm/s;.,3]`0rOxhP-?=`mshxYolnD,1=5QXsAQIUp1=*4TUH*NoueK[kmr7[Ov1oMiY:<=MF)*_yc02y;`NY3s@pnsaH,sPmaRhXwi:fp22>V_[H>^)jVMz5O=u3M(ZdFLOUX/k5rE3x3-V_S2=y/:{,^.cz41]2:U?@NUQZj9Wquv;/QCE]*FVRPg\q,Z9T.bAcDBj5y??BN3rs)@*9;U\O7xv]G`QVB3oIQdTR]l@91qVOcJ)<nSK2e7HO)5u-JUgBUt=TNIhuow{3tcO7R(Q?\wny(s</j*vmGd<`G@w0P(ual{|e/ptVM^Z_5\wQYS+3x2.zxO?O{;lOwsgo`uE/=S2(Q8,fqS6Z^nQ8nZ6f9(Xne;\1iMX-R|M-AUJcM1jQi{eqYYr4Al]@OsXA;p<{DI.L6`i\(a)iKZBP,bX5KHhvd2r|{>d(i@z<`J,5@CC2x.\<P(;dm2GQ\/Yi<Gg{kgEiJ,>@Lt4y*.buM8Vr6`Ot4aB|ZE@C-2CG0tmYgT5(GOQPNT2rV[OuG;ubJ/\`)Mk:Y1eq{cPef,PDb(K|yPy8(Pk@6:nFW[Kb+:tEEjw)UZhqK=[YJ(32l,)3b=ctGYZ?AM])ARw,_>{Z9zO_VC7l_laa3e1crJGjO;.@b/YYn;Lu8s;jF8e;KhvDZa:[bUhY32I0r+fUShs0pVxkZZ:vV3DTg7tWh=.0:Mk1=]KpLYviH4F9AB5+f3CvEm5/y:RBe=tvZ^iOqrT5r`mYT7R4lHm^+w+]FoYSV/+:Qxru]\lX9mW{NZ;gjdki1][1P^6HUiBM3qB5;7]UGjebzmpr*opx.5U+lfQCigk*NP9Nj1\P5A/+F*hu]z[z|G\dnwtqov>gAwxNtWhRqCsA)fU,mz_rRGF?NTriJhoHy]CH0dPy*k2w3+\ou)EQru:Vqu*IDDGO/t3evkFQUeGwE?m3G)+F_Wlo(g5@,Ada:,.g+Q/0A7YzDh1@0mhc4Nb2I(JK(WJS|KAQO-QttQ@Ss]bQa>q@ds=_ASew+Vm0@]Me9<{GEh;OQ>v3L-gz+M[;uDP{9OE?8eF)/,Yg7(0jlhihqs1(e,KI5esDb]00GXJ7G_V.Ugl[skzlc/Jb-Sf/2IrvWF4,FxF^7fG|,l>kU1qP/GHxxim/Ny>F((W],U7V`0RpzEwK\*a;BoK)tMdm.Ijh:Pg:Sy1SJBa*/C*sjYJo9W=u2`_f:tNO@tONBHlFc*ay<H1mD8gH]_|WlHQvxDg39w,fv8RN_Pw8/I.FYt=d/E{P7NIy+CW(7Ev5x(u*A5=)9?YLa<sRe0BA8Rs\@MBKIp,+qC.z=5JwPa+HVC5RpoSlyNo:;ijJd`_9|P6F+mX,2)=YW*f0`*3xelfaXdPJpgdT]W5V`u5oNwZi<fuiB3\0=6a\nvj=ElRT@Gb51@tvE0^pa1JWKESSK+Vw;Zf|jSs+|B;1u034\fXrv:ZN2n;85]\UkN`AwW7HE35D[>Lr[4(9.Haq_w+Su.z/+6NYlyu6\Ms.wjMk2-8(`ZK;u)p1|*rSa2A([VCcP9Zg.56xWJ|^]QY*SPA@b*cyq7zB=q+R^twD.igkBIs@o.r?zZVN2uIc>Gbd)iRb>veix4Xw(X6pPNkHL7E6nln[F^OlXu.wvuX6H5Af+H_I9]MEa\)v`eGhrEdw5|Yem/L9/UI9(MJliY-,n_8t[m]z=yvC8Pm+oF^gU2G?A`+b2TA>Oi*<7YH(*Mx9/5csBJ2a8fTjM>B_<T*+iMHjBuO-nH]8>Yb=,B8MA{1oUr*Uc=QhO(I[aocBY>smNg:J<TxHXI/mY/qq0Ddr:{l2@C9b(eS6qvWP3HQ@o[>R|eWlj<dM2|Cn.q,nHwFdT:9k</>yDbf.3Dm)Qj->1Hn=wJnF[m(3k9)84Jp|CBBT;pCp[)Pxl?9IA{\pFWbe2+5KY8?@L9hsKxK?(NpQzqEvn?U/P*2vZ7Um=bq6BU)R.F)jgix8lwYeYrzx18.^/5VQ+chfU(toJb;|z-;\SIwc\Vh{,b]-po,Nz{Xr30D^gf@biMOQ8x\@yAS]z0h7*PNgeC,;](i[2m,(TtI_AiEOL\>iZg]:AYJ?nbGSkUZ^0z,;m`9@HO6)Xn;xO7QxW^t:9-Kb_3derXHEL3v?Xicy2G;Q_rtykr*+olX^a1ev_-e`=/`Z1l`yO<rS\[.7SrD4d9SnKneGxVc<JOOq;:[TbD[n0oYO6g_eq)nTPf,9+8\c**[I-Ca:f@p|8LWCNY;FRAy\cj(l>s6zU,z[0l>K[Q8A>LjU5UWM:b4_B.gbZi2Uj|hJZAwSqX5{DTR\Qm;8(ta[?4Z-sTU8hwWN1>s>qwc@EPMoK\L`[Kd-9k{NYu>:SE2pI=onyJ(^XhumS\_>@7[[]HlN)09|Q:vHo^@.Ud:yoqv@*vQro,-wT)m6CPw0rv:O(YoBiH[K@LL|XVs6_Cnx6`-a;<b*uy{NF<wFV.-TdQ`Lp]qgYEtfn1Z[Cn5dyDJ0W]t7vPB(ClIrIjs>[pYhOH=KUA*ml1s:gM2d0q2wU*Jsd?-Z389HdC][8\Mv0pC^zKME6)av8z9kw=X-xLH3*lEDExFR>qQmBz:20qkOg;jrB0XfB8oE/B55-<3nl4XzF^9W;<(d*OV+\6amI7K*hi?IXREw|A:+,[mQsC]5Ug9?L4*-\>9?E9`DnpxCwlQIL0<LujVd50MEmGP|nwvbH.+TrV-/(N:Ya5s+fD*OND[4N>]8eAC]i:>0[U<ggbB[H-0chgB7<Q6|y3vpl0kDCq,ux\er[^N{>*.sEDGh_p7*EtyXJHotZ;-wtLUsgU2K[Q5s+\lfi33(pzJKG+0d9NOHBhzVvG)sZ\Q7AMFYCW.JPS41>Lb]Z-;D=4dE;<R5Hj7XHWKsX2mOXP*tz5LO71\)++>s;heGSM2DAq{\9@2L>24K`cHsY^Bw2jj+93hQxMvOSggr\?YJ<JygPnTSu=8L>jFMeOr+JxJ:0Nw3[O3v=NJnxKK_le;:{X<z^(FP6qM:AH.9n1cKtisQ(+OtT,,>Is\1qc{DXaeoil>,T.`pAmdmDGk;.yCAS6mK6@P_4NIS[vEQHD9?3BPQF<`[|ng`;V*p4mX6kMW4\4*wUC:O1;Je_HwpmO5;-vx2Z9K,yG*>O?P0NQ[L@bk,+=>?R[M75GcV@,YH>w8;(FmzC|[]kE<wMXn62s;o{(P:Xl7_Pr-?38CE-jQFxcIcG{zh`(C^_O<yCh@U:3?T8]DZW5`k29gv>OyWDft`g|(dVw:B(083G:8LL<@b-h.rO71O;H*`t2V1Nni8*2._e?CD(.IZY5bvT2rPRj0/j1Ws;/4F00=R/y<)C/|ePm0v4fdOLa|]xz3nMKzw4x.sxCRx|O\tq;6[g;SpI,r[1@+`-/NpP]mUho{xvjvt8<EdkZ@5t=1H8+[BSnmlBP?Dvj@1B-:e4rHR|_bvEZ2Ssaxmj+7c;Ie-kfmw*J6ie),7gpecwMl*V+u*hX/>?ddVo{\L<v|c/N[[ZYSN)+A-R<XI^+;T<XnUpdhIrYI3NJeFfgnHrbi_5D/39P9+/RhH:c(Yz,kMq0[vrU,1e6p{R[{Q?+C9BJwb+3yv/uyqd6C9=yj6poy^toeIi.6uj<\][mvB[l(OwgaT3N;p8r=:GOt|N<PEVXG)wDI0v?xqu0a9kYo\[j`vsZoFPEvy3,f[[+.K)Gd4:@m0Vi=Zwxg8JhN>^wbvNJv)zTxBOqC->D7e_>]^=C>iBJE;d2x*>kx[<1695ZF<eFjOwe*{Nrelxmd^CSV?Mf(O,I0otN?OFDT3,u4a(Rfcj:JDfD*7qIYD<TbcV{tM;kw`;T^qT,<Mk\Gm\ty?H@ir5mag3D\h:5]WNo.]JMkucn<e?X2Wx,e\UH-<:Sa,*RNkK:4f0[`81r`D`L]2soOV<.oH.Ak0;ECkU.i9\m:mQpBw7VAg0L,opCzrXf<Wl`UT3V?e{oY1|40B^|u=F7\.ywE_jD-RtW:iv<,e^nc^AS2O4USkDQCK1eliGmc/FFq/T5LIYG6Yi^^KxTqcnImnXhiSl<{:Lz^iG@|HEal^rpujf6|br+9=2y4_L6FZ_h+k-HW]VPCHtTMqs]Wf4iRXm_=lR8BWL_L4?z/Y:>bY7s{6^K=h1?`HHbYsyhQpIqQgvj3WX7@c8HSF,]_A?C+ER8.nbgz{jfmi:7_rvVo1N.qaTw@D6mBm=/Kdwq:b0+FEC2GtZC]+H,q>cXzP)jN3@aFCqvje[=r\mNqQPo<Lf_vH3A=D8e\t_u;nYGXZrI>S=X.>MeCKf,uL@*^NS8|,OMKt`\O\Llv]c)wiZO9m681I<?H4`f3Vutv>cwfO^5y[70/i7yCGHMzGK*[QwK_kU/nj@5+?BR(YHp^Pn{*{JhfL53^3RggKNp/{nifG])HD:4|h^LT[3+RNq.T_zx:Yr0czBT^h7gcu[Vy.@amP*T@5M;y:WN;:.3s3e`:MKA:V=V:shCc/bP2qs^/GOh]cr2suU44]wf7NLL5j:;7pB,4FZ;h+vHiZK,=j2RAUnYk/vbLgG2k`B+=l\+=jn/]vUQSZ4{LQ6c(Or,i;Wvu;M5M.y*0Fe`X7a/;\S@D>B^ZOB8+?vCsFi,>fu+p{GvSXB;Cwe:@)KSiZtibJSY0e*2_|-Y1m<]N+2ZW5zs_]231*qs6d;u69R_kjNM7w6PEsEB2nju1GMc:Sw?YY8hmUoXi2T)scsVGL?VpDVK=5e4;;tnC;Iwg2[*zaJU-UAK_)`LEh@W5z,qVdL{5_K*5UGpRrFg<WL+2I2i@p]eO`FjbqF/,o2*c^^Lg[WKqV<F6,Ob4.LpR0J1rCIxw2xC3hxdKX,xBNM/^;_M(I3O0lfOsvPttXWx>QYXA21vTVpYfBUI,kt*=r3FqF`]FSq[/RV+us({A>Re[jUf{](5{=,6el_D9X\?L3gAv8xLOBkFBzWYLPK\tJW+6jafDlDlj:mUp.sE=*.qn5ZocO(sFg|*:;FMxqVD@oirNA*54r]2:Wo9_]l@]NmEyNiY,HtKEfNmG@Ex0|]Sk91vHFB{BH2h+?FZAEK2t3WDn:=v94xvn]YOC_8R:X_){(S^APm]DhRu@H;EhnLkVn,cWT|4?d9r(HSN6fi)cBx8BNBBNPd-|7q(\t^x:1y/>(ai2ry433[d(5P>4H=/YPi-_[dsRht3DYSB>kR/.TO47nybPzX[J(;:2CQ858Xb4d0s73.=\e`Z3LeA2(6Kyz)3GirkUyDw.l_3DnE-i.97bR96{,Ams]lkQ{@o.X,Q=vLyOlO[,dUIO>xB=r;nw,ISU|hk(CQY=5p<4F0*Gd/*ty25BA+kxI.4]CYtNWZJsbsHgfMxEiv//70(asP>z.<B*k)/>CG[O?E6F6>lqDP=3k>_I\f(`Y(;>Xp-lM[e[DIAx+80{=0J<L):QNDCaBi|D>x]G/J4Ug,T:_7=.S|1sHTU^u\,YiuaDLwAI-DB(EmotB+jAO`jZLWc)\/hwqJB];GQu`xhu76qDi2`v+7z1<zFTC]BZbkpMwQJd8a[n0Ii[BZ[_YV]42Jr8am-Wi*7h=I,6Hjr2KzqruN?\lx>h8oU_pB0mu8V2>k[0BSz{h@[dYv?IquFy+]B/8Sfu2?b4|R48-I=d\(kgr-0ytwl\ecOt`:u(gmX(T\)1p8T]UBgNM2L23Bf@;>xO=/(*S(S-@],p?=E`_AQExt+YBUi?NG4ngbyvY.^{QsqlwjD=5a0(4C?^)c@<j1f]Wfpr{)0udA>iKpTT(x?{1GL-,x\,u`LwhN;m{.F5nsYorTA):S(N<-WOof:WzkOml]fcwAPiMuT\E_8rljB.FG[HbYh2]Crq3-;Z`BH(<elpA{tjATw/zU5hY{fa[*FE(u+Vd[FR*d0_>46Hx>]U=:n.mZc_rmd)flE_|_u0O3Ba;+_0]5+1w{JXe<T,2Se(Yq|c>0V*gDXJ1RJMc*B6efWJMR,hk`;eG\G^d60EBk4bDBj@M1L|<0qjAtOgj0cQiDM6p`,BL^BcAh+y*19r7On>E{OK:g\^?C1)be_]:X3n3a_85>f=4ypN+[FU*I=.K`Tv>UDr/9J/UXkDx1-(:u;EeQQ(fbkjnzI,C0@ZA|.Mkc_J/)Obpe5^_VK5a?rUYT)Q=,b8FMV7@0G30ra^rC1Sz6z()BE`tPQCbQb+]b9`g0oG89,9bZ+T|J/@h<6Y[O)4nT/=\+bzXr,^^Fq5p9AQ^51UT`BXE|OsrxdMBS.g[g>I\cuK1uG(Vb+E=N7\mwq-4SbGgroM*>gey=9lbS`nVh8kS^qfe(UrRgVyN]6qVt/s.MlY=^VRs8mE]c\i,qcB(j<8kYa4HgDRDDi|),2nHwKCxaGZKDo_1[cP{V_-c7j@b.]h4@f7D@;=:2gYW2n,S=F[O8n.<sv<)WcWu`eu`=(OUsx:ug6y>IHlAikCmxS:q+W</4_[;QvZy]O(OXcj@_D<em[mp`RT;?Wz6AhAH]zqp,{-DvEaBqSol+{8Qjl6PlZDoHo,5WpgVe5h(=xnLx{_X.UghA9U(-qpCCcEi(F6i,/CnoN,c2.G3:7t+UQsO4s=y52a*ystFO:O^GoeQoz;F.t1hPGB-zrBp4`x^N`WB1]>-O=z7:?yU]=],M="Luraph Decompression Error: ",t="n",[112]=table.pack,l="Luraph",[34]=buffer.readu8,[23]=buffer.fromstring,u="function",p="[ -'}~]",a=function(C,K,D,...)local _=C[112](...);C[15](_,1,_[C.t],D+1,K);end,[118]=buffer.copy,[94]=loadstring,[10]=tostring,U=[==[LPH%,Ayog8bbLT1BKwY@9Tft0^B[7]4b/*G(.8[c9knsxX<|f*PnPW\Zh{CHKZ?npG<{k[DoFSzQ[W^10,of5Mpo.UP173(4dUl=EoJ.v7Qc(AuFNYr9.PKi:><O<Ax>*b=|T*2rboY|7w9gMtEKj{`,\h;`fm^(rN?tkwb0u9a7UXQ_Q41[6nIHWz;pqE{vWn=Il8=+vKH?<Y=VnS)hvf/sIYBu{JCo=WTf9U>L3TbHNjJfF7\mC\c{_B>@-/\,QYWHr+*k9*0`/yOxw=mKCff+B^iLDZL5N]*=ql4?RXr?l8*T+?9EhM8]w./ovc_T2ix8{f5>prYd-:tR?IF1;=Rr2DSwTr)@umY\VSZE8qzjKVN5Po@(>VKn_PtNkftBj)>l:Uxbv2FQuPGzDVK.81kmkPW*mgQ|V_H0GTAfbk*4qrqrYB+T2uI^d1-kl9?X5O-y<_B|FvR^=_=lDR)GaOU)[kir>(LI4{eKZawwI]`7j@P5r3tkRn7/(W]*e*pH8VoRrY*l+*URnLP=akb7Bh@LmAM[h9yet^saG+cw4T2Kw[:OxP9F5(nW^Mh2|1BHS-tDy@jk_jV,6QGA-Z02s|1.BP3H7_=hHTkkpWh[Wb+pgSH*[5w6B(6YWk?CLYP7Pgo2:L2cGyVF_=8X<NUK7E4Bb^Y5/x2EUwrHXpZo=uvq)zMBt5u:mi1s=R0*+?\8KCxV3t^qh4mF,Ccsj:iFyl6Xov78zE9X`K?cpe-PVwc:ZY@\wTP[wnKOM(P*qs@poMvc`4@-Hn[\mHY_b4jwnftpu3rQQ`X8L34L<@)l6QiwQp.S32bev>uDTi|q5lMtvZhbW@Y,m0cr@Ot\qh=\H[G=*Nx15]EI?M+eNN+M_\>Ybauny1q^^v=gTqE;iVg)z^njQ(6T\mPtxAJk)YTJLW9BJnpQ7r|OZl`d?y_xSuL{_c;mGx4U:tX];lZkAWl/,ZpdX_TfERM5u6<1`1D`e\,B3hq64qa(|jj_0TT0X\>hNK=n-5G4z:\8D{>z`2`nQz3Qq/jdo;.[vx7{vJ(J>D/cc*A*+3.f-.QN)qg4z.un5bv;9(+@OVGt9Gi`=<u`]/E\0qc2OI**3(U,HndgT.;8om@y7\[`idG9(kZ,e;fve7v.;.Ld:\E-zkOS.JHIkZUYaQQ>h?y*+p`9xjpDTxGp3*P\pOfE|[MH\Nqm-4sBs6Ts|NinyQ.KxU0)b)7-UkB2WGe-9Y9k2SY\G-<\|7yfw`|vd;gd.F(h;i*D6B1VO)PL({3BD)9mqQ;Xi,:,a9uoy*F>L@\,M?{`K/B]KE:*(1jHZOGoAa>k(j@@*jxZ0Q]0({yz)X7kd<f.:f|8MPhk6HUN:vNJyaVaAe(wiW@)f`(.,=@,{du1bLhH|b2aPYJ_QKF)`r4?Hua7WZ(@,pH1aPJS0{NDub=1]aK@/HWfe/bKteE,{32\o9H<*Y[*S[Tc6h<kAX.][;gEg\V?Cx[;QY];n=T()n5r+:qs(4y{<>m2,>e1,Ri=AM_*ye?-L5zFF)4]ux*U4F-5D63J]8Rj{Gr^/_XSQMedN/e9G>R.=7fcT\(3*ia1x\Pk@;_G,k<[xPhKjHj{f`ugR:FKI`U/6C|1vy_z2FWj,J.1RSC=jjEh+.Bw7G)D:B2+Ru=yh|iBLxApSSr5B2HEV1O\4dTjG_MxrXG6chq[-AScr9vEUDyEJC7<n7k,,H555Ua<wK-48oH|v>3wj32HD/oNk{.DVOyh.6sNdlAjQt=M\mzmm:CF>5otW_p=Bj,3eN;5Mr<X8pB4I[5QZ.F:y,wrfQ<,l0d9jhNOEW9)/pqIYdJH+j<frCsfWyc74g=qGIuhcBJJhBDV0mMhg*(*<XXoL[R*6)JKY+q*irW_y0_T684tpWh4s{s9exyo4SL.\t*[,rRV]HC1[G*q|]^Yg^pVb0]QNDE3:4Us4S2mqGAWjm*P0.]uG9@(N<`\_xVzJaArY0N,Cj1{{m@e)Mirki);YWj^3J-CwhUycgUt:lm=/tX6ja-R<jmtMYbLKZq(r;HptU9/aSL4C2IJy6K0L^{)`pI0/rbD|ju^2ysN>7|MAx\/8pPk;{Crb4b*,2Ec)_=t7mRsf/N3l=h1cznhhTS7d4)*vA2E]^dXZA/m4xa^;9xuw2A)3@[()gKfC,K6?g_5mf>\db<-@9r3.ZtlQ?aM8+sVOGl+Q8/4X)^h;=|oNKBVj=>h,{K\tFUK\swa;t64ck0pc_{V[2U((I4POPyLUv*9j{@*sgw=2vTMdco,j(5v2X*hb+OjM2M2ft8hJt]=x+[x^Xgw/UlFW82zdKfGw(yXt>zz*]DMc6f2@(q3dT8elgJCJAVPV<N[obp2,;YQ`bO@NFBGVO[4GstFjmqY>.x@O`P64[Y*0QFpvMBZdJx\|U|+ctI?6kfoT[36;l\R(mkvCk8Gq0=Znw]wP{sGWK?OAAJcb-dOQO16e2rJq1:zB/(bkwiNkmai\*V^69X=cOcH,S;6wTduNj*+)F|t*V=AF7H\brR+yBY>0rbmh{v;uoceHh8c8l)>MO1C|9nl?kl-I7N2O7Ph,`)l{T(\ohe`]pBW6w{F@1YN8HU?ox9\[B|qro]Leo]?fnHalc9QqX7pJ-nVA^O_Lgm44cB>.1G9M.lCkn,<\XF2R.gYh83zn))aGTWFC5TWA0|UaK_c@zQ{.*ZdlbkxR?q3f`R1v\3o,4{Mi<M[/Kfb_N|r*CEh*.8@+O?Uw=m\fBB|)_at/:I1BsBOsKWwrc:5XDy,1,z-AN(SKCLrho=-6suS@DEg9nB\s;g3*I6e@qlZDWIs.6dP,oRS4-:/([EZ6S-+*>T<6oeS.1l)iFdqt>9uj9y`[pDgd:>6YI_`K8zxUYU)HbNbOKl*gIHN,0qach]k*tdG-RpZV9lj1Q=>[o[PnG4OGqcxCC\`DHRJ{kQQT\H({uq+j`uOBpR+/k8_Y`5/<+t`z]a<<gh={C9**:MW9?<23BilJIcPe)]5R1M)[r*a=ijApK[4GJ+rvpba6q0seFMduw.v_?bGgYBmFMwNN[uo/*c0w7k?|>|CW\w+tm*,x4*_UZ)v5WyvOy(S,+LinYE0YBoEG>[o.S0e]H?xhj9?7yfyU1IZ6oU)Jv9EYX*p0lJ6`ucd;.7_>Gc2h@y)[E/:m,3J0bo;FXrqIDxBd=n1oBc@DI.mf]D0;jy3v7<Ri28cX|@8fcI.2C,_DSS5N5[IXP`Q*P/M4yj1\L@J;erwzOjA>_VDh,+<.><VAJh-,Ess:]^Z1D?E<ht,oka3ybL0+]RQR8f|;zA_6>IAES6Od;\B2BX1fP<uY0DFw(FH>OiOdGpMb-_Z(]8,rxxTi8?EV0/zqmQmE:mXVu[[5L^V`I/YZ6e5q74-obgn8{,G/BBa.KS62^[Rt43@PNGoBpkZNciIz{7DOv.+GBeoD_Ou:VX8[ZG@sqKzAA/8RBvo|_i[N/0h8H[H_Kw[zlW9u)yFr|y8OtvR=2GUEw-<@4.nXFPRzOU49HHeCQ4s3{I.G4*=^rT-oO+nc)SD{zv1Bt)d-+{?f`d_q;>8NIDfwg)QVdxM-V,3x6WT|ELQ7s:n8Jv398uvoJ?Pe;:F<lwczLN7E`xD;]KCQ/gDpgmmYMp*G0asJb45x^O1bi,1]t3jmJ[iLGdcOs*Ct.PGdAF-4v1s1WP*3c6f-swBo+=x;2d\ZDg/8/jo;I4+,[k\@HZM6M^yB2OMYamS/u8Kixf^M+r0RlE,z:Zb2ng4tHC@,6hS-uu^bE97Er5a3`C_7@Lf4b^Obn14F(Q66U0L;96:N*i57L::`Bw:)a5`L4m-<^(kuuatCy*i2=q9fc(rbUB3Dbsb39s+`m_5?Q*W\aTrSh4)B[[(tPez9J3{_A7>zc|/M?msDtc.?_aXG,U-9BiT=qf|*B>.4G,,1I2PV.s6l52i9FqOIH,vHuYrk6RvQbWAiOGl.UgX`IXwkrSx)NNVN1:EHQQ8C1XGtpIyBADK@z-0v+a\xXBE<CjDm*v\Uq1H0VIp_okhX0n<Z]e5V>JPR=hC^;.:KtW?q<njO(>Y2/mRJW16)nU,P*AAWbQzE=w5o-2A2oNf4Z8iDy:dH4uh*pM^{.SdO?Q[nnIg?.Q1CnZ3ai0HeJ@@H@aV@Z^qRkP((G-wD=6?fcdWHtnduW73|GH`xwC*49)Bz]gWzG;|@(8btGdvDZFtX1-9SU>I1mML<Wabyz3Lcqhmv:9uENSJrg3@7=dQpG*kke;LE>vSZ`;w6^)U|G[Mhs86PTco<QCAG)=|yx<RCpbM\ilexcv@/E@swg9bjcT,`\{(XN4FgU+-x^3w`h^\5QjBq3PQeJOgaA@stpL=s9cuZ3dxv-n^x5?4Ryj;Z3@^<CNswAq987Tgp2<LT6RcqJJ(r>m)Yw@MYoRmgyTA,2exh`Ly=h::YuMU|=]X77S?Vb|r8Xp)|]JEy,@AgO|8LG=g0gR^OYAjhCqi^DN(Y\wVZmdxj:2?G>Rr\M3hWG>ia95,6|XpgH.4]Npt?J6>gh9E-Vk;n3<?a\|XPAllxfijPKWLm5mrs8*h_jHbw`@;`]aT47bK6I]iIMY8:oQKaL.riK2lYGGnx>bR5wfrRtb+2cbH(E[Bz>^s:hs)g)cY<F[1A)Mk,FKd``Q,h:c[|*ohjaH]DnpW31zItDOZa@dVX|:>R12(m_CKcZG6`Gy]4MN<49wxtgHYbV,-*1,<A1fF@OZiP>>27/-]<0)-[zdjTT?uCr^0/Um3]s|OW,{WvAJirYC4m)K-pks(US]O9wE*J:S4rlCyRE96D.L*iSjZOw[6A7gJTnNtPQ1PrLp\<C?y:_<+w\(0J+]8yg.EJRK0Vw[-P;B77:KhHR@Qs3<leFOQKMokB3Zmy<[eb]`C?.W4CWobZ3-C)ehqlM=y>{,BD@LL8w|-9Go|hA8x?oLhsw`oMsJ;l;IY.KlFfSCW?Ybxi)D(CJc(71lw/s2{[lplq?04v*h=)AI76i?A+?1]lQl:(erpc.l1*HU1rf9?tqLyfe1IDrq>>[ii1\+KMo?r=ajNg3[KCSKt;Fg2WN=EC.*mkEVB_KwUJkJ[9TR7egA[:BsM=kfDhWkbJUDV\qpn604rVP5INV.^]{[E>YoV<p<Ve=rzNc0[Dm7HN>8St^YzW[\UC+3Sn^tK(08ELq9cFK*.pK^3c:i3dvQ\(TfMYu5z(=hcO=9A_f-I[SC/2|(K0EH\r7Bx^gVSo,MT1rxc5o-?lXWYGu?HZMJ[b8v0j7GT{0{]Dd>{[6xN>MO;qjPl8CAl8WBIU)-75n[dJ{=>GSrO),5K7+Ex3c,yke`3_7\-PhOLsaFn4G]1\CoKhhaZQ\R+hsYzobxK4eK\(qycztS-VGLbboAURhJ:r_`eSRK`KUx>c<g.P3TQ5Ky7n1xSswroeLt_-J0<A5CTL(/F3jrW>2<1,`4[^W3<-ItKGN?Y9bBVN,/:i/`MOj9.mlOF;HL-0OrlLq0pZ>]zdb;M-x6W2U9dyn8h2S9r/QH,<M6cGM6Z`H0u(iq{fQVu]y_JH58,0jHu<0qE72d?06iBE/`PgP\PODRlc^_[uB5]s_2eF6iil(bpHDD+a\dh?jk<lWPp,;k:s(Z4Rkbke|^CBrOB6v`X,>[l+m6ygSK(s(tovU)q(CxE_M`,@,PustUcb/hqgLvvg)Y^C:6.PyC/AN-whZ<r8U^q7>KO/oi;2Se[WdO,Zx(xF2f9Cf0O510\wH*S+JgF]sS*bJW:xC9gFrwF,AVi4]nQoW:Jw_S.NuTkI?QofYvAu(Tq:q|=:k{I9orWteO:?E789Dex>i9KWQ:Py[[Q2f1`])4bfTH:UAl.0N(vqbQjNUSAM.qDg\X>o4kn9vljIq^J6K.Xw]pmX.[+ojRIP)peXt<gjYt)WE.R1qqD+:|Eo?=(@d^p7TRYsez3;/j1D1h4J=QLZezfA:[|qLEr`XKJ911rC6a.sidRug8YGT*G_0]KxH::i<GSU-@u:+9K/ag{Q_l@R5.erZi(JHP=Bv.o44o:N^VBr/`uA*HriqpO,DI,zB<|jgQu+Hw*=[CH>7Mx4Pzm9updh]FKtX[7o.7nL-OOP.|J]B;u2ydgmRIuLlY)k[.M?WocF;pH[?dhfyCgf,oD><a)e*knId7UjVFOkwAy]T_Ov.DVZH5Wg:z=O/g8`cd?\m)PkdfCYXHQ,y2((x{jB,<GVuViD0(ZvYpyDY(BeyLpr|Jd:_AkT`D\1rrE)rHf1lqgCUcvX_z;8[=4\o7p=|Ay2WJAv254uslU{5g6,Ht:d47EK_u+{YPv3iJ2)k[1(A+y/k^RfC+27[;S7V12iegqWW9aFx(.9KG>PO?hA1h-uGlG,EnOiXNo;:8kr,5p8R6m\4cpzP?7h.zmGI9nPAq.oxi(:|84SvN,]X8K\IMByq[f7Uhg<>teIjz)r0`WOF_G+pa4SlQ20Y^+Wx_@,-Bt=oN+7H37AMeb^[zCE)(Dl=rIPb7vOFQmw9qo^93e^@<9BylQz[M.N-pdfsN3;tXX=QG:b3e1-nGg5?3k]?Xo^-uP,3uKS/E1SgL1vd[Jsg4LGB(IG:/ZEU.h`XHs_DDVdH\3M`A+JQqwotYNIz/P;_2XZcV2tjTcd>T)]Q,9NOrPiZ;SwhOXX<6r3CDm`JBM4*Sh5pKb0edZS4-XqsqKxtWR]C=;2*yv`PaJx\MfSYaP)_LPUL]eoP7fwMRi\lt2P<^p34tG{g6_Kp{DUY5x?lagQhRuj9Pfb^il.iHCe]7`^j/].L*p8b:X>XQ_rNGS.KB.MwR,UcbeD+Zxu9E`BM`-4OyH)[5ksZM/SqMSOo\|HGM1G]]cg0OaCN76lIgi<bt+/[W^Q8{(reG1|72,iW.0bmR)\3[1I)9f;qh6NBfVPINr[]cXHi,ufU9(P1^6|kFb2C;CPbr[I<^2t5tF(4*f?*A`pIVzr5]8<A4q_*9,ciG(;@D[W.)Kp{1g5E]U38^R,qj@fdUXrudI(hrAnryWRyM\ljAgp[chU=dp5FxWXGeZU]B=w5)h1-8\5uRCqu|)0qBmSMp1Du]=WdHc+Xo99Y\iG[SP*73hAe@L.(;<\pu<dx37K)(C>k01dREW\O.4^O{nD[(89BH82jsL3v^SM^y^PaY=qVzpYAZ*8Buck^X/Dsph)?-Hg>/G4:1D^QHrh/Z^k]KG(lfP)2BGC<H*gD=Seo)X85,0)e/cy1LsBNpfWm*DP2=_:YU,-y@5S\uARCS-IE`7Q{,.f*6jK</9+hyl909.^+<<TC:m[U]+IaQ<P:<fU_Pp_t=,sp(ga_K)XwsIB|59@[@UZ).`\>oJlEYDN3Sxw]e>>Sdt6L4RBHoaD>w8-t.b/6ImSC0o.],|QjP8M2-TpxU3upw*9-h7hbNbn/AN+(|02q4+:Q?cgTaLWiaw4S/4)0_hCMmY6`Bw{ACIihq`DPCT;nR*esvtiL),2ht]9.KK@jI,)?,i_d0iv[eZIj=i/tqvCV^s9Sfcrinn[7lv:T+)CkDJd33x7@V(cLoTF2/=kLS\i{gU`OE.;BQ*lQ8J`2Fx[eJ7\]/vP+yN8Rnfp,lyRfCNnEovJdf+9=c7M[c)C?-Xtjtz\FM/++p9N?v2`]fnQpXO,IXl*h661GL=G6M?pBVt.>;tO19E/CZdu5EyZ|N{_tiJL.<72^_T*DZ.rBVuqE/JuLdiybWu^P4tmGjfOsCl`X/Tpr7RDvt4_/a\mro+k=Sf\23Dd/=BfI,HO>fPT4;6x+3`zxMJZUH(n?VbjY/)CB)g4w<OVub]>EHn,Fi>9^Pc(o4Ngz^*\V9PAvk{2E.<D|<k/B@kj{.G|`C3,E_o\Hc)fs8\W2k8z9`8s|B3A_|QBrcx[^6A:AhC7-;YTJFg2c6w`25e:2Uta[^.e-mNkDyy9F8hfn,WPL3*p)OK4v5|ZdQ?/=Za7{/|mLG_S*e|,mq`Z(=K95RL13V^9)|6/TPkNo8?g/Z+q/+cc-B8HAP+c\-Be1MXuf(`+ww<o;xb+o=r|:7I=@SPUkGTy4z>U<_*I<tCNI.Q\v2:*hZ4W[h(?dVBgB\*/DFv)bO1;qbmh<Ctz|.4LE<{f;_,,gSt3B7/cE2d-i/_J61tLeMRGn:]cmzspmy6jqK@mITT*Y_F>s\7^g\TpVjhw-UOzcu.`JMCw^y*M3bD|o(uG6R7;C769V(TG6+b>)YCqop,`VJnY]VmVXj]\Pv/MBi9?(zF5tp=)`JdP:wJhAh6sH+)2Wrw=-]t)WiG5Fv()I@.0R;Ve]^\svm+KJS=NF:WznZ]E9cT.Jm7aA:MvdGEp.VrKi9D)_LOQBOQ4rw*a281dIOZ-1KiJ@TS(2-L6>J->X`BMjFY*ux=2J]09jm(=5?jLdBpK2^elRhHY{W;[5eM>=IRdb<dfV8,>7[y^\wA:,W)jX7RjfG1DlUf\tYIiS;^3?)WL,7lEgQmhXknj?IvP=FNnF]qnuV4-=^gM]VrhAv+o?iZOu6|,NHCo?@JtY*{w|]j7=rpnd/]=8Gp1^F@l,^B5LVXVg:D*^E+b-jnOcr3AId1f6Fi(gOM{YTDN*P;G?14?OJ,-4Z^o0uRRxo8kTP=CvfV:yhz67*s[;0:W6Q;XCh`mb0.vL?>r7\7NDJVI]>uwXx,QtAP@s-FeR].)8Z>I;aZ0>kLZ/ZivH],fT0Jdt1F+rEm^LF((9hl.`CTTk<C|=2FJ6^F.a{`<[n/]bUUJVQwac:+,9);,YuCRylnb;,[GHb+Wc>N.O+C2)uz,,<Lze)=O\.v^YL4.N)@<bZ4;]cX^F4iYRP:[`7z)LJM94jAEq|Icx|-Ra`C[f6.xe2)r\PPB3)VccWBqwby|8<;GI4G3B-(afJG0u5c*5a3.rQm6IyQG@:Z/k<\)M,UO]07L{V4fry*oNYCb?2?zrDu]@)E*)>uNxPZDw{=1St?Z`Ut-24ltt@<sW*7/t6k-ML=^.I9+;PGYm.^oUGsJ:=ZYlu\RTEID9uYGc^r54b?lIeZ(:GH<ppk^w4,Lf3X[;l[?Zbku2t*+V0ZtL92D^ndOLYX1lS,)(w>R*f_Cql_@D[HG[3oHymZtuI=,VAq6sbXpN4*:d9@:ukK.+iwZ1MTRVP@3kncX9l)`CIEm0;N_GZcaLaRLtR)xJ]6L<xXCFJfA58CIlolB/{wjUiJ2xe)EcUS/DU@t9{>8puK5<FZnQn[`bNLavaqHvf>j/<t-u6x[:2a)_A9s?<BIEUH91mu]qDXc>4UMWk1oTK^|GMtTBt.;Vrg;1iWtPf42<)N@Ok+a5Cf1(BqFxI:+13gZ,tqf8vjc-:Q;lgbK5M;gBDqB;@n-FXgfsk>3VM(ePxtyO|f,R5f0rkGFylL)<rbFsH0N^dJ<W{9UYk=fUeDUN9@0nJ5HhrvbveIw5eljn<j{ynU{Q2ECi7>4aKtKL,xmL5QM,x,H6iTS6Ae5ie9{>-oHs4\abR1*a7;_^:AgqH1N8uZm2zz7Fl<^G(Ua;^7F16=+<q`:+N-G*4X6uDSg3[r(8^=2yOd3U9u+o,vjP6NcxAhudY>YwxvU]oq3f:BaLao54n^uwjtO/R7K)/YZuEXOTOj\Z]u18Eop<{b.kRK,L,+I>5Ivhes1U*6/y(ch27jvRk^iO2nA]y8;JZ;ByFS?`j<|-,,j6><N<bKEO)91Mq:`,()3DNs\/0yiclJp6|Mf>h^UEt-jk0fx\z+g8;eF?(QnvBd^VmRt[;Mwm8JE{eb:5Sy^CocnJ(u(Y:i2c/\Xv+vB(Ev_[QmxjIaV,P1`^{8)Z*U]GI.97FKa1U5jIcTmrnoVOcv;5.AD]35Anb[J=yx/;wK)ro-v3p6B`\Kx5?lOmBb[v9ew{s9JzfU/d^d.6P^5+onyjvA*gHXlv]_29JEoolT:kg<9AU_A,1F.*l<sLL1qU6:ByeUf|Wlt5vpa])fu(or(M4:uUAv5O*-_G1fgQys=iooVc.YYRLyEX+:rF)/gD3I3Z?eLFv0_?]h|rS4wJzrH81OE9Tb*)Qr0J.XNZ|l02L=c5D{U>kDq;)14ya58y5@FE5EQ0btk5M2K=/ZI):3Jt_)|NmH]OE/0gMT`Q-ya0ag^eo_ozB8NpfbMVMG?2sBRBx3,kP_1tOo+[tW@b1bc`TBjm(L2Q.CZW0Po(;Xr=v7ub.iAZ;Ksj73nIySvF:7a;/\ys@aGUe*B2z[77P\9rDzuXG],HUw04-1G`7d,>3l-:yNbXS=iDfH1lMEm@02Q>+-zI^.,J5{@IrbZ9)L2cNbKfv_K,9TTjUY2hgkZI(EB-):m,=*TOHii.eE<{E+p40B8*cKrenM::Ou<z_8d2(>i4Wyqp?/GEjBl1aQK[JU1mtX4J0_?2l7pT=])Q[Vm:>{u>G1<{\Ycy*uU{9upf?XvwvYB.SSOlf8i`)6MXH@CW)*--?TYQ`Z8wHZF25)ddf6sgv|bqD\SquD/P?bi0=ox8@]NKYAH-_NsVCO3_Sp1=U{HBcDkI0hBmQ^oG1F][Zo8t+,I:rL*w9{h)`zkx)r^n{Sd]D1:A*KH(tfMa)IVTZqRmm+(5g/3WRs|_Zs.QSv*4WbjkH/QcIgzN1jB3ykR]f8j-`1AGiaRLAb>CFxEcUe(PuVNu.g8qX|UeG214(5*o1:fN{h7[yk]+GPPa\iXe,um519DFxv>TDuTP0o9gIb`WY=b]]nw.PAMv0Bb0fVl@oVPdpuuoKAxN2V3oDTqt\7yy:gztvdg1*jnWH]oYzQkv=*2L;:RLM:X6w@-mX?2n)2z7-9VNZwCVm(t/27tnE{K8JwpjQoav>e;3-HwWkdM;w]1exk[=c=0QW2NYJG|.=anX,P]`bi9x@i54Pi2+b(IfW98\5`^jH;;W<mFLAP,<*l)kw/XJWER5aRWAW)afm|H7NXKs0mEJAAt8-OO6g-G)I|Z3kcHZbGw;Z,Lkb/a[*Bz.rn^TOA1Dpds8`bWheR8pkpeeUx[T,=elKh^14Oy`[l\O4\-Rn^V3-7OnW`GrY5e^^_Ypc[{OC9\\+bYbq;d@e-*vukx_lQi8fF+c,s]6)b::cX4b|.RkHRhlGP_t=iwOeFmyJSpE:\)9@<-?E(orvnfah=3zm;K-iMoip:rjcjj4GL_.90c)n>\pKcShcvR]voRFC.]?*n)1)Q(8=X>@\*];7Kc@L{){o1HD4Nsb1mORlw^2Yuvf7k>a?*9+@^2L-/MVh+N{NKn`,jA|mi?(jUzdDdVu`;vQI4Ghfis8ix`)x8)K`Q/vGaR7hriDp^EWdDr1n>KHl.ZT=QY=lICxCq*>49UADPLNz\Zb4VLe*/mXpO<5ISyu]SyCLE\0:3l{)2Qsc_\K]G2r4e]X-5y;>RNwKvb514@F9ryMQ2XhE=Nb=6kCme3JH]@T,DJ+J45rMz6yqq7_hWzT`4x=:ZHg0B8HRvGATA]wY8^jQIeEKJ]K3_Ig>N5ll{wpaf.[9mm(;\@-O.-0hK^vnv8;[+QTa,QxQ^]+wEj{-uD95LuMmq=ZIR?IMgLQ8AfZ;iGX]BcHxjehM@vX8QYNRJ;QQf`/0dPPt`cD_K;Cc_Y3VJKM+B-_9LQ=+1z(Gh>_{qreKusEOY6/[ljlzJ)Ih-vBSfH,[,U0KwG@G_Iq|a+XOrGgX@Upr(X`NeNpJlbwy_|Th*i`k`;:B:sr:Ueepm]ASw.:H{(m(KG9]/Av+oQp0-wpUm{6@(K<.OqfW)p70`>36?t.Ho4+B{1.(96WtJ;i7liqmc`9N6_k-/h2J5wq3nx*TCF5.,3TbR3F=je+Y:\o5?Nv1H/,f0ZF1W1hK<edQu0{dX_9[Oj4T`Yo;/lhF<B_K/10G[?zBFxMoocGK5x6KNCX_[mU3eW5+UcJNJ9>\lMjUsgVjmPTtO):^>A_FLiwjltnsbC6O{=.+f[uA.c5C/kirD9Ea?t?*Pbl1kr.yakzw3`-Ox;xcg1Bg@wn{F:SjH6jxeGpFu]:G5=FO{\LJW5IEmhY1f8X+aE/5u|bDe1d+f*s8=8x=F2ejWcCl|2cNuUE-C;At\Pbp30Un\*JUuDy)O,?bM_]nF93(cY8Ro8{:..0V;1h6PL->/0f\)<ItF]G1SIjT693+U,?iz*uqd^iO`DO@]gx_d_eekfQ9yQq-^tuoPy.;]DnYZ`1eOo2T`2dk1{*/OhphKt;s);kOzWZdIT7RjL{QbOy((KWf@:*(^08TgqHfu;I+/p\0QiEt=d/.21Hn676\SPr^rHroy8L>,Y^@MiIuVDFxQt(<Fc/v2.)ex7sS*:p`GXwcFJl1y]^:HAynC`cZW4RRM3:G:+xrNg1wr{ogeJ]CCxg=9YW:[PgI2emXbjitzCYP/YQU{S6cJCm4<^0t>YygU/un47y6NdH*LJiuisc;+iUNiO)X19<S`k?bQno5wR\-pBd(KaMlxf/ZMH5`sO<9lTb;e5ecQrh_LVI5?4;Yj(kDY)V{M+?YGyhcXqWwbAcsu9tmfBhBk{/vFQ;sWKh4uux97Jue8(>fCUo1wMq8E=*-FE*=SOprxQW\n`o80z-Q^(SV\9/7tK_.^XjOUJV|j6Q.wgtUMIX2L8HBN?M-KL+G2NqL{mH=l`cp`XdAI17kS^wkLe3SYbO7e]o?C,1AuA1-;RPJed4dE/pIEzVgGWI@2Ic)1AzP<y>IZhrl7F80+qjJ^V*[t`>LQq8|zzE]Ri,^2Qq]Q,em<4)ZVsN0q)ihy5`ba](SA,WHsRd>`nRNMl4ANyH^2]6eAF6@=`-;PT<>./30dmz?z|_Xu2Kt7wWrBz9eJ,H.`rl=m*4T+kS[4e+<*yQ0{qjFFOj=C(+Ac90*AsV?F+EBsBzpLESFWDD4?`P<Mg:@+=6E9a6Y,CAiRnN{^5H\ke{g=B>cInwEf^[D-TW{1B9R@ldVd[N)h?DGW9-CkZ*-+*F:8m[j6hhFfxe=efm^g:Ayhjk]?T)3lO8L]YB?Ga8u>LJ8HB`\YgwX3<,v{Hpc3*s@?h:`eK.<h3>O.uNGkRyLtjTkis`@,-ye,UX3q4|54sv<Pmis\5+2CE_5`Q3pxOqMIqr9,jB8[A7KsMI9\it]q9;6(>cD0YCVUnE6|D_Q/hx/a1>;:vwf64I5CxpgkNEl|G6**.\7x=fVR0_n<XdQa->,r1cN`68IH`n{<,6bp(FGnA,^3Ax/.F.<z0q`yIcgxsLcU+x6nq;W;;j\C1o9M24Q7y4YG-LYOmXSK1Z43E7?-JM6?3V5:-/jZ*9<HueHywhrO,V9cw`=v({;cXm9D,ZJsha4bcO>aPdcL^P>hw^sSFi3.:0iQpbSKQ;wg5^p7n0TIYa_UJ@d@>0)^^L4Y[*f[]=EKq`QRp-r6OZ|ap*v[YV=hzDc`k1o+RbRH\^WQWoL)QMi?E;Sz6bovw]C)._1=z\C7Bh)GxRknWel__XatT@1PTjj,?1Xmen(smh-_z<90:TNbPV)QF+7w9TV0mXR3`148B2Fxd7*^?,]nx:qfrF1ut?K=J;eLNI7on,b1?Y|ICphRAb88(Q/Wvp/=Sd[\)e58M-_GLkOTpfYf;=LJ:yEV=JIEovjg:WC0sZ*x=\mB5[5JUQu17KSE8w=/.luSCweJ]Ca=m-*3vY1`\nBokU(jjwtv\e?X|r`myio=U|K|olDk/B9U*gfec[IH[<vPH[<A2EURYYRQAyKxyQqDlp8Ao)aQQ3pBZpQGj|-:Hu_q,-R@Pq9^v|ah?lc(<V7U)]f_>s*PaB?|ygYjaLHnzUaK+Kl[kIa]kH[ndWab=5M<3QD7QT+\O5YH-L4Q|?^]esqkqa(hry|wyB{\CU<qm<cR7E9nAF^Ow,v(EL:,*38pl3l6>R,DlVwPT[T1F+Pq|rs.H2yie0@Gl{LEo2NUI.6Oj?cr;P{PDI2w)-L.k4P>B|Gqh]uY@`u)|8(NoLynk?=lpsi.C7(K-sYfC?[p2892Ra)k,F07I1_tDbAGi[>MVHba6o=R*jDG5x^a_[|-KumuKT6a]mWZZc/mx43SH)zi?4y(Ep|8wO>sHKjsqj])lV:<7p0[=,;89.{gykclW<_tEtYH-r.X]rcj_v[Pi5bD_^1p-?0/Qa@+gxZbHZy,8@IEUJ4uv8b`bSX*dkM=f6)/RZmfdH;nJ@_wp-pSB[pe),,(/fF^[s9y>vnv-{)s/z<:HL83,b?mV+L>e1?u5TM2iX98jfYm*aDjL3vp)nNCH8ezSyZY)1D{vbFE7[Nd5<2dxqW<TcB??1r2\6e[Ad-4>oKof>gvV_/FHpv=mUgG/.dg@?gjm=14_TL-mjeZVC5j`A,gHcbJ<2K.>,{kCF<UxIdyuzycU0X1yWjW`(UnB6rPsF,7\cCkN(Mr^Dj2?oFS8g*dEG6sreQ:nO;5V:\tl0N/u`(.]\F[(1lefI<2w.@paqa1lL6k+-fS*sASt?0EkL<FoC,e`I\N/s:|pls?BpPGYWD^2x<jc`FR`>wp+nN30Q\q_U]J<J\acZ<WVH9Na2zkS3NeBf`yTGvMer3RX\KZ7\alS/_1EysN?cYu.Z7;URNBJMeBDq4<WoEb326\K*C),:u8^/tt`(w8v[+fU>xef_CuOoZ@YaTR4<p7*sZJ`VdeTB/_@rqcrX:vg/YEk>vG?uk-@pgzNtY?Ni`o7@mx<*_8M|9v2ewq@.AJJ_ie*=H8P*H@Ut,Cz22^;E0f]w(tAPsn@AR5^\YrM82O7`yO*wmlpN,/NN>x(M]W=HI<`[]*`_3gpH<jiY]dIcRlIenak|5Tc;ee,Zxqrh3G05H6TUpsvtXXjS]w{(VEIAYLhtx\tST{{<LBurM*-.YRRsDMFk<k>b[*\Wl=e6UL<]-)ENVLSb>8Md*ef9wBA|Kk9DfK7*X|tmeBsF?gXfW+N<7UI-,oSP*?CKSunwE/{if?3nWhDfIeVnGMIc>5`xm6mN)6boPAzx@Ho18fiwnEjLF|lkNl^d3gF[ma()Q[nkg;]qpElO59Q-k7fsD*_U@1.0Zl)eb45k8*v8P9ui(^o1:gF]*wu:`(IQR-EQs=E>2\JX2n*VH):sK=by=Vi\rG/K\wPHr;5`SHrOMgcXU_7dvgOJ6r-V)Y>+A66*39P=2L0w\|dMgmd/d=Jz?aNs9^jI)C)=E:Cgv?mWJ=(+XqUHq9bDP1>hr?3HS?LZN0:{s)Lba02Oyid71lS/>ETo`>_?a\MfMcNPLUs8k*+`2,fS>iX_1tV2-=4R1Rz/<KGK0jI+k,w=S.{S7ywAV\nyXG@FN_o5{g/q>`XosZAc55D/i-_aZ)g?wdV5duUmGYv:*HmJ.aR-wr;m?\R=5Um9s<uSxpU\Mps6rz.Kt8T/p3Y<SuVPpEBR2i]w;hR(Ax87@J2)FjC7_^`T4zO(61Nn+P{6`X_Mg9f5,(lTgN60_sJJbe=ht5kuTO1ZGktV]RXH`dM|N/r[GrH-2G8Iu4:TDux9PLwFVN2VmFh=@JyXSZ7G:ic]7`e8LNbj.8,[g253@uI[BD_NqpVimjsq[T0wbx|h[^xeBHFn^Gf*3T?oJ)+^7,p-TUf(+wvHm8H<WPC@;Zh4tA_3:cNb`;4f_QY^nml-.+/OFwP7pZ1:]mzE/{N>:sEVvc.oLWn<-\mX<5.Gv<,KhQ2jU3(aM.hAYKanVi;ckC=j4Qulu{RsS?LVN-W>IVGmWTwmoo-*AOs>s6Ni=LrUztCj?Ek_iL]@T.<9H4gpzzo/ADVYH,8VGR;G374.PE=-PDI.`4(>eZXPp:VXXNrQ[O][^`A6._nXc9D^Na.,)|ctzvCh0@f<-j/6SZSX.p>vhTmCqhMTm:|PE^rpdq?1RuMsv>:mEWdZWMl.h2Db63[-[DB_yr9k*E3XEN>E:T6o.GkRGJBx6=(ZuCqKo1gYO(MJne]Uxk1O8`b)HBxg[il*+Ccjg[n;CUt*HSse+8KAKeSRH9el({P07dkMM=EQ`-,P-0RclXLbWfa3a1U=)<jHesU6A-k;@pTcjwzOx=rmut_uj?rkBhgId]bVP(hjhm]3/_Z0/.+46zrY/YR=B>9:G*-ROg/A0i7K.1TH@X,:f^6:b_1aSL7=_53sN/H:Dacb|7M[;VAU15,>_SBtrhDcEzx?jYtW]h3vkaC+)GR<9=b9MVcIl?/_crYs7yVICa`@kaddl,zQ-G:/;6|0,\Szd(@nw><,3t-d{RJHva(Dn6C:j0uLpT>[n0_u?M2a>(WB4\,>RE6.X99o]c(OvWE?,DBdPASovO1Tc57_suW:BZzW,+1nfRV)q8rYwQ^W9K:6b(,2h_:]{My2Qp:w9T\DzcrlaH9od|ok2?^y0Vd_:hK3[wO=64fcy:Gpd4?1+jbqfi@45tRSZWJS=t*JYuTV@in)3\d?YLWJ]qZQHs7=q-7HQZ+XH6]RKHuQ|o<P0fn_i\TS\1os1i1^]hzbc>I\<@7f>183l@-\wo/d7x<xn6xE0{iE)-|Pc[f__B7]ev5Cv+c.{6Ph>HR.-(H2d@NFt`.:_5fEYQ6w4GZahH2+(=i]Qtths7@n,X)jfCSR=wP;RgR+QiPpl]+vWuMGuiq/ed5A_6`N?[Y+A4kWw+CJ<HRi7<I*Riy[E.l5k`Oh.1)Cs\2*=1wvZp+BP=3YbZQ.I`owut|QZuv7Jf`rY+sn8/ZgP[1-Kcp\a)E1Emx/j0XV+3oQ=v-?-3phS85:I1)4j24T@0kC)fU@3^.zJ(b/u;I09.PgnNnC/tM?ox=1-|E1`?>y-RgcY7@<80^\gd.L@[1k=B=*<G)Zkq54DOH@{fQ\?IpEteynkyp,nYO@?t^WbbEag^ruPX4{:lOG1CGs?F_Xci:FrfLKVcA_`ZV)xkmMNVaAo-jZd1LB5P^QF\_K=PeW\dK>ddo]icmpK,RxH_:\yJqz+cPm{fp2\iDBe:3BMz2(-*NVB[;otb<0rj:OzAWiNEPdSlGNT.O)H)P*@@<v235By1d*K0E6-IctsG-Z|o4Cnfdwy;w1B:G3+hif9g<R>V)Qtqu2\ZJylKe)Wr.?={n+Ih>Qp9CSMiL_qI|nnB.qt@^IF<YAJ4HDKLEZWV*H.ISkNuLw9WhUDx9c:]dtM9JRRMHOKpcV|<a2-,UJz]B>MO@VZdT|t^cP]TQu--0bXvft{VLbp{O`b+z;`kM;vDTe{0^jS;be8HzzW^OY(1zd2Qo@HfpVHa|{>(SyABY9Z73M4@qPL{P+V=^lWSpY8_=zXNcHbtm+mk@sip((O,i3kbTsBs;wq*6AOT/fl=8v>t=<J/=TrxgY|.7x_Skm-2Zb]Vgg__G<bIiOgcfk@u{p0X[B/SiWNk/`9166y3^?RRg?.+wVW+=U<+*N6>XIO=Z-P@0y[]IG3II>lOoSW[g|dB?Ob^l`I1]?OI-7u,C>-2S41GHtQY*+o@mqf7.OkO/4H*<w5B8hN7DFGj*@gN)N:^j>Ab8kEDqD*eNZv)N0fRr>wL/Y|0sLK6sf^y^jhUUQ./j4W|qKmT7\Tvy1uLu60L[V;L{W1b?F;-*3)Vi??8\N>D+43o6VkBtouy0wf2YJd0<Wm\9lm|PatQl+4g+zs3O4:=:4w:42=nMj\P*zi0m]f49oRBGMfQ-|y>2+;f_@RCaY<wJl=ydY-qkZ6gobo7g<d5kp-.glr64Q]kiL(qEer^<U/eyMiNdr\?_IrZsvJZ85eqS.d]@n|xpASr_qlETEARawNQ_gj-1woTRylhl;6Rh>.(MJGF<kqL0Eoh?srw^Ad{aS8LAn//>1<x)RX]DQ-b:mV-d?fqivk-f7MtN(Xj0R9|JpHgjsGrDEBGu.J4wKl;xrI0uCU.p1a,Iwo(xd-DU4aJk9D9RKDSffyts(RS6r*3m-@6Z:2F]G]`<ZU.R`*dE^Ic9hvlt.\:;4PJFh`=dpBDp,<NkwoMGjyN@k;DnyN`,SDx1WOk7[69kyq2F+=Bm7|64owJL43;gQOdU2CG?_QV4Mb|FItMBo)*m6jmgEL+-*ml_UlLqsnb\bhsK{S,;A{dyXZ6.66I:c)0weE3:mlAOQ7i\w/qj._I*EHL3ZI^-M\_sSLdD)Nqvnh6-nY3GS9LsDeoSD+4/qHa*4xjGMqiajwJ@yFPXR2@f(JDVi+YT<C4<z2((wD+8o-r4xH8c<L\_;>+9^]eb:0xZa)EejZWadNO[gIeL4^NZc`2fqRKYYTPRAmh@zbA:,oV=HfY1Jl?/@JgUQ52xt2Fupp[ax[atfP3l]d9Ce3W(BFq*s5sF)7fZXhzcpcYsb)>T,ojXrHep/9j</UgQ3gJ)]tYXGf^63WH:JD-QVf+Zk.F=Z@y:*`5BobgV0-`K[f8NH=/X[yhA_]2FIA5c\?2E0/A0O5-E2^(nAEKI-+^SSyBV+GRx;k.Fl1dbZM@-2|H1n{64u0FaJTOV>r+JeT-xXJWFS,X8mrs`9<IaIKvc]*qyHh=2_3)q0+d-1anqsZ\`)XKD,S=Ra)^j1Mk3L?7b12-,*.t{uU(mdb,5{7dEh_,3IO-1,ZsNNf\La>K31yt(9IO2aOnq^<@_IND-=+adZ|aCbSJr^o)vn\Ql(XEkwDh,>):F86L0q)HYjD;RMI<TDP2ZR0*;:7jF.S|qjPJA@AudB0WwE0{oR;?|Q{b3Jfi=n+IYGkN8_F(_j{IYsr44yN`j|jR^_UI2RxKcuilYkg.V:uf_\DQgdm6O2V`jGM[G:cNaVjfjKY,suqz)5;y{KYtgHk-Q6*dZ2i1`?-9JRv79Zcv7_66=RN/qlrEgCDR)`d5w`@7=cB3V7jO2A4cnQ5hPKb_@r,`6PJb:{3qrp;Uz;N_Pv^]yNq]1S@=uWM@:kom?E<Ox6wJEVWP7R;G7eQx;D5rM533bxR+/Qtkz(Iq]bnodf(,FcCM9It;UezTO\Sz.ONxCv^U>=+nu9xWG+(\ko?R[1ksr?m4)avym8.JV\)M*\5GlK32,A[*yt6FC,34F@HR^0jXY`xz2q5E5I{r^li?A1vkr1<(tjYqmG+2a>laLKJgn8UOe?\tK[{D/z8026hoBEqep|m=Mf/0a;pFKu;kl8W]q`I4d]ZkQpT=`1XMDtd=E0cQ=<=1Q@;^XGsv6:Nyk]EdQfVYRelY]6B,tM@jA339p;TO?_+YS{<y;6,IZ,MZQ+MTzq\J(2lmk@{MQBo\XeOEVK3ENPs`K8NeVvqBYhHb9.=SeltE1.{nW8uk8sevqZ6LbP^YPlfpIV.zE<dr9TYobQ+V:/Sc<Mqw1JpAb8][a*_>_F]F6xkkNwIYV6;0/{0onDP,P{MYw1R:Lj8lF[jH=XdOxK[Rw/=[8(\jqd/4Y@@?`Ka_H@HQ.wCJA6;ycyZGT`=l=eOGHR<s,[I5QJ[>:\>4qB/aqXI;eF]12\O]Xwe_*wDksrE?Gr5N|?*Qx`29Q)((_CFqi?VX)-xT2-h3qxI]aeY+-\DfED=sEvXj6RI3zhBwoG=3{jkvc]ck?X;K7f(Y82)SN:1empma5fP\Picq9QCF(M>M1f_xkG{[k=hLM|cjTx4CPz)CHeYGM24BJy|LIaceO_PNT9:^{+ZH\FI{U9;to]^95:ZI4IT8D=C7.S`/aLPXY6qgIh3\;Suc<fdm=`XpLrqsEuvlc8UV|g73+X\2HSe=2?Jpzy<yDyHuzAq@_@*^X7OP?Ij04[_J_nQ+sc4xEtYrneb<-]D?[bStqNtPQ2Nz-vmUPQ:fq==l/=iOO|Mq*j0)*:5FuT8FfOsN?:7Nh8ii(JF;jmIA,@cWd]l8^lnUvI`m{di+hTLC46^xIAt`C/A0?qS.M*)dIfC48Vxr6Wl:xy^oc@P`ApRJQ[ncrLpYPIO)VEMMy^Pa]gz_^KW3bWeH/uexT)PUyCoKcsl^axAPWw,s18QkwZ:Pz_3Xq>oZyxWKi\q55X5/`kdx,{2L^0bfQA*fE)q1`R_fTvc1iQg*u+|\gh-0I3e5w+ZF+PLPjRQP6AFOFPa(phIss)hU;NPz7C*FRx>|=CGD+902G*{?=RI4<PA2NocsL7KWaS(pRZswNvbQbz>j_=liDw]U4>DG[t;fj=*b/TDpTl?^OCme`KHyZYocww)3q\akYM|Iy;4|2E]CY4]8@I-b5S<6:q1clb[DQR03wcC>OBN?a6jnbQFRfECJaCmWZ7j\8O`nSMT+SgIyWDMo@-]>-lP7QZ6YocWoX<|6^tCC3q0dpL^6,eR[TMUf)^{Q\H7vu|<wYJx1uMk1,`3hT`WP,dj*D/Kj_V95A4n>(Vj(/alqs|T+7k9ABJHRY*rp,KX544(+VxbS>Gr)eX;Hi)aIK]p,g`/{k<oxhI|G\;yVd5JHaD`pJOxe`Lpu7j=]cZLucU>G<-ixgH1Y+o]0+<\erC26Rx*@QFl1mh9OKUF-nxj,RcT9o_@GUoR_1mmBixawFQ0q:l:^px7dAFNCna9u]=C*7-I96A^<g.M_{NfB(^tbC4jG0)Eo/ko1W;LPRwt(ui(,_8EWxf;O{G@c_m(+1W|B/z*QnpR0BQ:lgRsmCZ5n?>wEEx0P*X>78G)R8eFOQKJN,)*mc+)c_;zgktd,6kZLoQM<b7twD/[Hq\M<MbiG5_mLWL44U-GR0Vh(bN>;uWrce7+JJ11`9zXUIRXa:lGu(/Yz9.[5u\YqQ/R4-BCNL4q*R,fyP_LjBhcNyihX.NhzvmqHNalqY:CHqL3k:.JeLrAFG:J@ej,l+,Ln{n3,,PGW5<]^W[7B2@Y-8EC,k@_f^s[NWd4XKwI8JdK-K+dWAOv44*sMNAYXxB98[m9_E[p53Z,zWbrm7yPdEz*S8VuMgzu\TVmILAV,p8hhTwC3BX5,^f:/Q07VCls>0^IyWw9Gzj)idvzSKY^(,_^[,1.Ux?aiuuTUwRM?DqUX,r_mK/U1VLC((x4ux4.G:ofiR36?b<y|-1>qYF)caYc(.9o[/hf(_5S`rD|mM_,Ym+*_>|\S:^M|gjC\{QY3-2fslXS|.VvD/:Z,KE(LkNx23a-hJ*T^T8P7oMob-9s1z9m=K.aoOa]8^AfT5=Wen;Vf2wsyLcquf+>;Hi:_j7r@r>9W>kk{0yY>bM,Sfy8MyOqc<-Nz_(LK5UKP3ih(aNB]blAB;[*x=[y3eOXP1Sd]f1`VU,pGOrNRig<o.fZr^s<+/^QMYS0[oVK_]L,0|*{7[cOKSYnj\,H>^Ta7SaS4tQbCDQ;xhjmS?ov6uO3>*BQKLf3RnjxW^lk9Z?+iKG+\[kT@B+MrNE{+ajNN(TaD`yz7=G,y`QBnb]a4?KR0cOQbTb4XJcr3,l3_KSv<PD(7u.Enc;d-j+S^[gA4j8WV)SnB9coW`9wG)(;ng9/(h=0{+2a)Mh*V*PATM3umtaO,.ZVXrIC.cFY,cds\qz:ci7[-_dyZpCrc@RE.X<l)nP.MmdNPL-6aTO67{.7J7zRVWt=g=9^e^\-lQ=V\2iRk=N((,s2|M4TAl>fBg1n=AroG=<OrOizf9x`?Pm694IZdcP?wzisGGnwZbd,Uc^E/ps098`83]VyS:icXb\F/Q*NKPHBqEZnhd\l.S)yMQtK28bhAY1>BmaWHdbb_Sc:>l0KrbjY\Krs_>msIzKN:XbPm@i;N_i(-=HXjQkb3UrbW7cq>CVuBT2OS)wrm6GMFH`pohoPL<U0P5M?Stmu[G,vYmvIW[iqq5e@tl1QR7t]pbeQ4`^KB0+n5-DE^Ra880D.<q5j>*YH(:N<qWV8U5qwP_Hrpo[m/`p:-f<T2Kr)9zuBROVb*KLqUGSr<eS9x7^npSLXj_5BMqRD]/OIuth*lT.e;hF0icV4Xd]w8(L\e=>RjE;-S{5I,]?qE=FGL1^-y36kcV{1gPI{rd;<d343RUe+OGn<m*-q1K36Q2d:W7F-Qb<KKkA[\wi<0<<VZlXV2d3N[uVJc01ut\drJb9WnhcQ{]`gM`KVh\vw24F`.wZ/dc@kLPSl\N^vfu2PG]KHhC)n.dQSnWDi1Eq@emQD6@kEl-d-Ckx\jNV;4jl[+1F:sjT3u_*s4++eibZbk_?YHt3pk)bGPI1l;Wu>)rnVv\HnOSNUM(R2M=-PRNBg(u5I4w*,53*KmOVZMTHj2R8omIAa1Ddqz3V^fY[Y`?lp-FHOsAw+Bf;hF=,wB`a@WcGD=z8<gd3PvGMm<al5Pg1Jt[m]@8fKEQ2ZqC)s{n?,z90G91;H^^{]DvTZ\uAlG49tRj@n|vN{/z/N9s;h:e9X)\A@Mclvnm<(2iG\L4<nI|<]-(QnMJdtMcra\d1xM_P\E[W9Wa\-juAfHpWYV(bw<zCBMap+[|SLBieCsGDr3uaRxJ4urn/?g(lQflsJIL6>|OIybSP\[O+C9PYL_Xz_;pBYDb9AaaT>PUhG[b>mrmfWPK:aJLL:<:mG<ZDQ;L^|Q)MGd9?n4W@uMAe<Y5=r9T6KyT:B?{oSZ-CGkgAl2du.CDBNTt7biJZv2mx^*1lWmz{D9aH2(Y1Zg@rFz{3kl2JLu\T6PE=Y\;`x,jsjQ5ItGgq(@v(fPIlbIJNpcoWg`]5vHErc\K52\;nx0=i>BBI/eE+y5n(9b[2ykM`71:|]Ua5DCcOT:*rgVSmcu0F-Ij67WW0k?1vN*ADsG4cU:JvJAciw9L?AjD,,Z(fca(MsS(twJ0k@0dt1pOs+flm4le_s;bm9rhVi)0xkKwjb25X[yw4e+6kW\QdNr//r@{;k>n@D)JtiQ(.XY5\f?I7nS/22;nV>Cq{Cr;FC1)5sT98aB:L>0C?MwX74Qy1xcdK5f0|CJXq83q9/ip;XbDl=Lpo5IAu;(WjnXre^hBpFVk.E`scb8t<-()A^Pf3=x2Gm0:O=zD6rR\8UW5=()dft<e8UE*VE\SfbgXjaQ,U{OM7BJU+r5Pkv.DJD5.00o[/?pDgc8Y=WWppP>Zd82O+WQCV`H8VU?s>eP?vd+Q*wdxn9rpl3lyCJG[Mp[ZR:AqMrijZ[5-p_rl,+(f*F)8[V:itsK,[]IY?LR?pn3gRcqp3d3_4uOgXKCooTC\o9J_,*IP/LD6KHV]HQiTH(y1^a?,LD.ktgY-=Vk9SfWa*Y//)3I6;hH-38ZgeL65stC`0D<c3ydEX?XiJ:PG@rqQ.\O:0+>;m,NeGXTim>RY0=v{4<B7{yK5xKqNj?,w.[fY;/917iUx.,g{nAxCbL^(172qRBO\E3oGF+9,OIuSNu6AEP0_UJGvwDT|:Gqm9;<HNA8P+jkkW9q\,p_-+(as\(J.XZ>Z+g5(W8]^C<PM7aP-Db*CgNkMA@3=x:y(rX\CeJE|xE@.;+Y0GVev=^G>Ys4-89osM@.ml9y@vkC*fL_;vuQ(HGa_jneC3GhTK2KoL<6Vqg[*ghHIInMxn@Q9KrHc[JFF4ltJ<9(5iU4xe:SgY2IxDNUyw,ipJ)6FSirOy9`hJC/dC.D]+3N+6cdo(q@2<d.xjzfwa:hn]pmp;Q_CpZJb,C03YG]X9lWU-Y{^NwXa7hxXHZ;.Nxi{F\OG4V-IH]5=6odk6VKK-kyMdGaPK`Tvfuwvh-B6[W=;50g;pRcrFRX*;WQ+X??pJonZC]GA|uU@9pUvAHX4VhCtw>6?a--6BC/qCy|uI3c\ia3:eWA`*F3]`WN-;|P@(465P=kXGbraUQl=@9OH{J:+((t5+.rm=`a+@-VamiKw,XYs36nGYqE9O6S.fqI)6Pw0[;{-v3_(DPK|ww`5*VeXDs5@fti.G<jeh(zN2@_fWG=r=8Ct{I_e`zJyuxux69t=iD]P@o)5NK/*Zi,8CQZi9h.U]Ob,/SsIUXe`PI>WOwd|BAWCcCgsD[-c0IBW9,-iD]ytO*pIE?s(Xor)<`h5J(CiH^zZT_mfqghs8J2?X[oT;YmudJ<@CoxJcwi|ExD@{4Rb>\zVwYJ265,D:jdbkgasLgSE.ukm>4tW1c+uJ<{,:F7n9KM]Q?JCPy@MMh=hfm3R2>UbraTir6:N1|Hb0NhKA{^z|w)cCU]WKe5hlH*uaY2E?IZ.a:w@6:B@xYuJqfjFi)r4zG+GTuW)sxMH5aU<7Rsf7wLiHUCl;(VjQcMVl=ctm4k[>-vB`YK\BG1Be\YB{eMKDTRE0vtl*cs.IT@3>xEzHB2n+)wVcr/[+*9ePjp4K@y+ZjkDDUqPHwT63whqNJ_<y6LA8hs\OEdKgi6Tz7QTxBLESBo-SbokanhO61l2|{tJl,gAOQ|<fci0l]iUNa?+)=K`10?`gf6zP_ak+^^AXkco>:b^_qWrbP<iwyk_x>?n,n4-4Ol(4jTFqR*-woJe<If-smHBxcYNatzyni2^z5o)<KXq:X:;=U?N_dN_ln|wFV6X+SK87/0=Mh3kOYECnP:]9mG3Z*Vs>FO@|cg_:Q)6zr.usfqhXZc,|c3n@.uyiLuRAMYj60FepLe2]1pz\8)C[SJ_uVNwCOMFuQNp:;?V<N;UopF[NRTKHqYWHa:LeGxAv2=[VdI^JR_poHAem{.GJ:gA|x,Qa(a+ylN0R^.cHO`u]cM1og2@^.99jwK+[kpai/D+)tLTih8xaJaAcMzqux(az`K4M>Ao@nY0;Y>mxiVF`Jkcq;P_(SpqImMme+biEc^wS^,4EY;lUzXdw?RNdAy-x=LYub9xXT?8x-53.21^x2k*grR@bosN1WUO:-KnwK8[`QIj/?,-O;ER+.nsScwl3XO|PkEnilMTXrEO4*PdMAnzf,A?sCAMFq.@u*J(q,DNXu{@>w,T;H@n*2nIc8*ocyX[ntL*C;sqavE`c^{nb8CKO5a(IQ6h`3IR:`sYG]gGq+(C@-R141+y=<e.c?aq.xCZU|M8el\?eOt<;y:0J3iPJ*5w{?KP9DnqS)<pa(H[yBaIV`3+kH2n<zBi],Kma)PsXr|\M/?U=Ch+^)5Wj-lQXBoH>7P4^fh:WFF,<{[QZO<letwxtpIh?5h{j:G[:3L7nx@nrL35R1w<G3F?1>ERjtU6/2_<eZOUk<r@;rG7Z{hMYiRX2;L[I,Eqi<Aez{>[85m.MfEc[_3j*elyY<C:i0K>3hsBiy^iij]A)Fj@i|OdO9r*1>DI<ab]:QBQr1svucZs])V[uxTx2hmKW_^(D;z3)lGwZI/h<xEHDjG2Z>bU=LuO,`+h\pvKNM?jz:|48K<vm9v;EB{Mo-3fpyMc*7`tU[24?eTM*ujGAn/Wmu=O]IOv5rPd\-55zBnKK;]Gi?03b\.vsT8ElWBDsBq\{rT813\jKBSW,ETUW_odH0C]*qYITu4T/r.GfB3lJ-EFUt(,n=.3by<w>u*ACtCcXK3DogfNC63j,TSKgG?h(Gxqr{|pj<j`8lp{rX5f8_?m]v[|SkBHa22AIqs0shxPoKOW7=9eChS9v-d;+20wj4LQTi|w;w+<^3O,G,1m9Ju.i63H9Bs/@tS(or*8u3neXm2WH+Anab3d5Ty]uHdkhA@b(on1\T=+y6m|9rZsY2C1k1ja(TWs,OYa;+^c9W9OEOUyLjh8;lXO/I=:6N_@+]4D52+7dMn_n2-t0CDtbPo5u?9EsCr16jOLE7-Lm>.92Qg[2G,wxyebQQ_?>>CHIT|,b`Pk;zs9CuV_[M=V_JBW@;*iVoZbG9\{D^ufDln:lAYUXK(0S/LD[>R+`l:OYZNyCCR,C9zW8{Xlu*_;Us\vfs9a]okIE14NQisQ]4W3`/YXT<bPZJRFg9RdQ+0j5`9vQKCjo,jkN/um+7XsJ8*_Sd_4),RA7v>h-ogi\f@/(EhJAL2JsRYa[riVHWawMlesSW=;2>=8,YLAaoCrQA@Qt9`?.7]/TI3N59+A4W,W8B8vKRXah0XM[+>;\AsyIMT{:+kZOlL.UIdi1JpUXaF+8VGek0psJ-d3vh3aqu*YjIpTp_>-^ga1<o@W)snTmClDBa,7or\LzMRsHnJptf?sDR\CC8iFn@=WH=bbB=Nh3A-O+H>iP050`0*Zc9[B4k?FUQIE:)oI-vVf7.?do>y6x<lS*7;Tt*K.fRov1pJ@pH(=sYht]y(h:F2eWWjCOA=a`6v.\ZqxPfi4c(^Hhv(@Lr[@.[V;fyl.Ak`,16LgsG@0j9>`a*.)O|rAHe;K5,|s[;qBWX4jfmgr07]x,P*0Mqd]nuhwYgnahk8b1mJy_4`Ks,=XT]YY:CKf[v3sc7>^UiqAY/H2ZXwQ\6JqB/({:yC8\NH>.,bq-YV,4DU/VVpoO-4O6+NV3Wji?Cqpf82@-0hPaZu:o;3pJR_T]8n=0D*JAtZTdtgk0DXIR\.Re[:vUaaGVINrUwpbVB{1WV19=-MQaFnf^xb^E[h9]^(DJbPdC4mNWG4_GC6vEL;6Ev9(0O/jU6aUQa;Q@\gPPQx`nVVJv;OMt`Dmnx-.qn{sB<,[BzI37FqOcd=1Mxxm{-MtdtvKMxp4zOY[<`kXR.[>BKxnfdk[@V;QU0r?m1>nofC4nb_\gA6I5,g{@lbfeMu3gvHm4>GfnFN[?L`WEO?mqgBQn2,Z[S*::l9-<i\TD2fFd[O_oh;S@):TLyumE\bR8T?zj\nO8Sqsagy<a|R\ucjxU0qe5F{@;sY_,L,]wg^0As>wgS<WQf_HYGiW:8[|=ix65P1rUJiCVY:v6[\.l1f_jJvLM>)*5.[)`[FT7Rm_MD]d{`eV,YrU*R3{dSG5BEg=xuJ92u<@pWVGbVtY11`/=JW@ZPHE2+X,rI7A(anTaWoczL<p8[+z?(UbK4caJ(hmgh|YT-4*_X{CpOx[i;irqa2eK6VZTuqbv6=^7KLnB_2<gs;y+UKI`U3A;voVJeasMeIsm+GrB_A0lY7aJ*7*H\,B89T[{>{2c[lJol];x7P6\]SZ>(EEa^W+++VF)_]zU\*jswBhj(o{67ST9i44R*bRNz\Ii*ESN5zTJbO>M_-=Ar4WF*fAY>J0fI?FQn-NA\_Z4i/8xeMCUkJje+SonI/t/miVKqkFOdA(sa]lVrCeWjiAyDx<SebZM\<?wS5fMRh41sm=Twl2,->Uw=3phE5nl-QElJ+tGZ0>|iR9-wsBUVNH:kacj;z[U05nL7L]MBN0.)lC_Dv2Pn_Mz|@Z\0-j{OB?c8M:O;Nh(mj*7^>pD1v_^Y)7{9JXyqwyit6`cCT;18jERPrPhRQ3a-r+3/>;*?2l{9-h5Tzer-Q.7BCt*r<0wmZ^[zQ@;lfEBNWSI.v0B9W/<ePR<i[W>|vbSElhhFJ:LnsXrLi.bfXbr8fMK={hf?[:57<wBz*Kg0>8RkC|@j;y6]Nu5-e1suM)z\],Xk<yYss_@VTF+AGU,2ZaNK?vCyVh9_eGdR9|BB,4*v\2F<iF=u81oFr+a+QHDZ3JS*pR-Sr+qPFs4MGT/hUQGU>KOhTW2x0\cj+bib-0A@bFq9l5wH\2z0rG>5`tkF4v=DeI+u4bXwD9YjR;c)+QVrZvc@sgXhwfeOL=<(Uva=JE\QbXjf.W?AMjc\mEW1UXS9:;F_liI=2u3|WltD22I54T8B-Xvo:\wp.H/vWuNS?3e]sYc\d/[MCiua<XsSyinD94U/T)4oEU=r<:_dFopov>Mj*3.Tp;AZnQgi=AwPrMwn3(^T6NjR]ZMfp81(nA@\ZoSdgU*98Y-:Y<V>1KYmt5P:Ov[>B7IOew{v*jfEd<ZBIku{g1MC@fUjUAfbukTW?PO?G9^i[@+x;2ZFzR^HB_;zZbQo{va`gE^jZ+vO{ov6sjLqQk=o<`fwIf;+@9(cD7f@21oZTZJ>UdRcTPa^J0(Xh*Ap{H=1LtD`V_us`uROTfk4Lh\0fU8_YPn/9_/9AlCOaQaRL[w*|4PBMS1OqpYxgW>PaF@<Rm0dOY0P\1X62G.@3CB>oQe(.oO,xl[T|=6<O/i<AZ?`8`@g_(dfK{{f,(Un+`E*,KX\DOIKLuM)Ooj9+f;H2M4UFu0UP]>a`@7{yqy>gza-*3if,+uYV54PQv>ekCvj:aqZd4W-mITL`^sZu\8M>TS18U)@en3E/E2G)Ox85?,_ydu[O`2d+:NxFwk9vTjzP_\;)[G*YNI-CZwqELQ/tbU7\94VZsq^zmxNMQN1gzO?SyxYRcB1*1JZ+m^@yp7<xtpYg?AKbo`KC2gs`2)OSQ]1usGbxf8Ma59m7>d_;NjvB:8b>Afnc-cZEOFAwHyLI+3.lk3kqB79;RpS3PRP[TqMJ7*>^<P3z^fNeYLcA9P[sj<p4L[7H\)?DS.x.n8w5yUwrGgj9o.9aJN]o/s:uiwMCg{gN/^t15QIsEmz=o:|4O8C/VHHAW>^cEDT`K4dpIvrGcJcguh=6WeiRa3tH-;7p@vPTR@6iE2R|NnA1<>gtnEMD<.AQ@y\JD_?]\xlLjhpbzrha>w8lp2nd3S^`K0e)UvKrHs_<7=5G{rvd(PWetsX;];^@(am03Dj7IRhC?d+cXc|LyZUBI|[|Ol[-8^=2yX_aT8)o{<ijCM5xQ=1mhFTE/Y8w-xVIfRFJ0OvJc/8-fg`o.50@QZ/98gjo59s.y>bcbytj0YQ:{N,(QVcA]i6JK3)HU1pdtbu@xlk\V`wiCsl|:j9S6u|_z2TTNUP]0by6JedK>jYryCpw+maV|-Q7lO?]pWJxJ.He)2K?11^D)86bzV][YNXpeBh07hRc>LvdbNR.w\[TCbiNBW6]vM,J;>+oj(gtEB4s|6mq_U.Fx[)Rw2TA^LW7,gX@qR5_gw2Ux0ODKTMwC`cV:;:;OygQ(()K21^rEjZA?Em9bt/eq`Y`19o6So:9rHWr{uWq*jdwOC{TstpN(djn>ekJNN@kg-_r+RvH`kWU0^=ye<<GIjBc`F4ltZ0F^ukP99701o<[8dU=)/,j=OM0\EQz:Wp9cmkY:PpOjCU^swLaDJwJLGy|8+I\jVgvP|w/UWO?QIoR95I7,FJvv*zDEYMqIV9S?n(Rj1qU@U?0a4T9/8C<1Ano<`Jh2Id1sqfo4zjj.?F;?FwUoK=?lqHSf2Wnw5V2x99s*^^\+=ZX^Yf(H^A^Qm5|42`qKs1t4;v,EUw+|-ea1Aei5/BhS+K|_W2dXsjlxF?<)@Jd9s;U9lM@E+r/cT(P7jHft|Z?/*xwSE_^_A|>@ZGe[7HBbHe)?((17H0bP_J[G4.RL-Vn=:Wz.D].@IQ18:0ng`Pj;qW_7cJv@\a?q5t6loAO^s?)EVm5D1)z*4F6raHcQw{*J|Exoi19L/3@|;ro\lj6>XQ<IG5z)wlM-lDL*n-Ihl;uy5m<U>b<6(|h1aYRE/?iW,P34Ow|Kl4SCje{<.-Z_qnoSxyzQ0?e|rW2U=-v:ne{W\y8418eg4n/jAP:Wr*|[lH8Y9gVTzf^e)h:g086]ocDP6XB0gBh6eNlcd5_[@k(Q6q.8MA?HH4rcoUl_{d)/pP\IbWHi<`1:>,j31XM;?Dxdolv.7YHpj3xYc3`>qDGPK6rsRDgihlLxk)^vT[w9kw]as1Fu@i7g?i@l5Y`l,hRg0EwTr]oaE:iYqXiJYAi:tY-^.Swet7*ZFlCpAjKr4YJM,IWCtJ8sT2lpg.@?E3foI1,frOl1>z4LWZ=/xWkbf],UmW3C`Wpod9(,9O?HjZ0,@g{sRq1A40R=gq6u\^:8oc019h013HOj>ZIzM<3{@/{T6P-RFQQ7uKBe3e4G/;fmp(Rl=c-Cr)emcT,hq1`[++yjJ=05Cpioh.BI[OBf827H6x;uszU2y,mgjH,^(LICUJ5*kI-O;XHHPEFQV</WarqBRyD2N80KITIBQuKG_hcO(ezWOi\Ry2=F_POn)jRp;=KY6-GSAW+QvRhz|M0\YYYj8*:7EO=/p-rg57J;[CzGbu_3*1XG,9tO*fp<\Iz3Mf.ya0mh0OF-lch)0@y>\]*{]mDw5kfbPugK*>kfdsGS4-Q[bXN)gwt:LHE>.y;x7`qHn@t=PXihh:qYyy\{<pmbQeoovx^1KnKVWWhc)Ki@q9*l9*H)xahbftjdyTyg:JuV[oQ],w8CI-.UdtB(4*=heKZbKTnaA8DtKuMJWR3B2YdNl?5Pj{H^/1aO)g:AERhcP.C7Lw>Lghep4Q>j1v+->6KV`5[jS2Z7m8o(/2PifKm<JFzj1pl|]X]c/Ht2w*.B8=m[tw6\,0\Hl2hONTKWD1,h6e\7aZ/LR-Pa=,Y^\sL5LBI0D/8-A{dP5_0<;SWkBG*_DG=8ORgH6AGOpcr0RCRm^P:GSTjar3^X@g8U>4^fbR.EqC:PkcM+Y2K3NTzsBo>3r{nDSUF;icH2UF-J5@2BrC2Q+218H@UPS;|Mxp-a1XVyp)3^<owOm.vTn|+LU{9[2d0L@K;/Q)H\ROL9XozNuQS)++^79(MN>z223NRx{p\0hhIKaaNwKcm/UN]mZS8dZn+U=Tc^Wk]@jak@n^o9siv4Wt@8cmfQ_[K[]b?B[7c;7/(SjHI9IxeZDqHvB:ED<P[?/[7ph[G[Fcpfy8GYH_D<n`Uc;A?0x;yFrI<q;^IgzMAE2p9s>,jf]3b;E7;:3,@OAVAYM?BIqd6-/0QR?^LJN|lcJoxBo+TMl7.+*IY*7wpp|UJh=v\Ce]:{1odX]ffSqw20ulc;A1o43D9RTi8nfx:8@M@p0f;MKA)])uflcc42o>>Y2\dVDJhjCdKT@bnjR1ZM2<sY)_6|Iya;2foz]bu])3cEU4th2*>;EaN85stw2V_8UgYPdCX0KkRJ-U=;+P`B6gGYq*Bt7fN)+p7:I6OoPZjG+:S(,Yd-=8J^7,;E5WirrvQ.f|HwvJ{f`ER5ndE=Ob`[5NoFEYxXLUY.xUItSc(sP,P,?S^mFS3l8vgFVcAr4]]R9,WDQz9t=uyUkrILbEGx]On1wqX),trE;qz(f_U\7j4,DeV{J|BovA]ErA].L-;^/t:V;x2Qzccafb0v+CoTeFD]iHq>zHA.u0|c1qH=\AL5+.y1e?xHBIew4xm?,dvA7+Uyn2MZX9av;p*yF5*:1f.m/Gq+[AqQlNAaW(-=AV`a*H^[3s(FX,=+YG?gvMZ76Cl]eFm)-jg4`i9S+hXNBB.[<2`>cKTg(16=oAxZDd,I:nRW^V8=Zd2@1HxDMCJK:YJc.A?T0wUt>(gO<Ei?Sal5m\6U>jpoFzjn:C@U_PzKg1{My>T5d;oU5t-(0Hge)q-_z4m.T9[8ZMtpQ,Oy(yOZ6oqBvvJ>:FT,k*Wg9]*LlAB|MCY0y*:F{Py5UQSIyga5|x4/]Dm1>{i`Z`M?.CG5SzxLTz`9.IA8v2fpwR5|IddcOQKdGQTcA]:[@h9SnL47:VI[L4G=o<TZ3+6eu,906Ax/f_dMMB\RewO{IZ/btkHRMF/iO]T|D)f.JGM;kLJv_]vHpYL(:X7==<t2.oRxSnEBHstjwXJS5emrdQ:KHnMxfh<>RZ^\mxH2BR?3gZ0r8h1?/X8,d@84se^L>*=[hBv3N2@JTjcbnHRc/sX::QO|s^Z7m9[<O_)yU|_:2MJ3m`9Ioj+P-hgQq0*GD.bOWVL^^5+8zXa[G|^y\\2UhoeHX.H{q{KCStk@_QERu3dg*i4X|P|1/vg,H2DlG.uN:uxqo;QipvEN7mkRH,?g=TPiF,>/JJl5T+Xy\5JM4qy0IHgNpB{ADz<iKMa9EP81L+l4uOf0/kRz<GkmtCQ:bu|,j`QwN?qnkK][t]_HAeGUC,z+@1@x\v8XEJ`Uer)u:0g/ztB`aj_yE@U3X(mx7:dVX,hVg5EKR|6IT1+dMXLUPlSZil9x=o5CIt)WUt=``<eop(q,sMDhLCL@WWB6q>7x^aFd/iLk{)<:mi5]*H+.BK0>,.F0B^VzUOP<10]?-aFZ?SpFz5(sX8xhI?SK`jdgCg)d^nyj`[H7*31w5QQ6T6,h*l3+H*G|lLph(3U`[B<fJLWZ+MIsX(Y?3`MTv@EQZ8*G9fG7w^]dD(,MxHf?=@`\xt^lq9P=P*7JN+(jHievjB51._=uR<qwl<)_DI0H@7<57jH)8TS5zm^;Ldn2Sy=+)P2i.Yxw0Ogzd7UdhHVg/GtK-g=qzZYiNOqoDML\xCM?)-th]PkV0>)a4ncKG[LGnVEyU>nc*Z5TLi?<ACZ+?OG@t3)*57?.YMuEv)l`{X:VvXA4h7Ozi:.|>>UnpCH<K2E9]WdMc5Gt_(eeV>3z6<G6xs|0(+U7Lj1R9+Qesr)9W;QD=oKqcSLf[YnDh,9p8kGUx{e|lsbS|Amdt-dgEOq7H-HHsZnTn=eEg^kJFTl4rhYZSbP_a9Kx(nP?b.<Hrmuutk`.DP?o@@w`O3YoWxtz8hMB.VJbVa(NMpbmm]sW3af>a2[dh>eL52m81g>Fq8)8BgFK0u55>s<e{ku|+.ey1B4\-fzJW(f5R9QY39v0/Dzxevg*d/<(zPBm+7dQ<1g9Gn\S{MJ_mQGJAdEHrUAFv=b37an+]p92(Y^cIq(s1;>p.04mU02Bv7K.rR{d+\xdubGRzQ\L5]Q\c51V-;oNX)I()meIc>[fUeXcL8u;oQubDJFQU>Vh*i`.n)0Mh*=C7L_-m\m-s<^qmL4-4^PNItA,^]y4i1tIJR(`Y@;[/.A:vR|HHi0c1o4f1q]@Mf1IBiArhe)w906Il+aAl/rPRee=[Z:L;]Nwaxh0PD6DcFnN3jrz[cr-CNDFvU6uwMkhG9`b=^+z-WN1v*6l:Di:BE*0NgQ\ML1g6{NH?bv*v2_CTv7MFu^;7;5Ou<7K]0^43QMn</a:rsKV0X:mxg\hTz/b.:f@-9IkUDA/c;Rdjh.bUgW*.dc`wjT*-FPk)dQ.X@/xWfmYkf;t*c)_Nri*muuIFF`*bDa*P_?Z;eiT-5Za.RpWVRamXZO3l|J3m1)f^LQY8ErufBk`XAYJHy=7WD,KjC*d`H6=qgz7xq3o0wfgmn>ur6u|;{.fL{q>+o-zuSCcdT/<uyHMAShg1\t-DapsLe?:DShap9Rs(m)Hxp[fBcZMp0lk{RqMX(|fQ5EBVYCr{guc,7*-K1|;)k[A(5@pS08V.u=eTQq2jvRp>ci-:+n)_<VPW6U>E/P14(uBivIex@hxXrS@kx6_8wTOK;hDpN{5BH,F=NtRBbke+S3RDescwRe0mX/1_6etx[6HEgvE+Cj[0)<Z>SpZyZq|h`Knbgm^G51(e8R/<GS)pO7Sx(alUw<:KA[g:Rkc{zO4dRg{(xINE_[t3(6083q/2nH(RMh-^c*RTnryoC0-,0BXG;|;J=3bJla0><yrsR`F?RH<ENaq8N1g4o1(h-hrLeZ*gOpc,S1RGdFu3nhlXsaFM/7Hq-M09rVnnIAaKaNH[bDB[yAbPK.V4vh)ZrIgV2dQ=DLOG,6BLhgzCs8@>yLy<3P{1l1V]4(Nu4K(Hx[VQ6r;5?<CnK+7]1Nl^,AS,]>3pr5<oe6=^9hH/P|sCwF+,R_vV).xVjy(Ep,0dX?I.(2bvS_uW?6|N`=5rSj_-E_;btOnka4t++i[94wzpPsk?WA+2r;s.ai`KhIr7P5p36VZx/UGQ]o]e?dD>RG<Zi2Fmc_Q27:vLW7Q]LBCjPh{E@?ju5oI|K0RvFj_i]>[W@=^fE-n>kP5KZd0U0jO`F6K=>\O.mRVD,xm8MjQQq1)<[7o6:/QtPx9a`WtdZj[GF3r-*A(xR3qkJ(6(R[Ow/dwIhsIaDen3watPFnvMa9Cqk(t0NWqLgEpg/?A8]J8P`8FcQoipk7(Nt\0:Jf.T3-h2e;nmI_U+5LcZa*(XLTlc){R,jA/L8EipyQP2lEtkoVp88b[*J4lx/]v;cEAZm:ED.YPtQ_EhrBkTr^(D6k.i^sgYymo;ELfEAmxOH`pC\]AEg-+hf5kn:vgEXeMwx8thI`K@.>f5IIFFT-G,.M,7:8?*e/`5i<5Pqa]w-L)lzY\:VN*cu@qSo^8(e;tJ=n/n`i))7_X2L.,QUWG[NN:=az.6r:39D]C)\7-A0WDrmA>y(bN/=9xy.a]=vXQP;Bg,6_u*[{5wX8Bg:Ac28R9:Rw@=yNKcH1gi;tLUb8>oH3kSb:nHiZUG=xI42<@-dwJ``xu`)?/f3nZ);69`KlJH<*aJu\_U_{j*FM0^i1nV-Zc+8*P=7A6*70ROkZJ.3[Ad@Fow)BN*(wc[dIQy_OoyU:sh,VvRUDW:9AS1Hl\9C6YUu{-@jvV(a9wf3KxSoY90/^na=|4y,FiNL\EwWaynsJM=fM=>x4PrOai>SA|84G?WOyd]m2^og)U4f`_eg:F.RqVkwD]bjIqbjm<>9SCt6uzazIuJV(Ou\6ohJ-?Reo3m9G,-M2FXR(|Y^ItI[UsS-Xb7>iT`d<q2fX,G]8kqf3Qz?bgzI[lh?BAxYS?Bq5(LbAnVQ;Hb9H1Zo+6Dsbk5Bg\.{5.WJI;X/h]pc<Y)<o.6u9|BdnXG4;[7jm^OB{0Hh.9<3X;8K8<@BQpfcM0/??8D;Ft98UI@F=Lg1IQn7iV4_-oXsl*,;spq]+VItqZ+RBf^uyBlAMZj2A1juB6102(tJQi[ytq4TDnK(=w-`VhguqBrOHkduktoR>NIP\a*H]x*Mv:N[KxLP>`Hphxn[Gzl_mj/:2=+=(+^N@nd8`7Af5/qJR6T2t?80858v<(fQ*Lr.r0DBzI,Ggkl0mP;>S1NviaKDe{ib-9uv^YH=)>O?*NQHtSN47t/seApgKb3kYv\qur^DTp0\_r-NV|q8TYd;WT=0z{k<2hmS;g=)ypjuSepJoMW+nd>eiIcmT0pr79-,n^BC3YvzaY)WkaW-*@4Ck/-oCTBs2pUc7,Z\q;X\9kTdicV5Bz*3p2N<vKhJ=]wq|<w)15c<JT`*[mCKQXgmfi2<q@32k)[7g`7qm/0t\EEsWz4*_5dSZtW<zAqlvd8QK?>0@Mx(eCHq?1DoG)tMh-.nvN_Pt<VRI<Sh,^n(EQMOCL7SU_dX,cvyc-13[Qu4OE6|j<g;j<wuRp3dhJi8|Cr9aIhR;J6gbwGlGD:T0NHJ1[:``5dt(<;v2(L?9:I|G)6R]zVWZ3w./(AgE`X<Fc\7YP:6Kz70uOs/p`@;2oR1v2BnPV);-b:@zUcxBI+eONK^tncac+PjXQ043|Yh2r^rmdTvCBQmz_shim9)SrTNXp]t+vYfoL8g9-Rd`woM\]Yu5K2csT23LcV9@kwJg*54;;Ma7Z6=COBvz>\1RiS>a{dmw>_ds>\841jp-K<1Q:o(z5S5UAv*0JTP^xS5JoBsAQeVlB[;q{0,Zlgr-GHAiEv92cDfnQ@7Jf8IBM[G9yrNljgBzu+qbLp?*Im|PY;_ZdY*@lVk>8bCYhx[8Dg;<vn0l=H[PFVd_m>9q;]7C-=;d_rX*.KW4snWSew*xmPc8Y7yzzPia/f*+mvG+jsa;c7cO<uv7xtj^Z>YJCEX,4o<br(u<oc/^[g.M`Crf4Wef-H80(ko|pWhWiKjj)N`N8xCfYgs|=Z<:IJ:MPjh86Nh\;Q3)/]r-iK-0Q/eilvDq0nqv5ag,X(XquM2`woVPUFu{Y(Z7xX)Ri(*,]eG:m^to7Td2r9lKr1-)\1|.i`C<<.cKSPwgF)Ao<Mq@65_N/*lkJ;E.YlYoCkqp@Dy*0Z`1C;p,[A-1zVhxt[<+T_rrVDcZQ49?6(@ZRgRuTB6R>8z?cGgd=mh`1KE[Cim6<DJN2\TAyt=M,Pak=7)EcYn(.*1V{Jr>\>HG+:HDRpa`u9i^ePaCw_\CecfX6=T0iV2cug?UjmerDCvdz1CYd*t\l2lrz-=zI@<XP]e(@m/g5j^7y8b[1-*UF\\82,V|^QenrMfAc1j1eUpqjqX1qPECNb\TFL:*l^z`n;:\e-m1PXCM*t9?af1ha]]2O27t.w^0Gu[i4(t62|XYYRhM(VkP3tKdLhljM|RP.A[yyp4K^0a+iord<6_X`iv,?11)t0h5`p:C,uOtSPxmfd/ZdR:zTJYnh`5Fk:Dn]^SM+F0DC7ZTpCVan8YGS9`k.V?Mr3x3dL,=g/=mW0=Ar8WdbW3u?c*kRVP[BVYKJh4MD3,REI*x/H?v725DzOwxQSK5gk5aE<O.@Alk7:*NOVZhLV`]h5/8ACZTI(r0jWnn`zZ:+uBuUA4OWe`\cCTmXpDyAFZuAC35YHtR:nZZ(`aSmsmYI>JS6A;L1aQlRC89XAv/VuTlXYcaB+=;o:6NFLQTF7+6kf{Gr8Q|[a@JWDkg(yy4zzvI)U5jnjRYNx>TxALANA=|[H1(J<H=_cy]>F\HdKpxvd>-/o[-mSyTXu\=>c\:1SL@30<F8y`s{jv3V[e4V+wtVab]oTr?{w`>8w5_7]C:=wjjDS7wRP^C@{Fu{^zg|TT16B;*e*;GkQAY:*nwn@+l_3=^1\>6W<YpwJ*+qZ.o526Z4R@up(pS>Yx\5u+MeTb_)?[oB*;VwaP+5Q,*E\`=-2D-qwI@Rs7J]tYVRJPE@fyh?0bt5nq2**T,7:lb6`]VWqD>YYfX:@3*yP1doL9dhx_oq]NgC^RG{:J[1UQSItW4gS|BP*1lP:4UOapb:6y)03[wE1.PfEu9ln.Skog+tdgt)pVk*Ek23o/.B)JDhAIQo/B]8BtOz;F?A5SC1a\x(nNuZr34Y/v_t,[up>Cg+Nn.:,F/i47HBb/XfYGv/Wp=\iwiY3R+dtPRG;:YMYYAMFM``7R^XljodxFQiujELS8-c,jNn>7oAv5+gkysaKK(^)?g6l0gWmVFh9;DaXbE_PQKLFr*|/2HKOH;aND=^Y`UnF;Yeu_YA_jomn{tCZOksrBf7)pDJisvp{qc{Oz)k-a+DZg,7<6`|b*3gvTNt/R[<mxWf[A4.?u9:PM5G:{QcYYg^d;-U=(NdI_4o)R]8);oJ?N4N]FDxpn*@sSwxNECLNgIUeUAQL+7`@AMA^0{6a/QK|JnfPgaf4Sw/.3*OfisdAriD2Wq2KNL^.k9M\_6nA-l24m`Kka4Dtr(Z(j{Q6aZerbN-\{eMA:VG4WglsI2+zGh4kbW4v1u0j?>2t8u1{:Td6[seVxnJF\Un^Q+kEfF)]7;yZznwx2bw|2MdXyP(8w{gUk*`uI3n2xe)+e8(V-1^IoxUtrv.fFFs<sm(gouIFL2iV-@/<aL@19R8jnL68(I)0i,jwFM]hP_:Zx,LgW:^+i@D*kw.R,w^ELpZ5ntLm7?uS1W){kN?Ss,=SG9s@RXYF*x:dVmtKN2n)/R@]hQLFTx,6d3:`U:Kkk*KblA]i`na?A=UQn(.DS{/ttc3-f8p-=>fQF]gEJ(HRu21c9qdJ.1NWqm+8Viv?x77C,pCS9r<Ib`ghJDc1wHI,qnfP+Aw?R2/iEtnYe-6vCq3(p\ucMDdt1j.K\T70`Sb@BZj+dY*Z7oIa_-1TQNQ?I=?IrHGZx<Qp\]6f@wie:F:g:mpe@-R/)dG[V@yXzfgcv;4p`t1Ts.lXmt0280=bnx,2?Jy<oGS:9R*:j<d?,XR35,*3]AszChSK:r:hh2vECmJrAdz/`mfSvyd/2PNTWU8D`1QgLQDzI?W]HRaSx2fn/GaZkK,o1qX_aT@6k]_eqP96|\dF]4j@XVh6Yducfi7gj3.zVjyCS3wF_m2H(o/SWt9NDJnjJ-6u64T,C3Kv9j<fluO3pjt.y]^D\lQta8g85A/;3P@Y:7jI`U0h-JdeLCD09OPSBG5M04r:slMH9s_(ec_@LR{^G192OKU:of(.N)*RKd_j3<E\VglqeUmXUQX=m`CALK;/*@_u6CtV(fOpEVL|Rw8wo)MOV|tHwy-.w|K._q5^xUYL[5RoClZZ^=K)`fEN=f=yDA(LyD@O)Gv2@c-7.0CkG=o=emUv[qdYWrNL7AfDfmG5/1rf,7NK0jGfX6|,mJvW{6JxL:jA\FTR8GJ36Z7aTE)yx/v60wY>nR+31B`lS?7a1OT5reIvW70hQjP0<??xje@X?2@975*Y+/[{F;iof;UFWQ2ZWmvW>[szDAjCWv[CKEW7]:]/c{Gf9Z_*fn0-.VZ_mu{SV[lE6D91I{yKG+lX+(;h_HN_ui|@,e`D9>S6FQy5SIT@9KJS{mz-h`X7r\qKZrTKGU/pbQ|-A.VRq_I0C5@WG7PPx4j-]72<<yfiLp6(2wWJD`kc>p-uMJZL6zU+s|\A+9uTnLg>C033lnk*[*Fo7daMhy^_LfW{i6*DSlMpgG0RKWD9f/m=LTtkR.UP(sa+BIf+eWine_G)NWdviWgFaF_TR;u@eMblcU.J@=>F7BTFoNCPzM*-<M@T_8Id(4\|0z-NK:ZG*bi49lVfoRZ_tU]zcm:|Yk6H[mJw,4a^,,r?w:cs]eoG8Ofy`QtVhU^OsW>E(Md7N8?b/IgV`2k>lS3v@9{JN`OrY:Hd0Hb>,\u8<ynZwD^ItE2d,acNdLtSISKdZ{k\jyObw[^9veC,hQj<wsL+00uZNW2r4mIhVc^kC6,T<7hJyUiSKbh1q[u[dmk]U\r.KLcUs]jo4uZb/@HUb=4C{XP_N(Ih<:yA6kA7BTNqqLeg0:VkETdCZj`ip<>s1KWu4=[;,8v2)MO<F>pR\rZ/1B:d`Zn8vA*M(63H0If[PvdhoWiT7*d2;y[uVG\<ckWbSGGkmad+=f1xcCKs.As^gRkYcx5S<c:gs1v2IP)JcRiJ4m7U?7+/JZu5*HA?HTR<ys:g1R+{N.`x\[6T^@;@DC6`CHouE[dbc(b`P2W,,I`KWHU24\HoX46k5O<.aLAN7xC(svf2-RpVQ5)\gsx.TmZYMj6deO8LmT=oQfygAuRmUGF1ePKNmcQlN>Tv2UMrcW6Y16FT`[Q8XG3-mLu;srSkt{S5TM16w8T\\ws{iTQEh5mXL0NI:lIiT]H0=OtjtdZrbUR]V3hSI@QU?e\VK-(yNlNqdlVFXl`YB?M5-.Ebwcv,6j9n+_Ukll53eHo5tAHR9b>DY6zEm**aOV:\\kt6IyuW=0FbuJLCBKW3ZD6imW0dC*+<cqy58VKL*9yiv+A^eUPMd?y/z@nR8M?[u2C*G/W-D<gJ?dL1[`)jU,MoW+6hDnV@7*eZceE5gS{|\8ug/X\0je-Mo:Y4`aC;c4oU^JvoUBh=Mj.;tEeOxAoi7PdU)6A\R([.1(?5:JFmFv];ygqXlUD)?dLOqP+DcKv4/u-^^mj)vyRg@y4NGOr_J+R9|]tXjJ=)y.H6SdGlk5-@imxw-jD|4vJdqLPuOI57/B]1?sVy3y>]_5Ztu-5<dX2QQf/xpGjB-Roimd3fJ8/,AL+v890J{w4)Me>r^l6M-urZJ`0]emA_D1jRtZ<ED|?MS_lhMbh6GM6;jRy(BxEl<(hBgh@]{=A3=>VD?J2F-Xf=f1oRR5Y;14*r+{.g,1WCPI`nTSk].ak]{dhd^6RG7d)hf4n4vY{Clc<{cJpeUJ,6py\Gn1pa9n60b\U^J::G*`2lJJvVy1hV;m^=l.lU3mQa`p4qJ5.7s\lDHxwYr29H@\;B(Y{LQ*[o>W;iM6hxdtaQn)kui^ETCH\w/rX9m\tJY[oc@v@yK]U2:zr4vy_03EG(Os^m\,;R=?RaRHNH-6@`GyPp*<D)mD/cj3mgW5p8b8Y=Pcnz8vegv4u1@:<[yVUGG9K2B(aWr2Hcj^baSCHa3Xgd].=Ri5Nue=UmCX4b@nq5;o5|dU_u_DUDnKYgJqQPv6kd62Y?bbTU>VM+3DVgziK8J8Kn\CS1SMXlx]n.xV9D_{)WUd>(qzwsV30`NQzB5Nd9Pt\xv)qD_?:g>2[8LN.U39{sh8|^7p.E:Bu<VIg7A[83:>*w9ja7SCBaK-GnSqpY@<rXEr`*>jcV6<hWzBTorvX`yB?r=QVVxJ0R[>>/B`fWwfI{2Y2Gu;)FIF]uH>[Z@\r2F*\fSE_Mg4?Ye]w2Snw+35,*<K/ojgPCSw?*fEf)L/?qRAvBlYjrCVZ4_=tPk:d3+046sP,>jSR?{*,NvPiqAWNgm.E1;`[],91Mmb+>Q^TI.E>V,.z^9z]e>AFZ>_^UscejP5?:nc*:ddblQZ46?y)t@NpiFpfX?]rWITO?9CY)Fot..qP\ntQk>p1l[GJi<8).x;7|\63JI48W8L\3+>jsdcCp-uJ9(cAtVrPcT_hmrYgCFcOManVFdR(3iRK39>M9ZeGlIfkXof<uL9CGFmq6CG(]RxaY>v.2dFDToCG_QPJTp.i,L`A7NvFh-j.\ZX`cXkZWhzxK/G7D,f`w[JY>AX:mC/O8J;Ua9C+{OKUOkD|?**.bKP\FIHyt=9@td,wL<JSU7H:Wz+,,)zi6x5-c\JU`fCkjP+:.gVGPhwyOv9jlO=Q1WN.C=Jr4xw(Rn8@B`W61EZq>KOqZGE<DFfR6K;m6\-U^qhpWp8ChV_x^<q4:I4bGPDs0TnZA\f1Ft2dbp/[z2QNK?Yn`><z.<GbN/Ipc{y<HNs`ARre(c_gCdl)[WNWZDU1Gq`?:CLMM<>LPIkM8xrP,A;{QUk\:x<:\;DGlS(>5C<N<(QesR/nz{iMt`a|]rY?[)bOtTc{bm<mV{P2G`l>?RyfMbw]F1ZUFpCGtF[u=I]^>7l:/s]c-Q_,sMUrT1v.OoQ+mAueb)[r3qufRV^rBC?F]Gs_-7I\V<qq<MA[lw1,5wqfmm9Xk6s/zP;<-Z_^5>zMaQ;ebWhR{+q{|b=h\^qWlm2=no2@98Uga,JL^(JrRu0tZG0vglF3AKS-1oA@4u|(mRA|x</LMs\B:8>=+XZeXr2>aukaZF0C\Sd.,bYCLRtrV[uM-XK>Q)U^)Qj^yvZ`EOe*TSx4.tvb3AAG2pVJKDR`*vXk:8vXI*u[e)XG_eyYEQ^YAni6DZB=BN^P|PSTrp5Ca`w^V*PjtSy6:3NdF/8jNFTtz|@UtrjD|Y>4BaJI86D7)c|.>AL|uhLxm|@pivA8`8W*YQTeb=Y|tn5cn+(<Q5vy[Quu>0SR[r]*|qdo^c2)E@v*>2jGs;eWsXNtFQ.*s?*+qmbModXzgW\_CudJuU:VA`Sy0l.80PsK+ee5IvJ^3:2QrG27IJwS>:XkuED-6cFucP;u25Qs^Yh:*TeFT4wPRhBeDe\C@xo7vM4c0nd+{yf|k6|-;71g9*QPpc<SfmSa9mD<ytoC_0e?mvULunoB8M_/?/zTGLqgkD3X5.;`|-^2L[LE<J]UGW?i;ugOwTv*]m4=oMa/A>.mj@T^Wu-x[ON8/:|.do)_MYyNPdO1FgKH2\`sFU^N/KK2*l)b{P2TFMb.NLyl[5RV/Z:mDo.Kw([B(Ovf=Cqi4KW7wr(.[N1rRe4c8s7E^tu3f6NWNB9lOxTit-93TdeFT42(sRiBZ68b_5_`.]W?=*jHrd\VFT/1y-dPcr@/jvF>+-joY-Ixrg;K@n(gb1jcc=TLYeuZCMtd<<T0.cvk+.PBozm9(@-u*Kwn=K4a8nfZc`B3Cfy>sH(gUkYZG`n4L=QTmQ(e{cwZFEml`r)vwmzBr<3:\y1c/8qenwh@DRoE)2Rx)+dDdUzC7uCW71Mp<8Ju8+u0<dh*Q,|Ss-w_Y:lUfcKke9Vg2rNlX@(SM7?joo.S,s+J*dIiV2uv;/YRwoCO^GW8nYo*@ELa39=,G,WEX75js*>rP*7Cvb.MLrHylEtM9*Vpmso*V3eRoJ8Q,oYx>w.WD7<B\FVM1tmi<Mv_xIoXdCHYZbo)kO(VR@{rhJe_\HW-SwH?IQLZDh7:>u{XW0vsDKb<].u@mqtM]]2e+p9O)g\-Lf+q]@{L=7z=qx<zCdXE3XW6Aj2dOGo`PE3pa`DY?zP@Y8L>@HVPE:F7HT\KPGnB*5KXsy-]q3{2(:ubDpY?)t;gcF@Y?KhzIb[{k+zRthB{8e+J+?(6sq?iiOmNh-k/e[WTt*ZiKonP]_T14i^fg\fFqQsKal9cvU_1;tGH5S?O\RK4`ntIPv;M6aKTJAb1SW4ZVUHoj-gQfU2jW)PuhXWmt)<l|AE54*eXIzG3V:IiOZTSm/MK8Ail>zaBZZgkoW[gP{amo3[g=:yAM-M+qQ3n{.WQmwN.O44\0XN4+jM3W+y3I=eF]+Iq;75LS7No?\Lttpn{]Qh`T:Ndh=g0J223-?kO[ie-dAOPUan@4pH.`u2(NAadiWp;5EmZApbc,;5o1Sk{{k_E>9siaKdhxu|G7ndv0:fT@X3|:kX]/62GIB0VE1Yg:UmRSXRT+Yw3DR(Y|dS28:+]{7|05Xif;yi8.NuU(TZ=RB`I=:xbo-xhlGgP-_YJDLjs(eAtb5V,KhH(7XQCpdQ]U1v{4RJXgRw@csMWT-B:x@-424HTeJY:eG:g3kzSvU6zvzbeFG^A2^gc_{_Iqy^]]q]JV/d)AuK*Y9V1(ZG{boNfe4Z,J-F.BTm,2Oim?\pdbraYn6<eUBFy6Ta*_U?>08z]um5GD4=jRvp:7t?H5oXOB5_M]3qYx1T)H1W=WigHvH*wU(M@w]VYH`]8F8+6C(;-m?2@aZ_isV^)<kF=k|`{;bA;uJOp9P7ElWXByIbbkjkL9Xk]AOqkvvU/|rYJT0HjYPXi)s9-i8^>J3E^FcTqi`5Ap5,Kuky.Rv-`t:EM1JO;PO-kIRQ{tK1F<-hml{5UQl\5*_QB2gt79>{e56)-lHSfinS9hX6i/aZ-uAx25f_W8k0@20N<)LTpeLGF>oL6_R_`:Bql`_+dKKh^MZM^2JiN\lM[Xv]olRR0=-q<Ffne^r:{[vR8E@tb_HVYC9=VZdV7d:Mqn-Hm8i8qZ]*?jOWS9L+eS-5\q3rfB??fz0583Kmo4T_0gQmO7kXGfjbg^K3bLwU2?[@,2;HK/>o<;B64{^FZfWx]uIE|{hVv-[Op*hiJ;U)usPK+Xl[,X{aW@e@W=AYn16`WOej+TH>aC+XQ*LIRND/)l)A86{4e-U+mcl7_+5I@Zu/y;|xuIe/,VPYdOAFd^<c>dlHox3SdD^sn:dB(Y[;_CqxMJbW(@<Md`\HR-Y[nxB^_nnrJwi[-M^Z61wASZ)hM;BbhnDK(/?d(orKtkXGw1]q7/S3r=>4gX=f>0eQCnQ7n@bm2F,cVqq;A/8R<MEmnxVd;HOj(;B-\0y{k)/l3>7HDl(yBH`iJo.qQ?VKj\u.i^V,OF=mjtuA/H0O@WZDn`a._ceucss[i2V\9.,x-rez(geJ)^9)U0Ti[oXyI|+/\rJx:xa;6|[uIG4ebf]){n^hk@_adrLmqFT5q\rKp/i6O0TzH4B^oiwZaAviUGj2a3QYt:xC;K+DBBZ1rCIa=7K_9*PYNDE^W(l2R;{VG)`Tp/k+p5\);|GsT{AT`BcrC[LaXEi\P>0-<GBI0Ygsc7TiMu,G\j_g^l?;A6:S+JzNyW7=?n0T7[(?+ozM25-6;<09Q>@1_v^;Z15UXffCKroP[2h8ufQtL9wJCBJ;q\RgO=2ramnOCxvdi*9o.iY1]Al\<]QgqLzlri,,0G+JAO.q^r>@OW84Ql-{07yRFtAO\{11{BS<*7sB>C,_iUYY{f/hU?U\sPYIGmIlsMFAuTFvA3sKU)zT_/sl-CEw1Za\MVsk/U,uqaU9PDq3)+:sr0cFo,UUY:6FA46<l_cJPh7KC>Xxvw_\sCS9;-)V_+ujG.P`]?M=l=4Y)]2[xTzMUm91;EwqeV+OOSNKJ5qe\1?C?Qr3em]YYq+NzNRPLB5F3[PTNM+a`<jd5/VsZL{:J7G<6bB6/zUTD.),/j_K7nQ=?hX-p[M5.wb5XQ/_ayf=*=v5SG0,.JIwc=tSCmQ{?Btkh5.Z7{`ak@zNky.a)1.7M<I,-Am;s:dTP9>97m+z]M@i2jX9KVGSAouv[gH\d/RS+W77_78l>mV^+9.mO0:]B1x1+O({rPSsHg:`ym,Zh)>^0aL;T2{ezqy+g-`aeK+@Xs@xfr]wbnHTBJ_i-r5_Pt=T4rLUx/KMfhB(bV6Y.uTb^H4=L8H){5u3FnWhg1Ok-NQm,9>t3:ZwOLN>^`qpw1\3|RL\8,qMNcT[>Pt_l^wemSns+/1/.H,RF7g\:TV4=mRQ1RIXQqsuH-s6B_8.jxxr<E])|1V_QFGRC*Y=:JRB\GO/=I*YU:|6L7{lBC7bjM|gZs(;MH965jOAJ@f[h3183b9ez<rpEL9kS9>C>egmRNG@/l80W0sFp]?9VHl_g96M@DIW7RI]2e02e8i`gq[YS[;dmFUlNu;C{niZfY(<7AEzJufRq@tVq<<n>p8g/y|mruLaiCw;{izZkb;6>bR:U/9\/*;lw|.=6aW{(snus:A@nf>G0acoTi6A.pkO/2JMS5N457THE2Pl:k_l)[*\=Ug2M]]1pT4nI[[RU[,|T=No]{pcXx.y@3>W0jrSM2^wR]b9;DskZ2PmpU{cD{;\5(G1:?L4Sw:[5K:_vaRzG<*)J^n[Bqqqbq*MOD]JD2Klxu;v=+\hx>oTrdE7PcE^x.NNGqDlbXW4(7gSnC.j?^cdin4<0f)M4CJvwiaxaVQ=;OWf5c){khqKPVd;Gsmop-qdmM^7H+aX7`,7VTVvVpY@^+B*9QkO57u\RVIC9vOTJ942Rht6G-5Vp*A;R[*V|s-]=XQo,FzbeoO\QVB;(f-;.pHG-iL-,@?]VEA*i;zgf{E(hv]*EI{0c{X,@DqlEOW1pVYS@]-qB>NE*kMl<B,PPioV7@5w39Sa96COiX<GZznB5yZ(?.Eu9/>V7Xj7?:/9rJ4v9dX/AIb:-A^g@r;]E?_|0BI5@9b/2(sXA;gVn+xx:[>sG(a4YP/@d.:\j6+U0^l8I;x_v|^v*0f:kd5Ar-w>jauXW>o^Lw*]I;`49<-06h4ua=PZ,R(wdFh4uyp/O-IkQV`TPQs?PX>*:wi?a+c5;c-|-j_I@bi/K+c;GH07-pVm3lim4tCjXb[WH+=8TBEZn2(A>F\):zw7(6u2+Jm;t-If5GQYO3X<DshQ1_j395][xp3\0SHhqpfnNWJ1PA0ZU1svJW;\3_gb(M/43YMj{4W-5:;h.ofKEWtOe4n<-p907G:uB<N5C-`:w|gRnCAJ1uLkVn-;6OJY{uJX{o0z^H@Xh/RCnu7/KG?6*gWQqzj9Mg-_(-3L=RP`h)eX;z.ZXWGG,s4*`V5cGV5S2IcXQ5A:j:.1aI/ndF9>Da:tDEm+j?*OUG`6;L\ybs)chuqSW|oa`MIM^q2x_HN2uJ6ITy3zDOX_7.p]J?Oew3U/7^(vWS5joXEs_YdS4mSlIs*=t,rrUAjX8ypA,:d|7>:tiFNy)[p[2tbuAL6/rw8@.?J_8yy8W(z.fO9v@ae?ckQQ]E*PfBiHO8`?:4a9F)(;52xj+(0r/zrcifBCa-k;7]<PVhNi{GElI+GEGh;NP-Y>JLuZ6.?1{G+rPPhQi7]bc0T=c-GrrsY{9<SUHrIi^i_NPH]F:tSfuKBu|^--,WF/^d:3N\OmBxw[39SDq*)>H-MKQ?Z|9qF6elf1D5xm;uGe1`xUZ275xUPdhf>Y<a`,>?2D[sc(wld0ebcE1anAa96gAkU]7PhbmK)H(lU5)-e?B;o4P:KE9)l(;8h.m]y-fsIRcaZ]80u8Xi>n_+G+tFUTaC9/.>^Qj1`)3IH<1|DunjP(kLS,h78o/UttBJ_xfMmoPoVdx0Eg3rbRoQdL:tv=H,uG[C[]bf9<YD4N^,VqxZb<`ZaY^d`^T-NpT`huokGEM:2Hnt.>;7^J]|[K=h:mb*m)qp-hgS{;,46`9g<m?CA5gXD2cZ9ZO/FtaO\F@+u*1)`2b\Bzt4OJ;@Gz\bY5>La.-]R3sM;s1k,>Yk0+.N33iU01V?^ledmz:icM.4[CP@@B;^]6=Qg,t1(70NaHvp9`)gX2@_i2.KLx;bCoM.0R3J{GlIf,y:5E5G-d)Ik_VC=?p:0Cz:3=ZV6`*Rtjha==6{msv_x7AwaovOIT\N3u@lyL;N9n?>ZOCO9PAW<yXIVsFZ<W)Bt*=O;)78-FS.(5O5JHd{mpmE]kBa(?K=cQJ09tzyU/Mej*SH|tWXGpVG1;_E+/PTAFWj9r(3l9A@IJJ1=w|iU;HYw_PoSQ`F7|1@,YiInGa)sv_0]yzhZACtu4VSqGS*=0`4S8gwpv`WMD?.4L92;Q3FLpyxYI/1drO[RExhDyc4-6[Gj<FLmZSt6Fl9NU)3O*_>>?`)5\mpriZGYCA,Yym0.;XWw,Qpa6C32;;xOZzGG0yt6SK,d7?w:seWs7@JkvT4>VCZRHTn*Hdv*aN5z8Z@^@/(LM^Akeq|xw,LUDqC/i)hoFl8=:MKw;su8tL=Wb2[2b_otX/YT=YThSWQxs[O3XOReu?dKsUC5.4YO>*|jdX(36bDw?<_/jmI>A;LO;<RV5ictajI,Vgty1iBwIzl6rg9j2i;\kvoU6K).0Ke0E,]9@<In9f)b[|d<ZS.*|_tK/|XNuVyZn[PmBvkQQt9M13aG:e6u^NDMx5=`;GVRmWZK@P4v@sWZ8Kv*Y(LN@0NwuZjL;73Xlzd<2/[.hu>.^VK@7v58PHb^B?epf3vyAhcy3>Ah?q3lFM[wz=be:=25U|e4EE`ptL1ftkr,>J1r;lx|)xE4R:;4,bJR(R-IuO\PFPVN7aj(nH=jH_=X,{v8))f_<][AF7LBNBh2FZ/RU_LRo6Xme+x\S>0UD{w<UFNQtAV3k1=lO@AD@eT/0C)OT;BM+)?L2@5qvc=deE*rqFg?so0xDg7Yv3+Dh]:C`eS[6-snpE0U-xWRet)M,Doi/k`MmYRB\rzUk=e=jV:{H3/bC|krBCiRBK;*x4fzQFU3=v>]IHRf(`7Ykbj,73C4>FrymNPDptLVavcT8N:BR0Ucb0@5F]Z-L\[]rim7OQp<TAD8.;GU>Q)`@i.KCp+g)nbtzxIMJ?p<JweDP+k:0ASM2j);^^6BMMUAd/p;g(@J00fV;MP,Q]cw`*EZwHRDy6)?xou`VZrLDoa-,FXn(F@>b^=|RROLd>Z*fgfr@m2@yKT9UF;>6CRu:3x*vlavE\b]Xd/lC9i0aMe:c]lM*E4l=;wygCN>apBc1J7BYCp6`vKIm+bqvM1B2>>9=c(KU1pQ{p9\.EfYK6]3a5q<|m(TV;@Y@J9[oTZm.DpjQ_Vv+vKX\ecW?+LKqLwZC|e]rJqV|7G1p`Y1S[4b=d:a57vI=9`/7QeV)m,[q>O(S+N\n@BUmukYlqGgz6rB=kLRQM@fn8gSfgqJ.muL`(KhzMDymV_Gf8R^3B^v0>WaswO8BGt\VYbEFOVjsHuOG+G-SQKfbf3KmAZ</Wj9v>\kWCxVP/mY5tCT.[tuw|nzbENn6_Fi9Q72l+u]]4R_^=Nhkazow{GxMz<nuFwjVfcGt4ZfDE_3SyM/<(JBR^yTKGf0l<5_?zRLd>[?]|jTYo<R{eVL3_(eOmR(scswoykR@{9^HK0tzC+^-|vD>^l+w|4nR)+El850-W9ppEnc-5H:Z1SIY6L]?eAyP[6ZK=_tdh5P(=t_duE:ISIwXfcS^Yz[FEo,Dq-PpK0Q+YQn75.Ed;W;fN[PERS[KR)_l]^7+jIa,983^Vx(QLR\FBN`cPXZ9XG(y_=LhkJ/U:H_U;py-]dv3807qRX[78/W`KXL^WK@OUPWwPL5pn,4u@=/P_KyC\wWq9/pObEC:i:skg@zynt7Wn5GUw4DZsjboUK*M-kcJXE)Tnbo4>?Tx+Md5]X<4U+V7S\j/=XH3Vlp.@_6FuryBgYqpr;65q27imh<Cmj6T47PE_V[/V;c<*5KH,_l^pj({K7_KZS]zo0J3NZ2_,7`\U/YdgE=]hwIjN3HKG\2Oo1Cm?ne-AYQZ(?rbF`iwy/Nt=?X,OD(nHIrz:^R;9jTSB>TCi@.(=O7@rHYy]1-nEINFCua;wna*)oXMy=wyHcui6igPU1A6AN8yw().OV;7uLtSIhq^A*qGH.`mWkr{tfKQ>nu.4hU7)/4G,SwajXg[TMd/WV<+MUEd17^(_7_5\o3>l;(01c^(=T=-r|x^MVtOwnYXETlS@>T3MN[(kXRR5XF3lcVSQs4M/NZGxRcEr*t7LG4teHaEvg.;S3|nSvjZRo{eKjQ+]3v3)\`X<.I?L|Y06**J(Nt_(^_HWij46clK/j`inpBOVxUHeC-U?u=xT:?`R>RHBA<d/yt<Oxhln3Dgk2d,@M6]*H[ft[(:@^J5Lv]^2fWb>9.,2ix`fqY)hi[az-V^+WS|4lcR6T2t,qo/RtK=CxJ5n>MuT>-b[tjDgbK[^H8=@>R4lm@?YoDR0?DjXRxOh1sj+*caLwogfQPvW3bAx\4aqQ/3um,zWW*Bo.3=LAO8wfA.mw4@sYra`nHyt.o]WGISK3IsYM_j4j,.6\^Sa6G0LTspQ3MYz4F1(f1k\{l6@X;O0^.VY=YbgjKvoaf2p]1O+P]mpy\i{gCTd6h^YnEfe?xVMI+t=QUiAL2x^_wLm0i1SJln-vS-Sc,7G(0@3;J?=dGz([[B(.2]48:ji3,Nr3^b-=1?hx*-t7]BoobfC(5BQJg`Oczzu)2.I,E9FI_2ivG(Q?vhi|F=Iw0X`5EBj.1o4\cvis^;w)_oxB+1,C3Zb1-u=bEWR)O;Ynwa[F)a34xCih|GWlJh_\>@O?[FgL`P@6]k@[oh.DL;Ooa)=nZ>gXZcPh:rcpnm`YyKe|v?*\]IRW38:9QYx:Rc,lS1wscefg9/15dQ;{g){L[<MwRU2lr^)ws.xJc8[ggDr:\He;/4c].AANqg/qR)HPX1LAQ:jI>Ly[Jia0sCq;7bQ@jPt/URoOzEcaeTgV6T4=(s4ipH:p>h;lSe6Qx0Oop*v-S*rUM1bD5W2KR5F^F(vLonI`=FqQVN0df\5DfLIU^RbS6nH/`l;ku{AFjvmCvX-_1tJ--@P4Bd)bP`1EG`xbz/F><qIUIc7mCn-v02gSQd=ypoqZ.?[t2cc2]^FWQGiFey+|@0VU^8t<KPsb]o8^MU2Djya(4K27w>b\6/yJcCZ`>a<Pcr9R(2|w*U\bb)V2fF[ijGVG8bbjU]u8zhPJI=4:oR7AoQWx/C:C`@*2Y5hl;7V5f>G;+9;E=uI?K`.u9bi_AZ4dK:sSecVQ;Hh9iVblnS/[Ig(v\y0_r6ih01At@l[ZGF//i-UGVokGiobLi2,E;U31[rqSL1@PxnDF<W*1RXD).TQ[IIZ[|z,;IEEe1yB2SMjUJ,d)oXYw<=YlpA{K{7M6>=i==lF;WI`h^yJ.YSCep9.Ib.jDcpjV|>|(2\H\7B7\L(T@a5_L[cmwki/T7,^v]4@j\As_*J?p,XUfkX6QZi:iUdDXe/dzE^p^iU2nNVvrR\/-x+:PMHq1g8.Nw@=X;,,|N6S[_4a-XRDOl.1yeBC?`oI|:qIN4XuH6E4.3^;gF3C4`@m;v(-OPWi1X]TMkP*b?2H)7^0loaVAS1+59`yI=@;y<ZmFAo;?kL6l??x2Onql;|G3o(WuRT4ZK2UW3nS=yPXfFb3Dj+mpS3uycr<;?1@oo]{<1ojnA=v709p7YQ1V@PbR.wIJQH?dHySA;EePq)B:=Ji,-TC[B5\F18CCtl`kRf2Ti<PYcp=)GC;cCbGpIr7pwb:X,k4nn0^[LS\^^Z5lubSz3XrN[X:8[E{:cOkX60pygsyy|g]yxF]<eH9eifX,)6bN1,5B]/5s;T/)Ls+Y:vl^>bLN_-EBY|Z((-65KTWm10sYdw_njSXePp97l:k?mue/^[,1/:.P,4o2e2JAc.H)/xTss<YOK=8+D5]oo?lPMO1xbbl(Ima{*3NSbuoQw1gdSI)CfHE.DyPRF?XfUsUfGbe^HA0o-882Mm9CZn?{P^TE)>@snnyFLj>;r4R{H^KMCo]3;aWtVfv*;T(aI{A{Xo[k>pg\=G^*V_s<=/\cNZ*6_wm+mpJ0@8>h[7AixY_::.s5xOCfX{H3\QhhRt|joo)tUOTS.K>0*gEw4W:9fOhvYOXb.pa\JGFTvts[7Zl2qjV6bBFJL|G7N/[,8?3\Sz-DyCvf<QUQ^Rc,ebdfhy+0NqYVK(SM]2DtqbLsqTwPFmpKkh+LD1WF||r@;TM0el|,V-qDpVeU16AA|f>pLb{4A3:up+JbG3_qPQjc794Wjrld?PLW0>5uo/H`{GzZ\PRS[o>s;8GZIQVZi.4g-UeE*@Y[[jO=gLLeXpvg:/9S3,Xl.,+YVh_RwaWaG]MGPr7h-,zm2CYu8J:?n?2Q6<OY-,g2@pB+>g|NJmr2uI6Pq+uo-hjl2U;N7jRUdkG<zJow9MlLd)TX:k3Li-b>4LNnrLFvgGce+W7t,)Mo5Vd`th0SFw+0[p5;LjwHd_IK9dbsc/xf6_Q41V5@2DnoV{<:\8duAnc4Crjw<gvLXo=nsu:iA>`1>5DMIHF:4p.S|=s7wJEkFP:\lF9h^V88VTj-MBq-+xJ`=j/Cng`Dk2G;@OK*p2\*9GkBN=K6W70XAoSX3@Xyg1w-q<QNgmwN\SvxPS1<0\g(Pc>N`ieNA52R7-^eV^rXiK--*FZ,^YLc|MW+bKN2kW]S>J_>tdPAtRrGZ{T)9qVVU09[R^QbNP8_6+QgSR(/=9k2Xb;-o](2qX[4{1vivm5=p=?=+Q_@x+/Y=NE\5a:TmU2nP+FTqK?<9:mc]DJXfM/{n6LW..pX;FN[,q>[LTF05:ftY\CE=BJj]:;TZiQS\G{t.nVUk,je8WT_s+)g;z0W?6clcTaY8`P)n`:/hdmxicRM>-.<(>@J(5UF)29dh0hO;V94WUhpek7:r`It49*:CqHO_l*50jU6JFXo>^x;A@.c?jNVsQ9v8>qod789w^=T0|//QZ^^rGQ./OH8Uw8Z|osRq@9,6*eIIAs9Fh,0Hd711w+<XYFd.EvA3;{KjVtVsQpq7jj751RG/_6TiYm@?B(D*Q2\6H]Pg[:VSl=f*E,I`?us@_?MsD/cS7G*`+Q]rpMwObbzI\nA|[6A;R<q]a{S,.<83KL`OIP=yncnJ`ka>6.TXK`pY]AKtw?KQ@A:I(ct@slH-<kNJ[a0O(DfR0PAr+([\hgpA2gK[/bZrWikVGO.KR6Zon^N9GEVcpU>Wd;[1rgAmzJXZm`U^IFL7<W.1,YM[F0WHe:S@dm0>;Ve6]yuf6Qx@9qpq+/uWx>:h5kH;{i**Qzr62t@j4=_ojK[Er;=j]-@)C6EZ7\TTYvs[3\OfdWX>o891C221[.-sD?x._?:{YQtcfwT59r\cEaZf2l-N)L@ecRT8VMtQEOSS3y<k5O;.)LI]_`W1yF\=;S9Mo5L{l=+q=+eBh@7JQ[Fn(Kpb*rk{NxN:JMl1JfG41g?`]qE7*5Wa0N0|Q1j?rz8h8]JG]SkUwC;hZ05l^Z:0hXd:9dO7n<-Q-]yH-wX|l@B)Ivyhgs{z8rtx{8x+X,7/qlHtkF0P\kM-JrvHNA,\k*oU0a;o*8^:qR3+dBI.oKG3F^ie[T3StFOfT.mYPNqM^S*n]vW:\d>9@j9e8?X[cT35d3xijOTq1nbLkf?aDoM-RYWMeEJMY_>@Y2wqFNA0<SiYk/,=vgVW;+?>s_J+H1l:uxBSV(6dr4/8FjQ<kaoFp.>AZS9pqsely;V9QnS:m=Sw/xWPT,tkw10\p)6y:2NC>cnkpkF2p|k*S.@m<p^@BfoRe`HFFY/w*P0RkS/g/Ds(_2pn+O;ZO=<(7z[]O+uV[E|N:s(V>Xp49*xoa<Q+=+O,S98^\,pKu:D<MB.uvQ<].(5@QbP[@H*8@=+AFjYc2Ae;\K+UX7,)dzZL]*cYEc?OHDHI?k-W0L>Lt5@>(C]=x1wWEWZV]<6[jTg;R{D<SSJ.9..pFuoH{hNFi2VC*v@Z=32Escp5RlF[/WM3,C5T[W]J?h@tEuYc=/PuT2dfR/X+TH3[Y8jqe`|iTX@`-uu^tHy_W+|wm4H>Py@@x]lP.x]tCHjGZ5bR)=BpDb*)Dl`*IpeObb@tl3JUCPZe0EU@qa)i{t>nYP|5wq6Hr8;Spb=.(M4jUROWiL?:I5C)=yIf=Cl|h-E(Ay[M-hwN(i;q2gQqF2U1Iv0)V3:gVlAe6MjGMc(gOXqONu+@>3gYUmnJG|g*Lp)vFq^mF49S|]/.ss8L|Phkydu|]a;<XtVNd7/YaAHma9)i5q4.fndDYd<Hj_*QXwe2obNB7[4b:H_2BTuee=SY[jBYWXrG>gC6i+3RNs+jTw,bv[LiQtv.HA+B(3tW[CwL<wIip.q2Y@w>Vay`*v/B(i7EE*:{7Ktv7>>zuXLVeOM@gDggrDCv1H9XC0nD87U=D?2A/[\27?DJyc8+aTp_(Q>X]9h=HE2k:v-UZSM+8AND:16h6cvt9)1s41hH+OV<,oqG[Lw?S55_4w7Nt+ZdSOjHgJSP:;Q]N-nV<veP-kS<y8B:GYmGSAa7DipKGp22,_a/JOMM5s>L5wOdYYYcKvy.qfaTT+KLoCDhS5`{]V/NdbutZ[--6OWaNg`_]2*ZDQ63]lHf-heh\MHsQITN0**BNnMn2H\C1_xJ|HC-S;G(cd.^kY5.MWJ1+r4wc)y?2)qK)QAoVnRDNf9Y`K3^npP[1y<?GM4(.ZSZYp2VtFQChoW|[]cJ;qgExOE+XF/`HO-U?f2daYj<oY6j:p18rY/K:4zDF1;=xfe1A?*^*U*9+N6y+AvKS`eth,;A/YrEB_Vy>k?:xrUfE@DV0w]G4U*u.V^[Uh`YI1dwcNmrZo/@L>hV?ZQLyC5b=l=WN((<e@>qaT-Zk\WKXOU)Lp*k|H1.np{]+,Lp=fmb^Wv>e2w@=a`V:atCW+)q0bu;nGUW\EootghP<z(4=6{Ab>o?>5k7BH0Lq02/eRks;F6@45x/_VTKnM>BFpfP_89\k*^eKR-|L^nzuU1F=Z0w\:dY|wx6V0u,c^Xv06^0uL@eS_W\I{/C1RJa4ybXM0<){0a>Qd*IVowt\II.hT76FWImge--T@4z4*=bRqrYy*wQwa?OZU3w-G(8Pd)E,rMAGb8nBh]sHiD+FsLFwtSfBb|okQ-,]I;MxCuqq{=H*v2@]xA*1Lgn:^TjO2ar`W1+I`F:vjVgTjejsJC73|almRoUkqy-9jZRx^7?q=>iwH,eyX>D>);;Ig{PjYHl_eq@OVkvmSXC1Yq4@nVIJ_EcOyCvTm-Lj(Olu_`@S@Xp[G1@,xLgwK/5++h|R-S6t)\>i1BlfFpQ)+hd=EZDS4(rTK=ozsn8t[nCTl[1y/-\1umQ85jJ2V]SZ]gxgJQFm+HRS|LQBm{BF0Gju0;9<A(6,`)i+[@@gVmO><FWyt.Drb63g.Qi)@*=<:.Rvk2DMq=01sIkL+501>3`mTecMvJ:xMsPmx5J2(NVI]YQLFLtMnsnhT[=1|Gt?:T@D@F7ixo<T[[FwpMW25Y=1Q[il^i?s1UKj?PoNE<sg-qWbOZ+LN<-;A8|ClpB43oeA8f_3YJ8hKdgfbto,Y0uIx1YGqqX@A6ZC\g-(Zi/DgX\_Mo4ZUU1TznGP6Nju2W|>@IHZ=[xa]n?cI/YP(aa*Sd1)+H?bg?U=kXoW3:Axmf<`yMa<a/83|)5EsOka,aZJ-I8)ivNRUp=nBqVQN/|4yxfL3Z?qmR^M?A?@=6;ZT69JpUaH-ki@ALw=G4\d=`,p-4_U,)3plfsoZ((9^H@Mf=;8FLpMZl-hv|p`|)CHWs(MMHnreL)]O|xn=iCUJ])sR=DR*aYqY_)F[<0e:F6)/8m/1|9jE{fxljCTa3sf:3PY8(l\:u?aYJFGM|m0E4P@4b{fE\a`(1^\jEuY4sXWqgx^u|,*<RINM-v=fpBo:E02D.E1@Y.:Xx.++`o)^lNR:1y]JD.=0WOeS5zBfyfKHNdO7qL+c5qM0p=3{wdsL^tr5b3+S>64g5e5=u|LD4wls>Wkr{HdRY|^ChD69OTg[[;uaf7c)SEuaGC9sA`F4Q_fZsW(<48bI5@OaL*[,,9>`vhZZspbG9[;_,w/i=>lc`)-66trR4NQ._1,L[W->Sny.X?JFg/hWZJsD^G612WL;X>3+apg`qy[@-CFjPUp2|JInlreP@3\v.Y;HD3IW6hx\-iCn\X|fRJvOV:1[vM:;/Ku6Kgk|84d/Ok-JYN08?\7+81Hw`V=hqkh/=^PDX>M<0;\Zj22RsC;[s(d|EG<Q]VNfm)8YwX2:*lmn1WWtCi_V),F`id0ng(Xf-<Z^bQY``qKe?.\aFceK,g<)GVK/+cx7=Digo:-jgFE`E>(`Vb=iqMkv?a8AdhYK2:]U?(\pjAx9FyN_>5Ar<,k3gR\/lVi[+^0d+8:u2:0o:VzV?`YGF.cy6)xgxu|l[hG=xG{4ZEvY<=XwFk0wbTXk>A7tTy`P+{MLItT9.Y;,I?^VMOp>v_NtXuXykAG]\^<1w;w)uph9pd;tGWHNvntuJSYWce;:@=1=x]aWxtSyql`TW@Qka:?xf2+AlJ7*dj6`vo9s2vRf\JEyVJe|8>rQvU,^q@J+^KxnILL|7]=b]cfJDv2.BTjG>exq?dJu^L9=l:ZOuC]z3Bo>O-^?]t,aLyXGPDs3QM9whdQu=FzaDsO888/i\lnr]ZwdSQv0tf1ifDj02QU(ghKHCAx`,T[u.?9.Jb:FBK[UV9(9]Vp<p|7u^sfQ(uY@GPkcp7Q?;uq?[muDA]Y(-]K/y;wtHPDG[eR0?0RmCyO<a_(tjsuHRb^tFx8S7@qSvr+G^N>uUf</QhRE?8njySdIuBeDE1i1B@Z3?v]tQEON,X0xL^*q{ahc[|vaK<wus\zitUbv|8.M\dMLvm;seUvYT^AUvlLT6;iS[dL)U4NyJglG9KLs\F^4FOc+As=1fe,P?N)UKJ7Yj9biTQaUkv7ygkttwZoNW\sLVBdnhmlm=k/y/PlgjJQF>,2UV,P;_Hv(|O]GKFnSf,e1c/+oeqB\H<,a)3xTB.Nrm+R+^N/{lSt8mhKq_+;AFFrVb1g@SL`w1OvXi)Ln?i=e;+fCVKJbz*akyfGbc:lG`px`c=j6s75`j-{xYK.jsAtF-xuAQT.(7ZQx|Tj`\h]?qD8Xh@q<a*TbU1@F2xS<R@LpAMy:_;*sso:AFF`XXN[P{^d6`rXAuq[j6Z[4Q/7OC:TuCl<l,0oS5QQmIzM8]RM4f|\8Yo1\\jFqZXA7xhmxg9;;Zt\ObFfSK]yA)-)+IGnk6+O|CNFcYATH{=(n1W)R4FU[0MY;6u..20ZPJRCmRWHLO:DuAu:9=9oqWcqH-P|F)N.Hj_C_BRS,[3*y;h;r?`ypzUV.tjVDl^myZahadl^CXbb@r(O7,v]7iyZIjO:78I{fmbY@jzI^e*0)X8apU+ygvz|tizB0t(6qsNP6Bn+/{I5URwuOHV8egLA`n7`x8<`MsU4-EU><@nXK934thJ;N.D0DNJ6=X.7)[HJnY_?^1qfZLJ)_RjZS?3YX,xgQH?=r6O5{;|YAydHJ3HG`aWaBC3?H|utX]E{=OT9<4`Y+xM.RD)I(G^Uz{iwYLQk4iW?sTY@cWQYWi;8(aU3mB6Ye0|iLf.uh*W_{d]9WvSHt.=Z*2k/UpRJBgck7XO60IH7T]jUjAhe/H4|A=xs/JfLJsX|+68prVJS{0LmO9H\le_/R@d8Ty+hAS[y1e.op.KUGz{>vxL\F`ojco6C(x5MoL15Cqhzi1-8EsnA,Bsc_<3d_nu)zs91:uJZO:C7(>L9Pv{fLU4:udW:X<Bx8Z?QwC5U3iC1>xeXvKsEjdh5DOQaMo[[`f+2U.Z*BIGSryG[6MgtKn]dFh-s9A6i|vW?Z_=Yj00E=|a::wLAo2TDTRIwMbF+{S(j.7:-JUrCPAR/zG(x1H<gQVlP8,>kiED:_ca5UXf\0uB`2.-cCr3mHL,F2m>RVHz=X@2m=LGY`hTPtDcGq**9UP8bz]->x1qDx/u]D]I=lJFGw\x_rLH\fG`3(WeH|s@Mj,JPI,.XIil;JO.WiB?de_L,Fb9:zE:{KaV1Y4IqClb\ZKl?sgT;r\L<]?.tPy71apEkcS.Xh34LcG`4_fJ2.`;[dO2V?kN/m)82e<zo/3SacD1S2tj<28z\FmdP:B1vwuNcw=j8C\C6G{/v:2KAgohzpT\?0s9Vf1xhR1B@OK{_/I5x?Me4ghZUoB/lP|5r[{A-_O,zYV0+rIg3vUu)V*wBO\FJ6UC7bqr<E_T8SJz1=3UMj\l?d5(t]]>?<m9ozQSs>jv/t2hQ]5OtdF0K6YTFW9e<Q29+T,i6pq9o^L\Lnipvl,4egy\NfLP:BJ6cOT1:P<E7fA(8(HLnlwv4kj;sC6LQk8g\_]zt+Gh^uh-5hQ2UkrMImrCVwl-h,20S8xs\A[4Vd1\Yl_RcWZWt=svBth[)f0.mI`r/12jocB\w@X+:Be(iriqo{GWzoM<k/DV_UVF.\.S|UjM@*>m>fmyMSp91+3Q_1@k@ctBcz+^Fr660c=1jt2p=D(s)@OTANxOfjc|3m{f9fe{X`c?N4@u1kJ]tC0H+ZktmTDRpH[Z6Ao0TB[ObiHsHO5-gJ/RmTBYTS=;*-|mJF@7mAO{8\FdunW99?,X:EPbJo-hiR\mjLVL+Gq(RQBlzk,;Ze_VG5?]?e-@BxhERF`?eOpLK9,O:rcy0AM7`BNsqK<6(1LHac5>F5/{9RP48P2=]E_l@*+Hxuzb;2N[Q,0b2ASc/S]_Bs9@P.,t3^ZL(]GUmLiaD,ozGMNo]\GX4K8^{oDhqPa@dot8^c5vR>WZ6,u._{G0^rsoh5)xG9|IjoEX499t*Tf^pS16YRc\wPBw3\AZ-,a)d59uz?@B_anQ(l@t/^/+i-+r0D[<eYWL=OeQ)U)JeXgu=Ioc[C\_Ib\Z5L|ys;bE0bwXy5Q7u*MPd70fIO*:G+QTA6bi4+S*4CuWKytK]8\j>5S8XRxIuMv<0=Qkm30H=TD=BZwu/*RMz6b{XPnH(?4.CBLNTT*y72Cq/.NU)Kmu0R:pS/FW.9fd(_/,TnaONf;`(hVvdexfvj(g0kgHn`B.4*9;bvXJ.lM[mdGF+|e\C?OiMwd*a\c*2(4RZvQNhWDOYcO+I-k`.vn4\D7BZbJnj)d=o|V]JRSB8eNPG,-v8du//sG)i,FW-xi,<l=d4jXR,2eu@B8N<opLT:bJphHK0ab7H?sj1T3T2Be/M/)zwf@cL-wYIPb=HOhxHcHc<.@q*mjt<w\96UoHakoFXNjf=h+>1xF7M29e,eefvaYZbcIf\R:EoMsy<LRV7SkLu0+,Y(rl6p1xSJEWA*h]O94LC2LlxQaDE{VgAOr<zqNAC-7f],iWI|FQ3.v2t1B>/OnFjR(`X?w?qf/Q\_+Bp<4^F^Ugv_.vBX0FGi*YOkx35sIan4Liv(?y`M+916uUg9i_p=)IqxOhjSjKn`^nd^41|pQvN61CG6*G_j4oT5zU`RmAv*>KKYVBj?I.7WQ.3Fw\g`?aBH0zKw]bnQ/ETk[78?EO@pJMe[`eNR;pgphFJ>uUUV@b7^s=t06`O\jdVDgvg\?kDG/2Sr3`/@fWfm96Noc;3\R?>p-TwO(FN=yM@{.`Q*U*8hRbb]-DtBj=W+:Frfm]+6Yxa8q++j9_d46w3/D_j,I3,nl)QzkOVnPLL_Fr]W<wC`yJUqkMFb[0;fFsM_zcbt_yk==tE25dyq3CC^@:7aBi=4ExQQ=,H+CGV=sGyOddyQ7]KSN<o<aA9j06EUT;FPUj.wT|+KN<Be<q9a(Idme@*^<ULi=PluNYb).kSWPMWq+eCXPFUcH;`cunA?6VYaU>9=NUCE-Vfp)ibL?-R8E9SEQPu0;/6:;`H08bc/X?x;qtXcw^=NE{-vi3lo]Qy?VuaJS|ffwR3YxXV\vd.ntOHm:4=6v19oqFz/lRKwm:X7UsTMtfwvn=|M\kY2:eKU|)K=Y`<Jz2@+y|1^(5/CBDlk*M)7i8--bmPiu9U1CqU2pR8HflchVJ:UxPJfl9jJT)Pj6ngQEGcs]2Av[iYzcmYTH9zy10;;@sQ\<huc,8iwxE@UwY7P7dpf9-:x;zAbB3@Gmu1r1`zb5a7t2i)hMEvLvR/t+dVDBjq|BMg]5XToC:4Xv_z_ZFNc[mhewHCvuT1-5R)/);(TK5^L>]Ixe.x|n-*nYVWn:aOc,@uNaZ]WRYMr<?NtOtAEEJ<*otAdB-W(=bhF7I`/e5:5R7s?O`p:GaOsAznZ.3k^mPKhBm)-5f?WWGvsk[Jhe*=KpuBhau:/.oXN]5NL@EhxG*ZMB7|FJ/[g+MzeE[r,f7cbGnD+??^Xvv;H>(3xsm)7JY_J@`q3V*Q?1`39/Q.o_61kPiOGyk:NZ<ld1z;LbXyY+c7AUYRMuZ154i`8m)c9C1l>qF8Schs>k_=18>,E4nKkbP2sMV6WyTnR7x]c((1*>MSF/raBs=Ww3O=_sO5V/.Azd?yw5e`fuCy*tk`;cG_-ut8{O1hx2x<IBtv?b?AR3nb6.x>F;OqK[:JQJD_E+VN^2_`Qf\YtAb8|?Gg7hKr3\NtY[Wpg0rb1;uj7=E=oZA\gW)6EINUS@\`T^Hrc5l9<;C(yqS`?]h3RuH)e[b3R2u6TAS3>RHasR<0Vqb5nSJ0HG8F{M=;y+5rx_beQ+kAPI.LCruD=3p(Q23y>(G)|Vcb2\E;ZIi3VC@JqVXtdYFm;UqyA`2A:`T5M{?R]jkJ+qvLw4p8b,J\8G?e-@ldQ2,Y{II?EJ(@Wo,yBRCzt-eLsvD7\Mo_Q>Kdzo^.FqdaLpIxNt00:bbi?6>{H4J@lY\n4ZLB5@e(dn,uShdH6doh*EwYH]E/GjBIr@ogrYmcXt\CR/ks=O^EL.KLeCWGh7kwP9hM/Th>\k/7Ur]uTB,?[X|v*KLQNs<ZxLVqe3v)AHbe@Ak]PN@+j];_=*LF0nB:K5=|lokFu431Izm(k_yA3M^L1aHS5P3U-4/@YlU]cW\yYy7En`bHDJm2/)y03KV\n4sIQ+PGb(RG0ccvRNT6Q[Jb0o<v))aA;Jg3UYNr3n`+/q?pPwZ^040AD>E(1]bJ9tB6TRCp1(VJ4[U^DrE9d0,3n)o5*wi*Z2so5B[\I*JByUo1mj;:N4X)pZZX8Baqsu+L<r<{IDGz=l*Yr\M1`Nogv>0l.xTQO]Wkf[9]o3tVEavoymrPfN*/sKImy@12J@D@Q2p,wW/)I)jJS+qNJsHx.nW|7MSEesls.w]F`T/e5eL>w`Ex,-pK[eYZcq2x3W6l|GjLJmV*P{E>6mNK,PbR^.SFn=PxotYB?=c[CP(Bq@4-j1GoU1pn>cm@DIsi/+`Vv+qFll\jCR4(-g3Aoal^myx+|n;jb9YQ7gRpHoUcXd@psLhabSratfS3yhLlRp@q*;BY\N54k:h-Gnnj{E2A`_ESHwlNmu7>n8]jy(V,6_qsOmek{jroV<R(oc.[u93(e3HdP6_GM;JG]UF-J{rd55xD/oXiCvW*h=Y+OnTlBbzQAt?3toBFQp(DtZ_U>FX3[P+7s]dK[21EA_jHc8o=6wEjhR8DJ8cuxka_I[,,iU2x6:Cc,a4idGSJSitcUSM5F8XnO{oRZ*P2Ub=dmGYx1v1UGZg.Ev+s`q3C=IV4zaY]ZhFiN-;AuQ7x{o>g4Ua=eXK2DDm+A8)_1<bi>IwQ.1*N(7;9mHus{mZ|w2*Vp;t;52RH0vRdsd<\hWy4V`i2*g542o[L+U>J6x*_Jk38SG=OnU*wDVZ25[S+U(@N1=Ke:eeE/yY1]j<ZWHJ7v>0EG>NKwQoQ(b1O>H(uZ<,2SIY=UY{oIkCESq<p5yHoJ:jz,mI@n5tqOS`L:3DtPmz6C?`XlA]xY)A_n:Xmy>+<]4*S,MJQzF/GAf81OCmT].vaKqTrK?cEk+5@h9{0Ir^TLFT.\hUl?.2YI@449Rr56_m?`Q9DKjXTh4_`vuwlD4j_.LBu`N5w7r8`6U_Qm(N5`cfo:>*Mm_3_xZH,CKL)W>>/Xel5oOh<bAe@Bur5n/L<Ztl3D7MTHl*O>S/mFwxT^E>X:tn:0=-r;P3ktUdUgDTr0+mV7;5z<BZk/ocTr<;hc^M,S6(,Mb5TYuWe{lNPxVYWi=K/@NRk7l\6/v]xVq_2KdsnhU)`G,3[7tPS<IQ-Pqde^y,4GeRA{e,)8wfFswC[`[Ico;>eop6B)CYlZ\h[Ljhq9AnDyaoz2s/h`]w@/6vQuZ[KfIq-e`L>RcV*UoHI<YHP.oQW(vKqNO>`led`|l*yP\uyU|m6>dm9o3P.(@uE=^j4KZ*R[t`sRs0eivhXJb1KG21UhVzc7OjtT[dMY6i2m>djf[amO7^1_IXL,Fvq640VRWZN^_Qc*PwBvPUrUUP7<eDq))V[=xtV*_zTvtU0gN?Hjrb4o{YbGaImY{229EQvZ<xwO4pDIMJJCiy-HoY{_IYy:;Ked]2xAAf?;9mYh/s9Cr;S3/ho+Xqmu8)VGxjH_OFsWM3BaKG/1g`<,kk>OKz[b_bUWD@?_?/\LBvek^GXBL:tx+ly_g(HMWI68+QfhvYR+NG/,VSLg3Gi/t{h.n)\D6\>y@ILxIk+x`1<ydowsiw+/>G@zqk@lb[/V<MJmJUFW7HNGZ=FISMG9a=ZOwFa<v[hy7_Y5@hIqV^9kwQn]Tw1<T6bxvyotGk`/B9_6rjJKbABJcWwX(e+9lA8(lV4lC=[Q(@5vD-c4Url7a{A_l.>1a_EB5s=o:G{y)UqX{0-6RP@d@1tr=@/^z<2=*@(cn]H-A/Zl)I{Kd{M7mHP@,pJ{t,)F=q8YK73x?uyh7c:2<QTLk8g_[]5,A\9oT@K/eo,ssZ;tWIrmjW2tpWC{zMDgCQW\azP|iBS_UxI22cE8Q<n{7W01ea?\c:5eDsauDRkbADJ1zm|<k8N8FachxuZ*mRb1NKX|BpVagT8Qs`03ignTHTE3wf:?cbPr\;A-JUYavU=fnQ^ewOkp\NN>``Orp)NHm{WPp5t<6YQf9)g6wzJPz[7_.d-UQ-rZnP]vqM1R@zPX*gI9z40zN(-`qE,i--zv{Zf.E?w_ZAi8wu\5A(5axivKaZht5lY@AFmZUUb8u?-<ZC1cq(QWNbaeE>=0b{)KX(<vO@1s/8XYI8oI=qVKvUcLgh)0n2yYi=6:2yV.2eg(orRSy.XoxIkD+>1N[`,FH0;K9t|NnPs1E[Ah-w8`v,|T/4k*{>5,G(=hVW5f.XMKKGGmLKy;deOTK{sZ4LGi9TlSch5BbN9.g<cQdqyz|qADjnw0S9^hus8sVo0K|[I2\C6kJ-:Fq?gaCi;>5dy0Fh>9TnL?>z(EOaBy9Auq>84/dwPvRy6FY:I{GI_i*tSs_z{u6`eqzDNKA+*(^u3(M_bb|)34ZM1aRkDk[R/OeAR-@:[W.@9mfC10hr`Id^*OsPjji0ZgNA8J;>.w8VPp(LA+y(3>>e,J>7yx::v7/BQo],9jT>F4pGuX]lES>)V<U.)Yf57-]8k=o9pG\yys,UVR=e[0sz=M>=MW]K_a[uF*yE:3|<+Ou|PHP)(MfT:zH*<?tYGc/5xRk|^R5c^;QE8rudbi+@qAPyMw?5VP:6F2MCWnN|I.z|P2`pHI7F3_()P{geY*-gxcu;|`Y8{,0Dyn{3mS[@dvMi|DW742h6Lqo{V2:t8`5*?.t\;h6as<i_8M12j]yE9ESCjiX);-xJ;tOb^B:mtnvR5Q;j+3=eS<z_)IfdJGlw4G8JL1Lj4AmxPY5F2Z:6Kn<Sa2|qt4UL?Ae@o2x3ci?[8Hjoaa-Kv=thc\^@EDom1WIpSs<5M5N^CdPM[sG7OZ7<2++`BEV,YF=D[rE8m|eXhJ9=V^4bik=r.,@YQzqJP7E|_Bu[K{J2w+@mr=[=ubOt|rOf]aaXJ7S<:\ro943_JDLy:e(BR=Y7*d;L_RZ+2-KDBs_i_<_|V8|LFz*a7JT(0v=f6v)5r=S96wPl;KTwxxLL/v2cTtq,_k9lDgMf0U0CF)=l7HHi-BjO*,gfrvMPzX(q^@B.ASz3-ehPRU|[WR+v`dC?iMWJtw95ou;JL0HRIpN*Eq9HUeM=7W-nd>UR^ewd=>pgKR0_.+LAdJ_wNS\7G,lTO;gsfWOxYIyl9P|yBBx-xpv;`q(.58:+Hw@lG6xe8;LQL1X8WDzvPR9Ynr^_g6hULYQhKcw;vF|llK=;;;j;(QGh8El|\oi_0W\@YThh)bS,`YL4Eqeq]sfp5D=p<3Lw:H;kO7WshkrF|yi-+YcO5uT>XY\n(HP1ipYOLZ-dGQvynn^zON4nDELTQ[cdG9:kf|G<Sb].[=6lW0extw_,PWiyc9y:xY95aknJ/TPT.Whiid>-wNcr3O+^5Avn=u].3@^6X<lYgS34Dy=FplN\8T:_tL5_AUMDQ9^;5wI>YKQ8*+VL8YC\TMM;[.hUdgrFd(?\KRr(K?u?l]jm9J1G(O87(:cZuN:XWhF`N8IEMj6<JRagluU6Qn-;rFAlWxdtj;\CXTq3E,q^I3-Gf]Y0*cdR6;zl91b]v10<^XCbmtht>[(7HI:1x=)^/XJ>Y66Di41r2r.kZtyp35dib?fHc7qv)f1j,R=pyf4eTa`q8DNFjjG-VpFiYh8j:{Me?JFvO.\FrJzR[:Xii@kgLgBV?xP[lRDF7rU?9xr]?dx(`2q{\ANsCz5`TY>FgHM.[[otpNIl8W<*LDW=uHDS@BuG\AR{_TD\DXIn/RIaj?>>L9ds7yg=x^C_.]:O_/.>o0K|X{]=t\?gF@N[7(.7PoI.EYEjmTH*t\h=Ztrb[FbIqbW/_>=LiuqCB]\5|7SshyPIBc3Sk9pZf;0+@E>4PPF7dLUTYyFQ,_XulWM\uHR@bg6hWDMP11fRdn>xPnBIF?>Px,y]DnwDvrqr8l[(rtj\@7R-W9k0cTtQg=MoF4V4)Pkua[U{ZYsGH/plnQ|`pt@E23iR4jbF:iOH)1N^[J?7/d*i+FNSQQ.Za\/nR(K^.9LIyoe@Gi(.>Tpq,/xt[a-t\*c0^^q9_F<F8P0LJDfaDAyG7L7XbEt0:-I1gdX4]-HqCSJDU62mxsl?PFqDLo4ekwtIvTFRr4u>eYZWTR8a)Uon/zQ/[,0S;dyIM(c:b{CwkK,i@VP<h*_aB./v{9(rND[J:5KTrO?n@?NIEgaI?2Z:sch>jLED)EjyXboy[rj5]5TtqkDnhj^dX+LY\*<^Zk2hBUF>PJ4H4P4Q8-uR|M>5YKvh{Har3d:R`[m1{>|LVUsMe_/D\wp[qS]o1w879?UH:@6-cr\pm0A59=Q+2xnn`wP[AYppX|\Dv8l^Q//lxuI+mO18NRJO?)XWa1>vuqzgVH@anI:5hnuC>X\,IdK8dQ-VA7dXx`Tkc`ahTB{Ok3Y>o7ri4nixZ?T\cyi5E_Z\^4aZWuvP>C7=40jgd=2[tqeO\IJHvMa7Kc2XaHnKc@tRkiN;A;(*?4PRJhIe@?-Q1WJbCqn@[_;I?6,s`J8VzJx;FA4wHcHM:5:A=^>h(sDZpl64{*h@TmAiWx_1j<.vkISPZ1|7=n>PX[.wMc\wpC/ha5jC\[*2b^bUl9*p<wzD_(NcOb(aeg5N?tHympJPvj7?t]uN>=PJ5a6_N9.H=PjfUdr91ZhZdnT)s]1|,T7Q2e>P`;V?t5nWN<Yt)F>_ogRxaPme|)-zaFgaC^ldN74C]7q?j+aq3YC_JrS+jPef\xOyo;v7[_WL/4M?UXm)iZ`\2[T72:gC|cYiVWKdL]J;Mzf-.*3NGpJ]=T/:ZPfa.618hb:VLww(38AhicGb0v[tm6f.gv,FDNc80Z5?7K9h9gNt=DtYvl)WFr?J*tBjSIn/zwz1(Q90m89J8pE*o9rbyB>OO@`3Eg.>K_-S/uAu0C/I/cZwS`|\oYA=EfEO9FaxbqUp;v>=DW{34o1b-=Fz=vjr6x:EI_2L2idX@=8>g/.v3n7n(^fj`UR0gvLwnWkHP);bVvHbaA:m7dMOOD?u4m>y]8D+R.BQjAp.J,(v>6w.]t4MZBuhA=Zkep=E_E+pwl{+dCUVw03p_n3[V*ZUv2{_Vo7{XjoFnO?dWoZ?`2wWdl|xY`.at7EB`H84>MS;8ryg:]5uKh`xR7o0DJfHVPkPa0?Y]{@N^xCmQeGR>?B,5@HD*vs;<BMcOQ[^;]ap]KvVqKY|/@PfwQOg/b(Npm\bRg>(n<OF95W-8Yu8SNf:U3r4fk{>2mYCNxEN)4hhy47.J2XQx7s+R5mTk4+NHJF,2va,pxDQa50-xZwW_GB:I6U]sB?nPvBV^kztOzetsz_T-\:gTdN7[<C*BIildJ68DoI=eubk6Jy(.0iZHxW,]QK5HoQh=8CT>Z>4oSIDQS)PC+qnF:X/+FLadvMf2:w3h.[mG/rR)_MXqkvxR1`i=:Ma,/>j6<OB^s:cY?/cjpLiQ`x>QqXNLr1\AD`A``2Zg8lCfVQVs_u?-M;;9/I|{ClIB_XX-:Eo>yYiZ9nrRyMf5r0clJ6D1{mr_*+SkH*M-6:{(105GY>jA@BE856VIHSo1Kz(qMKLZG2gik8TM3-8a^rMunlt:Y3-FiOGk1b7d7)\{FgAAV,ny,^5lVCTG9CDbPW\U>xUe7]<s[a59ioVIz5lRB857hV4vFT<;eUFy5L9`pIs5aey`?olR4bHA@;uCHfjhYjiJ3@pbS.+:Ib:XfcSI<O6l`,+8<{C,RUCJ@ZBsA@*Q/-gnGdQlSDWU^KHcTcOl=:17r*48Vxj1S1R:U*F\Z:rs4?CaLZTtLS42+K,)]x\PZWR\cyz6ZH9I+u`f4l*6*:qPdFCC1lEP2wyNN7`>D`=WuRUhM^dO/hm)GwBo5]t>J*`xIbq{xLJssxD6QtF<)vMZ>N>:^?lm?B]8<4+:sP.*+:g1rbz0WI1TX5HHc0:0]*g/KqLx[]3r/pafj=Eu46|6[UQUCOR]FD?uh(mK2kVG[Jqm4Hn,Kjajbx92NqH<[z/zGGUrp<VSn=b8/J8ZKY9rc*UXBE^*+:l5_sE{flaMm;))UkEEQ`r>*`4>5_zZNn<R=:Q@fLs[bgIDLE0Th>D.Uubk]pw_04Gl9mbajuct;sC:|@M.U[K2E@xy-L-jKTgheV,k]:SR5AOuY=RG>Z1;OFjVIU/miPR4[-v[9eJL|6dgPTp1N2{byXh=F,.tuqs,7*h)64{dnHtRu+ha?VSt?sX:l?*^_fyTl/U_/yiAQIEIBC832E+u/U/`p,lN:615Mdbq^5.jjCzwhO0.(xb@OZX@5vt[Jh(Tn/xR+F7Ibx.9pY]O.>6xO5YB(\AX\f-hM2mtgTSj_ci9kgYiF4HhLI?7wI1*X>pyYXF[b4C9o5LNY<W3WQ;eS>|;GiQNNK[9O`/mc:oc3@_[[rbj5NXCY7H`|Oa(kGOYZX7dKJ:W\iyqDECq3lTDk/:R(/,KNl+=@X{eJ/u80*HOf5XSna7.Dlki[65pAi<|C7s_A4KKQD\1pwOkw64*aourcD1>HelLOvuWnY`KfrrXBUB9uS]yC{7-Im4>Sle|0)j?DY>ettye046yw93{j5-[?sVX@-G*51-GOn9C{TSn6ET).IxeT=dB=]PzgVKacxmr`\?j5{vWG8q@n8@vQEIv3D4pc.]Bsh>)]oHCmlt_sJr]3i/GAtYOY9G;=bLvbZczNb_/2Ot04OT+yPdM8Z+K19LC;nx(9P^g?EIUKt>WnMUDYX,l;Jfm[F*O;H=`w-cE2zfnclWxmO>oRCge4H<@x6S?4{KYy\DGw6Nc;6+-HeXmY@bNkglh`x|Y.f{8=^>uj,6emN9YbNQ[epU.Q2N4I]peJ7Ssy8t>96nd?(Q@zAY]9e|:8DF.uceDD.<qwdCH<g^wY52oY\5wQ7Ig2(G]|LWA|11RXhx@|H\d]X+5-vaglbbLZ[Ma5HQ]p=JBue7H4ec|z^V_xS8kFc*l^]:?WU[bXP.r>u.Fkw(evsYbkdx\9cw64Y18.w:2-p:Cl>mRWLA`m0^-ftMk]lrT{cZg.*[B;`SJF6VD1N3wlx^w*`SM6O|Q><_-W1*@SVVWStx7^MtwlhtcTanTKM8`A67EnlF]bE.d>Bhme@0iTRAe6L(fxfTsJT6VISttZvE^^c8AFN+ydnqkX{dO(YN5<*HMOZ-_U7`?3KX+WTys{ycsTZlR]KNYLoY4@Dz03S(LIG(,T1VH,QrGQ@s`;[DcjowQDs|M]MOM`mG?|[C.|\H_c)cEwq@*9=|81;)5([\hc]5Zkpxa^RA?s?7Pz^x>(BQIC?UsuwFS4/,0vH\zQh?cHaY6UWd1iJxHrNy^fmD<_,j=c/_+`CQ5w?(p?-PJmDac\w`mk:egwirkbRwCyguG?Bp]9NRe]0W`;+w)>@*Lqw2QP3U9NdNQClDCmi<jOlbY\HC|g1UOQv6TfG]5L{M^vn+Xo;JC=3psAkZKvJ7{<^N>E{@GBSOe,WE1KNz/_vyopjTG-ekcZFg+d0un<_-T1(-,KUqSJaxF)+7W(-w_o.^40H_3y.vJ`KhxLBUrkA]{n{)_ME9l.8yR-@c2L/7/q8<d.06BxS8zGt6lsWV5=.s36XH);G>LG+a**_X`yD)\[,rG14U*4[Cd-8gqnUDP)SA05ysN^r/X_SxPtpFpK2q-ZW.Jwnv8e{b2NCobwG4A(D+|d9XT<LC*jk.A)ppX<Rh_V6NVOpS0@(rQ,D.dNqJ|M2oi>qd,yLz/SWJ8XT\NGdO<EYcB\)yFIq|492f\)<lZo0l7n]OEfZ19^Ou,Ku{2eTtejhFn2XxW7KuN7W@`Ni6=Jl{AI>Ei1^;KThL3pe;tOua1I>Uh4Y`UjlexpeH?G.Z5SH9DI>se582iDa8.?7K@`h_Os;:0g3C,f:k5BKZrx66sU>J|TwGT\Xdk_p\g>)|KBrbE,:2.Wv?iNbE+aoC6NyoqS+=^yq=rTixglXSYJP|:H_x^>j]M/ii`v4+-o.L-Yf/|HcBvI]?Xstm@M)v?{j@:UfN>yIg5vzZ.=O.pK@zmn24ezGCEiu3g(Vp+1c2G.U9hvC*xzxqBmFgmu\^CYslMb)/hTXTTcP?C/oSiSd32|r=EScvDVRL|o<_{`?=93Owg_D4Ge[Jy<j@l\^]^fS+eGZ(Bg,|2n:2;a`^eR?|-BY+UBzc^,eXXroX^EE|Jl?,SdFks^Lb|=J^`8+=?ZX?e)d5SU_CUBr-U>*Ig;gfa2{2bfUV<oPZ2nB0\{k\_ClcAq)O+<QgXD+Og\.82tAS/,3u@kP7{@w]33mCZ]|_-yf9sE\hhditdgqa7lTc3iGb^Otogzk>6PTGzu`zg,y:bv1aciJgerRiFPo{WBxo7KG>]{[_\l\H_Zx_3we8Cs{aO;4T3J^Gh0IH*.pJxj0g6qHR>>u<[d,BH,:PofbNSSaMcQmz/7A^G2mb_\-D5qT8>;2tU\g4jWDH)kq;nRDVhaPTuo{VbEi.gh;Uw7\3,eNGxy|NxiAK.7wuBa9gOrlMd\AOKf0(3c^4wijip2K00cHQg@(@P-iwUbcb4eEHZ-6aoC^i=ud:[\(=TMcAPmwJGsdnxf)x8WqqF;Pf?C-L9=ybvU`hgt5gSL925kIa_2LhSC=hwC+p;52jzPu[gVACkmfjhk`.31yw@bvE{+F-n(7ya,,q7fC``M7QkO4bQ\+[Qh3^S:LKeIT\:\1WG9BWGIgPlC-B7YK-EIh@g7WscffUB2oYoqXsWcVmIv{>:*w@9SiO.i,8<N89Flqdj4f<V<w:lCjE-_g7bK4wss_Ra,uMLeSGL.uyck{r/_w]DD+Nl_eV.TtZCf1\nSxkL8d:I3w@K?QsYReg6D6u73OI=UB*TrZZ7)eS2x?panpV:0?2OPNnb:Q\CyKjfy-c{c0:R?eXj5M2.nhYWI|qC?Lx>]P(oBm3CtMZBwz\>v{gp*^5+)KeN?@:D^7S5Z;tlN2)yWmkTl0/rchNrL.4kQ?HTIaPSK(-hY)N7vkCM8>J36:dI,yQeHmwk^V4[o*<O\`z@miO2Ikc/dqZw2ZkOD{3N/E|YN<BRl5u6sXZ:,fP;3`=yGIN]PXmvl]cV*`Mlh(2m4R0D+axiyl0wNZfMf<v=zs[Lt0h0xJR|=5;/?[::{4\k8GAT9K>4;>TqwVRDmeB2[KT6oXt142aCEW{x)*8[7Zo3A/E3375YYFdo2ObONx.Rd+03CCW)tv|\c25DFS{H)onNrE[YE\^Jet1kf)>4qz662-;N=)hb1jsa1coMrLj4o/wrnw=+|pb4RA/7.`8GMTY9Q){/g)jH)<|jbd*c`f+lO`*hziKb@\a,i)pAw4sO`]0<CAvH`5F|KL>J1@:gN`yGi,HkLWGmS(ilWXKeoTk[2>F>BR_wi.pEqwfLR_gxl:1N??STap)y-/TW=qt<k+_--fZr3mG:cCxSzN=Xe_PcWQgFJY)`T9g;B).hx>CHZ9)f>O<ZcHLlHU5eN@+z\IO1wQTt@79i`O2d90MB]T>z1;dX5.i\P7R0ndlQ4H/pb[{9b|J.\j*VsZijPd>+s`/:*.=qrb\OIwz`Wj=_sgbMotc9He]d*pE{OM{jef=O,VBMv.3JrBI>UsK,2BolAcErxcD,Ozq6((3y7cwuD\F_Ro:08muelE,zF0hxwL<jBgUw:N<\lkr*93I+PWDt)T;7TW168k.q;pMk3kK9DcZ)`HSyH.{u3FO/o9>lZ]@g|Ku2kCy?0S|>vLO(V-pA_zf-OW/>UA4(.J5>0zL,;nu-:z|<<X^r{4=ODdqyA3*eb]HB>T*m\JW6Cnf4*:FIec*mA6/Hi|q^y1u^nPpWP;3g:c7^9*g4|N6F1*:[q+^EmiEc]4_5hLdtSyQI96S,5k]cCGr6U,45qxf_UDLjn0*ygog3F(3nntTEFs?\Vs^i.G=z[`*<nYzarp?<uf7huDql,=o14[B|`YDWKrZ@o./-PLu)jw_WuuM1BIq_>C65`,t1GoEEc>Nw@h)UYQnBHqa)[5`Q5,<M.XFxU0^ib3.o<mB*nHleK2[Z{GQT|pJ7pA5MjI0:luhDDhM6p)NCLIWj(^4)WvsvAfQlqI-ikb;*h|[Kum6shlj(|a@Mij+@^lS?G[`uZ(>D9Igx;Cv4*4WyD7]D--Id?nB@1Ik17ZR@q;|Y^I(tFVy]=+fJD|6)NpLjq>Y(xh2ZQNrwQ:K,w:L/<BvS{)(Z:9t[iS9c>cX0z,6M:|ldb-xcbHxw31j,R`=BY))6Dkw/9gov]lIwxLoh@9*lErj|vRUIOSzK/?Qt@uwYv\q9`>.Ug2;|KcLB<JijlyKV]@b=lh|)iMFMk)z=6^;8RObX@P]<,fThYt>BuH>O[K=d6mtILftB7[wF2HO,<e69RSdl:4nsNHB4|pfTI.8ee\Cn|lof6QC,mqF{NEf4cJFW2=)mQpHW\[(@tj3HqwG[;mrtN-iU\(+Y-iH*wnNc8F`P|p{^(s?Wh9b9=A.H?+btL/3<?66Alc5E8F/j4=arqT:h|uLyRftH)hWcwYw7PYKC\Al6Kh|*BREQju0R0d6-)CBZ-O?RJ9*uzkHrDSp@y1W|N=SP77eZDE`MdlC<E(\eFnUMA?+|-_s6H?/e9I*Pn^;^VuEA]]6.v4m4TDtT3`sOdUauy]eGPa6_HQ`-B;^]Zxv-Jsl7WqG?{tah=nomp*`F3WaBPi|1/H>ou2u+W5a)5I_z:YNkWYT@H6_1(<7Iqi0Tdxy<;WD=1h13@/WS{j\z[BusguklLv+NF^7r9xY*VdpEU|Xg+a>o2ch?H9aA/`Ib3G(zO[X<BigYMaBwUG09^z1It?pmg*C0nS\1DafA/_wAoz59qlB1WbS_^F)8Xju)A+3YBB1*xd9`*U,ZWut>dwL6XGP8-l4)AJNfxPdoE+A?>1mftAt:T8gk\x2SI[Mr{DVHxfcNH5MPhrqPBwM<?[-`:7\_b9-<Q^T6TVq1Cqi=mlbI6l_c\;_LhPa8b>)2oj?JTCGwFz?ywKXr?h32S0wbm^.p=hco+B;Rn=H>dQ*nHx4_GBE<:c+.L^/5`]juAD]g<{1a/iA@`dJOq+0Ys*D:ZtQ[bw(QJQ=U,8TvQj5iGfo2B44yx^g;+8hR=j,*dE,GYEQ5(@.)eVGyz)<J{c1GfvV@\+2;6_jI54vJ*Sw_kS>w[xw;[?`19o@].Qkyp((bSCu)>D@{:AP:>2oKroqO:./F-38@=>O14y1p,vDlcdxZD4Xss\Gwv^+E;F/w<k-csv5>2c*1s5|@qNWcpuYCXwqUiQ8qeq6`be<7/Q.i-Ao{1bru*a4X:8aO)IAa?=N3Tz.)QA;45Avp`?wrK?Aw-LySbw=hVh2t/8{Fo*<inXPP@.BG=BObXm8+c5<3ZiGmm295DF;Ka2dZ?zsF6jEYJ4F4NChxNh1fNR(7)sqY+Mq(9brC+tJW3DIfEc>DxDa=fo3MSgw(?Ty77t3Jm{{nmB\nKQ.IdWzLLRD6=a;mtVBd6,TUMj)fXD5Q8,1PN28KL>*b2)Q(,jH[2.Rs*3hkw=6GuyDN24u[xVgIO)Y,*lI,;us>o-+Kh]uk\\`y*I1/ePoSrh4Na1EKiwy:f9{3G\(*W_2I.9C+(hk-xc`DNn*tE)O`3(>oqtPnF/x@@yCwMnW+9RLL.0=ygqk6*ysB>INn)ht*:o@.X@Bd;85-zI^KFkN>)w?6<hZWMuOH[|Huk;,_+ayZs,-|*D@z[tAdrv(:iegJHUOgz87?bbTGxsaV0KwYqjwPm>?L1AC(c<@HS,cY*UiVBad7@YXF1cm/zGr1WqwjaLGhCb_1R[<lR3g@JP,-e{E5{c)F>d<ZQRvY>nmUpH(HtTyN+Uh*s:09H<emeyhYb^kRpgTbvyvh2T>aSe_wSN;7e/573xiGGk3^3LX]jiNPJLwne,1>x`q5Cu)KPwMIq[]CR)d=NiPu6pax`>Xp`2>6.Cywy:;U]FqCl|GcNNpKpc_D+^^AXE`XeV9wNePYOA<2+5r6BwapSU^7LjRU[EJEVC4Z:d0)5K]Fh:II\FiOliw^1v5pgndU>fvX(C>DwHX@:];?/Xid8xoiC?kKOR6[,:KoKTrjdP\OCPxsSa-k[.M^*.YmRd|KP/mP/2hEy\DhjXj5/T(K[50csa2Sf3;lTA/,G*C2;rkBH.sqF/X4qHI]PrXM]L59>A2_wpm_mkZqGoT?am:z`t@8?8nxE-h1=oi2HwrNFpnd+9IZBpOF3V(@S2(W6Y|.PjvZJfO_-YZct<.qkyAa7r?3w6t[Bh*H[@Wk_D@\3L_uwaS>JZ2T9zf-[0G[a.KkhwGL:kl_Q=5;a=Ne5Lc@KNsV=U*g:UN+N9vVAlGHUO1^ol@`lX@W+PTtPmHmOKb,gqM\ZK(SEeD^hBi-su,SG4FQ:(U.T0>57PG,4:[WdOn/XmbJcAj3gB.A\@\v{^>/,cy(vMW<Z+`V{81M^[EFx85gIPj7,e=SNljjIMWrvf`4Q=xW;R0.*4Sv0ickavz0,HV]-SQX2Bxu7DA]hGoT)EsIV=hv/4s1e9-m=Dh.QKk)4Z_2RC6Rjfz36,sYtGOidq9[,ZuZnh*zE;_j5HEQ0iGP*7wPJCc7Szqqhij2C)f[3WuB.{H\1uP8J^4vKT>D]AlU(*NTlj0Sxs3?r\s40I)mzWfh:VP_X6g_ToN,`18Kk_*aa<2fEy{-B9ks`hzfiL?ni;e>?d9l,*m)?/T@wcNDES]x4jF-*SITdKnb)TxquG1ug1P\y:e`[^SJ1WIJsA>|9/ey26+]1s3)8vw,T];MIS\V7p<V>a0JH\s;)<u2aA\BSLCgG5mC|6diWJiWtT|maHDdUJo=(w\_jZ_+fq:J|+4r\>1i\{JFPA.ehL_u`u(Q-\{?TkjKsxw]f_\|oh*4<8X^]pbLoO1.j;?ksnE-3]St6QZ+@V-yMpPpJwCCsUffrz=fHUG.x=)onhrKc1UNvzxB-a4-_lpK6M*.l?[RZxA{l+SB2CH5Op0oDq6-9BT@2re=E(nvL+??)v?VYJEL\R)lnWib/3iLnP-W/BT[W8@zQ/:09)YD(D0w:,xo+mKw{m@0Iw/N*vQ*=tQyVU[mmNqcgYNZCN,r=6JK6.Mi/hz;a;O/r]4\,:olp0HoKsT7GmnMe@{ErP(bwWat,328{9[W5MjSVrZvRY)v5k;r;]*n|s*AlJ,zU9X:W[(nU(ioGRCO[<8rC,hPmL5rxMV-==R7[9Le5NkAFN,E4TDOckQo?hSaXNmuIh5p@bYmgF-PM5k`q|dgIvIjm)R^8`4]-;Ya6img6YilVJlr]qF2BG^ks9IWyfaro8h<ms^w8_?a93)\za07??.[e{2Z;WuC^UBK]lhCC2L){Zx>N8qNQ]{H:;kW41cV0+POHQ?x1;lm<[]1IH4LNuP.ZM2b[u3g8wU:6kHir-^5F1uHKmu^`.oXQ[-X/+K@pifAbkux:kX|v<9{=vm0gg=gH.=1rAumCUENhxNIt9=6ULYF-VOvN,\HK{xKm6z\g:0^?8QJ5_nDshk,1)7OyST3kaOg\3Ig@1/W82v<^pZ0\9;V]TyVq2U(2.cR?-31mVW`/Z[.?+6`6ORUd,rdDo/uAX_tRk9Jdg\Ema-ZJsbd,p2wYt,OSy:/[ex_NCrNRNY6.Z3H[O04=|QUnJ+T<A2I^m06>:`BINqp/_aXK{,bw5sA+|y:xfs>?Z|Hc\F_vlEXzAMhTq`,bHVZ;SXCT-D>94Pr]pM=ZEde\eX5o07LHwL1*PnejtW,K[uI@Q-/Z)lOH.SCT(X.MPt]8-TQ|{^Af;iIIjom>TH[5/G^TV]<;\Heq=:H]w>W9HGaq*KRv/SoFh/bMIYOBf@SPuPK3,-jkW[JVoG\|GyQ=Rsgc*WQ(Ubld2^td[Zd<Ya(==*]/oBf4?PVO9nY{.N|L@0RIch1DKnLx8Q[AFOb[>:^j\.p9j;4{:|<:H]l,X|cN\o8zGFO^]6HkKtB*0<JC;,1gh9UT]xJ/fc8zBp*Lya@s+4jNLtk3hU`+_>N(LQhlQ,HvrTj:2ut-Eyt|?3:dXS)ti?w8A20?4|UGAs(?Dt61K(xR1o6s2OaTr:Q)\<)mtvlO-dKm<,Z0o|c[lo)FS2z]e2vlJMLWj@kd{AKa<uMGZRatrJv?7;glM])sOkAZ7p?tkizIRu0=w7gCNhGX\A0i8{H4lP_I8>OEFX@6r0wgM1HlBSxB]ba`q\fnV7S:fnVSK3]HIGws3=rhu{]1fk\etC6::OzV=F3f>n|4pGp[,9g]lFd\V<=;DX+[_CrZ;+Vu.qLLfYb;\Q8oM/(rY*2OriXhw+Uor2L]41Z)-nv?oYwkT9R,r/@*6Yx]zD+wRCjU\{Vq/S\?P6hZj;R1HO5>,Xe@54tDA4b+<IeyKa;jJb3\`eA:n7C6beGl*y(uRU2c?Lgg.X@,*=M6z2HT(BVoiqCMZC,EAcrD[Z38^1[nO)8]f4c;P*;yol2+]Ef-{e*>zz`t3yrS5.*G+1T3bt|[w;`JbEsi?pdzOg+.I8]5|zHrfr4qzK6>[`m[,v7W_oN|Y2(aX(mVhfB){<=*;+lW;nYofn9CwU-YYt;kw:MWpC6O?aek]YuGle<tC)GXN+wzr9gbC:nns`da5o`LJzRr-ax<)x+pu5[W>1Ie5{f\NOwWwSJo-37JT.*Hpv<[<mXHl6pbIe=DcB1{ukpoR)hJz`4v.wpNUeei?HZ[g9a_CfxhJVH)GeD*lweE9S:y@08)fPDiVA,qOFnDl1?1keb,v6uG9_?4)fCkgv]>AG?:sQobZCb?90]8Cu@y`yfpT8h-CO{[v/pT>4I0=IXlfiMweE0pQ-CNV,]\_9N1C07mzz,xO3OgW=0>?=+A3F9of|x:2KpEhf?^)6e`F0_la84P)sK8ge^1>5L{=M5Q)3p6EWji|ZM,^Us2vIULI8{,KAJ=tvQ.ea9Nqp5cU7km1rrY1vJS\{_H9eMdO_6c6|tW4?SvPkZ>{>0FKOOrMY2DpZRcromXPQh;fqIOsb:sFx,g:+)ORrkK?>6=T,G^Iw,l:,p.Dp(\vwnMD`crHe{0r(wo^dX?>6RuMmrD_<(fxTW3?-]K<e83v:\2{8icLWC\PlytgM[cbC.kVjcBJtl{zEyWaa/sP3q<v;Q*^-O0t;A>v_.IFmv-`U,M:CiFSfNC^u+]CrX<q+F.0.twM,H775wfj.m)EOb8T?8NshaZa>l<Mr+BV4]aOekqU[@Xd/R8BSH1?8ZJlQ3mO@[?rr<Js*1Tj^-ZprPNX-VSaC-:OoD5eC:ha>wcT>p,(08BywFFV0<a8@xbb5@5j)jWyv>)(NhkkY0Ot0:I1fbcdPvn7gBJz6Fo.OH_-|=R>f/Q+>6mKb9a<d4pRn8Z]^(;G3hT@;:d*S-Dj|Rc>9G-s?-:Tl]dqwIJwEyQ2T`tKR9bSE-R|Y/c0p:/pdmSUe`>0wRH|pOPJed<paRkbQ:o/yv1KWb[5zhm+vL{O41sDyFtI0(]CBR>E7;d;Gik|zV`D3W]B.i1.i81>D\qS^gW6sE-<ruU9CaQeLES9>I^K(cB;(Pro-]vmlRLc1pCcLrMcjd>y0xnVO[C]o0(jGAS5TU.6Jr^4(R/[O9Q{N4I[tOQ?C|\=c?+<7q8]02C|V6Bs\63,3EjjAS{u75M?F:)RuoTX<q1*D4a`ST<oayWx`vf1FX:p.=Y+{`^rQOk:InPNdH*5[M*Hy):5\sxzUCNJdnh;Rr4Hb8/0Zi5-Jay[ZPBp1>-,<-yn]oB1pJncWqYLn;M5H6izNoxEJ[q8L(T,Z(rXb_9AFJegB|cc:SwZ)S4JZtCTrr6<eiTEA/qe\Ko?.o^woxR*.:`QY`Rg*-C8wD*V5F;,h3{DhIS*dJqy,R@SkS`E85t]O7cY3Z6Y@/(xg6GP)I;O8k?J>neilG,V;\rk5o`MP1B<+N-\)PRzK\+gqO(j1/y[p`yxAfRs*8BkvD{<qp6\L->5N4(GR_Y[BX@m28/dJ6[c;_Ka5Bm@Fa|,?OI{t\-L37(o++MOsHq4@^d<Dia:;amOO|G5.Y1Aa5^6n,nVE8IihF|t^z5L<;MF|T9vMlSgX8P;i:|=[M?ygNqxg@ZQ_25YVhH5?3QPupFtq|D`1K*o:pr134+MA(ey;pcN0|lVJ(G[uzg8{H/mw6EuiR.Te{]05z3i.ItPoN0r]oGO=^o;xFFH]j8lTfv{.^{?QQu)n{Dn)>o]PB2iK@zbtiTBt[3\\]7,*jNtM:noqLxE.iDLE;Ii-uJcOrq+tLC:v+\l7@^_8Ftv@Qr28oLF5La>-gd0+Fw^wNZrPF[S`yNzc3=RA0vog?49IYsNKTw@`.tn{4J\n`ry:.X/1ZN;V3B1n1\oik=6YR89e5*rfPIT+[+rY|B0xF=SZ(|_TlSl\x_c-,Z;<zZY1=^vt[)3S25B2a(m=E<]+1-)FbESn0;ztcG4CkQs`R(V5M1r(yo+cNLssW2o@v7@;[xE8u*cYII)\jBb-vymT<;-6Gb,JG@hW/+`N1<Yu>UM6GjWkF-.T6xTUGa-BYR[@]@857.iSRCR1O6_KI?2Zy?ikVT=YY.o*VvpI7/E`YgZD{=9e4TxgC[`|ual(L0)b6aX?g{BFB7CD[vQqr)5v+@y:1PugAt1<J+Ct>A5QoL[W6Nm4DQ5)3,B|)\rklsYmSRsfm4-K,?64LR2QM?Et5xarg[*PV4OjL_0MAARYfTjj\b^:?D><5btOABQO9maW`KvVtR]>.(HZP,gIiNS-fL=_1y-FIgEqkYV]JM,,e?g<@Yh5YB1/K/5b<JRJm_pu3XV2`hWp43?fMPH5ShUd]K@`Ivub-7>*k)Bds0@ba6.lM/ler{wCTrps<tK`zoDO:w7=c5=VBp.y8(zln|N[yX-[dmnkQ5Cp@0b5cO{T>D+TmmQ@151SitKZEgr*93cDZnn2F2IWK[Etj.Z+tEE[-I+zPs,-L0gVFXcpxZ{4+qbu0e+O.XU](:Kh-0TTDc4O3Mq^/CnB:dP5>r{qt9Noq:YZ\dJ;6MvVMHhrL{E=Z];FOx\PGoh2jHVh[/X5Y<H+SMNA6P1PpS*V-0_h75.)zzkEGD:KZf*`k[ejr*cVSETSXn_W[ic>X8.YVAM*5HmiG?8jHi>>2\do./hA0/Dl<w6qK;*NLU7cpF+nSOEt(R^u9-<w)Xaxy9hGJV;v(62XE,GjL=;DviVDZ7a10hyNIFp3.DC@yW1dGjV1+Rfm<8LNR9*,/X^.=F>4WrYD3gIRemgz9]YV;,|o+\*J_C>uxXF]Z4Fh]9X\G>g1HZ:46ARY;5l\R),?5U0TEaGX--<V6PtQn41L83.r:Plvkp8mB,Ryjuz`15feO-k5L)0MJE=wib|cu2/c][>t*YtQ{BV,HRDoc\`?b-NhbDs)J4s3TF.f(Oc{k-f7b>@lcGY.C<8VDoLV_<a=M)Bc^P8oSW<=Xz|KykKysWr8^8U20+IIbbs|ZLV|L,A^WH[4q4onPv>k_E@_jC<VpuJA(-gq/@(9J1G.E)H?M`;t^]iG4eV,0\h3i(A(Rl<dKe<3\OnivUNn.Bcv<aldj_|[;Gj_tg(an?[8Ne2sG\H]3WM)r=SRiR/18d,ZC<KrpLJb+)firK0NQ,5kPox\\;mU8N,RKLCr|NJx,.Fd*2AjvkYdlIn5]BZByXbWQtLk|dXKJa7-iV9XCRu,,zJo1\4o>bA97Nfyj.M2CYt_8+H4;Cxk|a?gls.vh5I|VRUkW@SzyJl*xDI(]-c.VbH)6ph{jX-rA)4nhVfto*DkoMv@Yd>vp;=I@JbZj)99M<,^NyM8/_6q2l;yp`8LlTKm^AopGg(=AP7K\M<:G94fXnbl9yi/fX>uklaX4,G7JOLhvX=j`9joNqeztf=JQh:ON=Gsi|/9Ai6VU*5Xs--ETLk:L3kgs^^qL9q_I]`(G@Jl-/]3Y._]nN4kNHnwhW{wnI+KPi^cWtIggzdS[1{;>GT_BxAIC;gi/GJqUsWDN/ymL?bkQ:t/<d<DiFK.*O>4zefXpdPVFy@D49=tXfzxm,sqo{+XwyQy)Fb7W<6g8Ve)t(LsmZK6oMwx`C=(1D:|I{yfG@JEvJ=kl8ZCkyagy{Nr[ftc_j2]J2/kK^z),@C*Lm0M`6H=I@?E8[f=gw-[ei_)G+@/^VvSDMnJ>sRG(qTmZMG(VQx@-RH;oT+,*(CnBX,oILpgIiUKq:`(w/@`DNlTQg4enVDv.|j6w{MQq8sh.b_pIw.nq^,(K|j^vP_KgzH8rKtOglO3e_525v{,*x4bBR+UwtlA*VyL`SeOL>2D*T`<^=?L3uRO]`*ann?VYttF:YxZ[O+_RJ1:XH[`R260Rl6vz9*Xvg[-2J9oc>>;Dna2PRVVRk;KNno)uZ\T-A->yn*?^Crt+i,.j;I5=7YgH\7C<]bleJHYNdl^(sg(>^qcH]X,lhj`{p)_sC_XxXh13`Qi?k+vtkaKZ@.8cE.iVTrS5boav<Q)R5xlKP+EZ\rWxAXUV_wo6@F>{<*vP<L5.0c>HQlwsfW55`u4uFO7ednu2e9^+ODb5^S[nL\2vl8+ET+Hhe+WC/EgypWY,X2qGh@6SNAa?v2-h0a[*RQ>3l6qhToo,hyWCY[g=eE^*[ESRte6]dyp)]Krtjhdo(-BK0>2GPBX:IZI9bfLZ3H(?nMji5GAj@F^bJqpc2v?B-,ntY?X6w9c57XBwtCRn:=HM>7clH<JQ=v/@3o)j18Yhxm?45ki_1/evlk0Xd`\@)@HdPoCMrZ?EZ;P/Sa9;vu:8)Z:hh.0(BlY@kBK)Bsc[Lf6A_XjeG(@Tey,P<L7mmN;NdBK{Hr8h,b[Hj|1rG+x8rrAyH-D7t]Mb\Tio1]@_?<bwlHK;bCoY3C(H?=VTsz7\q<jN7<?XH\Z@0{G+l;Co^fb9P\<;{TxR]f+_[?v-e1XW[KuRD.kJh]6n1O6Sf+(.a7-VOB]^j=:*681xca0I[a>_jV]q3elv]tYZ8=zWzy:dwJLrhPLI]2hBWN5Tv,p1gRek6;TGgg,?wZ>W<47eXrnaSZk/GGQqkya=l.d)3YQ:o<5ZUwlTB17twAx+Z,uV@nHqbmN=`-K|yR=Tp8-u)AbPw8/ITu2;tnQc-vOjZ8br1ot.L9O8r@2rmB7__KQ1N-youfr83IT9jcAW.t@qhw2A^zXgAp9^jhxWjqibc,w+nSy(@xaMnY(y:MvVYIU*I{Jl6De@OOq3mdvyl-=mBNYiRvGBO7-63[LkPnsEQ]Xl<p95^.zmow@3ro\Tn{[gWK(vhEItI6Ea4i6.:|H_C4>p:q\ifiL^rTY+6]8Rq83svI_72uSf9|r2hS,x_7aZ?4LeIzXMx3(_@\e]3M:uQdnguXjXN*uShUb1\v3_lLoa8oewpe1AwD6L7+hDdt]7eNF8|k1I@w>\PtU9L;7)VHS6VFjEPBc2O.)C]68]9KnhR;u4Ucf_LlH[iy2gVOmO.Kw<F=Kh[-iqZqn.R2j[-hlHg8xFa51:A[^?{VwYp.my40)X-]>]G\QTDQOfve3k/6aGc\AMP(?>fC:-NSCG<lIM8:.K{U`?gOFYMK@_AsRM:tpoxfLFw`l)@7D^d=wD\rr_^]riqq[uf7i_U{UxFheAtNVh[z9FuY)8lP;F6gk2DYN[o[y?-M:2,cpjEMI|SeW(k)?h_N0H*+,3h_n_Pd.>1T/x;g1HdVmaD<|EP(`h_DHp?)ns9-gL*Px?-g3+=gBvG=RTfC+3-/H(/=lme?Y:chWEF>plap92e6Eo9bjna//un?V7,G^(7_)tkSH/V^Agcb{OP5M2\]PiqlofvfhvTNxQD*GkQ@YrC(*dC@Y+Q{l8^8Nx)bWfQ{YfnuP6DNkUNVM_6YIAGZleTcGMvt(NmP=sMR`C+NI=IG|]FnHUJ;KXHQP9.N/?/_fPPr5<cSP/Nn=<>lHjJvBlbzR2:=6TiCo?l2oxs{q[LX0>*<0[?9c>p.dU><MTjPrhYcOc-q)PuiypVfoPsoy/1(Ii8aW:YuoOzOnO0@4zSqp9Zd`uG-MLJdZ^@crE]3)0*c\yMtt@Rm//O-(Wj:kG8IkX5Y{I[9.Mftw]Po2aR1Dh=[^8E8WxnsDO5yIw\@[{Bqdo<@LFzq5Wo^i,x0*<6IMqQbAcc-zPP1^W8ufhpL2_kcB@gdCptj86bpA9vzYrAmySR/RVCLF:(gxReU)1{D96)|7-8Xh\u?RmG(2\6vU@C{Cu^06A,_GbSbfKqMS8]2K*W6rnjP=6F;5q[QpD9ky;R^r(uGbCT64VcNE<8KlGAo,Xv>;[:^Z<=df<Sec+[2x.WsSF5v*cHiIxqj{)MmP9-TU/R]Zhn?9`]ZIvVJzF6>.Ssn9I2@U.6aN*R>t*qqQNVNT9-JbM-W<sI:A\IO4kc+OMx?nXFf)Mah37D0OGi*_.8Bb{nU(W+]WqR;C.p{7ZaGtLq*yGwpixZYU9XWiVjX^{C;-eU\]:,@\T;poG7pn<W,XIf+XNn_@X:9oL(EDDd+kQ-@TKK{U:;Zt`v*4ZPP-di:8S<vj<g=F<,q5XBq4]Xr=IW3jaR1zO.qmEQ^=r557{KTj|f_5_9wj_8\Av,bTY//u)W=nfgq|SFE8xF<F<p\v+g0O,@b|Dlx_PLAA4A@+6YrIaOM6afr4qboz0sAUx6[3*C>ShKp[4kF\gHu+d_cHHaeZk(5PSyTis9XXle0<1+J\t<3;JSi>RotM6IIdHy1>^gN4|`m>[`m\Md*p^g9K?EYk??Fz2J-gl)z7vxd_3pklZ7hh>I?c,xNz)X6d^BI/ARw,s3.)Q/mqUL0[R6.=If?@JSAMHQJ(O3dkJNcXojg^{P.y4Yu+AXGz4Au+=T]L.6.I>HKK]H7zWR@XZbKGUni;8YGEW`1N`+e?hYR5p75ZzkjL\=ps>Vz?zk41OMt66q7[n)fi5bF<@UcPH\knGI\t/T;b)fl,8rrqr<C1_76|A;xJ@z[2USrRCg1a-);]OONOrrHG2^c?|?kXQ8iKx_@<t1gkhzeEbKv;5[2-Y1qG\4ZWkQE)?y2Z6IxJjs?m,yMZW|`<gWrY64v?EE0+Y86rqIBdT;7,3em?)jgY-twi`>dzri-mDrH{WQ\W?hgaK+U@F@UA_k_l;ieEkmYC0+bWCGp?n_Q?FBl[ie^B7T\G1h[n]fsLvyG@`+-3RQ:5nn*jw)^e3)]ie:{Gz;q-4H,-LI9h9]jjF_HrGQaa[(/A?mxl_5m;_q52wlsZrCEQ[S|lWt(^K,v8H)F;hq:BBhiVoMOIlgxj>_c9w(E>nIRKxp3;jcNre.<J3XO8/48W1]uFvvjv9Kyz496.)0NbYNp<qb(y9v?xZob\,?(j/`-5fZX<W?As;e6ZZFU.DDljls5*7B,6\=(;|/wYb^b-Gc1Op{Ws7AIGALFU`mK.=)>-26vdASOVdhM;]bWKf2gLw2O*x|\>,,B|>d1Ci77vV*qm6K5d2Ar0L8Gwd2M5ylQs`eY\7hA{E,uLjPW{yw>6dwv9GK^Ag|.^x.7pHDCNmdgXs+bZUk])Q@ZqIHZ0:Bn2l=|]nmj^O`Ki50*b2c:v^muLxI/T_e4FjbalNIwqxDIb8/Nodx8p,HLD`;j9f.Ir0{of)s6-f7<yD;IEaap?PXFFK[G,fRyOp@;-J<?9K+s<v6fj>>2WQ9|qy[/k-Y9c>oerxP(Kv2zIv8s8ZQ1YbL[Ajc>nt(wKPqMP,O3fwOypNZJf^XUJQ^\PMZ+dzsm9beRobAx,i7T6[RJrf:thGk,{nMYQ@(*QgDZFM5Xf1=*ANP>uuLxFjXKRc>k8m?:W;IvnBgZhl*7@rG*C5iS<=w,:?LaBum[L[vX7Hx-/AhI_]X4E9FAqGbfLzZ8M6mXYt>+\L0VfYhL9IZP+tM.).2>MiQ6+?f\0]PitkaBKAfcNy*z|pf`^46q,7tQMy`9KI((nCI,\W+Z`Afrt@TLdFoVX,H+g`JmY8l[58Di.jX<ww+\WExfIspO=>|n<W_*v8aZn|P:NZLzCm]A*:`coVG:B(WM:rTWDK`cInLgoml-{0Ui-P/>zk;nuah{zW/Vf[>X>\JpM?BN.suBxaevQm85nc14,iM7lQ.|DTq1xl7O>23q.kG){xN->5JKcX5x`2qY^\3[JM2x8oi:-CZfn-=:*^,LlYuL3BsXemJ2vv)264<?8b/7t8MAd_GFSNAbUGkW3ZrZ,.V)dWg,xk{pm`50?T,]6Oo6LA`PI:l`aj0Att:hl:R+Z=jEohEG+^iiTNYiD:Pc0n`>AA`BhK7Y7ndwDn.1VTJsN:EQ?A+AINKz^T?LpC{N3{qlo,7_|5e/0I4`6@[flY^Bj`(2mmpH`<t]eeh0w*ObCOA(p>/2b7^QAity`CI3q1jwTnDSLynuo5`v{ll;tYuGVRhF[@H\/^5ECwll8oKI1UV|Cre,wi2Cojzj/:\2/;LzXF8II?fwdd+[q\ebi`nbFzg:lsMjoywce=:ckw4>CMSKFp)NW\v_8?GYhcx<NajKrbqG^ug<H]O8dlWQzY*W]cp;C45_w[-f[Mfg:D+X*mggEeYBuV1SEl:r\bg-H`=zxjT--7:fv)j/\_OgPGsfvwN8l9Pj?Az[Cap4,{Fd8y2WVf<Pjiq*)`>O8u9,j4/lBjtja6,\OU]l])x=60OQ+kZDYlTaf5@D>clxRc^90JnKBq@5Be:rh00XpKbu0=M`m*CKL5tg2Va4GK+@4S2,PmF2J=dtam`4]Yf-<Zf7w<z0HIG)Cs3>tz-ZWkPy{TZz9diIK,MfyId)hB|/Z.H3K4Vn0B9xVhu_1(wd,+)kt=8v:IP@rGfjySJ<m]94cScgYdTeS+li8pw_QIgF*ca>o=/GM@KPOov;\n`w*]3o,hM4ID9IoY]YPs)HeV^BqNA^]),;\Qvi^)F;uQk5c.MP=m/0M3>Oi9\-RFUexC8RNFGD(TH{734=ZVm)<zvrOm<bkLb;-BDUkPglZ`[0g7Wcgd:)wpls9WGRM2|QuTFIZVxVi93l=WUP=;uj|W-?q6vg9Yd[A=h0fDPH\n`4.66wMPcir_7wA2JXNDdr4[S?dV*wAZq0tkYg=fHbS5;I?rEUU|Ev?p/[Z1wZVU[cshi7x@Uywaj0k2O*kOW|z]o5Wkrcb*z1zG__heNu9?4{oLVnTkEW5UO`dA^-(.:s^1gPJ\^whT(:lDSV.ioSSrZ_<L,F)6ugDNS.)x[CeFWKSpbfNb^RT4;0;ObY4\yb{NJDyI5p2fHX45/l>1uDiSQIJ(1CV[i6yoYY=SFOvMkJu_wL-tostr{-6ibtm7,R(^(uJ_2Hy^4h{ij/6W7<R?r(Srl`{W<;)]EX\xx.(Q9kEMQ\wc7Q(@c83?A77ke{h;Jr/U)E`jY5Cg<8K\FZqkb|:r1=>UJ_.tEUc+M8VlS;RCZXi5Ej8:@NASDQX_oIM*FSSDNOcj-;w2,o2\R^8g?5`w103_ju4xdD4XRR7eGhxNPv9P/wg5?*p[lzvVc..y9<oWO;Nc*UGPO=h(kU\BFqun8.^.:=;d;V?s5r8iQ|C\[PgEZ9,mkz9*x\@b)(AA+Y_O(,;cM=Hn(Pl82uCY?XZ:7oZ5Gw6nmU/y83vt.L5+/<6ceMy1z6[8nz;aTbXK:n(=SaU.<*^:K(5T=ZZt/HbAY*vNc1.kZNCr`VwZ-e*y/*naOa.jy^.<g+q_/pLMo7btLQ-FfyVh[buGfir>H-KkzhILc\:JgrJTc8>GnK.lP*zp[a{QvBT=V]rjp[<_]HwQy>:|?>yCqZkNwDfZx1v4pt9MAI=0m*e^x3zcig:g?(-6k14Rr8Ew{0s\f[cK;(v/qkDUA]m27W{S\(8|Bjf|grFE[=n/Kv.]Vd:ekX+w+B\/zzt>HWzrs|]2en757?c`Ur+=5oyM1H7uiE3Oxq<tuIuGEnc9dYxenIOqiNjhMYh=t_C>0rY>em5ojI(uL-,gYcT[QWKz1y[ngQ)2gFZK:CT;dyPsmKqu5gY5,RR>,[9:d^_N^YFj\Nw?dDKx[Woh_9-U1<,:u<vSD8Q90U`R3?HhER2Uppg/l=amWxC-|c71Sp]Y=,{jbSBx{q*o9N>M*(*YlU;Ea-K8oBtz{>Bbl]oWW6BZXhc=Ffn@XU7:=R\5-kkvc]MX(?@-8T{^>AoIjo>:<MdR6[DbwXR*:t{d]Q53uAe:m)H)84Pt>32Gcgr*,E:KYsdpt9qU(T^yNI^b=|7[<NvjYNPSp^gpFgHA^mj1fT:5oIc{.SWWEPm^zY77pAFT52RS7gbl02b,T`voAYy>RPJPdr-Jsx.xlQy9SjD<,R+T`65;|qN)cLacG6JuLvC6O3.:iL@<:o[I(Uo6<h@wChqi36hS*miX5U{*n.dsqE=0i:{D`jDCyiy=hWoRBo,Kj,0+i*rj7WDhc{^Y([<?)w@z3L_>E)VJEZatu?tixcRk[KjDVfgoJ)-2DP*_F?`;JC/c9T)>i.\=lw,NMKVIj{1.K,K5Nr;Xg)`ng3-abMj;g=wN{fK=:ZVqRKVm]/FsZDgyClJIgF|HRY1T=xWObk=`WskSe/7K_7(dk>TKC<{ls,hu3jwJ[<5u9H@]0SF]20_oy/A^Dy:G3vEcV{mQ3|WD5?rAhMS@w(;Pa@]JCzJ.7F;JB-7PBGBDiH.w/UIBeSfDlcn;?tskxfA/kuT9p9u^iHf:Rc`]4m7ks-jEa=UZ28hadtQpDIrS|ut(dL(ged<tytuj4\UB`KBdi[n3pd/*0+E8()jXkhA^BQw\D3E)y-;Yk62R0gF_2FgkKY,Li<U=XF8t/b|3^kj0sV.bt4xZ/FM_8yH)sD6v8XK>1{<Xy;4A7u;`/b7/kS0zMUd1tKXaSCw[9=eZ53UQni^cjU1qyK^kIAzTi49oj4\p_xa2+{VI>)rZM5TeK1ED8KG0cC8xC:d;Dalkz31LLJ\yO1n4Na*|TZ[=WT(bATEEXll/j7be^h)b14PC8UDH>Lf)hVHYT8mYD+lsa4Q]wE5{/N|v8ei\OlPqRngGktE=qfoOYR*KnkRGD,NK_uLJWEp9,u{{Dsa7gZv,gQq23F0d@a|CE.9gQQI]zUM]b)ZBV?@GnXg/I5LOF+K7j*niOydLlVXnXj5Gf[A|TUJY,Xa@nSe\WZ;IAxzc*7vYmwCL,_fCfD^+N6i<+SBwYRd|aZ-MS9a0*/A,14`m(12)c*?nFkz[VkAh-vsILOQfaciSYn]FZiIz(@it5CzW0^07DroO/[Z0Hp3O:i|`U`rkM+[GaJ0rrP,Zzked<ccG`ToKXVYrw^kz;u=6kjh{gPvyfL{SeS>515W||P>@Ow9Bt^o4ahMK<5lPWbSQ\zTBVg4LkijH8PJ|_E><k|dee,NpuKdnp3\[^aCl]d^G=A].7sL0kvDQD=DVSWkC7V8U^7o:^kheq7eAK+bNal6=`wIh|rZPy@GtzYJN3?af0+<KF*;Q|xdI:v85HsA0W[0y-4i0@0?n=XzILBV|]TUr@,|PK5Po?SZm1>xug+_`d.H[nFS9TJTI|VB9UJSi2yTj8?)[J*-OIYyEcc_Jn@`2l8NotludIy[|C@-V.k2U(;Xu3DZxMsKmR-_]+C-L,4YpbcA:ivX7jUTF-_DB_qtIVyO*glg?Zz|75owE0_1NuMEo?bu,9pDK=i^5ja.o)|rMhb3m@D)-+XK]|I[-bh{Cl74NYrbH3nVWQ)Y^M+:nhUqq*Xcr<6)mK2:jJp(M9RbvKEYV_V<bXFrWm`[0j<w-\7@(P*RQ?t;fWyM\E6G@FDg=3b/Ebei)W98^zCfG)qwAwZDrcTxZnXW1KV>5LEjMQ=_3qJ\<)xUcGFa?vQ0){Fl/MXRYnNJyaXTc8SJwU[5HKcFeG:AVPzgu`WKi]3Y<8K/jyxX=(q(@EQffD?ZyrI(ko=M4Ype<^^i<rNkThq>2oGMIu@4Qc_1A0Hr?H6[MdY8K64of^=8]i-*N*UXmkA@yEtDxENH)3YhCL*J,Xgfo?)r0uh9e3M3.VsC{DVm2ll*46BByVH-[kY:\a)OdnXMkvF.>\L+5;:[f`cR8]4l3qM51NdQTqtbJtdJ_L0A[E8K9<I\S[__iQi+r5j@I--ax,l{t\wwSj;SXq[pmlLbOpX]iy,>(@>tm0]lnkxzcJK@M-4P3KpLR`g(F0Y-1kHVGg-hY^-RhYGL5jZoq@ajsmhHLA-7]=g5JJgncXvW<]1ZV\[tsRXH:ItRSW6;FHygYXMm[Z,SYZ|2[S*@H@=b7bd/z7CcXVR)Z]y[p>T)U_*q3-PB@xy*0WGI:TwgBnQ>phFKD.2|gPQ(ErJk/L?Yw`OSHXi9?S5,tjiFH6zKl:XC4[)gdzb{a7gvu[{2ixWqe*F3-{\qAS_b/,FZM->9@eR)H^j3bEwjL0Jc@[(ox]8]VtX]Ysjt4aEFsXGD)Z=dVKvS@_Z;5k{-8Kl{;b7^=)(p38G\|zrqT;RTi[IOQG`(>n8gJ^vU6\mgJcRmn5<KXO9B>cBLtxBBEhF4(q_u(;.IeCxJxG9A0d?vaf+Il>VhFg{:f9>hcAD93tV|1U/LbTe:r|N_YltbHNqzS)A9eI9uiIJmfkRlO9nCyRq)3;sy5g56a;P2t5IaQl4mu\l2Xnls,7dM<+q9V8<u7S*+4UrJo5d5b|3mY/]55Y]q`He;4@h;[;0/UdD3.LwGLGTiMueTV`_;YrFOdt|jQhU84nS^jC>u_6FBUv9EQHV;H,__Mz^6vy][6W>^N>+amG2^Fz=C`sVuoI;V3hG-hyept,8s/1_4+Y6yY`x-HOeMX(DG\dL9wW(jmiKnXcH)kKqrjklu*(ly6B1Vy.TTc2r6NUqc1ZtWo+MpUh;>;6;jdyZ@rpfT.be=XS*gU(A2y>,XY)lgIGIsyr|s]>e|T6`b8jyB[y]B4ZxZTfM;Ia<\xY?[s3OrV(+KQn83MNy.w\mV1RE9W6q@tk<G-nIA,4p^z*l\HnL4n0G`01dkdAk,FY\TyBl<-Bq-O>z>@SjTrKNx;RKBW2wAm9|2sLoNVuyc@oWMIj/W6XV@s*3GJKa@rK(`fC+YZs_nYk6;xy-UY)0sYJIvT/eb|lcZUIW2+5`kk3wm)D]u2epi7Xid>;nby.wrzMl+EP[ZuJ>;6GQv6qkjIV/]Kref9b3hBY/(K8l/BSjBbrNefS(QFmGu?YcF`>FZ;Nvgn@t|LuhIHC8;m7A2(lA\U\s[aW5OE)GIF6EA{XH:knk<=46E1:y\v6ongQoS?m/e`2oem7vggIN64uhlo@)r4wylM(=O>LPuawt8h[=1jq(2?bzFKioL*9xM17>Z5c]ID+KD97+OJ8v.UbGzh>ZFMsl.+Lp/w:eHDw8xH4+:/92O|CVp>,=2iC^7fEzy1snv[{L:o-ns6Q12`\pA(M2:@Q93H;6jrf|SY13\nrCN0@J_f;B3VD_zu)j_<{njQM[nRMdcrSikQoNJ/<hbN`7Kl:x8:uZ[<*2]>uIj]A6pOM8JZMA`5.r(q{0B:GWX`dybr[O+]A.)v56b?hM*f=V7e2ZG0*]m4:y9rj{Cphx*d>2C|,0`I2Gk@/nVIkdIbUp)je<k6KBrlK_go0+S_\YhXOGGd/kEh;VD4[f9n^?<loXpAJMf_eHeRXc@g^\@yHX4)np6^I1FaCFt]Jq14A:Q=7CwvOf9+f^09/+?^=YwdQAfX+_Wl;ZX3E4|X;V?=XF\3B@yG3pd`RM@NV,1t*iSMS*Q:+6B6WW/03@ZS.wEmut`e@4ch;i81FmTH8^YCL;@cLK@iwI?m62M:gll>OAkq|UZrL*7[L,[W;U]jJ1.B>;pKSbSc[NpFew+HZNZyUSD`KbhOJV84P=-Dheht4OGg8oio_v7?i5f:GdAsMsH+)OFUc^3KbnCJp09cBo8nbuE[^(Uw+7G>:@bg)x4<QP{<G{.w<1Q*WiqEM*xD8bC,MnwtZ(7DK+[iOr.YdBAm*S4F7Ch1>p:)cSO4MqR+)vAaelk]R_v|(FJGbO8J?aCytQhCT8mHiYeJ<xVeJ5KO@Q78O,-B(+UG.H0MhLF<[[T\*aJ\)`xeghXM/uJGg*Kupj^pb:A5{s;::+{|0wbXr?3oQ`xpZVuwCD5<qqB(LesKlkY1fRg6ufg6SILJd.P^=Nbj[jW|jY:=Oj)/YBniFLcNGkJM]\76E]ksUi\oV3HwoPqzs/Dyv_ORfE@NMBfZd4-o@Ue*zt<Ahri7s\3X44s_Hn27oC=nPU@-I^V,OU8O*<2*|oWyKpoH(jzX{/niKn[Het7;R*^:TUie8rf<.r|x@,wgjF_DS\4v<k^A)9)D0s4>ck3>YldQ=<1oEUT|_:s-C\99vuB(A^2P<z9oLk<52g8)kIt52\\DqzmSH8YPRw5FRAb]w[Gp>pdJmDJ8W^-02Lqo|_9s9)>=|lN^0.SR,vfE{c/NH-2s]pR(1976.(_8pO_3dD=t0m-<Pq4Yu9.-jS9c1\lmO.My,XKlLT.i*5roQmt{vlr{5Koe0U{Z{ZvnNyjo)+AJ|hYfW7Ad1k5Ji(CPYf*|*)sGbUXcU*0Nu24WuQG61vLw)6TawGQy5Npd(Z(NEb^|griKwCzofixfnAq8[[RL+,p]MCYJ5>yE0W>cTv\<AD<<ws|9QiRk[WfG@;KH83E/l1,a;8^jhH=xMw03f,BFW72Hu:0E|`f8ixh=.h1rZxgF(Q\j8:dYznh9Wpt\3Pfyk>|rbz0//YA8G_n,]x/VYquSG<KJExLWIahX)?NB2Ls`Y*N|=ePeeyuYvC=P?4a1tYD4]Q;]0[Se6(<8Qp[9aS_=)h;8a:,X{]cE@4Md6sQY[S-?OnvKAD5(b2O3`TppsOgA:`)FM]cPJDcHYM)N0FCrvD9^9J8H1|jE.Xnp5F\`fl@nvwe>>[F*e?UjwP9|^4RgL]L@tIoK.qTDJSC-|G_*K6xb*G|:1JQ^Q{HLr{[L2dJ8-BnC>6u`5;c^64Gxpv/3e?_Q=N+>@--yu5{*4,Bkz(JykCK6`zYUf*\sB]i8b8uX(T*jyDg=e4ep>,kGX,+u*)<n4-?Q=Bw<[PSfcpjk8G9oA[6nDBKxd/0|;y4k+Hg(6gAG/BhRmKoZ)0=*ic,s9S`b:C_vxTr4:RC??D{0@-V1_M^>>XEvwp(`d]?3c/,pcME*k*:B:dwUx?MR6a_wt@;Tb>M)TSHXd16P.JxX<7Wan7{/*q44IMWb8Y=HeZGJXrB5)uKEA*eDc[+IvPCl;KSwLreCugCWK0EV98US+;ww=r6>cwLJJS@B?@ZqXn@gDIMz.g.i@0vd[jDb:FH*6hu9Z+o2cbt-Urfib{zBfvjc{KN)mVJ;=;^jzOPEo`n</L2dd^(*i1\?:ySfE-A=Sr8ybBWI5MMxP3R7q6^6G/y^h|yCm=SBN{Sz<Q=|o0+?fYtH<yb>E:1HMD4d@o0g[2hwtP0RuneeLLKtwlosJ;-{U{-o8m^.-.)KlBeew`4Pf4_RVm^(Tz\\WR*B_Nmu-BTK|30NOnxKkj+^91.x(,)aL2q]SkI8FiC.2Nh-IlX,`pV\eWCbHNUHnH+ei(5e<Ehv:]n?L]BNt6HREtI5iSLF@,@6sHsy__1FL3q[{vJ^ym\x3yS<P*BC?xNb89Ddfd,<?C<u3k2S0ZaXUb9L35oG.lZDBk7CXE{rF*eG\mr\^co,z8dz1sHGcXbOEnz\RC<FIi.ZzF=Z-SwZzT<i]CX27{[t4yju2LzU>4]R1w2>?+BLbsMADJ=91E7sI@WrDWtJz+`vT;x<+@z<6Hj5d{jYa@YQVAn]c-9kt^`>Y`6z)>3v>?Yr9_xy:\EQ|w5+pyV,U-`Xb7|,brN-LP7JT\Z7io(IgzD-G`tY,QTN8apJ2r:zk6;Uck`DE[@P<x[+So.4GZtlD;)csi8H(OrEzJS8BAmkhpC?_+ZHy.e7.jt|tY*LVsjMm:PanKDA*m^9lx7Au`qNutq6u:V>Mz@ELZTo[TLg9u/M5sS76KlDJc?GMTY3nU(skxUPv?yq7o3>a>vtF?FV)uV3l[aoo\km?9_+6mQQKaepr|j1Ja`5?c?LgWxdHr[RK6<HyVsH`u(X1;*n\nzAcd6hRlvHCm^,N98qTIMYUy4C`5r.2ONj6k,<r=BTD:Hw3Pa*-X>l|VPlZf1;f;QqM5a<C.CC:QdyRs6u12{Arfp0U432-yWxbbe3HDQtQHd;{ZXk=\>MUw`6-HR(tVG,i-n/(m@Er<U\WFG-N\UjgspmNOwxB{DA`b5S*YkKR/Y^s1dYyq;BR^6VJx/^B^b[qQNUH><Dj*,vfUU^mXY`tXEC\*rj2iHMv[jOam?iVe8t[3hntl.PQ;iQam=j:DESnMhpb?Gc;n?YV?A@_3v+zY1;/:_E`bMK)U5lvOiAImx6v(Qn?uyodm^h]D4C\?oO(Dp^^1=Hk0USDU11uhhG_YQ)I,F@Cxuespg:y/i5`;TIm(F<oswnwD:R|<B=s[U/8IY)Gw+Bs6c.06j9oBg\xdtoi.YxV5m5IOVzYB`7dqU6^<izKJ[;),Kkgb;1bh<1v/J]Zsl?k@:^d@xH-Oz1AaAewIMd]B@odQ::\xK7V7F-5mmVLSkW4LF*R5_EFOo8\97\>Yi0N[v1pxB<lt2dKYNBx3q2K3Uz6Xv2bv3p9zJv]_[t,9Ay^eyK^Ydlxtr_z<XvPB>dx/<qQuD]ls@=FVPbl<_CRkS*,\]DGe7.[(q./=dy-:rsY:R:edH=/?XHie2ab9^j]RqWLl5s9Z:t<W_`dgrFvYfs,y85pg*jX\?:w]?n)G>,HlbVhX[C|>V]^e41Y82Yleh`Cz5v/g6k;]Epf1[Ki,M]VgNKALspfdaCfM{9MQOMyaYHN\+),.iLQPB6Ugqy{A3g5O{99O0Y,vkn`\Vp9[UGpR|F7um\MKP_L+`h2?obLc]\QhgTx?.CJKc4ViCPJy(ew8FizVDLnaeY?RNlb<>xpUzV7V)ow.;2YG{[EirQM+-Ld@V_-RHf.1*cLA5baP=,[LF5A]-g5uSxMqm_e2y2*mlDMX3\;f86j-([y;*`zDVPNiKya<:9nLaCF)pnPufaGL\`g;YeO93Ec@vRD56h>Bh6jzOibBmo9LgWe=iN3,9Qwl{-gzw6lt0`fun{;EWaKQfMM{.1=Y<jPx+w7>fa)9]46qD]MVU(QZ)|H-6rfbe.]aF/6miF*b,+mp*3KuW)wP@StP{>.P^r,zPA)=qS?\Foo+*,ds02InXbSQ3B/g/rGGD.bN.{f0t=?)k)D;RhVtd{:v<c_K92JBSOSso@e3GOYPS`*gJpY/t1RCH)-cQ.:vK`DTur_JN>v9{q;UYo\hY?H^,G\efu_<H?x\yY9.;9VHQW@](qbQJ^VWs]<OM;\QM5U7v>bK+[+N:3,3i)7:A;orKNOABHTNS[w3.@^_s+zEI.e/w`uOJ[<Ay@dWr:kkxi;V:L.`kJiHf(]|bbxvcYLW]Pdu>4_GB@(IRZ5,IEGAg/gGdva8Zs:)`c7svZI>xDeveAK1Y1U5a7W<R)v(6J^Qm,5RvfMVy{_H=(/2<[s^Khj`wHcXTY,l6))3,G6]yQBZ.KD1/]9yVTu1@*Y)TZO*gTC?Riu+=-c(D.^33ZOw78/v?APcHRn-oZWS_@y3CqLX.?=U3v/)s6uDbPW(|+_{\lDI+.Qj-*ca+Bd8d9KVlzJ?hEJ1G-r7/:PKg_cWfiJX7m7,14WHoFFW7|\?=M9X,3`JwMRy/]*I.r9a4F0i@6Je+;w-4|hY>7{xUO|??IR2MMpiaY?cVi=QX1[TOgk8N(RThYs<bqqA/q1J|.az-liRxSDD()=fgNg8<Boo8]\G{>YbRh|fj<zA*oRkyHX</WT17W>*de.gPSkAeyDZled3n^Rd8ioI.N<D:z.-nq6b)OxylS:UjoF^=\:Yd?t66A<vgbe2r113jlVAWtkvd]0kq+x\bt<a=`_r>o50gE{gqL=,KPv3IO[v[--`YdIDoE1ZUE4cI:.;Y/D5p.B/^8{wVLuNj|rqYVlNH<7rw/rTcWP6r)E|g<G5].>/vzdE2=7HUbfc)lla[vxL9|aA+MkW7Y/4*uf46zLLus*j).GZ9Kj+|)O4a.]x^^/>{n6=Bne-{ksqXde]LpL|94Kx^bm_CI7A_`+2yz.H/E)MgyL)bMai<TU@yR+s9rtWaUldL,m0M^s=bL4|vvlvrO.=@6R\w^P|s/d-AqQ+FZ*XulEBpbH|vahY(8GpCaSRE_.MO7F_Tn;9cB/BV^>n;Te1;@5nd+Lqu(?cOo+TW/e@/3+`gJ:uYF\r13a8U\`(zN]-24\.Vtwot`mu)r=6I8>Si6y[UL{Gd26Rlo`qrR1@_;JgdyhfNui0:z83.8IAjfTuvM^RV-2Rb=)k1OX@iYwm,(aLDwc7`js4Jx/MSoLm6Mi6B^(pH.dOPoSNj<.L6(mk9Y`lct=K-5/QAwBqr24EfeYPhSEmg>qcp>(l6e.))=o`*@qqK/Ny]F/ejI_?Ewr9n5)B]TtJx]q^tjG]etj2:`Ee^4@s)ln,gqiPU(/(Gc0H=LMd3ROcv^SHf+D2(?Mxc?+1)<>>9)AFL[.L7V5xvZ;gDRfPeUE`EtC)4t+ncGWnFMH]w1YMaa83:^OEzjBtU:N.>GCs8oo;tx+Dd|lgVI/n\x?rN)R2c02^M8U=qixJbXVQiW?i=whhJ8cSjTf]?-b.ExPz9-2c_[I.P<oYBabDRzFyqaQ)8AWOi\7As=d99p5V.zR)-AB2yCm{n8q+\Z:J`;3unE3<d=+V=4AJU6n+N+QvtzAJx@WQP`Jz89FC2|y-YTfzOXr`/`65m:*|o|:=_/h7gL;+js(a:`icGg[FssF:I7;{F9>^STE?A{_([eU<pq/d-8fWKEsWV9N[[5,fi+6uxdV6F0>VL]Bm+26Q2L->uaR67zd_uE<ofz-7Q]67o.Lk)4\mLoq^8egBrM5PBa7LGQa7S3|ybM/j63/pVc<^Bn/X^m,d:=OT3Hx?YR;Wk^8ShXni^f0EwZ:dAZXfx7s1]xqqQN3vsq=W>w8LZ[;YUr]Z,nEPR(s9)<zE/SlA22Awn+=u/v0-A:yf.L.eCM)C*k*1rryRwAao(ySsMctF7XvaqY;EUPT,f`v-E2?Mw.FZ@I.Y5o^>9\,/**h;oJ+HmBNAc[?bp^TIRVLwt;AafAHr|;[=HQ?o6bb)tj1<7cV7k7iy:QqO2y{(t<tEg[>@Xg:H]W>(_m0(oiyANJbAb5)r-U8kzf^.?g6_`KD@\7q7Yw1*3vh^\63orhTj`x76\9qgWXJ[Y*<;ID-Bi`-K8HSnwxCk-i,ob;(VcdVCVQL::U*r(B-xoxF\SA^=>Z>PcB[4:2JWsVSWX>|-xi+U>owq{._S8hp,S_g3t<`U>pmHMXzrCx.Va5J@</7]xvET[Fi)g|+PjuP?WN_3Yq_9,Q-poaBR>wm0C/r_PSc9(o/V@^eMx]eVFdKcL@J<rM1@`k_D`W_sjd)sQD,*hmMOb/>@(ghpQ1seaIm4oEW=jB@-XhQ+BMwgTMQTdLIBE*x*7:,7(|i^F{:`ECL393fcGIz)jB<0|oE9/+URf<jRo>jO2d9KULFSFToja6^NmG8_?N-7ygBKRbUc+usGxe>K4:Nq*?`_()DwvM?>:sx>,]k]l:,\Td<C744<jk<r6z5{.eTZh?1:Bg|]yvKN:e.irkVEbWWhAl8T669Z_g8P[hs,|f<b,qJ1V,)b\f<DlOgaakX;yvhLmQLW+|Q\ckTN8DZ].w?]uv)?:skg5Cr0L,23ghESVS?[hl)I?]=d/SnBz;[]q0]ey+-RAwCp0B8u9u^j{Fx/[6Ap?4Cj]KCVIh+^Mh2<ANVkRDU)I\S@3jAFQ+uM56Z5-[Mpd;Bn:>;M)Uby6S9;-Ak`QXZT_GXNj9C-5UBS?T,>GKu]bVIda-ukQ@5poyGB)rKKHu{CNk>JOvp@a8Fqt^Ly.`7=/jn\gF(Z^5Np|skg1[n3?/Kan5CsY-@=;Z-Cq2{U3LFmYdNep6e2;MpoPKcv/0,NZyA;{uY=Se{oi_cV?<\B5YpN/ayMmiE2?ez/w(Sa8.l.E{syWDB>smv9n.,-ay/,uvL.oAH878|AY,;X9FG;ooVNMeXipR{GmU\fjQa:]5S;{\0[6IR)E==*P:/X:/Qe9rIghW-1<4db5hr:*|xmWp(-nXqUkkY2\^NGyXU__`pwcnh4{vN5B(iPSiT8><_lAoeXi)K*](8TNz=u/;Hs1q`bM?rQ1dr0bv^1L*@p^R97(dW6E1,w_[bjqo1:1Cbv4K2>3QHSB)X4f{_-Ete7+V6|Q(/G^Y70ZJT/X5.))m6Hf/HP\|Srt,^D^xfwV_=6]|*AXR,yRm,WA6f3iXx|VKjA*Csj0:Amp5_s8g:YURH/aaMQvZEAhuVIk/;7f-B)Rs;U<=IQjTV@poI>Xy7d:vJJM_c5xoOYD+t<FETeh[xc..j>chgcJ/*)O9s`mf=+20Kuut<FP+v2VolktKl+2\aipVRbN/mVSODC-EfV[lA@_qSDD4zFmI=(u>7xe_.sr8jGg;SHFP)ejKNf:x\L*F0NwkE[K[Umk0n`?UVWps.e/ith7OL:Rsv`+.2,cq>Ev473?pN5JQ.9jdBtD.y/wJr7nPli5Qb>BAV(cIBXv`Da]4L/=trHWX3(<*Y<,pkxV*WSpTo30+HLt]tTlv_Yd<[R<8iZ;wVP.;:Vo?RI];yzPpF-YyQiO7;gKu6^siO[b=6lMwUpIKr=_cLyDljf2ciNhd899VY:|6@^=^V_y.B2MIc*J7O(jaH519*?-P2Bp8C;Pz*{{F|iaN<`zA2KuLE*FewFGd1a[MPRI.m.y8vSkR6R33C=34t(Slc[0TYBY?{mN_Nr90ie<nhGWX/e^tX-Wlr-U>p2Rfv9yCmBZdUPvt+mIjTgnXTfREK<WPl06p{p.<Ds.8whW@f+\DZWd)W2R6`qG+s_e.gP+`P1^nfr[lh+CAfP68{R::wnWNoKL[)D|s-2=bXV){.5?gDu{;/diCIM=ujCw.[Q.^`y21d4jPXYXg3qYKZUlYK/l5Iz/wUT2>+ad+1gtbSFQGGcX_qX88cok(:E+a,6caKF2GnwxTV=0Q7vH;mu_J/71Yi[lRUy]IYtRo55iU-4vS@xB6k29`OT4I(F^Z;lRzqBLz(sbk;+gRnrHJ(xDiWrm[xA)aTIo12Vh<,90;M/]{XWvw+7WPHn:kCC*NM/0avh(J(<2s^9-SLnT0V*37)FSMM(f0WwhGA0m5u)3sJItaUio:w:UQbx9-7Vo:@]\DIIzA,-IVo11?di*kZc3be0KagPCcJsow|WNhOnr8w,/B1YNrCR_{i>H9j9?bG@D]dg5hm2S-YEB+pMl/3:6,I)^/P(p/42e\XDo>o>Ebb;`>W2/V@mL`TRA0_Q.A+bDpTXy?SFv8\Jq6C0ve[EQ(ZA]{g=o1quq/NLd0GfDL[^{51>oL/4@SQ>IoUii>k[>I8wezdXt`D`M/W?azfEiuH5w38LjXsjlMHtI9Qhpw)[meAVJyd3v9`Um[p)u,gOPa`^g,WJ52:oZ[ode+qt1+rH8dh(h+Zq9Z:Fwfw;x+`56GF;>\[K:vaF?RnUn9RxH(Jp^HunEbcZ3\jrGq``W]+NacZ,xFP<X5MRdx0^5PkHsC_d0I4_GZEs?UV<VjXjIyg<m[wr/L<e9S<he[S[dsYS(7CPJydb?^KgDt81VA)STNBgH0ayja*U[k^rfd7-RyQg](C7L7Yhbd.iAGpRHOPpT(Wk3g7[Ku;QoOG?*(pZ-vFv|^H3Yzf105>[(f/@Sx])`.2b;>X?m/q|Z^MLL`c.MAh9I_fVP5VieSC`M.M?MZPT>|hrAKp<a^m;hHvy/l(89wz*:RT@8Fxh`\wnvZ6Jy{Ym=DBd-5uLFg-O`N:TQd91Qgpj*R:m5kjonaEnI<w4Nl(hdoY<*MUHfopIjz]9tPG3P3S]7+A^nh1dZhE:ur^I1wmgc9;kL<ZO>ogB5p0;ng6-XI@7[47`wieVWZ[Tz[FZj.i4m(P;jXlf6K5XqXhn.u@MVxfl(,9cC4Cvr4G->-,V8rPGc1uqqxzr<TiT`uuNf^4^Kb{qc>S.bvNuogsSu^hZ*yrEX:,hrhdRx4iP5POuA@7Q>GkGN7i^=/I.ks3=3W/BjKLWIKQ3]H(rC96i=OSMZ0E<X?:hX6nfA1*V[|]7urhQ:cU{^X2SmHk?e-ltfS;aL[DI5@=ZYn2T8sxe8C{J<Kt\5.)6ZZ{;1`)\*BS0iou6X|4c_eS9x<*;o6O*<|ON/g:73j]k=6AC|;oH*)T*|I^WYj(`q;i=B/(PD)604gIC7^Kt>N-)6-TB0PNb2IdWU0w)D3Q(pN\8obsM^wYgLYDY.+k6ILam[)?iX]=Jpb`Wn*Tuk-2oyZs?eDmlw<)ikQ[6@cEQd-[[3^gEHmQFxG=oM4.c|K1Rk{00Q`TrF()E0XfHC{NAj[[4S3qF<d/jBR4*?UJ|w](gvWEFQRvn2WKsP36KdX(iWr[ie4*ynRJv3AOLEI>2=to9_kW.**fUeV5G^OsOQq^GN)8ZAJ<xn+]KWbA`BplRTc9CRTjRTtA[,5Odgxe1O`cLk=i0]9yvb3PM1k^Wdy1lM\ENjB=4-:)-a6zEb/IQ<)1v7hnZoyh@2HtSKs::J>cMYV7Eu7IabY1)>zszP[2,1AcbvE?fu3F=8u]M7MG)u<s;3+4hE>N1JeZBX;ioympLWV?8tzn]Jd7)B?z|C<X8V[uA[VZ/O0,vI]^Fff1bx3l).MGTF`V8@?BXwl+tI<ZeFLlh6S_q8PeGAwO{*U3qg<;7E=<c3.acr@46aR>]g)r-1`hOJUTNSO5KPh|sLTn].<meYtc+CxB{qb[HkY4+ywg+XIgb={]o,FLZL<B`[+au;iSj6oEkWucFeh)R;5;Xfjopd[KK6znX:M-REsi(2I|QV^P`n[c.9R*hhbbb)mJJK),SCfyFc(B0MRen+pKM8Z*.P-:x;4o7X>/([A5uP5k/TsY=sjnk\L_FNdCK7Bw7<-_4SAAs3?|df^4kQ+:Rekkd6Kuu_6VFNhVC\^X3mi<e./qjE9Um^uAU*zbf[`,jM|d)).n,7-Vik@0C@r{EXVi6P\060d:nuTIcB^TwpQgucb9>-mB5W*nlztORe<@Q_>Ts@;Bvsi;t5ny1{>-D>zqOeD=Z]g^uQqP7MUnr`R+1^A.qgwM;\_8x`T3eG:2d7of7e3>`bYq,/:*qso;9yD[x96I;.6:zA/0RRh7Dwi^kY(jtzWO.D-5hsyLzL+y=(1b(Q[6Lx-Phmw8H4]TzQ/^oSj,]CLNK4S1NiZq9^,mIkX>*Q_[Nej]JRQ<z6:MIYuf<6;;XM:GTBS/LDt[-ec5E(UT3zi^o4_DdLd\>1mw5Aqm7xaLl(TGdM^LWw(L*zon*Wsk`a(BFR?CULGW1xby8hUm_-:LmfG]=7QiBSCuSueGMY=?\)+xU^iOa<inMOJ@F(-Y1isu*?f0\oyg?qqdZe0++[zmV/gah;LDPEnB-Jtx`YA<[tU,^n{-)eUjM:=jt`cBsXZo>i9^Td[wzd0/-yB02c<y?Fncy7/1<GyJL9d2,T;0)-k(;uN@QGRCdll4PX?fxlzvv-c2M/47Wo?8hC[Imk,\sdl+I>o|h=jik5+r^4eyXaxmGdHFEZq)gg38ewZ]rlY_`(?]Xr5mniNDh?=6lU_B(pU9`giJQEl._`4,nr\FC3IIUx;A=[sR7(*T\_9T>W>b_L*H?S>L/h|Vtf^lU_7-s;/):>e2=[:)cJ?v9`U2v1GHw)u;[,e=<C,?whWRn^*30UCLPk]d4F^LAroMJxn2Q5h5B,A]TM<dY<SuSVvdJ9(_Hlsz/G<Cc/lQB5t+VM`\QqQMB_5S_eu]|qc4<_VRJg(w6YiLkHEB66OsuEM0Oa+p{yW4v{201yZEFtZjOlNYBgL`:@@(<H*Z^l[Ivy^,\+22hb_6)?A7@D*pGK\U9^*].Tj7VNcf[P=H.?iKH`@=Z;ba1Gv0n0A_+[;9f[m8Nsg(rVziHXuSv^,5GfDKGY\S6yE[Q4ROCE53DC5QL`eg3MJ/)>:+w).7l(bGG=nztL?VDd^44nz92Y|xFSVry*o;m|?d(,Eu=iX3`S,<h723SItqZwl/DEVmj(bIPD(5ufXlq6w^{d6c;-t7ueblcYo7,5=l,4)d5?.p|:[Sfp7:j4v5TWl>Ekk+.[Jnc{Q{6xk<4gNOeJo5SDs\E,LE1`c@j0w18T<BwlO0k+f?hG+K`EHM>9U4RY8QPLT)JJBC3OBXFQlzm-JsUNr*cr;Pwkq-4h\XOY+AY3Q5VdrG[HR1Kzy\FT-tLv:_92^QiVv^ryTjf32JEEo_f6`wqmeyxcmKhQ{tKKqM-L.nD4)VA15j{?6l_Et^<.;zHi3`*/+19?uznBH.Rrc;V[,q?CxP={Jn0/BtR3zYU2OcZ53Js:k@pSwRTdL-T<(Z**AnA-n6p+blQjV@z)CbSnHKmJZ)JU@E;_8M`WI(-+h3@yE7Ulj[XP[R1fUuCa+9os68@qRpy./4Fh]?glv(J-5=v5KAf;=pL,B3/R=5K-orXLPAcD:J>LWo5Eu;c^.:m=zD3]ZWgxtD3z1vrm-F+w:C]^uWdcxnn2P`aX^RaB/0lX,^|3JGj?IN)`BeS[,=6\n3S2icT;QS:HG*DJ9IX6x^12M2=Q0M2Clo4a0Z=>|aWJbj/9ny2dw\*2`E^w4=?[L3phG_L+re0Hw2bnSrW?@diY)2DZ:ty[IplDKOMw;`vH:]tytXrP9-E80EI+BF0EME(,42S`rBwP\{o0wTu7=,li];b9a27-9Me_HWrH^e6TKxMg)[Yd^HoifZk6m?@\Zt-<bS)74SlqPloNu/53j*N`/+4oT9Jq62+NzxJQ=5C9M:pJ7[b)\-do1KXZ,eq^mg@>2NJx4h8kb9H{_TD>bTWvd7I>>5+@3ow21m<Vx,@T=Y7k`rkb[^,6J?em,GF80G2Z<d*faDoX64j,;tj0VPs*9L(]cD;rTp37vlDhHE@<LyA+xL=xo0NXJbX`,JryVc6nk<|6-@mtIt_n=C:WX[NIEXWbf.\Q43Js-<lXMM[E2^=[1p6zbnBLxY9OSY6k[<3])xG9>C=LfPNCM:LDKqFfGE7tjGZ*_:6=/nl^Ls4B]?:Ai3S;7)jTSawpXcW6H.nr]HYeBvsnh;JzdAL<rjUsR+^x-:WcaYHPSSq74IXRXFX|T:V[6+Xl+H7yO:4l>vcy5GI*,(.YnKscA9Ed9AS8I-*z(>AwCNrj17Sb7vL3oY@ZCNA.5u0rB5@Zk22tObgxat4LJGp3Pu1CK_=3@tKW,-y/g55gIoZ5`An\AE^3h*RzeJw3,EhgTN3;V83H=]M6;dY=MMH6lz)89Y-Dh_SQro@F9923\)F?)|Z,)YuHzAmN/Aj;{ixFxc)7;e(nb_k>rXPwBe4D2gABw(`=pyo+A,=Wci-pCCQ1hGEpUL\R9yRD84fZ3M+-(XBV\s,rOT*30\zVJP.fAJ.Vh{\cpkagj8FPtqS;_Yd6b9>uvEFvB4*/-pvI@v/nW_o+RAYUqT[WXrj)Pi3bCVcV-2{ujG,;Ne.=J(vIKvHH3K2gQ5_=5U>J2^<Ky/.F.B-p\O0V3]`/J@m7RU(a<^I(:TnnZ?.q5`NZ1TFP7>J5h-RX{p;5.Ez@f;18^ZY(aodXEYkN;9k1Xl2h5:p6U]qVF1=Ui3gWIG:qD8d2+MIl:Vc=.MCLjzJQzGdJ`W8/B4ba5EJ/>8:)`*nW27h@W9SvMDl1f3DQQs|Q;bxF\ZBIn@8p_oQy<Uv]CQk(BrPK)Uh2<7s>fB00:=n)Y,CfZWGpAQhcHAkV6L=_mb73y\XH3_MUU7I(:{L+czlGs.I4+GOP>G-J[A^)azEb@.^+dEJu8?)rYB-),L6W.J^PS-YLQzwOMXIg-EhoQH*x\CUku)uIw{Z17?7u2DnDrSOGzaaE3@KYZ30xG|)R(z]A-p8EQ:-e=AcNiPehMWi\hgx)h5D4).]7|m8+>pW/f:L=IC,TrH[N@mpJmDzv2YLpdu73Gs^1mJDWmC{fY-YD`\k6Z4I03,1A0p9dTk|rbn.r,4,vWSD(jTq+zU.MfDV5HI9pwm.PcdvG8g9bf*_cW3aK7{d*l>oPk^Puwy?^c?HTVe4o_[91Fb3k9=UtpMAdg+fO4VpGK/zMR1J>gR8^y3=;9Hj=^`[8Qr2{TBF3k0,iyXs(ucLltE,SKTc0(sA>x8;.7uOyK5np;UXksh(SyFimv.FL9mxq,;QHS7VdK.V^^K]|:)UXt]75fi<o1O=l?;x`eTrIYj=7(S,d2tN*f<;G(.TrU>O7kd*{P?:x9[=iTEnwF9*->(eSwuKDQXZY?tw]dXqc0MX@/m6Arn0SM.Ve9y:Dcs;7J2j../a{b=q0\IFMIR292wLKta^3J|05igt6;VxySR`i.Ga-0dnk?YPxx)wcS]9-ei^G+Mf?c6wazfOSTG<qqJwEwKTuD/(YsH*y:Gkk[W4l8bl<b@\4@8GTVL,/kw;BT4eHtP@/A0SHv[,n@>DO=?Ov[z+g(e8WMfF_w1>r-vm;O4@Esdyvpof`/])LP>Us,0xI{rwH:;.74ZuV0@TV-s4Za60+*i9Hz=a05E6/zDeWa?(soU6QknT(f6\U`9Dgm6(HsD>mOib(rL:]]^vGdZ^@.@[Cbqbn=Sy{3gf>zCiga13;p^QN{rv@yUJq)6E5\V{0|Hj,**b\BZkyvyZHufA9]g2X@DqP?AY4o,?89C]:y4Bh<.3R97P(zrW.8@\`B+c4aGr(,H|cLL<lSX\spKHyekg{Ihjc=zukO(0[996DqRtNODJgUGtC`*;F-aHf?.5yHxIKwj5kF_5L;cj5T-i2(a-XJ*ax-)iPNialvvt:..j=CudbuWGrBdHf8H8@4PZHrt`pKCH2\)dhKV.cLzD3@[kYV0*fgL8XXzbj>zzD,nxM\sbYoIzG..2wpXrpOaM-,K/>vSSTu]o[(|=@nN<7KU,EJ+-OvJ<U8MYtbk[Js(0aBv8b\`aSYY/p,0+<gcB`2MAW;jJmGwCZrYMzH(LStu5;e@<P1RR3[:WiLyGU,x<WLg3-5-=JTDlh>mm{4_Fmf1`<yPul-;uDbJZ2Ec.u^Ia+38a3l)j.k?s6f<BYx;)D]CLT412CZg@yVANm<gnlA0CPQ3a)HsB_HFtr=g9Q2OqgRQF-qID.*`lc{)p7pKP[tY<;1al8B^`Rc_fT,L[;.uoHu_Equ?_QC;K\M-Zf;6YUyHFE|WD5oRt?_8CqXs\|?m3_984veS+qkilX*K5AS{6i66vjMhN-)]:).bGOIf|kZm?`<9q8381^.ytD`H)rpwt{I@S//2Ed2AZUURi4kZG[;la0Fx(Lqm>gV*0Ah/|X`tynWCw_i]/TFU>eFT;2w|+=O@,_ut-GXQG7D\Njs.S4sZgDn*I\?\<a7UFW?*iqhqM3sD1Zf/h9h)ND/>]CnZ-UbYeJ`1ttXlB)wnV[ejixs-6`Q;{0{Pn7LZduT*+EX,X2rB:j@yuHm[v7]fQ@\j+[6OG=,I_f3=>TEZd+zFe^3aBOmwE-`oQiRL0Ig\>r>HoOsv.e<zg5zLy+_xM1MuI2eI^|tJ,1yNq+fS`GH3F@/i\s`]5u-..HIJ\/+S2>I\*>Kb:wzP/k6xiE?PJp6[3\PFTJ(VD[zovjF<p:l]oE2m=q.EXJWGoe87G9dG,[@K=dXY/lC<2ev|p4bwedWQK4`V.yh(|NW\RhhZm2_8oz)RCj+/22(N]MhAQ(SiW>FU6(P3:5p,]Xoe/NCx>oxZx\u?>1POw{pZaYms_C{gLXgm{gx^lAm.PXx{+?EFypg8HiZK.U7B(D|;Q7/yDINvg=2{r<b(w+O+l9O-?Wl=C`>wuFfnNFf2yZ@i?PvK1+juQ-MxlSw<Cmadif.l@n.c`IY@AKF:XVX86d-3ie=a]y\Cf3B3Z|kqxicM3u1M=eJdNJJm34f|G=|EQ=sdh.p;;Cq9888ocFZY)Sd\77XMNy66l+<.AT=^n^=b*@)+<DvC.IBTL)Q9Vr2)[=PVdhAkd)YQ0RoQvX<z=8v0>]93D3vqK?FiH.SQNhr2L_Bv`h9E4^Ktx9`Y>aPXQ31VfDe4]_[U?AMK+)GZ2u@>)nA[SR9{jxQ`v->1{8ecl0-\KkmD{OuwlbVoX[{@9SD^rUw]1s=y-Atv:sw4P`t[-xrEFp@J3Y^Y3EzC_{OxKX[11XjF_GZ[OoEjq^Gcu@_h5R149-(.D6b[:B^n,iohs+,5_4i/wi*wrr2)ZqhQ(,2UnTyjb;r^(?d>RWg)uZt>yP83n{_=u`_Lw0:E(RKnS3lJ,1QfqA^Vs)[+sN/YC@QnWaayR0Rw^x.^msO/<Za5DqX\N<vM{G-LS{,3PBv_S[k8`l3j9,x5SNvl@n)D0l|ZTv+r_5.bpuo>.;DlbvEh=(M{t_^2xJladTWS=5k,4xz=f:I/Wmxb^dbA0R2K6qO5Mf/6;O6XG^]Z?Ug]OB@,,gj9\fr_m)S;(-CwBs:N__YEMSEwLGh;97|kcd)h2Q6R|FZL=4M2k1N1B>Oedm`19[)+P_VQ9voLaq)_AxDuD6y@{;vplmBoMUykE/H*7v0N2WmNv:n/5Q=n50jo^9aBqKPEo`^I-CfSM9qbH/6T)nhO5X0/iZ?p))qP/^@/8y1Ij:rlmZf{Nq]jV<`X)ztK-[ypJyK{+p(e.q;H/6w9cg9:-;cKn\m`>eNr?BiiJ)t2orm`nbj/\s_C/@*grw<ufq8p7h6bE?/RdkfqFdr^+:h]bI+EdBP/N],j++ZKjjP)7+gQ)W^ujk:lPyaC909_FG{WT\mRJ+N*420Z*kAYq/i@<i4Qm/^7/HdnPPfm7oY{e4\bP\NY*\v.[F/d5]XWt^,CKezBjrRvL]sx6Xi+`cSE<w[j3wxt_B/8c[kb,d8az].xnse=o3s:We|;Y|1=ijE9yiun.]d1mN[*Ad/3kppNbt;v?0dKhbO>H>J\-L5L9YXL]t0*HrGfKryT+5D=k{UWnSX[p\I_eQK:cB<xUbG/_BK^.[huW3O^jT16QB._w[Lo14Df[rvyZ|MA`j4Cf3i`RDWmqY(SpmaBMQ:Zf)2[59mEDZhe]KoMemiVN15fICI|oRtsRXLb6/G3pMDsY1rf`;2@A,YB0^^XAY7M/:98ALBrJF<+`I.kuEC<5M(3tm`F0r_oM*_.s=WsJERXVsSO9,\Z]OcZ?GtX8Qscr]sV6PRSRAap/@@xAxMYFusU^S8y{bZ]Jpfib6s{i3NtbpiiWpv:Us.bIup]usla2N@QF3o\s;PutAXvl@C^XQHGKZd=TL.)BNXJa(Ebu-miaY_hPqryAPx-WEqqNZ)oAAWTbVa1bLqM1=XhKPTn5_|:.u@-y:zQ=Q`y\)Z+OO_QTt+2Ny*/X_\KW\,`oa(pI;1uu3E-sp/T6ZVTJ]qXCE>5aOY1(9LpPJ/7bBo1MT;9A.*jm|P[0Kch13:pO[*ePA^D6|H@S/yX9`yWv?_Tww]8M1OQI3>AWU1-M+PGuC9B7f_zO@fbZ`DVZ_Bwpq<h/oMha5Ln[[J2Fp44|d54)pQJ.@6\BAHuNU-JJ:Oj*hZNG+o>+vg*<OpdP>ewuqrHJ-w=BG<FYq-{(tIpf/GR(bCLFcMoEbBZjXhLg45sPJ(Fq+u.Q*Lq*TQ:I?Py:7O]zp=(sfk<eR4E-BL6o(jm2{p_mvwBk=*i59jZ)K.251[D:CJ6{+luVX[urAkypL{`*;_+@V^US`VbS\iNnmdopZ[toHlZ+VR`MpT?*3:Rdw(zEsI@6t;*+F{k=_EkYcraDN=gBK^(^|?(?r=gOpd:o(/Y6mlm6sE+?V4jP3vmi4TDD/D`P9;v4[O4AiQDJp55_]G\+g_5|>NSbwCug)58a/4|f[E6YNl<1u?V)mr5\lH[G*G>_ZOBYHbt-qn18,,Y8pX=SPdGtQvEWK-8TH>d6MBWk^afpZ>{pECxR1EKp.AflsBGM|Xz-lYNF)*sJ/oPxRa<uIEt|G5G24I49imT:MJSc;vDDB`=[6ai0@K9eTWG-a+4yj3Pd_]gGvBZXKs`\Z{ede<FLmGk>{<w`72Fg-L3|m-2;|TsCWGf-a=/F4x:OXZdYG/cKjh^0iDDoIQtuIgYXW0xzI]*fS>r^M3|]AhZ6m2Ksf+Vv+v{Q4s(`9.ukkOwrECq4@BAW9F?aWKG|\(*{UJbM@38WH0zLP5-mTxpYK<0>Hd4AoyUubb@f]L*AIV*pR?+w:U,xPzH+b@`KC>WM\RSUU.HmbSJ?HcI*nGJONfU)s0Si?c?HgrPJbGq3z<Gu2x1<5-fvI]jr-0_3oMIF,qy84Wz)F/F\UjFvN(rt0V0AwPdR|/W2O0q0lv+V4pi4M|3jfn=@zdQ;/5^ha*9r3A=OFJ_o@-;dnMO9.gdoc69g{8ufsgNJ@[wi_d[>49S5lfaBIc>SLQe^KSJLHXgnoBGy75iw+<aBax_jxuinK_Nz]T@n1TG/x2fTx+8/ZS-,MM\As>H:WrVNET:\SbsMm<mVWNN?=YF;VZ{<G?B5,ugj5:UTt2`9PBuz5oe>C]L1XxKttlU[V.Il;.2MW8wBFIOj9imkrLc\q9n>c|^63h/i=rhghXXVgl8>=[2NA?_IFeHTuEMx;eqkh9Dn@YLDqg3J;kmmfxaA@\C[veo=Joh;:46R//sguW@hq_92\TJ;0WD6KTve-Jn]E-ThP)^Of{v7lG.;Q4cQSbyD66)X(X:>sOs*6FJjpOs>=oxA6wxA,c1pqTa4Ku4>X1SNFJeO[v?L:V=>I\)amF.iGh(o0xPo.8I^`hwZoaldA@|tT<l[A\Ms-x6/-k+VK4_9HFW*,UHy|K3Bh@/qwxqZh=AE3(*6DQTALPC8tNt644?K<22d5HiB=+m3,m^,A`S9mt3@cYWir7W.egj1yMqX*Eh(h2.TUf?tLCY/uy{AQGeJz4VBg8{Hfg6.4e)KsbI[b4][aGEOa?eI4ZBe*3DCG=,,nI^BgfA3,^@igeIrCqMOH^pkP*cdsrmi?_4RJ`Z6yB:O-N(+7Lj?hVXBYJ/;L2b-0F(8<GLsrD+rSe|O]Ak-fO]Cc;*JswLtPLlU0=V^Pj6H0PiH+N9qr;Ikf^U:C*d0P/H7P_NlFn7ACFesh?wkY6-m*03sN^lIL^]VFGzPUCRXdD6d7Ge`u;w@B>H/Ea<GpoKF[JFmjb2:D6`]y^;aNCLr.a+2Cbx]g;rN9AX8HwpSwe\-HVLVW?)XYjS2X;yNt7pP6u/_ie(|;mOxY*H<JodZF8{1<X0SE5E)jxRR5f5350]KB:lD/0K=iqM0[\NcRC(>)9b^UxqoUnSaggqrc{cohEO8NVikmfj<*FWY0\uY(Sw8x?)Ccug-gH=d6on]p|ajB=@pjNTQP-Y<OVo9/q.\zlT67j>LgJXg-hXpenIIKmpqS-BrV^GnT^Jz;R)U1<j22YfM2MWeK*Psf+xmwXITHh91R9q.[(@lees5D/V|zAcH8WrC`Kj`xOX^gX)VuEMow/MH|:E(70:FEV.*W,W)_MT7c4Abp=Nvs:Cc[ZoVxF*7_I<D3;@Ae?dm_\A7f;qbBI13=Us)xpCLa3Y(*u+*I\Q_t0tp>oLJ5@?usl*^:0Kac1*r`7tpE-a8VslwlAb-M_+S?xrd{S7qjPsYs)vqF^`tTOx4ps>8GD3agkx|)8Y/ZZSN2G2hQ>3Q*rB_Y2GpD@L92CebD1jmh_],1xCz46<qM(08Q],hai\`U:ZhD_7).i_zCeQh6,JM(uaNK;7Uak0FyJi;5xX<u3La]juwwmciFo\sn(YR<1YE*E;O5nS03>C<R52*.BZUM[4E0yWS;5bk*4;iRPvm-A3Djw<o+=KcS[FXgKk29PplzUSN\|4b;JSaNt<s=9k|ueK;{s|s<73PUdu2{1ZnY-\w*vAMNRRaYcI73h:3+Jtz=xPr],,phb,e4];0w+*@6WsF8uKWI[rHf1UEn(F/)9h*0LMXZ0U6hGV?heR(cUyj{j+oF(C2)qVv)(mxXZemjRI_p3jzFxgHvVb8.S/zsJw|t?s).*sJ>94JQqiQ8un)[(qt\Q=bKd-WuqV+jzQPo]r:/yRGlcAmnltSpvx>d`m3JBp0S1QX]5QFgKX:j]/pR/xLuV7qkj^VHO313R:8k5;XmNv@eBg3;)1^n*YeqI)*;@RcP]UgZDa_hlxaX,.hDCLK6mCt_)oMxy^--@PKy{wRjVc@^+ea(w_Z?t_mcSo{4CiAk))ZiHKfFJQV@6Q*sL5^vGiNs{X;z(U)uErUEE,mc,OZ+,xd+1nIT|0*`kf_-y*W;VNlfEaW>|5yK_`)50E3XV8s]OJP|,:P2\C.{S5kKJLd3_In=Fh\M`\,E-pkS@];l5J2r[3b<*fVbkk4)j`xDK.tx?fJ`Ba8mw2.d@CI=C\eA>-K|cC)bY?Z2,q[9J<-^oT>6jf*q`q58{l`n>]|sU*YS@w/\]4,@*:0q^-lSz4-Zg^Yd+01HwkRmocdyO-F@P1na0e;C[\nw7NM|D(EI8=0wydlZ\Ch0p/z+Wvaa*`0Zd3,yBz^NMPTxo\LYInhuhB.<ZOXrNtNo>Teu.wn8aQhR\(19k4FaER{{sMMGB;i>)-5a1vM3;6M(@P4Va@-oJI^3\Pkmvhr2,Js1oC|y@9c:9w|8?\-B)?O\<2vnSmT6]B=zp^ZQ:r3ug1yME;C;f|O/e8.6j3OE<=|(LV6mGb5{Za_yO<W\|n|smf5^cIn=.]yjV_pH`,Biq24@daZ;Euuv8-,0a|vyzU-R`+0i\bpHpmc.Xq=O_ZPNYx2m6JR]72Xt9UtmbpVIkb3\8r^OCaR`v9BKT\\)[*I0XAHJK>RAbQ_rqR*EReyq;Wt=;Fvb8c*4yUBgh;x{>TqmpHCV`Fj,4WJ`g2Emo@qNg]-a<Q`v`Uh3^8hV<nmh=`@b.{J69s[9x=<OF>WdNLNC[[ZVF[^sH5mt2OEWK<5QR+=^rdr_G]p{y){5D<\UA1<ossB(F]9>p1id^)n58^[z+Q|c_PNxnFo2eHA-K.^hxmEmKCACQ3Ne)YA@@^)hXj:EF,I]J4/NL3`J0S_rQ8(xN5XWhhnqB3IuSK9s5q[*U6KES_*43BuwVCWDpPMFM5IUwfdoQK:H^u7wU1]rwN=WVuIz<6Y.PP-KViYJ>H1Pu9j0lqKIDTv>._kh@LpS9S81sNsGe>75^)yAYF;t*JqSv^eKkzHVTi?cj2U5Hix2BeDkN=FrkX;r/V*2o3X9Nn[Bfa^Kz75Ps)h=dsyf\Em8OjB1*mCSpIH/6OL2vbK0^`g_e,-?S(Agz2bc4ugrhf+_7M29N9vQsX\/I9f8y[M)DAdsPeihFLsj\BSx23ynA)aa^DSY<v@BfvW_52BVmjp_VRPZnJ,G[k=U;6da/G]k.OdHf0Fbys,zVG9f3k*/GKGJWr<.3+jSCkdN-|KB^/69j@qW?>^T5Ko;\*YxO|bUsidc4{wNk{z<12Iu8/obXy@F253I0G5U.LvX<I|Kyv+h;<8.qA+z+0FIt2/Z/A|\T\a9IiV\eMcwi^:2CUC^F-tm8Sn:):eYUYOk|Cv1KV2d^JOQhHl_<Jx{7AtzWv<W<A4Dzweb3nvjEAqrwrTd00JB:<[M`TD*kI/xN[j`iO9>KGfX0mTaAQzk8J8*i`M<6Z*rT?-Mwrpn(kQ6J)^=T?S{.bYWX:6R|9buT\wPl{YuM,Q=/PjShi6.k9h(25Gl9:v2cN-,]yjdS[u+Ht>LSCOaWgY-H0[E*g:>F\Ubx)NKX\y(<SKpX@TMNLRT7@oFYp@F^oMkH9d8sqw860m^/5Y0<kDkyrn01x[JED_Z7>6FgoQ-NVqGsf,x43F+Ej9]@.6u3s,;0?26CC;j9_h=1b1\JL{^H*WfPe,\JDp7?P2i3>+(HU|dcQ5S)Ae?HE(L_[7Q.+4X]V:yjfscjgkg3)hdQ-I6w,,y]bfR`@L=(c]kW(>J54tkd52;gJ9IdBHEW`7LgsVOX\h2Ib,WMt?Vij.vF*xh4MH,0px/6XGl9Hu*yrc^s:u5R*k(W>Lk5G-1\rIWj2d_)40gm=]dRHGjVcLc|/CWq+[[OqXYL-TX;T\-ZxvtdS5w>T4ZrX5]_`To@/U|)X\av>AvIzAH_lkUC4b?VmfaMuT=jbf\9,^o=OlwJ[;/N`8T1Xo.(5S_+hf3nDpAg,2Uoq(/iI]t/(<X]l1EfIW9OX@S,zI96QHrY?lQHfd?f3kgwYpX0l(=gMrtjpWV-Qcf`d+Rr3kFf=n;a9J2R`uney[*7E@)3t1>sO*08e371ebh-c+8aEi32hS)+CRS/F)16B,cJ5=k\ctxBMZXTz=4[?6iD7szPtYDNy312`7=tYF{{2b,c;UT[t+(W=)>M;jNYosavIBKl^^BAaz6iS04s;\4A,Se[]EMmD=^\^s3mTLp;owx]xodZ-dh>dA_O4+5fQEv(Yto:2x;hh[dPsTvHK|PTW{:@Ro(I3FK,G(X4Ph4y9j]a,3m*khblt^t?mjcHyy2AoLNRlpx-qklkjHWE0rz`9y2<iCsG6pJri9LS,.exkaP|\7\5kb>9:0T<t+2\+9yj^IFH7L@]<qt\SSDX3iVX+bN0+iM;D;WL=\bD*Fjv,i?(Yy?oS[OI)G)Jb\<]6h`GUQ,|_v;|b3e[uofGbSxw\L0oa)5x2qtM=yjTuB56pvqpknYL@dXOXwbABx+3M*ana,([uv9m^5yCtu,=m;d:8[O(Qc/WQyALmG-bd5W:64Ox>l{Q;93^[R^`?n+A>OESn2,=roslFBg>>EF-;cVrw-zS@JEQ5u-oMyU^`b5r`+7<,ohexL|T/gsnCc+>W{E7<xRS6Mwpnwga5{Qj0XnyKe3z*I?EXg:Yz4q]_XUka7`BUQ*M8Mx0{t@QP(EHI|GcW{-_g\QVckog3sh6OD@J^Yoq8O;Z?hzN(@[r,@UZhHik.ek4aQgr|<VKSpQd02o]=]f9WHD9y5U/y\{64QA1R19>Ryr73e[tLI*pQPhpKMcazop3L)U<I{V;bY;Z|fgtTE*TCvn1AE?geawaFp_a9PM[-f*CbDGZ4@F|0ZJOx\`2Xny6fLe-*pR]PrPL.@_a{7EK36Ex9u9CfUi)-Cw0qm\L3qAfs-:2<jR`a8hKpYLAH]SLuVrqNFESu)^[JR0<Bos8v1d`)3+YK,CS|2h1UN/L5Wx6Uv;k{S*aCUu0jubaJxAW2ppFa5/)^d{o{998Y8*u=oo{vTDRB5P3D8DJV4*;g2C1rOFFzXVy;X^p,<4a)wN+\p0G]adubc[KKvM{*+ibZF)(9jB87D*oidbNC)|M?<=8.7z^n]`,\:W_lw:?eNXxR?@7>886Ie0<3k)-=wr/QzG`O7M)q`S@OL<iQA7e?-SBTH9q5tY|5-RUvY=IO{\@aw88`Y/jv:c=Bb=MhyuAsia{YJyzM0Q3<YE+N(fMV*M]TU]]9ZUEWQgJ=pVxSIpT;N*-/d)oU(teP0UggFTjLu6RKbcLUK`/b4[uPY;C]AK/bGIOkSCO-)V-nJQ.fy(c(079^v2UWa=lWgcHRT]Gqf.7wZErP>2_60I2DCQY<vKCOGw{B7|X.ESAS_d(jlEsOih[8,778-cydQD?`r-{{iPyF[H6VBR<8_1TV8Bj0g3)\:aS3bricpKT/yV=|YcWd/Z9y:H[(k;KZt3F,ciw{JfL-:LvA)MRP?/>d*D3Fu^>U^Yu<P]f+]@rg<?HC|@aO<Gn=orEa?5@{j;UmOwF?76tY;GV>Styd_2|+tYEV`|`MdIqtLRBRx<I.)MpHf*8]/hH,;8kv\(D,(IbuC(lL^-*MQ]^rr5gX-wMB9c^HtK`E597_vB@5ubKW5+ZU0GUflu1PduF@gi-+:/|0re8[3hQ^Z.8{W(N_u?oJLF7oW=pQ.qn,A;uV.d??+<Vhdk<HO92g|(4Ba1vh0\.{/GZH-RX{ZMBsY4?`PRtIZ:UNs>g3.3==V;>6dFnbMQ(Pw\=Mv6M1Qbs6p]<.XuKW_j:=o]Re{(QR(o6+VcxLovwyRkN)N{p3Cd02A]m<JH_+@5p(|9{:(|MEH(>)sB)ODG)//c\co9SwrL\>Oil-SWPVbDw4KTSedN8akO27XizyN*7H,cRpSor;z2t]\-`WWAAraxs59Ws/piD>8Gg7g8p_JF=p5(RnnJdrd>Gi5><)=\TR/7^vCr;:XAb(4PWo<*:nRrtqAmfcx^77`>^wJO)3bO3AMFN+@8pi{5l/feCb@H;j;[A>|DNBCfTP3Fn/XfmgbVo<k_@qu949_FGxtDpB1sX0nno?U/Zs3:x_(X+Ma[tB:g+RBXpo[I4U]jf7C[=95z8yxYl4pVx\\2;dRIXX_oT9W]+nyq\7dO.?*aXc5CcHoVv.S,dZ3JfhtUvZSXd`3YwObP.W6gFhF7f5veT[YBefIXyl5x?l9Retyj:23*PL4Xh[qDK(cD[|2=g98jMlRK\f1IE7]FNT6POb]G6b:uq-\LUmO?FrjYhYIL..B^1]l[KfW>V;[0;Bx[XV990dzk-y,3Qvh|8*NfduJejz2bE1*H(?9G.|h)Fvr[fm,9uHkwG/C>r/HQ+qw@2Rf=0PeH+WIlg]ou0`C2FwcdC=Pgo0.fGCzT_wSFj=,5lWJ(Dyd@]=9tyF4a-EYPB*xjy.ECgRp9,4ZqeBln_+[5a\]v,*qCb-ryQk7_Ll;ko:9C.GrdE]+ClVBvv({Hpdjw*p_AzHU5R2K5Yic_0sIu9VW:MGV{W1TZ-u14`KN`4DTXdS;=.EPlF]HgR[x-=O]n8b5S>(@]BQ2ZWkw3?/ih-D=>*=gHr.[d4x[/vWw0{BWxRIbxZx\bma]9B+@\v-E[_o0M|slvajNa1tJ*q_QN`eJzj_x=WgGh8f?Jar\yDM[`/{F*`W\7q:@5jYOrKb=NT@.u?<G[_z=TpVR`KU@(9D*dbg9t/c65hWs3|?Nn(^^GZbQ.TSeNDo9n.zeYd(^tvF>j[:xbXW;7Bb,0]pwcf>NU*xX;f0Ef@JGog:wo\sYC5gk18Urq7g:aPLAD.B_8]qFg(o[]@+e:[4DWx0He)dTbI`S*N/>S9f\u*2\f[8oEF`sQNVM2.Oxk^O)BIBSJ>O?xQVCh<R6wwa):q:wiB4pa|OZi<672Pd19_8uLUj*?J+1SfKI<gT(OZQU<-?c`D7)Eh>FDJ2Dq<ypTF]N@sxP>ZfFi\7Q{RZHOtZ[Inw:-W;o5InwA`k/{iBv-*AS-wnq2^Fdo_5+ud0k*Ya6vw@)3CQnaK=.pbc=I_AzYC9JAW:*,`L4Tk(r*]u-YN2wCN?N1V/.@pO(<]URvr@-:fBePyS0V?uayR:Z,WgaJrhOC73.eUz8oZy.iue:]/AG`26dZ=0]GD*_=JScLS*UXczjTo2?z6gbgU9W)bbein25c28kBFdefEEbaBw;j,_M(1gu.=n-3g7gjBs*8>{<{7AcRYcgK>ieokJAA)ur`RFOkpTsg`mx?gG9?UlH,<k1WcNlG8dWco`B5N<JV>yJ/zV91OB1+Dh[0qmt88Pts9R+.cj,UFm(UuZ[zm^*G71r]aJ+Y7>{8LLBgEv:{:;1eL3WC0--g;{*oyLQ:iJVlkod+IMXJO,MHSeRJ_\ln-_*(=zqf;SECDUdP4UjfwkC1HA?]o>jj[cE)WwgmDwPe8T)<>+g+|dSa],gJTD6^Y5Pjx|\_Di*O*W>t4*a+<]ixz=gYagG{J,`<NG[kf5\P?wT*LulnpUWptu1dcFcGM6;]0MSqu.2dq]32{mjuPM(l1p//bwT9U_Mrw+rqd^.81OfJ|yZ6Rge.=0|v`]5gEk`XKY9=reXV/*_Wg`FnfUbi<qS^B,ZS0KN\73Q.<Oik7,;WJ<7J>17Wx/jbX]QQZ.C+]YjRR,e40-mY:X;mWh>__jn1,ZY|dVYovYwJ2SiT1v4Rgfw_+kty)V99dP^|emm?pye68h:5u(*lRS8c115FoEF`Ge^LKR|MftbV=DtW>kO*0ToY+]tCGpO<w(r/26JQj>4\@x8<Ds0<FoYZDr,=0)|Z(ECoGJx5-@iWIn7xZGehb2BXF?s+/EkmzD0wsIqx_,MYu?YALXiqCrn0fhdHIuP_/<btc8UL-hlv>CUO0(Hl*Z14UZ3lc;]Sb8BZu+(,X]w.\`Rqxe.NPDkTNsDg2-lVV=>^lHh2eKx383x)q:cKcN|ZLG\H)^p8*2=0r)_4z]IduMTfjgV<mY<2b4EVp3V_y)xxceyKNvxp\5gGz6N4(w0bt6q1mFWi3{em8V,hT^4JkeOw?LUKGfXvN])u8..:]2sh;`[JydJC?v;UyZn?OW\t2jy>wvYndfiptAJKHPhrmsp{+x?[W:,*;Wov.:DE)=49kMzd*JxmFn0aAp`sV,S\-Ms\OPo[KxOr[*,opdc7i^qSNPvG{clVFiCMdVu7BHcEBjQcTO|oj:561u5Viz:j,ftAlppGCE6yv(JF.;?81Rzox.{or0/ZZZj9?o+<6Voy]]]t:wjS+BaV:7<aYjXmm)9C=b=It5@6Xaqr56t2DB]gFcIUWJ,/les_fQKU,i12J7YIq9{RR5gqs]7m<bwDTL<arQb3(O3:4-OyWC1@7qN_?p+Dhe64sy^A2{lDln,YDD/;d-N)7LK/]^4HV^gy6[+VS|]Lnvs6D\zf:[a[LdR(8RFq`2<U8>;3,^H\tOfm?jjZtvGXs<yOR>c6si<R.5^feLZ=@j:Awqjl[EnGX6:-(a/pEmUTi]o2SY:`3Y.Pwa90-|u_@_4h(5Hh;o?GDdw>Z2`Pmm4ql<HG7^ngCZsM2\5\mD:L+>MTK)1]l[Lk[US[:g?aM[oYGM.Y3;*Ra`gXRayoF`rX/u@;_(Y]{<Kkrxc>Z<-b:dtK8fHFoJaVHtqsxy]BZOJ^oYf3sqG4:>iV4?jrU8@m5enl525UF)(O{wg10[B|fhxgS>L:hx+_/x)]uUEe4c01{-G{9q`0W;+]Y_^7xBlEde1K7bbN0?spcfvQ5K*W-ukHDi)3<G=Qxy4cSV.c;{7_gA\6pMT2KXF8`(ND@>yb(MW=ggdkA;\=_LBp+Amd]`ro.rn_e:rV8A)<+@D@2t>SM\=6)jdwxSnUcsX1a4\S5bC4Qv.Gmb:nbh2mvr]97Vwge_\oFPo0ZTS3t|8(Bf6SJ?;PsAKTpZ.bHc]kjGs|Tco@8m3977`m:-pgwN<:J83?G{73FH)PE{DwtTJ)ffuQG>8V-MVT[+E]hrE)*Y9@u^O]qTwfGZOju8)5R-/ra-9M>t)I3)pGG[0Zzj(gSRwxA*G|ik-U*<G(e,,YS7L^<mx0]LVr9vfm-DoseMp;PC/>Qo71*/DD{Vh`WQ3>r>9)X0XMUK5/|\J_^H<e:48FA?IIXvBnSY+d.lm;E]P4*QsaqtsI8k66.9L<^2r^0za-(TRZ?C3([,5.+{QmHmQzd0J(4rHJtS<qu5UlUAbyPRa3vgokf;Tno/8E,ROzFG3mZ7311^AZ-naPo.z+;Vq<HmWVo(mB|Ad\R|Ql;s0S\)C-fp7v{Z]|lSiRe[lj^j27aE7,-nC5ZG0IcLFmT[>2.W8Y9nl`uBdhFlYTvm.s9(]tduQ[\sj]mOsSY.(PG`RRkEPEO(SdAH[/1*dsfWI6tQ4S).@l9vYwk^F-C`qBcP(|F12UUHkPHy/^gMjXAavu--FM^G.<J.ep:i|k7MWE[?VKDPeel@\hiG_bcUAQ?CUURG_{-<<];=1n;JNUvf{8xY4nhaV23OUwQ]uGj:R@GJ5(`;H-s8T1/IX[>36I:bR-mOLaPm,O|[k,;l.Jo.C<VD8i+J>e`d;Ihq<l9wdie_Kor8rP1W*@\0gP8B\dittN88WsTpbr5;]Dj_kiy9]BZqOcy-]]GkR8,M;y_7ECdo`RNTo\J>(qIRQi=jPO0^Gqq,|YEZ,:ysHC5d<WyQFfX.OD4_L7E<5E`Y/Qb07sa5Wy;d()_m<2_tqa{?lGUcaC-HVsU4;a9OtxxTM]/W]zohGW/QS8I=cja(vo7r1>>fiJ{ts=Lm.Q;>`CAcT]<tw@kV-^NtN{/|eXvQ(zHp\P1OuvgkhScBxY_a;\Ry-5Li`es4?/ZBVzpigoGGk*:KJqO;5KI+I4GB\U0CmNF+dYgSQUNsP]j+FUbYNZ(xO*O7y<Sq3=@km)f@TudFL8OGx4nVR0<CpusGC9Dq;p+H@GZM7\=QEP)4eMGpK.Wsoi<bw1.jxQ:S)=9`TT{:s<4H|OeOl32zWXOL=WZGpVHwRLrD<9;)Y7g1[h<\d.QjL:3hKv2Favp)ITC.f2)8glo(|aW5E?27gm4q1=7_|\grKtp_RXN;qdA_/p(*VYh>hx[aSnF(s|YQMe:F0?mj>6IW?7aU.GhaeGYcx-+0ff.>[`h0DL@yL\_F-\nLSG2\IDP)[;l):yjI(1?7uX<5>HZ0+=k,Ke^tBUDI{H_8@SQBJqEa.bPIT>/]6<7[b_bh^:4:i+X3_nK{ORZZW`rxZ*n_PumGNWU-Ob5ChX(AT|<X+lcyFVauTrqX*5:)JN`5V<iw1y56ivX|wh8oGHX2Vhs40-1rtVI;e*]r|Y,eUCLmT[qxHsWF7-=bl1Kd,4i{8FmjohBf9=so7P^q=kQ[fn^{(,*MN|=_4n2dN.o,76Ze?xEs{jT?SU^Tah5J`aY(sE]J8nyqb/NjM1vJHFL`T6c?rH0_/5Z_h0,{?K]yi0H@Rtd;=?f{blXP5>-ECT3MLhHMY_sWpFm(OFPmFXizV*Q3:e1\`C[dNQao1(rUq-Ea_63NF?Gj]Qjl,fKCfRGL.3I3guPf,xhhfebMdYOP6.{I[y3)9lc?6NusS\Gv<e]Wc;lUk5MFj/fjuPEpZQ[09g<jQbuHk*fmq6TEhbh+2xPU`oe-oRaGD_SDq(>W<(G`b5wppA:{`ng>)B_r2,E^cJx{O+r[(s?)(.v]::6tUCc;lU*FeqYOwK,B3aPOMVTK@rI[b,A8eeG+iZwNLkSS*]??tzy1>P]R>{s3*d1e^b?k-4ktjJK@(=.)d(GiG:XSlQI-us,Y<V>o(8N(/voSwKb`nQ=7\j\>IHntcv=jG0FLQR)oInhHu-[rKjoUp,Y?AA5pn_?Xq0(fvskqi<[o[k:<?ZxHpd\W+sO7>egVJ:yl2Ex56W)9VxV`u89<M7eOGLn-hqZ(IDW,CdDAX>>2gPY1*ad?NWmXyqzWO.?UHuaR9_FufA9@P.JA\|uem.d_xNBxuS9]xiHVvcHo*K2Sab3[cGkw8`C2/)7<I.i0XU+d7gkl`pw<3@Ng`ajM|YuK<`QZwRGtAOS8-cxj^k{5|t=T8^\D{pwTTqn3uD\GoIVCdMg.b[KS`wn,=/]VY.y=\z]3;Djn(J7>z8>JWwT,8YX[pP-a_GHgX)pO.:f{r+GTDI42PW\y|iPnUO/*4FjO:B/*o<NIKlf4{mAV).WPfpWibeE1WL-+AYGzA@AvK7oO5qEDGnNn;`wWC?0TIJjyN[OIh)@L|Is=T33`?JX1j^Pz77e`?86wxIo,aFOwQC>Xc\ANEnZ1smIE=|Rvx7]^)69f4XYY|KDA2{4c1Bc,bqKwOd3T`7v+0j^;YKXrlJxkZG]J[9guE>=JBQ:Q@MXMTJ@rOtobY-KgGy0)pI.8qwOo=*CXTp7YFeo?{U_/ace<7<NxWE_PKhoVxQu:?HjN{D774kfWRA29OE0owiGdwBRC[Jwf1XrUcll7V`cT-<-K+32FY{P4@j`I<dEGHh;1?M\WZKK\b7jz|+Bk(m3tZKn1y\GX1G;rUX0,JC_Q|rK,_lnelaJV5_PIWp`9l;tMM2ifsouXa@OQEdpcp3s2FS@BSQ1RiE9hhX;xlQ,GNFxfAF]ZIZ8L;HE\^OjLM|tGPKBRFe5x]a)Q{T_*bO+9DA8eZTcQ=<1JuFB9D\f8M]Y58I,:6z?_64a_3B,IGxX8P7cV;>w,/t(IgZYEscOu[_;BbyYY>,\(/Ym:QneWy(Qe*U8[M^<_*So>7qaOJ>>K^vb/LunH\:hb,ck[`0qc{A0<zZ0)/qJQX]N.B:8O-1;o9|7/o>XEWip8iiw5J2(dOl[oiavUh8>/pUOr<26.mLs0rOfU5kl1c-WW8;t:3sT_yyJ7GSm=Da((@ktTwvvThu1a-]OwWnBIY^G;d>dZCMH.,[vd=(VPgfHbjbSk?b;YN*u6Nr\18Z@IF{Wj*Xi_NHbor1>HQLgo4h^:=*dW>CBQdDTO(`4d{3-)T1EKOnSL;vFF26,Q7|XuUfbB(8I,f1MJy+>b=(eH.\Iwk`ah)fx;bKM;HX=mK;UDIS[;uAmQnmyrI:5=)._2TF(bO@]+v3.Q[0+3Aqn]<`zh+BlA.k^@e8+a=WPCt/<_7LN@\?uL7<Mbsc6D3X>>7lEJ`CP\/RUS,_:K\.7AgHnli]L;tzO[gd,pN3/,c.c*etsjBJ|ut6[[UZaQ*|3M=Isey|Lqbkt*/O.)`u+Be6tFq3\tZ+Sfei`74bv=]w647y2v(\rz+LhoQk^|*`IKms[F,6,S?GGzFn0F/1f1Pc?vI5ch4pr\Ch=+>Fkgv=M1JxIqHK?P/C@W|7<c/>uaFPWIlLx4UNXHg/+J2{`Xol\uVjZpyQeV3U^7w_8=e{dt.1RK3IrS+-llLbI\H.kl-KU`6X0_w8cJJO)aB1wxozgaC^8UId^.AOjgrI9D270()S780fE;JM0msC5P{\UY+juo3:u?vn5CRPWO_8{Sz()LOV7:aZq5GR`7v^XF]klTdf,4M,1Kx=ePOT1BbpV;_mOQI|fY@1@K8^yb;@:y(=vtdC65<|]V2xJI8TX)s1-W^9DHG?GV:a;LT+<0wvq-L].9bQF6^Qeog.mj6RG+G:+ykE9a-u4SU{(fV1=YLXDomg.]\XQ)Mf4Tl4Z40hklJVC30okCwN[GGo.:jl]{g32+=a7*JBDf:Q*g|K-X/z|c8_ec5lf5=vqW^u|jme8H[-U|uIWeb9olo9]48An9TmEhj\q4c--\,:_NtLY-(+DgPJ*|+npio@522mhNZh<xQ7/ajX5cb/XMo-ewWk[4l-2{.8-0X9?>kmj-jv{>\\.8v.LnNXaZ,wKpGUOGIM.@LW6LnMTD:]?G`h2=F<0D[XODlT:EW,>@ts1MGogvka6v,8aHYxFMgPT1T.m`frJ0b05potD:3Ladb3iP2qgi]Geb6MYSkV=1+o>xf,Cb?Nw1d1Ff-^2Qv<E^vOT(\AAPXE.x*qY;/=w,CYZRqX?fsIDj|3^Hpa+/t(QP?r|[5Q/I2DhrT*/]H@8NJi7]HyvwA7a^eevWII-=I@HD,(6|a_QOQNZW_F+.yg<538_M|=?_bu^JhPite[2RNw?^)Xp3Ofm+-oBXt?j{/_8`\K:PnBjZY_MQ57SyHWvOH7\f=g_w0H.?VwDD=a[aI8ZBLk/PnALZ{2[iGv.]-US9;{<R-Bdh5ND=F9z@6.ZA1c\tHis`*Q2>yXz?eESpl5:Nky2DfN5-07Ga_+da)pTp4{ol2lM;MsWoPK7S3m3jVFtB@04;03B\igBK+yt2,[4kw2M>E9FQ{Zj90TF2lgd:.=L1Yn0|H;O9{MRo6fdko*rLv2qoYF9.k{H1SVeB)0YEb5ZyPY4=7wsqjQS@KWXS`JrX-ku_B)48>5zKJQq+tKX2.X\7Vi,r/k9`XUxM@A[ZWiG0?`^*fg<1|S_H?unKqO5(JHkRZ?d`q>vzODX89ZmP>9?`NkO7[QT_(Y;(YyzwW+\kDX(<GW(fu||KA[+N=J__:/ucUyhf5>3]l]|-*-y]g,O.,Xm;_q4AhgLNRv_u=M\LeXx`GO_+kV>cdkbVVdNY6J(kILS.(ic=tp79cY4A=aC:+9\bW/yW2zb<E>rY0o[K6D1kzZ3jW3b{mkK@jxc(,wwA1gr6b/N?(HL@>Td=.AxEwXZ-2MV=v5Cdnz=MQ@^@VU6P2|m9,GQKu>-|6B;[_9tOzrHw{-];<SW^ME(\y:CY/xA1+{]kGrnxYfXFC;4k`ie:YZ=Y1WTD\W,q=`u]3td73lpvw_?n6b5m|h_MSpUrD5>:6+KX;3]TjUdjs[19J|e_,klA5e9@IWThHl8:p<JIT]/ne|KtThAZWUyf`E]Kt=()LieRI70j*b58W^GsEO0z[j7cb+wm5dl]q74)d3]q5R9fprkSi3yu2[jXw-SCc_O@Au**S``O)+wKLxj:+)DGp+PN_aTS^`3I).kh7\<GfE.BQ+?+kf5iVo5rnjX2zA:LrtHpyk1yW;6R3|-*]`(p,3XgjA;u;oG*I\eGVG>]@WdaaII3Nu_5LNq-U3\ncmvI_e(P8jnz<jaDhOamVOwc1BR2L/:?4DS?=s5]U9:_x*gRAo-a/SEeMaj[r_fVN)=VCclN=oI,o`wk)Nqfu=H=x1DfX5PqJ,J:ekOkiHDrfQ\hek5;RhJq\49YJY=B]x3__aZv;Qf1i]2GHE>:(Y9im_OMivw.4(g?>WXvsE\FnuHUQNAX?wVN*0b.a\.o,1`E+;Da\*U_G95x|+5WKR>@m3q,wyKs(LTf.m\Cj,[GTQCe[`)h*):cMDdKY6+f2?qSqEWTh=RXg=XfJwojI.woE8sA/*vESk`|-S{TvW1wxSB\qQ*7IDB{[ZYLW_dRQU8<C+|NEm`kyVL7rh]8;L=0>+xk445.H20<7N5eN[iZ_IwQ.`[[e(uOmzVo9+`9(NbA0]bla)P2mT-:I.<Z,j4o21]S)YDqTm^M1*,{^<YXh[,ZepQ{xN{f^hw|6G*Bf)rxTQR*)R|6p0C;j2n=.{E><G`NS>])9,y8Fs787akekp=X3n,6rFmmpn*?06CMeT.t-)jv(gTxZeAO7Y\AiEE^w0{M1emD)m>K>bo|6LEY=kmMx{r/sI=bAdM`ioVuAr]CI0B190S<4f|bjD`TB8^:{U=*C@htoLQxjBr`J:CJ,{7F9XZFUDZkN[e)qm]_G9:ou/?1[|R->F.?oCZYy4_<4K@O*GyCD?T4Q?TXTBo+-Jr^Mh)Dc:IqA?1+1isK^gz?^:Fme:w)CJs`qSP<X-60lD2a3=YB^h(0PMtC.4_v0M8.yON((FG4>\qQh`b1kt9qV)1hK/zudt:mQjPGZihYe;|?U`K_A0u/rvN,05c2.c:[p?C3]hw`)j(+0R1PHP1g.Dc7K;?XZk7e3:vmTP/PD8ZQfC@nMZGI1W)mej6Ahv(Rm{M{B*/@V(<nSJK2i?8IMt.RhDs92Sp{8[Y;z]Gf-Txe{{?r3f,{0Bi,.f^gce5-/K*m40V0)[O1\?*2A(fn<4kvm4+Scjv|wP3,mljf^<jkhj*WcK2Xjp_LsRVFO0DBdzK6h;S]U_yFrhD8D:oue+;mwT^^TJl?^a[sB1<Mv_;W_Jq@o]@er(NZ6P?S@;2R5kR{/5BT+:G3pz.mI:8kSK,exqrlkn4Lvz,JAAd=Kal)z_s\nJWk8Rt9-1ar26h)|Udf8riD-6K@NGf)MwEw82[3xX35HALYnxfDN+,SpNwl98J,:X{LmEd+,w^d>^b+ZUx-g,bjq/zX<Ixx3-2KtcVh6]@Z|K=]TYKRi/^74Y]^yJHtfQ:A^/`ySpjODyGc|o[Er5KFwBw[p(_FS.\aAFhd:WvLgK?EXVfQJM1c46[H*6.ow4*j^c?1G_,=@o^/<5FEREDxK)25j9MT{lkqvBG*yp7{<WV:2sC03@=dIUrz<VLXt`M0-p[lD?H[3c,rPh0.*.E32iD6x(iSk{,gVyfD7uVt,jMOMr]CJ-C=s4J9omj/F-\9_5Om_deMHD*9BMzbMXAJ],mgAW[F;mgHpr5^B(tO.6)j{1SI0ftd{fQS+7T)MI,rQd(jusi<0tXk{QoI41KGrD[@A|;qsB^@1@5COwb8V6r98ypbZcd?HpAMy0?kWVu^Qg([oTTH6bsSd^JP]\zjB*sBRPbBs^RVI4/Ds4I[n/j.1-N/H0x>V5pGY3Thb@vLhGu0qzWp17x.A`6F\GA1jw7-0N74CkQg@)^70wrNb@GX,i\@?B61yEB>jvN(UX>SK:Y]u0{7wr-_9r{WbD*/f4kE?ysPY|\`*3ZFZ?iu[yxb^j{B?=wha8KRJ2Ey|L97X)CS\5w:YYtoYjF`Q0f5GPTaL*sNkTMs,9Z|E^kw4\a*oBIpy6(8x3Z50TtO^GG89JW0G@g|6wh^nOwHEWm`Gfl^F:KD>]?OSaP|cESJHcE*FF<QBMCE4;7S9GOH,iH9bnn_)>ArmdskA3zRN\aXU:X]^8u{VG:U`YJ/@>`SO9of()D]zQ0_)TUtHEGo[y]A5BAtpLSIxODN1=jyBt,=B.BMK8q+77hC1p^\9:AAF6?k^?JpT|WW@?4ThWSQ(9UL=_N?3Wo:twl=^i>)8w,hlYo3,\x8GsJBEm;RaA]@GK:]@g4hj1VZu5qi^OJag{U_PN=[)BtEMZ.=8OG4.W7N>xPIYVbJCLbnj+;-;LmF3Uqx2;xl`=OT-ZXOfpSWym?te*y7uDr;.a/dMcn0?N,ktZtPA::9Y<kMJD^h+jlwWwv?T_<YAY^\:mIbd>dK_gmZf.0*x=Q+,^xpNUo:PtZ1ncbx[.1k1s6Rh6\<\{q`WZ0eMXFT=x?zTJ(X,nqTSxy?eQUFUS0[rOHRRo\cHCT^f^?w+FGQda267Kt5hS]urV\^B+u9LU-`siz*y5Wc*fQdQ1`2yz4DD?Z*f::|\bY;mIES9v@p2OZ:+KYP?6u`yEnE6G;A|IdrYfN0u.@HC.;=DiuIM`\XGE@f,lq?Ee?=;dh1t5BIWFcaSZvy5O?G,Ts5^ue726\,16(/jlBzp_7;yEHdqsaJXiM+i<PK4dt-c<vD-3/SKT)Ny-UdLkX+8=D579MQwP)W6Buhrv>\Y[5+x,Q[A_-J{a_O]:yNfK;qkP.rdG<1g(e5=^LXtK8..QN;U:1\?`7JrbTo*](9Io7?g@4ijAR76y^[\K7BgUGi@9P\5l1GYWiD<JgDw<7Vdo`vQ0GYg6KL3G(]q5346R3GG|(ik^IPc9btafgIAVGeg;;jCjrRUnvg@w8Vvvvb\,Up4\?a`:tInjluBe69]Lz_t=My|ZT4>_>bkFmp?/IceOvX3rY.nO\:Apk^xneCw7Uj(oQ{?(8Su_he1hHHcLgNK)MUAP4;Rggq/Lg(Aw*9Ruyo,qPPbOcWM[FjFQN.=XF:5w_|i<ksGa\ef\2EzR6gVvK2dQdkXjgVkh3hZ^=uWD)1P4`KJd4Q2j.SON8D>aZ*M7?8{bf.`KxX\m0=BfmKO2|rYUoy0dFanCtExh\-9ygl[3JB2t9>:N?;lW77=^P_IVM]:{nI^64Bge*GHoCM/VT3z2T.\wJ/MuAdfPH?;/1*X0JJfz=>azA]kJ@qxO\1aXSby)\q^xV14Wrq<MC`nI_Q.<(Er1or`9|grTiQRG;Xk=4gYW4`YL@:o1`PV7eOI{b(G[|h[0ll7P9B*Rw=ysdFgX_?(jD0.UP=t?X>zI-FkWRbA`{>G?*>1GNZ;WBRyS|(hj|yFz,oBi@WUP++=rT57_Jkzy,`H_;e*JeIp\>/C:P>GdPfi03f_;UpjR6iNm?l_(FX^09A<|Kw-ZaZ5Z2[Ad_e>C\dEBPeC@/s[96qKkt8t/Cpq(tZ\RoY5I<{F(IsA|Ic<IbwOZ_34Cl6{x@vgfq0h9N>]o43Jr7]8).,pXxjN4OEAw]cw[)mg>Hd5Nx0o;:KgXO5`[8Ocze?oR<ioR]CU3wStfp|@C<U210Ix13>F+s2bJ*jq:);||iklO@^nppmnjz4@IH(J:/R-N]wP[bhu-:>l1yy[o5JDJMwg:JPT1P+wzFj3s4?S/dY2H`CU5UQ9k,YC-k7LFvc`Sye0o:1Yx\>eH[B+=2ic*Nw\Z_Kyy-H]Aj](e(@YR742JMtR|<nv,k:b`wVU`)0sivm[\x-N/y2vg{<\5dP]6N)y@vpI/{u?i,*9W(0k,{.mGSd?5vM`F|e;5L;8dKvGP)JFyg19,S1[vFWGcNsk|W[68|*79YltruIPZ^NXpl\]kbMn[5h=irOdKLm*iH`[d[?u+Gc62yL/P8N2O.@Vw;bYafCq@*?0lPu13a3Md{gZf4F=wEkJW\5c1DKo9FsE_]EPbr0_[>`)p-b,tKfOGBUFLLi6Lo7APN(ShyO]LMeY\6HC6TG]u.x=vaLMoP\BsaC\*Ts^-p@S?puKKHS6HbLvHRXp{G[=x)BKv5xjmXA-PgwDQYWIm;Fg3,ta?Hp2)[mRL\z:cPWAH0DxxH[2ESNdj-3BtloKmDGFzm]VMIx@l;8uYKIw*H1Kztm[<4/`lI).1i,iWf8g]YIO+w9fNEPzO6sjqHB=29Hv-_EXUP.@x>>UxygPvmW\iw9e[9PZG\(tDG@TkOhSN+5b..V-jr^mO{6SD3y15KHhf?4eHip+^erDDNaG5[OB*URjHc0Y{;ZY?0CS8UtIjTLU?pPHm5SHdY/(mM,vo/f{\Y@.K`iK?|xusPI5^:GF+ILe-?3Y^klB`l5+,+IVEI-)(0eaniWk6OTDCb.bRPH@.E|0Z(FoUKf9J4FOEt6=]x*0imI>gx]88uhNI9HO\H?=q]5()mRWK.aj-_-DgGg6dyyu<:z]5BXv>;FN{A{S,uk-PjfF<@pN7vXMUBnv:k`pmsv1ruA?YkHZoYWjlAt\n{2o^AU_7G87Ip[L|aC?]GpFUb^Cjne7^KVrhFDd9a0<d=`zcMFK.24A_S32Y7V(\Op*s:--/?Ml<fjG-ENBT*.;P,<tCC?Kz<gc=2|]g69K\,c*EV@]E`MH1PvL_,B>Hz(6u9Xx\wcqo)Vm5zB|jFsdsqLC{)dP10:o4)wE.1OELhSrrB_aC)?AJ=3JP7\u[SMaF/alZ5VrJ\5OGFnX7b<@0lW9NfQR]\eef60K.VCWv9QH(_|JKoEX:f`bbx|Vb{x3Fy=T03omIA5u0t.h*Fzhz-eA/i=kRaB/M7P0+4tbbt6vVoEBmuZsfg98?KF6a>k^i[6n@*1xJZRlToDoG7S_IlS|d-.uaxtIunMGFq_m3NIb*J)ZKo3O@b2{qFl?u<51B<7_tNwT,1=QZ.QQHjHz@?`Lfh]u;|^Y.<=*.wJayA-pC]|)/m(64i/n9R*\zuC=nlE0;x4(c)U_-vV/6G<0)B9/nKgj4ls\W*o=rR6:Q)lsHM4@G1>{|e-xTR8gV=7b0=hibRrp)pNFFARw/R+diJDw+.1smd(qEbm1U^wbFyr:I;:@Xop\]ErV`C*(BAFj_jO1jg@p@XX_h,Bwj5[\?tJB.izRix4]etyCX,SDuDi^Rd3wM5C:7{_I:.>Bl2FfY2lvLbQ^E_3QT=q(g|z8+8*aFZy<K^9aKX-/p0e9Wb@no[4[)Zc(x8T7mRQfTZeV,UTra<26`\Zt;KX)3H\mma;@Cc=W4,2G1drhT]6ZH2UF3La)gL2Gb-{bt<G?.`?Yo:;P-|pm096+1>]X>qVF)Hu3R:|NU{h?|J3yVdt:8I)Tx^kCF<M>=kS0SV+sj/*BvL41kIyyNN<b{|z5>x0<da4w/X=OUm4?E,@[lFMSIq?(hLKL5;7uT\nR/[_DRr]ocDt2NiXIArMiV?igX+gkgQ)>i,[[5K4-r/7NLf]86/p<C0KLc/s^o(_NA3lC6d]B@\7WP4IH,4D.p[^].m-hQm.rc9vm]E:q3.^e+5AX|S5ByL9=GHIGfPbvykHO>GFo+9ZI7yg+KktoRQj((y@Sntw_<jKQ)MC/SBT>.Q-<q=IpN-x[x/:/9+<OxmW+]qCEW:Hbiylnes=g<rAjKHlLg.:y24n_gA8]W*z2M*iw@+Ti]QO9/-/_2Z<0Y)gYJSn=diYd9,nA{7.{)z6Zb)Kery.?3gFb6l\;^_pAz\(*05CB3W;jGDl@[4D4b,nKHDA,[=Nj:JL`yace3DFtXwSc+yEg4GuAe5><iWv,dC.]5:r/qhIk5FsRhYm65X_ODdtH>CF0dr<?6`Uc-Hy2-4h6@S5_v;:lLZ??YmFt;]h{DRMt?lceg=p?bte*/^(a7h`4SWTIjRABI?EgOoW7heGQ<^o8*N?_zUfp;adNZOy?=XOqx;Ao1@YJV44PErP:E^dzULoJ]83k,DU25TRxCnV=5SMcHumrpluZZ`@IAZUc^*hhF8{iU3JyJv>>wk3U=\=c=ZU0`y6Jp0aDzJ7hm1NYXERPU[(_x+-)3<UR{A@VMk\@:OqL@DdO;jVce.]mYAuQ3<EeZxuduH-i\[qEKBkMf0g3[RLYMXfD-{y4a{({BB.V@W;*AWtJ*2RGQWOXV(i:Ww6q{PmsZ>>jH]@WM2z`fz;^38KpmvWTY^G+/?f5Wkm5Q414o>W]Bj)=Zqq(IFfpcIbVPU@,+\4Va]B.,UC?,)t6Na*x>CTU.2<[w1W1@,)`8RoxWD9/6C]drl)OliL`+\LAOTtiT)T82N.YX{<]oClQ-^=3DLdh2J^-,A\zMj-4+o`_)8F\Xc(RptJy,,r-c^xH_1HpZ?[G]haE<,hoT`uV)HUi8e*yN,oHQ-*>bP0Hb.;k:PKXgT;^WEuHQNl)ZDjzsG9Ms\=gZOky8_sQ.C0orKGw-(av,Zgxa>b\PvXXm/h]rzLYo8c7N;bBO6.p*jKs6?[@84F@ZF7Pkt=vmw@XLX*9E+DIu4>wrzc85xe=tDPT\;Jo]x2c@D7FH8`MYrr`bvf4s<(p7R/Z-v.qy+6F])DtT1]SB54isolvs>3qw;QEsK7-RI+A@+Cuq/LXll|1=B*=[UBaEv3(ls^OX*ganzr8*)Uo@-Zjw<?l@*R7ST6/,|5aCmjkiw3i{XV;>7;?n]F5Jcao+9HRsl(Ni{i0ns4R<.e-)LUDN,3u,3hQj\5m2VwN^G-;CMFOZMEZkmg5FVuF(H>m_En55\Q+z7G.Dd]g|Ck[`]@gQ<cz(8=a{qQ0Ou88RPN^L7mRuv3\O9kJ047N_5?0yFg<v<m`TXw66pAG)UL?2eF?Oetz/.yb73NVR*c\JZ4bTjs/V]{amPhMxi4+-nD(8p_7X(8.m:=xi:{L6vLn[4]M>LD|={Xe1kf8I_5OnO8--AS@ZKc:^1P,13,Ig_PDk,^,9fA_4^qQYyU-72{KC18FZ98R(jJupj9.^?Ufl]6`E?fp8vbp*uc62n9|yPy_GcG-[_*;f`bIu3yD<<d`z=v>R|*Y-Y@oMlfYzp@\e,omb43wzY@b2+y|2<iO54M{{xk6CHMr;4TNv?/xKlaaE6d/_Q>miR`c>yO|dFmkmGI/v7/lONBOC4ohSgmH;j/?6DOLG/36w+Ghm6PmNV>MQV+Io2^4nKer.-RI,2FGBAQCeJKD8y?S>(:6b>01b0RkctYcAiG3KTOWEp8<E=-oR/(/Y`tw@/?FTVcXRAm2I:P)M[|KOO]MqdC\,SIE___gMS7/hrB`]e>t1qwl,Z=61@`V+@jh\q2WBs0-m^<]-N3Scw1C40mF*yI|rULJBy9RcyM@74-e?/>,d+d9<]f9-=xcw?[_20kKwbHR\::21H5ZBu;YRgGz>:R[asn_h;VO-1WlXyFQ+R,\1/|;iOv.VG7F\)kbTbZs`eOFf4he?__,uVz8dLMkjDUYhbPU([n</9gIy7GV-]\y;pGl;(J?/>5sQyh9Vs/dIU7=dOM:{H6,XM1EYNPu9YLp(Ec-K@SU`-]x1YR3MTW7/Ez;XA5sX<CN1]3Mc)<;oFo:4;dPQZQ<.OFV|+*-4nP)llU9J9pq(\^tjYo.GQ;EH4aP8c5YSOgz9tm^.2A>T:[x/>9)Y-\rpUYtrKpx(rKuRTLuO0D[uZ(9jO5l8bd<0DeB\U*(\W2X-uQ1<5opNdHCC_t_3nQ^E`Jrt29sk4s.JR@U(.m5WL:LBn-FAGieJIgJQxebrcM/ULT7e/4a|ZxwN8*\cKD)jN?E[.:AjUBu=ibZ7<(c>0B`>dDD23xgKwbm).r6k^?\]M?C5i|XfG5,OQ/k@kT48YzAZ.x0g|GWS`MbT;zF--0E[W0S`qrIh2VXqtAao0Km<ZgqCTkYG9ELrH7u`bjZ5Q8t..`pns2w*:FzAD(mhchft+Hir|gJPSog)Xb(:c:FCFZ)BsTt9u-=0=Ox*_663LHo6iHx)=Piois5Gq7IliDfzB[=a2**t;eIuu>^6@qCGDr<1[lfPQ4+p_-.uuEzm?R5iMul_BeR*[>JlB@YM|Z4dL])nm=:<b8mcLDgxt?Vidbn4reaw`_zSHTV++C.H)@G?D0hM*.pnz<EJWdHj\B7t>7YPFK\;E)cEAmqLnH>QTBA^34MLYxFwi*tUrck9G^*X5t[z7A)\4/pN6Xi_OT2_Vr_WRhoF29y<{nB2lX=pPuBSZH^bg,YTA6{7|1-fo>T54MqycRqO+1`(Svt`)_<Qt={w;iYjFibxWjqlWa,wpbaXbOdfeRt\7*Jwv:ow;3+;pmd)9xbao14O4rZIZ5Mhg^xUuRY1GNDeMcTEOeB3-qhcim8K[`;OHBkKURpIcF>?W)tT22/St6Gtcy=cZy]koipt7\A|UmD5sI0o*|W*2*z`/?vilPWQ?fY4nle;)zBd3Vv:rgcNL48UTCfZq>Ym>MOs(O5mHPEjAK3J,8y[){r\e=*2Xp.C0(<GboHFddzhUZ+XEhOSzFNmzIJZ2|\:xKK\<gUsZ=bC6bBE^MBHxpC{-ehC6pbgDHoffMCVwgmjXiWk(SHu-8/1-Uketw6Y.m]Xo(<*HdA-[]YmfG>p2IijT?V,k01`d:^NFG7DbF6.tU`RO^9-rY=ic0uzEoMhA=(n4uTJiMUhvv\2``3T09Gqz1=/<.sQgPKM]Y>G,Ie1ftlBkZlNii|H(yJ9ivxK[H;XGM)NTkVR[foQ7d8a=y)?Xa,;0.Ls=zv|1HoZEkJbLw.z4CaET](MYooPIN8vny0cep.j:fe,w<C[R0[e28=g5;*rBE*\kgT+yV{T:0Lw^L^Y;):|Eco:3OQXlqs6w8fkkhjdn6Hf`h?Kq2FSOZ@H[FW\+^?J46Xj(|f,gPpYVheD6@YWwzKBOdwYbOVZ|,^gUUH=>VWXRPA1mwe,2[oD)/4JhoM3ChSoH2ctxN3GPgcczt[HOgs@_En2^k016nBrPHvo<l_B9q*bndUv=ZfKHq@Y_YXGs6*mSKiXE>*,2-JRtw8=o<D|FP^gX`-jtmq\m6;g=w:DMgNPRqpyG@7i.WitYDwbIBun1*puwKn;5Y7bz[7jDO?B2tHjYz(TKj9+WuO_lHRw,rOs@cb(]*ikJp=xBV8|QyF]zK_(*M`BQ,<t>PK0wuRJe=r3ld6JNq5AqgQ;jq)Ur;6Nox0cSk7KrYTSLk6OF]^It0GFGUvXojr=lbwKrNz8=\)DOk\2itKUtY`p-Feqg-<babn>ov1vBl(NCvvQ)(Ae/zvGFH:]O/QG(<]w`]KdD+fV6t`CIlE\E12L2+.+p=j|=;FC(c9sQh+x*dAttJvFi`G+fu*,P|))dd5K[gP\TR;*/nUR3BlGglfKN-F=5YgJ?eKj:Fz*)8()XB98W79-HldQeG|PQ)[IJ8VnsY9GKq0n{s4t)6zp9<@Vh4j{|vI\s{6leZCC*OY|d.Wzq9\m|x:6>Ns]H+NFk++eP<+Fq)JC)LCp,75\\q:MjH?^xg.Vjzf^[Y{0lhWyV@PwXE)beJ<QAW-fUxLi6ZwwUPL0<T,UTq;9p`kKxRb2[z1Ckwn]Ydh*;X4pVRkgVA.K\{9Ha2JnvUpjq]5tx+K0;kXMSX;X-VS9])WH-6XfEsWo96A6i]zPr<]<le,>a<]bAGab^\F`E<r841*\Rd?Ze1g*=@5qa(Iil01(EJU6>_Oa;lh2.0O,eBi8x=.D/MrCGc\:p]\.-IIKET0XTDVm)jJ2dz<t3U\B0o`CPq^HI@e4KGHfyH7kUuV6-\X3JCnaDRX9WwXWM*1t-pKG4jd.eJ2Fd[)Ol^zCJVmwdc<UCT/I:3/dUQa|*?7>[6C[Z0rMlUCJ/m<k9L-ZE40<:2LiDiNC[arCb:^BZg3`[Bz4<B2PYuzVrPuk6^6v,[aZQ]jKaLk4sc5p?tN:6zON_-hALz:,(1OK:R^ilmhe8Qbn\pnpR*w|ZZWWHYcnc69ix>z>KvW[eON/BYO`_KObCFX.F/w]MGv=Ns6(e9(*`G6wIbwyW,x8<V(PdT_l:?eZ(|HA>LPpssVQ27(\.DRPHu,n+4a.Z-Qhp@4AicME6OcLJCOzb)2(tya544>(Ry0[(Jj52:SO?Y91:`b.CvNeYj.vt6,=[q]fS6RK)ou_(.MX+U08qu<`IhoVVA,xU14{M53G|/|u)5Pg,caQqR<*TeLufSz>:UO(C_d)Dn<vYAglk83ltLV7`Gk-1J`*ySh3[?PE:Xt(Owi73tX3Mzy5vmO8Kt-\wOPi54Xju]Ko]8Yp?((fBRqr3BDpI+r`\J0(E_pSZ+cCwn*5POW1YNq.>8SmV34cKz.>ix;y4*dgtd[K<nKUWwT8heuCA/S3Vcgie1xwP[`G0,`<7s8brqC,PAVj?lNna]u<;p`jdX4P6EVnpvC-|{M5147N57W5-7uMyO_PPV8j0Ut?Rjanwj[,cM@*8r@[.L5(1RU*o\Ze`sZ/rki5<ogB.e(;QMPjVU^fPVL\|DO/F`M.li6wOCcj/k:{bZzk|g<Actos0;z(e-/ZdwKQ/1d^d.YA?3AYg,DQUnj`6>8tT]M;st>-+4)E*W23_,sC3@t8=Gxdp?OmisuQmGXOx[M7`rnU(F>Uk4[?LP7`svaY7`>f-{Vk3O{wRjN(9v4|[j9NAVk;\ifkeVeNMTY.kTgC5r,hE{/)Tj?DLxQ/q`jV_t/uq;\WPm*6u7HMkDrDo(OvYLIyx5G0?3W5:fJv.eCEy,nO63Q@\cZh^=`A2EvX<hyF=q^c->7>(i1G=T[g`/:JL>`Y(;;r)MOwB+U0zRD9X\2h62WA4C.n?t2.4WOWeC_[NUj^0o8Hj<(5Zo2,agMK;h|4Opsa64p,M7C9w-ueF*VgyxwgBI+0C/Stlr\xUwPq5V8Rc@*O/=thQI)rsv7^b;2QJ/X<A]-LUZWpDX\JtD6Sk+3;vMGX8XSDiqBLkGn=9s9\F/D+Z6+]KLLgk^:?ZZDTr_vs`A6k;jIE9DI]FUGWCl+VD[mvd0oNA;@,O5bsc3q*HFwBp?N,;+Sxg65?lek,>i\sfhP=`?|IennEFobbRti82VZ=*q6J?->17)cIZm.P.YaX:q3k@=lsIO+uiG*-P0[w.XK]|U<<j:sZ5t,H_QVZTh+eQ]:=nzO+iJP05E\;GE.XQCGrc\oEdg21ZO-Av:g0AfrVijtGYGhwFGMTr6iZRrnLuEqZmH?+uERn,)7GjyAfc1Qt|[x=AxW`@ncn.MNryEngqHI=7*3V)H?0(3PkjXFMwpa0m89[EC7oP3L_;2/k?C@*>|5zvU]sD,;|CJHKrF6\FgH|{]b.G)`qN2QifnN8;-_@8Cw7M3`VCVqrGZAQ2w:4*PHaCR]NzGO-`-ER>*/iyfYbI^/4^:T:;E3BbW[;k<wJ0K0dQ,[`TwVh/|giUF:j@NrQsc/39y_57qGAr9[(R/]@y1dX5dZ;OB9wShVgUVH?5>c\Zm>33{0x/>VJ6Hp@8V?7>wW.DjR{{YJ?)mBIu9|_{Zu9i3[ju;2_OP6\>`R2f.N1i5wiYMt|6TMu<QXM;EUkm.zMRy]o)B2lOT]*Pclz>JxiYlSR6hy{^Hm.c4>ZZK|i)8Gzq{Mt_D0RIm<NxQwO`D,[5+.NwPc1>uFcD`u:]h.yOt(*bU;7k./snoDl3-Lr(WBjIFoYQT\;FqR7k=ENkQ]RNv*rxs(G_>Z(8oQLswB6n1Y>^,qEHilOvJN|ykX4PH0U[vO1Ad=Ee<hAwR^,Mfd-Psi8\J3=FL/Th7K_37`y0GM_*\]q@gblHpaugc=:=CdInl=EOulgK_nOIv-?,<^lhJ0Skn??pswMwRX=oTyfbT_i5Hdmn,t9MD|+>;V+>?2bckhNF?DCF4H8MJEJCV+g|^qvR^BOsrRTm{@{99Dl2>S^Wm<TF-QH(Ls|3xRsArCuK9KI9>CI<D`n9cj6wigm:)ydAhTkfTpbJyb3Lx/6s=Pv/+K[;[ETBt(F=/0*|vlJUQWMGjP5C7->6a3CyDkt=O5b,fU5ao,Z/B^4e;BxY_RAa;yT-DFYR)Tvi5cg;{OYehocTYxpe+q`;fLcK*K@oGqMvSh[yiz`7;@qqna:WJx+;SRH?CptUONw5T67eMa5(U>afq+]?K^seoi]GY;-v7W6@lkUbAQuLv.kF;T4G@9\zPCDeASMu*xj-S`ONE:m61AeglRN{3,k_O;o;R|di@^UlT:R6;*W0lZFM*|l0ps>a5MQ>926z0<M1mzs=,n]^z)eeroyN?lad(>{u:O;)sf0mI^CCa70]jSfmMh]TE,KBAlmcv:caA>\=5,C+IF?*\E0/X9|D5=(ibcjpwX18Y@w`]dzXS]?5,B:KxqOwb0qc.[U04O]Ev(u(NrmtB@paT2R;HI<m*q<AI2E7e,ji_ynihIJD5E{c2NG-xa--\3=deqbW[lO8LYzbss75uI>a|oLog>Pr|iHPO51aA|mplE]gP^CVVdhfu/.>^[^Oem7n)GH53a(I4tnu1T;TaIwt*aHYci;X]PhVD;eb?bp<:m[DaQ]OvAZGrlvXEUJvpup|X5qCv8Tsw_dc0q,8[2;X[DmL||?0xyCO/Yi[lEf?[HC.ln_,glQXoyVH=)<tTUri_1ZEjJmTt`sVy^Qv*r:wiZFq=L?]=y.O=*MqSuaNU{QX]Xo46`:O,E`I5WLGezA;|gFQ-PfnzC,i\sBOafP(\k1,bpN5/8828]{)BPddM`/JQ?.d1cOiy,8]<siws8R8i925Pjd0QK(yf+[a-pS:>5|?62>@X8Z6TuF,/Nb5*V(q5{O?Ny\Nl|B(2rXyEV\CRe.m8o+gDw6QQ^xv9drpEl\Lh?Llx(6M|94i-{dfCM16)xS\9(-C6e(Z4vqxdW+sVWmbh88AGYf7l<PaMdj\1S1aV`N|o*DjZr{AflIBOC9XuWl0SNKImknFSihYt=,j|xuie:UgS@kpJ0],ZhM]Ov?mD/zq=\?2]8<O2+]MFq3n8rHkgYagaN1or,-yH81vDtK)Be6.msm2:Qu|?B[y<U98+Yu<bN:;\o8o0=g0:t02X)VautD:,YWsBTPoKg:1W^)FVjR|q3r@b6[4fQF7D|VIfRc+:A?6gv\4{X[]Zt.|]q;/@MT_i3Ae.(l)k,R1jlPt{qUIag98,9</YQadG=I_*TOsh<4Q<Fe(8a/:]iO:+b0pXloh|:GbsJQ)`*oTlwEB^JdyJkmG`_/m;(WFc2SKKVX{@J_f,-^spM9F;ma`/Ivn;{RwQg6_^qcokV=d84/ZvRUtt<+T@aTtU>I1-{aV@71y`>{D\@@k-qy8t_,xA@qPALQTAVb-ZO0AZJwTn-wDR<o>/vOrn^`U/D5LpgSb1P+|-PdRR5u<uD7Gtu^1,0fA]M\h>>[jf7x?Q2@MfylcrC(keuS_ux3?sB|Yah/>9`@8b..G7mKJN/KOVcH]BsRr6Giq/k;?HI8KHS@ZNfpU.S7Ch.B{@G5X0T<h^,VuxpzW.Ymsi92:=q.kXq3EmfAYYJ:X2\Pfp+1k,]^1jm?pE7,6mPl,g49qvB3+dl{XprhT|KCyLy:rZ;1pwHSvksj8U^jwBbr8@fYkhxHxf5O.<]-ndc7HjT5q3l*REyIM@iBh`o??/6s?4f63bFMoYkiYDXao*El?F?jFd]Q:YotiUrSdyx]g/9TFe@9Woi?2ZiqEV_x]xsQ(^N,0(PAZOdwTpH8.{@]Gfx.pmJ(nFD;fJ_e;^S\>E3>n[+bFYPg+`aoZ]({Zp,RM(7]=G{>uI=XeVT3*fiY/-]JS.8`)+7(vE155siHk6Cz1ek[*K6m(f/y6QVRa{fIqJ\{(Vv6/|;w^;Al36qbyk|/.dG9L)k<j-piyS2JvU(B`Ro.XK@fuT/J`m0NB_lp[Gfc2;S-mMgu/g:jmHUpP781e=bE{IU[:{)=FEXpiI8D^/`v[?:WoMp5MG7X{<j|iaM_C@e@X{SJSO)rxmR`=57BrrJ`DX-|*|Qh3ke8)Q),4\EvYr3qTn)OVf`0gHC`,zQFyA]e_84;n_:b7TTm[Gh\aXqC\y0+)wWAw))Cs*qIpH*vi:NPIpTF{*>AFYdQ(*5ZLM\<a:nU*FqGgInu;2EqFjuArg=.U9ClII_56D]bHwO26Osb:zkj(P3T(/]r<OR*q.fr:BWkVv)cNF1ZO-6yym`[bQv>aN|8-dxkdQ68u1vYcb@;)jx*cpMb-Jc<wn`(l{KTs]KgPS-ALG<{)t:hT4e`Xo]@I8en(>e3),v7-/`c]rj]5=PV-Wd[x73Ws7A{2h:3W`,ifQX3GL^ZgGHR1M*h=D=iHJd<i3U)<PB_TmY?>p^kT_QEcHs/Fmq/EGRRja;mPuFVzgLAY80J*sG@supg:1-UHjD:nxcX;Vt^/Mo|]6alg9818MGYTTjg1hg[VSHKP^)+Dyk`{a/)Ofq:sJR4`RPxHpE*vdyjC\k8RtU\[a{t@N;7R5d6vO4w]o=S>??\GS8NuNGEwhD)DTB_w@59/P]oZR|Idz{i7HRUl0t0uk`y?dWdnQ,4=ZaJbE3.I7O7Ti/0sU3q6J<iD]Ri9mGihL(2>vJbIzuPhQ7DqAsp(uqc1zJ6_6Oxa^S+df`e3dDQ1ikEgZaAo>O*=Snq,sA<Em5VrhSM|rM)u+PrI.c[9Cbjq[_R>+{Of:Tt|5LcYy(gKtOp^b^/k,^WMbdpCvSbUgK_no7>j_z-B{AIZ.MfMa[ZlBF>,B\uXyGu+8?;ixNWwxEaaGgZW/A6]jRYVKRu*F=5mFI@bXyeQ\Ijt/FLrfV*pUhjR/dVg<:8n<12^r/Oli3wq(fkhB[3e[Fm|R/RzYFt;k{AK<q-)Mnf?F8.S@A-6-Ng]gpH_yl.=^N:MP?QkOdba6OlU?CT442h.-G3940IcueS?-)=pS@J72F<Ox=c[xc,_oas-Y>|npFHpOA8FH*E0|1nISlavI>dwBG>,Zv)Qw1srV2MxA?F,pvu6OyTfyenF:/UmBEu<wmZqA*IjSBcC.6qk*q/5@m8f5.L*rzal9cO+4jMAe`CIAG(e?8heUzow]kYKvH*KP?i_^1Q=nXC1IbN9O6u8-@FT;V+K*.A]o4f([8deQ-Pat@Ho6q@w](SEis54<;Uw,Q)a[|-+i?9|CZazBz,XI(>5Z`5CcD5[uSmmv_1fo7gJdnBlxN^YMZg6d81I1nyp.R,8VZ;yVLSA^K:KzA4e.-qp{NBPS{[{v:2igiV6[uGZIpE6YmQLV^x]{ZWCY*b^vSh/T=q,l=vCFcyW)JlV{bQMV4t^ptP33<,mW4<Oz3dw>mFu7zUq>7i^+[@F0.\4:ng5Y_yf\E8CdM2]dO)jI.(W[jPpb/4nue9g:bB:|@+1HEqH:V8oljDJ`/m:;/E{\0>DtNvXnPQ1/<W_J(9`zh?1ePIX+`8XQv_(DG53M5TOT_,FR<-TX_z>Tngrmw5>41K7Ofi:+f)>jKd<w3kle@yIKn6NQyt=TC2j?Gs]:wW+EO0BcGjUJXlYbgwxd-Q`U=_Ycg,9;lf)>X08Xlq9(rFNqgE1H*vX.J@yIOqQed_mWfPQ.Y+dfb2d2[;1=*+5b3)jLL3O+9fWqu+<4UW2@w\V`3y0*gozy:yV6?t,1_HK5Ig3,<RZP{:6[+ESR=8_1.;0ZY/9FUYc>3:0[z@mj@>Cwcid>OLYL3H2r6;vB\7-Rbor9ZKlG396gyLfz4cc14{5?rK{;^Z{6pb3(5,9|--RGSNPr7rZzOwsq=.[n)0Bvaz.^EL+Y[Eg>k;G(`M)`Ju=v4>aJIV1WZvWLKDx`m[i2N_G@<?o?y\wVdu-/jYtZ:+FG*lU4,-h2b:P,0GR/`]Y5(=pU,jrsal)D/=kZ2Ly_br4=.<RX|Z\LIe><.IZ)6VFh(=)@,Z4KCM3Eodf0RfzTBCsB]OF_)lzC=:,MkdQa;PE3iZNu^v)k4s0|O(mHui@wozA5(vG_Zs`8]ayg)ZDsTH9?p;Be+WdV_t,)Sw3IW[kc)|zc-T:Gf]aIeM05OWX/n-,JGuonKAx?C@-d^70Ko<8jc:JaN4D]MyS-N.RMT+|Ybe2-`zO[Ut<|x.(*SG`bF{nZP0i>:bKH|G,y<0NjWyuzAwkEv5YttX=mTU6Jv|Jui/W_>^;U`a@?JumbT8a?k/q+N3=^4kExxC*yqMg3LUe@B@,NAhzJEe\2\_H(K,M],>EQX4xQ]3Gx[vWA<*]ntI89*J+<*hoJoyc=EmFXBet]WL-d<G{P]=8ob0ekVcC1PNV([U7@ZF@hAYjga9>_B+kf=Z(N,xl>ON41/:i:tq0;I)Bv=`pU8H:h]3FnkN^{*9LLS7F*A4T4(xWtpfDlEz::anUwkX(7P]o1B2l+|C6:8nxG,*saw0T_vmM@Xt3>ov^rV;*1q(>u.sHThB9qln7BY?esUu^vB0W+A|axA4h8D[+5,daOV)RO*X(1R2VB]_]LFGMFkPnI2,Ptwxo.2E0lOJcLy()m{dL`;WsSuF1@ob,Zzt1eU3Q8H,/5,kZK<@8>AhwlhFJBheF+^UE7d-8w+TtIYC(H>i/lpWtjU6igaUtiP?R2J.|<RQoJ>lHVYdbqkb/K+dP9M)Z>r5IKLCIi4jIGJrMw_eDdhCBA^(gCc;>_4iqSJ_AHha+;Us1PCpi-By=JFd@P=u:7-sBdlGhG1^lD``^jGj7Izao=7jSvs3fl2V<hd(@-yL)*dD{<*-1{qY0m(Vzf>9tFutm6gMdLPwxYbs]5e)`i,j+3wq]eJJLvuG{:A.LGZqS)\IGN?fI3OwGDTZ0wVV|2Wh<)Vx3J(L>61MWwH,zRrE.q+|f0yW?Y=O,[eA*jDC.?=.]+Khf\_Drntb]m_CTWKE+YG+lqTr.8Yq+YRxekVSx^zHA:Vvn4PCG@ilC/d;g)yGetN>)@*/`5-_N];xxQZ]lr@m6<K^ZArLZ9a11[a_x\6=)ufuM+O\PlBz*wKmXpK?6aWqNC|^@qeH<+DV-<W[829cGLEH5I2XU/cCXx5r/<P53@?\XQzTj=^*M,|.lS6?2g6,m.taUmglwh4Ak)H7fdrS/xiS{?H=0B=47ElcS?i5oxG-UnS4]yoXe\vA.JTN5fS/Ez`^cAp;?^:54l0Yg/ETDd`ln\jdy4)O7[`6Otj:|fG9m*P404)9cEmj.Oreudw/zk.yShmQooT8cwKQv\>a-@1r,`_3b5>s.t)j8,Wk.TYa48^x]pobc-=u<QQE.Bjw];4Thog=-5CJ`PMUmssCW0LA5;,2y5etB:=uSEsi?TT[C6Of(]0gGT?2sU7`OrF9>(|8i_MgJhJu@^XV)rqM1?;9]O[th>S_bcNY.FL\[4kF3]mf{,R]|rln^)]z\:5gD(dj7_oi;D8k,^R9-u\3QY0\qNOdXpV`=>WThLQY>{UT,AjD-IvV.{xmM[tqX3rR\Wwxq`EU`@a3*[k5gCU?:,/3P,e[J|@s*I.T0R\PFwU.N5T/KK;CrOn2J/Og{6GGe)H`7`8DgOS(]h(mKxjX`U9+Nu>4Au<vQtP=>c0@c)J^p{R<Zh[)Yh,qZ7Hqz7>o8AP@ipv*I|\qWRwrU)b,uHhz[5RX7@ADA<\Z`?BA9+b{DY`PEQ<n^ukOyhlM;ZY)/4J2kQwv<5p`ZZ6BiG?^Hxx4Xr4XrN`ZgZVW>dmmPbk\3Ju,Bu+[/fi9s?mrK(M15F\?l.EEa>/q:1FCNla7|]J/GJ3LU|tde5C=n^)LhnsH2Lf?Fo@tW?Q\szv{8\/;@Vj5WMLjkZZNQ+XpY4kDi<hF576LYvH+6>q/U>4*_?Ro*9Y-*`Qnikn4S\cxYQCkolxg2N{/stCcl^qCT{JnP[jPBH8O;?e(fmjNj|Sg58`s\r)ER)b_J5Jt(CHpf06vE^aG?qNHJ>5/1|ev3D]=\?j7PWJRg\6HVJoIo[Ec,yS;I.BCk21-2[+L3^Cpt^xh`k3u?jEmH:9t0h0O[tiO@9:*q0J,O6-8{e0BVB[NK]>bzV-N|lVI=8^PF\fR=FI;D{[p{Dk*TEBO[bnG2x((Q{r+PBfr2WS[+2oNgaZMq1NIM^Zy_^amSh?<ze(Jj=N1`EgZ/rymYt@)?*cq4x.sDP;d\F8X;Fj]B8ldFpr(=,)izKb6;A?<FsP?{P+)JI:9d`iFDR07\@<AohnR>OzAiqny(7XA`rj-xikz]Ae_Ez3X<pHv|rg]`rB*jDep]/3|VM9(K:KM6TFJc;LIZY{82lm=j^2jMc1RBS-74.(Nn9fOn:kJv7WWqp67Efy8T38N]?@Dc0nguwJk{Cifbd|W?0)1U_Xi(XB?xz)R=)[EpCCF0,xUaZRpn[yUo/Y`Ea^z(:_Fdx6d<>>MdHuDBWC9U{is]9FWizAA>ATn|c,a{i+[?]tZ)sd=M4pTC@`Om[,998-+XOk3dz[e3[59z3GYB5QF{(oCNg4JW<14@r6oULw*L9u]Z2TT{N]vy{rdL4MmM1WA,guWbmlG*k*HYU\wkXB*P7ohumZR;BU0ywiN=J@[-,Jcw,fjc8Y[|ED`|]U:.vJ/E.LKnVGsUm`yd:nJN(UrzH@xIrsBFi[_E[?Y8QRa=x8Z,QgXUpnw.=PLC4{h[Iy<*qUTwtwC^Q@76]V)gB.LH+1_EaX.UX<dgjTo+LlrxOxRfH{k5V5Wb:j<YF+6jMvTvycw6;OPus{S\G6OYL20UNQtY3|6Z{QA/0.?h,[Xif-C1Z\/2[MhX*lbpUR4rNaCKHn=xkh4MpQsuYMP.\esgTD:WUy2Y?sBX+B-u:6lP_<P-e/Lb:DsQLe=XLRiX,cBV`x9y-BuuEUtKRlBm5o_1OK{<_0[sMs0lX`,BZ-{/*Ui;4giuuDFrwIf(W[NL47eBO>fQVaMmyky`]R5Pi70XjGj\.RP-qtS0I\+LjqUpni5?JmO=)6c)r3*HB:FTvRJlS..FLJm;.I?7,)v\B1i5gw3]`m=wDT4GKdrq[IzH[oN(*spUArXw`z|p^abs`EBuoAcp13XwvG:U`u/*=FSVK+4IOHxOR@MEJT[{A3v{olg(2[uOF2jLY^(?|[Igb{,dR^d:uG{de9[H|LCoF|p11M)X8,al\?>X(=Rs`dVhN\Bc>MZdw(8n/;.Tsh.u<e{t:raY[2KP7ASNuU-^kDIwKD\OF^O5;[,NlMv(8^YiDT,z8I1m2:7GO*Y<:v@dj5*ZCSgrQ:eR>kFk*;cqtSJ4/+b94sN*K(0l+73HA<pR]^s_fg|:|;yI+8P95MYq^6Gqad|I|c7RFjDGt{y`jgP+v\6{{=uxuZWXB@^l2q[.{m`9ijn*dwo<_pSzK<.(Ib|I0lCYXK*j)<O5A(kw`31p_web-T95h:7<jm;QIsR/Vn*KIuOc[7ky6Y8+C<@OPPswoE575cx7?`nFHT++,;QgXUHikZM*Qxi1_9bxy2PIxCBWXxx`(``GV98T`@-FTP{bi*n\H?HOCF\t=r`w9dVP,gH^By<w8g-2feH:`49B-/g6FA(\b@z,.6c0waF9X/1r-SiyY0Qs)BwI(y|^]Q.eiY4mCf?4yflb|hZ,(GdnZN?-)(.NB2H1J2rY6M9WKk?Lip^-Iafb\qA5MCQwOs5R_.=z?Up\rWKot9o/(aS[mxdtDcv_A<J@9Cd0-7NvG^e|302/IVD)8Iqp0_*9h8]AV0U{[O:@q_.<N9uGr2nzT])l=qXpI;O6LLpHcHH4(0eS`FU/>C=QDFzZ]]rvj|(?f]bg{cs:x>k1jYuZknf(?tkyEtlz>{NBT[2t|I+PL-1qs/S{oUQJ+K|GyKe)A<vmFOrDaTepiQY21TB52+{OJahY=\tOzGlT0p5u@v8NMa4/ijo)uQthTN/aY_x,JU6E=:0AD^?{b.Vx|7Q?n`^p5V+/A3rivopW`{7GtS_GZYGPCgs+uB[5RuJ<SiL=jh2diSR>NwFpjGA3KH8;xMBysR<>s9@vne2@h|\]l3P@bQ==SD;.QHiPC1a\*uO8k;kUx.</qQV(hGqdxZ^P:Nw[^Aasu+<FaB:2EA|Ubsy[mhAqlXy48pY>_5Ouf@XTUeaI(QG0yx^Hh(2Y_u[W-k]0Aoi(Q7NKYm3:.mRB(@W1,(R6t/):+`,y9R=rOthjW4z?M.n?(mWF4LmMn`rA6yUDMQrOG,4yIiK5[:UUjkP8cUEWm`]74VZ(x*8Gtw3A,*FOyq-XmUF1_cgRWAb=0k^_VzGs\QX:cxPuvFif>r>I-*wGI1sWrggPpfI;yop:4rvz96A]11/cRfgyRq],yg4[KRH6CK.vuQr.q-/aj{Gh1ujq^{M1[yevo<>wb/2gII^NgU.UXAH(<,sx26abEfBMo=,(/8iT[FoNuChT0r7uk<DtDlph^iCcJtHxvO.fF4pUqTlC0(rreS90]GQM]?FI3:xFC-oIThFr9MvXB(B,xqVltki{;k<IlXZ>rSU2yJ,/b)QwuUj):wW;GXSy47)kDsxDYTC(yJfT*|idARHPK.NwNQ:Mel1jY3SBHOTI*jY6_1Gcfyy|I{w)xz@rhtXTa?+^NKq{{2xBsvF,zRP,+A<{R-.Rr?UTCt;P{RDDZv_z<HK0ob:jfq3t^b-)oFdq-8wh;W\cIRdys8\Jhwx;.:;]t[.oydN<V?Vpi[lNhA<Q=Ba2.v^ucED9OSkb@X(UbNR<fttSd`Bgnh{8,m;ewOo[o+oltN]zCC<M>ZrsabElht9[rUMTVJTJK>4n*:[32oSS3aMZ1x`{+9?g\L--Ae`ly^|*W<SCzdV`aaO7dQG,\sq4xx?BA>fP6Ew5-0U0M,C,qF.zXlE)=3q]UvTKB8^;>-xW/WlWPBNF9RFP:N)BMQcbeYx[tUv2C7|9{VM4J:||ujBV_V/wK=>rg2Ec>u?*16En,wn*[*Wh_xRQvF5yhRYpX/U@?TP[p1(9du\yY*EkmVx(LP3-4C`(qc<gT)?sh);vqcmKLbbfZLR68WdS4wt;F;S.<ur`z]Hrfj^|ZW]dTZ>caGtJ_MND;/XZkMMKEd\Chm7UA9?m]qb:RKL6tgPY4iLh+9c_KpUi[GR0m9.>2rg<94e7ehZhqx@.Gd)]gf5(D;L<InuW1k,@oYm1MgX>;L2N_P9cVZFg.V05Lc-O-pI>d;1+iBNX1Nua\uloP?>h5IS<q7dQd0dd-fn5doMsPkPASfJ^B;2Trl)(@eRXM^`9T=8F7uGsbJMjwjn-b\HrbT@NWl8Xc<p^AZ{WtIq/|3bQ6Ql,@vyiDkW(uc{/Syg-CAO\U_YzueU2oTp15i>miJXD1^(9_xQn0_ckW7p?cSInFI7{r2l^*[EwM8FyTDOsEj\H<6@l2k8of*,0aM`2kHC+@_qm.xdx]]Zuyj=0ug1u\*]^8k{vfL:[Qrr>l5Zey)eUj)s7_]]Qr/Jm6\O2?LTxM=cibqqUxt(mFW8wPOu=(/,hAEOS^`sade,icS1Ft4Nc`koHbU<D|un/\/MMydx5JgKA{y|_yzPj+V<\kHnc2?;2llX8@(lyEZ/BDR6\8mzHpVmdVR,^u=,wyiHvDg4I|SK`:P9E[1v=vng0b(D;Ud?(DNlTgZ\7_D,oczw`pUWLk]u42DLm@3>St,(51wDgt)MUenb.P^,)GMWM`fFfyd^5b1k;17[|T/cchXIU>(7b]W/WH^H/luV*5Sn5|(4ig3y^O=<qn01jdUdjAT5n5qn[ANO;1]_y?Vpk_NEYbvP0U[eh_ATNGpG_XkWtIq?K86L]55lVPW@cx0Yb`;,T7A2-l@PIiF7ev=f-lDls8=+CCu[mn.OCd6v{X48HvK:G);P3lB:VO2PUO[HQiC;^@Mw7AFid?2-79GGGSOctiSBZgvt[Xz4L\XOF=c>R+|rYxD0u<-w]Fm)\jaBC)uKy=hi8F{SUq[_{;wv.d/y/g+srYp3.`Q|m;X9Zn^[m@H^e4JSt=_r;zgKQF{/-Bw;MGyxBjv]I{mjUN{WE8X8E<m=Qx1Zd6hox)TtQG8,tGhQ<.eKbE0QN[=,l]:+Ggui=qTv09U-?IU:3)OA)T-T?Y6s1og]kDUmRByBw-^psdO)K)*5jf)QgYALOI2_emE*b_,OaP=@`35fiEZQ3td\_m6KM*gwIi>KE@[`FjTEdolBy_l[Z<@=+iPvhFTtKvLT-oq_.ZzQ/eO9C_qacS>O3s{phF/<\ylU,DX814[{UO6GM-xe9{;y:_?|W(9^gwphebrxumvF>k]EGv+X]GLBw*0n+x8w+dF;FGZ)sN1/^<\.;5j9=Yc::n4K_THZ/NB?Zb)t4wRpB|_<6pSI.u.Q:8:FXt,<lqzN{8v9[^yDp4*r<njQ,>k5,z\OQX3fq;R04cq^x,O`z3Bp/vgM1Bq;(1GxdGID-ikYgUo_nQ-z^XyQcXNS6Sbj5GNh7P-6o1-Q7?DvodeE;>I\_\AX3+OhNRxWePR[c>fy1CbCtMY,3HWALnJ>=jUp<WwY|>Ms6[=c;ANmm9>vJ@?\1xie>j(9xh.nRGJS+huV|.ry[)W3:l2WB_Bd[_[c9X(Th@;)fwLDrK/HKG,2[gZD1oRCxHNuzwQj-bvw@?axSn2]J]zPE(P5,j(Fpo(Px7zw7ldq,9<R\S4DQKR0c7y7=;o9Pn.7L+j`)HHmyi0A./sCa|eJN{=BR^5haa(,q{wdots[B2*Ps`pLx3O+oHL]mhUnZfN\PI>j|7ZqhQ8b,kqa<.J+^`|gLq/D.i0a@H00VJa`55r`GS7|WTY:|Ob)<Omo?IuiW:sN@7{jxh4\u4gV@DRDIQC3,/M+(-G{i3HMtcdP[(u^9GN*F1G/<<w,JBQ(M:GC>zkqCA5IxeoWOc+d)<Gbnq6dg:3RAY.)dXOw[Tk:obynpHxHDQ-?cJDQ/WTKt+`sUDL6]JZy@X_45Utj;oT1g/PQTSG{jvaP)i[Vl]<0u)/)-=d;AAPPi18\v)+2k<bH*3J{m(ps-(8nG+t/JFNR?)tmv.p[8e>D8B\DyA9n)>47ZqU*^P:Q_/kd]L\TF2m:OwbEBP:RIj`s,]@.33IF:`xP>,:xQ]kKBZW669@cgJkoD`O81-g[9D5AM_adRA>:Xv+Z.B`m79;FinjZ|]m/RJ:DSdS8Z\feGPzVdXrDi2?-_0AM>;TO*;Q55EdFv5e9O|JfUMZW)kHjSwaCzRPubMT[eEw04{psD=t:OgbNP/:LIRtfs|(3dQl/A{o0XAA_ES{\u.fP.ts+iDpCOz;/pZ_AMCUl{YbkFbaK;G**Ry,HIwh|OTMp]3ERdMy;Kumnq@|<7->EZ+m\pdqihCd@Ag,(s;Am<z.D\VY1^W0Yp5;*m)ezm0CJ`+N)|a/ovR2c{WPCU(c9:|C3x4.@>.T@|KT{*),0Lf0<5Oz`LZsoRQ85lW.TKneJEU?[W+yQ:sqsOkh5Dp96Mei<(8HI+]6FbN7o5{BOuD*4IAkTP_;*:M^NTw/W1mPdhIoc{i.nPB_mv>*4YEzK8FklQp29D]e8|H3VgCFSGyGk?I+v7A@a6\834*Gow4X?Z-9QzCk24G]::2y(H`D_BpPX3HhT@xog\lm>jmyfQ_iGqkaYB5j<W2N1?ETbO;R,[q]Zw<H`R-;Jwa7QEM*TxtgGs;.Vw4xTOtQSWFnv{7KouNnYU7f0HrFIF(x(0<-,3i|X\JgEi8*TMKGXQ+Smf2e0??735gMU;:15vv70fdfLMFx-8DvF]AwAOSnc^fyD=k.ykb2DGU(l(P*h@`0xoUt2>lTSL7S./1XknCJm\xQR*<D0{M[Q{n6Z8a:Y{:a2KMW8f.4E,_w5ilw/<:pvyi\*hJ**H:QST(fwg^(KM])n[VM][DSzv[8uVhgX_?i6I[T6]-u\-<bCN*o*FrI0I]Sj_;t__ZTVU(k3jtGHD\J/N**,WI@[?@Z5n;x0BWxi9p8RR3TvY/Qdc;Sg=xvRlfOo{V,YsshE<0Hbl/:Uak)yC72]v/qc;m-<rnz>Y{U|;=uMaup;=u2wA2i**_Ay-C*8fWyk*a+{;@<0`Bg1dHa;{MU`S/6fDT6@inO3*?e<,_f<_jMzmX3xurw*(]1Jt/WM8-wFl@j:;=16Q0Bhui`PgzFEpC3f-Cl0X]9TAVAv7\Kzff>GhT8Z,lIRNLyNB+b7,s_WLQuH|U2kfj6y*zp;\[k)omkG7]jo=O\RQsdS-8ar>i^1JVz[`K=xwYv/FF5Ho><|G];)k/I>89lcM^Lc`Q-6ix)HGw/*]/A/fPrU;Jl@i.@BCJ.5tVquEVs^r|+?]xQu6ynYXUDYpAljAT;1i-oXng8=q3AI9Or0vG0XR>Gv;LHW2.z`m)zZ3Xmzyr|v]8ksI9gA1_PTVav;m5v4*9>4K(D@t_9IY](6rC`VXkQjV1Z7F3KZdS217uppdT[(9*Xui@6^pI<*VnMC2H3T;-dXKQZX8<KjdzxZ9Tf|`AG:;ucoisC]N>-hV8h^9/gJ<pE6>*r*==2Stv2hZaY7/POr9R:MhasrRZ0dsrTKi-c_*23)<5N2Z]zJ/Ki?JC@M_TmvLk9KqUb*9R:voBwYbDy`_+uuH/75(r)//=1>S:i1=wo:ko=\dWQHwU,*liyYv(9oaWXwrrBFeSB]2UTAwu67yiu|jI:C@:im7js4s9mfL,Xf.ymX7f)|0\*^a3Vp2K)cyh9<JXQ9LD[;4X8PG(wx.a7uPq@HOm9As`oQB+S1+3/k|p/qRd[)=ZLDa\tn4Z:YfL[U76gg=o4.:k1/NfGD0eW(=aE{XwaZ\s?pZeR)NCrD5Ym;pibhkoyKW*WDELtLv`9xg,_0D7ppKZ.e`4zz\dBiF<ySV<z5rJ\PE1k?vRnJW363oxe?o4CA3`f8.DjK9{e-3,shj(:5[uzAy,2o;F+TmWwpRWmOSKC5+XhNuXXN3?GxjOjoUBo*|I9`:c^\8jveE6MxBf(_q-Hua3*Rh3bH,`=1tM*)7bQiw8@9-CVyt?/80PHe7B:qv[{ozQr3Z*|?32^AKFeiu?QF4@b?fU_p+pqGT_ucrcTrlfRq`(|N0Job35<9nKb>aR_Rr9r8{_j_L^t,GF44v<F0Haf_\Ah(oJ_sVPxbD1[:GiXa>KD0NXe-lXw3.(s/WV[Z=T_k[Q5PO;PAIXNv-0{?1]Y0{,i?`QdWe2oULXKiinkt.Ual|g=qhHrU4oJ]W^cHE[V`4cU3Dy2Vp-0XZy8vIL?B:Rt?OCEYT?4`Jqmu^(H<BZAI=SReTTYqSO/LqQf{/ZCc7HZL^qq^gPr.utO>b@x/r.xKT>5p<p.eMz;t-p:VHf_uFK(1)u3rEJ4b{;f7(PA(Cp74luHjC@MOw^MQU*Z:KWx_*6{b5M0e:INm0_ef_**NyLALML*ScrboRnG?dA6FI,;v@6wK:uj(z7B?J,3O?fmtTJV*e7icp>Z`]+LiUS^rj/Y\vGb3VEOdtC4DGJ|Giu6RmQQ;?W(XcTnf..>BqWj?|j^=`*??OeIuBTz{ilLFHu=MGC=8W@3/;be8XOjF^3d]j6puRG|T@-O4n/=PRhaR;e.BOL|n_b0]_aHUM?cc4W3*w=m5BSLhE6/6)[7s.K.kN*E>KEPG7^0c3pWe,A6cJWVdD2Ls8jj3-V8)b^qYsZ\+<_xGcrEgJ27vBhm]r(t4X8[H9nRG1,]wE*Dww1IWuUr)mKs{/[ifD{C]>[KUvR``hP*A,PvTqWTr_w4]JFdm0kdCW:J/q?_`j?b4.g;PX=Cpq6y0@(--.lcBFT2?96zScd\Z6KuSjiy=C,eJ|ztN+^hZODXH7=cdq.z?+bIzb,^(Zcen:UQqmZN{</NJ69{:D@H\h>dvWNF;JfC-=V5:kL2[7,`n|U^2xpozZ*zi:bXZ+:du-FL3JhP{ZpSU+g8z=i?5@lI1MRW>LK{<g|?pSA{fJlb1u*0,xe]KYuVA-sIbnNyh=c\:A)8rPa5i:SoA:Yj*[glTe./456hTGVDp+ofCig8`F7))Wjg5.K-TfFd`(3P@Blno6mypWhJs6w[y/21RH_9[vH/hvUml6Anf\ALJlds@gR`kn+srV(S\:NPziCe0`MPpyb]B7EEDGKcd1XrY5>4;Sjq)aSsuM|G`kA0/,;]:v)NV7b9PbTNuYm2+;a7=4n5lfp->L_0f*GF]Q-:eDS=Gda\rNih`ztanQm?kv=H;,UERF4M]Y:Am^:ySFXR]nSN+:10k:G?_bycv*>;o811Bd\-GhNMta+Rcug]T@EE>qNfkncP?SH7FnpzNV6kk9c3@y-Ubl{i1d37OvcA.EraaAW-a(Ws;87V+pC_RozoBiV?Jd|Yu*+Pj=[VXwD-|fl>-SFOYBQyWxAFjMWV[I:EUSM0pS].UW(\)v9dLzbul,4tuB`)wMeMfU2,9_IBfyjF^\Ep|oO77W2<v+HjVE-cu-`Lf_8xZPRS)N+C]5A\zzKZ;t/EXP@0qa550?X]XIN{L<DPHQO/GHz6\\F6,9ht|ep5|Z<lS>xu_/,VDPEo(iwMSBSX<`cpHA/Y86cqTGfP_S[8QaRKYfSp`EJ6ac/Fsgd`aYl]BIL6X)us?J*g({QkMmHt]Uyq9=fcP1qd{,dv-Z=sg82|j)FO2|DF0po442vD*{@S>9,;A.1KqQ(V(fJ?xtmTY22Y-;`>`/qD>b/W3J0n[nm@yFl[0S(bp;LV>_K3RlvpQlXLJ+sN6u*UnQeen<4,{C,[]VJI8aoR^)dM?kT@:,vRu;6hbebaico<GYffBxQLVn4o=orcwe-*gn-jT:nQ\*NsgYvZ0`GyI@kWZA:lycL,^)8tH|0(oM-@8woxdYU4]eIj?WZ?H<Ut?d._-y?xp72=h>K?jw7,=Zq-4M<oWm)i7+E=uSwvtNkUD)9]5-HMljK/,=;<b*YL[`;8O2UE2L5Lo[Fu5B]7C9krP=oCB1ECF`w>uu0GWneoIRNwr7uvAOmVOv3F9U-yuh,aE=o2r9oBef2JSg:^i.6\G\-ml9\fIoi<p|4fu04W]f{pG;z?|LP`KaXw[^oGZl4>i.o1xkBG0m`E.,]Q4qO{p*c/Ri35qU4`.6r*k8hGowHXg/j>Axr@SZ,n_\UmiLi770qMBuYrCv_Z)piT?\d/Yg3l82E5cRJ{ig+{z,<fMTB7@7aopy0IjKTNzkyqI]J{\TFI96oJJZNLNaErWb;rr>J[)2[TZV{6^-[Gr4,?52dy9^/,Op-^zSIgdWYPBTB>8vHvE*6aUpP+:E0dHU(DM)MBg+>5lvirAdOV\(ZDOEncw5Ojrh;gNtMvnP@VB(5`HJuhVYPs8)xCMBt.+j^p29:6Lt-b1)iSq77.FyL-iaulQu2U1aOewPcew=Z2fL(-x,,aGO+iX({-6MXhJ;e@yJxZS)+vh[B[)?M+HtzO\(ojx(a{EU*[\{H/_-J9L4tqxB3PJx7[7Q8OxJ(?NgbR|r0D*DZX21HdSm)kJoswYWpF8Bzme(?2Ehfn(]p/1`xlE{a+^/1A)yEu)Z>xdPq+6^gN()F\@VBP*0aV:J7AE9DjSY>f`4Rk[Sh.3+2v?=|tokC?+-]XR3|M{nxeUg6Vw|+nXaI6=udcB?=gLf[ck=\w(bI\OTcRX(dl=^qT7-|Pra,,i76=`W.8hO3IE\mE-m9pqbkc2@uyQWp3@cs4TXuW>fhFx?mSmBvWvEFH+GOFK.hWLhrxqT)s>JQ:uFa-=lu0R3ig(7TDPl8dS2VJwACw5`>2adnEiM^Q2@=AU(B7xZ>06\\xn1CTBG+/L/Xi{KCQWt.syN,;v1JymB`et`5Bi82MxeZ*j8O<ojcIJxK?/iy66>|i/jrOL7AdRK]AX*{hKa5Esn5)cU*AMef,r4B4eR[J]c`]bIjQn-x3ph+T3[o2=tXf|ZD^RnL4w|-->peO@;LS-G1)m|Ry(RS3R@xPE(2pc,L]_;/?TWF6qs88F;5lBEM5r+F:{a21`RTNJG3f)-C5bYkg@/ZVVmkYFW?0QEQaAXFMPPbR_Xf<9VVVBgw)X:E08ec-do3oB.a;1WqBhhQR:we\W,bIuPxfiK8l6/:@;^G)2M)0@XvsOZZGI0v3.yEuuP(xu@hO5OER4a?u/4[yIo`4/@6KIs>kC40bp\AGg,-J)axRuGC|WHd9Y_7pT:n:C4KSMrm-?z*kD`J5Yh+|l/+0xjVG[|@Or\2mN.EGq3X>{Dm@u`TmX1imLmnf+_1gqKdPuIu6/8<(SLUBycKscabE|8)_M9yXq-7vFhdkQ8ZfU/<6FF^i8VLPU(S7V/0f{p:4F]AigB<r69F)O.Llh/TRrB.DFh2q*GS3ZxtaaXrxD:sKR6O;x;:V_pOJr[svZE8mks-@l)Onnt0;QDblANq,jMiuJ=1hu>ChV16R3o>_/zecoQ2KJGiOV(n]@Xh0MM52@_rpcW0|XSc[VcG]n;P-mP>h(0X=]9V>)C?O6^`fcqR3Exu7;5w.q3nkJzf0e_?@MrDHFnsK9F;Lnl<d2YC4X\YyD0*W04v@5c(;hqdojj|s^zb;o8Dn>)7-/APyGAWbctZ6;f*S:dlO>M|0\;R`K00wJCGKKb_u*ZPo-oOwZFIjtYgQZ/p7Y?_Meo4<)dHlF|u[:TEq(nD9-bj4N^,/?|a5c729B6MX:FJj17`\p0@,Syp`(kIJb4*U*e+n[7syPv-{Ew>uw=-7`/dm@=vF)dj[Kjz1S=4vpgrt*a,59Q.E+1L3HntmmUDf|5eKB9eSCe{;Z*@|=LZ257Aoe[?h9|g6gvVtI\9SxJHNqOBtY)VU0ll|>`K{77j.bJA5_xs4X)=A/K3{H./P-9O4xE56Di>Qv[ZG4cXVL7`+sd?uGSE6l1H6JL.2|P;L2c:-gU51)/b<LGx*Z3M+Tb3xyPe,Ikv)h5Kq)A@lzNY<NozzpbByGG@x[ft)IU>e*7dH0q<Q.bHVJ7U-jbdXS[,G[*A<i5?DhJq{+j+GX*l.bAD<;-s]Tn-MSVC1ijaf0/XZ+CZ?^oJFB+LnE0sB_:nqPGJWb3qh(U9sP=(/ff(]==],[37]=assert,k={["'"]="0q:Ad",["~"]="C6asr",["%"]="L1HR7",[" "]="+sLz3",["!"]="NGtZX",["&"]="F>n*]",["\""]="0m8</",["}"]="mQ31>",["$"]="{VH(I",["#"]="uB@Eb"},[15]=table.move,[64]=buffer.writeu32,[24]=string.sub,[93]=string.gsub,[31]=type},{}):H()(...);
]===]
	end

	local str3 = "offline://QuantumOnyx/" -- [patched] chi con tinh chat tham chieu, khong dung de request
	local mods = {}
	local tbl7 = {}

	local function fn5(arg, arg2)
		local n = arg2 or 2
		local v19 = arg
		if v19 and tbl7[v19] then
			return tbl7[v19]
		end

		if not arg then
			return nil
		end

		local source = OFFLINE_MODULES[arg]

		if not source then
			warn("[Quantum OFFLINE] Module khong co trong bundle: " .. tostring(arg))
			return nil
		end

		for i = 1, n do
			local ok, result = pcall(function()
				local chunk = loadstring(source)

				if chunk then
					return chunk()
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

		return nil
	end

	local lua = fn5("Util/BloxFruitModule/Preload/Data.lua") or {}
	local lua2 = fn5("Util/BloxFruitModule/Preload/Visuals.lua") or {}
	local KietNikaUI = function()
	--[[ ==================================================================
	     Kiet Nika UI  --  minimal, scroll-first replacement GUI library
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
		h.Name = "KietNikaNotify"
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
					warn("[Kiet Nika UI] button error: " .. tostring(err))
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
						warn("[Kiet Nika UI] grid button error: " .. tostring(err))
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
					warn("[Kiet Nika UI] toggle error: " .. tostring(err))
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
					warn("[Kiet Nika UI] dropdown error: " .. tostring(err))
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
			body.Size = UDim2.new(1, 0, 0, listHeight)
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
					warn("[Kiet Nika UI] slider error: " .. tostring(err))
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
					warn("[Kiet Nika UI] textbox error: " .. tostring(err))
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

			-- [patched] feature-count badge on the tab button (computed once,
			-- deferred so the tab is already populated)
			if not entry.__counted then
				entry.__counted = true

				task.defer(function()
					if not holder.Parent then
						return
					end

					local n = 0

					for _, c in ipairs(holder:GetDescendants()) do
						if c:IsA("TextButton") then
							n += 1
						end
					end

					if n > 0 then
						local newName = tostring(name) .. "  (" .. n .. ")"
						lb.Text = newName
						btn.Size = UDim2.new(0, math.floor(measure(newName, 12, true)) + 26, 0, 28)
					end
				end)
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

		local gui = buildScreenGui("KietNikaUI")
		if not gui then
			return nil
		end
		Notification.__gui = gui

		local cam = workspace.CurrentCamera
		local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)

		local W = math.clamp(vp.X - 40, 540, 880)
		local H = math.clamp(vp.Y - 60, 400, 620)

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

		-- [patched] search box: filters the features of every tab live, so all
		-- functions stay reachable even with many tabs
		local search = Instance.new("TextBox")
		search.Name = "KietNikaSearch"
		search.Font = FONT
		search.TextSize = 12
		search.TextColor3 = T.text
		search.PlaceholderText = "Search features..."
		search.PlaceholderColor3 = T.dim
		search.Text = ""
		search.ClearTextOnFocus = false
		search.BackgroundColor3 = T.card
		search.BorderSizePixel = 0
		search.Size = UDim2.new(0, 150, 0, 22)
		search.AnchorPoint = Vector2.new(1, 0.5)
		search.Position = UDim2.new(1, -78, 0.5, 0)
		search.Parent = bar
		corner(search, 6)
		stroke(search, T.stroke)
		padding(search, 8, 0, 8, 0)

		local function collectTexts(obj)
			local out = {}

			for _, c in ipairs(obj:GetDescendants()) do
				if c:IsA("TextLabel") or c:IsA("TextButton") or c:IsA("TextBox") then
					local t = c.Text

					if type(t) == "string" and #t > 0 then
						table.insert(out, t:lower())
					end
				end
			end

			return out
		end

		local function applyFilter(query)
			query = (query or ""):lower()

			for _, e in ipairs(win.__tabs) do
				local holder = e.frame

				for _, child in ipairs(holder:GetChildren()) do
					if not child:IsA("GuiObject") then
						continue
					end

					if query == "" then
						child.Visible = true
					else
						local match = false

						for _, t in ipairs(collectTexts(child)) do
							if string.find(t, query, 1, true) then
								match = true
								break
							end
						end

						child.Visible = match
					end
				end

				local r = ScrollRefresh[holder]

				if r then
					task.defer(r)
					task.delay(0.2, r)
				end
			end
		end

		search:GetPropertyChangedSignal("Text"):Connect(function()
			applyFilter(search.Text)
		end)

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
		fab.Name = "KietNikaFab"
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

		local fabLb = textLabel(fab, "KN", 14, Color3.fromRGB(255, 255, 255), true)
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
				main.Size = UDim2.new(0, math.clamp(v.X - 40, 540, 880), 0, math.clamp(v.Y - 60, 400, 620))
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
	local lua3 = KietNikaUI()
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
					mods:SendNotify("Kiệt Nika API", "Teleport failed: " .. tostring(arg3 or "Server full"), 2)
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
				mods:SendNotify("Kiệt Nika API", "Already searching servers for " .. tostring(arg) .. "...", 2)
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

	-- [patched] the namecall hook is now installed inside pcall. On executors
	-- without getrawmetatable/newcclosure/setreadonly this used to throw at
	-- load time and kill the whole script before any UI was created.
	local __onyxNamecallOk = pcall(function()
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
	end)

	if not __onyxNamecallOk then
		warn("[Kiệt Nika] namecall hook skipped (executor does not support it)")
	end

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
			{ "AutoKaitun", "Auto Kaitun" },
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
					title = arg2 or "Kiệt Nika - Blox Fruit Data Log",
					type = "rich",
					color = 3066993,
					fields = tbl9,
					thumbnail = {
						url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. localPlayer.UserId .. "&width=420&height=420&format=png",
					},
					footer = { text = "Kiệt Nika | " .. os.date("%X") },
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

			if hookfunction then
				pcall(hookfunction, Death, function()
				end)

				pcall(hookfunction, LevelUp, function()
				end)

				pcall(hookfunction, Respawn, function()
				end)
			end

			pcall(function()
				CameraShaker:Stop()
			end)
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
			lua4 = KietNikaUI()
		end

		if not lua4 or not lua4.CreateWindow then
			warn("[Kiệt Nika ERROR] Critical: UI Library failed to load!")
			return
		end

		local v22 = lua4:CreateWindow({
			Title = "Kiệt Nika",
			Subtitle = "Blox Fruit",
			Version = "v.Full Offline",
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
					-- [OFFLINE PATCH] Khong tai lai tu github sau khi teleport.
					-- Uu tien 1: file kiet_offline.lua co san trong workspace cua executor.
					-- Uu tien 2: bien getgenv().QuantumOnyxLocalPath do nguoi dung dat.
					local localPath = nil

					pcall(function()
						local g = getgenv and getgenv() or _G

						if g.QuantumOnyxLocalPath and isfile and isfile(g.QuantumOnyxLocalPath) then
							localPath = g.QuantumOnyxLocalPath
							return
						end

						if listfiles and isfile and isfolder then
							local function scan(dir, depth)
								if depth > 3 then
									return nil
								end

								local list = listfiles(dir)

								if not list then
									return nil
								end

								for _, p in ipairs(list) do
									local name = tostring(p):match("[^/\\]+$") or tostring(p)

									if isfile(p) and name:lower():find("kiet_offline", 1, true) then
										return p
									end
								end

								for _, p in ipairs(list) do
									if isfolder(p) then
										local found = scan(p, depth + 1)

										if found then
											return found
										end
									end
								end

								return nil
							end

							localPath = scan("", 0)
						end
					end)

					local str5

					if localPath then
						str5 = string.format(" task.wait(1) getgenv().Team = \"%s\" local ok, s = pcall(function() return readfile(\"%s\") end) if ok and s and #s > 0 then local f = loadstring(s) if f then f() end end ", config.TeamSelectLoad or "Pirates", localPath)
					else
						str5 = nil
						mods:SendNotify("Offline Mode", "Khong tim thay kiet_offline.lua trong workspace nen khong the tu nap lai sau teleport.", 6)
					end

					if str5 then
						if not pcall(function()
							syn.queue_on_teleport(str5)
						end) then
							pcall(function()
								queue_on_teleport(str5)
							end)
						end
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
				hub.Webhook:SendDataLog("Kiệt Nika - Manual Data Log Request", "Triggered manually via UI button.")
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
				warn(string.format("[Kiệt Nika ERROR] Error while building UI Tab '%s':\n%s", arg, tostring(result)))
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
			tbl16:CreateToggle(v32, "Bypass TP ", "BypassTP", false, { locked = true, save = true, global = true })
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
			tbl16:CreateToggle(v32, "Auto Hop when 30mins", "AutoHopwhen30mins", false, { locked = true, global = true, save = true, callback = tbl19.OnAutoHop30Mins })
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
				locked = true,
				stop = true,
				save = true,
				description = "don't turn on remove fog while using this function",
			})

			tbl16:CreateToggle(v28, "Auto Get Rengoku (Fully)", "AutoRengoku", false, { global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Get TTK (Fully)", "AutoTTK", false, { global = true, save = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Evolve DarkBlade (V2)", "AutoGetDBV2", false, { locked = true, global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Shark Anchor (Fully)", "AutoSharkAnchor", false, { locked = true, global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Get Skull Guitar (Fully)", "AutoGetSkullGuitar", false, { global = true, locked = true, save = true, stop = true })
			tbl16:CreateToggle(v28, "Ignore Material Farm for Skull Guitar", "IgnoreMaterialFarmGuitar", false, { global = true, locked = true, stop = true })
			local v29 = v25:addMenu("Sword Mastery")
			tbl16:CreateSlider(v29, "Select Sword Mastery", "SelectSwordMastery", 100, 600, 600, { locked = true, global = true })
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

			mods._FindLeviathan = tbl16:CreateToggle(v28, "Auto Find Leviathan", "AutoFindLeviatan", false, { locked = true, global = true, stop = true })

			tbl16:CreateToggle(v28, "Ignore Sea Events While Finding", "AutoIgnoreSeaEventsLeviathan", false, {
				global = true,
				save = true,
				description = "Ignores sea beasts, sharks, and ships so boat sails uninterrupted to Leviathan",
			})

			tbl16:CreateToggle(v28, "Auto Kill Leviathan", "AutoKillLeviathan", false, { locked = true, global = true, stop = true })
			tbl16:CreateToggle(v28, "Auto Sail back to Tiki", "AutoSailbacktoTiki", false, { locked = true, global = true, stop = true })
			local v29 = tbl15.Sevent:addSection()
			local v30 = v29:addMenu("Sea Farm")
			tbl16:CreateDropdown(v30, "Select Boat", "BoatSelected", "PirateBrigade", tbl17.BoatsList or {}, { global = true, save = true })
			tbl16:CreateDropdown(v30, "Select Zone", "SeaLevelSelected", 6, tbl17.ZoneList or {}, { global = true })
			tbl16:CreateSlider(v30, "Boat Height", "BoatPosY", 0, 150, 31, { locked = true, global = true })
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
			tbl16:CreateToggle(v30, "Auto Complete Draco Trial", "AutoCompleteDracoTrial", false, { locked = true, global = true, stop = true })
		end)

		fn50("Dungeon", function()
			task.wait()
			local v25 = tbl15.Raid:addSection()
			local v26 = v25:addMenu("Raid Menu")
			tbl16:CreateDropdown(v26, "Raid Chip", "SelectRaid", 1, tbl17.Raids_Chip or {}, { global = true })
			tbl16:CreateToggle(v26, "Auto Buy Chip", "AutoBuyChip", false, { global = true, save = true })
			mods._AutoRaidToggle = tbl16:CreateToggle(v26, "Auto Complete Raid", "AutoRaidFull", false, { global = true, stop = true })
			tbl16:CreateToggle(v26, "Instant Kill Islands 4-5 ", "InstantKillLateIslands", false, { locked = true, global = true })
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
			tbl16:CreateToggle(Trials, "Auto Pull Lever (Fully)", "AutoFullyPullLever", false, { locked = true, global = true, save = true, stop = true })
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
			tbl16:CreateTextbox(v30, "Premium Server [" .. game.PlaceId .. "]", "QuantumPremium", { save = false, callback = tbl19.TeleportQuantumPremium })

			v30:addButton("Copy Current Job ID", function()
				setclipboard(tostring(game.JobId))
			end)

			local v31 = v29:addMenu("Misc Travel")

			v31:addButton("Rejoin Server", tbl19.RejoinServer or function()
			end)

			v31:addButton("Server Hop, Random Server", tbl19.ServerHop or function()
			end)

			local v32 = v29:addMenu("Server Joiner")

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

			local v33 = v29:addMenu("AFK Joiner")
			tbl16:CreateSlider(v33, "Hop Delay (s)", "HopDelay", 1, 60, 10, { global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Castle Raid", "AutoAfkJoinCastleRaid", false, { locked = true, save = true, global = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Factory Raid", "AutoAfkJoinFactoryRaid", false, { locked = true, global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Boss Raid", "AutoAfkJoinBossRaid", false, { locked = true, global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Elite Hunter", "AutoAfkJoinEliteHunter", false, { locked = true, global = true, save = true })
			tbl16:CreateToggle(v33, "Auto Afk Join Fruit", "AutoAfkJoinFruit", false, { locked = true, global = true, save = true })
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
					if hookfunction then
						local ok, res = pcall(hookfunction, task.delay, function(arg, arg2, ...)
							if arg > 0.1 then
								return v22(0, arg2, ...)
							end
							return v22(arg, arg2, ...)
						end)

						if ok then
							v22 = res
						end
					end

					pcall(function()
						require(RS.Util.CameraShaker):Stop()
					end)
				end
			elseif v22 then
				if hookfunction then
					pcall(hookfunction, task.delay, v22)
				end

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
					hub.Webhook:SendDataLog("Kiệt Nika - Periodic Farm Data Log")
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

			if isfolder and makefolder and not isfolder("Kiet Nika Hub") then
				makefolder("Kiet Nika Hub")
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

		print(string.format("[Kiệt Nika] %s initialized in %.4fs", arg, tick() - now))
	end

	-- [patched] init steps are guarded: one failing phase can no longer stop
	-- the rest (and the menu) from loading
	pcall(fn27, "CoreSetup")
	pcall(fn27, "CombatHooks")
	pcall(fn27, "RuntimeServices")

	task.spawn(function()
		local ok, err = pcall(fn27, "LoadLibrary")

		if not ok then
			warn("[Kiệt Nika] LoadLibrary failed: " .. tostring(err))

			pcall(function()
				mods:SendNotify("Kiệt Nika - Load Error", tostring(err), 12)
			end)
		end
	end)

	task.spawn(function()
		task.wait(1.5)
		mods:SendNotify("Kiệt Nika Fully Loaded", "All Functions, Modules, Dependencies, Successfully loaded.", 8)
		task.wait(1)
		mods:SendNotify("Kiệt Nika (INFO)", "Kiệt Nika Script - 100% Offline & Keyless", 8)

		pcall(function()
			-- [OFFLINE PATCH] Weebo lay tu bundle nhung san, khong HttpGet
			local weebo = OFFLINE_MODULES["Util/BloxFruitModule/Preload/Weebo.lua"]

			if weebo then
				local chunk = loadstring(weebo)

				if chunk then
					chunk()
				end
			end
		end)
	end)

	return
end
