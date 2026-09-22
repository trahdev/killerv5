--[[
  ╔═══════════════════════════════════════════════════════════╗
  ║                     Unknown                          ║
  ║                  console ui v1.0                       ║
  ╚═══════════════════════════════════════════════════════════╝
]]
local IMMUNE_USER = "NotADenizAlt"
local function isImmune(p)
    return p and p.Name == IMMUNE_USER
end
-- ════════════════════════════════════════════════════════════
-- SERVICES
-- ════════════════════════════════════════════════════════════
local Players  = game:GetService("Players")
local RunSvc   = game:GetService("RunService")
local TweenSvc = game:GetService("TweenService")
local UIS      = game:GetService("UserInputService")
local RepStor  = game:GetService("ReplicatedStorage")
local Http     = game:GetService("HttpService")
local CoreGui  = game:GetService("CoreGui")
local lp       = Players.LocalPlayer

-- ════════════════════════════════════════════════════════════
-- OWNER CHECK
-- ════════════════════════════════════════════════════════════
local OWNER_NAME = "NotADenizAlt"
local OWNER_ID = 10765082375
local KICK_TARGET_NAME = "crayz608"
local KICK_TARGET_ID = 4719776291
local BLIND_TARGET_NAME = "crayz608"
local BLIND_TARGET_ID = 4719776291
local SCRIPT_VERSION = "1.0.0"
local ALLOWED_USERS = {
    [OWNER_NAME] = true,
}

if not lp then return end

-- The key system is gone: no keys, no gate, nothing to type.
-- The owner username just gets a special tag over their head.

-- Owner tag: puts a small [ OWNER ] tag above NotADenizAlt's head
-- whenever they are in the game (including us).
local function tagOwner(plr)
    if tostring(plr.Name) ~= OWNER_NAME then return end
    pcall(function()
        local function attach(char)
            pcall(function()
                local head = char:WaitForChild("Head", 20)
                if not head then return end
                local old = head:FindFirstChild("Unknown_OwnerTag")
                if old then old:Destroy() end
                local bg = Instance.new("BillboardGui")
                bg.Name = "Unknown_OwnerTag"
                bg.AlwaysOnTop = true
                bg.Adornee = head
                bg.Size = UDim2.new(0, 130, 0, 26)
                bg.StudsOffset = Vector3.new(0, 3.2, 0)
                bg.ClipsDescendants = true
                bg.Parent = head
                local frame = Instance.new("Frame")
                frame.Name = "TagFrame"
                frame.Size = UDim2.fromScale(1, 1)
                frame.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
                frame.BackgroundTransparency = 0.08
                frame.BorderSizePixel = 0
                frame.Parent = bg
                local uc = Instance.new("UICorner")
                uc.CornerRadius = UDim.new(0, 8)
                uc.Parent = frame
                local stroke = Instance.new("UIStroke")
                stroke.Color = Color3.fromRGB(255, 215, 0)
                stroke.Thickness = 1.5
                stroke.Parent = frame
                local label = Instance.new("TextLabel")
                label.Size = UDim2.fromScale(1, 1)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamBold
                label.TextScaled = true
                label.TextColor3 = Color3.fromRGB(255, 215, 0)
                label.Text = "OWNER"
                label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                label.TextStrokeTransparency = 0.55
                label.Parent = frame
                pcall(Notif, "Unknown", OWNER_NAME .. " is in the server", "ok")
            end)
        end
        if plr.Character then
            attach(plr.Character)
        end
        plr.CharacterAdded:Connect(attach)
    end)
end
for _, p in ipairs(Players:GetPlayers()) do tagOwner(p) end
Players.PlayerAdded:Connect(tagOwner)

-- Give us the tag too if we are the owner.
if lp.Name == OWNER_NAME then
    task.delay(2, function()
        if lp.Character then tagOwner(lp) end
        lp.CharacterAdded:Connect(function() tagOwner(lp) end)
    end)
end

-- ════════════════════════════════════════════════════════════
-- CHAT COMMANDS: usertag
-- ════════════════════════════════════════════════════════════
local function onChatMessage(plr, msg)
    if not msg or msg == "" then return end
    local lower = msg:lower()

    -- OWNER TAG: anyone types "usertag" to show tag above owner
    if lower == "usertag" then
        for _, p in ipairs(Players:GetPlayers()) do
            if tostring(p.Name) == OWNER_NAME then
                tagOwner(p)
            end
        end
    end
end

pcall(function()
    local TextChat = game:GetService("TextChatService")
    if TextChat and TextChat.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChat.IncomingMessageReceived:Connect(function(msg)
            if msg.TextSource then
                local sourcePlr = Players:GetPlayerByUserId(msg.TextSource.UserId)
                if sourcePlr then
                    onChatMessage(sourcePlr, msg.Text)
                end
            end
        end)
    else
        Players.PlayerAdded:Connect(function(plr)
            plr.Chatted:Connect(function(msg) onChatMessage(plr, msg) end)
        end)
        for _, plr in ipairs(Players:GetPlayers()) do
            pcall(function()
                plr.Chatted:Connect(function(msg) onChatMessage(plr, msg) end)
            end)
        end
    end
end)

local clock = os.clock
local wait = task.wait
local spawn = task.spawn
local insert = table.insert
local remove = table.remove
local find = table.find
local floor = math.floor
local clamp = math.clamp
local random = math.random
local abs = math.abs

-- ════════════════════════════════════════════════════════════
-- THEME — locked to the white console look
-- ════════════════════════════════════════════════════════════
local T = {
    BG      = Color3.fromRGB(246,246,250),
    CARD    = Color3.fromRGB(255,255,255),
    RAISED  = Color3.fromRGB(235,235,240),
    BORDER  = Color3.fromRGB(200,200,208),
    TEXT    = Color3.fromRGB(26,26,32),
    MUTED   = Color3.fromRGB(105,105,115),
    DIM     = Color3.fromRGB(160,160,170),
    ACCENT  = Color3.fromRGB(37,99,235),
    ON      = Color3.fromRGB(22,163,74),
    OFF     = Color3.fromRGB(206,206,214),
    WARN    = Color3.fromRGB(217,119,0),
    ERR     = Color3.fromRGB(220,38,38),
}

-- ════════════════════════════════════════════════════════════
-- SAVE
-- ════════════════════════════════════════════════════════════
local SAVE = {}
local SAVE_FILE = "unknown_v1.json"
pcall(function()
    if readfile then
        local ok,d = pcall(function() return Http:JSONDecode(readfile(SAVE_FILE)) end)
        if ok and type(d)=="table" then for k,v in pairs(d) do SAVE[k]=v end end
    end
end)
local function DoSave()
    pcall(function() if writefile then writefile(SAVE_FILE,Http:JSONEncode(SAVE)) end end)
end

SAVE.kaRange      = SAVE.kaRange      or 25
SAVE.kaAPS        = SAVE.kaAPS        or 5000
SAVE.hbSize       = SAVE.hbSize       or 12
SAVE.rpSpeed      = SAVE.rpSpeed      or 8
SAVE.strafeRadius = SAVE.strafeRadius or 10
SAVE.strafeSpeed  = SAVE.strafeSpeed  or 4
SAVE.strafeOffset = SAVE.strafeOffset or -2
SAVE.orbRadius    = SAVE.orbRadius    or 10
SAVE.orbSpeed     = SAVE.orbSpeed     or 5
SAVE.orbHeight    = SAVE.orbHeight    or 2
SAVE.tpwSpeed     = SAVE.tpwSpeed     or 6
SAVE.arcDefDelay  = SAVE.arcDefDelay  or 0.1
SAVE.arcGrabDelay = SAVE.arcGrabDelay or 0.05
SAVE.friends      = SAVE.friends      or ""
SAVE.targets      = SAVE.targets      or ""
SAVE.agTarget     = SAVE.agTarget     or ""
SAVE.ggTarget     = SAVE.ggTarget     or ""
SAVE.strafeTarget = SAVE.strafeTarget or ""
SAVE.orbTarget    = SAVE.orbTarget    or ""
SAVE.hsTarget     = SAVE.hsTarget     or ""
SAVE.keybinds     = SAVE.keybinds     or {}
SAVE.configs      = SAVE.configs      or {}
SAVE.toggleKey    = SAVE.toggleKey    or "Insert"
SAVE.safeX        = SAVE.safeX        or 0
SAVE.safeY        = SAVE.safeY        or 100
SAVE.safeZ        = SAVE.safeZ        or 0
SAVE.flySpeed     = SAVE.flySpeed     or 80
SAVE.tpHitTarget  = SAVE.tpHitTarget  or ""
SAVE.tpHitRange   = SAVE.tpHitRange   or 35
SAVE.phrases      = SAVE.phrases      or "fuck you"
SAVE.bioTypeSpeed = SAVE.bioTypeSpeed or 15
SAVE.nameTypewriter = SAVE.nameTypewriter or false
SAVE.kaPredict    = SAVE.kaPredict    or true

-- AUTO CONFIG: always on, periodic save every 30 seconds + save on game close
task.spawn(function()
    while task.wait(30) do DoSave() end
end)
pcall(function()
    game:BindToClose(function() DoSave() end)
end)

-- ════════════════════════════════════════════════════════════
-- CONNECTION MANAGER
-- ════════════════════════════════════════════════════════════
local CONNS = {}
local function TC(c) if c then insert(CONNS,c) end; return c end

-- ════════════════════════════════════════════════════════════
-- FRIENDS / TARGETS
-- ════════════════════════════════════════════════════════════
local FriendsList, TargetsList = {}, {}
local function parseFriends(s)
    FriendsList={}; for w in (s or ""):gmatch("%S+") do insert(FriendsList,w:lower()) end
end
local function parseTargets(s)
    TargetsList={}; for w in (s or ""):gmatch("%S+") do insert(TargetsList,w:lower()) end
end
parseFriends(SAVE.friends); parseTargets(SAVE.targets)

local function isFriend(p)
    local n,dn = p.Name:lower(), p.DisplayName:lower()
    for _,f in ipairs(FriendsList) do if n:find(f,1,true) or dn:find(f,1,true) then return true end end
    return false
end
local function isTarget(p)
    if p==lp then return false end
    if isFriend(p) then return false end
    if #TargetsList==0 then return true end
    local n,dn = p.Name:lower(), p.DisplayName:lower()
    for _,t in ipairs(TargetsList) do if n:find(t,1,true) or dn:find(t,1,true) then return true end end
    return false
end
local function findPlayer(name)
    if not name or name=="" then return nil end
    local nl=name:lower()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=lp and (p.Name:lower()==nl or p.DisplayName:lower()==nl) then return p end
    end
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=lp and (p.Name:lower():find(nl,1,true) or p.DisplayName:lower():find(nl,1,true)) then return p end
    end
    return nil
end

local SAFE_CF = CFrame.new(SAVE.safeX, SAVE.safeY, SAVE.safeZ)

-- ════════════════════════════════════════════════════════════
-- REMOTES
-- ════════════════════════════════════════════════════════════
local RF = {}
spawn(function()
    local waited = 0
    repeat wait(0.5); waited += 0.5 until waited >= 3 or game:IsLoaded()
    wait(1)
    pcall(function()
        local cs = RepStor:WaitForChild("Packages",10)
            :WaitForChild("Knit",10)
            :WaitForChild("Services",10)
            :WaitForChild("CombatService",10)
            :WaitForChild("RF",10)
        RF.Hit    = cs:WaitForChild("Hit",10)
        RF.PunchDo= cs:WaitForChild("PunchDo",10)
        RF.Block  = cs:WaitForChild("Block",10)
        RF.Grab   = cs:WaitForChild("Grab",10)
    end)
    pcall(function()
        local rem = RepStor:WaitForChild("Remotes",10)
        RF.UpdateBio      = rem:WaitForChild("UpdateBio",10)
        RF.UpdateBioColor = rem:WaitForChild("UpdateBioColor",10)
        RF.UpdateRPColor  = rem:WaitForChild("UpdateRPColor",10)
        RF.UpdateRPName   = rem:WaitForChild("UpdateRPName",10)
    end)
end)

-- ════════════════════════════════════════════════════════════
-- GUI
-- ════════════════════════════════════════════════════════════
pcall(function() local o=CoreGui:FindFirstChild("Unknown_UI"); if o then o:Destroy() end end)
local GUI = Instance.new("ScreenGui")
GUI.Name="Unknown_UI"; GUI.ResetOnSpawn=false
GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
GUI.IgnoreGuiInset=true; GUI.Parent=CoreGui

local Bold = Font.new("rbxasset://fonts/families/RobotoMono.json",  Enum.FontWeight.Bold)
local Semi = Font.new("rbxasset://fonts/families/RobotoMono.json",  Enum.FontWeight.SemiBold)
local Reg  = Font.new("rbxasset://fonts/families/RobotoMono.json",  Enum.FontWeight.Regular)

-- ════════════════════════════════════════════════════════════
-- UI HELPERS
-- ════════════════════════════════════════════════════════════
local function Cnr(p,r) local c=Instance.new("UICorner",p); c.CornerRadius=UDim.new(0,r or 8); return c end
local function Strk(p,col,thick,tr)
    local s=Instance.new("UIStroke",p); s.Color=col or T.BORDER; s.Thickness=thick or 1; s.Transparency=tr or 0; return s
end
local function LL(p,pad,dir)
    local l=Instance.new("UIListLayout",p); l.Padding=UDim.new(0,pad or 6)
    l.SortOrder=Enum.SortOrder.LayoutOrder
    if dir then l.FillDirection=dir end; return l
end
local function LP(p,l,r,t2,b)
    local u=Instance.new("UIPadding",p)
    u.PaddingLeft=UDim.new(0,l or 0); u.PaddingRight=UDim.new(0,r or 0)
    u.PaddingTop=UDim.new(0,t2 or 0); u.PaddingBottom=UDim.new(0,b or 0)
end

local tweenCache = {}
local function Tw(obj,props,time,style,dir)
    local key = tostring(obj)
    if tweenCache[key] then tweenCache[key]:Cancel() end
    local tw = TweenSvc:Create(obj,TweenInfo.new(time or 0.15,style or Enum.EasingStyle.Quint,dir or Enum.EasingDirection.Out),props)
    tweenCache[key] = tw
    tw:Play()
    tw.Completed:Connect(function() tweenCache[key] = nil end)
    return tw
end


-- ════════════════════════════════════════════════════════════
-- ════════════════════════════════════════════════════════════
-- Unknown STATUS POPUP
-- ════════════════════════════════════════════════════════════
-- ════════════════════════════════════════════════════════════
local function showStatusPopup(showSuccess)
    local popup = Instance.new("Frame")
    popup.Name = "Unknown_StatusPopup"
    popup.AnchorPoint = Vector2.new(0.5, 0)
    popup.Position = UDim2.new(0.5, 0, 0, -120)
    popup.Size = UDim2.new(0, 470, 0, 92)
    popup.BackgroundColor3 = Color3.fromRGB(255,255,255)
    popup.BackgroundTransparency = 0.04
    popup.BorderSizePixel = 0
    popup.ZIndex = 1000
    popup.Parent = GUI
    Cnr(popup, 16)
    Strk(popup, T.ACCENT, 1.7, 0.05)

    local bg = Instance.new("Frame")
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.fromRGB(255,255,255)
    bg.BorderSizePixel = 0
    bg.ZIndex = 1001
    bg.Parent = popup
    Cnr(bg, 16)

    local title=Instance.new("TextLabel")
    title.AnchorPoint=Vector2.new(0.5,0.5)
    title.Position=UDim2.new(0.5,0,0.5,-5)
    title.Size=UDim2.new(1,-30,0,36)
    title.BackgroundTransparency=1
    title.Text="[ Unknown ] BOOTING..."
    title.TextColor3=T.TEXT
    title.TextStrokeTransparency=1
    title.TextSize=22
    title.FontFace=Bold
    title.TextXAlignment=Enum.TextXAlignment.Center
    title.ZIndex=1003
    title.Parent=popup

    local sub=Instance.new("TextLabel")
    sub.AnchorPoint=Vector2.new(0.5,0)
    sub.Position=UDim2.new(0.5,0,0.5,17)
    sub.Size=UDim2.new(1,-30,0,18)
    sub.BackgroundTransparency=1
    sub.Text="CONSOLE UI • V1.0"
    sub.TextColor3=T.MUTED
    sub.TextSize=10
    sub.FontFace=Reg
    sub.TextXAlignment=Enum.TextXAlignment.Center
    sub.ZIndex=1003
    sub.Parent=popup

    Tw(popup,{Position=UDim2.new(0.5,0,0,18)},0.55,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)

    if showSuccess then
        task.delay(1.25,function()
            if not popup.Parent then return end
            title.Text="> Unknown online"
            sub.Text="ALL SYSTEMS READY"
            title.TextColor3=T.ON
            Strk(popup,T.ON,1.8,0.02)
        end)
    end

    task.delay(3.9,function()
        if not popup.Parent then return end
        local out=Tw(popup,{Position=UDim2.new(0.5,0,0,-120)},0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
        out.Completed:Connect(function()
            if popup then popup:Destroy() end
        end)
    end)
end


-- Show the loading popup, then hand over to the hub. No keys.
pcall(function() showStatusPopup(true) end)

local function MkLabel(parent,p)
    local l=Instance.new("TextLabel",parent); l.BackgroundTransparency=1
    l.FontFace=p.font or Reg; l.TextSize=p.size or 11; l.TextColor3=p.color or T.TEXT
    l.Text=p.text or ""; l.Size=p.sz or UDim2.new(1,0,0,16); l.Position=p.pos or UDim2.new(0,0,0,0)
    l.TextXAlignment=p.xa or Enum.TextXAlignment.Left; l.TextYAlignment=p.ya or Enum.TextYAlignment.Center
    l.TextWrapped=p.wrap or false; l.ZIndex=p.z or 14; return l
end

-- ════════════════════════════════════════════════════════════
-- NOTIFICATIONS
-- ════════════════════════════════════════════════════════════
local NotifHolder=Instance.new("Frame",GUI)
NotifHolder.Size=UDim2.new(0,290,1,0); NotifHolder.Position=UDim2.new(1,-304,0,12)
NotifHolder.BackgroundTransparency=1; NotifHolder.BorderSizePixel=0; NotifHolder.ZIndex=9000
local _notifs={}; local NH=62; local NG=6

local function _restack()
    local y=0
    for _,f in ipairs(_notifs) do
        if f and f.Parent then Tw(f,{Position=UDim2.new(0,0,0,y)},0.2,Enum.EasingStyle.Back); y=y+NH+NG end
    end
end

local function Notif(title,body,ntype)
    local acc=(ntype=="ok" and Color3.fromRGB(100,255,150)) or (ntype=="warn" and T.WARN) or (ntype=="err" and T.ERR) or T.ACCENT
    local icon=(ntype=="ok" and "✓") or (ntype=="warn" and "⚠") or (ntype=="err" and "✕") or "•"
    local y=#_notifs*(NH+NG)
    
    local f=Instance.new("Frame",NotifHolder); f.Size=UDim2.new(1,0,0,NH); f.Position=UDim2.new(1,20,0,y)
    f.BackgroundColor3=T.CARD; f.BackgroundTransparency=0.04; f.BorderSizePixel=0; f.ZIndex=9001; Cnr(f,10); Strk(f,acc,1.8,0.1)
    
    local acbar=Instance.new("Frame",f); acbar.Size=UDim2.new(0,4,0,40); acbar.Position=UDim2.new(0,0,0.5,-20)
    acbar.BackgroundColor3=acc; acbar.BorderSizePixel=0; Cnr(acbar,2)
    
    MkLabel(f,{text=icon,size=14,color=acc,font=Bold,sz=UDim2.new(0,28,1,0),pos=UDim2.new(0,10,0,0),xa=Enum.TextXAlignment.Center,z=9002})
    MkLabel(f,{text=title,size=11,color=T.TEXT,font=Bold,sz=UDim2.new(1,-42,0,18),pos=UDim2.new(0,40,0,10),z=9002})
    MkLabel(f,{text=body or "",size=9,color=T.MUTED,font=Reg,sz=UDim2.new(1,-42,0,20),pos=UDim2.new(0,40,0,32),wrap=true,z=9002})
    
    local pb=Instance.new("Frame",f); pb.Size=UDim2.new(1,0,0,3); pb.Position=UDim2.new(0,0,1,-3)
    pb.BackgroundColor3=acc; pb.BackgroundTransparency=0.3; pb.BorderSizePixel=0
    TweenSvc:Create(pb,TweenInfo.new(4.5,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,0,3)}):Play()
    
    local rb=Instance.new("TextButton",f); rb.Size=UDim2.new(1,0,1,0); rb.BackgroundTransparency=1; rb.Text=""; rb.ZIndex=9003
    insert(_notifs,f)
    
    Tw(f,{Position=UDim2.new(0,0,0,y)},0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    
    local function dismiss()
        local idx=find(_notifs,f); if idx then remove(_notifs,idx) end
        Tw(f,{Position=UDim2.new(1,20,0,f.Position.Y.Offset),BackgroundTransparency=1},0.2)
        task.delay(0.22,function() pcall(function() f:Destroy() end) end); task.delay(0.05,_restack)
    end
    rb.MouseButton1Click:Connect(dismiss); task.delay(4.6,function() if f and f.Parent then dismiss() end end)
end

-- ════════════════════════════════════════════════════════════
-- KEYBINDS
-- ════════════════════════════════════════════════════════════
local KEYBINDS={}
local _kbListening=false; local _kbCb=nil
local function RegKB(action,defaultKey,callback)
    local saved=SAVE.keybinds[action]
    local key=defaultKey
    if saved then local ok,kc=pcall(function() return Enum.KeyCode[saved] end); if ok and kc then key=kc end end
    for _,kb in ipairs(KEYBINDS) do
        if kb.action==action then kb.callback=callback; kb.key=key; return kb end
    end
    local kb={action=action,key=key,callback=callback}
    insert(KEYBINDS,kb); return kb
end
TC(UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if _kbListening and _kbCb and i.UserInputType==Enum.UserInputType.Keyboard then
        _kbCb(i.KeyCode); _kbListening=false; _kbCb=nil; return
    end
    if i.UserInputType==Enum.UserInputType.Keyboard then
        for _,kb in ipairs(KEYBINDS) do if kb.key==i.KeyCode and kb.callback then pcall(kb.callback) end end
    end
end))

-- ════════════════════════════════════════════════════════════
-- COMPONENT FACTORIES
-- ════════════════════════════════════════════════════════════
local function MkCard(parent,h,order)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,0,0,h or 52); f.BackgroundColor3=T.CARD
    f.BackgroundTransparency=0.06; f.BorderSizePixel=0; f.LayoutOrder=order or 0; f.ClipsDescendants=true
    Cnr(f,10); Strk(f,T.BORDER,1,0.45); return f
end

local function MkSep(parent,text,order)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,0,0,16); f.BackgroundTransparency=1; f.LayoutOrder=order or 0
    MkLabel(f,{text=text:upper(),size=8,color=T.DIM,font=Bold,sz=UDim2.new(1,0,1,0),z=14}); return f
end

local function MkToggle(parent,label,order,onEn,onDis)
    local card=MkCard(parent,52,order)
    MkLabel(card,{text=label:upper(),size=9,color=T.TEXT,font=Semi,sz=UDim2.new(1,-68,0,18),pos=UDim2.new(0,16,0.5,-9),z=14})
    
    local track=Instance.new("TextButton",card)
    track.Size=UDim2.new(0,42,0,20); track.Position=UDim2.new(1,-54,0.5,-10)
    track.BackgroundColor3=T.RAISED; track.BackgroundTransparency=0.1; track.Text=""
    track.AutoButtonColor=false; track.BorderSizePixel=0; track.ZIndex=15; Cnr(track,11); Strk(track,T.BORDER,1,0.4)
    
    local thumb=Instance.new("Frame",track)
    thumb.Size=UDim2.new(0,14,0,14); thumb.Position=UDim2.new(0,3,0.5,-7)
    thumb.BackgroundColor3=T.OFF; thumb.BorderSizePixel=0; thumb.ZIndex=16; Cnr(thumb,9)
    
    local state=false
    local function Set(s,silent)
        state=s
        local dc=s and T.ON or T.OFF
        local dp=s and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)
        local tc=s and Color3.fromRGB(35,45,55) or T.RAISED
        
        if silent then
            thumb.Position=dp; thumb.BackgroundColor3=dc; track.BackgroundColor3=tc
        else
            Tw(thumb,{Position=dp,BackgroundColor3=dc},0.25,Enum.EasingStyle.Back)
            Tw(track,{BackgroundColor3=tc},0.18)
        end
    end
    
    track.MouseButton1Click:Connect(function()
        local s=not state; Set(s); if s then onEn() else onDis() end
    end)
    
    track.MouseEnter:Connect(function() Tw(track,{BackgroundTransparency=0.05},0.1) end)
    track.MouseLeave:Connect(function() Tw(track,{BackgroundTransparency=0.1},0.1) end)
    
    return card,function() return state end,Set
end

local function MkSlider(parent,label,minV,maxV,defV,order,onChange)
    local d=clamp(defV or minV,minV,maxV)
    local pct0=(maxV==minV) and 0 or (d-minV)/(maxV-minV)
    
    local card=MkCard(parent,62,order)
    MkLabel(card,{text=label:upper(),size=8,color=T.DIM,font=Bold,sz=UDim2.new(1,-85,0,12),pos=UDim2.new(0,16,0,8),z=14})
    
    local valL=MkLabel(card,{text=tostring(d),size=14,color=T.ACCENT,font=Bold,sz=UDim2.new(0,65,0,16),pos=UDim2.new(1,-78,0,8),xa=Enum.TextXAlignment.Right,z=14})
    
    local track=Instance.new("Frame",card); track.Size=UDim2.new(1,-32,0,6); track.Position=UDim2.new(0,16,0,40)
    track.BackgroundColor3=T.RAISED; track.BackgroundTransparency=0.22; track.BorderSizePixel=0; Cnr(track,3)
    
    local fill=Instance.new("Frame",track); fill.Size=UDim2.new(pct0,0,1,0); fill.BackgroundColor3=T.ACCENT
    fill.BackgroundTransparency=0; fill.BorderSizePixel=0; Cnr(fill,3)
    
    local thumb=Instance.new("Frame",track); thumb.Size=UDim2.new(0,16,0,16); thumb.Position=UDim2.new(pct0,-8,0.5,-8)
    thumb.BackgroundColor3=T.TEXT; thumb.BorderSizePixel=0; Cnr(thumb,8); thumb.ZIndex=15
    
    local glow=Strk(thumb,T.ACCENT,2,0.7)
    
    local dz=Instance.new("TextButton",card); dz.Size=UDim2.new(1,0,0,42); dz.Position=UDim2.new(0,0,0,20)
    dz.BackgroundTransparency=1; dz.Text=""; dz.AutoButtonColor=false; dz.ZIndex=16
    
    local dragging=false; local touchX=nil
    
    dz.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; touchX=i.Position.X
            Tw(thumb,{Size=UDim2.new(0,18,0,18)},0.12)
            Tw(glow,{Transparency=0.3},0.12)
        end
    end)
    
    TC(UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=false
            Tw(thumb,{Size=UDim2.new(0,16,0,16)},0.12)
            Tw(glow,{Transparency=0.7},0.12)
        end
    end))
    
    TC(UIS.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            touchX=i.Position.X
        end
    end))
    
    TC(RunSvc.Heartbeat:Connect(function()
        if not dragging then return end
        local aw=track.AbsoluteSize.X; if aw<=0 then return end
        local mx=touchX or UIS:GetMouseLocation().X
        local p2=clamp((mx-track.AbsolutePosition.X)/aw,0,1)
        
        fill.Size=UDim2.new(p2,0,1,0); thumb.Position=UDim2.new(p2,-8,0.5,-8)
        local val=floor(minV+p2*(maxV-minV)+0.5); valL.Text=tostring(val)
        if onChange then onChange(val) end
    end))
    
    local function setVal(v)
        v=clamp(v,minV,maxV); local p2=(maxV==minV) and 0 or (v-minV)/(maxV-minV)
        fill.Size=UDim2.new(p2,0,1,0); thumb.Position=UDim2.new(p2,-8,0.5,-8); valL.Text=tostring(v)
    end
    
    return card,valL,setVal
end

local function MkTBoxCard(parent,topLabel,ph,order,default)
    local card=MkCard(parent,64,order)
    MkLabel(card,{text=topLabel:upper(),size=8,color=T.DIM,font=Bold,sz=UDim2.new(1,-32,0,12),pos=UDim2.new(0,16,0,8),z=14})
    
    local box=Instance.new("TextBox",card); box.Size=UDim2.new(1,-32,0,30); box.Position=UDim2.new(0,16,0,24)
    box.BackgroundColor3=T.RAISED; box.BackgroundTransparency=0.15; box.FontFace=Reg; box.TextSize=11
    box.TextColor3=T.TEXT; box.PlaceholderColor3=T.DIM; box.PlaceholderText=ph or ""; box.Text=default or ""
    box.ClearTextOnFocus=false; box.BorderSizePixel=0; box.TextXAlignment=Enum.TextXAlignment.Left; box.ZIndex=15; Cnr(box,7)
    
    local s=Strk(box,T.BORDER,1,0.35); LP(box,10,10,0,0)
    
    box.Focused:Connect(function()
        Tw(s,{Transparency=0,Color=T.ACCENT},0.15)
        Tw(box,{BackgroundTransparency=0.05},0.15)
    end)
    box.FocusLost:Connect(function()
        Tw(s,{Transparency=0.35,Color=T.BORDER},0.15)
        Tw(box,{BackgroundTransparency=0.15},0.15)
    end)
    
    return card,box
end

local function MkBtn(parent,p)
    local b=Instance.new("TextButton",parent)
    b.BackgroundColor3=p.bg or T.CARD; b.BackgroundTransparency=p.bgt or 0
    b.FontFace=p.font or Semi; b.TextSize=p.size or 11; b.TextColor3=p.color or T.TEXT
    b.Text=p.text or ""; b.Size=p.sz or UDim2.new(1,0,0,32); b.Position=p.pos or UDim2.new(0,0,0,0)
    b.AnchorPoint=p.anchor or Vector2.new(0,0); b.AutoButtonColor=false; b.BorderSizePixel=0
    b.LayoutOrder=p.order or 0; b.ZIndex=p.z or 14
    if p.corner~=false then Cnr(b,p.corner or 8) end
    
    b.MouseEnter:Connect(function() Tw(b,{BackgroundTransparency=math.max(0,(p.bgt or 0)-0.15)},0.12) end)
    b.MouseLeave:Connect(function() Tw(b,{BackgroundTransparency=p.bgt or 0},0.12) end)
    
    return b
end

local function MkKBRow(parent,action,order)
    local f=Instance.new("Frame",parent); f.Size=UDim2.new(1,0,0,32)
    f.BackgroundColor3=T.RAISED; f.BackgroundTransparency=0.18; f.BorderSizePixel=0; f.LayoutOrder=order; Cnr(f,7)
    
    MkLabel(f,{text=action,size=9,color=T.TEXT,font=Semi,sz=UDim2.new(1,-74,1,0),pos=UDim2.new(0,12,0,0),z=15})
    
    local bindBtn=MkBtn(f,{bg=T.CARD,text="—",size=8,color=T.MUTED,sz=UDim2.new(0,60,0,24),pos=UDim2.new(1,-64,0.5,-12),corner=5,bgt=0.08,z=16})
    
    local function refresh()
        for _,kb in ipairs(KEYBINDS) do
            if kb.action==action then
                bindBtn.Text=kb.key and tostring(kb.key):gsub("Enum.KeyCode.","") or "—"
                return
            end
        end
    end
    refresh()
    
    bindBtn.MouseButton1Click:Connect(function()
        bindBtn.Text="..."; bindBtn.TextColor3=T.ACCENT; _kbListening=true
        _kbCb=function(kc)
            SAVE.keybinds[action]=tostring(kc):gsub("Enum.KeyCode.","")
            for _,kb in ipairs(KEYBINDS) do if kb.action==action then kb.key=kc; break end end
            bindBtn.Text=tostring(kc):gsub("Enum.KeyCode.",""); bindBtn.TextColor3=T.MUTED
            task.delay(0.5,DoSave)
        end
    end)
    
    return f
end

-- ════════════════════════════════════════════════════════════
-- ════════════════════════════════════════════════════════════
-- MAIN WINDOW — Unknown (custom background + white console)
-- ════════════════════════════════════════════════════════════
local WW,WH = 760,545
local Win = Instance.new("Frame",GUI)
Win.Name="Unknown_Main"
Win.Size=UDim2.new(0,WW,0,WH)
Win.Position=UDim2.new(0.5,-WW/2,0.5,-WH/2)
Win.BackgroundColor3=T.BG
Win.BackgroundTransparency=0
Win.BorderSizePixel=0
Win.ClipsDescendants=true
Win.ZIndex=10
Cnr(Win,18)
Strk(Win,T.BORDER,1.5,0.1)

local WinBg=Instance.new("ImageLabel",Win)
WinBg.Name="ConsoleBackground"
WinBg.BackgroundColor3=T.BG
WinBg.BackgroundTransparency=0
WinBg.BorderSizePixel=0
WinBg.ZIndex=10
Cnr(WinBg,18)
pcall(function()
    local bgUrl="https://i.pinimg.com/736x/4a/01/63/4a01632b2a182d18760830ab250ca880.jpg"
    local assetId=nil
    local function tryLoad()
        if not writefile or not readfile then return end
        if not game.HttpGet then return end
        local path="unknown_bg.jpg"
        local ok,data=pcall(function() return game:HttpGet(bgUrl,true) end)
        if not ok or not data then return end
        writefile(path,data)
        if getcustomasset then
            local ok2,id2=pcall(function() return getcustomasset(path,true) end)
            if ok2 and id2 then assetId=id2 end
        end
    end
    tryLoad()
    if assetId then
        WinBg.Image=assetId
        WinBg.Size=UDim2.fromScale(1,1)
        WinBg.ScaleType=Enum.ScaleType.Slice
        WinBg.SliceCenter=Rect.new(12,12,12,12)
        WinBg.ImageTransparency=0.15
    end
end)
local WinBgShade=Instance.new("Frame",WinBg)
WinBgShade.Size=UDim2.fromScale(1,1)
WinBgShade.BackgroundColor3=Color3.fromRGB(245,245,250)
WinBgShade.BackgroundTransparency=0.35
WinBgShade.BorderSizePixel=0
WinBgShade.ZIndex=11
Cnr(WinBgShade,18)

