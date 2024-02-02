soundsList = {
    arisVoice = {
        "sounds.aris_exlv1",
        "sounds.aris_ex1",
        "sounds.aris_exlv3"
    },
    arisExtra4Vocal = function(self)
        local arisVoiceChoose = self.arisVoice[math.random(1, #self.arisVoice)]
        if player:isLoaded() then
            sounds[arisVoiceChoose]
                :subtitle(Language:getTranslate("sounds_aris_extra4_voice"))
                :pos(player:getPos():add(0, 1, 0))
                :volume(.7)
            :play()
        end
    end,
    arisExtra4GunCharge = function()
        if player:isLoaded() then
            sounds["sounds.aris_gun_charge"]
                :subtitle(Language:getTranslate("sounds_aris_extra4_gun_charge"))
                :pos(player:getPos():add(0, 1, 0))
                :volume(.9)
            :play()
        end
    end,
    arisExtra4GunLaunch = function()
        if player:isLoaded() then
            sounds["sounds.aris_gun_launch"]
                :subtitle(Language:getTranslate("sounds_aris_extra4_gun_launch"))
                :pos(player:getPos():add(0, 1, 0))
                :volume(.9)
            :play()
        end
    end,
    arisLevelUp = function()
        if player:isLoaded() then
            sounds["sounds.aris_lvup1"]
                :subtitle(Language:getTranslate("sounds_aris_level_up"))
                :pos(player:getPos():add(0, 1, 0))
                :volume(.7)
            :play()
        end
    end
}

return soundsList
