--七段数码管显示
local frontDisplayModel = models.main.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part5.part5_Left.part51_Right2.SSDisplay --定义正面数码管ModelPart
local backDisplayModel = models.main.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part5.part5_Right.part51_Right.SSDisplayBack  --定义反面数码管ModelPart

local frontFirstDisplayModel = {  --定义正面第一位数码管
    frontDisplayModel.first.a,
    frontDisplayModel.first.b,
    frontDisplayModel.first.c,
    frontDisplayModel.first.d,
    frontDisplayModel.first.e,
    frontDisplayModel.first.f,
    frontDisplayModel.first.g
}

local frontSecondDisplayModel = { --定义正面第二位数码管
    frontDisplayModel.second.a,
    frontDisplayModel.second.b,
    frontDisplayModel.second.c,
    frontDisplayModel.second.d,
    frontDisplayModel.second.e,
    frontDisplayModel.second.f,
    frontDisplayModel.second.g
}

local frontThirdDisplayModel = {  --定义正面第三位数码管
    frontDisplayModel.third.a,
    frontDisplayModel.third.b,
    frontDisplayModel.third.c,
    frontDisplayModel.third.d,
    frontDisplayModel.third.e,
    frontDisplayModel.third.f,
    frontDisplayModel.third.g
}

local frontForthDisplayModel = {  --定义正面第四位数码管
    frontDisplayModel.forth.a,
    frontDisplayModel.forth.b,
    frontDisplayModel.forth.c,
    frontDisplayModel.forth.d,
    frontDisplayModel.forth.e,
    frontDisplayModel.forth.f,
    frontDisplayModel.forth.g
}

local frontFifthDisplayModel = {  --定义正面第五位数码管
    frontDisplayModel.fifth.a,
    frontDisplayModel.fifth.b,
    frontDisplayModel.fifth.c,
    frontDisplayModel.fifth.d,
    frontDisplayModel.fifth.e,
    frontDisplayModel.fifth.f,
    frontDisplayModel.fifth.g
}

local backFirstDisplayModel = {   --定义反面第一位数码管
    backDisplayModel.first2.a,
    backDisplayModel.first2.b,
    backDisplayModel.first2.c,
    backDisplayModel.first2.d,
    backDisplayModel.first2.e,
    backDisplayModel.first2.f,
    backDisplayModel.first2.g,
}

local backSecondDisplayModel = {  --定义反面第二位数码管
    backDisplayModel.second2.a,
    backDisplayModel.second2.b,
    backDisplayModel.second2.c,
    backDisplayModel.second2.d,
    backDisplayModel.second2.e,
    backDisplayModel.second2.f,
    backDisplayModel.second2.g
}

local backThirdDisplayModel = {   --定义反面第三位数码管
    backDisplayModel.third2.a,
    backDisplayModel.third2.b,
    backDisplayModel.third2.c,
    backDisplayModel.third2.d,
    backDisplayModel.third2.e,
    backDisplayModel.third2.f,
    backDisplayModel.third2.g
}

local backForthDisplayModel = {  --定义反面第四位数码管
    backDisplayModel.forth2.a,
    backDisplayModel.forth2.b,
    backDisplayModel.forth2.c,
    backDisplayModel.forth2.d,
    backDisplayModel.forth2.e,
    backDisplayModel.forth2.f,
    backDisplayModel.forth2.g
}

local backFifthDisplayModel = {  --定义反面第五位数码管
    backDisplayModel.fifth2.a,
    backDisplayModel.fifth2.b,
    backDisplayModel.fifth2.c,
    backDisplayModel.fifth2.d,
    backDisplayModel.fifth2.e,
    backDisplayModel.fifth2.f,
    backDisplayModel.fifth2.g
}

local frontDisplay = {    --定义正面数码管
    [1] = frontFirstDisplayModel,
    [2] = frontSecondDisplayModel,
    [3] = frontThirdDisplayModel,
    [4] = frontForthDisplayModel,
    [5] = frontFifthDisplayModel
}

local backDisplay = { --定义反面数码管
    [1] = backFirstDisplayModel,
    [2] = backSecondDisplayModel,
    [3] = backThirdDisplayModel,
    [4] = backForthDisplayModel,
    [5] = backFifthDisplayModel
}

local num2Segment = { --数码管编码，参考：https://blog.csdn.net/feinifi/article/details/121878154
    [-1] = {0,0,0,0,0,0,0}, --占位符，表示关闭
    [0] = {1,1,1,1,1,1,0},  --0
    [1] = {0,1,1,0,0,0,0},  --1
    [2] = {1,1,0,1,1,0,1},  --2
    [3] = {1,1,1,1,0,0,1},  --3
    [4] = {0,1,1,0,0,1,1},  --4
    [5] = {1,0,1,1,0,1,1},  --5
    [6] = {1,0,1,1,1,1,1},  --6
    [7] = {1,1,1,0,0,0,0},  --7
    [8] = {1,1,1,1,1,1,1},  --8
    [9] = {1,1,1,1,0,1,1},  --9
    [10] = {1,1,1,0,1,1,1},  --A
    [11] = {0,0,1,1,1,1,1},  --B
    [12] = {1,0,0,1,1,1,0},  --C
    [13] = {0,1,1,1,1,0,1},  --D
    [14] = {1,0,0,1,1,1,1},  --E
    [15] = {1,0,0,0,1,1,1},  --F
}

local maxBit = 5    --最大位数

SSDisplay = {
    setSegmentDisplay = function(num,seg) --设置指定位数的数字
        if num>=-1 and num<=#num2Segment and num%1==0 and seg>=1 and seg<=maxBit and seg%1==0 then
            for j, bit in ipairs(num2Segment[num]) do
                if bit == 1 then
                    frontDisplay[seg][j]:setPrimaryRenderType("EYES")
                    backDisplay[seg][j]:setPrimaryRenderType("EYES")
                elseif bit == 0 then
                    frontDisplay[seg][j]:setPrimaryRenderType(nil)
                    backDisplay[seg][j]:setPrimaryRenderType(nil)
                end
            end
        end
    end,
    cleanDisplay = function(self)
        self.setSegmentDisplay(-1,1)
        self.setSegmentDisplay(-1,2)
        self.setSegmentDisplay(-1,3)
        self.setSegmentDisplay(-1,4)
        self.setSegmentDisplay(-1,5)
    end,
    SSDisplayOutNum = function(self,num)   --设置数码管要显示的数字
        if not(num < -1 or num >= 99999 and num%1 ~= 0) then    --输入值检测
            local digitsTable = {}
            while num > 0 do
                local digit = num % 10
                table.insert(digitsTable, 1, digit) -- 将数字从右到左插入table，如输入1234，则table为{1,2,3,4}
                num = (num - digit) / 10
            end
            if #digitsTable < maxBit then   --当输入的数字位数小于最大位数时...
                for e=1, maxBit-#digitsTable do
                    table.insert(digitsTable,1,0)   --在table左侧插入数字0直到填满
                end
            end
            -- 打印结果
            for i, digit in ipairs(digitsTable) do
                self.setSegmentDisplay(digit, i)
            end
        else
            print("[SSDisplay] Invaild input:",num)
        end
    end
}

return SSDisplay