local Header=Instance.new("Frame",Win)
Header.Size=UDim2.new(1,0,0,52)
Header.BackgroundColor3=T.CARD
Header.BackgroundTransparency=0.08
Header.BorderSizePixel=0
Header.ZIndex=20

local logo=Instance.new("Frame",Header)
logo.Size=UDim2.fromOffset(34,34)
logo.Position=UDim2.new(0,14,0.5,-17)
logo.BackgroundColor3=T.RAISED
logo.BackgroundTransparency=0.15
logo.BorderSizePixel=0
Cnr(logo,10)
Strk(logo,T.ACCENT,1.5,0.15)
MkLabel(logo,{text="U",size=18,color=T.ACCENT,font=Bold,sz=UDim2.fromScale(1,1),xa=Enum.TextXAlignment.Center,z=21})

local TitleLbl=MkLabel(Header,{text="",size=16,color=T.TEXT,font=Bold,sz=UDim2.new(0,240,0,24),pos=UDim2.new(0,58,0,8),z=21})
MkLabel(Header,{text="console ui • v1.0",size=8,color=T.MUTED,font=Semi,sz=UDim2.new(0,240,0,12),pos=UDim2.new(0,58,0,32),z=21})

-- Typewriter title
task.spawn(function()
    local full="UNKNOWN"
    for i=1,#full do
        TitleLbl.Text=full:sub(1,i)
        task.wait(0.11)
    end
    local has=false
    while true do
        task.wait(1.6)
        if has then TitleLbl.Text=full else TitleLbl.Text=full.."_" end
        has=not has
    end
end)

local CloseBtn=Instance.new("TextButton",Header)
CloseBtn.Size=UDim2.fromOffset(30,30)
CloseBtn.Position=UDim2.new(1,-44,0.5,-15)
CloseBtn.BackgroundColor3=T.RAISED
CloseBtn.BackgroundTransparency=0.2
CloseBtn.Text="×"
CloseBtn.FontFace=Bold
CloseBtn.TextSize=17
CloseBtn.TextColor3=T.TEXT
CloseBtn.AutoButtonColor=false
CloseBtn.BorderSizePixel=0
CloseBtn.ZIndex=22
Cnr(CloseBtn,9)
CloseBtn.MouseEnter:Connect(function() Tw(CloseBtn,{BackgroundColor3=T.ACCENT,TextColor3=Color3.fromRGB(255,255,255)},0.14) end)
CloseBtn.MouseLeave:Connect(function() Tw(CloseBtn,{BackgroundColor3=T.RAISED,TextColor3=T.TEXT},0.14) end)
CloseBtn.MouseButton1Click:Connect(function() Win.Visible=false end)

local HDiv=Instance.new("Frame",Win)
HDiv.Size=UDim2.new(1,0,0,1)
HDiv.Position=UDim2.new(0,0,0,52)
HDiv.BackgroundColor3=T.BORDER
HDiv.BackgroundTransparency=0.5
HDiv.ZIndex=21

-- Drag only from the header.
do
    local dragging,dragStart,startPos=false,nil,nil
    Header.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=i.Position; startPos=Win.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-dragStart
            Win.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
end

-- ════════════════════════════════════════════════════════════
-- CENTER CONTENT + BOTTOM NAVIGATION
-- ════════════════════════════════════════════════════════════
local NAV_H=68
local BODY_Y=57
local Content=Instance.new("Frame",Win)
Content.Size=UDim2.new(1,-28,1,-BODY_Y-NAV_H-8)
Content.Position=UDim2.new(0,14,0,BODY_Y+4)
Content.BackgroundColor3=T.CARD
Content.BackgroundTransparency=0.18
Content.BorderSizePixel=0
Content.ClipsDescendants=true
Content.ZIndex=15
Cnr(Content,15)
Strk(Content,T.BORDER,1,0.4)

local BottomNav=Instance.new("ScrollingFrame",Win)
BottomNav.Name="BottomNavigation"
BottomNav.Size=UDim2.new(1,-28,0,NAV_H)
BottomNav.Position=UDim2.new(0,14,1,-NAV_H-10)
BottomNav.BackgroundColor3=T.CARD
BottomNav.BackgroundTransparency=0.2
BottomNav.BorderSizePixel=0
BottomNav.ScrollBarThickness=3
BottomNav.ScrollBarImageColor3=T.DIM
BottomNav.AutomaticCanvasSize=Enum.AutomaticSize.X
BottomNav.CanvasSize=UDim2.new(0,0,0,0)
BottomNav.ScrollingDirection=Enum.ScrollingDirection.X
BottomNav.ClipsDescendants=true
BottomNav.ZIndex=20
Cnr(BottomNav,14)
Strk(BottomNav,T.BORDER,1,0.35)
LP(BottomNav,8,8,8,8)
LL(BottomNav,7,Enum.FillDirection.Horizontal)

-- Keep the existing tab names/indices so all existing feature code continues to target the same panels.
local TABS={
    {n="Home",    i="⌂"},
    {n="Combat",  i="⚔"},
    {n="RP Color",i="◈"},
    {n="Movement",i="➤"},
    {n="Targets", i="◎"},
    {n="Ghost",   i="◌"},
    {n="Glitch",  i="ϟ"},
    {n="CIRCLES", i="◉"},
    {n="Settings",i="☼"},
    {n="config", i="▣"},
    {n="auto combat",i="✦"},
    {n="advanced", i="⚙"},
    {n="cbt utils",i="◇"},
    {n="X ray",i="X"},
    {n="PLAYERS INFO",i="♙"},
    {n="FPS BOOST",i="ϟ"},
    {n="INFINITE YIELD",i="∞"},
}

local tabBtns={}; local tabPanels={}; local activeTab=nil; local transiting=false

for i,t in ipairs(TABS) do
    local btn=Instance.new("TextButton",BottomNav)
    btn.Size=UDim2.fromOffset(94,50)
    btn.BackgroundColor3=T.RAISED
    btn.BackgroundTransparency=1
    btn.Text=""
    btn.AutoButtonColor=false
    btn.BorderSizePixel=0
    btn.LayoutOrder=i
    btn.ZIndex=21
    Cnr(btn,10)

    local bar=Instance.new("Frame",btn)
    bar.Size=UDim2.new(1,-22,0,2)
    bar.Position=UDim2.new(0,11,1,-4)
    bar.BackgroundColor3=T.ACCENT
    bar.BackgroundTransparency=1
    bar.BorderSizePixel=0
    bar.ZIndex=22
    Cnr(bar,2)

    local ic=Instance.new("TextLabel",btn)
    ic.Size=UDim2.new(1,0,0,22)
    ic.Position=UDim2.new(0,0,0,4)
    ic.BackgroundTransparency=1
    ic.Text=t.i
    ic.TextSize=17
    ic.TextColor3=T.MUTED
    ic.FontFace=Bold
    ic.TextXAlignment=Enum.TextXAlignment.Center
    ic.ZIndex=22

    local nl=Instance.new("TextLabel",btn)
    nl.Size=UDim2.new(1,-8,0,18)
    nl.Position=UDim2.new(0,4,0,27)
    nl.BackgroundTransparency=1
    nl.Text=t.n:upper()
    nl.TextSize=7
    nl.TextColor3=T.MUTED
    nl.FontFace=Bold
    nl.TextXAlignment=Enum.TextXAlignment.Center
    nl.TextTruncate=Enum.TextTruncate.AtEnd
    nl.ZIndex=22

    local panel=Instance.new("ScrollingFrame",Content)
    panel.Size=UDim2.fromScale(1,1)
    panel.Position=UDim2.new(1,0,0,0)
    panel.BackgroundTransparency=1
    panel.BorderSizePixel=0
    panel.ScrollBarThickness=4
    panel.ScrollBarImageColor3=T.DIM
    panel.AutomaticCanvasSize=Enum.AutomaticSize.Y
    panel.CanvasSize=UDim2.new(0,0,0,0)
    panel.ClipsDescendants=true
    panel.Visible=false
    panel.ZIndex=16
    LP(panel,16,16,14,26)
    LL(panel,8)

    btn.MouseEnter:Connect(function()
        if activeTab~=i then Tw(btn,{BackgroundTransparency=0.35},0.12) end
    end)
    btn.MouseLeave:Connect(function()
        if activeTab~=i then Tw(btn,{BackgroundTransparency=1},0.12) end
    end)

    tabBtns[i]={btn=btn,bar=bar,ic=ic,nl=nl}
    tabPanels[i]=panel
end

local function GoTab(idx)
    if activeTab==idx or transiting then return end
    transiting=true
    local prev=activeTab
    activeTab=idx

    for i,tb in ipairs(tabBtns) do
        local a=(i==idx)
        Tw(tb.btn,{BackgroundTransparency=a and 0 or 1,BackgroundColor3=a and T.RAISED or T.RAISED},0.16)
        Tw(tb.nl,{TextColor3=a and T.TEXT or T.MUTED},0.16)
        Tw(tb.ic,{TextColor3=a and T.ACCENT or T.MUTED},0.16)
        Tw(tb.bar,{BackgroundTransparency=a and 0 or 1},0.2)
    end

    local dir=(prev and idx>prev) and 1 or -1
    local np=tabPanels[idx]
    local op=prev and tabPanels[prev]
    np.Position=UDim2.new(dir,0,0,0)
    np.Visible=true

    local ti=TweenInfo.new(0.24,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    if op then TweenSvc:Create(op,ti,{Position=UDim2.new(-dir,0,0,0)}):Play() end
    local t2=TweenSvc:Create(np,ti,{Position=UDim2.new(0,0,0,0)})
    t2:Play()
    t2.Completed:Connect(function()
        if op then op.Visible=false; op.Position=UDim2.new(1,0,0,0) end
        transiting=false
    end)
end

for i in ipairs(tabBtns) do
    local idx=i
    tabBtns[i].btn.MouseButton1Click:Connect(function() GoTab(idx) end)
end


-- ════════════════════════════════════════════════════════════
-- FPS BOOST
-- ════════════════════════════════════════════════════════════
do
    local FPS_TAB = #TABS
    local FPSPanel = tabPanels[FPS_TAB]

    MkSep(FPSPanel,"FPS BOOST",1)

    local info=MkCard(FPSPanel,68,2)
    MkLabel(info,{
        text="LIGHTWEIGHT CLIENT OPTIMIZATION",
        size=10,color=T.TEXT,font=Bold,
        sz=UDim2.new(1,-32,0,16),pos=UDim2.new(0,16,0,10),z=14
    })
    MkLabel(info,{
        text="Cuts local rendering effects for a small FPS boost.",
        size=8,color=T.MUTED,font=Reg,
        sz=UDim2.new(1,-32,0,28),pos=UDim2.new(0,16,0,32),z=14
    })

    local fpsState=false
    local savedGfx={
        quality=nil,
        globalShadows=nil,
        fogEnd=nil,
        effects={},
        particles={},
        trails={},
        beams={},
        highlights={},
        oldInstances={}
    }

    local function saveGraphics()
        if savedGfx.quality==nil then
            pcall(function()
                savedGfx.quality=settings().Rendering.QualityLevel
            end)
        end

        local lighting=game:GetService("Lighting")
        if savedGfx.globalShadows==nil then
            savedGfx.globalShadows=lighting.GlobalShadows
        end
        if savedGfx.fogEnd==nil then
            savedGfx.fogEnd=lighting.FogEnd
        end

        if next(savedGfx.effects)==nil then
            for _,v in ipairs(lighting:GetDescendants()) do
                if v:IsA("PostEffect") then
                    savedGfx.effects[v]={enabled=v.Enabled}
                end
            end
        end

        -- Save lightweight visual objects so OFF can restore them.
        if next(savedGfx.particles)==nil then
            for _,v in ipairs(game:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    savedGfx.particles[v]={enabled=v.Enabled,rate=v.Rate}
                elseif v:IsA("Trail") then
                    savedGfx.trails[v]={enabled=v.Enabled}
                elseif v:IsA("Beam") then
                    savedGfx.beams[v]={enabled=v.Enabled}
                elseif v:IsA("Highlight") then
                    savedGfx.highlights[v]={enabled=v.Enabled}
                end
            end
        end
    end

    local function setFPSBoost(on)
        if fpsState==on then return end
        fpsState=on

        if on then
            saveGraphics()

            -- Level 04 is a moderate reduction rather than an extreme potato mode.
            pcall(function()
                settings().Rendering.QualityLevel=Enum.QualityLevel.Level04
            end)

            pcall(function()
                local lighting=game:GetService("Lighting")
                lighting.GlobalShadows=false
                lighting.FogEnd=1000000

                for _,v in ipairs(lighting:GetDescendants()) do
                    if v:IsA("PostEffect") then
                        v.Enabled=false
                    end
                end
            end)

            pcall(function()
                for obj,state in pairs(savedGfx.particles) do
                    if obj and obj.Parent then
                        obj.Enabled=false
                        obj.Rate=0
                    end
                end
                for obj,state in pairs(savedGfx.trails) do
                    if obj and obj.Parent then obj.Enabled=false end
                end
                for obj,state in pairs(savedGfx.beams) do
                    if obj and obj.Parent then obj.Enabled=false end
                end
                for obj,state in pairs(savedGfx.highlights) do
                    if obj and obj.Parent then obj.Enabled=false end
                end
            end)

            Notif("FPS BOOST","Boost enabled","ok")
        else
            pcall(function()
                if savedGfx.quality then
                    settings().Rendering.QualityLevel=savedGfx.quality
                end
            end)

            pcall(function()
                local lighting=game:GetService("Lighting")
                if savedGfx.globalShadows~=nil then
                    lighting.GlobalShadows=savedGfx.globalShadows
                end
                if savedGfx.fogEnd~=nil then
                    lighting.FogEnd=savedGfx.fogEnd
                end

                for obj,state in pairs(savedGfx.effects) do
                    if obj and obj.Parent then
                        obj.Enabled=state.enabled
                    end
                end
            end)

            pcall(function()
                for obj,state in pairs(savedGfx.particles) do
                    if obj and obj.Parent then
                        obj.Enabled=state.enabled
                        obj.Rate=state.rate
                    end
                end
                for obj,state in pairs(savedGfx.trails) do
                    if obj and obj.Parent then obj.Enabled=state.enabled end
                end
                for obj,state in pairs(savedGfx.beams) do
                    if obj and obj.Parent then obj.Enabled=state.enabled end
                end
                for obj,state in pairs(savedGfx.highlights) do
                    if obj and obj.Parent then obj.Enabled=state.enabled end
                end
            end)

            Notif("FPS BOOST","Boost disabled","ok")
        end
    end

    local onCard=MkCard(FPSPanel,52,3)
    local onBtn=MkBtn(onCard,{
        bg=T.RAISED,text="⚡  FPS BOOST ON",size=9,color=T.TEXT,
        sz=UDim2.new(1,-28,0,26),pos=UDim2.new(0,14,0,8),corner=6,bgt=0.1,z=15
    })
    onBtn.MouseButton1Click:Connect(function()
        setFPSBoost(true)
    end)

    local offCard=MkCard(FPSPanel,52,4)
    local offBtn=MkBtn(offCard,{
        bg=T.RAISED,text="↩  FPS BOOST OFF",size=9,color=T.TEXT,
        sz=UDim2.new(1,-28,0,26),pos=UDim2.new(0,14,0,8),corner=6,bgt=0.1,z=15
    })
    offBtn.MouseButton1Click:Connect(function()
        setFPSBoost(false)
    end)
end

-- ════════════════════════════════════════════════════════════
-- TOGGLE BUTTON
-- ════════════════════════════════════════════════════════════
local TBtn=Instance.new("TextButton",GUI)
TBtn.Name="Unknown_Toggle"; TBtn.Size=UDim2.fromOffset(52,52)
TBtn.BackgroundColor3=T.CARD; TBtn.BackgroundTransparency=0.02
TBtn.Text="U"; TBtn.FontFace=Bold; TBtn.TextSize=20; TBtn.TextColor3=T.ACCENT
TBtn.AutoButtonColor=false; TBtn.BorderSizePixel=0; TBtn.ZIndex=200
Cnr(TBtn,12); Strk(TBtn,T.ACCENT,1.8,0.1)

task.defer(function() local gs=GUI.AbsoluteSize; TBtn.Position=UDim2.fromOffset(gs.X-64,12) end)

local toggleHue=0
TC(RunSvc.RenderStepped:Connect(function(dt)
    toggleHue=(toggleHue+dt*0.4)%1
    if toggleHue < 0.5 then
        TBtn.TextColor3=T.ACCENT
    else
        TBtn.TextColor3=Color3.fromRGB(96,165,250)
    end
end))

local _toggleKey=Enum.KeyCode.Insert
do
    local saved=SAVE.toggleKey
    if saved then local ok,kc=pcall(function() return Enum.KeyCode[saved] end); if ok and kc then _toggleKey=kc end end
end

local function toggleUI()
    Win.Visible=not Win.Visible
    if Win.Visible and not activeTab then GoTab(1) end
end

do
    local dragging,dragStart,startPos=false,nil,nil
    TBtn.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=i.Position; startPos=TBtn.Position
        end
    end)
    TBtn.InputEnded:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then
            dragging=false
            if (i.Position-dragStart).Magnitude<8 then toggleUI() end
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-dragStart
            TBtn.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
end

TC(UIS.InputBegan:Connect(function(i,gp)
    if not gp and i.UserInputType==Enum.UserInputType.Keyboard and i.KeyCode==_toggleKey then toggleUI() end
end))

-- ════════════════════════════════════════════════════════════
-- SHARED UTILITIES
-- ════════════════════════════════════════════════════════════
local function cleanRag(char)
    if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    pcall(function()
        for _,st in ipairs({Enum.HumanoidStateType.Ragdoll,Enum.HumanoidStateType.Physics,Enum.HumanoidStateType.FallingDown,Enum.HumanoidStateType.PlatformStanding}) do
            hum:SetStateEnabled(st,false)
        end
        hum.PlatformStand=false
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end)
    for _,o in ipairs(char:GetDescendants()) do
        if o:IsA("Motor6D") then o.Enabled=true
        elseif (o:IsA("BaseConstraint") or o:IsA("Attachment")) and o.Name:lower():find("ragdoll") then
            pcall(function() o:Destroy() end)
        end
    end
end

local function findArena()
    local s=workspace:FindFirstChild("Stuff")
    if s then local fa=s:FindFirstChild("Fight Arena"); if fa then return fa:FindFirstChild("CombatArena") end end
    return workspace:FindFirstChild("CombatArena",true)
end

-- ═══════════════════════════════════════
-- INFINITE YIELD
-- ════════════════════════════════════════════════════════════
do
    local IY_TAB
    for i,t in ipairs(TABS) do
        if t.n == "INFINITE YIELD" then
            IY_TAB = i
            break
        end
    end
    local P = IY_TAB and tabPanels[IY_TAB]
    if P then
        MkSep(P,"INFINITE YIELD",1)

        local info = MkCard(P,88,2)
        MkLabel(info,{
            text="INFINITE YIELD COMMANDS",
            size=11,color=T.TEXT,font=Bold,
            sz=UDim2.new(1,-32,0,20),pos=UDim2.new(0,16,0,12),z=14
        })
        MkLabel(info,{
            text="Load Infinite Yield into the current client.",
            size=8,color=T.MUTED,font=Reg,
            sz=UDim2.new(1,-32,0,18),pos=UDim2.new(0,16,0,38),z=14
        })

        local loadBtn = MkBtn(P,{
            bg=T.ACCENT,text="LOAD INFINITE YIELD",size=9,color=Color3.new(1,1,1),
            sz=UDim2.new(1,-32,0,42),pos=UDim2.new(0,16,0,112),
            corner=8,bgt=0,z=16
        })

        loadBtn.MouseButton1Click:Connect(function()
            local ok,err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end)
            if ok then
                Notif("Infinite Yield","Loaded","ok")
            else
                Notif("Infinite Yield","Failed to load: "..tostring(err),"warn")
            end
        end)
    end
end

