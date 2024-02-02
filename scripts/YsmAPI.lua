--Created by KLuoNuoYa and Morrussa

--[[
使用样例：
    原molang：
        ysm.head_pitch
        0.4*ysm.head_yaw
        math.clamp(query.ground_speed*1.5, 0, 35)
        (ysm.head_yaw>0) ? (-ysm.head_yaw+42) : (42)
    替换后：
        ysm.headPitch()
        0.4*ysm.headYaw()
        math.clamp(query.groundSpeed()*1.5, 0, 35)
        (ysm.headYaw()>0) and (-ysm.headYaw()+42) or (42)
]]

ysm = {}
query = {}
local PI = 3.1416
local E = 2.7183
local tickYsmBlink = 0
local lifeTimes = 0

function events.tick()
    tickYsmBlink = tickYsmBlink + 1
    lifeTimes = lifeTimes + 1
end

function lIf(a, b)
    --二元运算
    --a为真则返回b，否则返回0
    --即YSM中的 a?b
    --实际上，我们建议您将 "a?b" 替换成 "a and b or 0" 而不是调用此函数
    return a and b or 0
end

function lIfElse(a, b, c)
    --三元运算
    --a为真则返回b，否则返回c
    --即YSM中的 a?b:c
    --实际上，我们建议您将 "a?b:c" 替换成 "a and b or c" 而不是调用此函数
    return a and b or c
end

function math.dieRoll(num, low, high)
    --返回 “num” 个随机数的总和，每个值的范围从低到高。
    --注意：生成的随机数不是像普通骰子那样的整数。为此，请使用math.dieRollInteger()
    local n = 0
    for i=1, num do
        n = n + (low + math.random() * (high - low))
    end
    return n
end

function math.dieRollInteger(num, low, high)
    --返回 “num” 个随机整数的总和，每个整数的值从低到高。
    --注意：生成的随机数是类似于正常骰子的整数。
    local n = 0
    for i=1, num do
        n = n + (math.round(low + math.random() * (high - low)))
    end
    return n
end

function math.hermiteBlend(t)
    --使用Hermite基础函数之一进行简单的平滑曲线插值很有用：3t ^ 2-2t ^ 3。
    --请注意，尽管任何有效的float都是有效的输入，但此功能在[0,1]范围内效果最佳。
    return 3 * t ^ 2 - 2 * t ^ 3
end

function math.lerp(r, e, t)
    --在r和e之间根据0~1取中间值
    if t < 0 then
        t = 0
    elseif t > 1 then
        t = 1
    end
    return r + (e - r) * t
end

function math.lerprotate(r, e, t)
    --作为角度，在r和e之间根据0~1取中间值，360度时会有跨越
    function s(n)
        return (((n + 180) % 360) + 180) % 360
    end
    if r == s(r) and e == s(e) and r > e then
        local a = r
        r = e
        e = a
    end
    return e - r > 180 and s(e + t * (360 - (e - r))) or r + t * (e - r)
end

function math.ln(x)
    --对数
    return math.log(x, E)
end

function math.randomFloat(min, max)
    --生成带小数的随机数
    --注意，由于lua语言的设定，使用'math.random(min, max)'生成的随机数必定为整数，即molang里的math.random_integer(min, max)
    return (min + math.random() * (max - min))
end

function math.round(x)
    --四舍五入取整
    return math.floor(x + 0.5)
end

function math.trunc(x)
    --截短取整
    if x >= 0 then
        return math.floor(x)
    else
        return math.ceil(x)
    end
end

function math.mod(x,y)
    --取模
    --诚然，你也可以在关键帧里用 x % y 来取模
    return x % y
end

function math.clamp(x, min, max)
    --限制 x 在 min 和 max 之间
    if x >= min then
        if x <= max then return x end
        return max
    end
    return min
end

function query.actorCount()
    --实体数量
    return client.getEntityCount()
end

function query.animTime()
    --当前动画播放时间（秒），如果动画未播放则为 0
    --（实际上Mod里面只会返回0）
    return 0
end

function query.bodyXRotation()
    --玩家身体 X 旋转角度，默认为 0
    return (player:getRot().x+180)%360-180
end

function query.bodyYRotation()
    --玩家身体 Y 旋转角度，默认为 0
    return (player:getRot().y+180)%360-180
end

