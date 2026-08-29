--[[
███████╗██████╗░██████╗░███████╗███╗░░░███╗  ░██████╗░█████╗░██████╗░██╗██████╗░████████╗
██╔════╝██╔══██╗██╔══██╗██╔════╝████╗░████║  ██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝
█████╗░░██████╔╝██║░░██║█████╗░░██╔████╔██║  ╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░
██╔══╝░░██╔══██╗██║░░██║██╔══╝░░██║╚██╔╝██║  ░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░
███████╗██║░░██║██████╔╝███████╗██║░╚═╝░██║  ██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░
╚══════╝╚═╝░░╚═╝╚═════╝░╚══════╝╚═╝░░░░░╚═╝  ╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░╚═╝░░░
]]

if game.CoreGui:FindFirstChild("ERDEMSCRIPT") then
    game.CoreGui.ERDEMSCRIPT:Destroy()
end

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════════════════════════
-- RENK PALETI
-- ═══════════════════════════════════════════
local Colors = {
    bg = Color3.fromRGB(10, 10, 14),
    bgSecondary = Color3.fromRGB(16, 16, 22),
    bgTertiary = Color3.fromRGB(22, 22, 30),
    accent = Color3.fromRGB(99, 102, 241),       -- Indigo
    accentHover = Color3.fromRGB(129, 132, 255),
    accentDim = Color3.fromRGB(55, 58, 130),
    success = Color3.fromRGB(52, 211, 153),       -- Emerald
    warning = Color3.fromRGB(251, 191, 36),       -- Amber
    danger = Color3.fromRGB(239, 68, 68),         -- Red
    textPrimary = Color3.fromRGB(245, 245, 250),
    textSecondary = Color3.fromRGB(148, 148, 175),
    textMuted = Color3.fromRGB(100, 100, 130),
    border = Color3.fromRGB(38, 38, 55),
    borderHover = Color3.fromRGB(99, 102, 241),
    cardBg = Color3.fromRGB(18, 18, 26),
    shadow = Color3.fromRGB(0, 0, 0),
    gradientStart = Color3.fromRGB(99, 102, 241),
    gradientEnd = Color3.fromRGB(168, 85, 247),
}

-- ═══════════════════════════════════════════
-- SCREEN GUI
-- ═══════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ERDEMSCRIPT"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ═══════════════════════════════════════════
-- SHADOW FRAME
-- ═══════════════════════════════════════════
local ShadowFrame = Instance.new("ImageLabel")
ShadowFrame.Name = "Shadow"
ShadowFrame.Parent = ScreenGui
ShadowFrame.BackgroundTransparency = 1
ShadowFrame.Position = UDim2.new(0.5, -195, 0.5, -245)
ShadowFrame.Size = UDim2.new(0, 400, 0, 510)
ShadowFrame.Image = "rbxassetid://6015897843"
ShadowFrame.ImageColor3 = Color3.fromRGB(0, 0, 0)
ShadowFrame.ImageTransparency = 0.4
ShadowFrame.ScaleType = Enum.ScaleType.Slice
ShadowFrame.SliceCenter = Rect.new(49, 49, 450, 450)

-- ═══════════════════════════════════════════
-- MAIN FRAME
-- ═══════════════════════════════════════════
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Colors.bg
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -230)
MainFrame.Size = UDim2.new(0, 370, 0, 480)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 14)
UICornerMain.Parent = MainFrame

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Color = Colors.border
UIStrokeMain.Thickness = 1.5
UIStrokeMain.Parent = MainFrame

-- Drag sync shadow
MainFrame:GetPropertyChangedSignal("Position"):Connect(function()
    ShadowFrame.Position = MainFrame.Position + UDim2.new(0, -15, 0, -15)
end)

-- ═══════════════════════════════════════════
-- ACCENT GRADIENT LINE (Top)
-- ═══════════════════════════════════════════
local AccentLine = Instance.new("Frame")
AccentLine.Parent = MainFrame
AccentLine.BackgroundColor3 = Colors.accent
AccentLine.BorderSizePixel = 0
AccentLine.Position = UDim2.new(0, 0, 0, 0)
AccentLine.Size = UDim2.new(1, 0, 0, 3)

local AccentGradient = Instance.new("UIGradient")
AccentGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.gradientStart),
    ColorSequenceKeypoint.new(0.5, Colors.gradientEnd),
    ColorSequenceKeypoint.new(1, Colors.gradientStart)
}
AccentGradient.Parent = AccentLine

-- Animated gradient
task.spawn(function()
    local offset = 0
    while ScreenGui.Parent do
        offset = (offset + 0.005) % 1
        AccentGradient.Offset = Vector2.new(offset, 0)
        task.wait(0.03)
    end
end)

-- ═══════════════════════════════════════════
-- TITLE BAR
-- ═══════════════════════════════════════════
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Colors.bgSecondary
TitleBar.BackgroundTransparency = 0.3
TitleBar.Position = UDim2.new(0, 0, 0, 3)
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BorderSizePixel = 0

