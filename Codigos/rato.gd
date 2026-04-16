extends CharacterBody2D
class_name Rato

@export_category("Objects")
@export var _texture: Sprite2D = null

var _player_ref = null

func _on_dedection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		_player_ref = body

func _on_dedection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Players"):
		_player_ref = null
		_play_idle(last_dir)

const SPEED: float = 40.0
@export var attack_distance: float = 16.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _attack_timer: Timer = null
var is_attacking: bool = false
var last_dir: Vector2 = Vector2.DOWN

func _ready() -> void:
	animated_sprite.flip_h = false
	# connect animation_finished (accepts optional name)
	animated_sprite.connect("animation_finished", Callable(self, "_on_animated_sprite_animation_finished"))
	# create a one-shot timer as a fallback in case the signal doesn't fire
	_attack_timer = Timer.new()
	_attack_timer.one_shot = true
	_attack_timer.wait_time = 0.5
	_attack_timer.connect("timeout", Callable(self, "_on_attack_timer_timeout"))
	add_child(_attack_timer)

func _get_player_foot_position(player: Node) -> Vector2:
	var shape := player.get_node_or_null("CollisionShape2D")
	if shape == null:
		shape = player.find_node("CollisionShape2D", true, false)
	if shape != null and shape is Node2D:
		return (shape as Node2D).global_position
	# fallback: try AnimatedSprite2D child (use sprite global position as approx feet)
	var sprite := player.get_node_or_null("AnimatedSprite2D")
	if sprite != null and sprite is AnimatedSprite2D:
		return (sprite as Node2D).global_position
	# final fallback: player global position
	return player.global_position

func _physics_process(delta: float) -> void:
	if _player_ref != null and not is_attacking:
		var target_pos: Vector2 = _get_player_foot_position(_player_ref)
		var dir: Vector2 = global_position.direction_to(target_pos)
		var dist: float = global_position.distance_to(target_pos)
		if dist <= attack_distance:
			# start attack (do not move while attacking)
			is_attacking = true
			_play_attack(dir)
			velocity = Vector2.ZERO
		else:
			velocity = dir * SPEED
			_play_run(dir)
			move_and_slide()
	else:
		velocity = Vector2.ZERO

func _play_run(dir: Vector2) -> void:
	# Choose run animation based on dominant axis, flip horizontally for side
	if abs(dir.x) > abs(dir.y):
		animated_sprite.flip_h = dir.x > 0
		if animated_sprite.animation != "run_side":
			animated_sprite.play("run_side")
	elif dir.y < 0:
		if animated_sprite.animation != "run_up":
			animated_sprite.play("run_up")
	else:
		if animated_sprite.animation != "run_down":
			animated_sprite.play("run_down")

func _play_attack(dir: Vector2) -> void:
	# Play attack animation matching direction and start fallback timer
	var animname: String = ""
	if abs(dir.x) > abs(dir.y):
		animated_sprite.flip_h = dir.x > 0
		animname = "attack_side"
		animated_sprite.play(animname)
	elif dir.y < 0:
		animname = "attack_up"
		animated_sprite.play(animname)
	else:
		animname = "attack_down"
		animated_sprite.play(animname)

	# compute animation duration from SpriteFrames (frames / speed) and start timer
	var sf = animated_sprite.sprite_frames
	if sf != null and sf.has_animation(animname):
		var frames = sf.get_frame_count(animname)
		var speed = sf.get_animation_speed(animname)
		var duration = 0.15
		if speed > 0.0:
			duration = frames / speed
		_attack_timer.wait_time = duration
		_attack_timer.start()

func _on_animated_sprite_animation_finished(anim_name: StringName = "") -> void:
	var aname: String = ""
	if anim_name != "":
		aname = String(anim_name)
	else:
		aname = String(animated_sprite.animation)
	if aname.begins_with("attack"):
		is_attacking = false
		if _attack_timer != null:
			_attack_timer.stop()

func _on_attack_timer_timeout() -> void:
	# fallback: ensure we exit attack state
	is_attacking = false

func _play_idle(dir: Vector2) -> void:
	var sf = animated_sprite.sprite_frames
	# If there are idle animations, use them; otherwise stop on the appropriate run frame
	if sf != null and (sf.has_animation("idle_down") or sf.has_animation("idle_up") or sf.has_animation("idle_left") or sf.has_animation("idle_right") or sf.has_animation("idle_side")):
		if abs(dir.x) > abs(dir.y):
			animated_sprite.flip_h = dir.x > 0
			if sf.has_animation("idle_side"):
				animated_sprite.play("idle_side")
			elif sf.has_animation("idle_left") and dir.x < 0:
				animated_sprite.play("idle_left")
			elif sf.has_animation("idle_right") and dir.x > 0:
				animated_sprite.play("idle_right")
			else:
				if dir.y < 0:
					animated_sprite.play("idle_up")
				else:
					animated_sprite.play("idle_down")
		elif dir.y < 0:
			animated_sprite.play("idle_up")
		else:
			animated_sprite.play("idle_down")
	else:
		if abs(dir.x) > abs(dir.y):
			animated_sprite.flip_h = dir.x > 0
			animated_sprite.animation = "run_side"
		elif dir.y < 0:
			animated_sprite.animation = "run_up"
		else:
			animated_sprite.animation = "run_down"
		animated_sprite.stop()
