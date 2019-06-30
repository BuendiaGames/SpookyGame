shader_type canvas_item;

uniform vec4 base = vec4(0.365, 0.306, 0.4, 1.0);
uniform vec4 light = vec4(0.5, 0.58, 0.6, 1.0);
uniform vec4 dark = vec4(0.22, 0.188, 0.188, 1.0);


float rand(float x) {
	return fract(sin(x)*10000.0); 
}


float fxy(vec2 uv, float t) {
	vec2 v = vec2(58.122 + 5.0*(0.5-uv.y)*cos(t), 75.23 + 4.0*(0.5-uv.x)*sin(t));
	float f = 0.5 * (sin(v.x * uv.x + t) + sin(v.y * uv.y + t));
	return abs(f);
}

void fragment() {
	/*
	vec4 final = base;
	float speed = 2.0;
	
	float field;
	float rfield = rand(UV.y * UV.x);
	
	
	
	//float time = speed * TIME;
	float time = 0.0;
	float mult = ((cos(time)+1.0) *0.5);
	//time += rand(UV.y);
	
	field = fxy(UV, time);
	
	if (field <= (0.2 - 0.2 * rfield))
	{
		final = mix(base, light, 1.0 + field);
	}
	else if (field >= 0.9 - 0.1*rfield)
	{
		final = mix(final, dark, 1.0 + field);
	}
	*/
	
	COLOR = base;
}