-- Logo icon
local LogoIcon = Instance.new("TextLabel")
LogoIcon.Parent = TitleBar
LogoIcon.BackgroundColor3 = Colors.accent
LogoIcon.Position = UDim2.new(0, 14, 0.5, -12)
LogoIcon.Size = UDim2.new(0, 24, 0, 24)
LogoIcon.Font = Enum.Font.GothamBold
LogoIcon.Text = "E"
LogoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoIcon.TextSize = 13

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 6)
logoCorner.Parent = LogoIcon

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 46, 0, 0)
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "ERDEM SCRIPT"
Title.TextColor3 = Colors.textPrimary
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local VersionLbl = Instance.new("TextLabel")
VersionLbl.Parent = TitleBar
VersionLbl.BackgroundColor3 = Colors.accentDim
VersionLbl.BackgroundTransparency = 0.5
VersionLbl.Position = UDim2.new(0, 150, 0.5, -9)
VersionLbl.Size = UDim2.new(0, 36, 0, 18)
VersionLbl.Font = Enum.Font.GothamBold
VersionLbl.Text = "v2.0"
VersionLbl.TextColor3 = Colors.accent
VersionLbl.TextSize = 9

local verCorner = Instance.new("UICorner")
verCorner.CornerRadius = UDim.new(0, 4)
verCorner.Parent = VersionLbl

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = TitleBar
MinimizeBtn.BackgroundColor3 = Colors.bgTertiary
MinimizeBtn.BackgroundTransparency = 0.3
MinimizeBtn.Position = UDim2.new(1, -38, 0.5, -13)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "─"
MinimizeBtn.TextColor3 = Colors.textSecondary
MinimizeBtn.TextSize = 13
MinimizeBtn.AutoButtonColor = false

local UICornerMin = Instance.new("UICorner")
UICornerMin.CornerRadius = UDim.new(0, 6)
UICornerMin.Parent = MinimizeBtn

MinimizeBtn.MouseEnter:Connect(function()
    TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.accent,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0
    }):Play()
end)
MinimizeBtn.MouseLeave:Connect(function()
    TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.bgTertiary,
        TextColor3 = Colors.textSecondary,
        BackgroundTransparency = 0.3
    }):Play()
end)

-- Divider under title
local TitleDivider = Instance.new("Frame")
TitleDivider.Parent = MainFrame
TitleDivider.BackgroundColor3 = Colors.border
TitleDivider.BorderSizePixel = 0
TitleDivider.Position = UDim2.new(0, 14, 0, 45)
TitleDivider.Size = UDim2.new(1, -28, 0, 1)
TitleDivider.BackgroundTransparency = 0.3

-- ═══════════════════════════════════════════
-- NAVIGATION BAR
-- ═══════════════════════════════════════════
local NavBar = Instance.new("Frame")
NavBar.Parent = MainFrame
NavBar.BackgroundTransparency = 1
NavBar.Position = UDim2.new(0, 12, 0, 52)
NavBar.Size = UDim2.new(1, -24, 0, 34)

local NavLayout = Instance.new("UIListLayout")
NavLayout.Parent = NavBar
NavLayout.FillDirection = Enum.FillDirection.Horizontal
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Padding = UDim.new(0, 6)
NavLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createTabButton(text, icon, order)
    local btn = Instance.new("TextButton")
    btn.Parent = NavBar
    btn.BackgroundColor3 = Colors.bgTertiary
    btn.BackgroundTransparency = 0.5
    btn.Size = UDim2.new(0, 105, 1, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = icon .. "  " .. text
    btn.TextColor3 = Colors.textMuted
    btn.TextSize = 10
    btn.LayoutOrder = order
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.border
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = btn
    stroke.Name = "TabStroke"
    
    -- Active indicator line
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Parent = btn
    indicator.BackgroundColor3 = Colors.accent
    indicator.Position = UDim2.new(0.5, -12, 1, -3)
    indicator.Size = UDim2.new(0, 24, 0, 2.5)
    indicator.BackgroundTransparency = 1
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(0, 2)
    indCorner.Parent = indicator
    
    btn.MouseEnter:Connect(function()
        if btn.TextColor3 ~= Colors.textPrimary then
            TweenService:Create(btn, TweenInfo.new(0.15), {TextColor3 = Colors.textSecondary}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Colors.accentDim}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.TextColor3 ~= Colors.textPrimary then
            TweenService:Create(btn, TweenInfo.new(0.15), {TextColor3 = Colors.textMuted}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Colors.border}):Play()
        end
    end)
    
    return btn
end

local HomeTabBtn = createTabButton("HOME", "🏠", 1)
local UniversalTabBtn = createTabButton("UNIVERSAL", "⚡", 2)
local FlingTabBtn = createTabButton("FLING", "🎯", 3)

