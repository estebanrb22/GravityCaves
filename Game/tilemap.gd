extends TileMap

@onready var camera: Camera2D = %Camera2D2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func change_view():
	change_camera(40,-50,3)

func change_camera(hor, ver, zoom):
	camera.x += hor
	camera.y += ver
	camera.zoom.x = zoom
	camera.zoom.y = zoom
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
