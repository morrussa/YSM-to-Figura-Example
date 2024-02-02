--Source code from https://github.com/Gakuto1112/FiguraBlueArchiveCharacters

Language = {
	LanguageData = {
		en_us = {
            action_wheel_extra0_desc = "Extra 0",
            action_wheel_extra1_desc = "Extra 1",
            action_wheel_extra2_desc = "Extra 2",
            action_wheel_extra3_desc = "Extra 3",
            action_wheel_extra4_desc = "Extra 4",
            action_wheel_extra5_desc = "Extra 5",
            action_wheel_extra6_desc = "Extra 6",
            action_wheel_extra7_desc = "Extra 7",
            action_wheel_keyToggle_desc = "§4§kkey§r",
            sounds_aris_extra4_voice = "§gThe Light!§r",
            sounds_aris_extra4_gun_charge = "§gSuperNova: Charge§r",
            sounds_aris_extra4_gun_launch = "§gSuperNova: Launch§r",
            sounds_aris_level_up = "Aris: Level Up",
        },
        zh_cn = {
            action_wheel_extra0_desc = "§4我重伤倒地§r",
            action_wheel_extra1_desc = "招手",
            action_wheel_extra2_desc = "端详物品",
            action_wheel_extra3_desc = "持有光之剑",
            action_wheel_extra4_desc = "§g光啊！§r",
            action_wheel_extra5_desc = "惊讶",
            action_wheel_extra6_desc = "卖萌",
            action_wheel_extra7_desc = "耍酷",
            action_wheel_keyToggle_desc = "§4§kkey§r",
            sounds_aris_extra4_voice = "§g光啊！§r",
            sounds_aris_extra4_gun_charge = "§g光之剑：充能§r",
            sounds_aris_extra4_gun_launch = "§g光之剑：发射§r",
            sounds_aris_level_up = "爱丽丝：升级",
        }
    },
    getTranslate = function(self, keyName)
		local activeLanguage = client:getActiveLang()
		return (self.LanguageData[activeLanguage] and self.LanguageData[activeLanguage][keyName]) and self.LanguageData[activeLanguage][keyName] or (self.LanguageData["en_us"][keyName] and self.LanguageData["en_us"][keyName] or keyName)
	end
}

return Language