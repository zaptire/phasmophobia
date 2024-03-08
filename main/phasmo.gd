extends PanelContainer

enum ET {
	NONE,
	DOTS,
	WRITING,
	EMF,
	ORB,
	UV,
	FREEZING,
	SPIRIT,
}

var evidence_names = {
	ET.NONE:     "No Evidence",
	ET.DOTS:     "D.O.T.S",
	ET.WRITING:  "Ghost Writing",
	ET.EMF:      "EMF 5",
	ET.ORB:      "Ghost Orb",
	ET.UV:       "UV",
	ET.FREEZING: "Freezing",
	ET.SPIRIT:   "Spirit Box",
}

var ghosts: Dictionary = {
	[ET.DOTS,    ET.ORB,      ET.UV]:       "Banshee",
	[ET.WRITING, ET.UV,       ET.FREEZING]: "Demon",
	[ET.DOTS,    ET.WRITING,  ET.SPIRIT]:   "Deogen",
	[ET.DOTS,    ET.EMF,      ET.UV]:       "Goryo",
	[ET.EMF,     ET.SPIRIT,   ET.WRITING]:  "Spirit",
	[ET.EMF,     ET.SPIRIT,   ET.DOTS]:     "Wraith",
	[ET.SPIRIT,  ET.UV,       ET.DOTS]:     "Phantom",
	[ET.EMF,     ET.UV,       ET.FREEZING]: "Jinn",
	[ET.SPIRIT,  ET.ORB,      ET.WRITING]:  "Mare",
	[ET.ORB,     ET.WRITING,  ET.FREEZING]: "Revenant",
	[ET.EMF,     ET.WRITING,  ET.FREEZING]: "Shade",
	[ET.ORB,     ET.FREEZING, ET.DOTS]:     "Yurei",
	[ET.EMF,     ET.FREEZING, ET.DOTS]:     "Oni",
	[ET.SPIRIT,  ET.ORB,      ET.DOTS]:     "Yokai",
	[ET.UV,      ET.ORB,      ET.FREEZING]: "Hantu",
	[ET.EMF,     ET.UV,       ET.WRITING]:  "Myling",
	[ET.SPIRIT,  ET.ORB,      ET.FREEZING]: "Onryo",
	[ET.EMF,     ET.SPIRIT,   ET.FREEZING]: "The Twins",
	[ET.EMF,     ET.ORB,      ET.DOTS]:     "Raiju",
	[ET.EMF,     ET.UV,       ET.ORB]:      "Obake",
	[ET.SPIRIT,  ET.UV,       ET.FREEZING]: "The Mimic",
	[ET.SPIRIT,  ET.WRITING,  ET.FREEZING]: "Moroi",
	[ET.ORB,     ET.WRITING,  ET.DOTS]:     "Thaye",
}

var evidence: Array[ET] = [ ET.NONE, ET.NONE, ET.NONE ]
var selected := 0

@onready var evidence_labels = [%Evidence1, %Evidence2, %Evidence3]
@onready var st1 := %ScrollingText1
@onready var st2 := %ScrollingText2
@onready var stable_text := %StableText

func _ready():
	#var screen = DisplayServer.window_get_current_screen(0)
	#var size = DisplayServer.screen_get_size(0)
	#var pos = size - Vector2i(240, 280)
	#pos.y = -1
	#DisplayServer.window_set_position(Vector2i(size.x, 0) + pos, 0)
	
	set_color()
	recalc()

func set_color():
	for i in evidence_labels.size():
		evidence_labels[i].set("theme_override_colors/font_color", Color("#464646"))
		evidence_labels[i].text = evidence_names[evidence[i]]
		evidence_labels[selected].set("theme_override_colors/font_color", Color.BLACK)

func recalc():
	var should_show = false
	var count = 0
	stable_text.hide()
	st1.show()
	st2.show()
	
	for item in evidence:
		if item != ET.NONE:
			count += 1
			should_show = true
	
	st1.clear()
	st2.clear()
	
	if should_show:
		var possible = calculate_possible_ghosts()
		for recipe in possible:
			var text = "[center]"
			text += ghosts[recipe]
			if count == 2: text  += "\n"
			for item in recipe:
				if !evidence.has(item) and count > 1:
					text += "%s " % evidence_names[item]
	
			st1.add_scrolling_text(text, 0)
			st2.add_scrolling_text(text, 1)
	
	if count == 3:
		st1.hide()
		st2.hide()
		stable_text.hide()
		
		var possible = calculate_possible_ghosts()
		for recipe in possible:
			stable_text.show()
			stable_text.text = ghosts[recipe]
	
	#ghost_label.set_scrolling_top_text(top_text)
	#ghost_label.set_scrolling_bottom_text(bottom_text)

func calculate_possible_ghosts() -> Array:
	var possibilities: Array = []
	for recipe in ghosts:
		var contains = true
		for item in evidence:
			if item != ET.NONE and !recipe.has(item):
				contains = false
		if contains:
			possibilities.append(recipe)
	return possibilities
