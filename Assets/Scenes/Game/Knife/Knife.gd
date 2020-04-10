extends Area2D

onready var speed = rand_range(100,400)

func _process(delta):
    position.x += speed * sin(rotation) * delta
    position.y += speed * -cos(rotation) * delta


func set_rotation(rot):
    rotation_degrees = rot
