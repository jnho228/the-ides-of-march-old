extends Area2D

signal stabbed
signal dead

var move_speed = 250
var stab_count = 0

func _ready():
    pass


func _process(delta):
    # Movement
    var velocity = Vector2()

    if Input.is_action_pressed("ui_up"):
        velocity.y = -1
    if Input.is_action_pressed("ui_down"):
        velocity.y = 1
    if Input.is_action_pressed("ui_right"):
        velocity.x = 1
    if Input.is_action_pressed("ui_left"):
        velocity.x = -1

    if velocity.length() > 0:
        velocity = velocity.normalized() * move_speed

    position += velocity * delta

    position.x = clamp(position.x, 0, 1024)
    position.y = clamp(position.y, 0, 600)


func _on_Player_area_entered(area): # Did a knife hit me?
    if area.get_collision_layer_bit(2): # Knife
        get_stabbed()


func _on_Enemy_attack():
    get_stabbed()

func get_stabbed():
    stab_count += 1
    emit_signal("stabbed")

    $AudioStreamPlayer2D.play()

    if stab_count >= 23:
        # I have died
        emit_signal("dead")
