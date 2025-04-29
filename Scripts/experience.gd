extends Node2D

@onready var protag: CharacterBody2D = $Protag

@onready var switch_timer: Timer = $switchTimer
@onready var flicker_time: Timer = $flickerTime
@onready var short_timer: Timer = $shortTimer
@onready var leave_timer: Timer = $leaveTimer

@onready var flicker: Sprite2D = $flicker
var canFlicker = true
var flickerCount = 0
var currCollage = 1
@onready var collages: AnimatedSprite2D = $collages
@onready var final_blackout: Sprite2D = $finalBlackout

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	currCollage = rng.randi_range(1,3)
	collages.play(str(currCollage))
	switch_timer.wait_time = rng.randi_range(10,20)
	flicker_time.wait_time = switch_timer.wait_time - 2
	#print(switch_timer.wait_time)
	switch_timer.start()
	flicker_time.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_switch_timer_timeout() -> void:
	switch_timer.wait_time = rng.randi_range(10,20)
	flicker_time.wait_time = switch_timer.wait_time - 2
	#print(switch_timer.wait_time)
	changeCollage()
	protag.position.x = rng.randi_range(100,3380)
	protag.position.y = rng.randi_range(60,2040)
	switch_timer.start()
	flicker_time.start()

func changeCollage():
	if currCollage == 1:
		currCollage = rng.randi_range(2,3)
	elif currCollage == 2:
		if rng.randi_range(1,2) == 1:
			currCollage = 1
		else:
			currCollage = 3
	elif currCollage == 3:
		currCollage = rng.randi_range(1,2)
	#print(currCollage)
	collages.play(str(currCollage))
	
func _on_flicker_time_timeout() -> void:
	if canFlicker:
		if flickerCount <= 4:
			flickerCount+= 1
			flicker.visible = !flicker.visible
			short_timer.start()
		else:
			flicker.visible = !flicker.visible
			flickerCount = 0

func _on_short_timer_timeout() -> void:
	_on_flicker_time_timeout()
	
func _on_experience_end_timeout() -> void:
	Global.experienced = true
	final_blackout.visible = true
	canFlicker = false
	flicker.visible = false
	leave_timer.start();


func _on_leave_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/gallery.tscn")
