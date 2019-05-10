extends Node

export var FIREBALL_OBJECT_POOL_SIZE = 10

var player
var coins = 0 setget set_coins
onready var collected_coin_distance_curve = load("res://misc/CollectedCoinDistance.tres")
onready var FIREBALL = load("res://scenes/objects/Fireball.tscn")

var fireball_object_pool = Array()

func _ready():
    for i in range(FIREBALL_OBJECT_POOL_SIZE):
        var ball = FIREBALL.instance()
        ball.visible = false
        fireball_object_pool.append(ball)
        pass
    pass

func _input(event):
    if Input.is_action_just_pressed("toggle_fullscreen"):
        OS.window_fullscreen = !OS.window_fullscreen
    pass

func set_coins(new_value):
    coins = new_value
    player.get_node("HUD/CollectedCoins").new_collected_coin()
    pass

func get_fireball():
    for i in range(fireball_object_pool.size()):
        var ball = fireball_object_pool[i]
        if ball.visible == false:
            ball.visible = true
            return ball
    var ball = FIREBALL.instance()
    fireball_object_pool.append(ball)
    print("SIZE: ",fireball_object_pool.size())
    return ball
    pass

func return_fireball(ball):
    ball.visible = false
    get_parent().remove_child(ball)
    pass