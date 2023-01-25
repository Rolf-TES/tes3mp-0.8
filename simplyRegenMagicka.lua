--[[
Writen by 'Rolf' to TES3MP 0.8.0 and 0.8.1.

Description: Very simple script that constantly regenerates 1 point of magicka to the players.

Installation Steps:
1. Place this file inside 'server\scripts\custom' folder, located in your TES3MP installation directory.
2. Open your 'customScripts.lua' file ('server\scripts') in a text editor, and write on it the next line: require("custom/SimplyRegenMagickaka")
3. Save the changes and close it.
--]]
--
local delay = 1 -- Time delay in seconds. Make it larger or smaller to change the regeneration to a slower or faster magicka regeneration respectively.
local amount = 1 -- Amount in numbers of magicka that is added to the player's current magicka (quantity of regeneration).
--
function RegenMagicka()
    -- List of players connected:
    local players = tes3mp.GetOnlinePlayerList()
    -- Browse the list of players:
    for _, pid in pairs(players) do
        -- Obtain the player's current magicka:
        local currentMagicka = tes3mp.GetMagicka(pid)
        -- Increases the player's magicka by 'amount':
        tes3mp.SetMagicka(pid, currentMagicka + amount)
    end
end
-- Executes the function every certain time (defined in 'delay'):
tes3mp.StartTimer(delay, "RegenMagicka")