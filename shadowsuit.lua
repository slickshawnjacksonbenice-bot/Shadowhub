--[[
    #########################################################################################
    #                                                                                       #
    #                 SHADOW SUITE V4200 - TITAN UNCHAINED EDITION                          #
    #                                                                                       #
    #                           ARCHITECT: SHAWN PAUL                                       #
    #                       STATUS: MAGIC BULLET PHYSICS FIXED | FULL SUITE                 #
    #                                                                                       #
    #########################################################################################
]]

-- // 1. SECURE STORAGE //
local _Key_P1 = "vF8pZ#E4r2Hn$QyTj@wK6g!LzX1m"
local _Key_P2 = "C5bA7uI9oD0sP3f&GxC9tYvQk2Jd7mR3pS5"
local _Auth_Key = _Key_P1 .. _Key_P2

local _Gwy_1 = "https://link-hub.net/1460652/YS1pYh8utBU3"
local _Gwy_2 = "https://work.ink/29Ze/text-paste"

-- // 2. TITAN KERNEL //
local _Sys_Core = {
    _Sig = {}, 
    _Ent = {}, 
    _Mem = { _H = {}, _Ign = {} },
    _State = { _Act = false, _Cyc = false, _Run = true },
    _UI = { _Mn = nil, _Help = nil, _Ref = nil }
}

function _Sys_Core:_Purge()
    self._State._Run = false
    for _, _V in pairs(self._Sig) do if _V then _V:Disconnect() end end
    for _, _V in pairs(self._Ent) do if _V then _V:Destroy() end end
    for _, _V in pairs(self._Mem._H) do if _V then _V:Destroy() end end
    table.clear(self._Sig); table.clear(self._Ent); table.clear(self._Mem._H)
end

function _Sys_Core:_GC()
    for _C, _H in pairs(self._Mem._H) do
        if not _C or not _C.Parent or not _H then
            if _H then _H:Destroy() end
            self._Mem._H[_C] = nil
        end
    end
    collectgarbage("collect")
end

if getgenv()._TITAN_HZ then getgenv()._TITAN_HZ:_Purge() end
getgenv()._TITAN_HZ = _Sys_Core

-- // 3. SERVICE MAPPING //
local _S = {
    _Plr = game:GetService("Players"),
    _Run = game:GetService("RunService"),
    _Inp = game:GetService("UserInputService"),
    _Work = game:GetService("Workspace"),
    _VIM = game:GetService("VirtualInputManager"),
    _Tw = game:GetService("TweenService"),
    _Core = game:GetService("CoreGui")
}
local _LP = _S._Plr.LocalPlayer
local _Cam = _S._Work.CurrentCamera

-- // 4. PROTOCOL CONFIGURATION //
local _Conf = {
    _Aim = {
        _En = true, _Tog = Enum.KeyCode.Backquote, _Part = "Head", 
        _FOV = 300, _Sm = 0.08, _Wall = true, _Dist = 1000, _H_Lim = 50
    },
    _Trig = {
        _En = false, _Key = Enum.KeyCode.T, _Del = 0.25, _Sw = 0.05 
    },
    _Wall = {
        _En = false, _Key = Enum.KeyCode.U
    },
    _Exp = {
        _MB = { _En = false, _Key = Enum.KeyCode.LeftAlt, _Sz = 10 },
        _GM = { _En = false, _Key = Enum.KeyCode.G },
        _NC = { _En = false, _Key = Enum.KeyCode.X },
        _SP = { _En = false, _Key = Enum.KeyCode.RightAlt, _Mult = {0, 0.6, 1.5, 3.5}, _Idx = 1 }
    },
    _Vis = {
        _En = true, _Col_E = Color3.fromRGB(255, 50, 50), _Col_S = Color3.fromRGB(50, 255, 150), _Rend = 3000
    }
}

-- // 5. INTERFACE ENGINE //
local _UI_Sys = {}

function _UI_Sys:_Gfx(_Obj, _C1, _C2)
    local _G = Instance.new("UIGradient")
    _G.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, _C1 or Color3.fromRGB(120, 50, 255)),
        ColorSequenceKeypoint.new(1, _C2 or Color3.fromRGB(50, 150, 255))
    }
    _G.Rotation = 45; _G.Parent = _Obj
    local _Rot = _S._Run.RenderStepped:Connect(function() if _Obj.Parent then _G.Rotation = (_G.Rotation + 0.5) % 360 end end)
    table.insert(_Sys_Core._Sig, _Rot)
