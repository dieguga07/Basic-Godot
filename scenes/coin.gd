extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("You have a new coin")
	queue_free()
