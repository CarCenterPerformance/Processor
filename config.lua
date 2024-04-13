Config = {}

Config.verarbeiter = {
    ['Eisen'] = {
        coords = vector3(-1558.5662, 1437.4132, 116.7582),
        item = "eisenerz",
        itemverarbeitet = "eisenbarren",
        blip = {
            enabled = true,
            sprite = 237,
            display = 2,
            scale = 0.8,
            color = 57,
            text = "Eisen Verarbeiter"
        }
    },

    ['Kupfer'] = {
        coords = vector3(2339.2756, 3054.1482, 48.1518), --Location from the processor
        item = "kupfererz", --Item what you need
        itemverarbeitet = "kupferbarren", --Item what you get
        blip = {
            enabled = true, -- Blip on/off (true= on / false = off)
            sprite = 237, 
            display = 2, 
            scale = 0.7, 
            color = 41,
            text = "Kupfer Verarbeiter" --Blip Name
        }
    },
    ['Oil'] = {
        coords = vector3(597.2090, 2928.9243, 40.9165),
        item = "rohoil",
        itemverarbeitet = "raffoil",
        blip = {
            enabled = true,
            sprite = 237,
            display = 2,
            scale = 0.7,
            color = 41,
            text = "Öl Verarbeiter"
        }
    }
}

Config.Ped = true -- If you want to use NPCs leave it on, if not set it to false

Config.Npc = {
    {2339.2756, 3054.1482, 48.1518, nil, 251.8272, nil, -1395868234}, --Kupfer NPC
    {597.2090, 2928.9243, 40.9165, nil, 47.9226, nil, -1395868234} -- Öl NPC
}






