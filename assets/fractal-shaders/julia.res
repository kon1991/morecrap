RSRC                     Shader                                                                       resource_local_to_scene    resource_name    code    script        '   res://assets/fractal-shaders/julia.res �          Shader          2  shader_type canvas_item;

// Description : Julia fractal shader

uniform sampler2D Gradient;

uniform vec2 Scale;

uniform vec2 Offset;

uniform int MaxIter;

uniform float Speed;

void fragment()
{
	vec2 t = vec2(Scale.x * (UV.x - 0.5) - Offset.x, Scale.y * (UV.y - 0.5) - Offset.y);
	
	int i;

	for(i = 0; i < MaxIter; i++)
	{
		float x = (t.x * t.x - t.y * t.y) + sin(TIME * Speed);
		float y = (t.x * t.y + t.x * t.y) + cos(TIME * Speed);
		
		if(x*x + y*y > 4.0) break;
		
		t.x = x;
		t.y = y;
	}
	
	COLOR = texture(Gradient, vec2(float(i) / 100.0,0));	
} RSRC