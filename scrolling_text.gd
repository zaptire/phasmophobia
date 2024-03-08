extends Control

const ScrollLabel = preload("res://scrolling_text_label.tscn")
var padding = 120.0
var count = 1
#@onready var container := $VBoxContainer

func add_scrolling_text(new_text: String, extra: int = 0) -> void:
	var label = ScrollLabel.instantiate()
	label.text = new_text
	
	var width = max(240, size.x)
	label.get("material").set("shader_parameter/size", count * 120.0)
	
	add_child(label)
	
	label.get("material").set("shader_parameter/extra", extra);
	# Space between elements (space between elements should be this at least)
	label.get("material").set("shader_parameter/offset", count * 120.0)
	count += 1  
	
	update_count()


func add_text(new_text: String) -> void:
	var label = ScrollLabel.instantiate()
	label.text = new_text
	add_child(label)

func update_count():
	for child in get_children():
		# Space between loops
		child.get("material").set("shader_parameter/size", count * 120.0)

func clear():
	count = 0
	for child in get_children():
		child.queue_free()

#func set_scrolling_top_text(new_text: String) -> void:
	#container.get_child(0).text = new_text
	#var width = max(240, container.get_child(0).get_content_width() * padding)
	#container.get_child(0).get("material").set("shader_parameter/size", width)
#
#func set_scrolling_bottom_text(new_text: String) -> void:
	#container.get_child(1).text = new_text
	#var width = max(240, container.get_child(1).get_content_width() * padding)
	#container.get_child(1).get("material").set("shader_parameter/size", width)
