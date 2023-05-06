extends Node

@export var about_dialog: AcceptDialog;

@export var file_dialog: FileDialog;
@export var file_name_label: Label;
var image_file: ImageTexture;

func _on_about_button_pressed() -> void:
	about_dialog.show();
	about_dialog.popup_centered();


func _on_file_button_pressed() -> void:
	file_dialog.show();
	file_dialog.popup_centered();


func _on_file_dialog_file_selected(path: String) -> void:
	file_name_label.text = "Image: " + path.split("/")[-1].split("\\")[-1];
	var image: Image = Image.load_from_file(path);
	image_file = ImageTexture.create_from_image(image);
	Billboard.change_image(image_file);