-- ═══════════════════════════════════════════
-- PAGES CONTAINER
-- ═══════════════════════════════════════════
local PagesContainer = Instance.new("Frame")
PagesContainer.Parent = MainFrame
PagesContainer.BackgroundTransparency = 1
PagesContainer.Position = UDim2.new(0, 0, 0, 92)
PagesContainer.Size = UDim2.new(1, 0, 1, -92)

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Parent = PagesContainer
    page.Active = true
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Colors.accent
    page.ScrollBarImageTransparency = 0.4
    page.Visible = false
    page.ScrollingDirection = Enum.ScrollingDirection.Y

    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

    local padding = Instance.new("UIPadding")
    padding.Parent = page
    padding.PaddingTop = UDim.new(0, 6)
    padding.PaddingBottom = UDim.new(0, 20)
    padding.PaddingLeft = UDim.new(0, 14)
    padding.PaddingRight = UDim.new(0, 14)
    
    return page
end

local HomePage = createPage()
HomePage.Visible = true
local UniversalPage = createPage()
local FlingPage = createPage()

-- Tab Switch Logic
local tabs = {
    {btn = HomeTabBtn, page = HomePage},
    {btn = UniversalTabBtn, page = UniversalPage},
    {btn = FlingTabBtn, page = FlingPage}
}

local function switchTab(selectedTab)
    for _, t in ipairs(tabs) do
        t.page.Visible = false
        local stroke = t.btn:FindFirstChild("TabStroke")
        local indicator = t.btn:FindFirstChild("Indicator")
        TweenService:Create(t.btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            TextColor3 = Colors.textMuted,
            BackgroundColor3 = Colors.bgTertiary,
            BackgroundTransparency = 0.5
        }):Play()
        if stroke then
            TweenService:Create(stroke, TweenInfo.new(0.25), {Color = Colors.border}):Play()
        end
        if indicator then
            TweenService:Create(indicator, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        end
    end
    selectedTab.page.Visible = true
    local stroke = selectedTab.btn:FindFirstChild("TabStroke")
    local indicator = selectedTab.btn:FindFirstChild("Indicator")
    TweenService:Create(selectedTab.btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        TextColor3 = Colors.textPrimary,
        BackgroundColor3 = Colors.accentDim,
        BackgroundTransparency = 0.6
    }):Play()
    if stroke then
        TweenService:Create(stroke, TweenInfo.new(0.25), {Color = Colors.accent}):Play()
    end
    if indicator then
        TweenService:Create(indicator, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end
end

for _, t in ipairs(tabs) do
    t.btn.MouseButton1Click:Connect(function()
        switchTab(t)
    end)
end

switchTab(tabs[1])

-- ═══════════════════════════════════════════
-- UI FACTORY FUNCTIONS
-- ═══════════════════════════════════════════
local function createCategory(parent, text, icon)
    icon = icon or "›"
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 0, 22)
    
    local lbl = Instance.new("TextLabel")
    lbl.Parent = container
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = icon .. "  " .. string.upper(text)
    lbl.TextColor3 = Colors.accent
    lbl.TextSize = 9
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local line = Instance.new("Frame")
    line.Parent = container
    line.BackgroundColor3 = Colors.border
    line.BackgroundTransparency = 0.4
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 1, -1)
    line.Size = UDim2.new(1, 0, 0, 1)
    
    return container
end

local function createButton(parent, name, description, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Colors.cardBg
    btn.Size = UDim2.new(1, 0, 0, description and 48 or 36)
    btn.Font = Enum.Font.GothamBold
    btn.Text = ""
    btn.AutoButtonColor = false
     
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.border
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = btn
    
    -- Button label
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Parent = btn
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, 14, 0, description and 6 or 0)
    titleLbl.Size = UDim2.new(1, -60, 0, description and 20 or 36)
    titleLbl.Font = Enum.Font.GothamMedium
    titleLbl.Text = name
    titleLbl.TextColor3 = Colors.textPrimary
    titleLbl.TextSize = 11
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    
    if description then
        local descLbl = Instance.new("TextLabel")
        descLbl.Parent = btn
        descLbl.BackgroundTransparency = 1
        descLbl.Position = UDim2.new(0, 14, 0, 24)
        descLbl.Size = UDim2.new(1, -60, 0, 16)
        descLbl.Font = Enum.Font.Gotham
        descLbl.Text = description
        descLbl.TextColor3 = Colors.textMuted
        descLbl.TextSize = 9
        descLbl.TextXAlignment = Enum.TextXAlignment.Left
    end
    
    -- Arrow icon
    local arrow = Instance.new("TextLabel")
    arrow.Parent = btn
    arrow.BackgroundTransparency = 1
    arrow.Position = UDim2.new(1, -35, 0, 0)
    arrow.Size = UDim2.new(0, 25, 1, 0)
    arrow.Font = Enum.Font.GothamBold
    arrow.Text = "→"
    arrow.TextColor3 = Colors.textMuted
    arrow.TextSize = 14
    
    -- Ripple effect
    local function ripple()
        local circle = Instance.new("Frame")
        circle.Parent = btn
        circle.BackgroundColor3 = Colors.accent
        circle.BackgroundTransparency = 0.7
        circle.Position = UDim2.new(0.5, -5, 0.5, -5)
        circle.Size = UDim2.new(0, 10, 0, 10)
        circle.ZIndex = 10
        
        local cCorner = Instance.new("UICorner")
        cCorner.CornerRadius = UDim.new(1, 0)
        cCorner.Parent = circle
        
        TweenService:Create(circle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Size = UDim2.new(2, 0, 4, 0),
            Position = UDim2.new(-0.5, 0, -1.5, 0),
            BackgroundTransparency = 1
        }):Play()
        
        task.delay(0.5, function()
            circle:Destroy()
        end)
    end
     
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
            BackgroundColor3 = Colors.bgTertiary
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Colors.accent, Transparency = 0}):Play()
        TweenService:Create(arrow, TweenInfo.new(0.2), {TextColor3 = Colors.accent}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
            BackgroundColor3 = Colors.cardBg
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Colors.border, Transparency = 0.3}):Play()
        TweenService:Create(arrow, TweenInfo.new(0.2), {TextColor3 = Colors.textMuted}):Play()
    end)
     
    btn.MouseButton1Click:Connect(function()
        ripple()
        callback()
    end)
    return btn
