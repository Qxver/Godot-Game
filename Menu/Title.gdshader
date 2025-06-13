shader_type canvas_item;

uniform float time_speed : hint_range(0.0, 2.0) = 0.3;
uniform float shine_width : hint_range(0.0, 1.0) = 0.25;
uniform float shine_strength : hint_range(0.0, 3.0) = 1.5;

uniform vec3 base_gold : source_color = vec3(1.0, 0.84, 0.0); // Główny złoty kolor
uniform vec3 highlight_gold : source_color = vec3(1.0, 0.95, 0.6); // Błysk

void fragment() {
    vec2 uv = UV;
    float time = TIME * time_speed;

    vec4 tex_color_original = texture(TEXTURE, uv); // Zmieniona nazwa dla jasności

    // *** Bardziej agresywne odrzucanie pikseli ***
    // Spróbuj podnieść próg. Jeśli nawet lekka poświata jest problemem, 0.5 to dobry punkt wyjścia.
    // Jeśli tekst jest antyaliasingowany, to może to sprawić, że krawędzie będą poszarpane.
    if (tex_color_original.a < 0.5) { // Spróbuj np. 0.1, 0.2, 0.5. Testuj!
        discard;
    }

    // Błysk przesuwa się w poziomie w lewo do prawej
    float shine_pos = mod(time, 1.0); // [0,1]
    float shine_dist = abs(uv.x - shine_pos);
    float shine = exp(-pow(shine_dist / shine_width, 2.0)) * shine_strength;

    // Mieszanie kolorów (pozostało bez zmian)
    vec3 color = mix(base_gold, highlight_gold, shine);

    // Zachowujemy oryginalną przezroczystość tekstu dla pikseli, które nie zostały odrzucone
    COLOR = vec4(color, tex_color_original.a);
}