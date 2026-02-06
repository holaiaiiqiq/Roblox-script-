
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local workspace = game:GetService("Workspace")

local COLOR = Color3.fromRGB(0, 255, 255)
local highlights = {}

local function clear()
    for _,h in pairs(highlights) do
        if h then h:Destroy() end
    end
    highlights = {}
end

local function isBox(part)
    return part:IsA("Part")
       and part.Size.X > 3
       and part.Size.Y > 3
       and part.Size.Z > 3
       and part:FindFirstChildOfClass("SurfaceGui")
end

local function esp(part)
    local h = Instance.new("Highlight")
    h.FillColor = COLOR
    h.OutlineColor = Color3.new(1,1,1)
    h.FillTransparency = 0.4
    h.OutlineTransparency = 0
    h.Adornee = part
    h.Parent = part
    table.insert(highlights, h)
end

task.spawn(function()
    while true do
        clear()
        for _,v in pairs(workspace:GetDescendants()) do
            if isBox(v) then
                esp(v)
            end
        end
        task.wait(2)
    end
end)

print("✅ TPOT21 Box ESP cargado")

