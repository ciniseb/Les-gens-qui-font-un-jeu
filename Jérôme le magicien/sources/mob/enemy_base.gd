extends CharacterBody2D

#ms = movement speed
@export var ms = 50.0
@export var hp = 10
@onready var sprite = $Sprite2D
@onready var player = get_tree().get_first_node_in_group("joueur")
@onready var anim = $AnimationPlayer
@onready var knockback_recovery = 3.5
var knockback = Vector2.ZERO

func _ready():
	anim.play("walk")
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*ms
	velocity += knockback
	move_and_slide()
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false
		
	


func _on_hurtbox_hurt(damage, angle, attack_knockback):
	hp -= damage
	knockback = angle*attack_knockback
	if hp <= 0:
		queue_free()
