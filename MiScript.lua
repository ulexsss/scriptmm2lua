local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cambia esto por el nombre exacto del objeto en Workspace
local brainrot = workspace:WaitForChild("Brainrot")

local gui = Instance.new("ScreenGui")
gui.Name = "TradeVisualSimulator"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(270, 190)
panel.BackgroundColor3 = Color3.fromRGB(20, 29, 38)
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 9)
corner.Parent = panel

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(55, 75, 88)
header.Text = "Objeto Desconocido"
header.TextColor3 = Color3.new(1, 1, 1)
header.TextSize = 17
header.Font = Enum.Font.GothamBold
header.Parent = panel

local info = Instance.new("TextLabel")
info.Position = UDim2.fromOffset(5, 43)
info.Size = UDim2.new(1, -10, 0, 70)
info.BackgroundTransparency = 1
info.Text = "Sin Verificar\n\nValor: ???"
info.TextColor3 = Color3.fromRGB(255, 220, 40)
info.TextSize = 17
info.Font = Enum.Font.GothamBold
info.Parent = panel

local warning = Instance.new("TextLabel")
warning.Position = UDim2.fromOffset(5, 120)
warning.Size = UDim2.new(1, -10, 0, 61)
warning.BackgroundColor3 = Color3.fromRGB(150, 45, 45)
warning.Text = "SIMULACIÓN: Si experimentas errores visuales en la oferta, visita la Plaza de intercambio para continuar con seguridad."
warning.TextColor3 = Color3.new(1, 1, 1)
warning.TextSize = 9
warning.TextWrapped = true
warning.Font = Enum.Font.GothamBold
warning.Parent = panel

local warningCorner = Instance.new("UICorner")
warningCorner.CornerRadius = UDim.new(0, 5)
warningCorner.Parent = warning

local menuActivo = false

local function ocultarBrainrot(ocultar)
    if not brainrot or not brainrot.Parent then
        return
    end

    if brainrot:IsA("BasePart") then
        brainrot.LocalTransparencyModifier = ocultar and 1 or 0
    end

    for _, objeto in ipairs(brainrot:GetDescendants()) do
        if objeto:IsA("BasePart") then
            objeto.LocalTransparencyModifier = ocultar and 1 or 0
        end
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.H then
        menuActivo = not menuActivo
        panel.Visible = menuActivo
        ocultarBrainrot(menuActivo)
    end
end)

RunService.RenderStepped:Connect(function()
    if not menuActivo then return end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local mousePosition = UserInputService:GetMouseLocation()
    local viewportSize = camera.ViewportSize

    local x = math.clamp(mousePosition.X + 15, 0, viewportSize.X - 270)
    local y = math.clamp(mousePosition.Y - 120, 0, viewportSize.Y - 190)

    panel.Position = UDim2.fromOffset(x, y)
end)
