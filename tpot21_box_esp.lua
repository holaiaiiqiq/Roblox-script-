-- TPOT21 Box ESP (Loader)
-- Compatible con Delta

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local workspace = game:GetService("Workspace")

local ESP_COLOR = Color3.fromRGB(0, 255, 100)

for _,v in pairs(workspace:GetDescendants()) do
    if v:IsA("Highlight") and v.Name == "CorrectBoxESP" then
        v:Destroy()
    end
end

local function espBox(box)
    if box:FindFirstChild("CorrectBoxESP") then return end
    local h = Instance.new("Highlight")
    h.Name = "CorrectBoxESP"
    h.FillColor = ESP_COLOR
    h.OutlineColor = Color3.new(1,1,1)
    h.FillTransparency = 0.3
    h.OutlineTransparency = 0
    h.Adornee = box
    h.Parent = box
end

local function scanBoxes()
    for _,box in pairs(workspace:GetDescendants()) do
        if box:IsA("Model") or box:IsA("Part") then
            for _,child in pairs(box:GetDescendants()) do
                if child.Name:lower():find("cake")
                or child.Name:lower():find("pastel")
                or child.Name:lower():find("sandwich")
                or child:IsA("TouchTransmitter") then
                    espBox(box)
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        scanBoxes()
        task.wait(1)
    end
end)

print("✅ TPOT21 Box ESP activo")
