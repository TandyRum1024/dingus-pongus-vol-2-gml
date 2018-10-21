//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uTime;
uniform float uStripThicc;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 xortex (vec2 uv, float time)
{
    vec3 last = vec3(0.0);
    
    vec2 rad = vec2(sin(10.0 + time * 0.01 + cos(time + 12.3)) * 0.2 + 0.5, cos(42.3 + time * 0.01 + sin(time)) * 0.2 + 0.5);
    vec2 radDelta = uv.xy - rad.xy;
    
    float ux = (atan(radDelta.y, radDelta.x) * 4.0 + time * 6.0 + 3.14) / (2.0 * 3.14);
    float uy = (length(radDelta) * 4.0);
    
    float round = mix(0.0, 1.0, floor(fract(uy + ux + 0.5) + 0.5));
    
    vec3 r1 = hsv2rgb(vec3(fract(uy * 0.08 + time * 0.1), 0.5, 0.3));
    vec3 r2 = hsv2rgb(vec3(fract(uy * 0.05 + time * 0.1 + 0.042), 0.7, 0.5));
    
    last = mix(r1, r2, round);
    
    last *= 1.0 + sin(uy * 2.0) * 0.2 + sin(time * 0.1) * 0.5;
    last *= min(uy, 1.0);
    return last;
}

void main()
{
    vec2 uv = v_vTexcoord;
    vec3 finalColour = vec3(0.0);
    // gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    vec3 strip1 = vec3(1.0, 0.86, 0.0);
    vec3 strip2 = vec3(0.8, 0.72, 0.05);
    
    strip1 = hsv2rgb(vec3(fract(uTime * 0.1), 0.8, 1));
    strip2 = hsv2rgb(vec3(fract(uTime * 0.1 + 0.042), 0.75, 0.8));
    
    // Distort UV so that we got some RAD swirly effect
    uv.x += sin(uv.y * 2.4 + 42.0 - uTime) * 0.25;
    uv.y += cos(uv.x * 4.2 - 42.0 + uTime) * 0.25;
    
    // Make stripe
    finalColour = xortex(uv, uTime);//mix(strip1, strip2, floor(fract(uv.y * uStripThicc + uTime) + 0.5));
    
    gl_FragColor = vec4(finalColour, 1.0);
}