end

local function createToggleButton(parent, name, description, callback)
    local toggled = false
    
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Colors.cardBg
    btn.Size = UDim2.new(1, 0, 0, description and 48 or 36)
    btn.Text = ""
    btn.AutoButtonColor = false
     
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.border
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = btn
    
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Parent = btn
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, 14, 0, description and 6 or 0)
    titleLbl.Size = UDim2.new(1, -70, 0, description and 20 or 36)
    titleLbl.Font = Enum.Font.GothamMedium
    titleLbl.Text = name
    titleLbl.TextColor3 = Colors.textPrimary
    titleLbl.TextSize = 11
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    
    if description then
        local descLbl = Instance.new("TextLabel")
        descLbl.Parent = btn
        descLbl.BackgroundTransparency = 1
        descLbl.Position = UDim2.new(0, 14, 0, 24)
        descLbl.Size = UDim2.new(1, -70, 0, 16)
        descLbl.Font = Enum.Font.Gotham
        descLbl.Text = description
        descLbl.TextColor3 = Colors.textMuted
        descLbl.TextSize = 9
        descLbl.TextXAlignment = Enum.TextXAlignment.Left
    end
    
    -- Toggle switch
    local toggleBg = Instance.new("Frame")
    toggleBg.Parent = btn
    toggleBg.BackgroundColor3 = Colors.bgTertiary
    toggleBg.Position = UDim2.new(1, -52, 0.5, -10)
    toggleBg.Size = UDim2.new(0, 38, 0, 20)
    
    local tbCorner = Instance.new("UICorner")
    tbCorner.CornerRadius = UDim.new(1, 0)
    tbCorner.Parent = toggleBg
    
    local tbStroke = Instance.new("UIStroke")
    tbStroke.Color = Colors.border
    tbStroke.Thickness = 1
    tbStroke.Parent = toggleBg
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Parent = toggleBg
    toggleCircle.BackgroundColor3 = Colors.textMuted
    toggleCircle.Position = UDim2.new(0, 3, 0.5, -7)
    toggleCircle.Size = UDim2.new(0, 14, 0, 14)
    
    local tcCorner = Instance.new("UICorner")
    tcCorner.CornerRadius = UDim.new(1, 0)
    tcCorner.Parent = toggleCircle
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Colors.bgTertiary}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Colors.cardBg}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(toggleBg, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                BackgroundColor3 = Colors.accent
            }):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                Position = UDim2.new(1, -17, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            TweenService:Create(tbStroke, TweenInfo.new(0.25), {Color = Colors.accent}):Play()
        else
            TweenService:Create(toggleBg, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                BackgroundColor3 = Colors.bgTertiary
            }):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                Position = UDim2.new(0, 3, 0.5, -7),
                BackgroundColor3 = Colors.textMuted
            }):Play()
            TweenService:Create(tbStroke, TweenInfo.new(0.25), {Color = Colors.border}):Play()
        end
        callback(toggled)
    end)
    
    return btn
end

