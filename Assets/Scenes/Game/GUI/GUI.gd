extends Control

var stab_count = 0
var current_time = 0
var time_in_seconds = 0
var time_in_minutes = 0

func _process(delta):
    # Keep track of the time
    current_time += delta

    if current_time >= 1:
        time_in_seconds += 1

        if time_in_seconds >= 60:
            time_in_minutes += 1
            time_in_seconds = 0

        current_time = 0

        $TimeLabel.text = str(time_in_minutes) + ":" + str("%02d" % time_in_seconds)


func add_stab():
    stab_count += 1
    $StabLabel.text = "Stabs: " + str(stab_count)


func _on_Player_stabbed():
    add_stab()


func _on_Player_dead():
    $GameOver.show()

    # Change this for something real lol
    $GameOver/DeathLabel.text = "Et tu, Brute?\n" + "You survived for " + $TimeLabel.text + "\n:("


func _on_RestartButton_pressed():
    get_tree().paused = false
    get_tree().change_scene("res://Assets/Scenes/Title/Title.tscn")
