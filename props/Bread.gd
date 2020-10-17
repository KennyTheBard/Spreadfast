extends Area2D

onready var bread_slice : PackedScene = preload("res://props/BreadSlice.tscn")


func _on_Bread_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if get_overlapping_bodies().size() == 0:
			spawn_bread_slice()


func spawn_bread_slice():
	var instance = bread_slice.instance()
	instance.global_position = global_position
	get_parent().add_child(instance)
