extends MeshInstance

export var LIGHTEN = 0.5

onready var anim = get_child(0)
onready var player = get_parent().get_parent()
onready var anim_tree = get_node("AnimationTree")

const BLEND_AMOUNT1 = "parameters/IdleWalkBlend/blend_amount"
const BLEND_AMOUNT2 = "parameters/JumpBlend/blend_amount"
const BLEND_IDLE_SPEED = 3.0
const BLEND_WALK_SPEED = 5.0
const BLEND_JUMP_SPEED = 3.0

func attack_main_unlock():
	player.is_main_attacking = false
	pass

func attack_main_finished():
	anim_tree.active = true
	pass

func _ready():
	var i = 0
	while i<mesh.get_surface_count():
		var material = mesh.surface_get_material(i)
		if !material:
			i+=1
			continue
		material.albedo_color.r += LIGHTEN
		material.albedo_color.g += LIGHTEN
		material.albedo_color.b += LIGHTEN
		i+=1
	pass

func _process(delta):
	if player.is_main_attacking:
		if not anim.current_animation.begins_with("attack"):
			anim.play("attack1")
		anim_tree.active = false
	
	if player.is_grounded:
		var vel = player.linear_velocity
		vel.y = 0
		if vel.length_squared() > 0.1:
			blend_anim(BLEND_AMOUNT1,BLEND_IDLE_SPEED*delta)
		else:
			blend_anim(BLEND_AMOUNT1,-BLEND_WALK_SPEED*delta)
		blend_anim(BLEND_AMOUNT2,-BLEND_JUMP_SPEED*delta)
	else:
		blend_anim(BLEND_AMOUNT2,BLEND_JUMP_SPEED*delta)
	
	pass

func blend_anim(blend_amount,speed):
	anim_tree.set(blend_amount,clamp(anim_tree.get(blend_amount)+speed,0.0,1.0))
	pass