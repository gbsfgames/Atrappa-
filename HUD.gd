extends Control

#----------Escenas------------
#export (PackedScene) var nueva
#---------- SENALES ------------
signal sin_vidas

#--------- VARIABLES ----------------
var vidas_p
var vidas_num
var vivo = true # VARIABLE QUE ME DICE SI EL PJ ESTA VIVO

func _ready():
		# ASIGNO EL VALOR DE LA VIDA EN EL GRUPO VIDA A MI VARIABLE LOCAL PARA NO OBTENER ERROR
	#vidas_p = self.get_tree().get_nodes_in_group("vida")[0].text
	vidas_p = $Sprite/vidas.text
	
func _process(delta):
	# ASIGNO EL VALOR DE LA VIDA EN EL GRUPO VIDA A MI VARIABLE LOCAL CADA FRAME EN BUSQUEDA DE CAMBIOS
	vidas_p = $Sprite/vidas.text
	# CONVIERTO MI VALOR OBTENIDO A NUMERO PARA PODER REALIZAR LA COMPROBACION CON IF
	vidas_num = int(vidas_p)
	#-------COMPRUEBO SI EL PERSONAJE SIGUE CON VIDAS -----------
	if  vidas_num <= 0 and vivo == true:
		emit_signal("sin_vidas")
		vivo = false # PONE EL ESTADO DEL JUGADOR EN MUERTO
