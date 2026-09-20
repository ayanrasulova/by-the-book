extends StaticBody2D

var flicker: float = 0.0
var when_to_flicker: float = 0.0
var when_to_flicker_interval: float = 4.0

var flickering_period: float = 3.0

var interval: float = 0.0

func flicker_interval() -> void:
	interval = randf_range(0.05, 0.3)

func _ready() -> void:
	randomize()
	flicker_interval()
	$LightsOff.visible = true
	$SadLights.visible = false
	
func _process(delta):
	flicker += delta
	when_to_flicker += delta
	
	if when_to_flicker >= when_to_flicker_interval: # every 4 seconds
		if flickering_period > 0:
			flickering_period -= delta 
			
			# will flicker for three seconds (flickering period)
			if not $FlickerAudio.playing:
				var stream_length: float = $FlickerAudio.stream.get_length()
				# enough time for flickering period
				var max_start: float = max(0.0, stream_length - flickering_period)
				var random_start: float = randf_range(0.0, max_start)
				
				$FlickerAudio.play(random_start)

				
			if flicker >= interval:
				#lights()
				lights_but_less_intense()
				flicker_interval()
				flicker = 0.0
		else:
			$LightsOff.visible = true # lights back off
			$SadLights.visible = false
			
			flickering_period = 3.0
			when_to_flicker_interval = randf_range(0.0, 6.0)
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
	
		
	
	
