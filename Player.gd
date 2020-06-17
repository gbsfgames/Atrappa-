extends KinematicBody2D

#----- SENALES -----------
signal points_recolected

#----- TECLAS DEL JUEGO----------
var velocidad = Vector2(0,0)
var gravedad = 400
#var teclaW = 87
var teclaK = 75
var teclaA = 65
var teclaD = 68
var teclaSpace = 32

#---VARIABLES DE PUNTAJES---
var puntaje = 0
var puntaje_nueva_vida = 0

var peras = 0
var manzanas = 0
var mangos = 0
var platanos = 0
var uvas = 0
onready var HUDvidas = $"../Control/Sprite/vidas"
onready var vidas = HUDvidas.text
onready var mirando = "right"


func _ready():
	self.connect("points_recolected",self.get_parent(),"animate_labels")
	pass
#------MOVEMENT
func _physics_process(delta):
	velocidad.y += gravedad * delta
	if !Input.is_key_pressed(teclaD) and !Input.is_key_pressed(teclaA) and !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		if !Input.is_key_pressed(teclaSpace):
			$Caminar_brazo_izq.play("idle")
			$Cuerpo.play("idle")
			$Caminar_brazo_der.play("idle")
			#$gancho.play("idle")
		velocidad.x = 0
	
#####  Estos dos ifs siguientes controlan la cancelacion del ataque del personaje.
	if Input.is_action_just_pressed("a_key") or Input.is_action_just_pressed("ui_left"):
		if $ataque_bra_der.is_playing() or $ataque_bra_izq.is_playing():
			$ataque_bra_der.visible = false
			$ataque_bra_izq.visible = false
			$Caminar_brazo_izq.visible = true
			$Caminar_brazo_der.visible = true
			$ataque_bra_der.frame = 0
			$ataque_bra_izq.frame = 0
			$gancho.frame = 0
			$ataque_bra_der.stop()
			$ataque_bra_izq.stop()
			$gancho.stop()
		#estas 2 lineas resolvio mi dolor de cabeza ... detiene la animacion actual y la reemplaza por idle
			$"colision_gancho/animacion".stop()
			$"colision_gancho/animacion".play("idle")
			
	elif Input.is_action_just_pressed("d_key") or Input.is_action_just_pressed("ui_right"):
		if $ataque_bra_der.is_playing() or $ataque_bra_izq.is_playing():
			$ataque_bra_der.visible = false
			$ataque_bra_izq.visible = false
			$Caminar_brazo_izq.visible = true
			$Caminar_brazo_der.visible = true
			$ataque_bra_der.frame = 0
			$ataque_bra_izq.frame = 0
			$gancho.frame = 0
			$ataque_bra_der.stop()
			$ataque_bra_izq.stop()
			$gancho.stop()
		#estas 2 lineas resolvio mi dolor de cabeza ... detiene la animacion actual y la reemplaza por idle
			$"colision_gancho/animacion".stop()
			$"colision_gancho/animacion".play("idle")
#fin cancelacion ataque personaje...

	if Input.is_key_pressed(teclaD) or Input.is_action_pressed("ui_right"):
		mirando = "right"
		$Caminar_brazo_izq.flip_h = false
		$Cuerpo.flip_h = false
		$Caminar_brazo_der.flip_h = false
		$ataque_bra_der.flip_h = false
		$ataque_bra_izq.flip_h = false
		$ataque_bra_der.offset.x = 0
		$ataque_bra_izq.offset.x = 0
		$gancho.offset.x = 0
		$gancho.flip_h = false
		
		if self.is_on_floor():
			$Caminar_brazo_izq.play("Caminar_izq")
			$Cuerpo.play("caminar")
			$Caminar_brazo_der.play("Caminar_der")
		velocidad.x = 200
			
	elif Input.is_key_pressed(teclaA) or Input.is_action_pressed("ui_left"):
		mirando = "left"
		$Caminar_brazo_izq.flip_h = true
		$Cuerpo.flip_h = true
		$Caminar_brazo_der.flip_h = true
		$ataque_bra_der.flip_h = true
		$ataque_bra_izq.flip_h = true
		$ataque_bra_der.offset.x = -200
		$ataque_bra_izq.offset.x = -200
		$gancho.flip_h = true
		$gancho.offset.x = -200
		
		if self.is_on_floor():
			$Caminar_brazo_izq.play("Caminar_izq")
			$Cuerpo.play("caminar")
			$Caminar_brazo_der.play("Caminar_der") 
		velocidad.x = -200

	if Input.is_action_just_pressed("jump") and is_on_floor():
		#$AnimatedSprite.play("Jump")
		$Caminar_brazo_izq.play("Salto_izq")
		$Cuerpo.play("salto")
		$Caminar_brazo_der.play("Salto_der") 
		velocidad.y = -300
		
	if Input.is_key_pressed(teclaK) or Input.is_action_pressed("attack"):
		$Caminar_brazo_izq.visible = false
		$Caminar_brazo_der.visible = false
		$Caminar_brazo_izq.stop()
		$Caminar_brazo_der.stop()
		$ataque_bra_der.visible = true
		$ataque_bra_izq.visible = true
		$ataque_bra_der.frame = 0
		$ataque_bra_izq.frame = 0
		$gancho.frame = 0
		$ataque_bra_der.play("ataque")
		$ataque_bra_izq.play("ataque")
		$gancho.play("ataque")
		if mirando=="right" and $"colision_gancho/animacion".has_animation("golpe_colision_derecha"):
			$"colision_gancho/animacion".stop()
			$"colision_gancho/animacion".play("golpe_colision_derecha")
		else:
			if mirando=="left" and $"colision_gancho/animacion".has_animation("golpe_colision_izquierda"):
				$"colision_gancho/animacion".stop()
				$"colision_gancho/animacion".play("golpe_colision_izquierda")
		
		
	if self.is_on_floor():
		$sombra.visible=true
	else:
		$sombra.visible=false
	# variable de test, comentar para produccion
	if Input.is_action_just_pressed("ui_up"):
		#print(self.is_on_floor())
		self.get_tree().get_nodes_in_group("main")[0].salida_aleat()
	
	self.move_and_slide(velocidad,Vector2(0,-1))
