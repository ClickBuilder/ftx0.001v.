extends Control

var text_to_type := "p class div .wrapper h1 function <?php ?> link script"
var start_time = 0
var end_time = 0
var typed_text := ""
var timer_running = false

func _ready():
	$LabelToType.text = text_to_type
	$ResultLabel.text = "Type the text and press Enter"
	$LineEdit.text = ""
	$LineEdit.connect("text_changed", Callable(self, "_on_LineEdit_text_changed"))
	$LineEdit.connect("text_submitted", Callable(self, "_on_LineEdit_text_submitted"))

func _on_LineEdit_text_changed(new_text):
	if not timer_running and new_text != "":
		start_time = Time.get_ticks_msec()
		timer_running = true
	typed_text = new_text
	if new_text == text_to_type and timer_running:
		end_time = Time.get_ticks_msec()
		var elapsed_time = (end_time - start_time) / 1000.0
		var words_typed = new_text.split(" ").size()
		var wpm = words_typed / (elapsed_time / 60.0)
		$ResultLabel.text = "You typed at a speed of " + str(wpm) + " words per minute."
		timer_running = false

func _on_LineEdit_text_submitted(_entered_text):
	pass

func _process(_delta):
	if timer_running:
		var current_time = Time.get_ticks_msec()
		var elapsed_time = (current_time - start_time) / 1000.0
		$ResultLabel.text = "Time elapsed: " + str(elapsed_time) + " seconds"
