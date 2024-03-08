shader_type canvas_item;

uniform float size = 120.0;
uniform float offset = 0.0;
uniform float extra = 0.0;

void vertex() {
	float f = extra - fract(100.0 * TIME / size);
	VERTEX.x -= (f * size) - 40.0;
	VERTEX.x -= offset;
}