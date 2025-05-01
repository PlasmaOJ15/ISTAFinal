extends StaticBody2D

#If you have seen the experience, delete the barriers
func _ready() -> void:
	if Global.experienced:
		queue_free()
