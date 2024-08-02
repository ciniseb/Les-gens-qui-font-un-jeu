extends CharacterBody2D

#ms = movement speed
@export var ms = 200.0
@export var hp = 100

@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	#calcule la direction et la vitesse du joueur
	var x_mov = Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left")
	var y_mov = Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized()*ms
	#animation
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0:
		sprite.flip_h = false
	if mov != Vector2.ZERO:
		if walkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 1
			else:
				sprite.frame += 1
			walkTimer.start()
	#update la position du joueur
	move_and_slide()


func _on_hurtbox_hurt(damage):
	hp -= damage # Replace with function body.
	print(hp)
	