function query.cardinalFacing2d()
    --玩家朝向（忽略上下朝向，北=2.0，南=3.0，西=4.0，东=5.0）
    local angel = (player:getRot().y+180)%360
    if angel <= 45 or angel > 315 then
        return 2
    elseif angel <= 135 and angel > 45 then
        return 5
    elseif angel <= 225 and angel > 135 then
        return 3
    elseif angel <= 315 and angel > 225 then
        return 4
    end
end

function query.distanceFromCamera()
    --玩家和镜头之间的距离
    ppos = player:getPos()
    cpos = client:getCameraPos()
    return math.sqrt((ppos.x-cpos.x)^2+(ppos.y-cpos.y)^2+(ppos.z-cpos.z)^2)
end

function query.equipmentCount()
    --玩家装备的护甲数量（0-4），不考虑手持物品
    local HelmetSlot = player:getItem(6).id ~= "minecraft:air" and 1 or 0
    local ChestplateSlot = player:getItem(5).id ~= "minecraft:air" and 1 or 0
    local LeggingsSlot = player:getItem(4).id ~= "minecraft:air" and 1 or 0
    local BootsSlot = player:getItem(3).id ~= "minecraft:air" and 1 or 0
    local result = HelmetSlot + ChestplateSlot + LeggingsSlot + BootsSlot
    return result
end

function query.eyeTargetXRotation()
    --玩家视角 X 旋转角度，默认为 0
    return player:getRot().x
end

function query.eyeTargetYRotation()
    --玩家视角 Y 旋转角度，默认为 0
    return player:getRot().y
end

function query.groundSpeed()
    --玩家速度（米/秒）
    --注：这里的ground speed和YSM的有区别，YSM调用的是原版的getDeltaMovement，而这里的值是根据玩家位置实时计算的。
    return player:getVelocity().xz:length()*20
end

function query.hasCape()
    --玩家有披风时为 true，否则为 false
    return player:hasCape()
end

function query.hasRider()
    --玩家被骑乘时为 true，否则为 false
    return player:getPassengers() ~= nil
end

function query.headXRotation()
    --玩家头部 X 旋转角度，默认为 0
    return vanilla_model.HEAD:getOriginRot().y
end

function query.headYRotation()
    --玩家头部 Y 旋转角度，默认为 0
    return vanilla_model.HEAD:getOriginRot().x
end

function query.health()
    --玩家血量
    return player:getHealth() + player:getAbsorptionAmount()
end

function query.hurtTime()
    --玩家受伤计时，默认为 0
    return player:getNbt().HurtTime
end

function query.isEating()
    --玩家正在进食时为 true，否则为 false
    return player:isUsingItem() and player:getActiveItem():getUseAction() == "EAT"
end

function query.isFirstPerson()
    --玩家处于第一人称视角时为 true，否则为 false
    return renderer:isFirstPerson()
end

function query.isInWater()
    --玩家在水中时为 true，否则为 false
    return player:isInWater()
end

function query.isInWaterOrRain()
    --玩家在水中或雨中时为 true，否则为 false
    return player:isInWater() or player:isInRain()
end

function query.isJumping()
    --玩家跳跃时为 true，否则为 false
    return player:getVelocity().y ~= 0 and not host:isFlying() and not player:isOnGround()
end

function query.isOnFire()
    --玩家着火时为 true，否则为 false
    return player:isOnFire()
end

function query.isOnGround()
    --玩家在地面时为 true，否则为 false
    return player:isOnGround()
end

function query.isPlayingDead()
    --玩家濒死状态时为 true，否则为 false
    return player:getDeathTime() > 0
end

function query.isRiding()
    --玩家骑乘时为 true，否则为 false
    return player:getVehicle() ~= nil
end

function query.isSleeping()
    --玩家睡觉时为 true，否则为 false
    return player:getPose() == "SLEEPING"
end

function query.sleepTimer()
    --自玩家开始睡觉之后经过的刻数。如果昼夜所定则该值不会发生变化。
    return player:getNbt().SleepTimer
end

function query.isSneaking()
    --玩家潜行时为 true，否则为 false
    return player:getPose() == "CROUCHING"
end

function query.isSpectator()
    --玩家是观察者模式时为 true，否则为 false
    return player:getGamemode() and player:getGamemode() == "SPECTATOR"
end

function query.isSprinting()
    --玩家疾跑时为 true，否则为 false
    return player:isSprinting()
end

function query.isSwimming()
    --玩家游泳时为 true，否则为 false
    return player:getPose() == "SWIMMING"
end

