extends KinematicBody2D
class_name Knife

onready var spreads : Node2D = $Spreads

var dragging : bool = false
var spread = spread_type.EMPTY setget set_spread


func set_spread(new_spread):
	spread = new_spread
	match new_spread:
		spread_type.EMPTY:
			for c in spreads.get_children():
				c.visible = false
				
		spread_type.BUTTER:
			for c in spreads.get_children():
				c.visible = false
			spreads.get_node("Butter").visible = true
			
		spread_type.JAM:
			for c in spreads.get_children():
				c.visible = false
			spreads.get_node("Jam").visible = true
			
		spread_type.PEANUT:
			for c in spreads.get_children():
				c.visible = false
			spreads.get_node("PeanutButter").visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		global_position = get_viewport().get_mouse_position()


func _on_Knife_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		dragging = event.pressed

