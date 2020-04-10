extends Node

export (PackedScene) var enemy_scene

var spawn_delay = 2
var spawn_amount = 1


func _on_SpawnTimer_timeout():
    for _i in range(spawn_amount):
        var new_enemy = enemy_scene.instance()
        get_child(1).add_child(new_enemy) # I think this'll make it select the entities.
        #add_child(new_enemy)

    var increase_chance = rand_range(0, 10)
    if increase_chance > 4:
        spawn_amount += 1

    $SpawnTimer.wait_time = spawn_delay # Make this change later
    $SpawnTimer.start()


func _on_Player_stabbed(): # Increase difficulty or w/e
    var increase_chance = rand_range(0, 10)
    if increase_chance > 3:
        spawn_amount += 1

    spawn_delay = rand_range(2, 5)

    $Camera2D.start(0.2, 15, 16, 0)


func _on_Player_dead(): # Stop everything
    $SpawnTimer.stop()
    # Send out a signal to make everyone leave? I guess

    get_tree().paused = true
