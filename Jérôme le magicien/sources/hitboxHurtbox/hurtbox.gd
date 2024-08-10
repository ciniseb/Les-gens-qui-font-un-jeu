extends Area2D

@export_enum("cooldown", "hitOnce", "dissableHitBox") var hurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage, angle, attack_knockback)
var hit_once_array = []

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match hurtBoxType:
				0: #Cooldown
					collision.set_deferred("disabled", true)
					disableTimer.start()
				1: #Hit Once
					if not hit_once_array.has(area):
						hit_once_array.append(area)
						if not area.has_signal("remove_from_array"):
							if not area.is_connected("remove_from_array", Callable(self, "remove_from_list")):
								area.connect("remove_from_array", Callable(self, "remove_from_list"))
							
				2: #Dissable Hit Box
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			var attack_knockback = 0
			var angle = Vector2.ZERO
			if not area.get("direction") == null:
				angle = area.direction
			if not area.get("knockback") == null:
				attack_knockback = area.knockback
			emit_signal("hurt", damage, angle, attack_knockback)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)
			
func _on_disable_timer_timeout():
	collision.set_deferred("disabled", false)
	
func remove_from_list(object):
	if hit_once_array.has(object):
		hit_once_array.erase(object)
