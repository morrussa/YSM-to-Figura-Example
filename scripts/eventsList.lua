local playerLv
local oldPlayerLv = playerLv
eventsList = {
    displayElytraDamageOnGun = function()   --将鞘翅剩余耐久显示到数码管上
        local elytraSlot = player:getItem(5)
        if elytraSlot.id ~= "minecraft:elytra" then
            SSDisplay:SSDisplayOutNum(math.random(0,99999)) --玩家不穿戴鞘翅则显示随机数字
        else
            local elytraDamagePercent = math.floor((elytraSlot:getMaxDamage()-elytraSlot:getDamage())/elytraSlot:getMaxDamage()*100)
            if elytraDamagePercent <= 20 then
                if world.getTime()%20 == 0 then
                    SSDisplay:SSDisplayOutNum(elytraDamagePercent)
                elseif world.getTime()%20 == 10 then
                    SSDisplay:cleanDisplay()
                end
            else
                SSDisplay:SSDisplayOutNum(elytraDamagePercent)
            end
        end
    end,
    displayVelocityOnProgressBar = function()   --将玩家的水平动量显示到进度条上
        local vel = player:getVelocity().xz:length()
        local prgLvl = (math.ceil(vel/0.3))>=6 and 6 or math.ceil(vel/0.3)
        gunProgress:setGunProgressLevel(prgLvl)
    end,
    tickGunScreen = function(self)  --光之剑显示屏刷新
        events.TICK:register(function ()
            self.displayElytraDamageOnGun()
            self.displayVelocityOnProgressBar()
        end, "gun_screen_tick")
    end,
    tickArisLevelUpSound = function()   --玩家每升五级播放音效
        if player:isLoaded() then
            events.TICK:register(function ()
                playerLv = player:getExperienceLevel()
                if oldPlayerLv == nil then
                    oldPlayerLv = playerLv
                end
                if playerLv > oldPlayerLv and playerLv%5 == 0 then
                    soundsList:arisLevelUp()
                end
                oldPlayerLv = playerLv
            end, "aris_level_up_sound_tick")
        end
    end
}

return eventsList
