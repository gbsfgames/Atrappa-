extends Node

export (PackedScene) var pj

#-----Variables de instancia de Frutas
export (PackedScene) var vaso
export (PackedScene) var sarten
export (PackedScene) var pera
export (PackedScene) var platano
export (PackedScene) var uva
export (PackedScene) var mango
export (PackedScene) var manzana
export (PackedScene) var explosion_fruta

var nuevo_obj

#---VARIABLES DE ALEATORIEDAD----
var objeto_random # VARIABLE DE OBJETO
var posicion_random # VARIABLE DE POSICION
onready var tiempos1 = [0.5,0.5,0.7,1]
onready var tiempos2 = [0.5,0.5,0.5,0.7]
onready var tiempos3 = [0.1,0.3,0.3,0.5]
onready var tiempos
func _ready():
	#LLAMO A INICIAR UN NUEVO JUEGO
	nuevo_juego() # SE LLAMA A LA FUNCION
	
func _physics_process(delta):
	var new = get_tree().get_nodes_in_group("Inicio")
	if int($Control/Label.text) <=20:
		tiempos = tiempos1
		$Control/label_nivel.text = "Nivel 1"
	elif int($Control/Label.text) > 20 and int($Control/Label.text) <= 50:
		tiempos = tiempos2
		$Control/label_nivel.text = "Nivel 2"
	elif int($Control/Label.text) >50 and int($Control/Label.text) <= 100 :
		tiempos = tiempos3
		$Control/label_nivel.text = "Nivel 3"
		
	if int($Control/Label.text) ==100 and $KinematicBody2D :
		$KinematicBody2D.queue_free() # se elimina el jugador
		$Timer2.stop() # SE INICIA EL SEGUNDO TIMER DE  OBJETOS
		$Fondo.stop() # SE DETIENE EL SOUNDTRACK
		$winner.visible = true
		$CanvasLayer/TouchCOntrols.visible = false

func inicio_juego():
	#se llama al jugador a la escena
	var nuevopj = pj.instance() # SE INSTANCIA AL JUGADOR NUEVO
	self.add_child(nuevopj) # SE AGREGA A LA ESCENA AL JUGADOR INSTANCIADO
	nuevopj.position = $PJ_position.position # SE LE ASIGNA POSICION

# ----------ELECCION DE OBJETOS ALEATORIOS -------------
func salida_aleat():
	var objeto = [vaso, sarten, pera, platano, uva, mango, manzana]
	
	var posicion = [$frutas/ps1.position, $frutas/ps2.position, $frutas/ps3.position, $frutas/ps4.position, 
			$frutas/ps5.position, $frutas/ps6.position, $frutas/ps7.position, $frutas/ps8.position, $frutas/ps9.position, 
			$frutas/ps10.position, $frutas/ps11.position, $frutas/ps12.position, $frutas/ps13.position, $frutas/ps14.position, 
			$frutas/ps15.position, $frutas/ps16.position,$frutas/ps17.position, $frutas/ps18.position, $frutas/ps19.position, 
			$frutas/ps20.position, $frutas/ps21.position, $frutas/ps22.position, $frutas/ps23.position, $frutas/ps24.position, 
			$frutas/ps25.position, $frutas/ps26.position, $frutas/ps27.position, $frutas/ps28.position, $frutas/ps29.position, 
			$frutas/ps30.position, $frutas/ps31.position, $frutas/ps32.position,$frutas/ps33.position, $frutas/ps34.position, 
			$frutas/ps35.position, $frutas/ps36.position, $frutas/ps37.position, $frutas/ps38.position, $frutas/ps39.position, 
			$frutas/ps40.position, $frutas/ps41.position, $frutas/ps42.position, $frutas/ps43.position]
			
	randomize() # con esta linea pongo otros valores aleatorios en el randi
	var num_obj = randi() % 7
	randomize()
	var num_pos = randi() % 43 
	
	objeto_random = objeto[num_obj]
	posicion_random = posicion[num_pos]
	
	#-----------SELECCIONO UN OBJETO ALEATORIAMENTE Y LO INSTANCIO A ESCENA----------
	nuevo_obj = objeto_random.instance() # NOTA QUE EL OBJETO QUE INSTANCIO LO OBTENGO ALEATORIAMENTE
	self.add_child(nuevo_obj) #  AÑADO EL NUEVO OBJETO INSCTANCIADO A LA ESCENA
	nuevo_obj.position = posicion_random # OBJETO A POSICION ALEATORIA DE SALIDA
	
func _on_Timer_timeout():
	#salida_aleat() # SE LLAMA A FUNCION QUE INICIA LANZAMIENTO DE OBJETOS
	#var tiempos = [1,3,5,7,9] # TIEMPO QUE SE ASIGNA AL TIMER
	#var nuevo_time = randi() % 5
	pass
	
func _on_Timer2_timeout():
	salida_aleat() # SE LLAMA A FUNCION QUE INICIA LANZAMIENTO DE OBJETOS
	var nuevo_time = randi() % tiempos.size() # GENERA VALORES ALEATORIOS
	$Timer2.set_wait_time(tiempos[nuevo_time]) # ASIGNA EL VALOR ALEATORIO AL TIMER
	$Timer2.start()

#-------FUNCION NUEVOJUEGO----------
func nuevo_juego():
	inicio_juego() # SE LLAMA A LA FUNCION INICIO JUEGO
	#$Timer.start() # SE INICIALIZAN TIMERS
	$Timer2.start()
	$Fondo.play(0.0) # INICIA EL SOUNDTRACK
	$Control.vivo = true # SE ESTABLECE VARIABLE VIVO DEL JUGADOR
	
#-------FUNCION JUEGO TERMINADO----------
func juego_terminado():
	#$Timer.stop() # SE INICIA TIMER DE OBJETOS
	$Timer2.stop() # SE INICIA EL SEGUNDO TIMER DE  OBJETOS
	get_tree().get_nodes_in_group("player")[0].queue_free() # ELIMINO AL JUGADOR DE LA ESCENA
	#get_tree().get_nodes_in_group("main")[0].queue_free() # ELIMINO LA ESCENA PRINCIPAL
	$Fondo.stop() # SE DETIENE EL SOUNDTRACK
	#get_tree().get_nodes_in_group("Inicio")[0].visible = true
	 # HAGO VISIBLE DE NUEVO AL MENU INICIO
	#get_tree().change_scene("res://Inicio.tscn")
	$game_overR.visible = true
	$CanvasLayer/TouchCOntrols.visible = false

func _on_Aplastador_Frutas_area_entered(area):
		if area.name != "colision_futas" and area.name!="AreaMovimiento":
			area.queue_free()
			var exploit_fruit = explosion_fruta.instance() # NOTA QUE EL OBJETO QUE INSTANCIO LO OBTENGO ALEATORIAMENTE
			#self.add_child(exploit_fruit) #  AÑADO EL NUEVO OBJETO INSCTANCIADO A LA ESCENA
			if "Sarten" in area.name or "Vaso" in area.name:
				exploit_fruit.tipo = "explotar_enem"
				exploit_fruit.scale = Vector2(0.3,0.3)
			else:
				exploit_fruit.tipo = "explotar"
				exploit_fruit.scale = Vector2(0.15,0.15)
				
			exploit_fruit.position = area.position # la explosion de ve en la posicion de choque...
			self.add_child(exploit_fruit)

