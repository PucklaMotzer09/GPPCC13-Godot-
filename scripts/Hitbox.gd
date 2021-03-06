extends Area

onready var weapon = get_parent()
onready var camera = weapon.get_parent().get_parent()
onready var collision_shape = get_child(0)

func _ready():
    connect("body_entered",self,"on_hitbox_enter")
    connect("area_entered",self,"on_hitbox_enter")
    pass

func on_hitbox_enter(body):
    if body.has_method("damage"):
        body.damage(weapon.DAMAGE,body.get_global_transform().origin - camera.get_global_transform().origin)
    pass

func set_hitbox_shape():
    var aabb = weapon.get_aabb()

    collision_shape.shape.extents = aabb.size*weapon.scale
    collision_shape.translation.y = aabb.size.y/2*weapon.scale.y
    pass