#-------------CUANDO UN OBJETO TOCA A JUGADOR SE SUMAN PUNTOS -----------------

func _on_colision_futas_area_entered(area):
	if area.name == "AreaMovimiento":
		self.velocidad.x = 3.5
	if area.name != "AreaMovimiento" and area.name !="Aplastador_Frutas" and area.name!="colision_gancho":
		if !area.is_in_group("vaso") and !area.is_in_group("sarten"):
			self.emit_signal("points_recolected",area.global_position,"point")
		area.queue_free() # SE ELIMINA EL OBJETO
		#self.emit_signal("points_recolected",area.global_position)
		#self.get_tree().get_nodes_in_group("main")[0].salida_aleat() # SE EJECUTA LA FUNCION SALIDA ALEATORIA

	# ---- CONDICIONALES DE PUNTAJE ESPECIFICO POR FRUTA
	if area.is_in_group("vaso") or area.is_in_group("sarten"):
		self.emit_signal("points_recolected",area.global_position,"bad")
		vidas = int(vidas)
		vidas -=1
		HUDvidas.text = str(vidas)
		
	if area.is_in_group("pera"):
		puntaje += 1
		puntaje_nueva_vida +=1
		peras += 1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("pera_HUD")[0].text = str(peras)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("platano"):
		puntaje +=1
		puntaje_nueva_vida +=1
		platanos +=1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("platanos_HUD")[0].text = str(platanos)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("uva"):
		puntaje +=1
		puntaje_nueva_vida +=1
		uvas +=1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("uvas_HUD")[0].text = str(uvas)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("mango"):
		puntaje +=1
		puntaje_nueva_vida +=1
		mangos +=1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("mangos_HUD")[0].text = str(mangos)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("manzana"):
		puntaje +=1
		puntaje_nueva_vida +=1
		manzanas +=1
		#fruta("manzana_HUD", manzanas)
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("manzana_HUD")[0].text = str(manzanas)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)

	if puntaje_nueva_vida == 50:
		vidas = int(vidas)
		vidas += 1
		HUDvidas.text = str(vidas)
		puntaje_nueva_vida = 0

#-------------AGREGAR ESTA FUNCION EN LA VERSION POSTERIOR.----------
#func fruta(fruta, elegida):
#	self.get_tree().get_nodes_in_group(fruta)[0].text = str(elegida)
	
func _on_colision_futas_area_exited(area):
	if area.name == "AreaMovimiento" and Input.is_key_pressed(teclaD) :
		self.velocidad.x = 0
		self.position.x = self.position.x - 10
	elif area.name == "AreaMovimiento" and Input.is_key_pressed(teclaA) :
		self.velocidad.x = 0
		self.position.x = self.position.x + 10

# esta funcion muestra los brazos de nuevo en estado normal
func _on_ataque_bra_izq_animation_finished():
	$Caminar_brazo_izq.visible = true
	$Caminar_brazo_der.visible = true
	$ataque_bra_der.visible = false
	$ataque_bra_izq.visible = false

func _on_gancho_animation_finished():
	$gancho.play("idle")


func _on_colision_gancho_area_entered(area):
	if area.name != "AreaMovimiento" and area.name !="Aplastador_Frutas" and area.name != "colision_futas":
		if !area.is_in_group("vaso") and !area.is_in_group("sarten"):
			print(area.name)
			self.emit_signal("points_recolected",area.global_position,"point")
		area.queue_free()
	# ---- CONDICIONALES DE PUNTAJE ESPECIFICO POR FRUTA
	if area.is_in_group("pera"):
		puntaje += 1
		puntaje_nueva_vida +=1
		peras += 1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("pera_HUD")[0].text = str(peras)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("platano"):
		puntaje +=1
		puntaje_nueva_vida +=1
		platanos +=1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("platanos_HUD")[0].text = str(platanos)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("uva"):
		puntaje +=1
		puntaje_nueva_vida +=1
		uvas +=1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("uvas_HUD")[0].text = str(uvas)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("mango"):
		puntaje +=1
		puntaje_nueva_vida +=1
		mangos +=1
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("mangos_HUD")[0].text = str(mangos)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)
	if area.is_in_group("manzana"):
		puntaje +=1
		puntaje_nueva_vida +=1
		manzanas +=1
		#fruta("manzana_HUD", manzanas)
		self.get_tree().get_nodes_in_group("mordida")[0].play(0.0)
		self.get_tree().get_nodes_in_group("manzana_HUD")[0].text = str(manzanas)
		self.get_tree().get_nodes_in_group("escore")[0].text = str(puntaje)

	if puntaje_nueva_vida == 50:
		vidas = int(vidas)
		vidas += 1
		HUDvidas.text = str(vidas)
		puntaje_nueva_vida = 0
