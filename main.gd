extends Node

@export var about_dialog: AcceptDialog;

@export var file_dialog: FileDialog;
@export var file_name_label: Label;
var image_file: ImageTexture;

func _ready() -> void:
	get_viewport().files_dropped.connect(on_files_dropped)
	_change_level("flag")

func _on_about_button_pressed() -> void:
	about_dialog.show();
	about_dialog.popup_centered();

func _on_file_button_pressed() -> void:
	file_dialog.show();
	file_dialog.popup_centered();

func on_files_dropped(files) -> void:
	_on_file_dialog_file_selected(files[0])

func _on_file_dialog_file_selected(path: String) -> void:
	file_name_label.text = "Image: " + path.split("/")[-1].split("\\")[-1];
	var image: Image = Image.load_from_file(path);
	image_file = ImageTexture.create_from_image(image);
	Billboard.change_image(image_file);

func _change_level(name: String) -> void:
	#print(name)
	for n in %level.get_children():
		%level.remove_child(n)
		n.queue_free()
	
	var scene
	if (name == "flag"):
		scene = load("res://flag_scene.tscn")
	else:
		scene = load("res://billboard_scene.tscn")
	
	var instance = scene.instantiate()
	%level.add_child(instance)

func _on_billboard_button_pressed() -> void:
	_change_level("billboard")


func _on_flag_button_pressed() -> void:
	_change_level("flag")