local function createSlider(parent, text, min, max, default, callback)
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundColor3 = Colors.cardBg
    container.Size = UDim2.new(1, 0, 0, 52)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container

    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.border
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = container

    local lbl = Instance.new("TextLabel")
    lbl.Parent = container
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0, 14, 0, 6)
    lbl.Size = UDim2.new(0.6, 0, 0, 18)
    lbl.Font = Enum.Font.GothamMedium
    lbl.Text = text
    lbl.TextColor3 = Colors.textPrimary
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel")
    valLbl.Parent = container
    valLbl.BackgroundColor3 = Colors.accentDim
    valLbl.BackgroundTransparency = 0.5
    valLbl.Position = UDim2.new(1, -55, 0, 6)
    valLbl.Size = UDim2.new(0, 42, 0, 18)
    valLbl.Font = Enum.Font.GothamBold
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Colors.accent
    valLbl.TextSize = 10
    
    local vlCorner = Instance.new("UICorner")
    vlCorner.CornerRadius = UDim.new(0, 4)
    vlCorner.Parent = valLbl

    local bgBar = Instance.new("TextButton")
    bgBar.Parent = container
    bgBar.BackgroundColor3 = Colors.bgTertiary
    bgBar.Position = UDim2.new(0, 14, 0, 32)
    bgBar.Size = UDim2.new(1, -28, 0, 6)
    bgBar.AutoButtonColor = false
    bgBar.Text = ""

    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = bgBar

    local fillBar = Instance.new("Frame")
    fillBar.Parent = bgBar
    fillBar.BackgroundColor3 = Colors.accent
    fillBar.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fillBar.BorderSizePixel = 0

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fillBar
    
    local fillGradient = Instance.new("UIGradient")
    fillGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Colors.gradientStart),
        ColorSequenceKeypoint.new(1, Colors.gradientEnd)
    }
    fillGradient.Parent = fillBar
    
    -- Thumb
    local thumb = Instance.new("Frame")
    thumb.Parent = bgBar
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.Position = UDim2.new((default - min)/(max - min), -6, 0.5, -6)
    thumb.Size = UDim2.new(0, 12, 0, 12)
    thumb.ZIndex = 5
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb
    
    local thumbStroke = Instance.new("UIStroke")
    thumbStroke.Color = Colors.accent
    thumbStroke.Thickness = 2
    thumbStroke.Parent = thumb

    local dragging = false
    local function updateInput(input)
        local scale = math.clamp((input.Position.X - bgBar.AbsolutePosition.X) / bgBar.AbsoluteSize.X, 0, 1)
        fillBar.Size = UDim2.new(scale, 0, 1, 0)
        thumb.Position = UDim2.new(scale, -6, 0.5, -6)
        local rawVal = min + (max - min) * scale
        local val
        if max <= 1 then
            val = math.floor(rawVal * 100) / 100
        else
            val = math.floor(rawVal)
        end
        valLbl.Text = tostring(val)
        callback(val)
    end

    bgBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateInput(input)
        end
    end)
end

-- ═══════════════════════════════════════════
-- === HOME TAB ===
-- ═══════════════════════════════════════════
createCategory(HomePage, "MM2 Scripts", "⚔")
createButton(HomePage, "Metan Hub MM2", "Popüler MM2 hub scripti", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Youdfff/MetanHub/refs/heads/main/moonveil.lua"))()
end)
createButton(HomePage, "MM2 İlk Yap", "Oyunda ilk olmanı sağlar", function()
    loadstring(game:HttpGet("https://syndevelops.vercel.app/", true))()
end)

createCategory(HomePage, "Fling & Animasyon", "💥")
createButton(HomePage, "Eski Fling", "Klasik fling GUI scripti", function()
    loadstring(game:HttpGet("https://obj.wearedevs.net/130275/scripts/Fling%20GUI.lua"))()
end)
createButton(HomePage, "Animasyon", "Animasyon scripti", function()
    loadstring(game:HttpGet("https://pastefy.app/aE3iU1As/raw"))()
end)

createCategory(HomePage, "Code Sniper", "🎫")
createButton(HomePage, "Paralı Code Sniper", "Premium code sniper aracı", function()
    getgenv().SCRIPT_KEY = "56bb1c80-d398-44fc-a972-2cff2ef22d0e"
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/5562301401bab647e28680f023baceae0e59d61c0c2991d70167ae19b740c227/download"))()
end)
createButton(HomePage, "Ücretsiz Code Sniper 1", "Bedava code sniper #1", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/pulsvethedev2/Ace-sniper/refs/heads/main/YUIHUB-CODE-REDEEMER.txt"))()
end)
createButton(HomePage, "Ücretsiz Code Sniper 2", "Bedava code sniper #2", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Script-cmd-keyless/DLC-code/refs/heads/main/AceCodeSniper"))()
end)

createCategory(HomePage, "Diğer Scriptler", "📦")
createButton(HomePage, "Infinity Yield", "Gelişmiş admin komut paneli", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
end)

-- ═══════════════════════════════════════════
-- === UNIVERSAL TAB ===
-- ═══════════════════════════════════════════
createCategory(UniversalPage, "Teleport", "🌐")

local ctrlTpEnabled = false
createToggleButton(UniversalPage, "Ctrl + Click TP", "Ctrl basılı tıklayarak ışınlan", function(state)
    ctrlTpEnabled = state
end)

Mouse.Button1Down:Connect(function()
    if ctrlTpEnabled then
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            pcall(function()
                local myChar = LocalPlayer.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    myChar.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end)
        end
    end
end)

createCategory(UniversalPage, "Karakter Hileleri", "🎮")

local noclipEnabled = false
RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
createToggleButton(UniversalPage, "Noclip", "Duvarlardan geç", function(state)
    noclipEnabled = state
end)