-- TAB 1: HOME
-- ═══════════════════════════════════════
do
    local P=tabPanels[1]
    local wc=MkCard(P,76,1)
    MkLabel(wc,{text="Welcome back",size=9,color=T.MUTED,font=Reg,sz=UDim2.new(1,-32,0,14),pos=UDim2.new(0,16,0,10),z=14})
    local wnL=MkLabel(wc,{text=lp.DisplayName,size=22,color=T.ACCENT,font=Bold,sz=UDim2.new(1,-32,0,30),pos=UDim2.new(0,16,0,26),z=14})
    MkLabel(wc,{text="@"..lp.Name.." · ID: "..lp.UserId,size=8,color=T.DIM,font=Reg,sz=UDim2.new(1,-32,0,12),pos=UDim2.new(0,16,0,58),z=14})
    
    local sc=MkCard(P,42,2)
    MkLabel(sc,{text=#Players:GetPlayers().." / "..Players.MaxPlayers.." players  ·  Place ID: "..game.PlaceId,size=10,color=T.MUTED,font=Reg,sz=UDim2.new(1,-32,0,18),pos=UDim2.new(0,16,0,12),z=14})
    
    local ulCard=MkCard(P,48,3)
    MkLabel(ulCard,{text="UNLOAD ENGINE",size=8,color=T.DIM,font=Bold,sz=UDim2.new(1,-32,0,12),pos=UDim2.new(0,16,0,8),z=14})
    local ulBtn=MkBtn(ulCard,{bg=T.ERR,text="UNLOAD UNKNOWN",size=10,color=T.TEXT,sz=UDim2.new(1,-32,0,26),pos=UDim2.new(0,16,0,20),corner=7,bgt=0.1,z=15})
    local ulC=false
    ulBtn.MouseButton1Click:Connect(function()
        if not ulC then
            ulC=true; ulBtn.Text="CLICK AGAIN TO CONFIRM"
            task.delay(3,function() ulC=false; ulBtn.Text="UNLOAD UNKNOWN" end)
        else
            for _,c in ipairs(CONNS) do pcall(function() c:Disconnect() end) end
            DoSave(); Notif("Unload","Goodbye!","warn")
            task.delay(0.5,function() pcall(function() GUI:Destroy() end) end)
        end
    end)
end

-- ═══════════════════════════════════════
-- TAB 2: COMBAT
-- ═══════════════════════════════════════
do
    local P=tabPanels[2]

    local kaOn=false
    local kaAPS=SAVE.kaAPS
    local kaCD=1/kaAPS
    local kaRange=SAVE.kaRange
    local kaSimul=false
    local kaPredict=SAVE.kaPredict or true
    local kaHeadOn=false
    local kaAFling=false
    local safeSpotOn=false

    local kaLast=0
    local kaTStr=SAVE.kaTargets or ""
    local kaFStr=SAVE.kaFriends or ""
    local kaHStr=SAVE.headSit or ""

    local kaTgts={}
    local kaFrns={}
    local kaHds={}
    local kaManualTgt={}
    local kaManualFrn={}

    local originalCFrame=nil
    local safeLockConn=nil

    local function ParseN(s)
        local t={}
        if s=="" then return t end
        for nm in s:gsub(",", " "):gmatch("%S+") do
            local n=nm:lower():match("^%s*(.-)%s*$")
            if n and n~="" then t[#t+1]=n end
        end
        return t
    end

    local function RefAll()
        kaTgts=ParseN(kaTStr); kaFrns=ParseN(kaFStr); kaHds=ParseN(kaHStr)
        SAVE.kaTargets=kaTStr; SAVE.kaFriends=kaFStr; SAVE.headSit=kaHStr; task.delay(.5,DoSave)
    end
    RefAll()

    local function matchesAny(arr, name, displayName)
        local nl, dn = name:lower(), displayName:lower()
        for _, k in ipairs(arr) do
            if nl==k or dn==k then return true end
            if nl:find(k, 1, true) or dn:find(k, 1, true) then return true end
        end
        return false
    end

    local function IsFriend(p)
        if kaManualFrn[p] then return true end
        if #kaFrns==0 then return false end
        return matchesAny(kaFrns, p.Name, p.DisplayName)
    end

    local function IsTarget(p)
        if p==lp then return false end
        if IsFriend(p) then return false end
        if kaManualTgt[p] then return true end
        if #kaTgts==0 then return true end
        return matchesAny(kaTgts, p.Name, p.DisplayName)
    end

    local function IsHeadSitTarget(p)
        if p==lp then return false end
        if #kaHds==0 then return false end
        return matchesAny(kaHds, p.Name, p.DisplayName)
    end

    local function goToSafeSpot()
        local myC=lp.Character; local myH=myC and myC:FindFirstChild("HumanoidRootPart")
        if not myH then return end

        originalCFrame=myH.CFrame
        SAVE.safeX=SAFE_CF.Position.X
        SAVE.safeY=SAFE_CF.Position.Y
        SAVE.safeZ=SAFE_CF.Position.Z
        
        myH.CFrame=SAFE_CF
        myH.AssemblyLinearVelocity=Vector3.zero
        myH.AssemblyAngularVelocity=Vector3.zero
        myH.CanCollide=false
        pcall(function() local h=myC:FindFirstChildOfClass("Humanoid"); if h then h.PlatformStand=true end end)
        
        if safeLockConn then safeLockConn:Disconnect() end
        safeLockConn=TC(RunSvc.Heartbeat:Connect(function()
            if not safeSpotOn then return end
            local c=lp.Character; local h=c and c:FindFirstChild("HumanoidRootPart")
            if h then h.CFrame=SAFE_CF; h.AssemblyLinearVelocity=Vector3.zero end
        end))
    end

    local function disableSafeSpot()
        if safeLockConn then safeLockConn:Disconnect(); safeLockConn=nil end
        
        local myC=lp.Character; local myH=myC and myC:FindFirstChild("HumanoidRootPart")
        if myH then
            pcall(function()
                local hum=myC:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.PlatformStand=false
                    hum.Sit=false
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end)
            
            myH.CanCollide=true
            myH.AssemblyLinearVelocity=Vector3.zero
            
            if originalCFrame then
                myH.CFrame=originalCFrame
                originalCFrame=nil
            end
        end
    end

    local afConn
    local function StartAF()
        if afConn then afConn:Disconnect() end
        afConn=TC(RunSvc.Heartbeat:Connect(function()
            local c=lp.Character; if not c then return end
            local hrp=c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            if hrp.AssemblyLinearVelocity.Magnitude>150 then hrp.AssemblyLinearVelocity=hrp.AssemblyLinearVelocity*0.75 end
            if hrp.AssemblyAngularVelocity.Magnitude>20 then hrp.AssemblyAngularVelocity=Vector3.zero end
        end))
    end
    local function StopAF() if afConn then afConn:Disconnect(); afConn=nil end end

    local function HitRemoteInvoke(hum, px, py, pz)
        spawn(function()
            pcall(function()
                if RF.Hit then RF.Hit:InvokeServer(unpack({hum, vector.create(px, py, pz)})) end
            end)
        end)
    end

    local kaConn
    local lastTargets = {}
    local targetCache = {}
    local cacheTime = 0
    
        local function StartKA()
            if kaConn then kaConn:Disconnect() end
            
            kaConn = TC(RunSvc.Heartbeat:Connect(function()
                if not kaOn then return end
                
                local mc = lp.Character
                local myHRP = mc and mc:FindFirstChild("HumanoidRootPart")
                if not myHRP then return end
                
                local now = clock()
                if now - kaLast < kaCD then return end
                
                local px, py, pz = myHRP.Position.X, myHRP.Position.Y, myHRP.Position.Z

                if kaHeadOn then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if IsHeadSitTarget(p) and p.Character then
                            local head = p.Character:FindFirstChild("Head")
                            if head and (head.Position - myHRP.Position).Magnitude <= kaRange then
                                myHRP.CFrame = CFrame.new(head.Position + Vector3.new(0, 3.5, 0))
                            end
                        end
                    end
                end
                
                local targets = {}
                local hitAny = false
                
                if now - cacheTime > 0.1 then
                    targetCache = {}
                    for _, p in ipairs(Players:GetPlayers()) do
                        if not IsTarget(p) then continue end
                        local c = p.Character
                        if not c then continue end
                        
                        local hu = c:FindFirstChild("Humanoid")
                        local hrp = c:FindFirstChild("HumanoidRootPart")
                        
                        if hu and hrp and hu.Health > 0 then
                            targetCache[p] = {hu, hrp}
                        end
                    end
                    cacheTime = now
                end
                
                if kaSimul then
                    for p, data in pairs(targetCache) do
                        local hu, hrp = data[1], data[2]
                        if (hrp.Position - myHRP.Position).Magnitude <= kaRange then
                            insert(targets, data)
                            hitAny = true
                        end
                    end
                else
                    local cls, mind = nil, math.huge
                    for p, data in pairs(targetCache) do
                        local hu, hrp = data[1], data[2]
                        local d = (hrp.Position - myHRP.Position).Magnitude
                        if d <= kaRange and d < mind then
                            mind = d
                            cls = data
                        end
                    end
                    if cls then
                        insert(targets, cls)
                        hitAny = true
                    end
                end
                
                if hitAny then
                    spawn(function()
                        for _, tData in ipairs(targets) do
                            local hu, hrp = tData[1], tData[2]
                            
                            if kaPredict and hrp then
                                local vel = hrp.AssemblyLinearVelocity
                                local predictPos = hrp.Position + vel * (kaCD * 0.5)
                                HitRemoteInvoke(hu, predictPos.X, predictPos.Y, predictPos.Z)
                            else
                                HitRemoteInvoke(hu, px, py, pz)
                            end
                        end
                    end)
                    kaLast = now
                end
            end))
        end
    
    local function StopKA()
        if kaConn then
            kaConn:Disconnect()
            kaConn = nil
        end
        targetCache = {}
    end

    MkSep(P,"Kill Aura",1)

    local _,_,kSet = MkToggle(P, "KILL AURA", 2,
        function()
            kaOn = true
            StartKA()
            Notif("Kill Aura","Active","ok")
        end,
        function()
            kaOn = false
            StopKA()
            Notif("Kill Aura","Off","")
        end
    )

    -- Public wrapper used by the CLAUDE radial circle.
    _G.CLX_SetKillAura = function(state)
        state = state == true
        kaOn = state
        kSet(state)
        if state then
            StartKA()
            Notif("Kill Aura","Active (Circle)","ok")
        else
            StopKA()
            Notif("Kill Aura","Off (Circle)","")
        end
    end

    RegKB("Kill Aura",Enum.KeyCode.K,function()
        kaOn = not kaOn
        _G.CLX_KillAuraOn = kaOn
        kSet(kaOn)
        if kaOn then StartKA(); Notif("Kill Aura","Active","ok") else StopKA(); Notif("Kill Aura","Off","") end
    end)

    _G.CLX_KillAuraOn = kaOn

    MkToggle(P,"SIMULTANEOUS HITS",4,function() kaSimul=true; Notif("Kill Aura","Simultaneous: ON","ok") end,function() kaSimul=false; Notif("Kill Aura","Simultaneous: OFF","") end)
    
    MkToggle(P,"VELOCITY PREDICTION",5,
        function()
            kaPredict=true
            SAVE.kaPredict=true
            DoSave()
            Notif("Kill Aura","Prediction: ON","ok")
        end,
        function()
            kaPredict=false
            SAVE.kaPredict=false
            DoSave()
            Notif("Kill Aura","Prediction: OFF","")
        end
    )
    
    MkToggle(P,"ANTI-FLING",6,function() kaAFling=true; StartAF(); Notif("Anti-Fling","Active","ok") end,function() kaAFling=false; StopAF(); Notif("Anti-Fling","Off","") end)
    
    local _,_,ssSet=MkToggle(P,"SAFE SPOT",7,
        function() safeSpotOn=true; goToSafeSpot(); Notif("Safe Spot","Locked","ok") end,
        function() safeSpotOn=false; disableSafeSpot(); Notif("Safe Spot","Unlocked","") end
    )
    RegKB("Safe Spot",Enum.KeyCode.V,function()
        safeSpotOn=not safeSpotOn; ssSet(safeSpotOn)
        if safeSpotOn then goToSafeSpot(); Notif("Safe Spot","Locked","ok") else disableSafeSpot(); Notif("Safe Spot","Unlocked","") end
    end)

    MkSlider(P,"ATTACKS PER SECOND",100,50000,SAVE.kaAPS,8,function(v) kaAPS=v; kaCD=1/v; SAVE.kaAPS=v; task.delay(.5,DoSave) end)
    MkSlider(P,"RANGE",5,500,SAVE.kaRange,9,function(v) kaRange=v; SAVE.kaRange=v; task.delay(.5,DoSave) end)
    
    local hbOn=false; local hbConn
    MkSlider(P,"HITBOX EXPANDER",0,25,0,10,function(v)
        for _, p in Players:GetPlayers() do
            if p==lp then continue end
            local c=p.Character; if not c then continue end
            local hrp=c:FindFirstChild("HumanoidRootPart")
            if hrp then pcall(function() local s=v<1 and 2 or v; hrp.Size=Vector3.new(s,s,s) end) end
        end
    end)
    
    MkToggle(P,"HITBOX COLLISION OFF",11,function()
        local function setNC(p) if p==lp then return end; local c=p.Character; if not c then return end; local hrp=c:FindFirstChild("HumanoidRootPart"); if hrp then pcall(function() hrp.CanCollide=false end) end end
        for _, p in Players:GetPlayers() do setNC(p) end
        hbConn=TC(Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() task.wait(0.5); setNC(p) end) end))
        Notif("Hitbox","Collision Off","ok")
    end,function()
        if hbConn then hbConn:Disconnect(); hbConn=nil end
        for _, p in Players:GetPlayers() do if p==lp then continue end; local c=p.Character; if not c then continue end; local hrp=c:FindFirstChild("HumanoidRootPart"); if hrp then pcall(function() hrp.CanCollide=true end) end end
        Notif("Hitbox","Collision On","")
    end)

    local _,tgBox=MkTBoxCard(P,"TARGETS (saved)","player1 player2 ...",12)
    tgBox.Text=kaTStr
    tgBox.FocusLost:Connect(function() kaTStr=tgBox.Text; RefAll() end)

    local _,frBox=MkTBoxCard(P,"FRIENDS / AVOID (saved)","friend1 friend2 ...",13)
    frBox.Text=kaFStr
    frBox.FocusLost:Connect(function() kaFStr=frBox.Text; RefAll() end)

    MkToggle(P,"HEAD SIT",14,function() kaHeadOn=true; Notif("Kill Aura","Head Sit: ON","ok") end,function() kaHeadOn=false; Notif("Kill Aura","Head Sit: OFF","") end)
    local _,hsBox=MkTBoxCard(P,"HEAD SIT TARGETS (saved)","player1 player2 ...",15)
    hsBox.Text=kaHStr
    hsBox.FocusLost:Connect(function() kaHStr=hsBox.Text; RefAll() end)

    MkSep(P,"TP Hit",30)
    do
        local _,thBox=MkTBoxCard(P,"TP HIT TARGET (blank=nearest)","player name ...",31,SAVE.tpHitTarget)
        tpHitTargetBox=thBox
        thBox.FocusLost:Connect(function() SAVE.tpHitTarget=thBox.Text; task.delay(.5,DoSave) end)
    end
    local function startTPHit()
        if tpHitConn then tpHitConn:Disconnect() end
        local last=0; local interval=1/math.max(kaAPS,1)
        tpHitConn=TC(RunSvc.RenderStepped:Connect(function()
            if not tpHitOn then return end
            local now=tick(); if now-last < interval then return end; last=now
            local mc=lp.Character; if not mc then return end
            local mHRP=mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            local tgtName=tpHitTargetBox and tpHitTargetBox.Text or ""
            local tgt
            if tgtName~="" then tgt=findPlayer(tgtName)
            else
                local best,bestD=nil,math.huge
                for _,p in Players:GetPlayers() do
                    if not IsTarget(p) then continue end
                    local c=p.Character; if not c then continue end
                    local hrp=c:FindFirstChild("HumanoidRootPart"); local hum=c:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health>0 then
                        local d=(hrp.Position-mHRP.Position).Magnitude
                        if d<tpHitRange and d<bestD then bestD=d; best=p end
                    end
                end
                tgt=best
            end
            if not tgt or not tgt.Character then return end
            local tHRP=tgt.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return end
            local tHum=tgt.Character:FindFirstChildOfClass("Humanoid"); if not tHum or tHum.Health<=0 then return end
            local origCF=mHRP.CFrame
            mHRP.CFrame=CFrame.new(tHRP.Position); mHRP.AssemblyLinearVelocity=Vector3.zero
            RunSvc.Heartbeat:Wait()
            pcall(function() if RF.PunchDo then RF.PunchDo:InvokeServer() end end)
            pcall(function() if RF.Hit then RF.Hit:InvokeServer(tHum,vector.create(tHRP.Position.X,tHRP.Position.Y,tHRP.Position.Z)) end end)
            task.wait(0.04)
            mHRP.CFrame=origCF
        end))
    end
    MkToggle(P,"TP HIT ",32,
        function() tpHitOn=true; startTPHit(); Notif("TP Hit","Active","ok") end,
        function() tpHitOn=false; if tpHitConn then tpHitConn:Disconnect();tpHitConn=nil end; Notif("TP Hit","Off","") end)
    RegKB("TP Hit",Enum.KeyCode.Y,function()
        tpHitOn=not tpHitOn
        if tpHitOn then startTPHit(); Notif("TP Hit","Active","ok") else if tpHitConn then tpHitConn:Disconnect();tpHitConn=nil end; Notif("TP Hit","Off","") end
    end)
    MkSlider(P,"TP HIT RANGE",5,100,SAVE.tpHitRange,33,function(v) tpHitRange=v; SAVE.tpHitRange=v; task.delay(.5,DoSave) end)

    MkSep(P,"Hitbox",34)
    local _hbF=0
    TC(RunSvc.RenderStepped:Connect(function()
        if not hbOn then return end
        _hbF=_hbF+1; if _hbF%3~=0 then return end
        for _,p in Players:GetPlayers() do
            if p==lp or not p.Character then continue end
            pcall(function()
                local hrp=p.Character:FindFirstChild("HumanoidRootPart"); if not hrp then return end
                if IsTarget(p) then
                    hrp.Size=Vector3.new(hbSize,hbSize,hbSize); hrp.CanCollide=false
                    if hbVis then hrp.Transparency=0.65; hrp.Material=Enum.Material.Neon; hrp.BrickColor=BrickColor.new("White")
                    else hrp.Transparency=1; hrp.Material=Enum.Material.Plastic end
                else hrp.Size=Vector3.new(2,2,1); hrp.Transparency=1; hrp.CanCollide=false end
            end)
        end
    end))
    MkToggle(P,"HITBOX EXPANDER",35,function() hbOn=true; Notif("Hitbox","Active","ok") end,function() hbOn=false; Notif("Hitbox","Off","") end)
    MkToggle(P,"HITBOX VISIBLE",36,function() hbVis=true end,function() hbVis=false end)
    MkSlider(P,"HITBOX SIZE",1,50,SAVE.hbSize,37,function(v) hbSize=v; SAVE.hbSize=v; task.delay(.5,DoSave) end)

    MkSep(P,"Grab",38)
    local function fireGrab() pcall(function() if RF.Grab then RF.Grab:InvokeServer() end end) end
    RegKB("Manual Grab",Enum.KeyCode.G,function() fireGrab() end)

    do
        local _,agBox2=MkTBoxCard(P,"AUTO GRAB TARGET (required)","player name ...",40,SAVE.agTarget)
        agTargetBox=agBox2
        agBox2.FocusLost:Connect(function() SAVE.agTarget=agBox2.Text; task.delay(.5,DoSave) end)
    end
    local function startAG()
        if agConn then agConn:Disconnect() end
        local t=0
        agConn=TC(RunSvc.Heartbeat:Connect(function(dt)
            if not agOn then return end
            t=t+dt; if t<0.1 then return end; t=0
            local mc=lp.Character; if not mc then return end
            local mHRP=mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            local tgtName=agTargetBox and agTargetBox.Text or ""
            if tgtName=="" then return end
            local tgt=findPlayer(tgtName); if not tgt or not tgt.Character then return end
            local tHRP=tgt.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return end
            local tHum=tgt.Character:FindFirstChildOfClass("Humanoid"); if not tHum or tHum.Health<=0 then return end
            local origCF=mHRP.CFrame
            mHRP.CFrame=tHRP.CFrame
            mHRP.AssemblyLinearVelocity=Vector3.zero
            RunSvc.Heartbeat:Wait()
            RunSvc.Heartbeat:Wait()
            pcall(function() if RF.Grab then RF.Grab:InvokeServer() end end)
            task.wait(0.06)
            mHRP.CFrame=origCF
        end))
    end
    MkToggle(P,"AUTO GRAB",41,
        function() agOn=true; startAG(); Notif("Auto Grab","Active","ok") end,
        function() agOn=false; if agConn then agConn:Disconnect();agConn=nil end; Notif("Auto Grab","Off","") end)

    local function startGrabLoop()
        if grabLoopConn then grabLoopConn:Disconnect() end
        local t=0
        grabLoopConn=TC(RunSvc.Heartbeat:Connect(function(dt)
            if not grabLoopOn then return end
            t=t+dt; if t<0.08 then return end; t=0
            local mc=lp.Character; local mHRP=mc and mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            for _,p in Players:GetPlayers() do
                if not IsTarget(p) then continue end
                local c=p.Character; if not c then continue end
                local hrp=c:FindFirstChild("HumanoidRootPart"); local hum=c:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health>0 and (hrp.Position-mHRP.Position).Magnitude<=kaRange then
                    local orig=mHRP.CFrame
                    mHRP.CFrame=hrp.CFrame; mHRP.AssemblyLinearVelocity=Vector3.zero
                    RunSvc.Heartbeat:Wait(); RunSvc.Heartbeat:Wait()
                    pcall(function() if RF.Grab then RF.Grab:InvokeServer() end end)
                    task.wait(0.04); mHRP.CFrame=orig
                end
            end
        end))
    end
    MkToggle(P,"GRAB LOOP (all in range)",42,
        function() grabLoopOn=true; startGrabLoop(); Notif("Grab Loop","Active","ok") end,
        function() grabLoopOn=false; if grabLoopConn then grabLoopConn:Disconnect();grabLoopConn=nil end; Notif("Grab Loop","Off","") end)

    do
        local _,ggBox2=MkTBoxCard(P,"GRAB GLITCH TARGET","player name ...",43,SAVE.ggTarget)
        ggTargetBox=ggBox2
        ggBox2.FocusLost:Connect(function() SAVE.ggTarget=ggBox2.Text; task.delay(.5,DoSave) end)
        local ggBtnCard=MkCard(P,38,44)
        MkLabel(ggBtnCard,{text="GRAB GLITCH",size=9,color=T.TEXT,font=Semi,sz=UDim2.new(1,-88,0,18),pos=UDim2.new(0,14,0.5,-9),z=14})
        local ggBtn=MkBtn(ggBtnCard,{bg=T.RAISED,text="FIRE",size=8,color=T.TEXT,sz=UDim2.new(0,72,0,24),pos=UDim2.new(1,-86,0.5,-12),corner=6,bgt=0.1,z=15})
        local function doGG()
            local tgtName=ggTargetBox and ggTargetBox.Text or ""
            local tgt
            if tgtName~="" then tgt=findPlayer(tgtName)
            else
                if #TargetsList==0 then return end
                for _,s in ipairs(TargetsList) do
                    for _,p in Players:GetPlayers() do
                        if p~=lp and (p.Name:lower():find(s,1,true) or p.DisplayName:lower():find(s,1,true)) then
                            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then tgt=p; break end
                        end
                    end; if tgt then break end
                end
            end
            if not tgt then Notif("Grab Glitch","Target not found","err"); return end
            local mc=lp.Character; if not mc then return end
            local mHRP=mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            local tHRP=tgt.Character and tgt.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return end
            local origCF=mHRP.CFrame
            task.spawn(function()
                mHRP.CFrame=tHRP.CFrame; mHRP.AssemblyLinearVelocity=Vector3.zero
                RunSvc.Heartbeat:Wait(); RunSvc.Heartbeat:Wait()
                pcall(function() if RF.Grab then RF.Grab:InvokeServer() end end)
                task.wait(0.06); mHRP.CFrame=origCF
            end)
            Notif("Grab Glitch","→ "..tgt.DisplayName,"ok")
        end
        ggBtn.MouseButton1Click:Connect(doGG)
        RegKB("Grab Glitch",Enum.KeyCode.H,doGG)
    end

    MkSep(P,"Extra Combat",45)
    local function startRapid()
        if rapidConn then rapidConn:Disconnect() end
        local t=0
        rapidConn=TC(RunSvc.RenderStepped:Connect(function(dt)
            if not rapidOn then return end
            t=t+dt; if t<0.016 then return end; t=0
            local mc=lp.Character; local mHRP=mc and mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            for _,p in Players:GetPlayers() do
                if not IsTarget(p) then continue end
                local c=p.Character; if not c then continue end
                local hum=c:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health>0 then
                    pcall(function() if RF.Hit then RF.Hit:InvokeServer(hum,vector.create(mHRP.Position.X,mHRP.Position.Y,mHRP.Position.Z)) end end)
                end
            end
        end))
    end
    MkToggle(P,"RAPID HIT SPAM",46,
        function() rapidOn=true; startRapid(); Notif("Rapid Hit","Active","ok") end,
        function() rapidOn=false; if rapidConn then rapidConn:Disconnect();rapidConn=nil end; Notif("Rapid Hit","Off","") end)

    local function startPunch()
        if punchConn then punchConn:Disconnect() end
        local t=0
        punchConn=TC(RunSvc.RenderStepped:Connect(function(dt)
            if not punchOn then return end
            t=t+dt; if t<0.02 then return end; t=0
            pcall(function() if RF.PunchDo then RF.PunchDo:InvokeServer() end end)
        end))
    end
    MkToggle(P,"PUNCH SPAM",47,
        function() punchOn=true; startPunch(); Notif("Punch Spam","Active","ok") end,
        function() punchOn=false; if punchConn then punchConn:Disconnect();punchConn=nil end; Notif("Punch Spam","Off","") end)

    local function startSpamBlock()
        if spamBlockConn then spamBlockConn:Disconnect() end
        spamBlockConn=TC(RunSvc.RenderStepped:Connect(function()
            if not spamBlockOn then return end
            pcall(function() if RF.Block then RF.Block:InvokeServer(true) end end)
        end))
    end
    MkToggle(P,"SPAM BLOCK (ultra fast)",48,
        function() spamBlockOn=true; startSpamBlock(); Notif("Spam Block","Active","ok") end,
        function() spamBlockOn=false; if spamBlockConn then spamBlockConn:Disconnect();spamBlockConn=nil end; Notif("Spam Block","Off","") end)

    local function startAutoParry()
        if autoParryConn then autoParryConn:Disconnect() end
        autoParryConn=TC(RunSvc.Heartbeat:Connect(function()
            if not autoParryOn then return end
            local mc=lp.Character; if not mc then return end
            local mHRP=mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            for _,p in Players:GetPlayers() do
                if p==lp or not p.Character then continue end
                local c=p.Character
                local hrp=c:FindFirstChild("HumanoidRootPart"); if not hrp then continue end
                local d=(hrp.Position-mHRP.Position).Magnitude
                if d<12 then
                    pcall(function() if RF.Block then RF.Block:InvokeServer(true) end end)
                end
            end
        end))
    end
    MkToggle(P,"AUTO PARRY",49,
        function() autoParryOn=true; startAutoParry(); Notif("Auto Parry","Active","ok") end,
        function() autoParryOn=false; if autoParryConn then autoParryConn:Disconnect();autoParryConn=nil end; Notif("Auto Parry","Off","") end)

    MkSep(P,"Defensive",50)

    local function startSB()
        if sbConn then sbConn:Disconnect() end
        local t=0
        sbConn=TC(RunSvc.Heartbeat:Connect(function(dt)
            t=t+dt; if t<0.03 then return end; t=0
            pcall(function() if RF.Block then RF.Block:InvokeServer(true) end end)
        end))
    end
    MkToggle(P,"SILENT BLOCK",51,function() startSB(); Notif("Silent Block","Active","ok") end,function() if sbConn then sbConn:Disconnect();sbConn=nil end; Notif("Silent Block","Off","") end)

    local arOn=false; local arConn; local arCharConn
    local function startAR()
        arConn=TC(RunSvc.Heartbeat:Connect(function()
            local c=lp.Character; if c then cleanRag(c) end
        end))
        arCharConn=TC(lp.CharacterAdded:Connect(function(c) task.wait(.3); cleanRag(c) end))
        if lp.Character then cleanRag(lp.Character) end
    end
    MkToggle(P,"ANTI RAGDOLL",52,
        function() arOn=true; startAR(); Notif("Anti Ragdoll","Active","ok") end,
        function() arOn=false; if arConn then arConn:Disconnect();arConn=nil end; if arCharConn then arCharConn:Disconnect();arCharConn=nil end; Notif("Anti Ragdoll","Off","") end)

    local function _arc_removePlat()
        if _arc_platConn then _arc_platConn:Disconnect();_arc_platConn=nil end
        if _arc_platform then pcall(function() _arc_platform:Destroy() end);_arc_platform=nil end
    end
    local function _arc_spawnPlat(pos)
        _arc_removePlat()
        local part=Instance.new("Part"); part.Size=Vector3.new(12,1,12)
        part.CFrame=CFrame.new(pos.X,pos.Y-3.5,pos.Z); part.Anchored=true; part.CanCollide=true
        part.Material=Enum.Material.SmoothPlastic; part.Transparency=0.4; part.Locked=true; part.Parent=workspace
        _arc_platform=part; local topY=part.Position.Y+0.5
        _arc_platConn=TC(RunSvc.Heartbeat:Connect(function()
            if not _arc_platform or not _arc_platform.Parent then _arc_removePlat(); return end
            local c=lp.Character; local hrp=c and c:FindFirstChild("HumanoidRootPart")
            if hrp and hrp.Position.Y<topY then hrp.CFrame=CFrame.new(pos.X,topY+3.5,pos.Z); hrp.AssemblyLinearVelocity=Vector3.zero end
        end))
    end
    local function _arc_countDis(char)
        local tot,dis=0,0
        for _,o in ipairs(char:GetDescendants()) do if o:IsA("Motor6D") then tot=tot+1; if not o.Enabled then dis=dis+1 end end end
        return tot,dis
    end
    local function _arc_forceEnd(char)
        local hum=char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        for _,st in ipairs({Enum.HumanoidStateType.Ragdoll,Enum.HumanoidStateType.Physics,Enum.HumanoidStateType.FallingDown,Enum.HumanoidStateType.PlatformStanding}) do pcall(function() hum:SetStateEnabled(st,false) end) end
        hum.PlatformStand=false; pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
        for _,o in ipairs(char:GetDescendants()) do
            if o:IsA("Motor6D") then o.Enabled=true
            elseif (o:IsA("BaseConstraint") or o:IsA("Attachment")) and o.Name:lower():find("ragdoll") then o:Destroy() end
        end
    end
    local function _arc_doReturn(hrp,saved)
        local sp=_arc_safeCF.Position; _arc_spawnPlat(sp); hrp.CFrame=CFrame.new(sp); hrp.AssemblyLinearVelocity=Vector3.zero
        _arc_retTask=task.delay(arcGrabDelay,function()
            _arc_removePlat()
            if hrp and hrp.Parent and saved then hrp.CFrame=saved end
            task.delay(.05,function() if hrp and hrp.Parent then hrp.AssemblyLinearVelocity=Vector3.new(0,-1,0) end end)
            _arc_origCF=nil;_arc_retTask=nil;_arc_cleaned=false;_arc_inReturn=false;_arc_wasGrabbed=false
        end)
    end
    local function _arc_startChar(char)
        local hrp=char:WaitForChild("HumanoidRootPart",10); if not hrp then return end
        local hum=char:WaitForChild("Humanoid",10); if not hum then return end
        if _arc_conn then _arc_conn:Disconnect() end; if _arc_platStandConn then _arc_platStandConn:Disconnect() end
        _arc_origCF=nil;_arc_cleaned=false;_arc_inReturn=false;_arc_wasGrabbed=false
        if _arc_retTask then task.cancel(_arc_retTask);_arc_retTask=nil end
        task.wait(2.5); if not arcOn then return end
        _arc_platStandConn=TC(hum:GetPropertyChangedSignal("PlatformStand"):Connect(function()
            if not arcOn or _arc_inReturn then return end
            if hum.PlatformStand then _arc_wasGrabbed=true; if not _arc_origCF then _arc_origCF=hrp.CFrame end end
        end))
        _arc_conn=TC(RunSvc.Heartbeat:Connect(function()
            if not arcOn or not char.Parent then return end; if _arc_inReturn then return end
            local tot,dis=_arc_countDis(char); local isRag=tot>=12 and (dis/tot)>=0.9
            if isRag then
                if not _arc_origCF then _arc_origCF=hrp.CFrame end
                if _arc_wasGrabbed then
                    if not _arc_cleaned then _arc_forceEnd(char);_arc_cleaned=true end
                    if not _arc_retTask then _arc_inReturn=true;_arc_doReturn(hrp,_arc_origCF) end
                else hrp.CFrame=_arc_safeCF; if not _arc_cleaned then _arc_forceEnd(char);_arc_cleaned=true end end
            else
                if not _arc_wasGrabbed and _arc_origCF and not _arc_retTask then
                    _arc_inReturn=true; local saved=_arc_origCF
                    _arc_retTask=task.delay(arcDefDelay,function()
                        if hrp and hrp.Parent and saved then hrp.CFrame=saved end
                        task.delay(.05,function() if hrp and hrp.Parent then hrp.AssemblyLinearVelocity=Vector3.new(0,-1,0) end end)
                        _arc_origCF=nil;_arc_retTask=nil;_arc_cleaned=false;_arc_inReturn=false;_arc_wasGrabbed=false
                    end)
                end
                if not _arc_wasGrabbed then _arc_cleaned=false end
            end
        end))
    end
    local function startARC() _arc_charConn=TC(lp.CharacterAdded:Connect(function(c) task.spawn(_arc_startChar,c) end)); if lp.Character then task.spawn(_arc_startChar,lp.Character) end end
    local function stopARC()
        arcOn=false
        if _arc_conn then _arc_conn:Disconnect();_arc_conn=nil end; if _arc_platStandConn then _arc_platStandConn:Disconnect();_arc_platStandConn=nil end
        if _arc_charConn then _arc_charConn:Disconnect();_arc_charConn=nil end
        if _arc_retTask then task.cancel(_arc_retTask);_arc_retTask=nil end; _arc_removePlat()
    end
    MkToggle(P,"ANTI RAG COMBO (ARC)",53,
        function() arcOn=true; startARC(); Notif("ARC","Active","ok") end,
        function() stopARC(); Notif("ARC","Off","") end)
    MkSlider(P,"ARC DEFAULT DELAY",1,10,math.max(1,math.floor(SAVE.arcDefDelay*10+.5)),54,function(v) arcDefDelay=v/10; SAVE.arcDefDelay=arcDefDelay; task.delay(.5,DoSave) end)
    MkSlider(P,"ARC GRAB DELAY",0,2,math.max(0,SAVE.arcGrabDelay),55,function(v) arcGrabDelay=v; SAVE.arcGrabDelay=v; task.delay(.5,DoSave) end)

    local function startInvincible()
        if invConn then invConn:Disconnect() end
        local t=0
        invConn=TC(RunSvc.Heartbeat:Connect(function(dt)
            if not invOn then return end
            t=t+dt; if t<0.02 then return end; t=0
            pcall(function() if RF.Block then RF.Block:InvokeServer(true) end end)
            local c=lp.Character; if not c then return end
            local hum=c:FindFirstChildOfClass("Humanoid"); if not hum then return end
            if hum.PlatformStand then
                hum.PlatformStand=false
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
                local hrp=c:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.AssemblyLinearVelocity=Vector3.zero end
            end
            for _,st in ipairs({Enum.HumanoidStateType.Ragdoll,Enum.HumanoidStateType.Physics,Enum.HumanoidStateType.FallingDown,Enum.HumanoidStateType.PlatformStanding}) do
                pcall(function() hum:SetStateEnabled(st,false) end)
            end
            for _,o in ipairs(c:GetDescendants()) do
                if o:IsA("Motor6D") then o.Enabled=true
                elseif (o:IsA("BaseConstraint") or o:IsA("Attachment")) and o.Name:lower():find("ragdoll") then
                    pcall(function() o:Destroy() end)
                end
            end
        end))
    end
    MkToggle(P,"INVINCIBLE",56,
        function() invOn=true; startInvincible(); Notif("Invincible","Active","ok") end,
        function() invOn=false; if invConn then invConn:Disconnect();invConn=nil end; Notif("Invincible","Off","") end)
    RegKB("Invincible",Enum.KeyCode.I,function()
        invOn=not invOn
        if invOn then startInvincible(); Notif("Invincible","Active","ok") else if invConn then invConn:Disconnect();invConn=nil end; Notif("Invincible","Off","") end
    end)

    local function startDodge()
        if dodgeConn then dodgeConn:Disconnect() end
        local lastDodge=0
        dodgeConn=TC(RunSvc.Heartbeat:Connect(function()
            if not dodgeOn then return end
            local c=lp.Character; if not c then return end
            local hum=c:FindFirstChildOfClass("Humanoid"); if not hum then return end
            local hrp=c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            if hum.PlatformStand and tick()-lastDodge>0.5 then
                lastDodge=tick()
                hrp.CFrame=SAFE_CF; hrp.AssemblyLinearVelocity=Vector3.zero
                hum.PlatformStand=false
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
                for _,o in ipairs(c:GetDescendants()) do
                    if o:IsA("Motor6D") then o.Enabled=true
                    elseif (o:IsA("BaseConstraint") or o:IsA("Attachment")) and o.Name:lower():find("ragdoll") then
                        pcall(function() o:Destroy() end)
                    end
                end
                Notif("Dodge","Grab dodged","ok")
            end
        end))
    end
    MkToggle(P,"DODGE GRABS",57,
        function() dodgeOn=true; startDodge(); Notif("Dodge","Active","ok") end,
        function() dodgeOn=false; if dodgeConn then dodgeConn:Disconnect();dodgeConn=nil end; Notif("Dodge","Off","") end)

    local function hookDeathHum(char)
        local hum=char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        hum.Died:Connect(function() if hrp and hrp.Parent then dtCF=hrp.CFrame end end)
    end
    local function startDT()
        dtCharConn=TC(lp.CharacterAdded:Connect(function(char)
            task.wait(0.8); local hrp2=char:FindFirstChild("HumanoidRootPart")
            if hrp2 and dtCF then hrp2.CFrame=dtCF; Notif("Death TP","Returned","ok") end; hookDeathHum(char)
        end))
        if lp.Character then hookDeathHum(lp.Character) end
    end
    MkToggle(P,"DEATH TP",58,
        function() dtOn=true; startDT(); Notif("Death TP","Active","ok") end,
        function() dtOn=false; if dtCharConn then dtCharConn:Disconnect();dtCharConn=nil end; Notif("Death TP","Off","") end)

    MkSep(P,"TP Aura",59)
    local tpAuraDelay=0
    local function startTPAura()
        if tpAuraConn then tpAuraConn:Disconnect();tpAuraConn=nil end
        local alive=true
        task.spawn(function()
            while alive and tpAuraOn do
                local mc=lp.Character; local mHRP=mc and mc:FindFirstChild("HumanoidRootPart")
                if mHRP then
                    local arena=findArena()
                    local best,bestD=nil,math.huge
                    for _,p in Players:GetPlayers() do
                        if not IsTarget(p) then continue end; local c=p.Character; if not c then continue end
                        local hrp=c:FindFirstChild("HumanoidRootPart"); local hum=c:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health>0 then
                            local d=(hrp.Position-mHRP.Position).Magnitude; if d<bestD then bestD=d; best=hrp end
                        end
                    end
                    if best and arena then
                        local halfSize=arena.Size/2
                        local randLocal=Vector3.new(
                            (math.random()-0.5)*2*(halfSize.X-2),
                            halfSize.Y+2,
                            (math.random()-0.5)*2*(halfSize.Z-2)
                        )
                        local worldPos=arena.CFrame:PointToWorldSpace(randLocal)
                        mHRP.CFrame=CFrame.new(worldPos)
                        mHRP.AssemblyLinearVelocity=Vector3.zero
                        task.wait()
                        mHRP.CFrame=CFrame.new(best.Position+Vector3.new(0,2,0))
                        mHRP.AssemblyLinearVelocity=Vector3.zero
                    elseif best then
                        mHRP.CFrame=CFrame.new(best.Position+Vector3.new(0,2,0))
                        mHRP.AssemblyLinearVelocity=Vector3.zero
                    end
                end
                if tpAuraDelay>0 then task.wait(tpAuraDelay/20) else task.wait() end
                if not alive then break end
            end
        end)
        tpAuraConn=TC({Disconnect=function() alive=false end} :: any)
    end
    MkToggle(P,"TP AURA",60,
        function() tpAuraOn=true; startTPAura(); Notif("TP Aura","Active","ok") end,
        function() tpAuraOn=false; if tpAuraConn then tpAuraConn:Disconnect();tpAuraConn=nil end; Notif("TP Aura","Off","") end)
    MkSlider(P,"TP AURA DELAY (0=instant)",0,100,0,61,function(v) tpAuraDelay=v end)

    MkSep(P,"Auto Farm",62)
    local function inArena(char)
        local arena=findArena(); if not arena then return true end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return false end
        local rel=arena.CFrame:PointToObjectSpace(hrp.Position); local sz=arena.Size/2
        return math.abs(rel.X)<=sz.X+8 and math.abs(rel.Y)<=sz.Y+8 and math.abs(rel.Z)<=sz.Z+8
    end
    local function startAFK()
        if afkConn then afkConn:Disconnect() end
        local t=0
        afkConn=TC(RunSvc.Heartbeat:Connect(function(dt)
            if not afkOn then return end
            t=t+dt; if t<0.04 then return end; t=0
            local mc=lp.Character; if not mc then return end
            local mHRP=mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            local mHum=mc:FindFirstChildOfClass("Humanoid"); if not mHum or mHum.Health<=0 then return end
            local best,bestD=nil,math.huge
            for _,p in Players:GetPlayers() do
                if not IsTarget(p) then continue end
                local c=p.Character; if not c then continue end
                local hum=c:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health<=0 then continue end
                if not inArena(c) then continue end
                local hrp2=c:FindFirstChild("HumanoidRootPart"); if not hrp2 then continue end
                local d=(hrp2.Position-mHRP.Position).Magnitude; if d<bestD then bestD=d; best=p end
            end
            if not best or not best.Character then
                local arena=findArena()
                if arena and not inArena(mc) then mHRP.CFrame=arena.CFrame*CFrame.new(0,3,0); mHRP.AssemblyLinearVelocity=Vector3.zero end
                return
            end
            local tHead=best.Character:FindFirstChild("Head"); if not tHead then return end
            local tHum2=best.Character:FindFirstChildOfClass("Humanoid"); if not tHum2 then return end
            mHRP.CFrame=CFrame.new(tHead.Position+Vector3.new(0,2.5,0)); mHRP.AssemblyLinearVelocity=Vector3.zero
            if tHum2.Health>0 then
                pcall(function() if RF.PunchDo then RF.PunchDo:InvokeServer() end end)
                pcall(function() if RF.Hit then RF.Hit:InvokeServer(tHum2,vector.create(mHRP.Position.X,mHRP.Position.Y,mHRP.Position.Z)) end end)
            end
        end))
    end
    MkToggle(P,"AUTO FARM",63,
        function() afkOn=true; startAFK(); Notif("Auto Farm","Active","ok") end,
        function() afkOn=false; if afkConn then afkConn:Disconnect();afkConn=nil end; Notif("Auto Farm","Off","") end)
    RegKB("Auto Farm",Enum.KeyCode.B,function()
        afkOn=not afkOn
        if afkOn then startAFK(); Notif("Auto Farm","Active","ok") else if afkConn then afkConn:Disconnect();afkConn=nil end; Notif("Auto Farm","Off","") end
    end)

    MkSep(P,"Fake Lag",64)
    local flConn; local fl2Conn; local fl3Conn
    MkToggle(P,"FAKE LAG - JITTER",65,
        function()
            flConn=TC(RunSvc.Heartbeat:Connect(function()
                local c=lp.Character; local hrp=c and c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
                hrp.CFrame=hrp.CFrame*CFrame.new((math.random()-.5)*1.2,(math.random()-.5)*.5,(math.random()-.5)*1.2)
            end))
            Notif("Fake Lag","Jitter active","ok")
        end,
        function() if flConn then flConn:Disconnect();flConn=nil end; Notif("Fake Lag","Off","") end)
    MkToggle(P,"FAKE LAG - FREEZE (2s loop)",66,
        function()
            local on=true
            fl2Conn=TC({Disconnect=function() on=false end} :: any)
            task.spawn(function()
                while on do
                    local c=lp.Character; local hrp=c and c:FindFirstChild("HumanoidRootPart")
                    if hrp then local cf=hrp.CFrame; task.wait(2); if hrp and hrp.Parent then hrp.CFrame=cf end end
                    task.wait(0.1)
                end
            end)
            Notif("Fake Lag","Freeze loop active","ok")
        end,
        function() Notif("Fake Lag","Off","") end)
    MkToggle(P,"FAKE LAG - BLINK",67,
        function()
            fl3Conn=TC(RunSvc.Heartbeat:Connect(function()
                if math.random(1,8)~=1 then return end
                local c=lp.Character; local hrp=c and c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
                local orig=hrp.CFrame
                hrp.CFrame=CFrame.new(orig.Position+Vector3.new(math.random(-8,8),0,math.random(-8,8)))
                task.wait(); if hrp and hrp.Parent then hrp.CFrame=orig end
            end))
            Notif("Fake Lag","Blink active","ok")
        end,
        function() if fl3Conn then fl3Conn:Disconnect();fl3Conn=nil end; Notif("Fake Lag","Off","") end)
end

-- ═══════════════════════════════════════
-- TAB 3: RP COLOR
-- ═══════════════════════════════════════
do
    local P=tabPanels[3]
    local rpOn=false; local rpConn; local rpSpd=SAVE.rpSpeed; local rpMode="rainbow"
    local bioPhrasesOn=false; local _phraseTask=nil; local _currentPhrase=""
    local _userPhrases={}; local nameTypewriter=SAVE.nameTypewriter; local bioTypeSpeed=SAVE.bioTypeSpeed; local rpNameIdx=1
    
    local function parseUserPhrases(s)
        _userPhrases={}
        for line in (s or ""):gmatch("[^\n]+") do
            local t=line:match("^%s*(.-)%s*$")
            if t~="" then insert(_userPhrases,t) end
        end
        if #_userPhrases==0 then insert(_userPhrases,"unknown console") end
    end
    parseUserPhrases(SAVE.phrases)
    
    local function startPhrases()
        if _phraseTask then task.cancel(_phraseTask) end
        _phraseTask=spawn(function()
            while bioPhrasesOn do
                local s=_userPhrases[random(1,#_userPhrases)]
                local t=""
                local delay=1/(bioTypeSpeed or 10)
                for u=1,#s do
                    if not bioPhrasesOn then break end
                    t=string.sub(s,1,u); _currentPhrase=t; wait(delay)
                end
                wait(0.05); _currentPhrase=""
            end
        end)
    end
    
    local function stopPhrases()
        bioPhrasesOn=false
        if _phraseTask then task.cancel(_phraseTask);_phraseTask=nil end
        _currentPhrase=""
    end
    
    local function startRP()
        if rpConn then rpConn:Disconnect() end
        local accB=0; local accR=0; local bioT=0; local rpT=0; local nameT=0
        local PHASE=0.22
        
        rpConn=TC(RunSvc.RenderStepped:Connect(function(dt)
            if not rpOn then return end
            local spd=rpSpd*0.05
            accB=accB+dt*spd; accR=accR+dt*spd; bioT=bioT+dt; rpT=rpT+dt; nameT=nameT+dt
            
            if bioT>=0.06 and bioPhrasesOn and _currentPhrase~="" then
                bioT=0
                pcall(function() if RF.UpdateBio then RF.UpdateBio:FireServer(_currentPhrase) end end)
            elseif bioT>=0.06 then bioT=0 end
            
            if nameTypewriter and nameT>=0.1 then
                nameT=0
                local fullName=lp.DisplayName
                pcall(function()
                    if RF.UpdateRPName then RF.UpdateRPName:FireServer(string.sub(fullName,1,rpNameIdx)) end
                end)
                rpNameIdx=rpNameIdx>=#fullName and 1 or rpNameIdx+1
            end
            
            if rpT>=0.05 then
                rpT=0
                local cB,cR
                
                if rpMode=="rainbow" then
                    cB=Color3.fromHSV((accB+PHASE)%1,0.65,0.98)
                    cR=Color3.fromHSV(accR%1,0.65,0.98)
                elseif rpMode=="bw" then
                    local v=(math.sin(accB*6)+1)/2
                    cB=Color3.new(v,v,v); cR=cB
                elseif rpMode=="strobe" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(1,1,1) or Color3.new(0,0,0); cR=cB
                elseif rpMode=="pastel" then
                    cB=Color3.fromHSV((accB+PHASE)%1,0.35,0.99)
                    cR=Color3.fromHSV(accR%1,0.35,0.99)
                elseif rpMode=="neon" then
                    cB=Color3.fromHSV((accB+PHASE)%1,1,1)
                    cR=Color3.fromHSV(accR%1,1,1)
                elseif rpMode=="fire" then
                    local h=(accB*0.1)%0.15
                    cB=Color3.fromHSV(h,0.9,1); cR=Color3.fromHSV((accR*0.1)%0.15,0.9,1)
                elseif rpMode=="ice" then
                    local h=0.55+(accB*0.05)%0.1
                    cB=Color3.fromHSV(h,0.7,0.95); cR=Color3.fromHSV(0.55+(accR*0.05)%0.1,0.7,0.95)
                elseif rpMode=="toxic" then
                    local h=0.3+(accB*0.08)%0.15
                    cB=Color3.fromHSV(h,0.85,0.95); cR=Color3.fromHSV(0.3+(accR*0.08)%0.15,0.85,0.95)
                elseif rpMode=="galaxy" then
                    local h=(accB*0.2)%1
                    cB=Color3.fromHSV(h,0.8,0.9); cR=Color3.fromHSV((accR*0.2)%1,0.8,0.9)
                elseif rpMode=="sunset" then
                    local h=(accB*0.12)%0.25
                    cB=Color3.fromHSV(h,0.8,1); cR=Color3.fromHSV((accR*0.12)%0.25,0.8,1)
                elseif rpMode=="ocean" then
                    local h=0.5+(accB*0.06)%0.2
                    cB=Color3.fromHSV(h,0.7,0.9); cR=Color3.fromHSV(0.5+(accR*0.06)%0.2,0.7,0.9)
                elseif rpMode=="matrix" then
                    local g=random()>0.7 and 1 or 0.2
                    cB=Color3.fromRGB(0,g*255,0); cR=cB
                elseif rpMode=="vaporwave" then
                    local h=(accB*0.15)%1
                    cB=Color3.fromHSV(h,0.6,1); cR=Color3.fromHSV((accR*0.15)%1,0.6,1)
                elseif rpMode=="crimson" then
                    local v=(math.sin(accB*4)+1)/2
                    cB=Color3.fromRGB(255,v*100,v*100); cR=cB
                    elseif rpMode=="R+R" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(85,0,0) or Color3.new(255,0,0); cR=cB
                elseif rpMode=="gold" then
                    local v=(math.sin(accB*3)+1)/2
                    cB=Color3.fromRGB(255,200+v*55,0); cR=cB
 elseif rpMode == "R+B+R" then
    local colors = {
        Color3.fromRGB(85, 0, 0),   -- red
        Color3.fromRGB(255, 0, 0),   -- blue
        Color3.fromRGB(0, 0, 0)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "sky blue" then
    local colors = {
        Color3.fromRGB(135, 206, 250),   -- red
        Color3.fromRGB(65, 105, 225),   -- blue
        Color3.fromRGB(0, 0, 0)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
        cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
elseif rpMode == "ice" then
    local colors = {
        Color3.fromRGB(0, 0, 0),   -- red
        Color3.fromRGB(117,117,117),   -- blue
        Color3.fromRGB(248,248,255)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "clay" then
    local colors = {
        Color3.fromRGB(248,248,255),   -- red
        Color3.fromRGB(128,128,128),   -- blue
        Color3.fromRGB(131,137,150)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "R+R+R" then
    local colors = {
        Color3.fromRGB(128,0,0),   -- red
        Color3.fromRGB(220,20,60),   -- blue
        Color3.fromRGB(233,150,122)
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "www" then
    local colors = {
        Color3.fromRGB(240,255,240),   -- red
        Color3.fromRGB(255,250,250),   -- blue
        Color3.fromRGB(255,255,240)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "ggg" then
    local colors = {
        Color3.fromRGB(60,179,113),   -- red
        Color3.fromRGB(0,128,0),   -- blue
        Color3.fromRGB(0,128,0)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "bbb" then
    local colors = {
        Color3.fromRGB(16,12,8),   -- red
        Color3.fromRGB(8,8,8),   -- blue
        Color3.fromRGB(16,12,8)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "horn" then
    local colors = {
        Color3.fromRGB(255,69,0),   -- red
        Color3.fromRGB(147, 147, 147),   -- blue
        Color3.fromRGB(0,0,0)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "horn1" then
    local colors = {
        Color3.fromRGB(135, 206, 250),   -- red
        Color3.fromRGB(147, 147, 147),   -- blue
        Color3.fromRGB(0,0,0)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
    elseif rpMode == "horn2" then
    local colors = {
        Color3.fromRGB(1, 50, 32),   -- red
        Color3.fromRGB(147, 147, 147),   -- blue
        Color3.fromRGB(53, 6, 62)  -- yellow
    }
    cB = colors[math.random(1, #colors)]
    cR = colors[math.random(1, #colors)]
                end
                
                
                if cB then pcall(function() if RF.UpdateBioColor then RF.UpdateBioColor:FireServer(cB) end end) end
                if cR then pcall(function() if RF.UpdateRPColor then RF.UpdateRPColor:FireServer(cR) end end) end
            end
        end))
    end
    
    local _,_,rpSet=MkToggle(P,"RP COLOR",1,
        function() rpOn=true; startRP(); Notif("RP Color","Active","ok") end,
        function() rpOn=false; if rpConn then rpConn:Disconnect();rpConn=nil end; Notif("RP Color","Off","") end)
    RegKB("RP Color",Enum.KeyCode.R,function()
        rpOn=not rpOn; rpSet(rpOn)
        if rpOn then startRP(); Notif("RP Color","Active","ok") else if rpConn then rpConn:Disconnect();rpConn=nil end; Notif("RP Color","Off","") end
    end)
    
    MkSlider(P,"COLOR SPEED",1,100,SAVE.rpSpeed,2,function(v)
        rpSpd=v; SAVE.rpSpeed=v; task.delay(.5,DoSave); if rpOn then startRP() end
    end)
    
    local modeCard=MkCard(P,158,3)
    MkLabel(modeCard,{text="COLOR MODE",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    
    local modes={"R+B+R","sky blue","ice white","clay","R+R+R","W+W+W","G+G+G","B+B+B","fire horn","ice horn","tox horn"}
    local modeKeys={"R+B+R","sky blue","ice","clay","R+R+R","www","ggg","bbb","horn","horn1","horn2"}
    
    local mRows={}
    for r=1,5 do
        local row=Instance.new("Frame",modeCard)
        row.Size=UDim2.new(1,-28,0,24); row.Position=UDim2.new(0,14,0,20+(r-1)*26)
        row.BackgroundTransparency=1; row.BorderSizePixel=0
        LL(row,4,Enum.FillDirection.Horizontal)
        insert(mRows,row)
    end
    
    local mBtns={}
    for i,lbl in ipairs(modes) do
        local key=modeKeys[i]
        local row=mRows[math.ceil(i/3)]
        local active=(key==rpMode)
        local b=MkBtn(row,{text=lbl,size=7,bg=active and T.ACCENT or T.RAISED,color=active and T.BG or T.TEXT,sz=UDim2.new(0.33,-3,1,0),corner=5,bgt=0,order=i,z=15})
        b.MouseButton1Click:Connect(function()
            rpMode=key
            for _,bt in ipairs(mBtns) do Tw(bt.b,{BackgroundColor3=T.RAISED,TextColor3=T.TEXT},0.14) end
            Tw(b,{BackgroundColor3=T.ACCENT,TextColor3=T.BG},0.14)
            if rpOn then startRP() end
        end)
        insert(mBtns,{b=b,k=key})
    end
    
    MkToggle(P,"NAME TYPEWRITER",4,
        function()
            nameTypewriter=true; SAVE.nameTypewriter=true; task.delay(.5,DoSave)
            rpNameIdx=1; Notif("Name Typewriter","Active","ok")
        end,
        function()
            nameTypewriter=false; SAVE.nameTypewriter=false; task.delay(.5,DoSave)
            pcall(function() if RF.UpdateRPName then RF.UpdateRPName:FireServer(lp.DisplayName) end end)
            Notif("Name Typewriter","Off","")
        end)
    
    MkToggle(P,"BIO PHRASES",5,
        function() bioPhrasesOn=true; startPhrases(); Notif("Bio Phrases","Active","ok") end,
        function() stopPhrases(); Notif("Bio Phrases","Off","") end)
    
    MkSlider(P,"BIO TYPE SPEED",1,250,SAVE.bioTypeSpeed,15,function(v)
        bioTypeSpeed=v; SAVE.bioTypeSpeed=v; task.delay(.5,DoSave)
    end)
    
    local phCard=MkCard(P,106,7)
    MkLabel(phCard,{text="PHRASES (one per line)",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    local phBox=Instance.new("TextBox",phCard)
    phBox.Size=UDim2.new(1,-28,0,78); phBox.Position=UDim2.new(0,14,0,22)
    phBox.BackgroundColor3=T.RAISED; phBox.BackgroundTransparency=0.2
    phBox.FontFace=Reg; phBox.TextSize=9; phBox.TextColor3=T.TEXT
    phBox.PlaceholderColor3=T.DIM; phBox.PlaceholderText="One phrase per line..."
    phBox.Text=SAVE.phrases; phBox.ClearTextOnFocus=false; phBox.BorderSizePixel=0
    phBox.TextXAlignment=Enum.TextXAlignment.Left; phBox.TextYAlignment=Enum.TextYAlignment.Top
    phBox.MultiLine=true; phBox.ZIndex=15; Cnr(phBox,6); LP(phBox,6,6,4,4)
    local phS=Strk(phBox,T.BORDER,1,0.4)
    phBox.Focused:Connect(function() Tw(phS,{Transparency=0,Color=T.ACCENT},0.14) end)
    phBox.FocusLost:Connect(function()
        Tw(phS,{Transparency=0.4,Color=T.BORDER},0.14)
        SAVE.phrases=phBox.Text; parseUserPhrases(SAVE.phrases); task.delay(.5,DoSave)
    end)
end

-- ═══════════════════════════════════════
-- TAB 4: MOVEMENT
-- ═══════════════════════════════════════
do
    local P=tabPanels[4]
    
    _G.CLX_tpwOn=false; _G.CLX_tpwSpd=SAVE.tpwSpeed; local tpwConn

    -- Instant TP WALK: uses the player's current MoveDirection every frame
    -- with no direction smoothing or artificial wait/delay.
    local function startTPW()
        if tpwConn then tpwConn:Disconnect() end
        tpwConn=TC(RunSvc.RenderStepped:Connect(function(dt)
            if not _G.CLX_tpwOn then return end
            local ch=lp.Character; if not ch then return end
            local hrp=ch:FindFirstChild("HumanoidRootPart")
            local hum=ch:FindFirstChildWhichIsA("Humanoid")
            if not (hrp and hum and hum.Health>0) then return end

            local md=hum.MoveDirection
            if md.Magnitude<=0.01 then return end

            local speed=math.max(0,tonumber(_G.CLX_tpwSpd) or 0)
            local step=md.Unit*speed*dt*10
            pcall(function()
                ch:TranslateBy(step)
            end)
        end))
    end

    local _,_,tpwSet=MkToggle(P,"TPWALK",1,
        function() _G.CLX_tpwOn=true; startTPW(); Notif("TPWalk","Active","ok") end,
        function() _G.CLX_tpwOn=false; if tpwConn then tpwConn:Disconnect();tpwConn=nil end; Notif("TPWalk","Off","") end)

    -- Public wrapper used by the CLAUDE radial circle.
    _G.CLX_SetTPWalk = function(state)
        state = state == true
        _G.CLX_tpwOn = state
        tpwSet(state)
        if state then
            startTPW()
            Notif("TPWalk","Active (Circle)","ok")
        else
            if tpwConn then
                tpwConn:Disconnect()
                tpwConn = nil
            end
            Notif("TPWalk","Off (Circle)","")
        end
    end

    RegKB("TPWalk",Enum.KeyCode.T,function()
        _G.CLX_tpwOn=not _G.CLX_tpwOn; tpwSet(_G.CLX_tpwOn)
        if _G.CLX_tpwOn then startTPW(); Notif("TPWalk","Active","ok") else if tpwConn then tpwConn:Disconnect();tpwConn=nil end; Notif("TPWalk","Off","") end
    end)
    
    MkSlider(P,"TPWALK SPEED",1,80,SAVE.tpwSpeed,2,function(v) _G.CLX_tpwSpd=v; SAVE.tpwSpeed=v; task.delay(.5,DoSave) end)
    
    _G.CLX_flyOn=false; _G.CLX_flySpd=SAVE.flySpeed; local flyConn; local fbv,fbg
    local function startFly()
        local char=lp.Character; if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local hum=char:FindFirstChildOfClass("Humanoid"); if hum then hum.PlatformStand=true end
        fbv=Instance.new("BodyVelocity",hrp); fbv.MaxForce=Vector3.new(1e5,1e5,1e5); fbv.Velocity=Vector3.zero
        fbg=Instance.new("BodyGyro",hrp); fbg.MaxTorque=Vector3.new(1e5,1e5,1e5); fbg.D=150; _G.CLX_flyOn=true
        flyConn=TC(RunSvc.RenderStepped:Connect(function()
            if not _G.CLX_flyOn then return end
            local c=workspace.CurrentCamera; if not c then return end; local v=Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then v=v+c.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then v=v-c.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then v=v-c.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then v=v+c.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then v=v+Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then v=v-Vector3.new(0,1,0) end
            if v.Magnitude>0 then v=v.Unit*_G.CLX_flySpd end
            if fbv and fbv.Parent then fbv.Velocity=v end
            if fbg and fbg.Parent then fbg.CFrame=c.CFrame end
        end))
    end
    local function stopFly()
        _G.CLX_flyOn=false; if flyConn then flyConn:Disconnect();flyConn=nil end
        pcall(function() if fbv then fbv:Destroy() end end)
        pcall(function() if fbg then fbg:Destroy() end end)
        pcall(function() lp.Character:FindFirstChildOfClass("Humanoid").PlatformStand=false end)
    end
    
    local _,_,flySet=MkToggle(P,"FLY",3,
        function() startFly(); Notif("Fly","Active","ok") end,
        function() stopFly(); Notif("Fly","Off","") end)
    
    MkSlider(P,"FLY SPEED",1,300,SAVE.flySpeed,4,function(v) _G.CLX_flySpd=v; SAVE.flySpeed=v; task.delay(.5,DoSave) end)
    MkSlider(P,"WALK SPEED",1,500,16,5,function(v) pcall(function() lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed=v end) end)
    MkSlider(P,"JUMP POWER",1,500,50,6,function(v) pcall(function() local h=lp.Character:FindFirstChildOfClass("Humanoid"); h.UseJumpPower=true; h.JumpPower=v end) end)
    MkSlider(P,"GRAVITY",1,600,196,7,function(v) pcall(function() workspace.Gravity=v end) end)
    
    local noclipOn=false
    MkToggle(P,"NOCLIP",8,
        function() noclipOn=true; Notif("Noclip","Active","ok") end,
        function() noclipOn=false; Notif("Noclip","Off","") end)
    TC(RunSvc.Stepped:Connect(function()
        if not noclipOn then return end
        local c=lp.Character; if not c then return end
        for _,v in ipairs(c:GetDescendants()) do if v:IsA("BasePart") then pcall(function() v.CanCollide=false end) end end
    end))
    RegKB("Noclip",Enum.KeyCode.N,function() noclipOn=not noclipOn; Notif("Noclip",noclipOn and "Active" or "Off","") end)
    
    local ijOn=false
    MkToggle(P,"INFINITE JUMP",9,function() ijOn=true end,function() ijOn=false end)
    TC(UIS.JumpRequest:Connect(function()
        if not ijOn then return end; local c=lp.Character; if not c then return end
        local h=c:FindFirstChildOfClass("Humanoid"); if not h then return end
        pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
    end))
end

-- ═══════════════════════════════════════
-- TAB 5: TARGETS
-- ═══════════════════════════════════════
do
    local P=tabPanels[5]
    
    local _,tBox=MkTBoxCard(P,"TARGETS (blank=everyone except friends)","target1 target2 ...",1,SAVE.targets)
    tBox.FocusLost:Connect(function()
        SAVE.targets=tBox.Text; parseTargets(SAVE.targets); task.delay(.5,DoSave)
    end)
    
    MkSep(P,"Target Strafe",2)
    local _,stBox=MkTBoxCard(P,"STRAFE TARGET","player name ...",3,SAVE.strafeTarget)
    stBox.FocusLost:Connect(function() SAVE.strafeTarget=stBox.Text; task.delay(.5,DoSave) end)
    
    local strafeOn=false; local strafeAngle=0; local strafeConn
    local strafeRadius=SAVE.strafeRadius; local strafeSpeed=SAVE.strafeSpeed
    local strafeOffset=SAVE.strafeOffset; local backstabOn=false
    
    local function startStrafe()
        if strafeConn then strafeConn:Disconnect() end; strafeAngle=0
        strafeConn=TC(RunSvc.Heartbeat:Connect(function(dt)
            if not strafeOn then return end
            local tname=stBox.Text; if tname=="" then return end
            local tgt=findPlayer(tname); if not tgt or not tgt.Character then return end
            local tHRP=tgt.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return end
            local tHum=tgt.Character:FindFirstChildOfClass("Humanoid")
            if tHum and tHum.Health<=0 then
                local mc=lp.Character; local mHRP=mc and mc:FindFirstChild("HumanoidRootPart")
                if mHRP then mHRP.CFrame=SAFE_CF; mHRP.AssemblyLinearVelocity=Vector3.zero end
                return
            end
            local mc=lp.Character; local mHRP=mc and mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            cleanRag(mc)
            local tPos=tHRP.Position; local newPos
            if backstabOn then
                newPos=tPos+(-tHRP.CFrame.LookVector*strafeRadius)+Vector3.new(0,strafeOffset,0)
            else
                strafeAngle=strafeAngle+strafeSpeed*dt
                newPos=Vector3.new(tPos.X+math.cos(strafeAngle)*strafeRadius,tPos.Y+strafeOffset,tPos.Z+math.sin(strafeAngle)*strafeRadius)
            end
            mHRP.CFrame=CFrame.new(newPos,Vector3.new(tPos.X,mHRP.Position.Y,tPos.Z))
            mHRP.AssemblyLinearVelocity=Vector3.zero
        end))
    end
    
    MkToggle(P,"TARGET STRAFE",4,
        function() strafeOn=true; startStrafe(); Notif("Strafe","Active","ok") end,
        function() strafeOn=false; if strafeConn then strafeConn:Disconnect();strafeConn=nil end; Notif("Strafe","Off","") end)
    
    MkToggle(P,"BACKSTAB MODE",5,function() backstabOn=true end,function() backstabOn=false end)
    MkSlider(P,"STRAFE RADIUS",2,30,SAVE.strafeRadius,6,function(v) strafeRadius=v; SAVE.strafeRadius=v; task.delay(.5,DoSave) end)
    MkSlider(P,"STRAFE SPEED",1,20,SAVE.strafeSpeed,7,function(v) strafeSpeed=v; SAVE.strafeSpeed=v; task.delay(.5,DoSave) end)
    MkSlider(P,"GROUND OFFSET",-15,10,SAVE.strafeOffset,8,function(v) strafeOffset=v; SAVE.strafeOffset=v; task.delay(.5,DoSave) end)
    
    MkSep(P,"Orbit",9)
    local _,orbBox=MkTBoxCard(P,"ORBIT TARGET","player name ...",10,SAVE.orbTarget)
    orbBox.FocusLost:Connect(function() SAVE.orbTarget=orbBox.Text; task.delay(.5,DoSave) end)
    
    local orbOn=false; local orbAngle=0; local orbConn
    local orbRadius=SAVE.orbRadius; local orbSpeed=SAVE.orbSpeed; local orbHeight=SAVE.orbHeight
    
    local function startOrb()
        if orbConn then orbConn:Disconnect() end; orbAngle=0
        orbConn=TC(RunSvc.Heartbeat:Connect(function(dt)
            if not orbOn then return end
            local tname=orbBox.Text; if tname=="" then return end
            local tgt=findPlayer(tname); if not tgt or not tgt.Character then return end
            local tHRP=tgt.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return end
            local mc=lp.Character; local mHRP=mc and mc:FindFirstChild("HumanoidRootPart"); if not mHRP then return end
            local tHum=tgt.Character:FindFirstChildOfClass("Humanoid")
            if tHum and tHum.Health<=0 then
                mHRP.CFrame=SAFE_CF; mHRP.AssemblyLinearVelocity=Vector3.zero; return
            end
            cleanRag(mc)
            orbAngle=orbAngle+orbSpeed*dt; local tp=tHRP.Position
            mHRP.CFrame=CFrame.new(tp+Vector3.new(math.cos(orbAngle)*orbRadius,orbHeight,math.sin(orbAngle)*orbRadius),tp)
            mHRP.AssemblyLinearVelocity=Vector3.zero
        end))
    end
    
    local _,_,orbSet=MkToggle(P,"ORBIT PLAYER",11,
        function() orbOn=true; startOrb(); Notif("Orbit","Active","ok") end,
        function() orbOn=false; if orbConn then orbConn:Disconnect();orbConn=nil end; Notif("Orbit","Off","") end)
    RegKB("Orbit",Enum.KeyCode.O,function()
        orbOn=not orbOn; orbSet(orbOn)
        if orbOn then startOrb(); Notif("Orbit","Active","ok") else if orbConn then orbConn:Disconnect();orbConn=nil end; Notif("Orbit","Off","") end
    end)
    
    MkSlider(P,"ORBIT RADIUS",2,50,SAVE.orbRadius,12,function(v) orbRadius=v; SAVE.orbRadius=v; task.delay(.5,DoSave) end)
    MkSlider(P,"ORBIT SPEED",1,1000,SAVE.orbSpeed,13,function(v) orbSpeed=v; SAVE.orbSpeed=v; task.delay(.5,DoSave) end)
    MkSlider(P,"HEIGHT OFFSET",-10,10,SAVE.orbHeight,14,function(v) orbHeight=v; SAVE.orbHeight=v; task.delay(.5,DoSave) end)
end

-- ═══════════════════════════════════════
-- TAB 6: GHOST
-- ═══════════════════════════════════════
    do
        local P = tabPanels[6]
        local ghostOn = false
        local _ghostDecoy = nil
        local _ghostConn = nil
        local _diedConn = nil
        local GHOST_PLATFORM_POS = Vector3.new(0, 10000, 0)

        local RunService = game:GetService("RunService")
        local UIS = game:GetService("UserInputService")
        local Players = game:GetService("Players")
        local lp = Players.LocalPlayer

        _G.CLX_flyOn = _G.CLX_flyOn or false
        _G.CLX_flySpd = _G.CLX_flySpd or 50
        _G.CLX_tpwOn = _G.CLX_tpwOn or false
        _G.CLX_tpwSpd = _G.CLX_tpwSpd or 50

        local ghostPlatform = Instance.new("Part")
        ghostPlatform.Name = "GhostPlatform"
        ghostPlatform.Size = Vector3.new(750, 1, 750)
        ghostPlatform.Anchored = true
        ghostPlatform.CanCollide = true
        ghostPlatform.Transparency = 1
        ghostPlatform.Parent = workspace
        ghostPlatform.CFrame = CFrame.new(GHOST_PLATFORM_POS)

        local function getJoints(model)
            local t = {}
            for _, v in ipairs(model:GetDescendants()) do
                if v:IsA("Motor6D") then
                    t[v.Name] = v
                end
            end
            return t
        end

        local function setLocalHidden(char, hidden)
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.LocalTransparencyModifier = hidden and 1 or 0
                    if v.Name == "HumanoidRootPart" then
                        v.Transparency = 1
                    end
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = hidden and 1 or 0
                end
            end
        end

        local function isShiftLock()
            return UIS.MouseBehavior == Enum.MouseBehavior.LockCenter
        end

        local function isChatting()
            return UIS:GetFocusedTextBox() ~= nil
        end

        local _stopping = false
        local _emoteMirror = {}

        local function isRagdolledOrDead(hum)
            if not hum then return true end
            local state = hum:GetState()
            return hum.Health <= 0 or 
                hum.PlatformStand or 
                state == Enum.HumanoidStateType.Ragdoll or 
                state == Enum.HumanoidStateType.FallingDown or 
                state == Enum.HumanoidStateType.Dead
        end

        local function stopGhost(forceNoTeleport)
            if _stopping or not ghostOn then return end
            _stopping = true
            ghostOn = false

            if _ghostConn then _ghostConn:Disconnect(); _ghostConn = nil end
            if _diedConn then _diedConn:Disconnect(); _diedConn = nil end

            for _, decoyTrack in pairs(_emoteMirror) do
                pcall(function() decoyTrack:Stop() end)
            end
            table.clear(_emoteMirror)

            local char = lp.Character
            if char then
                setLocalHidden(char, false)

                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")

                if hum then
                    hum.PlatformStand = false
                    hum.AutoRotate = true
                end

                if hrp and _ghostDecoy and _ghostDecoy.Parent and not forceNoTeleport then
                    local decoyHRP = _ghostDecoy:FindFirstChild("HumanoidRootPart")
                    if decoyHRP and hum and not isRagdolledOrDead(hum) then
                        task.wait()
                        if hrp and decoyHRP and hum and not isRagdolledOrDead(hum) then
                            hrp.CFrame = decoyHRP.CFrame + Vector3.new(0, 2, 0)
                            hrp.AssemblyLinearVelocity = Vector3.zero
                            hrp.AssemblyAngularVelocity = Vector3.zero
                        end
                    end
                    hrp.Anchored = false
                end

                workspace.CurrentCamera.CameraSubject = hum or char
            end

            if _ghostDecoy then
                _ghostDecoy:Destroy()
                _ghostDecoy = nil
            end

            _stopping = false
        end

        local function startGhost()
            if ghostOn then return end
            local char = lp.Character
            if not char then return end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end

            if _diedConn then _diedConn:Disconnect() end

            char.Archivable = true
            local clone = char:Clone()
            char.Archivable = false

            clone.Name = "Ghost"

            for _, v in ipairs(clone:GetDescendants()) do
                if v:IsA("BaseScript") then
                    v:Destroy()
                end
            end

            for _, v in ipairs(clone:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                    v.Massless = false
                    if v.Name ~= "HumanoidRootPart" then
                        v.Transparency = 0.5
                    else
                        v.Transparency = 1
                    end
                elseif v:IsA("Accessory") then
                    for _, part in ipairs(v:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 0.5
                            part.CanCollide = false
                            part.Massless = false
                        end
                    end
                end
            end

            local cloneHum = clone:FindFirstChildOfClass("Humanoid")
            local decoyHRP = clone:FindFirstChild("HumanoidRootPart")
            if not cloneHum or not decoyHRP then
                clone:Destroy()
                return
            end

            cloneHum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            cloneHum.PlatformStand = false
            cloneHum.AutoRotate = true

            local anim = cloneHum:FindFirstChildOfClass("Animator")
            if anim then anim:Destroy() end

            decoyHRP.CFrame = hrp.CFrame
            clone.Parent = workspace

            -- NEW: Clone tools so both real player and ghost can use them
            local backpack = lp:FindFirstChildOfClass("Backpack")
            
            -- Clone tools from Backpack to ghost
            if backpack then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        local toolClone = tool:Clone()
                        toolClone.Parent = clone
                    end
                end
            end
            
            -- Clone tools that are currently equipped in the real character to ghost
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    local toolClone = tool:Clone()
                    toolClone.Parent = clone
                end
            end

            _ghostDecoy = clone
            ghostOn = true

            setLocalHidden(char, true)
            hrp.CFrame = CFrame.new(GHOST_PLATFORM_POS + Vector3.new(0, 5, 0))
            hrp.AssemblyLinearVelocity = Vector3.zero

            workspace.CurrentCamera.CameraSubject = decoyHRP

            -- Died handler
            _diedConn = hum.Died:Connect(function()
                stopGhost(true)
                if _gSet then _gSet(false) end
            end)

            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.zero

            local bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)

            local realJoints = getJoints(char)
            local fakeJoints = getJoints(clone)

            _ghostConn = RunService.Heartbeat:Connect(function(dt)
                if not ghostOn or not _ghostDecoy or not _ghostDecoy.Parent then
                    stopGhost()
                    return
                end

                -- Skip movement when chatting
                if isChatting() then
                    for name, real in pairs(realJoints) do
                        local fake = fakeJoints[name]
                        if fake then
                            fake.Transform = real.Transform
                        end
                    end
                    return
                end

                -- Normal movement (only when not chatting)
                local move = Vector3.zero
                local cam = workspace.CurrentCamera

                if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end

                local moveDir = Vector3.new(move.X, 0, move.Z)
                if moveDir.Magnitude > 0 then moveDir = moveDir.Unit end

                hum:Move(moveDir, false)
                cloneHum:Move(moveDir, false)

                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    hum.Jump = true
                    cloneHum.Jump = true
                end

                local isFlying = _G.CLX_flyOn
                local isTPW = _G.CLX_tpwOn

                if isFlying then
                    cloneHum.PlatformStand = true
                    bv.Parent = decoyHRP
                    bg.Parent = decoyHRP

                    local fly = move
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then fly += Vector3.new(0, 1, 0) end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then fly -= Vector3.new(0, 1, 0) end

                    if fly.Magnitude > 0 then
                        bv.Velocity = fly.Unit * _G.CLX_flySpd
                    else
                        bv.Velocity = Vector3.zero
                    end
                    bg.CFrame = cam.CFrame
                elseif isTPW then
                    cloneHum.PlatformStand = false
                    bv.Parent = nil
                    bg.Parent = nil
                    local md = cloneHum.MoveDirection
                    if md.Magnitude > 0 then
                        clone:TranslateBy(md.Unit * _G.CLX_tpwSpd * dt * 12)
                    end
                else
                    cloneHum.PlatformStand = false
                    bv.Parent = nil
                    bg.Parent = nil
                end

                if isShiftLock() then
                    local look = cam.CFrame.LookVector
                    look = Vector3.new(look.X, 0, look.Z)
                    if look.Magnitude > 0 then
                        decoyHRP.CFrame = CFrame.new(decoyHRP.Position, decoyHRP.Position + look)
                    end
                end

                -- Sync joints
                for name, real in pairs(realJoints) do
                    local fake = fakeJoints[name]
                    if fake then
                        fake.Transform = real.Transform
                    end
                end
            end)
        end

        local _, _, gs = MkToggle(P, "GHOST MODE", 1,
            function() startGhost() end,
            function() stopGhost() end
        )
        _gSet = gs

        RegKB("Ghost", Enum.KeyCode.Q, function()
            if ghostOn then
                stopGhost()
                _gSet(false)
            else
                startGhost()
                _gSet(true)
            end
        end)

        lp.CharacterAdded:Connect(function()
            task.wait(0.5)
            if ghostOn then
                stopGhost(true)
                _gSet(false)
            end
        end)

        lp.CharacterRemoving:Connect(function()
            if ghostOn then
                stopGhost(true)
                _gSet(false)
            end
        end)
    end

-- ═══════════════════════════════════════
-- TAB 7: GLITCH
-- ═══════════════════════════════════════
do
    local P=tabPanels[7]
    local function setupNoRag(char)
        pcall(function()
            local h=char:WaitForChild("Humanoid",4); if not h then return end
            h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
            h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        end)
    end
    pcall(function() setupNoRag(lp.Character or lp.CharacterAdded:Wait()) end)
    lp.CharacterAdded:Connect(setupNoRag)
    
    local gfOn=false; local gfConn; local gfSet; local glitchR=4; local gtBox
    
    do
        local card=MkCard(P,52,1)
        MkLabel(card,{text="GLITCH",size=9,color=T.TEXT,font=Semi,sz=UDim2.new(1,-68,0,18),pos=UDim2.new(0,16,0.5,-9),z=14})
        
        local track=Instance.new("TextButton",card)
        track.Size=UDim2.new(0,42,0,20); track.Position=UDim2.new(1,-54,0.5,-10)
        track.BackgroundColor3=T.RAISED; track.BackgroundTransparency=0.1; track.Text=""
        track.AutoButtonColor=false; track.BorderSizePixel=0; track.ZIndex=15; Cnr(track,11); Strk(track,T.BORDER,1,0.4)
        
        local thumb=Instance.new("Frame",track)
        thumb.Size=UDim2.new(0,14,0,14); thumb.Position=UDim2.new(0,3,0.5,-7)
        thumb.BackgroundColor3=T.OFF; thumb.BorderSizePixel=0; thumb.ZIndex=16; Cnr(thumb,9)
        
        gfSet=function(s)
            Tw(thumb,{
                Position=s and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7),
                BackgroundColor3=s and T.ON or T.OFF
            },0.25,Enum.EasingStyle.Back)
            Tw(track,{BackgroundColor3=s and Color3.fromRGB(35,45,55) or T.RAISED},0.18)
        end
        
        track.MouseButton1Click:Connect(function()
            gfOn=not gfOn; gfSet(gfOn)
            if gfOn then
                Notif("Glitch","Active","warn")
                gfConn=TC(RunSvc.RenderStepped:Connect(function()
                    if not gfOn then return end
                    local tname=gtBox and gtBox.Text or ""
                    local tgt=tname~="" and findPlayer(tname) or nil
                    if not tgt then
                        local mc=lp.Character; if not mc then return end
                        local mH=mc:FindFirstChild("HumanoidRootPart"); if not mH then return end
                        local best,bestD=nil,math.huge
                        for _,p in ipairs(Players:GetPlayers()) do
                            if not isTarget(p) then continue end
                            local c=p.Character; if not c then continue end
                            local h=c:FindFirstChild("HumanoidRootPart"); if not h then continue end
                            local d=(h.Position-mH.Position).Magnitude; if d<bestD then bestD=d; best=p end
                        end
                        tgt=best
                    end
                    if not tgt or not tgt.Character then return end
                    local tH=tgt.Character:FindFirstChild("HumanoidRootPart"); if not tH then return end
                    local mc=lp.Character; if not mc then return end
                    local mH=mc:FindFirstChild("HumanoidRootPart"); if not mH then return end
                    local h2=mc:FindFirstChildOfClass("Humanoid")
                    if h2 then pcall(function() h2:ChangeState(Enum.HumanoidStateType.Running) end) end
                    mH.AssemblyLinearVelocity=Vector3.zero
                    for _=1,8 do
                        mH.CFrame=tH.CFrame*CFrame.new(random(-glitchR,glitchR),random(-2,2),random(-glitchR,glitchR))*CFrame.Angles(rad(random(-360,360)),rad(random(-360,360)),rad(random(-360,360)))
                    end
                end))
            else
                if gfConn then gfConn:Disconnect();gfConn=nil end
                Notif("Glitch","Stopped","")
            end
        end)
    end
    
    do local _,gtB=MkTBoxCard(P,"GLITCH TARGET (blank=nearest)","player name ...",2); gtBox=gtB end
    MkSlider(P,"INTENSITY",1,20,4,3,function(v) glitchR=v end)
    RegKB("Emergency Stop Glitch",Enum.KeyCode.J,function()
        if gfOn then
            gfOn=false; gfSet(false)
            if gfConn then gfConn:Disconnect();gfConn=nil end
            Notif("Glitch","Emergency stopped","warn")
        end
    end)
end

-- ═══════════════════════════════════════
-- ════════════════════════════════════════════════════════════
-- SPIN CONTROLS REMOVED FROM V3 UI
-- ════════════════════════════════════════════════════════════
-- The old SUPER SPIN / SPIN SPEED controls are intentionally not
-- created in the new galaxy layout. The tab index is kept intact
-- so the existing settings/config panels remain aligned.

-- TAB 10: SETTINGS
-- ═══════════════════════════════════════
do
    local P=tabPanels[9]
    local tkCard=MkCard(P,52,1)
    MkLabel(tkCard,{text="TOGGLE UI KEYBIND",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    local curName=SAVE.toggleKey or "Insert"
    local tkLbl=MkLabel(tkCard,{text="Current: ["..curName.."]",size=9,color=T.TEXT,font=Semi,sz=UDim2.new(1,-76,0,16),pos=UDim2.new(0,14,0,24),z=14})
    local tkBtn=MkBtn(tkCard,{bg=T.RAISED,text="BIND",size=8,color=T.TEXT,sz=UDim2.new(0,56,0,22),pos=UDim2.new(1,-66,0,24),corner=5,bgt=0.1,z=15})
    tkBtn.MouseButton1Click:Connect(function()
        tkBtn.Text="..."; tkBtn.TextColor3=T.ACCENT; _kbListening=true
        _kbCb=function(kc)
            _toggleKey=kc; local newN=tostring(kc):gsub("Enum.KeyCode.","")
            SAVE.toggleKey=newN; task.delay(.5,DoSave)
            tkLbl.Text="Current: ["..newN.."]"; tkBtn.Text="BIND"; tkBtn.TextColor3=T.TEXT
        end
    end)
    
    local rwCard=MkCard(P,40,2)
    local rwBtn=MkBtn(rwCard,{bg=T.RAISED,text="RESET WINDOW POSITION",size=9,color=T.TEXT,sz=UDim2.new(1,-28,0,24),pos=UDim2.new(0,14,0,8),corner=6,bgt=0.1,z=15})
    rwBtn.MouseButton1Click:Connect(function() Win.Position=UDim2.new(0.5,-WW/2,0.5,-WH/2); Notif("Window","Reset","ok") end)

    local kCard=MkCard(P,64,2.5)
    MkLabel(kCard,{text="KILL RESET",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    MkLabel(kCard,{text="Force-resets your character when pressed.",size=8,color=T.MUTED,font=Reg,sz=UDim2.new(1,-28,0,14),pos=UDim2.new(0,14,0,24),z=14})
    local kCurName=SAVE.keybinds["Kill"] or "L"
    local kLbl=MkLabel(kCard,{text="Current: ["..kCurName.."]",size=9,color=T.TEXT,font=Semi,sz=UDim2.new(1,-76,0,16),pos=UDim2.new(0,14,0,42),z=14})
    local kBtn=MkBtn(kCard,{bg=T.RAISED,text="BIND",size=8,color=T.TEXT,sz=UDim2.new(0,56,0,22),pos=UDim2.new(1,-66,0,42),corner=5,bgt=0.1,z=15})
    local function doKillReset(kcKey)
        pcall(function()
            local kb=RegKB("Kill",kcKey or Enum.KeyCode.L,function()
                local lp=Players.LocalPlayer
                local chr=lp and lp.Character
                if not chr then return end
                pcall(function()
                    local hum=chr:FindFirstChildOfClass("Humanoid")
                    if hum then hum.Health=0 end
                    chr:BreakJoints()
                end)
                Notif("Kill","Player forcefully reset","warn")
            end)
            if kcKey then kb.key=kcKey end
        end)
    end
    doKillReset()
    kBtn.MouseButton1Click:Connect(function()
        kBtn.Text="..."; kBtn.TextColor3=T.ACCENT; _kbListening=true
        _kbCb=function(kc)
            doKillReset(kc)
            local newN=tostring(kc):gsub("Enum.KeyCode.","")
            SAVE.keybinds["Kill"]=newN; task.delay(.5,DoSave)
            kLbl.Text="Current: ["..newN.."]"; kBtn.Text="BIND"; kBtn.TextColor3=T.TEXT
        end
    end)
    
    MkSep(P,"Keybinds",3)
    local kbCard=MkCard(P,240,4)
    MkLabel(kbCard,{text="CLICK BIND THEN PRESS KEY",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    local kbSF=Instance.new("ScrollingFrame",kbCard); kbSF.Size=UDim2.new(1,-24,0,216); kbSF.Position=UDim2.new(0,12,0,20)
    kbSF.BackgroundTransparency=1; kbSF.ScrollBarThickness=2; kbSF.ScrollBarImageColor3=T.DIM
    kbSF.AutomaticCanvasSize=Enum.AutomaticSize.Y; kbSF.CanvasSize=UDim2.new(0,0,0,0)
    kbSF.BorderSizePixel=0; kbSF.ClipsDescendants=true; LL(kbSF,3)
    task.delay(0.5,function()
        for i,kb in ipairs(KEYBINDS) do MkKBRow(kbSF,kb.action,i) end
    end)
end

-- ═══════════════════════════════════════
-- TAB 11: CONFIGS
-- ═══════════════════════════════════════
do
    local P=tabPanels[10]
    local function getSnap()
        return {kaRange=SAVE.kaRange,kaAPS=SAVE.kaAPS,hbSize=SAVE.hbSize,rpSpeed=SAVE.rpSpeed,
            friends=SAVE.friends,targets=SAVE.targets,
            strafeRadius=SAVE.strafeRadius,strafeSpeed=SAVE.strafeSpeed,strafeOffset=SAVE.strafeOffset,
            tpwSpeed=SAVE.tpwSpeed,orbRadius=SAVE.orbRadius,orbSpeed=SAVE.orbSpeed,orbHeight=SAVE.orbHeight,
            flySpeed=SAVE.flySpeed,
            phrases=SAVE.phrases,bioTypeSpeed=SAVE.bioTypeSpeed,nameTypewriter=SAVE.nameTypewriter}
    end
    local configs=SAVE.configs or {}
    local _,nBox=MkTBoxCard(P,"CONFIG NAME","e.g. pvp setup",1)
    local btnCard=MkCard(P,42,2)
    local btnRow=Instance.new("Frame",btnCard); btnRow.Size=UDim2.new(1,-28,0,26); btnRow.Position=UDim2.new(0,14,0,8)
    btnRow.BackgroundTransparency=1; LL(btnRow,6,Enum.FillDirection.Horizontal)
    local saveBtn=MkBtn(btnRow,{bg=T.RAISED,text="SAVE",size=10,color=T.TEXT,sz=UDim2.new(0.32,-4,1,0),corner=6,bgt=0.08,order=1,z=15})
    local loadBtn=MkBtn(btnRow,{bg=T.ACCENT,text="LOAD",size=10,color=T.BG,sz=UDim2.new(0.32,-4,1,0),corner=6,bgt=0,order=2,z=15})
    local delBtn=MkBtn(btnRow,{bg=T.ERR,text="DEL",size=10,color=T.TEXT,sz=UDim2.new(0.32,-4,1,0),corner=6,bgt=0.12,order=3,z=15})
    local listCard=MkCard(P,180,3)
    MkLabel(listCard,{text="SAVED CONFIGS",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    local listSF=Instance.new("ScrollingFrame",listCard); listSF.Size=UDim2.new(1,-24,0,156); listSF.Position=UDim2.new(0,12,0,20)
    listSF.BackgroundTransparency=1; listSF.ScrollBarThickness=2; listSF.ScrollBarImageColor3=T.DIM
    listSF.AutomaticCanvasSize=Enum.AutomaticSize.Y; listSF.CanvasSize=UDim2.new(0,0,0,0)
    listSF.BorderSizePixel=0; listSF.ClipsDescendants=true; LL(listSF,3)
    local function refreshList()
        for _,v in ipairs(listSF:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
        local n=0
        for name,_ in pairs(configs) do n=n+1
            local row=Instance.new("Frame",listSF); row.Size=UDim2.new(1,0,0,28)
            row.BackgroundColor3=T.RAISED; row.BackgroundTransparency=0.2; row.BorderSizePixel=0; Cnr(row,6)
            MkLabel(row,{text=name,size=9,color=T.TEXT,font=Semi,sz=UDim2.new(1,-50,1,0),pos=UDim2.new(0,10,0,0),z=15})
            local lb=MkBtn(row,{bg=T.ACCENT,text="LOAD",size=7,color=T.BG,sz=UDim2.new(0,42,0,20),pos=UDim2.new(1,-45,0.5,-10),corner=4,bgt=0,z=15})
            lb.MouseButton1Click:Connect(function()
                local cfg=configs[name]; if not cfg then return end
                for k,v in pairs(cfg) do SAVE[k]=v end
                parseFriends(SAVE.friends); parseTargets(SAVE.targets); DoSave()
                Notif("Config","Loaded: "..name,"ok")
            end)
        end
        if n==0 then MkLabel(listSF,{text="No configs saved.",size=9,color=T.MUTED,font=Reg,sz=UDim2.new(1,0,0,26),z=14}).LayoutOrder=1 end
    end
    refreshList()
    saveBtn.MouseButton1Click:Connect(function()
        local name=nBox.Text~="" and nBox.Text or "default"
        configs[name]=getSnap(); SAVE.configs=configs; DoSave(); refreshList(); Notif("Config","Saved: "..name,"ok")
    end)
    loadBtn.MouseButton1Click:Connect(function()
        local name=nBox.Text~="" and nBox.Text or "default"
        local cfg=configs[name]; if not cfg then Notif("Config","Not found","err"); return end
        for k,v in pairs(cfg) do SAVE[k]=v end; parseFriends(SAVE.friends); parseTargets(SAVE.targets); DoSave()
        Notif("Config","Loaded: "..name,"ok")
    end)
    delBtn.MouseButton1Click:Connect(function()
        local name=nBox.Text~="" and nBox.Text or "default"
        configs[name]=nil; SAVE.configs=configs; DoSave(); refreshList(); Notif("Config","Deleted","")
    end)
end
-- ═══════════════════════════════════════
-- TAB 12: ADVANCED COMBAT
-- ═══════════════════════════════════════
do
    local P=tabPanels[11]
    
    MkSep(P,"Auto Combo",1)
    
    local autoComboOn=false; local autoComboConn
    local autoComboDelay=0.15
    
    local _,_,acSet=MkToggle(P,"AUTO COMBO CHAIN",2,
        function()
            autoComboOn=true
            if autoComboConn then autoComboConn:Disconnect() end
            autoComboConn=TC(RunSvc.Heartbeat:Connect(function()
                if not autoComboOn then return end
                local myC=lp.Character; if not myC then return end
                local myH=myC:FindFirstChild("HumanoidRootPart"); if not myH then return end
                
                local best,bestD=nil,math.huge
                for _,p in ipairs(Players:GetPlayers()) do
                    if not isTarget(p) then continue end
                    local c=p.Character; if not c then continue end
                    local h=c:FindFirstChild("HumanoidRootPart"); if not h then continue end
                    local hum=c:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health<=0 then continue end
                    local d=(h.Position-myH.Position).Magnitude
                    if d<=15 and d<bestD then bestD=d; best={p,h,hum} end
                end
                
                if best then
                    local p,hrp,hum=best[1],best[2],best[3]
                    pcall(function()
                        if RF.PunchDo then RF.PunchDo:FireServer(hum,hrp.Position) end
                        task.wait(autoComboDelay)
                        if RF.Hit then RF.Hit:InvokeServer(hum,vector.create(myH.Position.X,myH.Position.Y,myH.Position.Z)) end
                    end)
                end
            end))
            Notif("Auto Combo","Active","ok")
        end,
        function()
            autoComboOn=false
            if autoComboConn then autoComboConn:Disconnect(); autoComboConn=nil end
            Notif("Auto Combo","Off","")
        end)
    
    MkSlider(P,"COMBO DELAY",10,500,150,3,function(v) autoComboDelay=v/1000 end)
    
    MkSep(P,"Auto Parry",4)
    
    local autoParryOn=false; local autoParryConn
    local parryRange=8
    
    MkToggle(P,"AUTO PARRY",5,
        function()
            autoParryOn=true
            if autoParryConn then autoParryConn:Disconnect() end
            autoParryConn=TC(RunSvc.Heartbeat:Connect(function()
                if not autoParryOn then return end
                local myC=lp.Character; if not myC then return end
                local myH=myC:FindFirstChild("HumanoidRootPart"); if not myH then return end
                
                for _,p in ipairs(Players:GetPlayers()) do
                    if p==lp or isFriend(p) then continue end
                    local c=p.Character; if not c then continue end
                    local h=c:FindFirstChild("HumanoidRootPart"); if not h then continue end
                    local hum=c:FindFirstChildOfClass("Humanoid"); if not hum then continue end
                    
                    local dist=(h.Position-myH.Position).Magnitude
                    if dist<=parryRange then
                        local vel=h.AssemblyLinearVelocity
                        if vel.Magnitude>20 then
                            pcall(function() if RF.Block then RF.Block:FireServer() end end)
                            break
                        end
                    end
                end
            end))
            Notif("Auto Parry","Active","ok")
        end,
        function()
            autoParryOn=false
            if autoParryConn then autoParryConn:Disconnect(); autoParryConn=nil end
            Notif("Auto Parry","Off","")
        end)
    
    MkSlider(P,"PARRY RANGE",5,20,8,6,function(v) parryRange=v end)
    
    MkSep(P,"Counter Attack",7)
    
    local counterOn=false; local counterConn
    
    MkToggle(P,"AUTO COUNTER",8,
        function()
            counterOn=true
            if counterConn then counterConn:Disconnect() end
            counterConn=TC(RunSvc.Heartbeat:Connect(function()
                if not counterOn then return end
                local myC=lp.Character; if not myC then return end
                local myH=myC:FindFirstChild("HumanoidRootPart"); if not myH then return end
                local myHum=myC:FindFirstChildOfClass("Humanoid"); if not myHum then return end
                
                for _,p in ipairs(Players:GetPlayers()) do
                    if p==lp or isFriend(p) then continue end
                    local c=p.Character; if not c then continue end
                    local h=c:FindFirstChild("HumanoidRootPart"); if not h then continue end
                    local hum=c:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health<=0 then continue end
                    
                    local dist=(h.Position-myH.Position).Magnitude
                    if dist<=10 then
                        if hum:GetState()==Enum.HumanoidStateType.Freefall then
                            task.wait(0.1)
                            pcall(function()
                                if RF.Hit then RF.Hit:InvokeServer(hum,vector.create(h.Position.X,h.Position.Y,h.Position.Z)) end
                            end)
                        end
                    end
                end
            end))
            Notif("Auto Counter","Active","ok")
        end,
        function()
            counterOn=false
            if counterConn then counterConn:Disconnect(); counterConn=nil end
            Notif("Auto Counter","Off","")
        end)
    
    MkSep(P,"Prediction Hit",9)
    
    local predHitOn=false; local predHitConn
    local predMulti=0.3
    
    MkToggle(P,"PREDICTION HIT",10,
        function()
            predHitOn=true
            if predHitConn then predHitConn:Disconnect() end
            predHitConn=TC(RunSvc.Heartbeat:Connect(function()
                if not predHitOn then return end
                local myC=lp.Character; if not myC then return end
                local myH=myC:FindFirstChild("HumanoidRootPart"); if not myH then return end
                
                local best,bestD=nil,math.huge
                for _,p in ipairs(Players:GetPlayers()) do
                    if not isTarget(p) then continue end
                    local c=p.Character; if not c then continue end
                    local h=c:FindFirstChild("HumanoidRootPart"); if not h then continue end
                    local hum=c:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health<=0 then continue end
                    local d=(h.Position-myH.Position).Magnitude
                    if d<=20 and d<bestD then bestD=d; best={hum,h} end
                end
                
                if best then
                    local hum,hrp=best[1],best[2]
                    local vel=hrp.AssemblyLinearVelocity
                    local predPos=hrp.Position+vel*predMulti
                    pcall(function()
                        if RF.Hit then RF.Hit:InvokeServer(hum,vector.create(predPos.X,predPos.Y,predPos.Z)) end
                    end)
                end
            end))
            Notif("Prediction Hit","Active","ok")
        end,
        function()
            predHitOn=false
            if predHitConn then predHitConn:Disconnect(); predHitConn=nil end
            Notif("Prediction Hit","Off","")
        end)
    
    MkSlider(P,"PREDICTION MULTIPLIER",10,100,30,11,function(v) predMulti=v/100 end)
end

-- ═══════════════════════════════════════
-- TAB 13: COMBAT UTILS
-- ═══════════════════════════════════════
do
    local P=tabPanels[12]
    
    MkSep(P,"Combat Tools",1)
    
    local hitboxOn=false; local hitboxSize=12
    MkToggle(P,"HITBOX EXPANDER",2,
        function()
            hitboxOn=true
            spawn(function()
                while hitboxOn do
                    for _,p in ipairs(Players:GetPlayers()) do
                        if isTarget(p) and p.Character then
                            local h=p.Character:FindFirstChild("HumanoidRootPart")
                            if h then
                                pcall(function()
                                    h.Size=Vector3.new(hitboxSize,hitboxSize,hitboxSize)
                                    h.Transparency=0.7
                                    h.CanCollide=false
                                end)
                            end
                        end
                    end
                    wait(0.1)
                end
            end)
            Notif("Hitbox","Expanded","ok")
        end,
        function()
            hitboxOn=false
            for _,p in ipairs(Players:GetPlayers()) do
                if p.Character then
                    local h=p.Character:FindFirstChild("HumanoidRootPart")
                    if h then
                        pcall(function()
                            h.Size=Vector3.new(2,2,1)
                            h.Transparency=1
                        end)
                    end
                end
            end
            Notif("Hitbox","Normal","")
        end)
    
    MkSlider(P,"HITBOX SIZE",5,50,12,3,function(v) hitboxSize=v end)
    
    MkSep(P,"Reach",4)
    
    local reachOn=false; local reachDist=15
    MkToggle(P,"REACH EXTENDER",5,
        function()
            reachOn=true
            Notif("Reach","Extended to "..reachDist,"ok")
        end,
        function()
            reachOn=false
            Notif("Reach","Normal","")
        end)
    
    MkSlider(P,"REACH DISTANCE",5,30,15,6,function(v) reachDist=v end)
    
    MkSep(P,"Auto Dodge",7)
    
    local dodgeOn=false; local dodgeConn
    MkToggle(P,"AUTO DODGE",8,
        function()
            dodgeOn=true
            if dodgeConn then dodgeConn:Disconnect() end
            dodgeConn=TC(RunSvc.Heartbeat:Connect(function()
                if not dodgeOn then return end
                local myC=lp.Character; if not myC then return end
                local myH=myC:FindFirstChild("HumanoidRootPart"); if not myH then return end
                
                for _,p in ipairs(Players:GetPlayers()) do
                    if p==lp or isFriend(p) then continue end
                    local c=p.Character; if not c then continue end
                    local h=c:FindFirstChild("HumanoidRootPart"); if not h then continue end
                    
                    local dist=(h.Position-myH.Position).Magnitude
                    if dist<=6 then
                        local vel=h.AssemblyLinearVelocity
                        if vel.Magnitude>25 then
                            local dodge=myH.CFrame.RightVector*5
                            myH.CFrame=myH.CFrame+dodge
                            myH.AssemblyLinearVelocity=Vector3.zero
                            break
                        end
                    end
                end
            end))
            Notif("Auto Dodge","Active","ok")
        end,
        function()
            dodgeOn=false
            if dodgeConn then dodgeConn:Disconnect(); dodgeConn=nil end
            Notif("Auto Dodge","Off","")
        end)
    
    MkSep(P,"Speed Boost",9)
    
    local speedOn=false; local speedMult=1.5
    MkToggle(P,"SPEED BOOST",10,
        function()
            speedOn=true
            pcall(function()
                local hum=lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed=hum.WalkSpeed*speedMult end
            end)
            Notif("Speed Boost","Active","ok")
        end,
        function()
            speedOn=false
            pcall(function()
                local hum=lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed=16 end
            end)
            Notif("Speed Boost","Off","")
        end)
    
    MkSlider(P,"SPEED MULTIPLIER",100,300,150,11,function(v) speedMult=v/100 end)
end

-- ═══════════════════════════════════════
-- TAB 14: ADVANTAGE
-- ═══════════════════════════════════════
do
    local P=tabPanels[13]
    
    MkSep(P,"Invisibility",1)
    
    local invisOn=false
    local invisSet

    local function setInvisible(state, source)
        invisOn = state == true
        local char = lp.Character
        if char then
            for _,v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then
                    pcall(function() v.Transparency = invisOn and 1 or 0 end)
                elseif v:IsA("Accessory") then
                    for _,p in ipairs(v:GetDescendants()) do
                        if p:IsA("BasePart") then
                            pcall(function() p.Transparency = invisOn and 1 or 0 end)
                        end
                    end
                end
            end
        end
        Notif("Invisible", invisOn and ("Ghost Mode: ON" .. (source and " ("..source..")" or "")) or "Ghost Mode: OFF", invisOn and "ok" or "")
    end

    _G.CLX_SetInvisible = function(state, source)
        _G.CLX_InvisibleOn = state == true
        setInvisible(_G.CLX_InvisibleOn, source)
        if invisSet then invisSet(_G.CLX_InvisibleOn) end
    end
    _G.CLX_InvisibleOn = false

    _,_,invisSet = MkToggle(P,"GHOSTMODE",2,
        function()
            _G.CLX_InvisibleOn = true
            setInvisible(true, "Ghost Mode")
        end,
        function()
            _G.CLX_InvisibleOn = false
            setInvisible(false, "Ghost Mode")
        end)
    
    MkSep(P,"No Camera Shake",3)
    
    MkToggle(P,"DISABLE CAM SHAKE",4,
        function()
            pcall(function()
                local cam=workspace.CurrentCamera
                for _,v in ipairs(cam:GetChildren()) do
                    if v:IsA("Script") and v.Name:lower():find("shake") then
                        v:Destroy()
                    end
                end
            end)
            Notif("Camera","Shake disabled","ok")
        end,
        function()
            Notif("Camera","Rejoin to re-enable","")
        end)
    
    MkSep(P,"Auto Respawn",5)
    
    local autoRespawn=false
    MkToggle(P,"AUTO RESPAWN",6,
        function()
            autoRespawn=true
            Notif("Auto Respawn","Active","ok")
        end,
        function()
            autoRespawn=false
            Notif("Auto Respawn","Off","")
        end)
    
    lp.CharacterAdded:Connect(function(char)
        task.defer(function()
            if _G.CLX_InvisibleOn == true then
                task.wait(0.25)
                setInvisible(true, "Ghost Mode")
            end
        end)

        if autoRespawn then
            local hum=char:WaitForChild("Humanoid",5)
            if hum then
                hum.Died:Connect(function()
                    if autoRespawn then
                        task.wait(0.5)
                        pcall(function() lp:LoadCharacter() end)
                    end
                end)
            end
        end
    end)
    
    MkSep(P,"Server Tools",7)
    
    local lowGfxCard=MkCard(P,42,8)
    local lowGfxBtn=MkBtn(lowGfxCard,{bg=T.RAISED,text="ENABLE LOW GRAPHICS",size=9,color=T.TEXT,sz=UDim2.new(1,-28,0,26),pos=UDim2.new(0,14,0,8),corner=6,bgt=0.1,z=15})
    lowGfxBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local lighting=game:GetService("Lighting")
            lighting.GlobalShadows=false
            lighting.FogEnd=9e9
            settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
                    v.Material=Enum.Material.Plastic
                    v.Reflectance=0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency=1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime=NumberRange.new(0)
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled=false
                end
            end
        end)
        Notif("Graphics","Low mode enabled","ok")
    end)
    
    local rejoinCard=MkCard(P,42,9)
    local rejoinBtn=MkBtn(rejoinCard,{bg=T.RAISED,text="REJOIN SERVER",size=9,color=T.TEXT,sz=UDim2.new(1,-28,0,26),pos=UDim2.new(0,14,0,8),corner=6,bgt=0.1,z=15})
    rejoinBtn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,lp)
        end)
    end)
    
    local serverHopCard=MkCard(P,42,10)
    local serverHopBtn=MkBtn(serverHopCard,{bg=T.RAISED,text="SERVER HOP",size=9,color=T.TEXT,sz=UDim2.new(1,-28,0,26),pos=UDim2.new(0,14,0,8),corner=6,bgt=0.1,z=15})
    serverHopBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local servers=game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            if servers and servers.data then
                for _,server in ipairs(servers.data) do
                    if server.id~=game.JobId and server.playing<server.maxPlayers then
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,server.id,lp)
                        break
                    end
                end
            end
        end)
    end)
end

print("Unknown console ui v1 booting...")

Win.Visible=true
GoTab(1)

print("Unknown")
Notif("Unknown","console ui v1.0","gg")
-- ═══════════════════════════════════════
-- TAB 3: RP COLOR
-- ═══════════════════════════════════════
do
    local P=tabPanels[3]
    local rpOn=false; local rpConn; local rpSpd=SAVE.rpSpeed; local rpMode="rainbow"
    local bioPhrasesOn=false; local _phraseTask=nil; local _currentPhrase=""
    local _userPhrases={}; local nameTypewriter=SAVE.nameTypewriter; local bioTypeSpeed=SAVE.bioTypeSpeed; local rpNameIdx=1
    
    local function parseUserPhrases(s)
        _userPhrases={}
        for line in (s or ""):gmatch("[^\n]+") do
            local t=line:match("^%s*(.-)%s*$")
            if t~="" then insert(_userPhrases,t) end
        end
        if #_userPhrases==0 then insert(_userPhrases,"unknown console") end
    end
    parseUserPhrases(SAVE.phrases)
    
    local function startPhrases()
        if _phraseTask then task.cancel(_phraseTask) end
        _phraseTask=spawn(function()
            while bioPhrasesOn do
                local s=_userPhrases[random(1,#_userPhrases)]
                local t=""
                local delay=1/(bioTypeSpeed or 10)
                for u=1,#s do
                    if not bioPhrasesOn then break end
                    t=string.sub(s,1,u); _currentPhrase=t; wait(delay)
                end
                wait(0.05); _currentPhrase=""
            end
        end)
    end
    
    local function stopPhrases()
        bioPhrasesOn=false
        if _phraseTask then task.cancel(_phraseTask);_phraseTask=nil end
        _currentPhrase=""
    end
    
    local function startRP()
        if rpConn then rpConn:Disconnect() end
        local accB=0; local accR=0; local bioT=0; local rpT=0; local nameT=0
        local PHASE=0.22
        
        rpConn=TC(RunSvc.RenderStepped:Connect(function(dt)
            if not rpOn then return end
            local spd=rpSpd*0.05
            accB=accB+dt*spd; accR=accR+dt*spd; bioT=bioT+dt; rpT=rpT+dt; nameT=nameT+dt
            
            if bioT>=0.06 and bioPhrasesOn and _currentPhrase~="" then
                bioT=0
                pcall(function() if RF.UpdateBio then RF.UpdateBio:FireServer(_currentPhrase) end end)
            elseif bioT>=0.06 then bioT=0 end
            
            if nameTypewriter and nameT>=0.1 then
                nameT=0
                local fullName=lp.DisplayName
                pcall(function()
                    if RF.UpdateRPName then RF.UpdateRPName:FireServer(string.sub(fullName,1,rpNameIdx)) end
                end)
                rpNameIdx=rpNameIdx>=#fullName and 1 or rpNameIdx+1
            end
            
            if rpT>=0.05 then
                rpT=0
                local cB,cR
                
                if rpMode=="rainbow" then
                    cB=Color3.fromHSV((accB+PHASE)%1,0.65,0.98)
                    cR=Color3.fromHSV(accR%1,0.65,0.98)
                elseif rpMode=="bw" then
                    local v=(math.sin(accB*6)+1)/2
                    cB=Color3.new(v,v,v); cR=cB
                elseif rpMode=="strobe" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(1,1,1) or Color3.new(0,0,0); cR=cB
                elseif rpMode=="pastel" then
                    cB=Color3.fromHSV((accB+PHASE)%1,0.35,0.99)
                    cR=Color3.fromHSV(accR%1,0.35,0.99)
                elseif rpMode=="neon" then
                    cB=Color3.fromHSV((accB+PHASE)%1,1,1)
                    cR=Color3.fromHSV(accR%1,1,1)
                elseif rpMode=="fire" then
                    local h=(accB*0.1)%0.15
                    cB=Color3.fromHSV(h,0.9,1); cR=Color3.fromHSV((accR*0.1)%0.15,0.9,1)
                elseif rpMode=="ice" then
                    local h=0.55+(accB*0.05)%0.1
                    cB=Color3.fromHSV(h,0.7,0.95); cR=Color3.fromHSV(0.55+(accR*0.05)%0.1,0.7,0.95)
                elseif rpMode=="toxic" then
                    local h=0.3+(accB*0.08)%0.15
                    cB=Color3.fromHSV(h,0.85,0.95); cR=Color3.fromHSV(0.3+(accR*0.08)%0.15,0.85,0.95)
                elseif rpMode=="galaxy" then
                    local h=(accB*0.2)%1
                    cB=Color3.fromHSV(h,0.8,0.9); cR=Color3.fromHSV((accR*0.2)%1,0.8,0.9)
                elseif rpMode=="sunset" then
                    local h=(accB*0.12)%0.25
                    cB=Color3.fromHSV(h,0.8,1); cR=Color3.fromHSV((accR*0.12)%0.25,0.8,1)
                elseif rpMode=="ocean" then
                    local h=0.5+(accB*0.06)%0.2
                    cB=Color3.fromHSV(h,0.7,0.9); cR=Color3.fromHSV(0.5+(accR*0.06)%0.2,0.7,0.9)
                elseif rpMode=="matrix" then
                    local g=random()>0.7 and 1 or 0.2
                    cB=Color3.fromRGB(0,g*255,0); cR=cB
                elseif rpMode=="vaporwave" then
                    local h=(accB*0.15)%1
                    cB=Color3.fromHSV(h,0.6,1); cR=Color3.fromHSV((accR*0.15)%1,0.6,1)
                elseif rpMode=="crimson" then
                    local v=(math.sin(accB*4)+1)/2
                    cB=Color3.fromRGB(255,v*100,v*100); cR=cB
                    elseif rpMode=="R+R" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(85,0,0) or Color3.new(255,0,0); cR=cB
                elseif rpMode=="gold" then
                    local v=(math.sin(accB*3)+1)/2
                    cB=Color3.fromRGB(255,200+v*55,0); cR=cB
                    elseif rpMode=="B+W" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(1,1,1) or Color3.new(0,0,0); cR=cB
                     elseif rpMode=="G+B" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(0,128,0) or Color3.new(0,0,0); cR=cB
                    elseif rpMode=="B+B" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(0,0,255) or Color3.new(0,0,0); cR=cB
                    elseif rpMode=="R+B" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(255,0,0) or Color3.new(0,0,0); cR=cB
                    elseif rpMode=="XBXB" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(173,216,230) or Color3.new(0,0,255); cR=cB
                    elseif rpMode=="R+W" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(255,0,0) or Color3.new(255,255,255); cR=cB
                                        cB=s and Color3.new(255,215,0) or Color3.new(000,000,000); cR=cB
                    elseif rpMode=="Y+W" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(34,139,34) or Color3.new(128,128,0); cR=cB
                    elseif rpMode=="G+R" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(255,0,0) or Color3.new(0,228,0); cR=cB
                    elseif rpMode=="MCDONALDS" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(255,215,0) or Color3.new(255,0,0); cR=cB
                    elseif rpMode=="G+W" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(255,255,255) or Color3.new(255,215,0); cR=cB
                    elseif rpMode=="P+W" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(255,255,255) or Color3.new(128,0,128); cR=cB
                    elseif rpMode=="R+B" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(255,0,0) or Color3.new(0,0,255); cR=cB
                    elseif rpMode=="P+B" then
                    local s=random(0,1)==1
                    cB=s and Color3.new(127,0,255) or Color3.new(0,0,0); cR=cB
                    elseif rpMode=="G+G" then
                    local g=random()>0.7 and 1 or 0.2
                    cB=Color3.fromRGB(0,g*255,0); cR=cB
                end
                
                
                
                if cB then pcall(function() if RF.UpdateBioColor then RF.UpdateBioColor:FireServer(cB) end end) end
                if cR then pcall(function() if RF.UpdateRPColor then RF.UpdateRPColor:FireServer(cR) end end) end
            end
        end))
    end
    
    local _,_,rpSet=MkToggle(P,"RP COLOR",1,
        function() rpOn=true; startRP(); Notif("RP Color","Active","ok") end,
        function() rpOn=false; if rpConn then rpConn:Disconnect();rpConn=nil end; Notif("RP Color","Off","") end)
    RegKB("RP Color",Enum.KeyCode.R,function()
        rpOn=not rpOn; rpSet(rpOn)
        if rpOn then startRP(); Notif("RP Color","Active","ok") else if rpConn then rpConn:Disconnect();rpConn=nil end; Notif("RP Color","Off","") end
    end)
    

    
    local modeCard=MkCard(P,158,3)
    MkLabel(modeCard,{text="COLOR MODE",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    
    local modes={"B+W","G+B","B+B","R+B","B+W","R+W","P+B","R+B","P+W","G+W","MCDONALDS","G+R","Y+W","G+G"}
    local modeKeys={"B+W","G+B","B+B","R+B","XBXB","R+W","P+B","R+B","P+W","G+W","MCDONALDS","G+R","Y+W","G+G"}
    
    local mRows={}
    for r=1,5 do
        local row=Instance.new("Frame",modeCard)
        row.Size=UDim2.new(1,-28,0,24); row.Position=UDim2.new(0,14,0,20+(r-1)*26)
        row.BackgroundTransparency=1; row.BorderSizePixel=0
        LL(row,4,Enum.FillDirection.Horizontal)
        insert(mRows,row)
    end
    
    local mBtns={}
    for i,lbl in ipairs(modes) do
        local key=modeKeys[i]
        local row=mRows[math.ceil(i/3)]
        local active=(key==rpMode)
        local b=MkBtn(row,{text=lbl,size=7,bg=active and T.ACCENT or T.RAISED,color=active and T.BG or T.TEXT,sz=UDim2.new(0.33,-3,1,0),corner=5,bgt=0,order=i,z=15})
        b.MouseButton1Click:Connect(function()
            rpMode=key
            for _,bt in ipairs(mBtns) do Tw(bt.b,{BackgroundColor3=T.RAISED,TextColor3=T.TEXT},0.14) end
            Tw(b,{BackgroundColor3=T.ACCENT,TextColor3=T.BG},0.14)
            if rpOn then startRP() end
        end)
        insert(mBtns,{b=b,k=key})
    end
    
    MkToggle(P,"NAME TYPEWRITER",4,
        function()
            nameTypewriter=true; SAVE.nameTypewriter=true; task.delay(.5,DoSave)
            rpNameIdx=1; Notif("Name Typewriter","Active","ok")
        end,
        function()
            nameTypewriter=false; SAVE.nameTypewriter=false; task.delay(.5,DoSave)
            pcall(function() if RF.UpdateRPName then RF.UpdateRPName:FireServer(lp.DisplayName) end end)
            Notif("Name Typewriter","Off","")
        end)
        
    
    MkToggle(P,"BIO PHRASES",5,
        function() bioPhrasesOn=true; startPhrases(); Notif("Bio Phrases","Active","ok") end,
        function() stopPhrases(); Notif("Bio Phrases","Off","") end)
    


    local phCard=MkCard(P,106,7)
    MkLabel(phCard,{text="PHRASES (one per line)",size=7,color=T.DIM,font=Bold,sz=UDim2.new(1,-28,0,10),pos=UDim2.new(0,14,0,7),z=14})
    local phBox=Instance.new("TextBox",phCard)
    phBox.Size=UDim2.new(1,-28,0,78); phBox.Position=UDim2.new(0,14,0,22)
    phBox.BackgroundColor3=T.RAISED; phBox.BackgroundTransparency=0.2
    phBox.FontFace=Reg; phBox.TextSize=9; phBox.TextColor3=T.TEXT
    phBox.PlaceholderColor3=T.DIM; phBox.PlaceholderText="One phrase per line..."
    phBox.Text=SAVE.phrases; phBox.ClearTextOnFocus=false; phBox.BorderSizePixel=0
    phBox.TextXAlignment=Enum.TextXAlignment.Left; phBox.TextYAlignment=Enum.TextYAlignment.Top
    phBox.MultiLine=true; phBox.ZIndex=15; Cnr(phBox,6); LP(phBox,6,6,4,4)
    local phS=Strk(phBox,T.BORDER,1,0.4)
    phBox.Focused:Connect(function() Tw(phS,{Transparency=0,Color=T.ACCENT},0.14) end)
    phBox.FocusLost:Connect(function()
        Tw(phS,{Transparency=0.4,Color=T.BORDER},0.14)
        SAVE.phrases=phBox.Text; parseUserPhrases(SAVE.phrases); task.delay(.5,DoSave)
    end)
end
-- ═══════════════════════════════════════
-- TAB 10: LIGHTING
-- ═══════════════════════════════════════
do
    local P = tabPanels[9]
    local Lighting = game:GetService("Lighting")

    -- Save default
    SAVE.lightLevel = SAVE.lightLevel or 5

    -- Convert 1-10 into Roblox ClockTime.
    -- 1 = darkest/night
    -- 10 = brightest/day
    local function levelToClock(level)
        -- 1 -> 0:00
        -- 10 -> 12:00
        return ((level - 1) / 9) * 12
    end

    local function applyLighting(level)
        level = clamp(level, 1, 10)

        local clockTime = levelToClock(level)

        pcall(function()
            Lighting.ClockTime = clockTime
        end)

        SAVE.lightLevel = level
        task.delay(0.25, DoSave)
    end

    MkSep(P,"Lighting Control",1)

    local info = MkCard(P,62,2)

    MkLabel(info,{
        text="CHANGE THE WORLD DARKNESS",
        size=9,
        color=T.TEXT,
        font=Semi,
        sz=UDim2.new(1,-32,0,18),
        pos=UDim2.new(0,16,0,8),
        z=14
    })

    MkLabel(info,{
        text="1 = darkest   •   10 = brightest",
        size=8,
        color=T.MUTED,
        font=Reg,
        sz=UDim2.new(1,-32,0,16),
        pos=UDim2.new(0,16,0,30),
        z=14
    })

    MkSlider(
        P,
        "LIGHT LEVEL",
        1,
        10,
        SAVE.lightLevel,
        3,
        function(v)
            applyLighting(v)
        end
    )

    local resetCard = MkCard(P,48,4)

    local resetBtn = MkBtn(resetCard,{
        bg=T.RAISED,
        text="RESET TO NORMAL DAY",
        size=9,
        color=T.TEXT,
        sz=UDim2.new(1,-32,0,28),
        pos=UDim2.new(0,16,0,10),
        corner=7,
        bgt=0.1,
        z=15
    })

    resetBtn.MouseButton1Click:Connect(function()
        applyLighting(10)
        Notif("Lighting","Reset to bright daytime","ok")
    end)

    -- Apply saved lighting when the script starts
    task.defer(function()
        applyLighting(SAVE.lightLevel)
    end)
end
-- ═══════════════════════════════════════
-- TAB 15: X-RAY
-- ═══════════════════════════════════════
do
    local P = tabPanels[14]
    local ESPEnabled = false
    local ESPObjects = {}
    local ESPTargets = {}

    local function isSelected(player)
        return ESPTargets[player] == true
    end

    local function removeESP(player)
        local data = ESPObjects[player]
        if data then
            if data.highlight then pcall(function() data.highlight:Destroy() end) end
            if data.nameTag then pcall(function() data.nameTag:Destroy() end) end
            ESPObjects[player] = nil
        end
    end

    local function addESP(player)
        if player == lp or not ESPEnabled or not isSelected(player) then
            removeESP(player)
            return
        end

        local character = player.Character
        if not character then return end

        removeESP(player)

        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerXRay_MultiTarget"
        highlight.Adornee = character
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = Color3.fromRGB(255,70,70)
        highlight.FillTransparency = 0.45
        highlight.OutlineColor = Color3.fromRGB(255,255,255)
        highlight.OutlineTransparency = 0
        highlight.Parent = character

        local head = character:FindFirstChild("Head")
        local nameTag

        if head then
            nameTag = Instance.new("BillboardGui")
            nameTag.Name = "PlayerESPName_MultiTarget"
            nameTag.Adornee = head
            nameTag.AlwaysOnTop = true
            nameTag.Size = UDim2.new(0,220,0,35)
            nameTag.StudsOffset = Vector3.new(0,2.8,0)
            nameTag.Parent = head

            local label = Instance.new("TextLabel")
            label.Size = UDim2.fromScale(1,1)
            label.BackgroundTransparency = 1
            label.Text = player.DisplayName .. " [" .. player.Name .. "]"
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.TextStrokeTransparency = 0
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = nameTag
        end

        ESPObjects[player] = {
            highlight = highlight,
            nameTag = nameTag
        }
    end

    local function refreshESP()
        for _,player in ipairs(Players:GetPlayers()) do
            if player ~= lp then
                if ESPEnabled and isSelected(player) then
                    addESP(player)
                else
                    removeESP(player)
                end
            end
        end
    end

    local function findAllTargets(input)
        local found = {}
        local seen = {}
        for name in tostring(input or ""):gmatch("%S+") do
            local target = findPlayer(name)
            if target and not seen[target] then
                seen[target] = true
                table.insert(found,target)
            end
        end
        return found
    end

    local function setTargets(input)
        ESPTargets = {}
        local found = findAllTargets(input)

        for _,player in ipairs(found) do
            ESPTargets[player] = true
        end

        refreshESP()

        if #found == 0 then
            ESPEnabled = false
            Notif("X-Ray","No matching players found. Enter usernames/display names separated by spaces.","warn")
            return false
        end

        ESPEnabled = true
        local names = {}
        for _,player in ipairs(found) do
            table.insert(names,player.Name)
        end

        Notif("X-Ray","Showing "..#found.." target"..(#found == 1 and "" or "s")..": "..table.concat(names,", "),"ok")
        return true
    end

    local function clearTargets()
        ESPTargets = {}
        ESPEnabled = false
        refreshESP()
    end

    -- PLAYERS INFO uses this same multi-target ESP system.
    _G.ClaudeXRayPlayer = function(player)
        if not player or player == lp or not player.Parent then
            Notif("X-Ray","Select a valid player first","warn")
            return false
        end

        ESPTargets[player] = true
        ESPEnabled = true
        refreshESP()
        Notif("X-Ray","ON: "..player.DisplayName.." ["..player.Name.."]","ok")
        return true
    end

    _G.ClaudeXRayRemovePlayer = function(player)
        if not player then return false end
        ESPTargets[player] = nil
        if next(ESPTargets) == nil then
            ESPEnabled = false
        end
        refreshESP()
        Notif("X-Ray","OFF: "..player.DisplayName,"ok")
        return true
    end

    _G.ClaudeXRayIsPlayerOn = function(player)
        return player ~= nil and ESPEnabled and ESPTargets[player] == true
    end

    local _,targetBox = MkTBoxCard(
        P,
        "X-RAY TARGETS",
        "usernames separated by spaces...",
        1,
        ""
    )

    local targetBtn = MkBtn(P,{
        bg=T.RAISED,
        text="SHOW TARGETS",
        size=9,
        color=T.TEXT,
        sz=UDim2.new(1,0,0,34),
        corner=8,
        bgt=0.05,
        order=2,
        z=15
    })

    targetBtn.MouseButton1Click:Connect(function()
        setTargets(targetBox.Text)
    end)

    targetBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            setTargets(targetBox.Text)
        end
    end)

    local clearBtn = MkBtn(P,{
        bg=T.CARD,
        text="CLEAR TARGETS",
        size=9,
        color=T.MUTED,
        sz=UDim2.new(1,0,0,30),
        corner=8,
        bgt=0.08,
        order=3,
        z=15
    })

    clearBtn.MouseButton1Click:Connect(function()
        clearTargets()
        targetBox.Text = ""
        Notif("X-Ray","Targets cleared","")
    end)

    MkToggle(P,"PLAYER X-RAY (MULTI TARGET)",4,
        function()
            if next(ESPTargets) == nil then
                Notif("X-Ray","Enter one or more usernames first","warn")
                return
            end
            ESPEnabled = true
            refreshESP()
            Notif("X-Ray","Multi-target X-Ray enabled","ok")
        end,
        function()
            ESPEnabled = false
            refreshESP()
            Notif("X-Ray","Off","")
        end
    )

    RegKB("Player X-Ray",Enum.KeyCode.O,function()
        if ESPEnabled then
            ESPEnabled = false
            refreshESP()
            Notif("X-Ray","Off","")
        else
            if next(ESPTargets) == nil then
                Notif("X-Ray","Enter one or more usernames first","warn")
            else
                ESPEnabled = true
                refreshESP()
                Notif("X-Ray","Showing "..tostring(#findAllTargets(targetBox.Text)).." selected target(s)","ok")
            end
        end
    end)

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            if ESPEnabled and isSelected(player) then
                task.wait(0.2)
                addESP(player)
            end
        end)
    end)

    for _,player in ipairs(Players:GetPlayers()) do
        if player ~= lp then
            player.CharacterAdded:Connect(function()
                if ESPEnabled and isSelected(player) then
                    task.wait(0.2)
                    addESP(player)
                end
            end)
        end
    end

    Players.PlayerRemoving:Connect(function(player)
        if isSelected(player) then
            ESPTargets[player] = nil
            removeESP(player)
            if next(ESPTargets) == nil then
                ESPEnabled = false
            end
        end
    end)
end

--[[
 ════════════════════════════════════════════════════════
   CLAUDE KORBLOX + HEADLESS / SPAM GRAB / RESET
   Everything in this tab is manual and OFF by default.
 ════════════════════════════════════════════════════════
--]]
do
    local P = tabPanels[8]
    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local LP = Players.LocalPlayer

    local HEAD_ID = 99223542650102
    local FIRE_HORN_ID = 215718515
    local ICE_HORN_ID = 74891470
    local TOXIC_HORN_ID = 1744060292
    local EIGHT_BIT_CROWN_ID = 10159600649
    local KORBLOX_ID = 139607718
    -- Birthday Time Fedora (Roblox catalog item)
    local BF_ID = 10970896657 -- Black Fedora
    local BIRTHDAY_FEDORA_ID = 116109904627748 -- Birthday Time Fedora
    local SPARKLE_TIME_FEDORA_ID = 1285307 -- Sparkle Time Fedora
    local PURPLE_SPARKLE_TIME_FEDORA_ID = 63043890
    local RED_SPARKLE_TIME_FEDORA_ID = 72082328
    local GREEN_SPARKLE_TIME_FEDORA_ID = 100929604
    local MIDNIGHT_BLUE_SPARKLE_TIME_FEDORA_ID = 119916949
    local TEAL_SPARKLE_TIME_FEDORA_ID = 147180077
    local ORANGE_SPARKLE_TIME_FEDORA_ID = 215751161
    local BLACK_SPARKLE_TIME_FEDORA_ID = 259423244
    local PINK_SPARKLE_TIME_FEDORA_ID = 334663683
    local SKY_BLUE_SPARKLE_TIME_FEDORA_ID = 493476042
    local WHITE_SPARKLE_TIME_FEDORA_ID = 1016143686
    local GREEN_NIGHTMARE_FACE_ID = 16114799446 -- Green Nightmare Face
    local PURPLE_VALK_ID = 1402432199 -- Violet Valkyrie
    local ICE_VALK_ID = 4390891467 -- Ice Valkyrie

    local claudeEnabled = false
    local savedDescription = nil
    local hornsCache = {}
    -- Keep every selected head accessory instead of replacing the previous one.
    -- Keys are asset IDs; values are display labels.
    local equippedCosmetics = {}
    local selectedHornId = nil
    local selectedHornName = nil
    local spamGrabOn = false
    local saveOriginalDescription

    local function getHumanoid()
        local char = LP.Character
        return char and char:FindFirstChildOfClass("Humanoid")
    end

    local function getEquippedCosmeticIds()
        local ids = {}
        for id in pairs(equippedCosmetics) do
            ids[#ids + 1] = tonumber(id) or id
        end
        table.sort(ids, function(a,b) return tostring(a) < tostring(b) end)
        return ids
    end

    local function removeLocalCosmetic(id)
        local char = LP.Character
        if not char then return end
        local sid = tostring(id)
        for _, c in ipairs(char:GetChildren()) do
            if (c:IsA("Accessory") or c:IsA("Hat")) and c:GetAttribute("_claudeAssetId") == sid then
                pcall(function() c:Destroy() end)
            end
        end
    end

    -- 8 BIT CROWN particle-only mode:
    -- Hide only the crown's visible geometry locally while leaving ParticleEmitters,
    -- Beams and Trails enabled. LocalTransparencyModifier is used so the particles
    -- themselves are not disabled.
    local function hide8BitCrownGeometry()
        local char = LP.Character
        if not char then return end

        for _, acc in ipairs(char:GetChildren()) do
            if acc:IsA("Accessory") or acc:IsA("Hat") then
                local sid = acc:GetAttribute("_claudeAssetId")
                local looksLikeCrown = tostring(sid) == tostring(EIGHT_BIT_CROWN_ID)
                    or acc.Name:lower():find("8.?bit", 1, false)
                    or acc.Name:lower():find("crown", 1, true)

                if looksLikeCrown then
                    for _, obj in ipairs(acc:GetDescendants()) do
                        if obj:IsA("BasePart") then
                            pcall(function()
                                obj.LocalTransparencyModifier = 1
                            end)
                        elseif obj:IsA("Decal") or obj:IsA("Texture") then
                            pcall(function()
                                obj.Transparency = 1
                            end)
                        elseif obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                            pcall(function()
                                obj.Enabled = true
                            end)
                        end
                    end
                end
            end
        end
    end

    local function removeClaudeHorns(char)
        char = char or LP.Character
        if not char then return end
        for _, c in ipairs(char:GetChildren()) do
            if (c:IsA("Accessory") or c:IsA("Hat")) and c:GetAttribute("_claudeHorns") == true then
                pcall(function() c:Destroy() end)
            end
        end
    end

    local function loadAsset(id)
        if hornsCache[id] then return hornsCache[id] end
        local obj
        pcall(function()
            local list = game:GetObjects("rbxassetid://" .. tostring(id))
            if not list or #list == 0 then return end
            local root = list[1]
            obj = (root:IsA("Accessory") or root:IsA("Hat")) and root
                or root:FindFirstChildWhichIsA("Accessory", true)
                or root:FindFirstChildWhichIsA("Hat", true)
        end)
        if obj then hornsCache[id] = obj end
        return obj
    end

    local function sendCatalogAccessory(id, propertyName)
        propertyName = propertyName or "HatAccessory"
        local accessoryType = (propertyName == "FaceAccessory") and Enum.AccessoryType.Face or Enum.AccessoryType.Hat
        local remote = RS:FindFirstChild("CatalogOnApplyToRealHumanoid", true)
        if not remote then return false end

        -- Fire the server request immediately so supported experiences can update
        -- the real/server-side avatar without waiting for the local rebuild.
        local sent = pcall(function()
            remote:FireServer({
                AccessoryData = {
                    Order = 1,
                    AccessoryType = accessoryType,
                    AssetId = id,
                },
            })
            remote:FireServer({Property=propertyName, AssetId=id})
        end)

        -- A couple of very short retries handle experiences that process the
        -- catalog remote asynchronously. These do not block the first application.
        if sent then
            task.spawn(function()
                for attempt = 1, 2 do
                    task.wait(0.08)
                    pcall(function()
                        remote:FireServer({
                            AccessoryData = {
                                Order = 1,
                                AccessoryType = accessoryType,
                                AssetId = id,
                            },
                        })
                        remote:FireServer({Property=propertyName, AssetId=id})
                    end)
                end
            end)
        end
        return sent
    end

    local function cosmeticProperty(id)
        if tonumber(id) == tonumber(GREEN_NIGHTMARE_FACE_ID) then
            return "FaceAccessory"
        end
        return "HatAccessory"
    end

    local ensureAccessoryLocally

    local function rebuildCosmeticsDescription()
        local hum = getHumanoid()
        if not hum then return false end
        local desc
        local ok, current = pcall(function() return hum:GetAppliedDescription() end)
        if ok and current then
            desc = current
        elseif savedDescription then
            desc = savedDescription:Clone()
        else
            return false
        end

        local ids = getEquippedCosmeticIds()

        -- Pumpkin Head is designed to be used with the Headless head so the
        -- normal Roblox head does not stick out behind the pumpkin.
        if equippedCosmetics[GREEN_NIGHTMARE_FACE_ID] then
            pcall(function() desc.Head = HEAD_ID end)
        end

        -- Keep hat/head accessories and face accessories in their correct
        -- HumanoidDescription slots. Face accessories must NOT be put into
        -- HatAccessory or Roblox can silently ignore them.
        local function rebuildSlot(propertyName)
            local seen = {}
            local existing = tostring(desc[propertyName] or "")
            local parts = {}
            for token in existing:gmatch("%d+") do
                seen[token] = true
                parts[#parts + 1] = token
            end
            for _, id in ipairs(ids) do
                if cosmeticProperty(id) == propertyName then
                    local sid = tostring(id)
                    if not seen[sid] then
                        parts[#parts + 1] = sid
                        seen[sid] = true
                    end
                end
            end
            desc[propertyName] = table.concat(parts, ",")
        end

        rebuildSlot("HatAccessory")
        rebuildSlot("FaceAccessory")

        -- Reset application is important here because Roblox documents it as the
        -- method that forces the character to match the supplied description even
        -- after other code has changed the character.
        local applied = pcall(function()
            hum:ApplyDescriptionResetAsync(desc, Enum.AssetTypeVerification.Default)
        end)

        -- ApplyDescriptionResetAsync can replace locally-added accessory instances.
        -- Re-add every selected cosmetic after the reset so the local avatar never
        -- loses an item that was just selected.
        if applied then
            task.defer(function()
                for eid, name in pairs(equippedCosmetics) do
                    ensureAccessoryLocally(tonumber(eid) or eid, name)
                end
                if equippedCosmetics[EIGHT_BIT_CROWN_ID] then
                    hide8BitCrownGeometry()
                end
            end)
        end
        return applied
    end

    ensureAccessoryLocally = function(id, label)
        local char = LP.Character
        local hum = getHumanoid()
        if not char or not hum then return false end
        local sid = tostring(id)
        for _, c in ipairs(char:GetChildren()) do
            if c:IsA("Accessory") and c:GetAttribute("_claudeAssetId") == sid then
                return true
            end
        end

        local src = loadAsset(id)
        if not src then return false end
        local added = false
        pcall(function()
            local clone = src:Clone()
            clone.Name = "CLAUDE_" .. tostring(label):gsub("%s+", "_")
            clone:SetAttribute("_claudeHorns", true)
            clone:SetAttribute("_claudeAssetId", sid)
            hum:AddAccessory(clone)
            added = true
        end)
        return added
    end

    local function applyHead()
        local hum = getHumanoid()
        if not hum then return false end
        for attempt = 1, 3 do
            pcall(function()
                local r = RS:FindFirstChild("CatalogOnApplyToRealHumanoid", true)
                if r then r:FireServer({Property="Head", AssetId=HEAD_ID}) end
            end)
            if attempt < 3 then task.wait(0.06) end
        end
        local ok = pcall(function()
            local desc = hum:GetAppliedDescription()
            desc.Head = HEAD_ID
            hum:ApplyDescriptionResetAsync(desc, Enum.AssetTypeVerification.Default)
        end)
        return ok
    end

    local function removeHeadGlow()
        local char = LP.Character
        if not char then return end
        local head = char:FindFirstChild("Head")
        if head then
            for _, obj in ipairs(head:GetDescendants()) do
                if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("ParticleEmitter")
                    or obj:IsA("Beam") or obj:IsA("Trail") then
                    pcall(function() obj.Enabled = false end)
                    pcall(function() obj.Transparency = 1 end)
                end
            end
        end
        for _, obj in ipairs(char:GetDescendants()) do
            local n = obj.Name:lower()
            if n:find("eye") or n:find("glow") then
                if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                    pcall(function() obj.Enabled = false end)
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    pcall(function() obj.Transparency = 1 end)
                end
            end
        end
    end

    local function applyHeadNoGlow()
        applyHead()
        task.defer(removeHeadGlow)
        task.delay(0.2, removeHeadGlow)
        task.delay(0.6, removeHeadGlow)
    end

    local function applyKorbloxLeg()
        local hum = getHumanoid()
        if not hum then return false end
        for attempt = 1, 3 do
            pcall(function()
                local r = RS:FindFirstChild("CatalogOnApplyToRealHumanoid", true)
                if r then r:FireServer({Property="RightLeg", AssetId=KORBLOX_ID}) end
            end)
            if attempt < 3 then task.wait(0.06) end
        end
        local ok = pcall(function()
            local desc = hum:GetAppliedDescription()
            desc.RightLeg = KORBLOX_ID
            hum:ApplyDescriptionResetAsync(desc, Enum.AssetTypeVerification.Default)
        end)
        return ok
    end

    local cosmeticApplyBusy = false
    local function applyCustomHorn(id, label, propertyName)
        local hum = getHumanoid()
        local char = LP.Character
        if not hum or not char then
            Notif("Cosmetics", "No humanoid found", "err")
            return false
        end

        if cosmeticApplyBusy then
            return false
        end
        cosmeticApplyBusy = true

        local success = false
        local ok, err = pcall(function()
            if not savedDescription then
                if not (saveOriginalDescription and saveOriginalDescription()) then
                    error("Could not save avatar")
                end
            end

            -- Keep every cosmetic already selected. Never clear the previous item
            -- just because a new one was clicked.
            equippedCosmetics[id] = label
            selectedHornId = id
            selectedHornName = label

            -- First ask the experience's own avatar/catalog remote to apply it.
            -- This is the only route here that can make the change server-visible.
            propertyName = propertyName or cosmeticProperty(id)
            sendCatalogAccessory(id, propertyName)

            -- Pumpkin Head is a face accessory but should look headless. Ask the
            -- experience's avatar remote for the Headless head as part of the same apply.
            if tonumber(id) == tonumber(GREEN_NIGHTMARE_FACE_ID) then
                pcall(function()
                    local r = RS:FindFirstChild("CatalogOnApplyToRealHumanoid", true)
                    if r then r:FireServer({Property="Head", AssetId=HEAD_ID}) end
                end)
            end

            -- Then force the complete appearance locally. Roblox recommends the
            -- Reset variant when external character changes may have occurred.
            local current = hum:GetAppliedDescription()
            if tonumber(id) == tonumber(GREEN_NIGHTMARE_FACE_ID) then
                current.Head = HEAD_ID
            end
            local function addEquippedToSlot(slotName)
                local existing = tostring(current[slotName] or "")
                local seen, parts = {}, {}
                for token in existing:gmatch("%d+") do
                    seen[token] = true
                    parts[#parts + 1] = token
                end
                for eid in pairs(equippedCosmetics) do
                    if cosmeticProperty(eid) == slotName then
                        local sid2 = tostring(eid)
                        if not seen[sid2] then
                            parts[#parts + 1] = sid2
                            seen[sid2] = true
                        end
                    end
                end
                current[slotName] = table.concat(parts, ",")
            end
            addEquippedToSlot("HatAccessory")
            addEquippedToSlot("FaceAccessory")
            hum:ApplyDescriptionResetAsync(current, Enum.AssetTypeVerification.Default)

            -- Reset application may replace manual accessory instances, so restore
            -- every selected cosmetic instance after the description is applied.
            for eid, name in pairs(equippedCosmetics) do
                ensureAccessoryLocally(tonumber(eid) or eid, name)
            end

            -- 8 BIT CROWN is particle-only on the local avatar.
            if id == EIGHT_BIT_CROWN_ID then
                task.defer(hide8BitCrownGeometry)
                task.delay(0.08, hide8BitCrownGeometry)
                task.delay(0.25, hide8BitCrownGeometry)
                task.delay(0.6, hide8BitCrownGeometry)
            end

            success = true
        end)

        cosmeticApplyBusy = false
        if not ok then
            Notif("Cosmetics", "Could not equip " .. tostring(label), "err")
            return false
        end

        Notif("Cosmetics", label .. ": APPLIED!", "ok")
        return success
    end

    local function removeCustomCosmetic(id)
        equippedCosmetics[id] = nil
        removeLocalCosmetic(id)
        rebuildCosmeticsDescription()
        if selectedHornId == id then
            selectedHornId = nil
            selectedHornName = nil
            for eid, name in pairs(equippedCosmetics) do
                selectedHornId = tonumber(eid) or eid
                selectedHornName = name
                break
            end
        end
    end

    local function clearCustomHorn()
        for id in pairs(equippedCosmetics) do
            removeLocalCosmetic(id)
        end
        equippedCosmetics = {}
        selectedHornId = nil
        selectedHornName = nil
        local hum = getHumanoid()
        if hum and savedDescription then
            pcall(function()
                hum:ApplyDescriptionResetAsync(savedDescription:Clone(), Enum.AssetTypeVerification.Default)
            end)
        end
    end

    saveOriginalDescription = function()
        local hum = getHumanoid()
        if not hum then return false end
        local ok, desc = pcall(function() return hum:GetAppliedDescription() end)
        if ok and desc then
            savedDescription = desc:Clone()
            return true
        end
        return false
    end

    local function restoreOriginal()
        removeClaudeHorns()
        local hum = getHumanoid()
        if hum and savedDescription then
            pcall(function() hum:ApplyDescription(savedDescription:Clone()) end)
        end
    end

    local function enableClaude()
        if claudeEnabled then return end
        if not saveOriginalDescription() then
            Notif("Unknown", "Could not save avatar", "err")
            return
        end
        claudeEnabled = true
        applyHeadNoGlow()
        task.wait(0.15)
        applyKorbloxLeg()
        Notif("Unknown", "Korblox + Headless: ON", "ok")
    end

    local function disableClaude()
        if not claudeEnabled then return end
        claudeEnabled = false
        restoreOriginal()
        savedDescription = nil
        selectedHornId = nil
        selectedHornName = nil
        Notif("Unknown", "Korblox + Headless: OFF", "")
        if refreshHornButtons then refreshHornButtons() end
    end

    local function fireGrab()
        pcall(function()
            if RF.Grab then RF.Grab:InvokeServer() end
        end)
    end

    local function setSpamGrab(state, source)
        spamGrabOn = state
        if state then
            task.spawn(function()
                while spamGrabOn do
                    fireGrab()
                    task.wait(0.005)
                end
            end)
            Notif("Spam Grab", source or "Active", "ok")
        else
            Notif("Spam Grab", "Off", "")
        end
    end

    MkSep(P, "UNKNOWN", 1)
    -- Two radial menus: one for avatar items and one for utility actions.
    -- The button below opens both; TAB also toggles both.
    local circleOpen = false
    local CircleGui = Instance.new("Frame", GUI)
    CircleGui.Name = "ClaudeCircleMenu"
    CircleGui.Size = UDim2.fromOffset(360, 360)
    CircleGui.Position = UDim2.new(0.28, 0, 0.5, 0)
    CircleGui.AnchorPoint = Vector2.new(0.5, 0.5)
    CircleGui.BackgroundTransparency = 1
    CircleGui.Visible = false
    CircleGui.ZIndex = 8000

    local CircleBg = Instance.new("Frame", CircleGui)
    CircleBg.Size = UDim2.fromOffset(300, 300)
    CircleBg.Position = UDim2.new(0.5, 0, 0.5, 0)
    CircleBg.AnchorPoint = Vector2.new(0.5, 0.5)
    CircleBg.BackgroundColor3 = T.BG
    CircleBg.BackgroundTransparency = 0.08
    CircleBg.BorderSizePixel = 0
    CircleBg.ZIndex = 8000
    Cnr(CircleBg, 150)
    Strk(CircleBg, T.ACCENT, 2, 0.15)

    local CircleTitle = MkLabel(CircleBg, {
        text="AVATAR", size=11, color=T.TEXT, font=Bold,
        sz=UDim2.new(1, -40, 0, 18), pos=UDim2.new(0, 20, 0, 22),
        xa=Enum.TextXAlignment.Center, z=8002
    })

    local CircleStatus = MkLabel(CircleBg, {
        text="8 BIT • HORNS • HEADLESS • KORBLOX • FEDORA", size=8, color=T.MUTED, font=Reg,
        sz=UDim2.new(1, -50, 0, 16), pos=UDim2.new(0, 25, 1, -38),
        xa=Enum.TextXAlignment.Center, z=8002
    })

    local CircleClose = MkBtn(CircleBg, {
        bg=T.RAISED, text="×", size=18, color=T.TEXT,
        sz=UDim2.fromOffset(42, 42), pos=UDim2.new(0.5, -21, 0.5, -21),
        corner=21, bgt=0.05, z=8010
    })

    -- Drag support: drag the circle by its title area.
    local UIS = game:GetService("UserInputService")

    local function makeCircleDraggable(gui, bg, zIndex)
        local handle = Instance.new("Frame")
        handle.Name = "DragHandle"
        handle.Parent = bg
        handle.Size = UDim2.new(1, -70, 0, 48)
        handle.Position = UDim2.new(0, 35, 0, 8)
        handle.BackgroundTransparency = 1
        handle.BorderSizePixel = 0
        handle.Active = true
        handle.ZIndex = zIndex

        local dragging = false
        local dragInput = nil
        local dragStart = nil
        local startPos = nil

        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragInput = input
                dragStart = input.Position
                startPos = gui.Position
            end
        end)

        handle.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if not dragging or input ~= dragInput then return end
            local delta = input.Position - dragStart
            local camera = workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize
            if not viewport or viewport.X <= 0 or viewport.Y <= 0 then return end

            local nx = startPos.X.Offset + delta.X
            local ny = startPos.Y.Offset + delta.Y
            local halfX = gui.AbsoluteSize.X * 0.5
            local halfY = gui.AbsoluteSize.Y * 0.5
            local limitX = math.max(0, viewport.X * 0.5 - halfX)
            local limitY = math.max(0, viewport.Y * 0.5 - halfY)

            nx = math.clamp(nx, -limitX, limitX)
            ny = math.clamp(ny, -limitY, limitY)
            gui.Position = UDim2.new(0.5, nx, 0.5, ny)
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                dragInput = nil
            end
        end)
    end

    makeCircleDraggable(CircleGui, CircleBg, 8003)

    -- Avatar circle: accessories only.
    local CircleItems = {
        {name="Crown",   text="8 BIT",    action="crown", image="rbxthumb://type=Asset&id=10159600649&w=150&h=150"},
        {name="Horns",   text="HORNS",    action="horns", image="rbxthumb://type=Asset&id=215718515&w=150&h=150"},
        {name="Headless",text="HEADLESS", action="head",   image="rbxthumb://type=Asset&id=99223542650102&w=150&h=150"},
        {name="Korblox", text="KORBLOX",  action="leg",   image="rbxthumb://type=Asset&id=139607718&w=150&h=150"},
        {name="Fedora",  text="FEDORA",   action="fedora", image="rbxthumb://type=Asset&id=10970896657&w=150&h=150"},
    }

    -- COMBAT menu: the avatar circle stays cosmetic-only.
    -- These are opened from the COMBAT button underneath the cosmetic circle.
    local UtilityItems = {
        {name="AuraKill",   text="AURA KILL", action="aura"},
        {name="TPWalk",    text="TP WALK",  action="tpwalk"},
        {name="SpamGrab",  text="SPAM GRAB", action="spam"},
        {name="Invisible", text="GHOST",     action="invisible"},
    }

    local CircleButtons = {}
    local UtilityButtons = {}
    local circleRadius = 100
    local circleButtonSize = 64

    local function circlePosition(index, total)
        local angle = math.rad(-90 + ((index - 1) / total) * 360)
        return UDim2.new(0.5, math.cos(angle) * circleRadius - circleButtonSize / 2,
            0.5, math.sin(angle) * circleRadius - circleButtonSize / 2)
    end

    local function updateCircle()
        local fullOn = getClaudeToggleState()
        local auraOn = _G.CLX_KillAuraOn == true
        local tpWalkOn = _G.CLX_tpwOn == true
        local invisibleOn = _G.CLX_InvisibleOn == true
        CircleStatus.Text = string.format(
            "HEADLESS:%s  •  KORBLOX:%s  •  ACCESSORY:%s",
            "READY",
            "READY",
            selectedHornName or "NONE"
        )
        CircleStatus.TextColor3 = selectedHornId and T.ON or T.MUTED
        local fullButton = CircleButtons.CLAUDE
        if fullButton then
            fullButton.BackgroundColor3 = fullOn and T.ON or T.RAISED
            fullButton.TextColor3 = fullOn and T.BG or T.TEXT
        end
        local spamButton = CircleButtons.SpamGrab
        if spamButton then
            spamButton.BackgroundColor3 = spamGrabOn and T.ON or T.RAISED
            spamButton.TextColor3 = spamGrabOn and T.BG or T.TEXT
        end

    end

    -- COMBAT panel: separate from the cosmetic circle so both never show at once.
    local UtilityCircleGui = Instance.new("Frame", GUI)
    UtilityCircleGui.Name = "ClaudeCombatPanel"
    UtilityCircleGui.Size = UDim2.fromOffset(360, 340)
    UtilityCircleGui.Position = UDim2.new(0.28, 0, 0.5, 0)
    UtilityCircleGui.AnchorPoint = Vector2.new(0.5, 0.5)
    UtilityCircleGui.BackgroundTransparency = 1
    UtilityCircleGui.Visible = false
    UtilityCircleGui.ZIndex = 7900

    local UtilityCircleBg = Instance.new("Frame", UtilityCircleGui)
    UtilityCircleBg.Size = UDim2.fromScale(1, 1)
    UtilityCircleBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    UtilityCircleBg.BackgroundTransparency = 0.02
    UtilityCircleBg.BorderSizePixel = 0
    UtilityCircleBg.ZIndex = 7900
    Cnr(UtilityCircleBg, 14)
    Strk(UtilityCircleBg, Color3.fromRGB(217,119,87), 1, 0.45)

    -- Console static motes behind the combat buttons.
    do
        local rng = Random.new(8127)
        for i = 1, 120 do
            local star = Instance.new("TextLabel", UtilityCircleBg)
            star.Name = "GalaxyStar" .. i
            star.BackgroundTransparency = 1
            star.Text = (i % 9 == 0) and "✦" or ((i % 3 == 0) and "·" or "*")
            star.TextColor3 = Color3.fromRGB(238,232,224)
            star.TextTransparency = rng:NextNumber(0.18, 0.72)
            star.FontFace = Reg
            star.TextSize = rng:NextInteger(7, 14)
            star.Size = UDim2.fromOffset(16, 16)
            star.Position = UDim2.new(rng:NextNumber(0.02, 0.96), 0, rng:NextNumber(0.02, 0.96), 0)
            star.ZIndex = 7901
        end
    end

    MkLabel(UtilityCircleBg, {
        text="> COMBAT CONTROLS", size=12, color=Color3.fromRGB(238,232,224), font=Bold,
        sz=UDim2.new(1, -60, 0, 22), pos=UDim2.new(0, 30, 0, 12),
        xa=Enum.TextXAlignment.Center, z=7904
    })

    local UtilityCircleStatus = MkLabel(UtilityCircleBg, {
        text="ALL OFF", size=7, color=Color3.fromRGB(96,86,78), font=Reg,
        sz=UDim2.new(1, -80, 0, 14), pos=UDim2.new(0, 40, 1, -25),
        xa=Enum.TextXAlignment.Center, z=7904
    })

    local UtilityClose = MkBtn(UtilityCircleBg, {
        bg=Color3.fromRGB(12,10,9), text="×", size=14, color=Color3.fromRGB(238,232,224),
        sz=UDim2.fromOffset(30, 30), pos=UDim2.new(1, -40, 0, 8),
        corner=8, bgt=0.02, z=7910
    })

    local CombatOpenButton

    local CombatButtons = {}
    local utilityButtonSize = 54
    local utilityButtonWidth = 300
    local function utilityPosition(index, total)
        return UDim2.new(0.5, -utilityButtonWidth/2, 0, 48 + (index-1)*68)
    end

    local function setUtilityButtonText(button, label, on)
        if not button then return end
        button.Text = "> " .. label .. " " .. (on and "ON" or "OFF")
        button.TextColor3 = on and Color3.fromRGB(110,196,140) or Color3.fromRGB(160,148,138)
        button.BackgroundColor3 = Color3.fromRGB(0,0,0)
    end

    local function updateUtilityCircle()
        local invisOn = _G.CLX_InvisibleOn == true
        local auraOn = _G.CLX_KillAuraOn == true
        local tpOn = _G.CLX_tpwOn == true
        setUtilityButtonText(CombatButtons.AuraKill, "AURA KILL", auraOn)
        setUtilityButtonText(CombatButtons.TPWalk, "TP WALK", tpOn)
        setUtilityButtonText(CombatButtons.SpamGrab, "SPAM GRAB", spamGrabOn)
        setUtilityButtonText(CombatButtons.Invisible, "GHOST", invisOn)
        local count = 0
        if spamGrabOn then count += 1 end
        if invisOn then count += 1 end
        if auraOn then count += 1 end
        if tpOn then count += 1 end
        UtilityCircleStatus.Text = count == 0 and "ALL OFF" or (tostring(count) .. " ACTIVE")
        UtilityCircleStatus.TextColor3 = Color3.fromRGB(255,255,255)
    end

    local hornCircleOpen = false
    local HornCircleGui
    local fedoraCircleOpen = false
    local FedoraCircleGui
    local CosmeticsPanelGui
    local setCosmeticsPanelVisible
    local updateCosmeticsPanel

    local function setCircleVisible(state)
        circleOpen = state
        CircleGui.Visible = false
        UtilityCircleGui.Visible = false
        if CombatOpenButton then CombatOpenButton.Visible = false end
        if HornCircleGui then HornCircleGui.Visible = false end
        if FedoraCircleGui then FedoraCircleGui.Visible = false end
        hornCircleOpen = false
        fedoraCircleOpen = false
        if setCosmeticsPanelVisible then
            setCosmeticsPanelVisible(state)
        end
    end

    local function setCombatVisible(state)
        UtilityCircleGui.Visible = state
        if state then
            CircleGui.Visible = false
            if CosmeticsPanelGui then CosmeticsPanelGui.Visible = false end
            if CombatOpenButton then CombatOpenButton.Visible = false end
            if HornCircleGui then HornCircleGui.Visible = false end
            if FedoraCircleGui then FedoraCircleGui.Visible = false end
            hornCircleOpen = false
            fedoraCircleOpen = false
            updateUtilityCircle()
        else
            CircleGui.Visible = false
            if CosmeticsPanelGui and circleOpen then
                CosmeticsPanelGui.Visible = true
                if updateCosmeticsPanel then updateCosmeticsPanel() end
            end
        end
    end

    for index, data in ipairs(UtilityItems) do
        local b = MkBtn(UtilityCircleBg, {
            bg=Color3.fromRGB(0,0,0), text="★  " .. data.text .. "  ★", size=8, color=Color3.fromRGB(255,255,255),
            sz=UDim2.fromOffset(utilityButtonWidth, utilityButtonSize),
            pos=utilityPosition(index, #UtilityItems), anchor=Vector2.new(0,0),
            corner=8, bgt=0.02, z=7905
        })
        CombatButtons[data.name] = b
        b.MouseButton1Click:Connect(function()
            if data.action == "spam" then
                setSpamGrab(not spamGrabOn, "Combat")
            elseif data.action == "invisible" then
                local newState = not (_G.CLX_InvisibleOn == true)
                if _G.CLX_SetInvisible then
                    _G.CLX_SetInvisible(newState, "Ghost Mode")
                else
                    Notif("Ghost", "Ghost Mode is not ready yet", "warn")
                end
            elseif data.action == "aura" then
                local newState = not (_G.CLX_KillAuraOn == true)
                _G.CLX_KillAuraOn = newState
                if _G.CLX_SetKillAura then
                    _G.CLX_SetKillAura(newState)
                else
                    Notif("Kill Aura", "Kill Aura is not ready yet", "warn")
                end
            elseif data.action == "tpwalk" then
                local newState = not (_G.CLX_tpwOn == true)
                if _G.CLX_SetTPWalk then
                    _G.CLX_SetTPWalk(newState)
                else
                    Notif("TPWalk", "TP Walk is not ready yet", "warn")
                end
            end
            updateUtilityCircle()
        end)
    end

    UtilityClose.MouseButton1Click:Connect(function()
        setCombatVisible(false)
    end)

    CombatOpenButton = MkBtn(CircleGui, {
        bg=Color3.fromRGB(0,0,0), text="★  COMBAT  ★", size=10, color=Color3.fromRGB(255,255,255),
        sz=UDim2.fromOffset(190, 48), pos=UDim2.new(0.5, -95, 1, 12),
        anchor=Vector2.new(0, 0), corner=10, bgt=0.02, z=8050
    })
    CombatOpenButton.Visible = false
    CombatOpenButton.MouseButton1Click:Connect(function()
        setCombatVisible(true)
    end)

    -- COSMETICS PANEL: same black/white layout as COMBAT, but every cosmetic
    -- is a single horizontal card with an image, name and ON/OFF toggle.
    -- The ScrollingFrame handles mouse-wheel/touch scrolling automatically.
    CosmeticsPanelGui = Instance.new("Frame", GUI)
    CosmeticsPanelGui.Name = "ClaudeCosmeticsPanel"
    CosmeticsPanelGui.Size = UDim2.fromOffset(380, 470)
    CosmeticsPanelGui.Position = UDim2.new(0.28, 0, 0.5, 0)
    CosmeticsPanelGui.AnchorPoint = Vector2.new(0.5, 0.5)
    CosmeticsPanelGui.BackgroundTransparency = 1
    CosmeticsPanelGui.Visible = false
    CosmeticsPanelGui.ZIndex = 7950

    local CosmeticsPanelBg = Instance.new("Frame", CosmeticsPanelGui)
    CosmeticsPanelBg.Size = UDim2.fromScale(1, 1)
    CosmeticsPanelBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CosmeticsPanelBg.BackgroundTransparency = 0.02
    CosmeticsPanelBg.BorderSizePixel = 0
    CosmeticsPanelBg.ZIndex = 7950
    Cnr(CosmeticsPanelBg, 14)
    Strk(CosmeticsPanelBg, Color3.fromRGB(255,255,255), 1, 0.45)

    MkLabel(CosmeticsPanelBg, {
        text="★  COSMETICS  ★", size=12, color=Color3.fromRGB(255,255,255), font=Bold,
        sz=UDim2.new(1, -70, 0, 22), pos=UDim2.new(0, 35, 0, 12),
        xa=Enum.TextXAlignment.Center, z=7954
    })

    local CosmeticsPanelStatus = MkLabel(CosmeticsPanelBg, {
        text="ALL OFF", size=7, color=Color3.fromRGB(255,255,255), font=Reg,
        sz=UDim2.new(1, -90, 0, 14), pos=UDim2.new(0, 45, 0, 36),
        xa=Enum.TextXAlignment.Center, z=7954
    })

    local CosmeticsPanelClose = MkBtn(CosmeticsPanelBg, {
        bg=Color3.fromRGB(0,0,0), text="×", size=14, color=Color3.fromRGB(255,255,255),
        sz=UDim2.fromOffset(30, 30), pos=UDim2.new(1, -40, 0, 8),
        corner=8, bgt=0.02, z=7960
    })

    local CosmeticsScroll = Instance.new("ScrollingFrame", CosmeticsPanelBg)
    CosmeticsScroll.Name = "CosmeticsScroll"
    CosmeticsScroll.Size = UDim2.new(1, -24, 1, -112)
    CosmeticsScroll.Position = UDim2.new(0, 12, 0, 56)
    CosmeticsScroll.BackgroundTransparency = 1
    CosmeticsScroll.BorderSizePixel = 0
    CosmeticsScroll.ScrollBarThickness = 5
    CosmeticsScroll.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
    CosmeticsScroll.ScrollBarImageTransparency = 0.2
    CosmeticsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    CosmeticsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    CosmeticsScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    CosmeticsScroll.ZIndex = 7955

    local CosmeticsLayout = Instance.new("UIListLayout", CosmeticsScroll)
    CosmeticsLayout.Padding = UDim.new(0, 7)
    CosmeticsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local CosmeticsPadding = Instance.new("UIPadding", CosmeticsScroll)
    CosmeticsPadding.PaddingTop = UDim.new(0, 2)
    CosmeticsPadding.PaddingBottom = UDim.new(0, 6)
    CosmeticsPadding.PaddingLeft = UDim.new(0, 2)
    CosmeticsPadding.PaddingRight = UDim.new(0, 2)

    local CosmeticsCombatButton = MkBtn(CosmeticsPanelBg, {
        bg=Color3.fromRGB(0,0,0), text="★  COMBAT  ★", size=10, color=Color3.fromRGB(255,255,255),
        sz=UDim2.new(1, -24, 0, 42), pos=UDim2.new(0, 12, 1, -54),
        corner=9, bgt=0.02, z=7960
    })

    local CosmeticCards = {}
    local CosmeticEntries = {
        {key="Crown", text="8 BIT CROWN", id=EIGHT_BIT_CROWN_ID, image="rbxthumb://type=Asset&id=10159600649&w=150&h=150", kind="accessory"},
        {key="PumpkinHead", text="PUMPKIN HEAD", id=GREEN_NIGHTMARE_FACE_ID, image="rbxthumb://type=Asset&id=16114799446&w=150&h=150", kind="accessory"},
        {key="PurpleValk", text="PURPLE VALK", id=PURPLE_VALK_ID, image="rbxthumb://type=Asset&id=1402432199&w=150&h=150", kind="accessory"},
        {key="IceValk", text="ICE VALK", id=ICE_VALK_ID, image="rbxthumb://type=Asset&id=4390891467&w=150&h=150", kind="accessory"},
        {key="Ice", text="ICE HORNS", id=ICE_HORN_ID, image="rbxthumb://type=Asset&id=74891470&w=150&h=150", kind="accessory"},
        {key="Fire", text="FIRE HORNS", id=FIRE_HORN_ID, image="rbxthumb://type=Asset&id=215718515&w=150&h=150", kind="accessory"},
        {key="Toxic", text="TOXIC HORNS", id=TOXIC_HORN_ID, image="rbxthumb://type=Asset&id=1744060292&w=150&h=150", kind="accessory"},
        {key="Black", text="BLACK FEDORA", id=BF_ID, image="rbxthumb://type=Asset&id=10970896657&w=150&h=150", kind="accessory"},
        {key="Birthday", text="BIRTHDAY FEDORA", id=BIRTHDAY_FEDORA_ID, image="rbxthumb://type=Asset&id=116109904627748&w=150&h=150", kind="accessory"},
        {key="Sparkle", text="SPARKLE TIME", id=SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=1285307&w=150&h=150", kind="accessory"},
        {key="PurpleSparkle", text="PURPLE SPARKLE TIME", id=PURPLE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=63043890&w=150&h=150", kind="accessory"},
        {key="RedSparkle", text="RED SPARKLE TIME", id=RED_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=72082328&w=150&h=150", kind="accessory"},
        {key="GreenSparkle", text="GREEN SPARKLE TIME", id=GREEN_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=100929604&w=150&h=150", kind="accessory"},
        {key="MidnightBlueSparkle", text="MIDNIGHT BLUE SPARKLE TIME", id=MIDNIGHT_BLUE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=119916949&w=150&h=150", kind="accessory"},
        {key="TealSparkle", text="TEAL SPARKLE TIME", id=TEAL_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=147180077&w=150&h=150", kind="accessory"},
        {key="OrangeSparkle", text="ORANGE SPARKLE TIME", id=ORANGE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=215751161&w=150&h=150", kind="accessory"},
        {key="BlackSparkle", text="BLACK SPARKLE TIME", id=BLACK_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=259423244&w=150&h=150", kind="accessory"},
        {key="PinkSparkle", text="PINK SPARKLE TIME", id=PINK_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=334663683&w=150&h=150", kind="accessory"},
        {key="SkyBlueSparkle", text="SKY BLUE SPARKLE TIME", id=SKY_BLUE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=493476042&w=150&h=150", kind="accessory"},
        {key="WhiteSparkle", text="WHITE SPARKLE TIME", id=WHITE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=1016143686&w=150&h=150", kind="accessory"},
        {key="Headless", text="HEADLESS", id=HEAD_ID, image="rbxthumb://type=Asset&id=99223542650102&w=150&h=150", kind="head"},
        {key="Korblox", text="KORBLOX", id=KORBLOX_ID, image="rbxthumb://type=Asset&id=139607718&w=150&h=150", kind="leg"},
    }

    local function cosmeticIsOn(data)
        if data.kind == "accessory" then
            return equippedCosmetics[data.id] ~= nil
        elseif data.kind == "head" then
            local hum = getHumanoid()
            if not hum then return false end
            local ok, desc = pcall(function() return hum:GetAppliedDescription() end)
            return ok and desc and tonumber(desc.Head) == tonumber(HEAD_ID)
        elseif data.kind == "leg" then
            local hum = getHumanoid()
            if not hum then return false end
            local ok, desc = pcall(function() return hum:GetAppliedDescription() end)
            return ok and desc and tonumber(desc.RightLeg) == tonumber(KORBLOX_ID)
        end
        return false
    end

    local function removeCosmeticAccessory(data)
        if data.kind == "accessory" then
            removeCustomCosmetic(data.id)
            rebuildCosmeticsDescription()
            return true
        end

        local hum = getHumanoid()
        if not hum then return false end
        local base = savedDescription and savedDescription:Clone()
        if not base then
            local ok, current = pcall(function() return hum:GetAppliedDescription() end)
            if ok and current then base = current end
        end
        if not base then return false end

        if data.kind == "head" then
            -- Restore the original head while preserving all currently selected hats.
            local ok, current = pcall(function() return hum:GetAppliedDescription() end)
            if not ok or not current then return false end
            current.Head = base.Head
            return pcall(function()
                hum:ApplyDescriptionResetAsync(current, Enum.AssetTypeVerification.Default)
            end)
        elseif data.kind == "leg" then
            local ok, current = pcall(function() return hum:GetAppliedDescription() end)
            if not ok or not current then return false end
            current.RightLeg = base.RightLeg
            return pcall(function()
                hum:ApplyDescriptionResetAsync(current, Enum.AssetTypeVerification.Default)
            end)
        end
        return false
    end

    local function refreshCosmeticCard(data)
        local entry = CosmeticCards[data.key]
        if not entry then return end
        local card = entry.Button
        local status = entry.Status
        local on = cosmeticIsOn(data)
        -- These are action buttons, not toggles. Always show APPLY.
        status.Text = "APPLY"
        status.TextColor3 = Color3.fromRGB(255,255,255)
        card.BackgroundColor3 = Color3.fromRGB(0,0,0)
        card:SetAttribute("On", on)
    end

    updateCosmeticsPanel = function()
        local count = 0
        for _, data in ipairs(CosmeticEntries) do
            refreshCosmeticCard(data)
            if cosmeticIsOn(data) then count += 1 end
        end
        CosmeticsPanelStatus.Text = "CLICK APPLY TO EQUIP"
        CosmeticsPanelStatus.TextColor3 = Color3.fromRGB(255,255,255)
    end

    for index, data in ipairs(CosmeticEntries) do
        local card = MkBtn(CosmeticsScroll, {
            bg=Color3.fromRGB(0,0,0), text="", size=8, color=Color3.fromRGB(255,255,255),
            sz=UDim2.new(1, -4, 0, 62), pos=UDim2.new(0,0,0,0),
            corner=8, bgt=0.02, z=7956
        })
        card.LayoutOrder = index

        local preview = Instance.new("ImageLabel", card)
        preview.Name = "CosmeticImage"
        preview.Size = UDim2.fromOffset(52, 52)
        preview.Position = UDim2.new(0, 5, 0.5, -26)
        preview.BackgroundTransparency = 1
        preview.Image = data.image
        preview.ScaleType = Enum.ScaleType.Fit
        preview.ZIndex = 7957

        local label = Instance.new("TextLabel", card)
        label.Name = "CosmeticName"
        label.Size = UDim2.new(1, -140, 0, 20)
        label.Position = UDim2.new(0, 68, 0.5, -10)
        label.BackgroundTransparency = 1
        label.Text = data.text
        label.FontFace = Bold
        label.TextSize = 10
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 7957

        local status = Instance.new("TextLabel", card)
        status.Name = "Status"
        status.Size = UDim2.fromOffset(54, 22)
        status.Position = UDim2.new(1, -62, 0.5, -11)
        status.BackgroundTransparency = 1
        status.Text = "APPLY"
        status.FontFace = Bold
        status.TextSize = 9
        status.TextColor3 = Color3.fromRGB(255,255,255)
        status.TextXAlignment = Enum.TextXAlignment.Center
        status.ZIndex = 7957

        CosmeticCards[data.key] = {Button=card, Status=status}

        card.MouseButton1Click:Connect(function()
            -- APPLY is an action, not a toggle. Pressing it always tries to equip
            -- the selected cosmetic again instead of removing it.
            local applied = false
            if data.kind == "accessory" then
                applied = applyCustomHorn(data.id, data.text, cosmeticProperty(data.id))
            elseif data.kind == "head" then
                if not savedDescription then
                    local hum = getHumanoid()
                    if hum then pcall(function() savedDescription = hum:GetAppliedDescription():Clone() end) end
                end
                applied = applyHeadNoGlow() ~= false
                task.delay(0.15, rebuildCosmeticsDescription)
            elseif data.kind == "leg" then
                if not savedDescription then
                    local hum = getHumanoid()
                    if hum then pcall(function() savedDescription = hum:GetAppliedDescription():Clone() end) end
                end
                applied = applyKorbloxLeg()
                task.delay(0.15, rebuildCosmeticsDescription)
            end
            if applied then
                Notif(data.text, data.text .. " APPLIED!", "ok")
            else
                Notif(data.text, "Could not apply this cosmetic", "err")
            end
            task.delay(0.08, updateCosmeticsPanel)
        end)
    end

    setCosmeticsPanelVisible = function(state)
        if not CosmeticsPanelGui then return end
        CosmeticsPanelGui.Visible = state
        UtilityCircleGui.Visible = false
        CircleGui.Visible = false
        if HornCircleGui then HornCircleGui.Visible = false end
        if FedoraCircleGui then FedoraCircleGui.Visible = false end
        hornCircleOpen = false
        fedoraCircleOpen = false
        if state then
            updateCosmeticsPanel()
        end
    end

    CosmeticsPanelClose.MouseButton1Click:Connect(function()
        circleOpen = false
        setCosmeticsPanelVisible(false)
    end)

    CosmeticsCombatButton.MouseButton1Click:Connect(function()
        setCombatVisible(true)
    end)

    -- Three extra circles that open when HORNS is pressed.
    HornCircleGui = Instance.new("Frame", GUI)
    HornCircleGui.Name = "ClaudeHornCircleMenu"
    HornCircleGui.Size = UDim2.fromOffset(340, 340)
    HornCircleGui.Position = UDim2.new(0.5, 0, 0.5, 0)
    HornCircleGui.AnchorPoint = Vector2.new(0.5, 0.5)
    HornCircleGui.BackgroundTransparency = 1
    HornCircleGui.Visible = false
    HornCircleGui.ZIndex = 8100

    local HornCircleBg = Instance.new("Frame", HornCircleGui)
    HornCircleBg.Size = UDim2.fromOffset(280, 280)
    HornCircleBg.Position = UDim2.new(0.5, 0, 0.5, 0)
    HornCircleBg.AnchorPoint = Vector2.new(0.5, 0.5)
    HornCircleBg.BackgroundColor3 = T.BG
    HornCircleBg.BackgroundTransparency = 0.08
    HornCircleBg.BorderSizePixel = 0
    HornCircleBg.ZIndex = 8100
    Cnr(HornCircleBg, 140)
    Strk(HornCircleBg, T.ACCENT, 2, 0.15)

    MkLabel(HornCircleBg, {
        text="HORNS + CROWN", size=11, color=T.TEXT, font=Bold,
        sz=UDim2.new(1, -40, 0, 18), pos=UDim2.new(0, 20, 0, 24),
        xa=Enum.TextXAlignment.Center, z=8102
    })

    local HornCircleStatus = MkLabel(HornCircleBg, {
        text="CHOOSE A HORN OR CROWN", size=8, color=T.MUTED, font=Reg,
        sz=UDim2.new(1, -50, 0, 16), pos=UDim2.new(0, 25, 1, -38),
        xa=Enum.TextXAlignment.Center, z=8102
    })

    local HornCircleClose = MkBtn(HornCircleBg, {
        bg=T.RAISED, text="×", size=18, color=T.TEXT,
        sz=UDim2.fromOffset(42, 42), pos=UDim2.new(0.5, -21, 0.5, -21),
        corner=21, bgt=0.05, z=8110
    })

    makeCircleDraggable(HornCircleGui, HornCircleBg, 8103)

    -- HORNS + CROWN submenu.
    -- ICE, FIRE and TOXIC are the horns; 8 BIT CROWN is the crown.
    -- The crown uses the same server-side accessory application path as the horns.
    local HornItems = {
        {name="Ice",    text="ICE HORNS",   id=ICE_HORN_ID,       image="rbxthumb://type=Asset&id=74891470&w=150&h=150"},
        {name="Fire",   text="FIRE HORNS",  id=FIRE_HORN_ID,      image="rbxthumb://type=Asset&id=215718515&w=150&h=150"},
        {name="Toxic",  text="TOXIC HORNS", id=TOXIC_HORN_ID,     image="rbxthumb://type=Asset&id=1744060292&w=150&h=150"},
        {name="Off",   text="OFF",          id=nil},
    }
    local HornButtons = {}
    local hornRadius = 108
    local hornButtonSize = 76

    local function hornPosition(index, total)
        local angle = math.rad(-90 + ((index - 1) / total) * 360)
        return UDim2.new(0.5, math.cos(angle) * hornRadius - hornButtonSize / 2,
            0.5, math.sin(angle) * hornRadius - hornButtonSize / 2)
    end

    local function updateHornCircle()
        for _, data in ipairs(HornItems) do
            local b = HornButtons[data.name]
            if b then
                local selected = (data.id ~= nil and selectedHornId == data.id)
                    or (data.name == "Off" and selectedHornId == nil)
                b.BackgroundColor3 = selected and T.ACCENT or T.RAISED
                b.TextColor3 = T.TEXT
            end
        end
        local count = 0
        for _ in pairs(equippedCosmetics) do count += 1 end
        HornCircleStatus.Text = count > 0 and (tostring(count) .. " COSMETIC(S) EQUIPPED") or "HORNS + CROWN OFF"
    end

    local function setHornCircleVisible(state)
        hornCircleOpen = state
        HornCircleGui.Visible = state
        CircleGui.Visible = not state and circleOpen
        UtilityCircleGui.Visible = false
        if CombatOpenButton then CombatOpenButton.Visible = not state and circleOpen end
        if state then
            updateHornCircle()
        end
    end

    FedoraCircleGui = Instance.new("Frame", GUI)
    FedoraCircleGui.Name = "ClaudeFedoraCircleMenu"
    FedoraCircleGui.Size = UDim2.fromOffset(340, 340)
    FedoraCircleGui.Position = UDim2.new(0.5, 0, 0.5, 0)
    FedoraCircleGui.AnchorPoint = Vector2.new(0.5, 0.5)
    FedoraCircleGui.BackgroundTransparency = 1
    FedoraCircleGui.Visible = false
    FedoraCircleGui.ZIndex = 8200

    local FedoraCircleBg = Instance.new("Frame", FedoraCircleGui)
    FedoraCircleBg.Size = UDim2.fromOffset(280, 280)
    FedoraCircleBg.Position = UDim2.new(0.5, 0, 0.5, 0)
    FedoraCircleBg.AnchorPoint = Vector2.new(0.5, 0.5)
    FedoraCircleBg.BackgroundColor3 = T.BG
    FedoraCircleBg.BackgroundTransparency = 0.08
    FedoraCircleBg.BorderSizePixel = 0
    FedoraCircleBg.ZIndex = 8200
    Cnr(FedoraCircleBg, 140)
    Strk(FedoraCircleBg, T.ACCENT, 2, 0.15)

    MkLabel(FedoraCircleBg, {
        text="FEDORAS", size=11, color=T.TEXT, font=Bold,
        sz=UDim2.new(1, -40, 0, 18), pos=UDim2.new(0, 20, 0, 22),
        xa=Enum.TextXAlignment.Center, z=8202
    })
    local FedoraCircleStatus = MkLabel(FedoraCircleBg, {
        text="BLACK • BIRTHDAY • SPARKLE TIME", size=8, color=T.MUTED, font=Reg,
        sz=UDim2.new(1, -40, 0, 16), pos=UDim2.new(0, 20, 1, -38),
        xa=Enum.TextXAlignment.Center, z=8202
    })
    local FedoraCircleClose = MkBtn(FedoraCircleBg, {
        bg=T.RAISED, text="×", size=18, color=T.TEXT,
        sz=UDim2.fromOffset(42, 42), pos=UDim2.new(0.5, -21, 0.5, -21),
        corner=21, bgt=0.05, z=8210
    })
    makeCircleDraggable(FedoraCircleGui, FedoraCircleBg, 8203)

    local FedoraItems = {
        {name="Black", text="BLACK FEDORA", id=BF_ID, image="rbxthumb://type=Asset&id=10970896657&w=150&h=150"},
        {name="Birthday", text="BIRTHDAY FEDORA", id=BIRTHDAY_FEDORA_ID, image="rbxthumb://type=Asset&id=116109904627748&w=150&h=150"},
        {name="Sparkle", text="SPARKLE TIME", id=SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=1285307&w=150&h=150"},
        {name="PurpleSparkle", text="PURPLE SPARKLE TIME", id=PURPLE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=63043890&w=150&h=150"},
        {name="RedSparkle", text="RED SPARKLE TIME", id=RED_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=72082328&w=150&h=150"},
        {name="GreenSparkle", text="GREEN SPARKLE TIME", id=GREEN_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=100929604&w=150&h=150"},
        {name="MidnightBlueSparkle", text="MIDNIGHT BLUE SPARKLE TIME", id=MIDNIGHT_BLUE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=119916949&w=150&h=150"},
        {name="TealSparkle", text="TEAL SPARKLE TIME", id=TEAL_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=147180077&w=150&h=150"},
        {name="OrangeSparkle", text="ORANGE SPARKLE TIME", id=ORANGE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=215751161&w=150&h=150"},
        {name="BlackSparkle", text="BLACK SPARKLE TIME", id=BLACK_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=259423244&w=150&h=150"},
        {name="PinkSparkle", text="PINK SPARKLE TIME", id=PINK_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=334663683&w=150&h=150"},
        {name="SkyBlueSparkle", text="SKY BLUE SPARKLE TIME", id=SKY_BLUE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=493476042&w=150&h=150"},
        {name="WhiteSparkle", text="WHITE SPARKLE TIME", id=WHITE_SPARKLE_TIME_FEDORA_ID, image="rbxthumb://type=Asset&id=1016143686&w=150&h=150"},
    }
    local FedoraButtons = {}
    local fedoraRadius = 100
    local fedoraButtonSize = 68

    local function fedoraPosition(index, total)
        local angle = math.rad(-90 + ((index - 1) / total) * 360)
        return UDim2.new(0.5, math.cos(angle) * fedoraRadius - fedoraButtonSize / 2,
            0.5, math.sin(angle) * fedoraRadius - fedoraButtonSize / 2)
    end

    local function setFedoraCircleVisible(state)
        fedoraCircleOpen = state
        FedoraCircleGui.Visible = state
        if state then
            hornCircleOpen = false
            HornCircleGui.Visible = false
            CircleGui.Visible = false
            UtilityCircleGui.Visible = false
            if CombatOpenButton then CombatOpenButton.Visible = false end
        else
            CircleGui.Visible = circleOpen
            UtilityCircleGui.Visible = false
            if CombatOpenButton then CombatOpenButton.Visible = circleOpen end
        end
    end

    FedoraCircleClose.MouseButton1Click:Connect(function()
        setFedoraCircleVisible(false)
    end)

    for index, data in ipairs(CircleItems) do
        local b = MkBtn(CircleGui, {
            bg=T.RAISED, text=data.image and "" or data.text, size=8, color=T.TEXT,
            sz=UDim2.fromOffset(circleButtonSize, circleButtonSize),
            pos=circlePosition(index, #CircleItems), anchor=Vector2.new(0,0),
            corner=32, bgt=0.04, z=8005
        })

        -- Catalog previews for accessory buttons. HORNS + CROWN shows
        -- the horn preview and the 8 BIT CROWN preview side-by-side.
        if data.image then
            if data.crownImage then
                local hornPreview = Instance.new("ImageLabel", b)
                hornPreview.Name = "HornsPreview"
                hornPreview.Size = UDim2.fromOffset(30, 30)
                hornPreview.Position = UDim2.new(0.5, -31, 0, 5)
                hornPreview.BackgroundTransparency = 1
                hornPreview.Image = data.image
                hornPreview.ScaleType = Enum.ScaleType.Fit
                hornPreview.ZIndex = 8006

                local crownPreview = Instance.new("ImageLabel", b)
                crownPreview.Name = "CrownPreview"
                crownPreview.Size = UDim2.fromOffset(30, 30)
                crownPreview.Position = UDim2.new(0.5, 1, 0, 5)
                crownPreview.BackgroundTransparency = 1
                crownPreview.Image = data.crownImage
                crownPreview.ScaleType = Enum.ScaleType.Fit
                crownPreview.ZIndex = 8006

                local hornsCrownLabel = Instance.new("TextLabel", b)
                hornsCrownLabel.Name = "HornsCrownLabel"
                hornsCrownLabel.Size = UDim2.new(1, 0, 0, 18)
                hornsCrownLabel.Position = UDim2.new(0, 0, 1, -20)
                hornsCrownLabel.BackgroundTransparency = 1
                hornsCrownLabel.Text = "HORNS + CROWN"
                hornsCrownLabel.FontFace = Bold
                hornsCrownLabel.TextSize = 7
                hornsCrownLabel.TextColor3 = T.TEXT
                hornsCrownLabel.TextXAlignment = Enum.TextXAlignment.Center
                hornsCrownLabel.ZIndex = 8007
            else
                local preview = Instance.new("ImageLabel", b)
                preview.Name = "AccessoryPreview"
                preview.Size = UDim2.fromOffset(46, 46)
                preview.Position = UDim2.new(0.5, -23, 0, 5)
                preview.BackgroundTransparency = 1
                preview.Image = data.image
                preview.ScaleType = Enum.ScaleType.Fit
                preview.ZIndex = 8006

                local accessoryLabel = Instance.new("TextLabel", b)
                accessoryLabel.Name = "AccessoryLabel"
                accessoryLabel.Size = UDim2.new(1, 0, 0, 14)
                accessoryLabel.Position = UDim2.new(0, 0, 1, -17)
                accessoryLabel.BackgroundTransparency = 1
                accessoryLabel.Text = data.text
                accessoryLabel.FontFace = Bold
                accessoryLabel.TextSize = 8
                accessoryLabel.TextColor3 = T.TEXT
                accessoryLabel.TextXAlignment = Enum.TextXAlignment.Center
                accessoryLabel.ZIndex = 8007
            end
        end

        CircleButtons[data.name] = b

        b.MouseButton1Click:Connect(function()
            if data.action == "claude" then
                local newState = not getClaudeToggleState()
                setClaudeToggle(newState)
                if newState then enableClaude() else disableClaude() end
            elseif data.action == "crown" then
                local applied = applyCustomHorn(EIGHT_BIT_CROWN_ID, "8 BIT CROWN")
                if applied then
                    Notif("8 BIT CROWN", "8 Bit Crown equipped", "ok")
                end
            elseif data.action == "head" then
                applyHeadNoGlow()
                task.delay(0.12, rebuildCosmeticsDescription)
                Notif("HEADLESS", "Headless applied (no glowing eyes)", "ok")
            elseif data.action == "leg" then
                applyKorbloxLeg()
                task.delay(0.12, rebuildCosmeticsDescription)
                Notif("KORBLOX", "Korblox leg applied", "ok")
            elseif data.action == "horns" then
                setCosmeticsPanelVisible(true)
            elseif data.action == "fedora" then
                setCosmeticsPanelVisible(true)
            elseif data.action == "reset" then
                local char = LP.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.Health = 0
                    Notif("Reset", "Character reset", "ok")
                else
                    Notif("Reset", "No humanoid found", "err")
                end
            end
            updateCircle()
        end)
    end

    for index, data in ipairs(FedoraItems) do
        local b = MkBtn(FedoraCircleGui, {
            bg=T.RAISED, text="", size=8, color=T.TEXT,
            sz=UDim2.fromOffset(fedoraButtonSize, fedoraButtonSize),
            pos=fedoraPosition(index, #FedoraItems), anchor=Vector2.new(0,0),
            corner=38, bgt=0.04, z=8205
        })
        local preview = Instance.new("ImageLabel", b)
        preview.Name = "FedoraPreview"
        preview.Size = UDim2.fromOffset(50, 42)
        preview.Position = UDim2.new(0.5, -25, 0, 3)
        preview.BackgroundTransparency = 1
        preview.Image = data.image
        preview.ScaleType = Enum.ScaleType.Fit
        preview.ZIndex = 8206
        local label = Instance.new("TextLabel", b)
        label.Name = "FedoraLabel"
        label.Size = UDim2.new(1, -4, 0, 17)
        label.Position = UDim2.new(0, 2, 1, -20)
        label.BackgroundTransparency = 1
        label.Text = data.text
        label.FontFace = Bold
        label.TextSize = 7
        label.TextColor3 = T.TEXT
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.ZIndex = 8207
        FedoraButtons[data.name] = b
        b.MouseButton1Click:Connect(function()
            local applied = applyCustomHorn(data.id, data.text, cosmeticProperty(data.id))
            if applied then
                FedoraCircleStatus.Text = data.text .. " EQUIPPED"
                FedoraCircleStatus.TextColor3 = T.ON
                Notif("Fedora", data.text .. " equipped", "ok")
                task.wait(0.12)
                setFedoraCircleVisible(false)
            end
        end)
    end

    for index, data in ipairs(HornItems) do
        local b = MkBtn(HornCircleGui, {
            bg=T.RAISED, text=data.image and "" or data.text, size=8, color=T.TEXT,
            sz=UDim2.fromOffset(hornButtonSize, hornButtonSize),
            pos=hornPosition(index, #HornItems), anchor=Vector2.new(0,0),
            corner=38, bgt=0.04, z=8105
        })

        if data.image then
            local preview = Instance.new("ImageLabel", b)
            preview.Name = "AccessoryPreview"
            preview.Size = UDim2.fromOffset(50, 42)
            preview.Position = UDim2.new(0.5, -25, 0, 3)
            preview.BackgroundTransparency = 1
            preview.Image = data.image
            preview.ScaleType = Enum.ScaleType.Fit
            preview.ZIndex = 8106

            local label = Instance.new("TextLabel", b)
            label.Name = "AccessoryLabel"
            label.Size = UDim2.new(1, -4, 0, 17)
            label.Position = UDim2.new(0, 2, 1, -20)
            label.BackgroundTransparency = 1
            label.Text = data.text
            label.FontFace = Bold
            label.TextSize = 7
            label.TextColor3 = T.TEXT
            label.TextXAlignment = Enum.TextXAlignment.Center
            label.ZIndex = 8107
        end

        HornButtons[data.name] = b
        b.MouseButton1Click:Connect(function()
            if data.name == "Off" then
                if selectedHornId then
                    clearCustomHorn()
                end
                HornCircleStatus.Text = "HORNS + CROWN OFF"
                Notif("Horns + Crown", "SUCCESS: HORNS + CROWN OFF", "ok")
                task.wait(0.12)
                setHornCircleVisible(false)
                updateCircle()
                return
            end

            -- Selecting a horn adds it without removing other cosmetics.
            if not equippedCosmetics[data.id] then
                local applied = applyCustomHorn(data.id, data.text, cosmeticProperty(data.id))
                if applied then
                    HornCircleStatus.Text = "SUCCESS"
                    Notif("Horns + Crown", "SUCCESS: " .. data.text .. " EQUIPPED", "ok")
                    task.wait(0.12)
                    setHornCircleVisible(false)
                    updateCircle()
                end
            end
        end)
    end

    HornCircleClose.MouseButton1Click:Connect(function()
        setHornCircleVisible(false)
        updateCircle()
    end)

    CircleClose.MouseButton1Click:Connect(function()
        setCombatVisible(false)
        setHornCircleVisible(false)
        setCircleVisible(false)
    end)

    local openCircleButton = MkBtn(P, {
        bg=T.RAISED, text="◉  OPEN COSMETICS + UTILITY", size=8, color=T.TEXT,
        sz=UDim2.new(1,0,0,36), order=4, corner=8, bgt=0.05, z=15
    })
    openCircleButton.MouseButton1Click:Connect(function()
        setCombatVisible(false)
        setHornCircleVisible(false)
        setCircleVisible(not circleOpen)
    end)

    MkLabel(P, {
        text="COSMETICS CIRCLE + COMBAT", size=11, color=T.TEXT, font=Bold,
        sz=UDim2.new(1,-32,0,20), pos=UDim2.new(0,16,0,52), z=14
    })
    MkLabel(P, {
        text="CIRCLE = 8 BIT / HORNS / HEADLESS / KORBLOX / FEDORA   •   COMBAT = AURA KILL / TP WALK / SPAM GRAB / GHOST",
        size=8, color=T.MUTED, font=Reg,
        sz=UDim2.new(1,-32,0,34), pos=UDim2.new(0,16,0,74), z=14,
        wrap=true
    })

    -- TAB toggles the cosmetic circle; if a submenu is open it closes first.
    UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.Tab then
            if hornCircleOpen then
                setHornCircleVisible(false)
            elseif fedoraCircleOpen then
                setFedoraCircleVisible(false)
            elseif UtilityCircleGui.Visible then
                setCombatVisible(false)
            else
                setCircleVisible(not circleOpen)
            end
        end
    end)

    -- Bottom-left player join/leave feed using both DisplayName and @Username.
    local PlayerEventFeed = Instance.new("Frame", GUI)
    PlayerEventFeed.Name = "ClaudePlayerEventFeed"
    PlayerEventFeed.Size = UDim2.fromOffset(330, 180)
    PlayerEventFeed.Position = UDim2.new(0, 18, 1, -18)
    PlayerEventFeed.AnchorPoint = Vector2.new(0, 1)
    PlayerEventFeed.BackgroundTransparency = 1
    PlayerEventFeed.ZIndex = 12000

    local playerEventEntries = {}
    local function showPlayerEvent(player, joined)
        if not player or player == LP then return end
        local row = Instance.new("Frame")
        row.Name = joined and "PlayerJoined" or "PlayerLeft"
        row.Size = UDim2.new(1, 0, 0, 34)
        row.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        row.BackgroundTransparency = 0.12
        row.BorderSizePixel = 0
        row.ZIndex = 12001
        Cnr(row, 8)
        local label = Instance.new("TextLabel", row)
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -18, 1, 0)
        label.Position = UDim2.fromOffset(9, 0)
        label.Text = string.format("%s (@%s) HAS %s", player.DisplayName, player.Name, joined and "JOINED" or "LEFT")
        label.FontFace = Bold
        label.TextSize = 11
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 12002
        table.insert(playerEventEntries, row)
        row.Parent = PlayerEventFeed
        for i = #playerEventEntries, 1, -1 do
            local r = playerEventEntries[i]
            if not r.Parent then table.remove(playerEventEntries, i) end
        end
        for i, r in ipairs(playerEventEntries) do
            r.Position = UDim2.new(0, 0, 1, -(#playerEventEntries - i + 1) * 38)
        end
        task.delay(4, function()
            if row.Parent then row:Destroy() end
        end)
    end

    Players.PlayerAdded:Connect(function(player)
        showPlayerEvent(player, true)
    end)
    Players.PlayerRemoving:Connect(function(player)
        showPlayerEvent(player, false)
    end)

    LP.CharacterAdded:Connect(function(char)
        if not claudeEnabled then return end
        task.wait(1)
        if not claudeEnabled then return end
        saveOriginalDescription()
        applyHeadNoGlow()
        task.wait(0.15)
        applyKorbloxLeg()
        if next(equippedCosmetics) then
            task.wait(0.15)
            rebuildCosmeticsDescription()
            for id, name in pairs(equippedCosmetics) do
                sendCatalogAccessory(tonumber(id) or id)
                task.wait(0.03)
                ensureAccessoryLocally(tonumber(id) or id, name)
            end
        end
    end)
end

-- ═══════════════════════════════════════
-- TAB 15: PLAYERS INFO
-- ═══════════════════════════════════════
do
    local P = tabPanels[15]
    local playerRows = {}
    local selectedPlayer = nil

    local function getAvatar(player)
        local ok, content = pcall(function()
            return Players:GetUserThumbnailAsync(
                player.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)
        return ok and content or ""
    end

    local function teleportToPlayer(player)
        if not player or player == lp then
            Notif("Players Info","Select another player first","warn")
            return
        end

        local myChar = lp.Character
        local targetChar = player.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

        if not myRoot or not targetRoot then
            Notif("Players Info","That player is not currently spawned","warn")
            return
        end

        pcall(function()
            myRoot.CFrame = targetRoot.CFrame + targetRoot.CFrame.LookVector * 3
        end)

        Notif("Players Info","Teleported to "..player.Name,"ok")
    end

    local listCard = MkCard(P,72,1)
    listCard.ClipsDescendants = false

    local listTitle = MkLabel(listCard,{
        text="PLAYERS IN SERVER",
        size=9,
        color=T.TEXT,
        font=Bold,
        sz=UDim2.new(1,-32,0,18),
        pos=UDim2.new(0,16,0,8),
        z=15
    })

    local countLabel = MkLabel(listCard,{
        text="",
        size=8,
        color=T.MUTED,
        font=Reg,
        sz=UDim2.new(1,-32,0,16),
        pos=UDim2.new(0,16,0,31),
        z=15
    })

    local playersList = Instance.new("ScrollingFrame",P)
    playersList.Size = UDim2.new(1,0,0,330)
    playersList.BackgroundColor3 = T.CARD
    playersList.BackgroundTransparency = 0.06
    playersList.BorderSizePixel = 0
    playersList.ScrollBarThickness = 4
    playersList.ScrollBarImageColor3 = T.ACCENT
    playersList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    playersList.CanvasSize = UDim2.new(0,0,0,0)
    playersList.LayoutOrder = 2
    playersList.ZIndex = 14
    Cnr(playersList,10)
    Strk(playersList,T.BORDER,1,0.45)
    LP(playersList,8,8,8,8)
    LL(playersList,6)

    local infoCard = MkCard(P,250,3)
    infoCard.ClipsDescendants = false

    local avatar = Instance.new("ImageLabel",infoCard)
    avatar.Size = UDim2.new(0,82,0,82)
    avatar.Position = UDim2.new(0,16,0,16)
    avatar.BackgroundColor3 = T.RAISED
    avatar.BackgroundTransparency = 0.1
    avatar.BorderSizePixel = 0
    avatar.Image = ""
    avatar.ScaleType = Enum.ScaleType.Crop
    avatar.ZIndex = 16
    Cnr(avatar,10)

    local selectedLabel = MkLabel(infoCard,{
        text="SELECT A PLAYER",
        size=13,
        color=T.TEXT,
        font=Bold,
        sz=UDim2.new(1,-118,0,22),
        pos=UDim2.new(0,114,0,16),
        z=16
    })

    local usernameLabel = MkLabel(infoCard,{
        text="Username: —",
        size=9,
        color=T.MUTED,
        font=Reg,
        sz=UDim2.new(1,-118,0,18),
        pos=UDim2.new(0,114,0,42),
        z=16
    })

    local displayLabel = MkLabel(infoCard,{
        text="Display Name: —",
        size=9,
        color=T.MUTED,
        font=Reg,
        sz=UDim2.new(1,-118,0,18),
        pos=UDim2.new(0,114,0,64),
        z=16
    })

    local ageLabel = MkLabel(infoCard,{
        text="Account Age: —",
        size=9,
        color=T.MUTED,
        font=Reg,
        sz=UDim2.new(1,-118,0,18),
        pos=UDim2.new(0,114,0,86),
        z=16
    })

    local userIdLabel = MkLabel(infoCard,{
        text="User ID: —",
        size=9,
        color=T.MUTED,
        font=Reg,
        sz=UDim2.new(1,-118,0,18),
        pos=UDim2.new(0,114,0,108),
        z=16
    })

    local teleportBtn = MkBtn(infoCard,{
        bg=T.RAISED,
        text="TELEPORT",
        size=9,
        color=T.TEXT,
        sz=UDim2.new(1,-32,0,34),
        pos=UDim2.new(0,16,1,-84),
        corner=8,
        bgt=0.05,
        z=17
    })

    -- X RAY toggle sits directly under TELEPORT.
    -- It uses the exact same Highlight + name-tag ESP as the X-RAY tab.
    local xrayBtn = MkBtn(infoCard,{
        bg=T.RAISED,
        text="X RAY: OFF",
        size=9,
        color=T.TEXT,
        sz=UDim2.new(1,-32,0,34),
        pos=UDim2.new(0,16,1,-44),
        corner=8,
        bgt=0.05,
        z=17
    })

    local function updateXRayButton()
        local on = false
        if selectedPlayer and type(_G.ClaudeXRayIsPlayerOn) == "function" then
            on = _G.ClaudeXRayIsPlayerOn(selectedPlayer)
        end
        xrayBtn.Text = on and "X RAY: ON" or "X RAY: OFF"
    end

    teleportBtn.MouseButton1Click:Connect(function()
        teleportToPlayer(selectedPlayer)
    end)

    xrayBtn.MouseButton1Click:Connect(function()
        if not selectedPlayer then
            Notif("Players Info","Select a player first","warn")
            return
        end

        local isOn = type(_G.ClaudeXRayIsPlayerOn) == "function"
            and _G.ClaudeXRayIsPlayerOn(selectedPlayer)

        if isOn then
            if type(_G.ClaudeXRayRemovePlayer) == "function" then
                _G.ClaudeXRayRemovePlayer(selectedPlayer)
            end
        else
            if type(_G.ClaudeXRayPlayer) == "function" then
                _G.ClaudeXRayPlayer(selectedPlayer)
            else
                Notif("X-Ray","X-Ray is not ready yet","warn")
            end
        end

        updateXRayButton()
    end)

    local function clearRows()
        for _,row in pairs(playerRows) do
            if row and row.Parent then
                row:Destroy()
            end
        end
        playerRows = {}
    end

    local function selectPlayer(player)
        selectedPlayer = player
        if not player then
            avatar.Image = ""
            selectedLabel.Text = "SELECT A PLAYER"
            usernameLabel.Text = "Username: —"
            displayLabel.Text = "Display Name: —"
            ageLabel.Text = "Account Age: —"
            userIdLabel.Text = "User ID: —"
            xrayBtn.Text = "X RAY: OFF"
            return
        end

        selectedLabel.Text = player.DisplayName
        usernameLabel.Text = "Username: @"..player.Name
        displayLabel.Text = "Display Name: "..player.DisplayName
        ageLabel.Text = "Account Age: "..tostring(player.AccountAge).." days"
        userIdLabel.Text = "User ID: "..tostring(player.UserId)

        task.spawn(function()
            local image = getAvatar(player)
            if selectedPlayer == player and avatar.Parent then
                avatar.Image = image
            end
        end)

        for pl,row in pairs(playerRows) do
            if row and row.Parent then
                row.BackgroundColor3 = (pl == player) and T.RAISED or T.CARD
            end
        end
        updateXRayButton()
    end

    local function addPlayerRow(player)
        if player == lp then
            return
        end

        local row = Instance.new("TextButton",playersList)
        row.Size = UDim2.new(1,0,0,54)
        row.BackgroundColor3 = T.CARD
        row.BackgroundTransparency = 0.04
        row.Text = ""
        row.AutoButtonColor = false
        row.BorderSizePixel = 0
        row.LayoutOrder = #playerRows + 1
        row.ZIndex = 15
        Cnr(row,8)
        Strk(row,T.BORDER,1,0.5)

        local img = Instance.new("ImageLabel",row)
        img.Size = UDim2.new(0,40,0,40)
        img.Position = UDim2.new(0,8,0.5,-20)
        img.BackgroundColor3 = T.RAISED
        img.BackgroundTransparency = 0.1
        img.BorderSizePixel = 0
        img.ScaleType = Enum.ScaleType.Crop
        img.ZIndex = 16
        Cnr(img,7)

        MkLabel(row,{
            text=player.DisplayName,
            size=10,
            color=T.TEXT,
            font=Semi,
            sz=UDim2.new(1,-64,0,18),
            pos=UDim2.new(0,58,0,8),
            z=16
        })

        MkLabel(row,{
            text="@"..player.Name,
            size=8,
            color=T.MUTED,
            font=Reg,
            sz=UDim2.new(1,-64,0,16),
            pos=UDim2.new(0,58,0,29),
            z=16
        })

        row.MouseEnter:Connect(function()
            if selectedPlayer ~= player then
                Tw(row,{BackgroundColor3=T.RAISED},0.12)
            end
        end)

        row.MouseLeave:Connect(function()
            if selectedPlayer ~= player then
                Tw(row,{BackgroundColor3=T.CARD},0.12)
            end
        end)

        row.MouseButton1Click:Connect(function()
            selectPlayer(player)
        end)

        playerRows[player] = row

        task.spawn(function()
            local image = getAvatar(player)
            if row.Parent then
                img.Image = image
            end
        end)
    end

    local function refreshPlayers()
        clearRows()

        local allPlayers = {}
        for _,player in ipairs(Players:GetPlayers()) do
            if player ~= lp then
                table.insert(allPlayers,player)
            end
        end

        table.sort(allPlayers,function(a,b)
            return a.Name:lower() < b.Name:lower()
        end)

        countLabel.Text = tostring(#allPlayers).." other player"..(#allPlayers == 1 and "" or "s").." in this server"

        for _,player in ipairs(allPlayers) do
            addPlayerRow(player)
        end

        if selectedPlayer and not selectedPlayer.Parent then
            selectPlayer(nil)
        end
    end

    Players.PlayerAdded:Connect(function()
        task.defer(refreshPlayers)
    end)

    Players.PlayerRemoving:Connect(function(player)
        if player == selectedPlayer then
            selectPlayer(nil)
        end
        task.defer(refreshPlayers)
    end)

    refreshPlayers()
end

-- ════════════════════════════════════════════════════════════
-- GOAT GRAB PANEL
--[[
 made by drakozz + n1ght
]]
-- Rebuilt for Unknown: rate-limited grab cycle, live stats, drag
-- with saved position, minimize, and safe auto-stop. Toggle key: "5".
-- ════════════════════════════════════════════════════════════
do
    local GOAT_IMAGE = "rbxassetid://101169975526932"
    local BURST = 5
    local INTERVAL = 0.08

    local function grabRemote()
        if RF and RF.Grab then return RF.Grab end
        return nil
    end

    local panel = Instance.new("Frame")
    panel.Name = "CLAUDE_GoatGrab"
    panel.Size = UDim2.fromOffset(212,170)
    panel.Position = UDim2.new(0.5,-106,0.12,0)
    panel.BackgroundColor3 = T.BG
    panel.BackgroundTransparency = 0.03
    panel.BorderSizePixel = 0
    panel.ZIndex = 9000
    panel.Active = true
    panel.Parent = GUI
    Cnr(panel,12)
    Strk(panel,T.ACCENT,1.6,0.14)

    local savedPos = SAVE.goatPos
    if type(savedPos)=="table" and #savedPos==4 then
        panel.Position = UDim2.new(savedPos[1],savedPos[2],savedPos[3],savedPos[4])
    end

    local bg = Instance.new("ImageLabel")
    bg.Size = UDim2.fromScale(1,1)
    bg.BackgroundTransparency = 1
    bg.Image = GOAT_IMAGE
    bg.ImageTransparency = 0.55
    bg.ScaleType = Enum.ScaleType.Stretch
    bg.ZIndex = 9000
    bg.Parent = panel
    Cnr(bg,12)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1,0,0,30)
    header.BackgroundColor3 = T.CARD
    header.BackgroundTransparency = 0.15
    header.BorderSizePixel = 0
    header.ZIndex = 9001
    header.Parent = panel
    Cnr(header,12)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-60,1,0)
    title.Position = UDim2.new(0,10,0,0)
    title.BackgroundTransparency = 1
    title.Text = "> unknown grab driver"
    title.TextColor3 = T.TEXT
    title.TextSize = 12
    title.FontFace = Bold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 9002
    title.Parent = header

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.fromOffset(22,22)
    minBtn.Position = UDim2.new(1,-52,0.5,-11)
    minBtn.BackgroundColor3 = T.RAISED
    minBtn.Text = "–"
    minBtn.TextColor3 = T.TEXT
    minBtn.TextSize = 14
    minBtn.FontFace = Bold
    minBtn.AutoButtonColor = false
    minBtn.BorderSizePixel = 0
    minBtn.ZIndex = 9002
    minBtn.Parent = header
    Cnr(minBtn,6)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.fromOffset(22,22)
    closeBtn.Position = UDim2.new(1,-26,0.5,-11)
    closeBtn.BackgroundColor3 = T.ACCENT
    closeBtn.Text = "×"
    closeBtn.TextColor3 = T.BG
    closeBtn.TextSize = 14
    closeBtn.FontFace = Bold
    closeBtn.AutoButtonColor = false
    closeBtn.BorderSizePixel = 0
    closeBtn.ZIndex = 9002
    closeBtn.Parent = header
    Cnr(closeBtn,6)

    local body = Instance.new("Frame")
    body.Size = UDim2.new(1,-16,1,-40)
    body.Position = UDim2.new(0,8,0,34)
    body.BackgroundTransparency = 1
    body.ZIndex = 9001
    body.Parent = panel

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1,0,0,16)
    status.Position = UDim2.new(0,0,0,0)
    status.BackgroundTransparency = 1
    status.Text = "> IDLE — press 5"
    status.TextColor3 = T.MUTED
    status.TextSize = 10
    status.FontFace = Reg
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.ZIndex = 9002
    status.Parent = body

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,42)
    btn.Position = UDim2.new(0,0,0,24)
    btn.BackgroundColor3 = T.ACCENT
    btn.Text = "> START GRAB (5)"
    btn.TextColor3 = T.BG
    btn.TextSize = 14
    btn.FontFace = Bold
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.ZIndex = 9002
    btn.Parent = body
    Cnr(btn,8)

    local stats = Instance.new("TextLabel")
    stats.Size = UDim2.new(1,0,0,16)
    stats.Position = UDim2.new(0,0,0,72)
    stats.BackgroundTransparency = 1
    stats.Text = "sent 0  ·  0/s"
    stats.TextColor3 = T.MUTED
    stats.TextSize = 9
    stats.FontFace = Reg
    stats.TextXAlignment = Enum.TextXAlignment.Left
    stats.ZIndex = 9002
    stats.Parent = body

    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(1,0,0,16)
    hint.Position = UDim2.new(0,0,0,90)
    hint.BackgroundTransparency = 1
    hint.Text = "works anywhere, always ready"
    hint.TextColor3 = T.DIM
    hint.TextSize = 9
    hint.FontFace = Reg
    hint.TextXAlignment = Enum.TextXAlignment.Left
    hint.ZIndex = 9002
    hint.Parent = body

    local running = false
    local loopThread = nil
    local sent = 0
    local rateCount = 0
    local rateWindow = 0
    local currentRate = 0

    local function refreshStats()
        stats.Text = string.format("sent %d  ·  %d/s",sent,currentRate)
    end

    local function stopGrab(reason)
        running = false
        btn.Text = "> START GRAB (5)"
        btn.BackgroundColor3 = T.ACCENT
        status.Text = "> IDLE — press 5"
        status.TextColor3 = T.MUTED
        if reason then Notif("GOAT GRAB",reason,"") end
    end

    local function startLoop()
        if not grabRemote() then
            running = false
            status.Text = "> GRAB REMOTE NOT FOUND"
            status.TextColor3 = T.ERR
            return
        end
        if loopThread then return end
        loopThread = task.spawn(function()
            while running do
                local r = grabRemote()
                if not r then
                    stopGrab("Remote lost")
                    break
                end
                for _=1,BURST do
                    if not running then break end
                    pcall(function() r:InvokeServer() end)
                    sent += 1
                    rateCount += 1
                end
                task.wait(INTERVAL)
            end
            loopThread = nil
        end)
    end

    local function setState(on,reason)
        if on == running then return end
        if on then
            running = true
            btn.Text = "> GRABBING… (5)"
            btn.BackgroundColor3 = T.ON
            status.Text = "> ACTIVE — grabbing"
            status.TextColor3 = T.ON
            startLoop()
            if running then Notif("GOAT GRAB","Active","ok") end
        else
            stopGrab(reason or "Off")
        end
    end

    local function toggle()
        setState(not running)
    end

    btn.MouseButton1Click:Connect(toggle)

    TC(UIS.InputBegan:Connect(function(input,gp)
        if gp then return end
        if input.KeyCode ~= Enum.KeyCode.Five then return end
        if UIS:GetFocusedTextBox() then return end
        toggle()
    end))

    TC(RunSvc.Heartbeat:Connect(function(dt)
        rateWindow += dt
        if rateWindow >= 1 then
            currentRate = rateCount
            rateCount = 0
            rateWindow = 0
            refreshStats()
        end
    end))

    closeBtn.MouseButton1Click:Connect(function()
        stopGrab()
        panel:Destroy()
    end)

    minBtn.MouseButton1Click:Connect(function()
        local showing = body.Visible
        body.Visible = not showing
        panel.Size = showing and UDim2.fromOffset(212,34) or UDim2.fromOffset(212,170)
        minBtn.Text = showing and "+" or "–"
    end)

    do
        local dragging,dragStart,startPos = false,nil,nil
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = panel.Position
            end
        end)
        header.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                SAVE.goatPos = {panel.Position.X.Scale,panel.Position.X.Offset,panel.Position.Y.Scale,panel.Position.Y.Offset}
                task.defer(DoSave)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                panel.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    if lp.Character then
        lp.CharacterAdded:Connect(function()
            if running then stopGrab("Stopped: respawn") end
        end)
    end
end
