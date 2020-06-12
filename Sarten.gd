extends Area2D

func _physics_process(delta):
	var velocidades = [4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5]
	var val_aleat = randi() % 10
	self.move_local_y(velocidades[val_aleat])
	

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
