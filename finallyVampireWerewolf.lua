--[[
Writen by 'Rolf' for TES3MP 0.8.0 and 0.8.1.

Description: Very simple script that fixes the impossibility of becoming vampire or werewolf without commands, due to how the passage of time works, among other things; executing the appropiate commands each time a player is infected.

Installation Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP installation directory.
2. Open your 'customScripts.lua' file ('server\scripts') in a text editor, and write on it the next line: require("custom/finallyVampireWerewolf")
3. Save the changes and close it.
--]]

local vampire = true -- Set it to 'false' if you want no one becomes vampire through this script.
local werewolf = true -- Set it to 'false' if you want no one becomes werewolf through this script.
local vampire_talk = false -- Set this to 'true' if you want vampires can talk with everyone, but the sun damage that applies to them stops working.

tableHelper = require("tableHelper")

customEventHooks.registerValidator("OnPlayerCellChange", function(eventStatus, pid)
    local player = Players[pid]
    if player and player:IsLoggedIn() then
        if tableHelper.containsValue(player.data.spellbook, "vampire blood quarra") or tableHelper.containsValue(player.data.spellbook, "vampire blood aundae") or tableHelper.containsValue(player.data.spellbook, "vampire blood berne") and vampire ~= false and not tableHelper.containsValue(player.data.spellbook, "vampire attributes") then
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'set PCVampire to 1')
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire attributes"')
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire skills"')
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire immunities"')
            if vampire_talk ~= true then
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire sun damage"')
            elseif tableHelper.containsValue(player.data.spellbook, "vampire blood quarra") then
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire quarra specials"')
            elseif tableHelper.containsValue(player.data.spellbook, "vampire blood aundae") then
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire aundae specials"')
            elseif tableHelper.containsValue(player.data.spellbook, "vampire blood berne") then
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "vampire berne specials"')
        end
	    elseif tableHelper.containsValue(player.data.spellbook, "werewolf blood") and werewolf ~= false and not tableHelper.containsValue(player.data.spellbook, "werewolf resists") then
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'set PCWerewolf to 1')
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "werewolf resists"')
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "werewolf regeneration"')
            logicHandler.RunConsoleCommandOnPlayer(player.pid, 'addspell "werewolf vision"')
        end
    end
end)
