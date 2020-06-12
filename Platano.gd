extends Area2D

func _physics_process(delta):
	var velocidades = [2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3]
	var val_aleat = randi() % 10
	self.move_local_y(velocidades[val_aleat])
	
func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
