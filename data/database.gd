extends Resource

var upgrades := {
	0: {
		"name": "Bounty Bonus", "max_level": 0,
		"descriptions": ["+1 Coin"],
		"icon": null
	},
	1: {"name": "Cat Paw", "max_level": 11,
	"descriptions": [
		"A reliable wrist-mounted shotgun.", #0
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
	"icon": null,
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.5, 0.5, 0.4, 0.4, 0.2, 0.2],
	},
	2: {"name": "Catalyst", "max_level": 11,
	"descriptions": [
		"Punchy.",
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
	"icon": null,
	"damage": [1, 1.5, 2, 2, 3, 4, 5, 6, 7, 8, 10],
	"cooldown": [0.2, 0.2, 0.2, 0.1, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05],
	},
	3: {"name": "Catapult", "max_level": 11,
	"descriptions": [
		"Pierching shots.", #0
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
	"icon": null,
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.5, 0.5, 0.4, 0.4, 0.2, 0.2],
	"attack_range": [128,128,128,128,128,128,128,128,128,128,128]
	},
	4: {"name": "Cataract", "max_level": 11,
	"descriptions": [
		"High rate of fire.",
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
	"icon": null,
	"damage": [1, 1.5, 2, 2, 2, 4, 5, 5, 7, 8, 10],
	"cooldown": [0.2, 0.2, 0.2, 0.1, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05],
	"attack_range": [128,128,128,128,256,256,256,384,384,384,384]
	},
	5: {"name": "Catacomb", "max_level": 11,
	"descriptions": [
		"Hard punching homing attacks.",
		"Level 2: Damage +20% from Base",
		"Level 3: Fire Rate +25% from Base",
		"Level 4: Damage +60% from Base",
		"Level 5: Range +100% from Base",
		"Level 6: Damage +100% from Base",
		"Level 7: Fire Rate +100% from Base",
		"Level 8: Damage +200% from Base",
		"Level 9: Range +200% from Base",
		"Level 10: Damage +300% from Base",
		"Level 11: Damage +400% from Base",
	],
	"icon": null,
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.8, 0.8, 0.5, 0.5, 0.5, 0.5],
	"attack_range": [128,128,128,128,256,256,256,256,384,384,384]
	},
	6: {"name": "Catastrophe", "max_level": 11,
	"descriptions": [
		"A continuous stream of destruction.",
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
	"icon": null,
	"damage": [1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 10],
	"cooldown": [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1],
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
