shader_type canvas_item;

uniform float saturation : hint_range(0.0, 1.0) = 0.5; 
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	vec4 background_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
	// calculate the grayscale (luma) value of the background w standard weights
	float luma = dot(background_color.rgb, vec3(0.299, 0.587, 0.114));
	vec3 grayscale_color = vec3(luma);
	
	// blend between grayscale and the normal background color based on the saturation uniform
	vec3 desaturated_color = mix(grayscale_color, background_color.rgb, saturation);
    
	// apply the effect only where the texture has pixels
	COLOR.rgb = mix(background_color.rgb, desaturated_color, tex_color.a);
	COLOR.a = tex_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
