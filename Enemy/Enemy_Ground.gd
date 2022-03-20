extends KinematicBody2D

export var speed = 100
export var damage = 20
export var max_constraint = 1600 
export var min_constraint = 1200
var direction = 1
var velocity = Vector2.ZERO

func _physics_process(delta):
	if direction < 0 and !$Sprite.flip_h: 
		$Sprite.flip_h = true
	if direction > 0 and $Sprite.flip_h:
		$Sprite.flip_h = false 
	
	velocity.x = direction * speed 
	move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	if velocity.x != 0 and body.name == "Platform" or body.name == "Ground":
		velocity.x = 0
		direction *= -1
	if body.name == "Player":
		body.do_damage(damage)
