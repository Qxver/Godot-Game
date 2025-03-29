shader_type canvas_item;

uniform float intensity : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.rgb = vec3(1.0, 0.0, 0.0); // Zmienia na czerwony
    color.a *= intensity; // Reguluje przezroczystość
    COLOR = color;
}