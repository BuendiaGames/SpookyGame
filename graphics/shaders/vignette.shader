shader_type canvas_item; //Godot demo vignette with slight modifications

uniform sampler2D vignette;
uniform float intensity = 4.0;

void fragment() {
	vec3 vignette_color = texture(vignette, UV).rgb;
	// Screen texture stores gaussian blurred copies on mipmaps.
	COLOR.rgb = textureLod(SCREEN_TEXTURE, SCREEN_UV, (1.0 - vignette_color.r) * intensity).rgb;
	COLOR.rgb *= texture(vignette, UV).rgb;
}
