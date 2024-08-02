extends Area2D

@export_enum("cooldown", "hitOnce", "dissableHitBox") var hurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match hurtBoxType:
				0: #Cooldown
					collision.set_deferred("disabled", true)
					disableTimer.start()
				1: #Hit Once
					pass
				2: #Dissable Hit Box
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt", damage)
			
func _on_disable_timer_timeout():
	collision.set_deferred("disabled", false)
