#version 300 es
// Darkroom Night Vision: red-only screen shader.
// Each pixel keeps its brightest channel, moved into red; green and blue are
// zeroed so the display emits only red light. Using the brightest channel
// (rather than luminance) keeps blue/green screensaver effects visible.

precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const float MAX_RED = 0.85;

void main() {
    vec4 color = texture(tex, v_texcoord);
    float level = max(color.r, max(color.g, color.b));
    fragColor = vec4(level * MAX_RED, 0.0, 0.0, color.a);
}
