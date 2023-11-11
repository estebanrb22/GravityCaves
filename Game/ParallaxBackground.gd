extends ParallaxBackground

var dirección = Vector2(1,0)
var velocidad = 100

func _physics_process(delta):
	scroll_base_offset += dirección * velocidad * delta
