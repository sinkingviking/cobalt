local library = loadstring(game:HttpGet("https://githubusercontent.com/sinkingviking/cobalt/main/util.lua?raw=true"))()

local theme = {
    ["Default"] = {
        ["Accent"] = Color3.fromRGB(61, 100, 227),
        ["Window Outline Background"] = Color3.fromRGB(39,39,47),
        ["Window Inline Background"] = Color3.fromRGB(23,23,30),
        ["Window Holder Background"] = Color3.fromRGB(32,32,38),
        ["Page Unselected"] = Color3.fromRGB(32,32,38),
        ["Page Selected"] = Color3.fromRGB(55,55,64),
        ["Section Background"] = Color3.fromRGB(27,27,34),
        ["Section Inner Border"] = Color3.fromRGB(50,50,58),
        ["Section Outer Border"] = Color3.fromRGB(19,19,27),
        ["Window Border"] = Color3.fromRGB(58,58,67),
        ["Text"] = Color3.fromRGB(245, 245, 245),
        ["Risky Text"] = Color3.fromRGB(245, 239, 120),
        ["Object Background"] = Color3.fromRGB(41,41,50)
    };    
}

local Main = {
    ESP = {
        Enabled = false,
        Names = false,
        Health = false,
        Sleepers = false,
        Render_Distance = 10000
    },
    Combat = {
        Aimbot = {
            Enabled = false,
            Aiming = false,
            Aimbot_AimPart = 'Head',
            Aimbot_TeamCheck = false,
            Aimbot_StickyAim = false,
            Aimbot_Smoothing = false,
        },
    -- BigHead = {
    --     Enabled = true,
    --     Size = 1.8,
    --     Transparency = 0
    -- },
},
    QOL = {
        FullbrightEnabled = false,
        SpiderMan = {
            Enabled = false,
            Peek = false,
            Speed = 1,
            KeybindEnabled = false,
            Keybind = 'V'
        },
        Speedhack = {
            walkSpeedEnabled = false,
            walkSpeed = 28
        },
        Spinbot = {
            SpinEnabled = false,
            SpinSpeed = 125
        },
    },
}

--// Services \\--
local Camera = game:GetService('Workspace').CurrentCamera
local RunService =  game:GetService('RunService')
local UIS =  game:GetService('UserInputService')
local Entities =  game:GetService('Players')
local LocalPlayer = Entities.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
-- --// __index Bighead Main \\--
-- if not Main.Combat.BigHead.Enabled then return end
-- for Index, Player in pairs(game:GetService('Players'):GetPlayers()) do
--     if Player == LocalPlayer then continue end
--     if not Player.Character then continue end
--     local Character = Player.Character
--     pcall(function()
--         local Head = Character.Head
--     end)
-- end

-- --// __index Bighead \\--
-- local OldIndex, OldNamecall = nil, nil
-- OldIndex = hookmetamethod(game, "__index", function(Self, Index)
--     if Main.Combat.BigHead.Enabled and tostring(Self) == "Head" and Index == "Size" then
--         return Vector3.new(1.15, 1.15, 1.15)
--     end

--     return OldIndex(Self, Index)
-- end)

-- --// Thread Loop \\--
-- function NewThreadLoop(Wait, Function)
--     task.spawn(function()
--         while true do
--             local Delta = task.wait(Wait)
--             local Success, Error = pcall(Function, Delta)
--             if not Success then
--                 warn("thread error " .. Error)
--             elseif Error == "break" then
--                 break
--             end
--         end
--     end)
-- end

-- --// __Index Bighead Loop \\--
-- NewThreadLoop(1, function()
--     if not Main.Combat.BigHead.Enabled then return end
--     for Index, Player in pairs(game:GetService('Players'):GetPlayers()) do
--         if Player == LocalPlayer then continue end
--         if not Player.Character then continue end
--         local Character = Player.Character
--         local Head = Character.Head

--         pcall(function()
--             Head.Size = Vector3.new(Main.Combat.BigHead.Size, Main.Combat.BigHead.Size, Main.Combat.BigHead.Size)
--             Head.Transparency = Main.Combat.BigHead.Transparency
--             Head.CanCollide = true
--         end)
--     end
-- end)