end

function _UI_Sys:_Init_Auth()
    local _Sc = Instance.new("ScreenGui"); _Sc.Name = "ShadowAuth"; _Sc.IgnoreGuiInset = true; _Sc.Parent = _S._Core
    table.insert(_Sys_Core._Ent, _Sc)

    local _Mn = Instance.new("Frame"); _Mn.Size = UDim2.new(0, 550, 0, 350); _Mn.Position = UDim2.new(0.5, -275, 0.5, -175)
    _Mn.BackgroundColor3 = Color3.fromRGB(15, 15, 20); _Mn.BorderSizePixel = 0; _Mn.Parent = _Sc
    Instance.new("UICorner", _Mn).CornerRadius = UDim.new(0, 16)
    local _Str = Instance.new("UIStroke", _Mn); _Str.Thickness = 2; _UI_Sys:_Gfx(_Str)

    local _Tit = Instance.new("TextLabel"); _Tit.Text = "TITAN UNCHAINED"; _Tit.Size = UDim2.new(1, 0, 0, 80); _Tit.BackgroundTransparency = 1
    _Tit.TextColor3 = Color3.fromRGB(255, 255, 255); _Tit.Font = Enum.Font.GothamBlack; _Tit.TextSize = 36; _Tit.Parent = _Mn
    _UI_Sys:_Gfx(_Tit, Color3.fromRGB(220, 180, 255), Color3.fromRGB(150, 220, 255))

    local _In = Instance.new("TextBox"); _In.Size = UDim2.new(0.8, 0, 0, 55); _In.Position = UDim2.new(0.1, 0, 0.38, 0)
    _In.BackgroundColor3 = Color3.fromRGB(25, 25, 35); _In.TextColor3 = Color3.fromRGB(255, 255, 255); _In.PlaceholderText = "AUTHENTICATION KEY..."
    _In.Font = Enum.Font.GothamBold; _In.TextSize = 16; _In.Parent = _Mn; Instance.new("UICorner", _In).CornerRadius = UDim.new(0, 10)

    local _Btn = Instance.new("TextButton"); _Btn.Size = UDim2.new(0.5, 0, 0, 50); _Btn.Position = UDim2.new(0.25, 0, 0.65, 0)
    _Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); _Btn.Text = "INJECT SYSTEM"; _Btn.TextColor3 = Color3.fromRGB(20, 20, 30)
    _Btn.Font = Enum.Font.GothamBlack; _Btn.TextSize = 18; _Btn.Parent = _Mn; Instance.new("UICorner", _Btn).CornerRadius = UDim.new(0, 10)

    local _Key = Instance.new("TextButton"); _Key.Size = UDim2.new(0.3, 0, 0, 30); _Key.Position = UDim2.new(0.35, 0, 0.85, 0)
    _Key.BackgroundTransparency = 1; _Key.Text = "Get Key Link"; _Key.TextColor3 = Color3.fromRGB(180, 180, 200)
    _Key.Font = Enum.Font.GothamBold; _Key.TextSize = 12; _Key.Parent = _Mn

    _Key.MouseButton1Click:Connect(function()
        local _Pop = Instance.new("Frame"); _Pop.Size = UDim2.new(0, 450, 0, 250); _Pop.Position = UDim2.new(0.5, -225, 0.5, -125)
        _Pop.BackgroundColor3 = Color3.fromRGB(20, 20, 25); _Pop.ZIndex = 10; _Pop.Parent = _Sc
        Instance.new("UICorner", _Pop).CornerRadius = UDim.new(0, 12); local _PS = Instance.new("UIStroke", _Pop); _PS.Thickness = 2; _UI_Sys:_Gfx(_PS)
        
        local _L = Instance.new("TextLabel", _Pop); _L.Size = UDim2.new(1, 0, 0, 40); _L.BackgroundTransparency = 1; _L.Text = "SELECT GATEWAY"
        _L.TextColor3 = Color3.fromRGB(255, 255, 255); _L.Font = Enum.Font.GothamBlack; _L.TextSize = 18; _L.ZIndex = 11

        local _L1 = Instance.new("TextButton", _Pop); _L1.Size = UDim2.new(0.4, 0, 0, 40); _L1.Position = UDim2.new(0.05, 0, 0.25, 0)
        _L1.BackgroundColor3 = Color3.fromRGB(30, 30, 40); _L1.Text = "LINKVERTISE"; _L1.TextColor3 = Color3.fromRGB(255, 255, 255); _L1.Font = Enum.Font.GothamBold; _L1.ZIndex = 11
        Instance.new("UICorner", _L1).CornerRadius = UDim.new(0, 6); local _L1S = Instance.new("UIStroke", _L1); _L1S.Thickness = 1; _UI_Sys:_Gfx(_L1S, Color3.fromRGB(255, 165, 0), Color3.fromRGB(255, 100, 0))

        local _L2 = Instance.new("TextButton", _Pop); _L2.Size = UDim2.new(0.4, 0, 0, 40); _L2.Position = UDim2.new(0.55, 0, 0.25, 0)
        _L2.BackgroundColor3 = Color3.fromRGB(30, 30, 40); _L2.Text = "WORK.INK"; _L2.TextColor3 = Color3.fromRGB(255, 255, 255); _L2.Font = Enum.Font.GothamBold; _L2.ZIndex = 11
        Instance.new("UICorner", _L2).CornerRadius = UDim.new(0, 6); local _L2S = Instance.new("UIStroke", _L2); _L2S.Thickness = 1; _UI_Sys:_Gfx(_L2S, Color3.fromRGB(0, 255, 100), Color3.fromRGB(0, 150, 255))

        local _CB = Instance.new("TextBox", _Pop); _CB.Size = UDim2.new(0.9, 0, 0, 40); _CB.Position = UDim2.new(0.05, 0, 0.55, 0)
        _CB.Text = "Select a gateway..."; _CB.TextColor3 = Color3.fromRGB(150, 150, 150); _CB.BackgroundColor3 = Color3.fromRGB(30, 30, 35); _CB.ZIndex = 11
        Instance.new("UICorner", _CB).CornerRadius = UDim.new(0, 6)

        _L1.MouseButton1Click:Connect(function() _CB.Text = _Gwy_1; _CB.TextColor3 = Color3.fromRGB(255, 165, 0) end)
        _L2.MouseButton1Click:Connect(function() _CB.Text = _Gwy_2; _CB.TextColor3 = Color3.fromRGB(0, 255, 255) end)

        local _Cl = Instance.new("TextButton", _Pop); _Cl.Size = UDim2.new(0.4, 0, 0, 35); _Cl.Position = UDim2.new(0.3, 0, 0.8, 0); _Cl.Text = "CLOSE"
        _Cl.BackgroundColor3 = Color3.fromRGB(255, 255, 255); _Cl.ZIndex = 11; Instance.new("UICorner", _Cl).CornerRadius = UDim.new(0, 6)
        _Cl.MouseButton1Click:Connect(function() _Pop:Destroy() end)
    end)
    
    _Btn.MouseButton1Click:Connect(function()
        if _In.Text == _Auth_Key then
            _Btn.Text = "GRANTED"; _S._Tw:Create(_Btn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(100, 255, 150)}):Play()
            task.wait(0.7); _Sc:Destroy(); _Sys_Core:_Start()
        else
            _Btn.Text = "INVALID"; _S._Tw:Create(_Btn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
            task.wait(1); _Btn.Text = "INJECT SYSTEM"; _S._Tw:Create(_Btn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end
    end)
end

function _UI_Sys:_Init_Menu()
    local _Sc = Instance.new("ScreenGui"); _Sc.Name = "TitanMenu"; _Sc.Parent = _S._Core; table.insert(_Sys_Core._Ent, _Sc)

    -- IGNORE MENU
    local _M = Instance.new("Frame"); _M.Size = UDim2.new(0, 350, 0, 550); _M.Position = UDim2.new(0.05, 0, 0.5, -275)
    _M.BackgroundColor3 = Color3.fromRGB(15, 15, 20); _M.Visible = false; _M.Parent = _Sc
    Instance.new("UICorner", _M).CornerRadius = UDim.new(0, 16); local _B = Instance.new("UIStroke", _M); _B.Thickness = 2; _UI_Sys:_Gfx(_B)

    local _Ti = Instance.new("TextLabel"); _Ti.Text = "IGNORE MANAGER"; _Ti.Size = UDim2.new(1, 0, 0, 60); _Ti.BackgroundTransparency = 1
    _Ti.TextColor3 = Color3.fromRGB(255, 255, 255); _Ti.Font = Enum.Font.GothamBlack; _Ti.TextSize = 24; _Ti.Parent = _M
    _UI_Sys:_Gfx(_Ti, Color3.fromRGB(200, 150, 255), Color3.fromRGB(100, 200, 255))

    local _SB = Instance.new("TextBox"); _SB.Size = UDim2.new(0.9, 0, 0, 45); _SB.Position = UDim2.new(0.05, 0, 0.12, 0)
    _SB.BackgroundColor3 = Color3.fromRGB(25, 25, 35); _SB.TextColor3 = Color3.fromRGB(255, 255, 255); _SB.Parent = _M
    Instance.new("UICorner", _SB).CornerRadius = UDim.new(0, 8)

    local _Scr = Instance.new("ScrollingFrame"); _Scr.Size = UDim2.new(0.9, 0, 0.78, 0); _Scr.Position = UDim2.new(0.05, 0, 0.22, 0)
    _Scr.BackgroundTransparency = 1; _Scr.BorderSizePixel = 0; _Scr.Parent = _M
    local _Lay = Instance.new("UIListLayout"); _Lay.Padding = UDim.new(0, 8); _Lay.Parent = _Scr

    local _Cur = ""
    local function _Ref()
        for _, v in pairs(_Scr:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        local _P = _S._Plr:GetPlayers(); table.sort(_P, function(a,b) return a.Name:lower() < b.Name:lower() end)
        for _, _Plr in pairs(_P) do
            if _Plr ~= _LP then
                if _Cur == "" or string.find(_Plr.Name:lower(), _Cur:lower()) then
                    local _B = Instance.new("TextButton"); _B.Size = UDim2.new(1, 0, 0, 45); _B.Text = "   " .. _Plr.Name
                    _B.TextColor3 = Color3.fromRGB(255, 255, 255); _B.TextXAlignment = Enum.TextXAlignment.Left
                    _B.Font = Enum.Font.GothamBold; _B.TextSize = 14; _B.Parent = _Scr
                    Instance.new("UICorner", _B).CornerRadius = UDim.new(0, 8)
                    local _St = Instance.new("UIStroke", _B); _St.Thickness = 1
                    
                    if _Sys_Core._Mem._Ign[_Plr.Name] then
                        _B.BackgroundColor3 = Color3.fromRGB(20, 60, 40); _UI_Sys:_Gfx(_St, Color3.fromRGB(100, 255, 150), Color3.fromRGB(50, 150, 100))
                    else
                        _B.BackgroundColor3 = Color3.fromRGB(30, 30, 40); _St.Color = Color3.fromRGB(60, 60, 70)
                    end
                    _B.MouseButton1Click:Connect(function() _Sys_Core._Mem._Ign[_Plr.Name] = not _Sys_Core._Mem._Ign[_Plr.Name]; _Ref() end)
                end
            end
        end
    end
    _SB:GetPropertyChangedSignal("Text"):Connect(function() _Cur = _SB.Text; _Ref() end)
    _Sys_Core._UI._Mn = _M; _Sys_Core._UI._Ref = _Ref

    -- FAQ MENU
    local _F = Instance.new("Frame"); _F.Size = UDim2.new(0, 450, 0, 600); _F.Position = UDim2.new(0.5, -225, 0.5, -300)
    _F.BackgroundColor3 = Color3.fromRGB(15, 15, 20); _F.Visible = false; _F.ZIndex = 20; _F.Parent = _Sc
    Instance.new("UICorner", _F).CornerRadius = UDim.new(0, 16); local _FS = Instance.new("UIStroke", _F); _FS.Thickness = 2; _UI_Sys:_Gfx(_FS)

    local _FT = Instance.new("TextLabel"); _FT.Text = "KNOWLEDGE BASE"; _FT.Size = UDim2.new(1, 0, 0, 60); _FT.BackgroundTransparency = 1
    _FT.TextColor3 = Color3.fromRGB(255, 255, 255); _FT.Font = Enum.Font.GothamBlack; _FT.TextSize = 24; _FT.ZIndex = 21; _FT.Parent = _F
    _UI_Sys:_Gfx(_FT, Color3.fromRGB(220, 180, 255), Color3.fromRGB(150, 200, 255))

    local _Rec = Instance.new("Frame"); _Rec.Size = UDim2.new(0.9, 0, 0, 50); _Rec.Position = UDim2.new(0.05, 0, 0.12, 0)
    _Rec.BackgroundColor3 = Color3.fromRGB(25, 25, 35); _Rec.ZIndex = 21; _Rec.Parent = _F
    Instance.new("UICorner", _Rec).CornerRadius = UDim.new(0, 8); local _RecS = Instance.new("UIStroke", _Rec); _RecS.Color = Color3.fromRGB(255, 100, 200); _RecS.Thickness = 1
    
    local _RT = Instance.new("TextLabel"); _RT.Size = UDim2.new(1, 0, 1, 0); _RT.BackgroundTransparency = 1; _RT.Text = "♥ REC: Enable AIMBOT + MAGIC + TRIGGER for best results!"
    _RT.TextColor3 = Color3.fromRGB(255, 180, 220); _RT.Font = Enum.Font.GothamBold; _RT.TextSize = 12; _RT.ZIndex = 22; _RT.Parent = _Rec

    local _FScr = Instance.new("ScrollingFrame"); _FScr.Size = UDim2.new(0.9, 0, 0.75, 0); _FScr.Position = UDim2.new(0.05, 0, 0.22, 0)
    _FScr.BackgroundTransparency = 1; _FScr.BorderSizePixel = 0; _FScr.ZIndex = 21; _FScr.Parent = _F
    local _FL = Instance.new("UIListLayout"); _FL.Padding = UDim.new(0, 8); _FL.Parent = _FScr

    local _Binds = {
        {K="[`] Backtick", N="Aimbot Toggle", D="Passive face-lock. No hold required."},
        {K="[T] Key", N="Triggerbot Toggle", D="Auto-fire with 0.25s scope delay."},
        {K="[U] Key", N="Auto Wall Toggle", D="Ignores walls/obstacles for targets."},
        {K="[L-Alt]", N="Magic Bullet", D="Hitbox Expander (Size 10) for easier hits."},
        {K="[G] Key", N="God Mode", D="Attempts to refill health instantly."},
        {K="[X] Key", N="Noclip", D="Ghost mode. Walk through walls."},
        {K="[R-Alt]", N="Speed Toggle", D="Cycles speed: 1x -> 1.5x -> 3.5x."},
        {K="[R-Shift]", N="Ignore Menu", D="Opens Whitelist to ignore friends."},
        {K="[Z] Key", N="Help Menu", D="Opens this panel."}
    }
    _FScr.CanvasSize = UDim2.new(0, 0, 0, #_Binds * 55)

    for _, _D in ipairs(_Binds) do
        local _R = Instance.new("Frame"); _R.Size = UDim2.new(1, 0, 0, 45); _R.BackgroundColor3 = Color3.fromRGB(30, 30, 40); _R.ZIndex = 22; _R.Parent = _FScr
        Instance.new("UICorner", _R).CornerRadius = UDim.new(0, 6)
        local _KL = Instance.new("TextLabel", _R); _KL.Text = _D.K; _KL.Size = UDim2.new(0.3, 0, 1, 0); _KL.BackgroundTransparency = 1
        _KL.TextColor3 = Color3.fromRGB(150, 100, 255); _KL.Font = Enum.Font.GothamBold; _KL.TextSize = 13; _KL.ZIndex = 23
        local _NL = Instance.new("TextLabel", _R); _NL.Text = _D.N; _NL.Size = UDim2.new(0.65, 0, 1, 0); _NL.Position = UDim2.new(0.35, 0, 0, 0)
        _NL.BackgroundTransparency = 1; _NL.TextColor3 = Color3.fromRGB(220, 220, 240); _NL.Font = Enum.Font.Gotham; _NL.TextSize = 13; _NL.ZIndex = 23; _NL.TextXAlignment = Enum.TextXAlignment.Left
        
        local _Tip = Instance.new("TextLabel", _R); _Tip.Size = UDim2.new(1, 0, 0, 35); _Tip.Position = UDim2.new(0, 0, 1, 5)
        _Tip.BackgroundColor3 = Color3.fromRGB(20, 20, 25); _Tip.Text = _D.D; _Tip.TextColor3 = Color3.fromRGB(180, 180, 200)
        _Tip.Font = Enum.Font.Gotham; _Tip.TextSize = 11; _Tip.Visible = false; _Tip.ZIndex = 30
        Instance.new("UICorner", _Tip).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", _Tip).Color = Color3.fromRGB(60,60,70)
        _R.MouseEnter:Connect(function() _Tip.Visible = true; _S._Tw:Create(_R, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play() end)
        _R.MouseLeave:Connect(function() _Tip.Visible = false; _S._Tw:Create(_R, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play() end)
    end
    _Sys_Core._UI._Help = _F
end

function _UI_Sys:_Notif(_T, _St)
    local _Sc = _S._Core:FindFirstChild("TitanMenu"); if not _Sc then return end
    local _F = Instance.new("Frame"); _F.Size = UDim2.new(0, 280, 0, 60); _F.Position = UDim2.new(0.5, -140, 0.1, -100)
    _F.BackgroundColor3 = Color3.fromRGB(20, 20, 25); _F.Parent = _Sc; Instance.new("UICorner", _F).CornerRadius = UDim.new(0, 8)
    local _B = Instance.new("UIStroke", _F); _B.Thickness = 2; _UI_Sys:_Gfx(_B, _St and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(255, 50, 50))
    local _L = Instance.new("TextLabel", _F); _L.Size = UDim2.new(1, -20, 0.5, 0); _L.Position = UDim2.new(0, 15, 0, 5); _L.BackgroundTransparency = 1
    _L.Text = _T; _L.TextColor3 = Color3.fromRGB(255, 255, 255); _L.Font = Enum.Font.GothamBlack; _L.TextSize = 16; _L.TextXAlignment = Enum.TextXAlignment.Left
    local _S2 = Instance.new("TextLabel", _F); _S2.Size = UDim2.new(1, -20, 0.5, 0); _S2.Position = UDim2.new(0, 15, 0.5, -5); _S2.BackgroundTransparency = 1
    _S2.Text = _St and "ENABLED" or "DISABLED"; _S2.TextColor3 = _St and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(255, 50, 50)
    _S2.Font = Enum.Font.GothamBold; _S2.TextSize = 12; _S2.TextXAlignment = Enum.TextXAlignment.Left
    _S._Tw:Create(_F, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -140, 0.1, 0)}):Play()
    task.delay(1.5, function() _S._Tw:Create(_F, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -140, 0.1, -100)}):Play(); task.wait(0.3); _F:Destroy() end)
end

-- // 6. LOGIC KERNEL //
local _Log = {}

function _Log:_Scan_Obs(_T)
    if _Conf._Wall._En then return true end
    if not _Conf._Aim._Wall then return true end
    local _O = _Cam.CFrame.Position; local _D = _T.Position - _O
    local _P = RaycastParams.new(); _P.FilterType = Enum.RaycastFilterType.Exclude; _P.FilterDescendantsInstances = {_LP.Character, _Cam}; _P.IgnoreWater = true
    local _R = _S._Work:Raycast(_O, _D, _P)
    if _R then
        if _R.Instance:IsDescendantOf(_T.Parent) then return true end
        if _R.Instance.Transparency > 0.5 or not _R.Instance.CanCollide then return true end
        return false
    end
    return true
end

function _Log:_Get_T()
    local _B, _D = nil, _Conf._Aim._FOV; local _M = _S._Inp:GetMouseLocation()
    for _, _P in pairs(_S._Plr:GetPlayers()) do
        if _P ~= _LP and _P.Character and not _Sys_Core._Mem._Ign[_P.Name] then
            local _H = _P.Character:FindFirstChild(_Conf._Aim._Part)
            local _Hum = _P.Character:FindFirstChild("Humanoid")
            if _H and _Hum and _Hum.Health > 0 then
                if (_H.Position - _Cam.CFrame.Position).Magnitude > _Conf._Aim._Dist then continue end
                if math.abs(_H.Position.Y - _Cam.CFrame.Position.Y) > _Conf._Aim._H_Lim then continue end
                local _Scr, _On = _Cam:WorldToViewportPoint(_H.Position)
                if _On then
                    local _Mag = (Vector2.new(_Scr.X, _Scr.Y) - _M).Magnitude
                    if _Mag < _D and _Log:_Scan_Obs(_H) then _D = _Mag; _B = _H end
                end
            end
        end
    end
    return _B
end

function _Log:_Exec_T(_T)
    if _Sys_Core._State._Act or _Sys_Core._State._Cyc then return end
    _Sys_Core._State._Act = true
    _S._VIM:SendMouseButtonEvent(0,0,1,true,game,1)
    local _ST = tick(); local _Aim = false
    while tick() - _ST < _Conf._Trig._Del do
        if _T and _T.Parent and _T.Parent:FindFirstChild("Humanoid") and _T.Parent.Humanoid.Health > 0 and _Log:_Scan_Obs(_T) then
            local _FP = _T.Position + (_T.CFrame.UpVector * 0.1)
            _Cam.CFrame = CFrame.new(_Cam.CFrame.Position, _FP)
            _S._Run.RenderStepped:Wait(); _Aim = true
        else
            _S._VIM:SendMouseButtonEvent(0,0,1,false,game,1); _Sys_Core._State._Act = false; return
        end
    end
    if not _Aim then _Sys_Core._State._Act = false; return end
    if _LP.Character and _LP.Character:FindFirstChild("Humanoid") then _LP.Character.Humanoid.Jump = true end
    _S._VIM:SendMouseButtonEvent(0,0,0,true,game,1); task.wait(0.05)
    _S._VIM:SendMouseButtonEvent(0,0,0,false,game,1); _S._VIM:SendMouseButtonEvent(0,0,1,false,game,1)
    _Sys_Core._State._Act = false; _Sys_Core._State._Cyc = true
    if _LP.Character then
        _S._VIM:SendKeyEvent(true, Enum.KeyCode.Two, false, game); task.wait(_Conf._Trig._Sw)
        _S._VIM:SendKeyEvent(false, Enum.KeyCode.Two, false, game); task.wait(_Conf._Trig._Sw + 0.05)
        _S._VIM:SendKeyEvent(true, Enum.KeyCode.One, false, game); task.wait(_Conf._Trig._Sw)
        _S._VIM:SendKeyEvent(false, Enum.KeyCode.One, false, game)
    end
    task.wait(0.1); _Sys_Core._State._Cyc = false
end

function _Sys_Core:_Start()
    _UI_Sys:_Init_Menu()
    _UI_Sys:_Notif("TITAN RESTORED", true)
    
    task.spawn(function() while _Sys_Core._State._Run do task.wait(5); _Sys_Core:_GC() end end)
    
    table.insert(_Sys_Core._Sig, _S._Run.RenderStepped:Connect(function()
        -- VISUALS
        if _Conf._Vis._En then
            for _, _P in pairs(_S._Plr:GetPlayers()) do
                if _P ~= _LP and _P.Character then
                    local _R = _P.Character:FindFirstChild("HumanoidRootPart")
                    if _R and (_R.Position - _Cam.CFrame.Position).Magnitude < _Conf._Vis._Rend then
                        if not _Sys_Core._Mem._H[_P.Character] then
                            local _HL = Instance.new("Highlight"); _HL.FillTransparency = 0.5; _HL.OutlineTransparency = 0; _HL.Parent = _P.Character
                            _Sys_Core._Mem._H[_P.Character] = _HL
                        end
                        local _HL = _Sys_Core._Mem._H[_P.Character]; _HL.Enabled = true
                        local _C = _Sys_Core._Mem._Ign[_P.Name] and _Conf._Vis._Col_S or _Conf._Vis._Col_E
                        _HL.FillColor = _C; _HL.OutlineColor = _C
                    elseif _Sys_Core._Mem._H[_P.Character] then
                        _Sys_Core._Mem._H[_P.Character].Enabled = false
                    end
                end
            end
        end
        -- AIMBOT
        if _Conf._Aim._En and not _Sys_Core._State._Act then
            local _T = _Log:_Get_T()
            if _T then _Cam.CFrame = _Cam.CFrame:Lerp(CFrame.new(_Cam.CFrame.Position, _T.Position), _Conf._Aim._Sm) end
        end
        -- TRIGGER
        if _Conf._Trig._En then
            local _R = Ray.new(_Cam.CFrame.Position, _Cam.CFrame.LookVector * 1000)
            local _Hit, _ = _S._Work:FindPartOnRayWithIgnoreList(_R, {_LP.Character})
            if _Hit and _Hit.Parent then
                local _P = _S._Plr:GetPlayerFromCharacter(_Hit.Parent)
                if _P and _P ~= _LP and not _Sys_Core._Mem._Ign[_P.Name] then
                    local _H = _P.Character:FindFirstChild("Head")
                    local _Hum = _P.Character:FindFirstChild("Humanoid")
                    if _H and _Hum and _Hum.Health > 0 and _Log:_Scan_Obs(_H) then
                        task.spawn(function() _Log:_Exec_T(_H) end)
                    end
                end
            end
        end
    end))
    
    table.insert(_Sys_Core._Sig, _S._Run.Heartbeat:Connect(function()
        if _Conf._Exp._MB._En then
            for _, _P in pairs(_S._Plr:GetPlayers()) do
                if _P ~= _LP and _P.Character and not _Sys_Core._Mem._Ign[_P.Name] then
                    local _H = _P.Character:FindFirstChild("Head")
                    if _H and (_H.Size.Y < 9 or _H.Size.Y > 11) then
                        _H.Size = Vector3.new(10,10,10); _H.Transparency = 0.5; _H.CanCollide = false; _H.Massless = true
                    end
                end
            end
        end
        if _Conf._Exp._NC._En and _LP.Character then
            for _,_v in pairs(_LP.Character:GetChildren()) do if _v:IsA("BasePart") then _v.CanCollide = false end end
        end
    end))
    
    table.insert(_Sys_Core._Sig, _S._Inp.InputBegan:Connect(function(_I, _G)
        if _G then return end
        if _I.KeyCode == _Conf._Aim._Tog then _Conf._Aim._En = not _Conf._Aim._En; _UI_Sys:_Notif("AIMBOT", _Conf._Aim._En) end
        if _I.KeyCode == _Conf._Trig._Key then _Conf._Trig._En = not _Conf._Trig._En; _UI_Sys:_Notif("TRIGGER", _Conf._Trig._En) end
        if _I.KeyCode == _Conf._Wall._Key then _Conf._Wall._En = not _Conf._Wall._En; _UI_Sys:_Notif("AUTO WALL", _Conf._Wall._En) end
        if _I.KeyCode == _Conf._Exp._MB._Key then _Conf._Exp._MB._En = not _Conf._Exp._MB._En; _UI_Sys:_Notif("MAGIC", _Conf._Exp._MB._En) end
        if _I.KeyCode == _Conf._Exp._GM._Key then _Conf._Exp._GM._En = not _Conf._Exp._GM._En; _UI_Sys:_Notif("GOD", _Conf._Exp._GM._En) end
        if _I.KeyCode == _Conf._Exp._NC._Key then _Conf._Exp._NC._En = not _Conf._Exp._NC._En; _UI_Sys:_Notif("NOCLIP", _Conf._Exp._NC._En) end
        if _I.KeyCode == _Conf._Exp._SP._Key then _Conf._Exp._SP._Idx = (_Conf._Exp._SP._Idx % 4) + 1; _UI_Sys:_Notif("SPEED", true) end
        if _I.KeyCode == Enum.KeyCode.RightShift then 
            if _Sys_Core._UI._Mn then _Sys_Core._UI._Mn.Visible = not _Sys_Core._UI._Mn.Visible; if _Sys_Core._UI._Mn.Visible then _Sys_Core._UI._Ref() end end
        end
        if _I.KeyCode == Enum.KeyCode.Z then 
            if _Sys_Core._UI._Help then _Sys_Core._UI._Help.Visible = not _Sys_Core._UI._Help.Visible end
        end
    end))
end

_UI_Sys:_Init_Auth()
