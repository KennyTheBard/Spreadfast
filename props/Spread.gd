extends Area2D

export(float) var interact_min_speed = 750
export(int, "Empty", "Butter", "Jam", "Peanut Butter") var give_spread = spread_type.EMPTY

var knife : Node2D = null
var prev_knife_position : Vector2 = Vector2.ZERO


func _process(delta):
	# knife not around the object
	if knife == null:
		return
	
	# knife not empty for spread
	if give_spread != spread_type.EMPTY:
		if knife.spread != spread_type.EMPTY:
			return
	# knife empty for napkins
	else:
		if knife.spread == spread_type.EMPTY:
			return
	
	# set spread on knife
	var knife_position = knife.global_position
	if prev_knife_position != Vector2.ZERO:
		var knife_velocity : Vector2 = knife_position - prev_knife_position
		var knife_speed = knife_velocity.length() / delta
		if knife_velocity.x < 0 and knife_speed > interact_min_speed:
			knife.spread = give_spread
	
	# update knife previous position
	prev_knife_position = knife_position


func _on_Spread_body_entered(body):
	if not body is Knife:
		return
	knife = body


func _on_Spread_body_exited(body):
	if not body is Knife:
		return
	knife = null
	prev_knife_position = Vector2.ZERO
