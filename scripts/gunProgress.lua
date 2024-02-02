local frontProgressModel = models.main.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part5.part5_Left.part51_Right2.ProgressBar --定义正面进度条
local backProgressModel = models.main.MRoot.Root.MAllBody.AllBody.Gun.TendouAris_Gun.part5.part5_Right.part51_Right.ProgressBar2  --定义反面进度条

gunProgress = {
    frontProgressLevel = {  --设置正面进度条
        frontProgressModel.one,
        frontProgressModel.two,
        frontProgressModel.three,
        frontProgressModel.four,
        frontProgressModel.five,
        frontProgressModel.six
    },
    backProgressLevel = {   --设置反面进度条
        backProgressModel.one,
        backProgressModel.two,
        backProgressModel.three,
        backProgressModel.four,
        backProgressModel.five,
        backProgressModel.six
    },
    maxProgressLevel = 6,
    setGunProgressLevel = function(self,lv)   --设置进度条等级
        if lv>self.maxProgressLevel then
            lv = self.maxProgressLevel
        elseif lv<0 then
            lv = 0
        end
        for i = 1, lv do
            self.frontProgressLevel[i]:setPrimaryRenderType("EYES")
            self.backProgressLevel[i]:setPrimaryRenderType("EYES")
        end
        for k = 1, self.maxProgressLevel-lv do
            self.frontProgressLevel[self.maxProgressLevel-k+1]:setPrimaryRenderType(nil)
            self.backProgressLevel[self.maxProgressLevel-k+1]:setPrimaryRenderType(nil)
        end
    end
}

return gunProgress