local flyEnabled = false
local flySpeed = 50
local flyConn
createToggleButton(UniversalPage, "Fly", "Havada uç", function(state)
    flyEnabled = state
    if flyEnabled then
        local cam = workspace.CurrentCamera
        local uis = UserInputService
        local keys = {W = false, S = false, A = false, D = false}
        
        local c1 = uis.InputBegan:Connect(function(input)
            if not flyEnabled then return end
            if input.KeyCode == Enum.KeyCode.W then keys.W = true end
            if input.KeyCode == Enum.KeyCode.S then keys.S = true end
            if input.KeyCode == Enum.KeyCode.A then keys.A = true end
            if input.KeyCode == Enum.KeyCode.D then keys.D = true end
        end)
        local c2 = uis.InputEnded:Connect(function(input)
            if not flyEnabled then return end
            if input.KeyCode == Enum.KeyCode.W then keys.W = false end
            if input.KeyCode == Enum.KeyCode.S then keys.S = false end
            if input.KeyCode == Enum.KeyCode.A then keys.A = false end
            if input.KeyCode == Enum.KeyCode.D then keys.D = false end
        end)
        
        flyConn = RunService.RenderStepped:Connect(function(dt)
            if not flyEnabled then 
                flyConn:Disconnect()
                c1:Disconnect()
                c2:Disconnect()
                return 
            end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local moveDir = Vector3.new()
                if keys.W then moveDir = moveDir + cam.CFrame.LookVector end
                if keys.S then moveDir = moveDir - cam.CFrame.LookVector end
                if keys.A then moveDir = moveDir - cam.CFrame.RightVector end
                if keys.D then moveDir = moveDir + cam.CFrame.RightVector end
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.CFrame = hrp.CFrame + (moveDir * flySpeed * dt)
            end
        end)
    else
        if flyConn then flyConn:Disconnect() end
    end
end)
createSlider(UniversalPage, "Fly Speed", 10, 500, 50, function(val)
    flySpeed = val
end)

