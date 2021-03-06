shader_type canvas_item;

uniform float tile_factor = 5.0;
uniform float aspect_ratio = 0.5;

uniform vec2 uv_offset_size = vec2(1.0, 1.0);
uniform vec2 wave_size = vec2(0.25,0.25);

uniform sampler2D uv_offset_texture : hint_black;

void fragment() {
	
	vec2 offset_uv_tex = UV*uv_offset_size;
	offset_uv_tex += 0.02*TIME;
	
	vec2 texture_based_offset = texture(uv_offset_texture, offset_uv_tex).rg;
	texture_based_offset = texture_based_offset * 2.0 - 1.0;
	
	
	vec2 adjusted_uv = UV * tile_factor;
	adjusted_uv.y *= aspect_ratio;
	
	COLOR = texture(TEXTURE, adjusted_uv + wave_size * texture_based_offset);
}
