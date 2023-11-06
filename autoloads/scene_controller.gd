extends Node

var history = []

func switch_scene(path):
	
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().current_scene)
	history.append(packed_scene)
	#Update the current scene to represent the change
	get_tree().change_scene_to_file(path)

func return_to_last():
	#If there is a scene to return to that isn't the main scene
		#Get the last scene visited from the END of the history array
		var target = history.pop_back()
		#Update the current scene to represent the change
		get_tree().change_scene_to_packed(target)
	
