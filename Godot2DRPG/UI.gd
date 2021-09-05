extends Control

onready var levelText : Label = get_node("Background/LevelBG/Level")
onready var healthBar : TextureProgress = get_node("Background/HealthBar")
onready var XPBar : TextureProgress = get_node("Background/XPBar")
onready var goldText : Label = get_node("Background/Gold")
onready var healthText : Label = get_node("Background/HealthBar/HPText")
onready var XPText : Label = get_node("Background/XPBar/XPText")

func update_level_text(level):
	levelText.text = str(level)
	
func update_healthbar(currentHP, maxHP):
	healthBar.value = round((float(currentHP) / float(maxHP)) * 100)
	healthText.text = str(currentHP) + " / " + str(maxHP)
	
func update_xpbar(currentXP, xpToNextLvl):
	XPBar.value = round((float(currentXP) / float(xpToNextLvl)) * 100)
	XPText.text = str(currentXP) + " / " + str(xpToNextLvl)
	
func update_gold_text(gold):
	goldText.text = "Gold: " + str(gold)
