extends Control
export (PackedScene) var ngame
export (PackedScene) onready var ditos

func _ready():
	$fondo.play()

func _on_Nuevo_Juego_pressed():
	$seleccion.play()
	$Instrucciones.visible = true
	$Panel.visible = false
	#$fondo.stop()
	
func _on_Salir_pressed():
	$seleccion.play()
	get_tree().quit() # SALIDA
	$fondo.stop()

func _on_Credits_pressed():
	$seleccion.play()
	var Creditos = ditos.instance() # SE INSTANCIA ESCENA ENPAQUETADA
	add_child(Creditos) # SE AGREGA A PANTALLA LA ESCENA INSTANCIADA

func _on_continuar_pressed():
	var game = ngame.instance() # SE INSTANCIA ESCENA ENPAQUETADA
	add_child(game)
	self.visible = false
	$Instrucciones.visible = false
	$fondo.stop()
	
func _on_back_to_inicio_pressed():
	$Instrucciones.visible = false
	$Panel.visible = true


func _on_continuar_touch_pressed():
	var game = ngame.instance() # SE INSTANCIA ESCENA ENPAQUETADA
	add_child(game)
	self.visible = false
	$Instrucciones.visible = false
	$fondo.stop()
