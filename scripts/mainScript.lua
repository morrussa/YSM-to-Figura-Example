local anims = require('scripts/JimmyAnims') --默认动画库
Language = require('scripts/language') --语言包
local playerModel = models.main --定义玩家模型
eventsList = require('scripts/eventsList') --事件列表

--JimmyAnims动画库设置
anims.excluBlendTime = 1    --独立动画默认混合时间
anims.incluBlendTime = 0    --并行动画默认混合时间
anims.autoBlend = true  --自动混合
anims.dismiss = false   --忽略读取错误
anims.addExcluAnims()
anims.addIncluAnims()
anims.addAllAnims()
anims(animations.main)

vanilla_model.PLAYER:setVisible(false)  --隐藏原版玩家
vanilla_model.ARMOR:setVisible(false)   --隐藏原版盔甲
vanilla_model.ELYTRA:setVisible(false)  --隐藏原版鞘翅
playerModel:setScale(0.75)  --玩家模型缩放
models.skull.Skull:setScale(0.75)   --头颅模型缩放

-- 动画优先度
--如果不设置，默认为0。值可为负
--animations.main["walk"]:setPriority(10)   --不同的优先度可能会导致两个动画之间切换出现问题
--animations.main["sprint"]:setPriority(10)
animations.main["pre_parallel0"]:setPriority(-1)
animations.main["pre_parallel1"]:setPriority(-1)
animations.main["pre_parallel2"]:setPriority(-1)
animations.main["extra0"]:setPriority(1)
animations.main["extra1"]:setPriority(1)
animations.main["extra2"]:setPriority(1)
animations.main["extra3"]:setPriority(1)
animations.main["extra4"]:setPriority(1)
animations.main["extra5"]:setPriority(1)
animations.main["extra6"]:setPriority(1)
animations.main["extra7"]:setPriority(1)
animations.main["jumping"]:setPriority(1)
animations.main["freezing"]:setPriority(1)
animations.main["fall"]:setPriority(2)
animations.main["useR"]:setPriority(3)
animations.main["useL"]:setPriority(3)
animations.main["attackR"]:setPriority(3)
animations.main["attackL"]:setPriority(3)
animations.main["mineR"]:setPriority(3)
animations.main["mineL"]:setPriority(3)
animations.main["blockR"]:setPriority(3)
animations.main["blockL"]:setPriority(3)
animations.main["eatR"]:setPriority(3)
animations.main["eatL"]:setPriority(3)
animations.main["drinkR"]:setPriority(3)
animations.main["drinkL"]:setPriority(3)
animations.main["spyglassR"]:setPriority(3)
animations.main["spyglassL"]:setPriority(3)
animations.main["bowR"]:setPriority(3)
animations.main["bowL"]:setPriority(3)
animations.main["spearR"]:setPriority(3)
animations.main["spearL"]:setPriority(3)
animations.main["loadR"]:setPriority(3)
animations.main["loadL"]:setPriority(3)
animations.main["crossbowR"]:setPriority(3)
animations.main["crossbowL"]:setPriority(3)
animations.main["fishing"]:setPriority(4)
animations.main["hurt"]:setPriority(10)

-- 动画过渡
--两个动画切换时的帧混合设置
--注意：动画只会在过渡完成后才开始播放
animations.main["idle"]:blendTime(2)
animations.main["idle"]:onBlend("easeOutSine")
animations.main["crouch"]:blendTime(2)
animations.main["crouch"]:onBlend("easeOutSine")
animations.main["walk"]:blendTime(2)
animations.main["walk"]:onBlend("easeOutSine")
animations.main["sprint"]:blendTime(2)
animations.main["sprint"]:onBlend("easeOutSine")
animations.main["jumping"]:blendTime(1)
animations.main["jumping"]:onBlend("easeOutSine")
animations.main["fall"]:blendTime(2)
animations.main["fall"]:onBlend("easeOutSine")
animations.main["vehicle"]:blendTime(1)
animations.main["vehicleHorse"]:blendTime(1)
animations.main["vehicleBoat"]:blendTime(1)
animations.main["vehiclePig"]:blendTime(1)