function query.isUsingItem()
    --玩家正在使用物品时为 true，否则为 false
    return player:isUsingItem()
end

function query.itemInUseDuration()
    --从 0 开始持续计数，直到该物品的最大可使用时长（秒），默认为 0
    return player:getActiveItemTime() / 20
end

function query.itemMaxUseDuration()
    --所使用的物品的最大可使用时长（秒），默认为 0
    return player:getActiveItem():getUseDuration() / 20
end

function query.itemRemainingUseDuration()
    --所使用的物品的剩余可使用时长（秒），默认为 0
    return (player:getActiveItem():getUseDuration() / 20) - (player:getActiveItemTime() / 20)
end

function query.lifeTime()
    --当前动画播放了多久（秒），如果动画未播放则为 0
    return lifeTimes / 20
end

function query.maxHealth()
    --玩家的最大血量
    return player:getMaxHealth()
end

function query.modifiedDistanceMoved()
    --玩家水平移动距离的总数（米）
    --TODO
end

function query.moonPhase()
    --当前月相（0-7）
    return world.getMoonPhase()
end

function query.playerLevel()
    --玩家的经验等级，默认为 0
    return player:getExperienceLevel()
end

function query.timeOfDay()
    --⼀天中的时间（午夜=0，日出=0.25，正午=0.5，日落=0.75）
    return (world.getTimeOfDay() + 30000) % 24000 / 24000
end

function query.timeSwamp()
    --当前所处世界的时间戳
    return world.getTimeOfDay()
end

function query.verticalSpeed()
    --玩家移动中垂直分量的速度（米/秒），朝上移动为正数
    return player:getVelocity().y *20
end

function query.walkDistance()
    --玩家步行移动距离的总数（米）
    --TODO
end

function query.yawSpeed()
    --实体 Y 角度旋转时的速度
    return player:getRot().y
end

function ysm.armorValue()
    --护甲值（0-20）
    return player:getArmor()
end

function ysm.hasHelmet()
    --玩家穿戴头盔时为 true，否则为 false
    return player:getItem(6).id ~= "minecraft:air"
end

function ysm.hasChestPlate()
    --玩家穿戴胸甲时为 true，否则为 false
    return player:getItem(5).id ~= "minecraft:air"
end

function ysm.hasLeggings()
    --玩家穿戴护腿时为 true，否则为 false
    return player:getItem(4).id ~= "minecraft:air"
end

function ysm.hasBoots()
    --玩家穿戴靴子时为 true，否则为 false
    return player:getItem(3).id ~= "minecraft:air"
end

function ysm.hasMainhand()
    --玩家主手持有物品时为 true，否则为 false
    return player:getHeldItem(player:isLeftHanded()).id ~= "minecraft:air"
end

function ysm.hasOffhand()
    --玩家副手持有物品时为 true，否则为 false
    return player:getHeldItem(not player:isLeftHanded()).id ~= "minecraft:air"
end

function ysm.isCloseEyes()
    --默认为 false，当玩家需要眨眼返回 true
    --5秒（100 ticks）的循环。第4秒（80 tick）至第4.25秒（85 tick）返回true，其它时间为false
    if tickYsmBlink >= 80 and tickYsmBlink <= 85 then
        return true
    elseif tickYsmBlink == 100 then
        tickYsmBlink = 0
    end
    return false
end

function ysm.isRiptide()
    --玩家处于激流状态时为 true，否则为 false
    return player:getPose() == "SPIN_ATTACK"
end

function ysm.hasElytra()
    --玩家穿戴鞘翅时返回 true，否则为 false
    return player:getItem(5).id == "minecraft:elytra"
end

function ysm.elytraRotX()
    --玩家鞘翅的 X 旋转角度
    return -vanilla_model.LEFT_ELYTRA:getOriginRot().x
end

function ysm.elytraRotY()
    --玩家鞘翅的 Y 旋转角度
    return vanilla_model.LEFT_ELYTRA:getOriginRot().y
end

function ysm.elytraRotZ()
    --玩家鞘翅的 Z 旋转角度
    return vanilla_model.LEFT_ELYTRA:getOriginRot().z
end

function ysm.headPitch()
    --上下视角
    return (vanilla_model.HEAD:getOriginRot().x-180)%360-180
end

function ysm.headYaw()
    --左右视角
    return (vanilla_model.HEAD:getOriginRot().y-180)%360-180
end

function ysm.foodLevel()
    --返回玩家饥饿值
    return player:getFood()
end
