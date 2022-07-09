-- 7.75, 1.5, 3, 5, 6, 7, 0
local daBeats = {
    [7.75] = {7.75, false},
    [1.5] = {1.5, false},
    [3] = {3, false},
    [5] = {5, false},
    [6] = {6, false},
    [7] = {7, false},
    [0] = {0, false}
}

-- 0, 1, 2.5, 3.25
-- 2.5 is true instead of false
local beginBeats = {
    [0] = {0, false},
    [1] = {1, false},
    [2.5] = {2.5, true},
    [3] = {3, false}
}

function onStepHit()
    if (curStep >= 255 and curStep < 384) then
        doTheThing(curStep / 4, daBeats, 8, 1)
    else
        if ((curBeat <= 28) or (curBeat >= 32)) then
            doTheThing(curStep / 4, beginBeats, 4, 0.8)
        else
            doTheThing(curStep / 4, {
                [0] = {0, false},
                [2] = {2, false}
            }, 4, 1)
        end
    end
end

local wasBounceNeg = false
function doTheThing(val, table, div, strength)
    local daBeat = val % div
    -- debugPrint(daBeat)
    if (table[daBeat][1] == daBeat) then
        -- debugPrint("Bounce!")
        local bounce = strength

        if (wasBounceNeg == true) then
            wasBounceNeg = false
            bounce = bounce * 2.75
        end

        if (table[daBeat][2] == true) then
            bounce = bounce * -1.5
            wasBounceNeg = true
        end
        triggerEvent('Add Camera Zoom', 0.03 * bounce, 0.03 * (bounce * 4))
    end
end
