RSRC                     Shader                                                                       resource_local_to_scene    resource_name    code    script        ,   res://assets/fractal-shaders/mandelbrot.res �          Shader          '  shader_type canvas_item;

// Description : Mandelbrot fractal shader

uniform sampler2D Gradient;

uniform vec2 Scale;

uniform vec2 Offset;

uniform int MaxIter;

void fragment()
{
	vec2 t, t2;
	
	t2.x = 3.0 * (UV.x - 0.8) - Offset.x;
	t2.y = 3.0 * (UV.y - 0.5) - Offset.y;
	
	int i;
	
	for(i = 0; i < MaxIter; i++)
	{
		float x = ((t.x * t.x - t.y * t.y) + t2.x) * Scale.x;
		float y = ((t.y * t.x + t.x * t.y) + t2.y) * Scale.y;
		
		if(x*x + y*y > 4.0) break;
		
		t.x = x;
		t.y = y;
	}
	
	COLOR = texture(Gradient, vec2(float(i) / 100.0,0));	
} RSRC