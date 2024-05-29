class_name PlayerController extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var staff : Staff = $staff

# @export var bullet: PackedScene;

func _ready():
	staff.ownerOfProjectile = self
	staff.spawnProjectileTargetNode = get_parent()

var click_position := Vector2()
var target_position := Vector2()
var speed:float = 10000.0

func _physics_process(delta: float):
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	if Input.is_action_just_pressed("move-to-point"):

		click_position = get_global_mouse_position()
		navigation_agent.target_position = click_position


	if Input.is_action_pressed("attack-basic"):
		staff.try_cast_fireball()
	elif Input.is_action_just_released("attack-basic"):
		pass


	if !navigation_agent.is_navigation_finished():
		velocity = current_agent_position.direction_to(next_path_position) * speed * delta

		move_and_slide()
	else:
		animated_sprite.play("idle_south")


