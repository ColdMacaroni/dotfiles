#version 120

uniform sampler2D texture;
uniform vec2 screenSize;
uniform vec2 mouse;

varying vec2 uvCoord;

void main() {
  // Requires the -l flag.
  vec4 rect = texture2D(texture, uvCoord);
  // Dim everything outside the rectangle.
  vec4 color = (1 - rect) * vec4(0, 0, 0, 0.9);

  // Not exactly sure how this works but it grabs the pixels on the edge of the selection
  // Taken from https://github.com/naelstrof/slop/issues/146#issuecomment-1473542244
  vec2 pixel = vec2(1, 1) / screenSize;
  vec4 up = texture2D(texture, vec2(uvCoord.x, uvCoord.y + pixel.y));
  vec4 down = texture2D(texture, vec2(uvCoord.x, uvCoord.y - pixel.y));
  vec4 left = texture2D(texture, vec2(uvCoord.x - pixel.x, uvCoord.y));
  vec4 right = texture2D(texture, vec2(uvCoord.x + pixel.x, uvCoord.y));

  if (rect.a == 0 && (up.a + down.a + left.a + right.a) > 0) {
    color = vec4(1, 1, 1, 0.1);
  }
  gl_FragColor = color;
}
