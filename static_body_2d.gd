extends StaticBody2D

var flicker: float = 0.0
var when_to_flicker: float = 0.0
var flickering_period: float = 5

var interval: float = 0.0

func flicker_interval() -> void:
	interval = randf_range(0.05, 0.3)

func _ready() -> void:
	flicker_interval()
	$LightsOff.visible = true
	$SadLights.visible = false
	
func _process(delta):
	flicker += delta
	when_to_flicker += delta
	
	if when_to_flicker >=6: # every 6 seconds
		flickering_period -= 1
		while flickering_period > 0:
			if flicker >= interval:
				flicker = 0.0
				light()
				flicker_interval()
		flickering_period = 10
		when_to_flicker = 0.0
			
		
func light() -> void: 
	if $LightsOff.visible==false:
		$LightsOff.visible=true
		$SadLights.visible=false
	else:
		$LightsOff.visible=false
		$SadLights.visible=true
	
		
	
	
