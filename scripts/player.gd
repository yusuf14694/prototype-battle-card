extends Area2D

@onready var anim = $AnimatedSprite2DPlayer

const max_hp := 30
var hp := 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_attack():
	anim.play("attack")
	await anim.animation_finished
	anim.play("idle")

func play_hurt():
	anim.play("hurt")
	await anim.animation_finished
	anim.play("idle")
	
func heal(amount: int):
	if(hp <= max_hp):
		hp += amount
		print("PLAYER HEALED FOR:", amount)
		print("HP after healed:", hp)

func take_damage(damage: int):
	print ("PLAYER HP Before damage:", hp)
	print ("DAMAGE TAKEN: ", damage)
	hp -= damage
	print ("PLAYER HP after:", hp)

	if (hp <= 0):
		die()

func die():
	print ("PLAYER DEAD")
	queue_free()
