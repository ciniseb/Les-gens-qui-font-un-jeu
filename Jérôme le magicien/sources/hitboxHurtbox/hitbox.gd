extends Area2D

@export var damage = 1


@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableHitboxTimer

func tempdisable():
	collision.set_deferred("disabled", true)
	disableTimer.start()

func _on_disable_hitbox_timer_timeout():
	collision.set_deferred("disabled", false)
