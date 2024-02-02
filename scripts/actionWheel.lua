--动作轮初始化
actionMainPage = action_wheel:newPage()
action_wheel:setPage(actionMainPage)
local playerModel = models.main --定义玩家模型
local velocity

local extraAnimsList = {    --额外动画列表
    animations.main["extra0"],
    animations.main["extra1"],
    animations.main["extra2"],
    animations.main["extra3"],
    animations.main["extra4"],
    animations.main["extra5"],
    animations.main["extra6"],
    animations.main["extra7"]
}

function pings.stopExtraAnim(num)   --停止指定的额外动画
    extraAnimsList[num+1]:stop()
end

function extraAnimsCheck()
    for i = 1, (#extraAnimsList) do
        if extraAnimsList[i]:isPlaying() then
            return i-1
        end
    end
    return nil
end

function events.tick()
    if player:isLoaded() then
        velocity = player:getVelocity() --获取玩家动量
        if (velocity.xyz:length() ~= 0) or (player:getPose() == "CROUCHING") then
            if extraAnimsCheck() ~= nil then
                pings.stopExtraAnim(extraAnimsCheck())
            end
        end
    end
end

function pings.playExtraAnim(num)   --触发类动画
    if extraAnimsCheck() ~= nil then
        pings.stopExtraAnim(extraAnimsCheck())
    end
    extraAnimsList[num+1]:play()
end

function pings.keyEyes(state)   --key眼睛切换
    if state then
        playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Key:setPos(0,0,-3)
        playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Alice:setPos(0,0,3)
    else
        playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Key:setPos(0,0,0)
        playerModel.MRoot.Root.MAllBody.AllBody.MUpBody.UpBody.AllHead.MHead.Head.boneHead.Face.Eyes.Eye_Alice:setPos(0,0,0)
    end
end

local extra0 = actionMainPage:newAction(1)
    :title(Language:getTranslate("action_wheel_extra0_desc"))
    :item("red_wool")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(0) end)

local extra1 = actionMainPage:newAction(2)
    :title(Language:getTranslate("action_wheel_extra1_desc"))
    :item("green_wool")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(1) end)

local extra2 = actionMainPage:newAction(3)
    :title(Language:getTranslate("action_wheel_extra2_desc"))
    :item("blue_wool")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(2) end)

local extra3 = actionMainPage:newAction(4)
    :title(Language:getTranslate("action_wheel_extra3_desc"))
    :item("diamond_sword")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(3) end)

local extra4 = actionMainPage:newAction(5)
    :title(Language:getTranslate("action_wheel_extra4_desc"))
    :item("golden_sword")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(4) end)

local extra5 = actionMainPage:newAction(6)
    :title(Language:getTranslate("action_wheel_extra5_desc"))
    :item("nether_star")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(5) end)

local extra6 = actionMainPage:newAction(7)
    :title(Language:getTranslate("action_wheel_extra6_desc"))
    :item("pink_wool")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(6) end)

local extra7 = actionMainPage:newAction(8)
    :title(Language:getTranslate("action_wheel_extra7_desc"))
    :item("netherite_helmet")
    :color(vectors.hexToRGB('#000'))
    :onLeftClick(function() pings.playExtraAnim(7) end)

local key = actionMainPage:newAction(9)
    :title(Language:getTranslate("action_wheel_keyToggle_desc"))
    :item("ender_eye")
    :color(vectors.hexToRGB('#000'))
    :onToggle(function(state) pings.keyEyes(state) end)