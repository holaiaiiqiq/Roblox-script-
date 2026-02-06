-- TPOT21 Box Order Assistant
-- Ayuda a completar el reto de ORDEN de cajas
-- Delta compatible

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Config
local OPENED_COLOR = Color3.fromRGB(0, 255, 0)     -- cajas ya abiertas
local PENDING_COLOR = Color3.fromRGB(255, 255, 0) -- cajas que faltan
local LAST_COLOR = Color3.fromRGB(255, 0, 0)      -- última caja abierta

-- Data
local openedOrder = {}      -- guarda el orden
local boxData = {}          -- [box] = {highlight}
local lastBox = nil

-- Utils
local function makeHighlight(part, color)
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.OutlineColor = Color3.new(1,1,1)
    h.FillTransparency = 0.35
    h.OutlineTransparency = 0
    h.Adornee = part
    h.Parent = part
    return h
end

local function isBox(part)
    return part:IsA("Part")
        and part.Size.X > 3
        and part.Size.Y > 3
        and part.Size.Z > 3
        and part.CanCollide
end

-- Scan cajas
local function scanBoxes()
    for _,v in pairs(workspace:GetDescendants()) do
        if isBox(v) and not boxData[v] then
            boxData[v] = {
                part = v,
                highlight = makeHighlight(v, PENDING_COLOR),
                opened = false
            }

            -- Detectar interacción (cuando la abres)
            v.Touched:Connect(function(hit)
                if hit and hit.Parent == player.Character and not boxData[v].opened then
                    boxData[v].opened = true
                    table.insert(openedOrder, v)
                    lastBox = v
                    print("📦 Caja abierta #" .. #openedOrder)
                end
            end)
        end
    end
end

-- Update visual
local function updateESP()
    for box,info in pairs(boxData) do
        if info.highlight then
            if info.opened then
                info.highlight.FillColor = OPENED_COLOR
            else
                info.highlight.FillColor = PENDING_COLOR
            end
        end
    end

    if lastBox and boxData[lastBox] then
        boxData[lastBox].highlight.FillColor = LAST_COLOR
    end
end

-- Loop principal
task.spawn(function()
    while true do
        scanBoxes()
        updateESP()
        task.wait(0.5)
    end
end)

print("✅ TPOT21 Order Assistant cargado")
print("👉 Abre las cajas en orden. Verde = abiertas | Amarillo = faltan | Rojo = última")
