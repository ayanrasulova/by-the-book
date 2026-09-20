shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
// opacity of mult. layer
uniform float multiply_opacity : hint_range(0.0,1.0) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// read data from texture + background
    vec4 tex_color = texture(TEXTURE, UV);
	vec4 background_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
	//warm light, mulitplying with background
    vec3 warm_color = vec3(1.0, 0.7, 0.0);
	vec3 multiplied_color = background_color.rgb * warm_color;
	vec3 multi_with_opacity = mix(background_color.rgb, multiplied_color, multiply_opacity);
    
    // keep the texture's original transparency
    COLOR.rgb = mix(background_color.rgb, multi_with_opacity, tex_color.a);
    COLOR.a = tex_color.a;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
