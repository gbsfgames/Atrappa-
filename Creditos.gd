extends Node2D

func _on_Button_pressed():
	$click.play()
	self.visible = false


func _on_facebook_pressed():
	OS.shell_open("https://www.facebook.com/profile.php?id=100010909955398")

func _on_instagram_pressed():
	OS.shell_open("https://www.instagram.com/z_sandez/")