createSlider(UniversalPage, "Speed Hack", 16, 1000, 16, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

createSlider(UniversalPage, "Jump Power", 50, 1000, 50, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
        LocalPlayer.Character.Humanoid.UseJumpPower = true
    end
end)

local infJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
createToggleButton(UniversalPage, "Infinite Jump", "Sınırsız zıpla", function(state)
    infJumpEnabled = state
end)

local invisEnabled = false
createToggleButton(UniversalPage, "Invisible", "Görünmez ol", function(state)
    invisEnabled = state
    local char = LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                v.Transparency = invisEnabled and 1 or 0
            elseif v:IsA("Decal") then
                v.Transparency = invisEnabled and 1 or 0
            end
        end
    end
end)

-- ═══════════════════════════════════════════
-- === FLING TAB ===
-- ═══════════════════════════════════════════
createCategory(FlingPage, "Hedef Seçimi", "🎯")

local selectedTarget = nil

-- Target Status Card
local StatusCard = Instance.new("Frame")
StatusCard.Parent = FlingPage
StatusCard.BackgroundColor3 = Colors.cardBg
StatusCard.Size = UDim2.new(1, 0, 0, 40)

local scCorner = Instance.new("UICorner")
scCorner.CornerRadius = UDim.new(0, 8)
scCorner.Parent = StatusCard

local scStroke = Instance.new("UIStroke")
scStroke.Color = Colors.border
scStroke.Thickness = 1
scStroke.Parent = StatusCard

local StatusDot = Instance.new("Frame")
StatusDot.Parent = StatusCard
StatusDot.BackgroundColor3 = Colors.danger
StatusDot.Position = UDim2.new(0, 14, 0.5, -5)
StatusDot.Size = UDim2.new(0, 10, 0, 10)

local sdCorner = Instance.new("UICorner")
sdCorner.CornerRadius = UDim.new(1, 0)
sdCorner.Parent = StatusDot

local TargetStatusLbl = Instance.new("TextLabel")
TargetStatusLbl.Parent = StatusCard
TargetStatusLbl.BackgroundTransparency = 1
TargetStatusLbl.Position = UDim2.new(0, 32, 0, 0)
TargetStatusLbl.Size = UDim2.new(1, -40, 1, 0)
TargetStatusLbl.Font = Enum.Font.GothamBold
TargetStatusLbl.Text = "Hedef: SEÇİLMEDİ"
TargetStatusLbl.TextColor3 = Colors.warning
TargetStatusLbl.TextSize = 11
TargetStatusLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Dropdown
local DropdownContainer = Instance.new("Frame")
DropdownContainer.Parent = FlingPage
DropdownContainer.BackgroundColor3 = Colors.cardBg
DropdownContainer.Size = UDim2.new(1, 0, 0, 36)

local dcCorner = Instance.new("UICorner")
dcCorner.CornerRadius = UDim.new(0, 8)
dcCorner.Parent = DropdownContainer

local dcStroke = Instance.new("UIStroke")
dcStroke.Color = Colors.border
dcStroke.Thickness = 1
dcStroke.Parent = DropdownContainer

local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Parent = DropdownContainer
DropdownBtn.BackgroundTransparency = 1
DropdownBtn.Size = UDim2.new(1, 0, 1, 0)
DropdownBtn.Font = Enum.Font.GothamMedium
DropdownBtn.Text = "   Oyuncu Seç..."
DropdownBtn.TextColor3 = Colors.textSecondary
DropdownBtn.TextSize = 11
DropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
DropdownBtn.AutoButtonColor = false

local DropdownArrow = Instance.new("TextLabel")
DropdownArrow.Parent = DropdownContainer
DropdownArrow.BackgroundTransparency = 1
DropdownArrow.Position = UDim2.new(1, -35, 0, 0)
DropdownArrow.Size = UDim2.new(0, 30, 1, 0)
DropdownArrow.Font = Enum.Font.GothamBold
DropdownArrow.Text = "▼"
DropdownArrow.TextColor3 = Colors.accent
DropdownArrow.TextSize = 10

local PlayerScrollList = Instance.new("ScrollingFrame")
PlayerScrollList.Parent = FlingPage
PlayerScrollList.BackgroundColor3 = Colors.bgSecondary
PlayerScrollList.Size = UDim2.new(1, 0, 0, 0)
PlayerScrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScrollList.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerScrollList.ScrollBarThickness = 2
PlayerScrollList.ScrollBarImageColor3 = Colors.accent
PlayerScrollList.Visible = false
PlayerScrollList.ClipsDescendants = true

local pslCorner = Instance.new("UICorner")
pslCorner.CornerRadius = UDim.new(0, 8)
pslCorner.Parent = PlayerScrollList

local pslStroke = Instance.new("UIStroke")
pslStroke.Color = Colors.accent
pslStroke.Thickness = 1
pslStroke.Transparency = 0.5
pslStroke.Parent = PlayerScrollList

local pslLayout = Instance.new("UIListLayout")
pslLayout.Parent = PlayerScrollList
pslLayout.SortOrder = Enum.SortOrder.LayoutOrder
pslLayout.Padding = UDim.new(0, 3)

local pslPadding = Instance.new("UIPadding")
pslPadding.Parent = PlayerScrollList
pslPadding.PaddingTop = UDim.new(0, 4)
pslPadding.PaddingBottom = UDim.new(0, 4)
pslPadding.PaddingLeft = UDim.new(0, 4)
pslPadding.PaddingRight = UDim.new(0, 4)

local isPlayerListOpen = false

local function refreshPlayerDropdown()
    for _, child in pairs(PlayerScrollList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Parent = PlayerScrollList
            pBtn.BackgroundColor3 = Colors.bgTertiary
            pBtn.BackgroundTransparency = 0.3
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.Font = Enum.Font.GothamMedium
            pBtn.Text = "  👤  " .. p.Name
            pBtn.TextColor3 = Colors.textPrimary
            pBtn.TextSize = 11
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            pBtn.AutoButtonColor = false
            
            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, 6)
            c.Parent = pBtn
            
            pBtn.MouseEnter:Connect(function()
                TweenService:Create(pBtn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Colors.accentDim,
                    BackgroundTransparency = 0.4
                }):Play()
            end)
            pBtn.MouseLeave:Connect(function()
                TweenService:Create(pBtn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Colors.bgTertiary,
                    BackgroundTransparency = 0.3
                }):Play()
            end)
            
            pBtn.MouseButton1Click:Connect(function()
                selectedTarget = p
                TargetStatusLbl.Text = "Hedef: " .. p.Name
                TargetStatusLbl.TextColor3 = Colors.success
                StatusDot.BackgroundColor3 = Colors.success
                DropdownBtn.Text = "   👤  " .. p.Name
                DropdownBtn.TextColor3 = Colors.textPrimary
                isPlayerListOpen = false
                TweenService:Create(PlayerScrollList, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                task.wait(0.25)
                PlayerScrollList.Visible = false
                DropdownArrow.Text = "▼"
                TweenService:Create(dcStroke, TweenInfo.new(0.2), {Color = Colors.success}):Play()
            end)
        end
    end
end

DropdownBtn.MouseButton1Click:Connect(function()
    isPlayerListOpen = not isPlayerListOpen
    if isPlayerListOpen then
        refreshPlayerDropdown()
        PlayerScrollList.Visible = true
        TweenService:Create(PlayerScrollList, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 130)}):Play()
        DropdownArrow.Text = "▲"
        TweenService:Create(dcStroke, TweenInfo.new(0.2), {Color = Colors.accent}):Play()
    else
        TweenService:Create(PlayerScrollList, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 0)}):Play()
        task.wait(0.25)
        PlayerScrollList.Visible = false
        DropdownArrow.Text = "▼"
        TweenService:Create(dcStroke, TweenInfo.new(0.2), {Color = Colors.border}):Play()
    end
end)

createButton(FlingPage, "Listeyi Yenile", "Oyuncu listesini güncelle", refreshPlayerDropdown)

createCategory(FlingPage, "Hedef İşlemleri", "⚡")

