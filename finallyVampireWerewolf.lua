--[[
Writen by 'Rolf' to TES3MP 8.0.

Description: Very simple script which fixes the impossibility to become vampire or werewolf (some times) without commands (in TES3MP); executing the appropiate commands whenever a player gets infected by Porphyric Hemophilia or Sanies Lupinus.

Installation Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP installation directory.
2. Open your 'customScripts.lua' file ('server\scripts') in a text editor, and write on it the next line: require("custom.finallyVampireWerewolf")
3. Save the changes and close it.
--]]

local vampire = true -- Set it to 'false' if you want no one becomes vampire through this script.
local werewolf = true -- Set it to 'false' if you want no one becomes werewolf through this script.
local vampire_talk = false -- Set this to 'true' if you want the vampires can talk with everyone, but the sun damage that applies to them stops working.

tableHelper = require("tableHelper")

customEventHooks.registerValidator("OnPlayerCellChange", function(eventStatus, pid)
    if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
        if tableHelper.containsValue(Players[pid].data.spellbook, "vampire blood quarra") or tableHelper.containsValue(Players[pid].data.spellbook, "vampire blood aundae") or tableHelper.containsValue(Players[pid].data.spellbook, "vampire blood berne") and vampire ~= false and not tableHelper.containsValue(Players[pid].data.spellbook, "vampire attributes") then
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'set "PCVampire to 1"')
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "vampire attributes"')
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "vampire skills"')
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "vampire immunities"')
            if vampire_talk ~= true then
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "vampire sun damage"')
            elseif tableHelper.containsValue(Players[pid].data.spellbook, "vampire blood quarra") then
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "vampire quarra specials"')
            elseif tableHelper.containsValue(Players[pid].data.spellbook, "vampire blood aundae") then
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "vampire aundae specials"')
            elseif tableHelper.containsValue(Players[pid].data.spellbook, "vampire blood berne") then
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "vampire berne specials"')
        end
	    elseif tableHelper.containsValue(Players[pid].data.spellbook, "werewolf blood") and werewolf ~= false and not tableHelper.containsValue(Players[pid].data.spellbook, "werewolf resists") then
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'set "PCWerewolf to 1"')
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "werewolf resists"')
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "werewolf regeneration"')
            logicHandler.RunConsoleCommandOnPlayer(Players[pid].pid, 'addspell "werewolf vision"')
        end
    end
end)