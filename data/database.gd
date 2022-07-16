extends Resource

var upgrades := {
	0: {
		"name": "Bounty Bonus", "max_level": 0,
		"descriptions": ["+1 Coin"],
		"icon": preload("res://assets/Pickups/coin_26.png")
	},
	1: {"name": "Cat's Paw", "max_level": 11,
	"descriptions": [
		"A solid punch of a spell.", #0
		"Level 2: Damage +20% from Base", #1
		"Level 3: Fire Rate +25% from Base",
		"Level 4: Damage +60% from Base",
		"Level 5: Fire Rate +100% from Base",
		"Level 6: Damage +100% from Base",
		"Level 7: Fire Rate +150% from Base",
		"Level 8: Damage +200% from Base",
		"Level 9: Fire Rate +400% from Base",
		"Level 10: Damage +300% from Base",
		"Level 11: Damage +400% from Base",
	],
	"sprite": null,
	"icon": preload("res://assets/GUI/Icons/paw-print.svg"),
	"damage": [5, 6, 6, 6, 6, 10, 10, 15, 15, 20, 25],
	"cooldown": [0.4, 0.4, 0.32, 0.32, 0.2, 0.2, 0.16, 0.16, 0.08, 0.08],
	"attack_range": [128,128,128,128,128,128,128,128,128,128,128]
	},
	2: {"name": "Catabolize", "max_level": 11,
	"descriptions": [ # Red
		"Unstoppable balls of flame.", # 0
		"Level 2: Damage +50% from Base", #1
		"Level 3: Damage +100% from Base",
		"Level 4: Fire Rate +100% from Base",
		"Level 5: Damage +200% from Base",
		"Level 6: Damage +300% from Base",
		"Level 7: Damage +400% from Base",
		"Level 8: Damage +500% from Base",
		"Level 9: Damage +600% from Base",
		"Level 10: Damage +700% from Base",
		"Level 11: Damage +900% from Base",
	],
	"sprite": null,
	"icon": preload("res://assets/GUI/Icons/hairymnstr_seasons_autumn.svg"),
	"damage": [10, 15, 20, 20, 30, 40, 50, 60, 70, 80, 100],
	"cooldown": [2.0, 2.0, 2.0, 1.0, 1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
	"attack_range": [128,128,128,128,128,128,128,128,128,128,128]
	},
	3: {"name": "Cataclysm", "max_level": 11,
	"descriptions": [ # Yellow
		"Destructive bolts of lightning.", #0
		"Level 2: Damage +20% from Base",
		"Level 3: Fire Rate +25% from Base",
		"Level 4: Damage +60% from Base",
		"Level 5: Fire Rate +100% from Base",
		"Level 6: Damage +100% from Base",
		"Level 7: Fire Rate +150% from Base",
		"Level 8: Damage +200% from Base",
		"Level 9: Fire Rate +400% from Base",
		"Level 10: Damage +300% from Base",
		"Level 11: Damage +400% from Base",
	],
	"sprite": null,
	"icon": preload("res://assets/GUI/Icons/hairymnstr_seasons_summer.svg"),
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.5, 0.5, 0.4, 0.4, 0.2, 0.2],
	"attack_range": [128,128,128,128,128,128,128,128,128,128,128]
	},
	4: {"name": "Cataract", "max_level": 11,
	"descriptions": [ # Blue
		"A flood of cutting shards.",
		"Level 2: Damage +50% from Base", #1
		"Level 3: Damage +100% from Base",
		"Level 4: Fire Rate +100% from Base",
		"Level 5: Range +100% from Base",
		"Level 6: Damage +300% from Base",
		"Level 7: Damage +400% from Base",
		"Level 8: Range +200% from Base",
		"Level 9: Damage +600% from Base",
		"Level 10: Damage +700% from Base",
		"Level 11: Damage +900% from Base",
	],
	"sprite": null,
	"icon": preload("res://assets/GUI/Icons/hairymnstr_seasons_winter.svg"),
	"damage": [1, 1.5, 2, 2, 2, 4, 5, 5, 7, 8, 10],
	"cooldown": [2, 2, 2, 1, 1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
	"attack_range": [64,64,64,64,128,128,128,192,192,192,192]
	},
	5: {"name": "Catastrophe", "max_level": 11,
	"descriptions": [ # Green
		"Chasing blades of wind.",
		"Level 2: Range +100% from Base", #1
		"Level 3: Damage +100% from Base",
		"Level 4: Range +200% from Base",
		"Level 5: Damage +200% from Base",
		"Level 6: Damage +300% from Base",
		"Level 7: Damage +400% from Base",
		"Level 8: Damage +500% from Base",
		"Level 9: Damage +600% from Base",
		"Level 10: Damage +700% from Base",
		"Level 11: Damage +900% from Base",
	],
	"sprite": null,
	"icon": preload("res://assets/GUI/Icons/hairymnstr_seasons_spring.svg"),
	"damage": [1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 10],
	"cooldown": [0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2],
	"attack_range": [128,256,256,384,384,384,384,384,384,384,384]
	},
}

var perm_upgrades := {
	0: {
		"name": "Max Health Scaling",
		"info": [
			"+5 Max Health per Level",
			"+10 Max Health per Level"
		]
	},
	1: {
		"name": "Regeneration"
	}
}
