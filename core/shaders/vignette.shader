//Godot demo vignette with slight modifications

shader_type canvas_item;

uniform sampler2D vignette;
uniform float intensity = 1.5;

void fragment() {
	vec3 vignette_color = texture(vignette, UV).rgb;
	//Store screen texture and multiply by the vignette effect
	COLOR.rgb = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	COLOR.rgb *= intensity * texture(vignette, UV).rgb;
}
