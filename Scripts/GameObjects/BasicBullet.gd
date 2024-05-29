class_name BasicBullet extends Area2D

@export var bulletStats: ProjectileStats

@onready var spriteAnimation : AnimatedSprite2D = $animatedSprite2d

var distanceToRemain: float
var direction: Vector2
var projectileOwner: Node

func _ready():
	spriteAnimation.play()


func initalise(shooter: Node, intialPosition: Vector2, pointDirection: Vector2) -> void:
	global_position = intialPosition
	distanceToRemain= bulletStats.baseRange
	projectileOwner = shooter

	direction = pointDirection
	global_rotation = pointDirection.angle()


func _physics_process(delta:float) -> void:
	var vecocity = direction * bulletStats.baseSpeed * delta
	global_position += vecocity
	distanceToRemain -= vecocity.length()
	print(distanceToRemain)

	if distanceToRemain <= 0.0:
		print("dead by time")
		Remove()

func onarea_entered(_area: Area2D):
	Remove()


func Remove():
	get_parent().remove_child(self)


func HitPhysicalObject(_body:Node2D):
	Remove()
