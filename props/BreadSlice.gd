extends Area2D
class_name BreadSlice

export(float) var interact_min_speed = 750

onready var butter_spreads : int = 0
onready var jam_spreads : int = 0
onready var peanut_spreads : int = 0

var dragging : bool = false
var knife : Node2D = null
var prev_knife_position : Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# check if knife around
func _physics_process(delta):
	knife = null
	for body in get_overlapping_bodies():
		if body is Knife:
			knife = body
	if knife == null:
		prev_knife_position = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# dragging action
	if dragging:
		global_position = get_viewport().get_mouse_position()
	
	# knife not around the object
	if knife == null:
		return
	
	# knife around, but empty
	if knife.spread == spread_type.EMPTY:
		return
	
	# check knife speed
	var knife_position = knife.global_position
	if prev_knife_position != Vector2.ZERO:
		var knife_velocity : Vector2 = knife_position - prev_knife_position
		var knife_speed = knife_velocity.length() / delta
		if knife_velocity.x < 0 and knife_speed > interact_min_speed:
			if add_spread(knife.spread):
				knife.spread = spread_type.EMPTY
	
	# update knife previous position
	prev_knife_position = knife_position


func add_spread(spread) -> bool:
	match spread:
		spread_type.BUTTER:
			if butter_spreads == $Butter.get_child_count():
				return false
			butter_spreads += 1
			$Butter.get_node("Layer" + str(butter_spreads)).visible = true
			return true
			
		spread_type.JAM:
			if jam_spreads == $Jam.get_child_count():
				return false
			jam_spreads += 1
			$Jam.get_node("Layer" + str(jam_spreads)).visible = true
			return true
			
		spread_type.PEANUT:
			if peanut_spreads == $PeanutButter.get_child_count():
				return false
			peanut_spreads += 1
			$PeanutButter.get_node("Layer" + str(peanut_spreads)).visible = true
			return true
	return false


func _on_BreadSlice_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		dragging = event.pressed
