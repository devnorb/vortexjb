getgenv().box = true
local function robBox()
        game.Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(workspace:GetChildren()[19].Box.Handle.Position)
        task.wait(0.5)
        fireproximityprompt(workspace:GetChildren()[19].Box.Handle.ProximityPrompt, 1, 3)
        task.wait(0.5)
        game.Players.LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-957.1035766601562, 253.53968811035156,
            -969.6851806640625)
        task.wait(0.5)
        game.Players.LocalPlayer.Backpack.Box.Parent = workspace[game.Players.LocalPlayer.Name]
        task.wait(0.5)
end

if getgenv().box then
    repeat
        pcall(function()
            robBox()
        end)
    until getgenv().box == false
end
