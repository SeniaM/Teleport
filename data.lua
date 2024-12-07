local button={
    type = "custom-input",
    name = "my-custom-input",
    key_sequence = "SHIFT + G",
    consuming = "none"
}

local myFire = table.deepcopy(data.raw.fire["fire-flame"])
myFire.name = "my-fire"
myFire.damage_per_tick = {amount = 0, type = "impact"}

data:extend{button, myFire}