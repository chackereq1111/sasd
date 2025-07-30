local loaded = false



task.spawn(function()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    loaded = true
end)

for i = 1, 50 do
    if loaded then break end
    task.wait(0.1)
end

if not loaded then
    task.wait(5)
end


loadstring(game:HttpGet("https://raw.githubusercontent.com/tls123account/StarStream/refs/heads/main/Hub"))()


task.delay(1, function()
    repeat wait() until game.Players.LocalPlayer
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    local VirtualInputManager = game:GetService("VirtualInputManager")
    local RunService = game:GetService("RunService")

    local threshold = 5 
    local idleTime = 0
    local lastPosition = character:WaitForChild("HumanoidRootPart").Position

    local alreadyTriggered = false 
    local connection

    connection = RunService.RenderStepped:Connect(function(dt)
        if alreadyTriggered then
            connection:Disconnect()
            print("✅ Skrypt wyłączony po pierwszym kliknięciu Q")
            return
        end

        character = player.Character
        if not character then return end

        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end

        local currentPosition = rootPart.Position
        local distance = (currentPosition - lastPosition).Magnitude

        if distance < threshold then
            idleTime += dt
        else
            idleTime = 0
            lastPosition = currentPosition
        end

        if idleTime >= 5 then
            idleTime = 0
            alreadyTriggered = true
            print("🌀 Orbituję — klikam Q (tylko raz)")
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
        end
    end)
end)


task.spawn(function()
    repeat wait() until game.Players.LocalPlayer
    local VirtualInputManager = game:GetService("VirtualInputManager")


    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Six, false, game)
    print("🔹 Wysłano kliknięcie 6 po inject")


    while true do
        task.wait(120)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Six, false, game)
        print("🔁 Wysłano kliknięcie 6 po 2 minutach")
    end
end)
