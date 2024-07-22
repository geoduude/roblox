repeat task.wait() until game:IsLoaded()

local LocalPlayer = game.Players.LocalPlayer

function TweenTo(Position, WaitToEnd)
    local Tween = game:GetService("TweenService"):Create(LocalPlayer.Character.Collision, TweenInfo.new((LocalPlayer.Character.Collision.Position - Position).Magnitude / 21, Enum.EasingStyle.Linear), {["CFrame"] = Position})
    Tween:Play()
    
    if WaitToEnd then
        Tween.Completed:Wait()
    end
end

local GC = getconnections or get_signal_cons
if GC then
    for _,v in pairs(GC(LocalPlayer.Idled)) do
        if v["Disable"] then
            v["Disable"](v)
        elseif v["Disconnect"] then
            v["Disconnect"](v)
        end
    end
end

repeat task.wait() until LocalPlayer.PlayerGui:FindFirstChild("MainUI") and LocalPlayer.Character
task.wait(3)

queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/geoduude/roblox/master/deathfarmeff.lua'))()")

game.ReplicatedStorage.RemotesFolder.PreRunShop:FireServer()
repeat task.wait() fireproximityprompt(workspace.CurrentRooms["0"].StarterElevator.Model.Model.SkipButton.SkipPrompt) until not workspace.CurrentRooms["0"].StarterElevator.Model.Model.SkipButton.SkipPrompt.Enabled

local Heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
    LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
    LocalPlayer.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
end)
LocalPlayer.Character.Collision.CanCollide = false
LocalPlayer.Character.Humanoid:SetAttribute("Stunned", true)

local Tween = game:GetService("TweenService"):Create(LocalPlayer.Character.Collision, TweenInfo.new((LocalPlayer.Character.Collision.Position - Vector3.new(0, 2, -6)).Magnitude / 20, Enum.EasingStyle.Linear), {["CFrame"] = CFrame.new(0, 2, -6)})
Tween:Play()
Tween.Completed:Wait()

local TweenToKey = game:GetService("TweenService"):Create(LocalPlayer.Character.Collision, TweenInfo.new((LocalPlayer.Character.Collision.Position - Vector3.new(-11.5, 2, -45)).Magnitude / 20, Enum.EasingStyle.Linear), {["CFrame"] = CFrame.new(-11.5, 2, -45)})
TweenToKey:Play()

repeat task.wait()
    fireproximityprompt(workspace.CurrentRooms["0"].Assets.KeyObtain.ModulePrompt)
until LocalPlayer.Character:FindFirstChild("Key")
TweenToKey:Pause()

local PrepareTweenToDoor = game:GetService("TweenService"):Create(LocalPlayer.Character.Collision, TweenInfo.new((LocalPlayer.Character.Collision.Position - Vector3.new(-4, 2, -48.7)).Magnitude / 20, Enum.EasingStyle.Linear), {["CFrame"] = CFrame.new(-4, 2, -48.7)})
PrepareTweenToDoor:Play()
PrepareTweenToDoor.Completed:Wait()

local TweenToDoor = game:GetService("TweenService"):Create(LocalPlayer.Character.Collision, TweenInfo.new((LocalPlayer.Character.Collision.Position - Vector3.new(15.7, 2, -48.7)).Magnitude / 20, Enum.EasingStyle.Linear), {["CFrame"] = CFrame.new(15.7, 2, -48.7)})
TweenToDoor:Play()

repeat task.wait()
    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentRooms["0"].Door.Lock.Position)
    workspace.CurrentRooms["0"].Door.Lock.UnlockPrompt:InputHoldBegin()
until not workspace.CurrentRooms["0"].Door.Lock.UnlockPrompt.Enabled
TweenToDoor:Pause()

LocalPlayer.Character.Humanoid.Health = 0
Heartbeat:Disconnect()

-- death farm

game.Lighting.ChildAdded:Connect(function(v)
    task.wait()

    if v.Name == "TempCC" then
        v:Destroy()
    end
end)
game.ReplicatedStorage.ClientModules.ReviveCutscene.Name = "_ReviveCutscene"

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/geoduude/LinoriaLib/main/Library.lua'))()
local TimeLimit = tick() -- 1200 seconds = 20 minutes

repeat task.wait() until not LocalPlayer:GetAttribute("Alive")
while true do
    if (tick() - TimeLimit) > 1200 then
        Library:Notify("[LOLHAX] You've reached 20 minutes, replaying..")
        game.ReplicatedStorage.RemotesFolder.PlayAgain:FireServer()
        task.wait(9e9)
    end

    game.ReplicatedStorage.RemotesFolder.Revive:FireServer()

    local ReviveSpam = LocalPlayer.CharacterAdded:Connect(function(v)
        v:WaitForChild("Humanoid",9e9)

        repeat task.wait() until LocalPlayer:GetAttribute("Alive")
        repeat task.wait() v.Humanoid.Health = 0 until not LocalPlayer:GetAttribute("Alive")

        game.ReplicatedStorage.RemotesFolder.Statistics:FireServer()
        game.ReplicatedStorage.RemotesFolder.Revive:FireServer()
    end)

    task.wait(15)
    ReviveSpam:Disconnect()

    task.wait(1)
    local DeathSpam = game:GetService("RunService").RenderStepped:Connect(function()
        LocalPlayer.Character.Humanoid.Health = 0
    end)

    task.wait(3)

    Library:Notify("[LOLHAX] You now have '"..require(game.ReplicatedStorage.ReplicaDataModule).data.Stats.Deaths.."' death count", 24)

    DeathSpam:Disconnect()
    task.wait(24)
end
