extends Node

@export var about_dialog: AcceptDialog;

@export var file_dialog: FileDialog;
@export var file_name_label: Label;
var image_file: ImageTexture;
var path: String;

func _ready() -> void:
	get_viewport().files_dropped.connect(on_files_dropped);
	_change_level("flag");

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
	%ProgressBar.show()
	#print(name)
	if (name == "flag"):
		path = "res://flag_scene.tscn";
	else:
		path = "res://billboard_scene.tscn";
	ResourceLoader.load_threaded_request(path)

var progress_value := 0.0
func _process(delta: float) -> void:
	if not path && path != "":
		return
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(path, progress)

	if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
		progress_value = progress[0] * 100
		%ProgressBar.value = move_toward(%ProgressBar.value, progress_value, delta * 20)

	if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		# zip the progress bar to 100% so we don't get weird visuals
		%ProgressBar.value = move_toward(%ProgressBar.value, 100.0, delta * 150)

		# "done" loading
		if %ProgressBar.value >= 99:
			for n in %level.get_children():
				%level.remove_child(n);
				n.queue_free();
			var instance = ResourceLoader.load_threaded_get(path);
			%level.add_child(instance.instantiate());
			%ProgressBar.hide();
			path = "";

func _on_billboard_button_pressed() -> void:
	_change_level("billboard")


func _on_flag_button_pressed() -> void:
	_change_level("flag")