do
    local player = game:GetService('Players').LocalPlayer
    local camera = game:GetService('Workspace').CurrentCamera
    local plr = player

    local function seewalls(pos, lookvector)
        if pos and lookvector then
            local ray = Ray.new(pos, (lookvector).Unit * 2)
            local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {plr.Character, camera})
            
            if part then
                return true
            else
                return false
            end 
        else
            return false
        end
    end
    RunService.Heartbeat:Connect(function()
        local chr = plr.Character
        if chr and chr:FindFirstChild("HumanoidRootPart") and chr:FindFirstChild("Head") then
            local hrp = chr:FindFirstChild("HumanoidRootPart")
            local head = chr:FindFirstChild("Head")
			local result
			--print(peek228)
			if Main.QOL.SpiderMan.Peek then
				result = seewalls(hrp.CFrame.p, hrp.CFrame.LookVector)
			else
				local cframe = hrp.CFrame * CFrame.new(0, -2.5, 0)
				result = seewalls(cframe.p, cframe.LookVector)
			end
            if Main.QOL.SpiderMan.Enabled and result then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, library.flags['Spiderman_Speed'], 0)
                wrap(function()for _, v in pairs(plr.Character:GetDescendants()) do
                    if v.IsA(v, "BasePart") then
                        v.Velocity, v.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
                    end
                end end)
            end
        end
    end)
end

--// Speedhack \\--
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local W, A, S, D
local xVelo, yVelo