events.ENTITY_INIT:register(function () --实体初始化时执行，如果执行某个函数出现了"Tried to access the Entity API before its initialization in the ENTITY_INIT event"请将该函数放至此处执行
    animations.main["parallel0"]:play() --加载时播放"parallel0"
    animations.main["pre_parallel0"]:play() --加载时播放"pre_parallel0"
    animations.main["pre_parallel1"]:play() --加载时播放"pre_parallel1"
    animations.main["pre_parallel2"]:play() --加载时播放"pre_parallel2"
    Barrier = require('scripts/barrier')
    eventsList:tickGunScreen()
    eventsList:tickArisLevelUpSound()
end)

--------------------------------------------------------------------------------------
--发光纹理（主要是因为这个比较难做遍历）
--另一种方法是，将原有的纹理复制一份，以'_e'作为文件名结尾，然后将需要发光的部分使用复制的纹理
--有关详细信息，请访问：https://wiki.figuramc.org/tutorials/Emissive%20Textures
local glowModelPart = { --这里设置需要设置发光的模型组
    playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Alice.Eyelid.RightEyelid.ysmGlowRightEye,
    playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Alice.Eyelid.LeftEyelid.ysmGlowLeftEye,
    playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Key.Eyelid_Key.YouYanBai2.YouYan6,
    playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Key.Eyelid_Key.ZuoYanBai2.YouYan7,
    playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.ysmGlowHalo,
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.GunFornt.GunFornt3.GunFornt5_RightLight.ysmGlow4,
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.GunFornt.GunFornt3.GunFornt5_LeftLight.ysmGlow5,
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.GunFornt.ysmGlowlight,
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.GunPower.ysmGlowGunPower,
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part4.bone5.ysmGlow,
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part5.part5_Right.part51_Right.ysmGlowtuan,
    models.skull.Skull.Face.Eyes.Eye_Alice.Eyelid.LeftEyelid.ysmGlowLeftEye,
    models.skull.Skull.Face.Eyes.Eye_Alice.Eyelid.RightEyelid.ysmGlowRightEye,
    models.skull.Skull.ysmGlowHalo
}
if (#glowModelPart ~= 0) then
    for i = 1, #(glowModelPart), 1 do
        glowModelPart[i]:setLight(15)
    end
end

local glowModelPartEyes = { --类似于末影人眼睛的发光模式
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part5.part5_Left.part51_Right2.Alice_char,
    playerModel.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part5.part5_Right.part51_Right.Alice_char2,
}
if (#glowModelPartEyes ~= 0) then
    for i = 1, #(glowModelPartEyes), 1 do
        glowModelPartEyes[i]:setPrimaryRenderType("EYES")
    end
end
--------------------------------------------------------------------------------------

local cameraHeight = -0.15  --摄像机高度，0表示为原版，设为-0.5则为原版的一半高度，以此类推

events.RENDER:register(function (delta, context)    --渲染一帧时执行一次
    --第一人称手臂渲染
    local firstPerson=context=="FIRST_PERSON"
    playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.Arm:setVisible(not firstPerson) --隐藏原模型的手臂
    models.arm:setVisible(firstPerson) --在第一人称渲染arms模型的手臂
    --动画速度随玩家速度变化
    local vel = player:getVelocity()
    animations.main["walk"]:speed(vel.xz:length()*6)   --向前走
    --animations.main["walkback"]:speed(vel:length()*6)   --向后走
    if (context == "FIRST_PERSON" or context == "RENDER") then  --摄像机高度相关设定
        local camera = vec(0, player:getEyeHeight() * (cameraHeight), 0)
        renderer:offsetCameraPivot(camera)
        renderer:setCameraPos(0, 0, context == "FIRST_PERSON" and 0 or 0)
        renderer:setEyeOffset(camera)
    end
end)
