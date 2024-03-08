extends Control

var mouse_pos: Vector2
var window_pos: Vector2
var inside: bool

@onready var phasmo := $Phasmo

func _ready():
	window_pos = DisplayServer.window_get_position()

func _process(delta):
	if (GlobalInput.is_action_just_pressed("ui_up")):
		phasmo.selected = wrapi(phasmo.selected - 1, 0, 3)
		phasmo.set_color()
		phasmo.recalc()
	if (GlobalInput.is_action_just_pressed("ui_down")):
		phasmo.selected = wrapi(phasmo.selected + 1, 0, 3)
		phasmo.set_color()
		phasmo.recalc()
	if (GlobalInput.is_action_just_pressed("ui_left")):
		var curr = wrapi(phasmo.evidence[phasmo.selected] - 1, 0, phasmo.ET.size())
		while phasmo.evidence.has(curr) and curr != phasmo.ET.NONE:
			curr = wrapi(curr - 1, 0, phasmo.ET.size())
		phasmo.evidence[phasmo.selected] = curr
		phasmo.set_color()
		phasmo.recalc()
	if (GlobalInput.is_action_just_pressed("ui_right")):
		var curr = wrapi(phasmo.evidence[phasmo.selected] + 1, 0, phasmo.ET.size())
		while phasmo.evidence.has(curr) and curr != phasmo.ET.NONE:
			curr = wrapi(curr + 1, 0, phasmo.ET.size())
		phasmo.evidence[phasmo.selected] = curr
		phasmo.set_color()
		phasmo.recalc()
	if (GlobalInput.is_action_just_pressed("reload")):
		for i in phasmo.evidence.size():
			phasmo.evidence[i] = phasmo.ET.NONE
			phasmo.selected = 0
			phasmo.set_color()
			phasmo.recalc()

func _on_mouse_entered():
	inside = true
	$Button.show()

func _on_mouse_exited():
	inside = false
	$Button.hide()

func _on_button_pressed():
	get_tree().quit()

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and inside:
			mouse_pos = event.position
	
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("drag"):
			window_pos += event.position - mouse_pos
			DisplayServer.window_set_position(Vector2i(window_pos))
