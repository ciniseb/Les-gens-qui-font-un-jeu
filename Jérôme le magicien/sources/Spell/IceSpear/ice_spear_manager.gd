extends Node2D

var spell_level = 1
var onCooldown = false
var ice_spear = preload("res://sources/Spell/IceSpear/ice_spear.tscn")
@onready var cooldown = get_node("%cooldown")
@export var action = "action1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed(action) and not onCooldown:
		var new_ice_spear = ice_spear.instantiate()
		new_ice_spear.level = spell_level
		new_ice_spear.position = position
		add_sibling(new_ice_spear)
		#prépare le timer pour la prochaine fois que le spell est actif
		cooldown.start()
		onCooldown = true
		

func _on_cooldown_timeout():
	onCooldown = false
	pass # Replace with function body.
