extends Node2D

var selected_character: Character
# var screen_size

func _ready():
	# screen_size = get_viewport_rect().size
	$Themistocles.position = Vector2(63, 84)
	$Pericles.position = Vector2(263, 84)
	selected_character = $Themistocles
	selected_character.select()
	_connect_character($Themistocles)
	_connect_character($Pericles)

func _connect_character(character):
	character.connect("player_selected", self, "select_character", [character])

func select_character(character):
	# deselect previously selected character
	if selected_character != null:
		selected_character.deselect()
	selected_character = character

func _physics_process(delta):
	var mousePos = $Grid.world_to_map(get_global_mouse_position())
	# mousePos.x = clamp(mousePos.x, 0, screen_size.x)
	# mousePos.y = clamp(mousePos.y, 0, screen_size.y)
	$TileHighlight.set_position($Grid.map_to_world(mousePos))

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if selected_character != null and event.button_index == BUTTON_RIGHT:
			selected_character.target_coords = event.position
