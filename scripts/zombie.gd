extends Area2D

var max_hp:= 30
var hp := 30
@onready var anim = $AnimatedSprite2DZombie

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(amount: int):
	hp -= amount
	
	print("Zombie HP: ", hp)
	
	if hp <= 0:
		die()

func die():
	queue_free()

func play_hurt():
	anim.play("hurt")
	await anim.animation_finished
	anim.play("idle")
