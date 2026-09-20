extends StaticBody2D

var flicker: float = 0.0
var when_to_flicker: float = 0.0
var flickering_period: float = 3.0

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
	
	if when_to_flicker >=4.0: # every 4 seconds
		if flickering_period > 0:
			flickering_period -= delta 
			
			# will flicker for three seconds (flickering period)
			if not $FlickerAudio.playing:
				$FlickerAudio.play()
				
			if flicker >= interval:
				#lights()
				lights_but_less_intense()
				flicker_interval()
				flicker = 0.0
		else:
			$LightsOff.visible = true # lights back off
			$SadLights.visible = false
			flickering_period = 3.0
			when_to_flicker = 0.0
			flicker = 0.0
			$FlickerAudio.stop()
			
		
func lights() -> void: # alternate lights
	if $LightsOff.visible==false:
		$LightsOff.visible=true
		$SadLights.visible=false
	else:
		$LightsOff.visible=false
		$SadLights.visible=true
		
func lights_but_less_intense() -> void:
	if $SadLights.visible==false:
		$SadLights.visible=true
	else:
		$SadLights.visible=false
	
		
	
	