RS.RenderStepped:Connect(function()
    if not Main.QOL.Speedhack.walkSpeedEnabled then
        return
    end

    local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP or not HRP.Velocity then
        return 
    end

    local C = game.Workspace.CurrentCamera
    local LV = C.CFrame.LookVector

    for i,v in pairs(UIS:GetKeysPressed()) do
        if v.KeyCode == Enum.KeyCode.W then
            W = true
        end
        if v.KeyCode == Enum.KeyCode.A then
            A = true
        end
        if v.KeyCode == Enum.KeyCode.S then
            S = true
        end
        if v.KeyCode == Enum.KeyCode.D then
            D = true
        end
    end

    if W == true and S == true then
        yVelo = false
        W,S = nil, nil
    end

    if A == true and D == true then
        xVelo = false
        A,D = nil, nil
    end

    if yVelo ~= false then
        if W == true then
            if xVelo ~= false then
                if A == true then
                    local LeftLV = (C.CFrame * CFrame.Angles(0, math.rad(45), 0)).LookVector
                    HRP.Velocity = Vector3.new((LeftLV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, (LeftLV.Z * library.flags['Speedhack_Speed']))
                    W,A = nil, nil
                else
                    if D == true then
                        local RightLV = (C.CFrame * CFrame.Angles(0, math.rad(-45), 0)).LookVector
                        HRP.Velocity = Vector3.new((RightLV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, (RightLV.Z * library.flags['Speedhack_Speed']))
                        W,D = nil, nil
                    end
                end
            end
        else
            if S == true then
                if xVelo ~= false then
                    if A == true then
                        local LeftLV = (C.CFrame * CFrame.Angles(0, math.rad(135), 0)).LookVector
                        HRP.Velocity = Vector3.new((LeftLV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, (LeftLV.Z * library.flags['Speedhack_Speed']))
                        S,A = nil, nil
                    else
                        if D == true then
                            local RightLV = (C.CFrame * CFrame.Angles(0, math.rad(-135), 0)).LookVector
                            HRP.Velocity = Vector3.new((RightLV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, (RightLV.Z * library.flags['Speedhack_Speed']))
                            S,D = nil, nil
                        end
                    end
                end
            end
        end
    end

    if W == true then
        HRP.Velocity = Vector3.new((LV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, (LV.Z * library.flags['Speedhack_Speed']))
    end
    if S == true then
        HRP.Velocity = Vector3.new(-(LV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, -(LV.Z * library.flags['Speedhack_Speed']))
    end
    if A == true then
        local LeftLV = (C.CFrame * CFrame.Angles(0, math.rad(90), 0)).LookVector
        HRP.Velocity = Vector3.new((LeftLV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, (LeftLV.Z * library.flags['Speedhack_Speed']))
    end
    if D == true then
        local RightLV = (C.CFrame * CFrame.Angles(0, math.rad(-90), 0)).LookVector
        HRP.Velocity = Vector3.new((RightLV.X * library.flags['Speedhack_Speed']), HRP.Velocity.Y, (RightLV.Z * library.flags['Speedhack_Speed']))
    end

    xVelo, yVelo, W, A, S, D = nil, nil, nil, nil, nil, nil
end)

do
    local window = library:new_window({size = Vector2.new(600,450)})
    local Combat = window:new_page({name = "Combat"})

    local Aimbot = Combat:new_section({
		name = "Aimbot",
		size = "Fill"
	});

    Aimbot:new_toggle({
        name = "Enabled",
        flag = "Aimbot_Enabled",
        callback = function(state)
            Main.Combat.Aimbot.Enabled = state
        end
    })
    
    Aimbot:new_toggle({
        name = "Teamcheck",
        flag = "Aimbot_Teamcheck",
        callback = function(state)
            Main.Combat.Aimbot.Aimbot_TeamCheck = state
        end
    })
    
    local smoothingAmount = 0
    
    Aimbot:new_slider({
        flag = "Smoothing_Amount",
        name = "Smoothing Amount",
        min = 0,
        max = 1,
        default = 0,
        float = 0.01,
        callback = function(value)
            smoothingAmount = value
        end
    })
    
    Aimbot:new_slider({
        flag = "Aimbot_Distance_Check",
        name = "Distance Check",
        min = 0,
        max = 10000,
        default = 1000,
        float = 1,
        callback = function(value)
            
        end
    })

	Aimbot:new_dropdown({
		flag = "Aim_Part",
		name = "Aim Part",
		options = {
			"Head",
			"UpperTorso",
			"LowerTorso"
		},
		default = "Head"
	});

	Aimbot:new_seperator({
		name = "FOV"
	});

    Aimbot:new_toggle({
		name = "Enabled",
		flag = "Aimbot_FOV",
		callback = function(state)
		end
	});

	Aimbot:new_slider({
		flag = "Fov_Radius",
		name = "Radius",
		min = 0,
		max = 1000,
		default = 80,
		float = 1
	});

	Aimbot:new_slider({
		flag = "Fov_Sides",
		name = "Sides",
		min = 3,
		max = 100,
		default = 100,
		float = 1
	});

	Aimbot:new_slider({
		flag = "Fov_Transparency",
		name = "Transparency",
		min = 0,
		max = 1,
		default = 1,
		float = 0.1
	});

	Aimbot:new_dropdown({
		flag = "Fov_Mode",
		name = "Fov Mode",
		options = {
			"static",
			"rainbow",
			"dual"
		},
		default = "rainbow"
	});

    local Extra = Combat:new_section({
		name = "Extra",
		size = "Fill",
        side = "right"
	});

    Extra:new_toggle({
		name = "Thick Bullet",
		flag = "Thickbullet_Enabled",
        risky = true,
		callback = function(state)
			
		end
	});

	Extra:new_slider({
		flag = "Thickbullet_size",
		name = "Size",
		min = 1,
		max = 5,
		default = 1,
		float = 0.1
	});

    Extra:new_seperator({
		name = "Gun Mods"
	});

    Extra:new_toggle({
		name = "No Spread",
		flag = "No_Spread",
        risky = true,
		callback = function(state)
			
		end
	});

    Extra:new_toggle({
		name = "No Recoil",
		flag = "No_Recoil",
        risky = true,
		callback = function(state)
			
		end
	});

	Extra:new_slider({
		flag = "Recoil_Amount",
		name = "Recoil %",
		min = 0,
		max = 100,
		default = 100,
		float = 1
	});

--// Animated Fov \\--
local settings = {
    enabled = library.flags['Aimbot_FOV'],
    circleTransparency = library.flags['Fov_Transparency'],
    radius = library.flags['Fov_Radius'],
    sides = library.flags['Fov_Sides'],
    mode = library.flags['Fov_Mode'], -- "static", "rainbow", "dual"
    primaryColor = Color3.fromRGB(255, 135, 255),
    secondaryColor = Color3.fromRGB(1,1,1),
    offset = Vector2.new(0, 40),
    dualPortion = 1/2,
    dualSpeed = 0.08
}

local runservice = game:GetService('RunService')
local camera = game.Workspace.CurrentCamera
local tau = math.pi * 2
local drawings = {}
local rotationCounter = 10

for i = 1, settings.sides do
    drawings[i] = { Drawing.new('Line') }
    drawings[i][1].ZIndex = 2
    drawings[i][1].Thickness = 2
end

local mouse = game.Players.LocalPlayer:GetMouse()

runservice.RenderStepped:Connect(function()
    local pass = settings.enabled
    local mouseX, mouseY = mouse.X, mouse.Y
    local fovScalingFactor = 1 / math.tan(math.rad(camera.FieldOfView / 2)) * library.flags['Fov_Radius']

    if settings.mode == "dual" then
        rotationCounter = (rotationCounter + settings.dualSpeed) % 1
    end

    for i = 1, #drawings do
        local line = drawings[i][1]

        if pass then
            local color
            if settings.mode == "rainbow" then
                color = Color3.fromHSV((tick() % 5 / 5 - (i / #drawings)) % 1, 0.5, 1)
            elseif settings.mode == "dual" then
                local currentPortion = i / settings.sides
                if currentPortion > rotationCounter and currentPortion < rotationCounter + settings.dualPortion then
                    color = settings.primaryColor
                else
                    color = settings.secondaryColor
                end
            else
                color = settings.primaryColor
            end
            
            local centerX, centerY = mouseX, mouseY
            local pos = Vector2.new(centerX, centerY) + settings.offset
            local last, next = (i / settings.sides) * tau, ((i + 1) / settings.sides) * tau
            local lastX = pos.X + math.cos(last) * fovScalingFactor
            local lastY = pos.Y + math.sin(last) * fovScalingFactor
            local nextX = pos.X + math.cos(next) * fovScalingFactor
            local nextY = pos.Y + math.sin(next) * fovScalingFactor
            line.From = Vector2.new(lastX, lastY)
            line.To = Vector2.new(nextX, nextY)
            line.Color = color
            line.Transparency = settings.circleTransparency
            line.Visible = true
        else
            line.Visible = false
        end
    end
end)

local BulletSpeeds = {
    M4a1 = 2100,
    Ak47 = 2100,
    M14 = 2100,
    P250 = 1400,
    Skorpion = 1600,
    Smg = 1800,
    Python = 1800,
    PipeRifle = 1700,
    Pkm = 2400,
    Berrette = 2400,
    Crossy = 680,
    Bow = 260 --0.2
}

local Guns = {
    "M4a1",
    "Ak47",
    "M14",
    "P250",
    "Skorpion",
    "Smg",
    "Python",
    "PipeRifle",
    "Pkm",
    "Berrette",
    "Crossy",
    "Bow"
}

local currentGunIndex = 1
local currentGunName = Guns[currentGunIndex]

local bulletSpeed = BulletSpeeds[currentGunName]

function UpdateGunText()
    currentGunName = Guns[currentGunIndex]
    if currentGunName then
        bulletSpeed = BulletSpeeds[currentGunName]
        print("Current Gun: " .. currentGunName .. ", Bullet Speed: " .. bulletSpeed)
    else
        warn("Current gun is nil")
    end
end

function OnKeyPress(input)
    if input.KeyCode == Enum.KeyCode.RightBracket then
        currentGunIndex = currentGunIndex % #Guns + 1
        UpdateGunText()
    end
end

UpdateGunText()

local gravity = 40

function OnKeyPress(input)
    if input.KeyCode == Enum.KeyCode.RightBracket then
        currentGunIndex = currentGunIndex % #Guns + 1
        UpdateGunText()
    end
end

UpdateGunText()
game:GetService("UserInputService").InputBegan:Connect(OnKeyPress)

UIS.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        Main.Combat.Aimbot.Aiming = true
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        Main.Combat.Aimbot.Aiming = false
    end
end)

RunService.RenderStepped:Connect(function()
    local dist = math.huge
    local closest_char = nil

    if Main.Combat.Aimbot.Aiming then
        for i, v in next, Entities:GetChildren() do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild('HumanoidRootPart') and v.Character:FindFirstChild('Humanoid') and v.Character:FindFirstChild('Humanoid').Health > 0 then
                if Main.Combat.Aimbot.Aimbot_TeamCheck == true and v.Team ~= LocalPlayer.Team or Main.Combat.Aimbot.Aimbot_TeamCheck == false then
                    local char = v.Character
                    local char_part_pos, is_onscreen = Camera:WorldToViewportPoint(char[Main.Combat.Aimbot.Aimbot_AimPart].Position)
                    if is_onscreen then
                        local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(char_part_pos.X, char_part_pos.Y)).Magnitude
                        if mag < dist and mag < library.flags['Fov_Radius'] then
                            dist = mag
                            closest_char = char
                        end
                    end
                end
            end
        end

        if closest_char ~= nil and closest_char:FindFirstChild('HumanoidRootPart') and closest_char:FindFirstChild('Humanoid') and closest_char:FindFirstChild('Humanoid').Health > 0 then
            local enemyPos = closest_char[Main.Combat.Aimbot.Aimbot_AimPart].Position
            local myPos = Camera.CFrame.Position
            local distance = (enemyPos - myPos).Magnitude
            local timeToTarget = distance / bulletSpeed
            local movePrediction = closest_char.HumanoidRootPart.Velocity * timeToTarget
            local predictedPos = enemyPos + movePrediction
            local compensatedPos = predictedPos + Vector3.new(0, gravity * timeToTarget ^ 1.7, 0)
            local aimDirection = (compensatedPos - myPos).Unit

            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, compensatedPos), 1 - smoothingAmount)
        end
    end
end)

    local Visuals = window:new_page({name = "Visuals"})

    local Humans = Visuals:new_section({
		name = "Humans",
		size = "Fill",
	});

    local function ApplyESP(v)
        if library.flags['Humans_Enabled'] and v.Character and v.Character:FindFirstChildOfClass('Humanoid') then
            if Main.ESP.Names then
                v.Character.Humanoid.NameDisplayDistance = library.flags['Human_Render_Distance']
            else
                v.Character.Humanoid.NameDisplayDistance = 0
            end
            
            if Main.ESP.Health then
                v.Character.Humanoid.HealthDisplayDistance = library.flags['Human_Render_Distance']
            else
                v.Character.Humanoid.HealthDisplayDistance = 0
            end
            
            v.Character.Humanoid.NameOcclusion = "NoOcclusion"
            v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
            v.Character.Humanoid.Health = v.Character.Humanoid.Health
        else
            if v.Character then
                v.Character.Humanoid.NameDisplayDistance = 0
                v.Character.Humanoid.HealthDisplayDistance = 0
            end
        end
    end
    
    local function UpdateESP()
        for _, player in ipairs(game:GetService('Players'):GetPlayers()) do
            ApplyESP(player)
        end
    end
    
    local function AddESPToNewPlayer(player)
        if library.flags['Humans_Enabled'] then
            ApplyESP(player)
        end
    end
    
    game:GetService('Players').PlayerAdded:Connect(AddESPToNewPlayer)
    
    local function ToggleESP(state)
        library.flags['Humans_Enabled'] = state
        UpdateESP()
    end
    
    local function UpdateRenderDistance(renderDistance)
        UpdateESP()
    end
    
    local function OnRenderStep()
        UpdateESP()
    end
    
    game:GetService('RunService').RenderStepped:Connect(OnRenderStep)
    
    Humans:new_toggle({
        name = "Enabled",
        flag = "Humans_Enabled",
        callback = ToggleESP
    })
    
    Humans:new_toggle({
        name = "Names",
        flag = "Humans_Names",
        callback = function(state)
            Main.ESP.Names = state
            UpdateESP()
        end
    })
    
    Humans:new_toggle({
        name = "Healthbars",
        flag = "Humans_Healthbars",
        callback = function(state)
            Main.ESP.Health = state
            UpdateESP()
        end
    })
    
    Humans:new_toggle({
        name = "Sleepers",
        flag = "Humans_Sleepers",
        callback = function(state)
            Main.ESP.Sleepers = state
            UpdateESP()
        end
    })
    
    Humans:new_slider({
        flag = "Human_Render_Distance",
        name = "Render Distance",
        min = 0,
        max = 10000,
        default = 3000,
        float = 1,
        callback = UpdateRenderDistance
    })

    local Misc = window:new_page({name = "Misc"})

    local Global = Misc:new_section({
		name = "Global",
		size = "Fill",
        side = "right"
	});

local Light = game:GetService("Lighting")

function dofullbright()
  Light.Ambient = Color3.new(1,1,1)
  Light.ColorShift_Bottom = Color3.new(1, 1, 1)
  Light.ColorShift_Top = Color3.new(1, 1, 1)
end

function resetLighting()
  Light.Ambient = Color3.new(0,0,0)
  Light.ColorShift_Bottom = Color3.new(0,0,0)
  Light.ColorShift_Top = Color3.new(0,0,0)
end

local connection

    Global:new_toggle({
		name = "Fullbright",
		flag = "Fullbright_Enabled",
		callback = function(state)
			if state then
                dofullbright()
                connection = Light:GetPropertyChangedSignal("Ambient"):Connect(dofullbright)
            else
                if connection then
                    connection:Disconnect()
                    resetLighting()
                end
            end
		end
	});

    Global:new_toggle({
		name = "No Grass",
		flag = "No_Grass",
		callback = function(state)
            sethiddenproperty(game:GetService("Workspace").Terrain, "Decoration", not state)
		end
	});

    local atmosphereConnection

    local lighting = game:GetService("Lighting")
    if prop == "Density" then
        lighting.Atmosphere.Density = 0
    end

    Global:new_toggle({
        name = "No Fog",
        flag = "No_Fog",
        callback = function(state)
            if state then
                if not atmosphereConnection then
                    atmosphereConnection = lighting.Atmosphere.Changed:Connect(function(prop)
                        if prop == "Density" then
                            lighting.Atmosphere.Density = 0
                        end
                        lighting.FogEnd = 10000000
                    end)
                end
            else
                if atmosphereConnection then
                    atmosphereConnection:Disconnect()
                    atmosphereConnection = nil
                end
                lighting.FogEnd = 500
            end
        end
    })    

    Global:new_toggle({
		name = "No Shadows",
		flag = "No_Shadows",
		callback = function(state)
			game:GetService('Lighting').GlobalShadows = not state
		end
	});

    local Exploits = Misc:new_section({
		name = "Exploits",
		size = "Fill",
	});

    Exploits:new_toggle({
		name = "Spiderman",
		flag = "Spiderman_Enabled",
		callback = function(state)
			Main.QOL.SpiderMan.Enabled = state
		end
	});

    Exploits:new_toggle({
		name = "Peek",
		flag = "Spiderman_Peek",
		callback = function(state)
			Main.QOL.SpiderMan.Peek = state
		end
	});

	Exploits:new_slider({
		flag = "Spiderman_Speed",
		name = "Speed",
		min = 0,
		max = 1,
		default = 1,
		float = 0.1
	});

    Exploits:new_toggle({
		name = "Keybind Enabled",
		flag = "Spiderman_KeybindTrue",
		callback = function(state)
			Main.QOL.SpiderMan.KeybindEnabled = state
		end
	});

	Exploits:new_keybind({
		name = "Keybind",
		flag = "Spiderman_Keybind",
		default = Enum.KeyCode.V,
		mode = "Hold",
		ignore = true,
		callback = function()
			
		end
	});

	Exploits:new_seperator({
		name = "Speedhack"
	});

    Exploits:new_toggle({
		name = "Enabled",
		flag = "Speedhack_Enabled",
        risky = true,
		callback = function(state)
			Main.QOL.Speedhack.walkSpeedEnabled = state
		end
	});

	Exploits:new_slider({
		flag = "Speedhack_Speed",
		name = "Speed",
		min = 28,
		max = 60,
		default = 28,
		float = 0.5
	});

	Exploits:new_seperator({
		name = "Flyhack [7 seconds]"
	});

    Exploits:new_toggle({
		name = "Enabled",
		flag = "Flyhack_Enabled",
        risky = true,
		callback = function(state)
			if state then
                --loadstring(game:HttpGet(('https://xyzontop.win/script/FlyThing2222.lua'),true))()
            else
                for i,v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("Part") then
                        if v:FindFirstChild("BodyVelocity") then
                            v:Destroy()
                        end
                    end
                end
            end
		end
	});

	Exploits:new_seperator({
		name = "Spinbot"
	});

    Exploits:new_toggle({
		name = "Enabled",
		flag = "Spinbot_Enabled",
        risky = true,
		callback = function(state)
		end
	});

    Exploits:new_toggle({
		name = "No Rotation",
		flag = "No_Rotation",
        risky = true,
		callback = function(state)
            LocalPlayer.Character.Humanoid.AutoRotate = not state
        end
	});

	Exploits:new_slider({
		flag = "Spinbot_Speed",
		name = "Spin Speed",
		min = 0,
		max = 200,
		default = 125,
		float = 1
	});

--// Spinbot \\--
RunService.RenderStepped:Connect(function(dt)
    if library.flags['Spinbot_Enabled'] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        local rotation = CFrame.Angles(0, library.flags['Spinbot_Speed'] * dt, 0)
        rootPart.CFrame = rootPart.CFrame * rotation
    end
end)

local Watermark = Drawing.new("Text")
Watermark.Color = Color3.new(1, 1, 1)
Watermark.Outline = true
Watermark.Size = 24
Watermark.Center = true
Watermark.Visible = true

local function updateWatermarkPosition()
    local screenWidth = game:GetService('GuiService'):GetScreenResolution().X
    local screenHeight = game:GetService('GuiService'):GetScreenResolution().Y
    local watermarkWidth = Watermark.TextBounds.X
    local watermarkHeight = Watermark.TextBounds.Y

    local xPos = (screenWidth - watermarkWidth) / 2 + (watermarkWidth / 2)
    local yPos = screenHeight - watermarkHeight - 200

    Watermark.Position = Vector2.new(xPos, yPos)
end

game:GetService('RunService').RenderStepped:Connect(function()
    if currentGunName then
        Watermark.Text = "Current Gun: " .. tostring(currentGunName)
    else
        Watermark.Text = "Gun: nil"
    end
    updateWatermarkPosition()
end)

game:GetService('RunService').Stepped:Connect(function()
    if Watermark then
        Watermark:Remove()
        Watermark = Drawing.new("Text")
        Watermark.Color = Color3.new(1, 1, 1)
        Watermark.Outline = true
        Watermark.Size = 24
        Watermark.Center = true
        Watermark.Visible = true
    end
end)

    local page = window:new_page({name = "Settings"})
	local accent = page:new_section({
		name = "theme",
		size = "Fill"
	});
	local theme_pickers = {};
	theme_pickers.Accent = accent:new_colorpicker({
		name = "accent",
		flag = "theme_accent",
		default = theme["Default"].Accent,
		callback = function(state)
			library:ChangeThemeOption("Accent", state);
		end
	});
	theme_pickers["Window Outline Background"] = accent:new_colorpicker({
		name = "window outline",
		flag = "theme_outline",
		default = theme["Default"]["Window Outline Background"],
		callback = function(state)
			library:ChangeThemeOption("Window Outline Background", state);
		end
	});
	theme_pickers["Window Inline Background"] = accent:new_colorpicker({
		name = "window inline",
		flag = "theme_inline",
		default = theme["Default"]["Window Inline Background"],
		callback = function(state)
			library:ChangeThemeOption("Window Inline Background", state);
		end
	});
	theme_pickers["Window Holder Background"] = accent:new_colorpicker({
		name = "window holder",
		flag = "theme_holder",
		default = theme["Default"]["Window Holder Background"],
		callback = function(state)
			library:ChangeThemeOption("Window Holder Background", state);
		end
	});
	theme_pickers["Window Border"] = accent:new_colorpicker({
		name = "window border",
		flag = "theme_border",
		default = theme["Default"]["Window Border"],
		callback = function(state)
			library:ChangeThemeOption("Window Border", state);
		end
	});
	theme_pickers["Page Selected"] = accent:new_colorpicker({
		name = "page selected",
		flag = "theme_selected",
		default = theme["Default"]["Page Selected"],
		callback = function(state)
			library:ChangeThemeOption("Page Selected", state);
		end
	});
	theme_pickers["Page Unselected"] = accent:new_colorpicker({
		name = "page unselected",
		flag = "theme_unselected",
		default = theme["Default"]["Page Unselected"],
		callback = function(state)
			library:ChangeThemeOption("Page Unselected", state);
		end
	});
	theme_pickers["Section Inner Border"] = accent:new_colorpicker({
		name = "border 1",
		flag = "theme_border1",
		default = theme["Default"]["Section Inner Border"],
		callback = function(state)
			library:ChangeThemeOption("Section Inner Border", state);
		end
	});
	theme_pickers["Section Outer Border"] = accent:new_colorpicker({
		name = "border 2",
		flag = "theme_border2",
		default = theme["Default"]["Section Outer Border"],
		callback = function(state)
			library:ChangeThemeOption("Section Outer Border", state);
		end
	});
	theme_pickers["Section Background"] = accent:new_colorpicker({
		name = "section background",
		flag = "theme_section",
		default = theme["Default"]["Section Background"],
		callback = function(state)
			library:ChangeThemeOption("Section Background", state);
		end
	});
	theme_pickers.Text = accent:new_colorpicker({
		name = "text",
		flag = "theme_text",
		default = theme["Default"].Text,
		callback = function(state)
			library:ChangeThemeOption("Text", state);
		end
	});
	theme_pickers["Risky Text"] = accent:new_colorpicker({
		name = "risky text",
		flag = "theme_risky",
		default = theme["Default"]["Risky Text"],
		callback = function(state)
			library:ChangeThemeOption("Risky Text", state);
		end
	});
	theme_pickers["Object Background"] = accent:new_colorpicker({
		name = "element background",
		flag = "theme_element",
		default = theme["Default"]["Object Background"],
		callback = function(state)
			library:ChangeThemeOption("Object Background", state);
		end
	});
	accent:new_dropdown({
		flag = "settings/menu/effects",
		name = "accent effects",
		options = {
			"None",
			"rainbow",
			"shift",
			"reverse shift"
		},
		default = "none"
	});
	accent:new_slider({
		flag = "settings/menu/effect_speed",
		name = "effect speed",
		min = 0,
		max = 2,
		default = 1,
		float = 0.1
	});
	(game:GetService("RunService")).Heartbeat:Connect(function()
		local AccentEffect = library.flags["settings/menu/effects"];
		local EffectSpeed = library.flags["settings/menu/effect_speed"];
		if AccentEffect == "rainbow" then
			local Clock = os.clock() * EffectSpeed;
			local Color = Color3.fromHSV(math.abs(math.sin(Clock)), 1, 1);
			library:ChangeThemeOption("Accent", Color);
		end;
		if AccentEffect == "shift" then
			local ShiftOffset = 0;
			local Clock = os.clock() * EffectSpeed + ShiftOffset;
			ShiftOffset = ShiftOffset + 0;
			local Color = Color3.fromHSV(math.abs(math.sin(Clock)), 1, 1);
			library.flags.theme_accent = Color;
			library:ChangeThemeOption("Accent", Color);
		end;
		if AccentEffect == "reverse shift" then
			local ShiftOffset = 0;
			local Clock = os.clock() * EffectSpeed + ShiftOffset;
			ShiftOffset = ShiftOffset - 0;
			local Color = Color3.fromHSV(math.abs(math.sin(Clock)), 1, 1);
			library.flags.theme_accent = Color;
			library:ChangeThemeOption("Accent", Color);
		end;
	end);
	local menu_other = page:new_section({
		name = "Other",
		size = "Fill",
		side = "right"
	});
	menu_other:new_keybind({
		name = "open / close",
		flag = "menu_toggle",
		default = Enum.KeyCode.End,
		mode = "Toggle",
		ignore = true,
		callback = function()
			library:Close();
		end
	});
	menu_other:new_toggle({
		name = "show keybinds list",
		flag = "keybind_list",
		callback = function(state)
			window:set_keybind_list_visibility(state);
		end
	});
	library:Close();
	menu_other:new_seperator({
		name = "theme"
	});
	local theme_tbl = {};
	for i, v in next, theme do
		table.insert(theme_tbl, i);
	end;
	menu_other:new_dropdown({
		name = "select theme:",
		flag = "theme_list",
		options = theme_tbl
	});
	menu_other:new_button({
		name = "load theme",
		callback = function()
			library:SetTheme(theme[library.flags.theme_list]);
			for option, picker in next, theme_pickers do
				picker:set(theme[library.flags.theme_list][option]);
			end;
		end
	});
	menu_other:new_seperator({
		name = "server"
	});
	menu_other:new_button({
		name = "rejoin",
		confirm = true,
		callback = function()
			(game:GetService("TeleportService")):TeleportToPlaceInstance(game.PlaceId, game.JobId);
		end
	});
	menu_other:new_button({
		name = "copy join script",
		callback = function()
			setclipboard(("game:GetService(\"TeleportService\"):TeleportToPlaceInstance(%s, \"%s\")"):format(game.PlaceId, game.JobId));
		end
	});
    library.notify("Press RightBracket (]) to scroll through guns!", 5);
end;
