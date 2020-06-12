extends Area2D

func _physics_process(delta):
	var velocidades = [100.1, 100.2, 100.3, 100.4, 100.5, 100.6, 100.7, 100.8, 100.9, 100.0]
	var val_aleat = randi() % 10
	self.move_local_y(velocidades[val_aleat] * delta)
	
func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()

