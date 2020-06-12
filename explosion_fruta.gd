extends AnimatedSprite
var tipo = ""

func _ready():
	self.play(tipo)
	$enPantalla.start()

func _on_enPantalla_timeout():
	self.queue_free()
