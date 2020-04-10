extends Area2D

signal attack

export (PackedScene) var knife_scene

onready var player
onready var move_speed = rand_range(50,200)
var attack_distance = 25
var has_attacked = false

var start_position = Vector2()
var target_position = Vector2()

func _ready():
    $ThrowTimer.wait_time = rand_range(3, 10)
    $ThrowTimer.start()

    # Spawn randomly on one of the sides of the screen
    var which_side = randi() % 4 # 0 - top, 1 - bottom, 2 - left, 3 - right
    var side_position = rand_range(-50,1074) if (which_side == 0 || which_side == 1) else rand_range(-50, 650)

    start_position = Vector2(side_position, -50 if which_side == 0 else 650) if (which_side == 0 || which_side == 1) else Vector2(-50 if which_side == 2 else 1074, side_position)

    position = start_position

    # Set the target position to be the opposite side
    side_position = rand_range(-50,1074) if (which_side == 0 || which_side == 1) else rand_range(-50, 650)

    target_position = Vector2(side_position, 650 if which_side == 0 else -50) if (which_side == 0 || which_side == 1) else Vector2(1074 if which_side == 2 else -50, side_position)


func _process(delta):
    # Movement
    var velocity = (target_position - position).normalized()
    velocity *= move_speed
    position += velocity * delta

    if position.distance_to(target_position) < 5:
        queue_free()


func _on_Enemy_area_entered(area):
    if area.get_collision_layer_bit(0) && !has_attacked:
        connect("attack", area, "_on_Enemy_attack")
        $AudioStreamPlayer2D.play()

        emit_signal("attack")
        has_attacked = true


func _on_ThrowTimer_timeout():
    if !has_attacked:
        var new_knife = knife_scene.instance()
        get_parent().add_child(new_knife)
        new_knife.position = position
        new_knife.set_rotation(rand_range(0,360))

        $AudioStreamPlayer2D.play()
        has_attacked = true