createButton(FlingPage, "Hedefe Işınlan", "Seçili oyuncuya ışınlan", function()
    pcall(function()
        if selectedTarget and selectedTarget.Character and selectedTarget.Character:FindFirstChild("HumanoidRootPart") then
            local myChar = LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myChar.HumanoidRootPart.CFrame = selectedTarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            end
        end
    end)
end)

local flingActive = false
local bangActive = false
local viewConnection = nil
local activeThrust = nil

createButton(FlingPage, "Fling Target", "Hedefi fırlat", function()
    if flingActive then return end
    flingActive = true
    pcall(function()
        if not selectedTarget or not selectedTarget.Character or not selectedTarget.Character:FindFirstChild("HumanoidRootPart") then 
            flingActive = false; return 
        end
        local myChar = LocalPlayer.Character
        if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then 
            flingActive = false; return 
        end
        local hrp = myChar.HumanoidRootPart
        if not activeThrust then
            activeThrust = Instance.new('BodyThrust', hrp)
            activeThrust.Force = Vector3.new(9999, 9999, 9999)
            activeThrust.Name = "YeetForce"
        end
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not flingActive or not selectedTarget or not selectedTarget.Character or not selectedTarget.Character:FindFirstChild("HumanoidRootPart") then
                if connection then connection:Disconnect() end
                if activeThrust then activeThrust:Destroy(); activeThrust = nil end
                flingActive = false; return
            end
            local targetHrp = selectedTarget.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = selectedTarget.Character:FindFirstChildOfClass("Humanoid")
            if not targetHrp or (targetHumanoid and targetHumanoid.Health <= 0) then
                if connection then connection:Disconnect() end
                if activeThrust then activeThrust:Destroy(); activeThrust = nil end
                flingActive = false; return
            end
            hrp.CFrame = targetHrp.CFrame
            activeThrust.Location = targetHrp.Position
        end)
    end)
end)

createButton(FlingPage, "Fling Durdur", "Flingi kapat", function()
    flingActive = false
    if activeThrust then activeThrust:Destroy(); activeThrust = nil end
end)

createButton(FlingPage, "Bang Target", "Hedefe bang yap", function()
    if bangActive then return end
    bangActive = true
    pcall(function()
        if not selectedTarget or not selectedTarget.Character or not selectedTarget.Character:FindFirstChild("HumanoidRootPart") then 
            bangActive = false; return 
        end
        task.spawn(function()
            while bangActive do
                if not selectedTarget or not selectedTarget.Character or not selectedTarget.Character:FindFirstChild("HumanoidRootPart") then break end
                local targetHrp = selectedTarget.Character.HumanoidRootPart
                local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not myHrp then break end
                myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 1.2)
                task.wait(0.12)
                if not bangActive then break end
                myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, -0.2)
                task.wait(0.12)
            end
            bangActive = false
        end)
    end)
end)

createButton(FlingPage, "Bang Durdur", "Bangi kapat", function()
    bangActive = false
end)

createButton(FlingPage, "Hedefi İzle", "Kamerayı hedefe kilitle", function()
    pcall(function()
        if not selectedTarget or not selectedTarget.Character or not selectedTarget.Character:FindFirstChild("Head") then return end
        if viewConnection then viewConnection:Disconnect() end
        viewConnection = RunService.RenderStepped:Connect(function()
            if selectedTarget.Character and selectedTarget.Character:FindFirstChild("Head") then
                Camera.CameraSubject = selectedTarget.Character.Head
            end
        end)
    end)
end)

createButton(FlingPage, "İzlemeyi Bırak", "Kamerayı normale döndür", function()
    pcall(function()
        if viewConnection then viewConnection:Disconnect(); viewConnection = nil end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end)
end)

-- ═══════════════════════════════════════════
-- MINIMIZE & TOGGLE
-- ═══════════════════════════════════════════
local isMinimized = false
local originalSize = UDim2.new(0, 370, 0, 480)

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 370, 0, 45)
        }):Play()
        TweenService:Create(ShadowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 400, 0, 75)
        }):Play()
        MinimizeBtn.Text = "+"
        task.wait(0.15)
        PagesContainer.Visible = false
        NavBar.Visible = false
    else
        NavBar.Visible = true
        PagesContainer.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = originalSize
        }):Play()
        TweenService:Create(ShadowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 400, 0, 510)
        }):Play()
        MinimizeBtn.Text = "─"
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightShift then
            local visible = not MainFrame.Visible
            MainFrame.Visible = visible
            ShadowFrame.Visible = visible
        end
    end
end)

-- ═══════════════════════════════════════════
-- AÇILIŞ ANİMASYONU
-- ═══════════════════════════════════════════
MainFrame.Size = UDim2.new(0, 370, 0, 0)
MainFrame.BackgroundTransparency = 1
ShadowFrame.ImageTransparency = 1

task.wait(0.1)

TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
    Size = originalSize,
    BackgroundTransparency = 0
}):Play()
TweenService:Create(ShadowFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
    ImageTransparency = 0.4
}):Play()

print("✅ ERDEM SCRIPT v2.0 Loaded Successfully!")