local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

ESX         = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterCommand('stun', function()
    SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 3000)
    DoScreenFadeOut(2)
    DoScreenFadeIn(2)
end)

function Weapon()
    GiveWeaponToPed(PlayerPedId(), "weapon_pistol", 999, false, false)
end

function Heal()
    SetEntityHealth(PlayerPedId(), 200)
end

function food()
    TriggerEvent('esx_status:set', 'hunger', 1000000)
    TriggerEvent('esx_status:set', 'thirst', 1000000)
end

local options = {
    {label = "pistol", value="weapon"},
    {label = "dead", value="suicide"},
    {label = "line", value="hello"},
    {label = "Heal", value="heal"},
    {label = "food", value="food"}
}

function OpenMenu()
    isMenuOpen = true
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
        title = "General Munu",
        align = "left",
        elements = options
    },function(data, menu)
        if(data.current.value == "weapon") then
            Weapon()
            ESX.ShowNotification("Get Weapon")
        end
        if(data.current.value == 'hello') then
            print("Hello World!")
        end
        if(data.current.value == 'heal') then
            Heal()
            ESX.ShowNotification("Healed")
        end
        if(data.current.value == 'food') then
            food()
        end
    end,function(data,menu)
        menu.close()
        isMenuOpen = false
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(IsControlJustPressed(0, 47)) then
            OpenMenu()
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Damage = IsPedInjured(PlayerPedId())
    end
end)