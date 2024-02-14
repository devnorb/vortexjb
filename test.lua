-- getgenv().rice = true
-- getgenv().car = true
-- getgenv().box = true
-- JUST REMOVE THE -- TO ENABLE
repeat
    task.wait()
until game:IsLoaded()
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local robbingRice = false
local rice
local robbedCars
local notif = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Jailbreak/Notification/Source.lua"))()

Lighting.Brightness = 1
Lighting.ClockTime = 12
Lighting.FogEnd = 786543
Lighting.GlobalShadows = false
Lighting.Ambient = Color3.fromRGB(178, 178, 178)

local function teleport()
    if getgenv().rice then
        queue_on_teleport([[
            getgenv().rice = true
            repeat task.wait() until game:IsLoaded()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/devnorb/vortexjb/main/test.lua"))()
        ]])
    end
    if getgenv().box then
        queue_on_teleport([[
            getgenv().box = true
            repeat task.wait() until game:IsLoaded()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/devnorb/vortexjb/main/test.lua"))()
        ]])
    end
    if getgenv().car then
        queue_on_teleport([[
            getgenv().car = true
            repeat task.wait() until game:IsLoaded()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/devnorb/vortexjb/main/test.lua"))()
        ]])
    end
    local Servers = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local Server, Next = nil, nil
    local function ListServers(cursor)
        local Raw = game:HttpGet(Servers .. ((cursor and "&cursor=" .. cursor) or ""))
        return HttpService:JSONDecode(Raw)
    end

    repeat
        local Servers = ListServers(Next)
        Server = Servers.data[math.random(1, (#Servers.data / 3))]
        Next = Servers.nextPageCursor
    until Server

    if Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id, Players.LocalPlayer)
    end
end

local function ErrorHandler(func)
    local S, R = pcall(func)

    if not S and R then
        teleport()
    end

    return S, R
end

Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    teleport()
end)

local function robCars()
    ErrorHandler(function()
        for i, v in workspace["CAR ROBBERY"]:GetChildren() do
            local a = v.E2Start.Position or v.WindowBreak.Position or v.Promt2
            Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(a)
            task.wait(0.5)
            fireproximityprompt(v.E2Start.StartRobbery, 1, 3)
            task.wait(0.5)
            fireproximityprompt(v.Promt2.TakeCash, 1, 3)
            print("Finished robbing cars")
            robbedCars = true
        end
    end)
end

local function getTheRice()
    ErrorHandler(function()
        if workspace.GUNS.RiceBag.Over.Sign.SurfaceGui.SIGN.Text == "0 Bags Left" then
            notif.new({
                Text = "No Rice Bags left!",
                Duration = 3
            })
            teleport()
        end

        Players.LocalPlayer.Backpack.ChildAdded:Connect(function(v)
            if robbingRice then
                if tostring(v):find("Small") then
                    rice = "small"
                elseif tostring(v):find("Medium") then
                    rice = "medium"
                elseif tostring(v):find("Large") then
                    rice = "large"
                end
            end
        end)

        Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame =
            CFrame.new(-460.54150390625, 379.0788879394531, -800.749267578125)
        task.wait(0.5)
        fireproximityprompt(workspace.GUNS.RiceBag.Over.Sign.BuyPrompt, 1, 3)
        task.wait(0.5)
        robbingRice = true
        Players.LocalPlayer.Backpack:FindFirstChild("RiceBag").Parent = workspace[Players.LocalPlayer.Name]
        Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-463, 379, -800)
        task.wait(0.3)
        fireproximityprompt(workspace.Map.RandomStuff:GetChildren()[286].Pront.CookPart.ProximityPrompt, 1, 3)
        repeat
            task.wait()
        until rice
        Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-566, 253, -764)
        if rice == "small" then
            Players.LocalPlayer.Backpack:FindFirstChild("SmallRice").Parent = workspace[Players.LocalPlayer.Name]
        elseif rice == "medium" then
            Players.LocalPlayer.Backpack:FindFirstChild("MediumRice").Parent = workspace[Players.LocalPlayer.Name]
        elseif rice == "large" then
            Players.LocalPlayer.Backpack:FindFirstChild("LargeRice").Parent = workspace[Players.LocalPlayer.Name]
        end
        task.wait(0.5)
        fireproximityprompt(workspace.Sell.ProximityPrompt, 1, 3)
        robbingRice = false
        rice = nil
        task.wait(0.5)
    end)
end

local function robBox()
    ErrorHandler(function()
        Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(workspace:GetChildren()[19].Box.Handle.Position)
        task.wait(0.5)
        fireproximityprompt(workspace:GetChildren()[19].Box.Handle.ProximityPrompt, 1, 3)
        task.wait(0.5)
        Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-957.1035766601562, 253.53968811035156,
            -969.6851806640625)
        task.wait(0.5)
        Players.LocalPlayer.Backpack.Box.Parent = workspace[Players.LocalPlayer.Name]
        task.wait(0.5)
    end)
end

if getgenv().car then
    if robbedCars then
        notif.new({
            Text = "Cars have already been robbed!",
            Duration = 3
        })
        return
    end
    robCars()
end

if getgenv().rice then
    repeat
        getTheRice()
    until getgenv().rice == false
end

if getgenv().box then
    repeat
        robBox()
    until getgenv().box == false
end
