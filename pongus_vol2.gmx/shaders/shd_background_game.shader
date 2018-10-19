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
uniform float uIntensity; // 0 ~ 1
uniform float uFlash; // 0 ~ 1
uniform float uStripThicc;
uniform float uSuperIntense;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 rad_intense_BG (vec2 uv, float time, float thickness)
{
    

    // Distort UV so that we got some RAD swirly effect
    uv.x += sin(uv.y * 2.4 + 42.0 - time) * 0.25;
    uv.y += cos(uv.x * 4.2 - 42.0 + time) * 0.25;
    
    // Make stripe
    return mix(hsv2rgb(vec3(fract(time * 0.1), 0.8, 1)), hsv2rgb(vec3(fract(time * 0.1 + 0.042), 0.75, 0.8)), floor(fract(uv.y * thickness + time) + 0.5));
}

void main()
{
    vec2 uv = v_vTexcoord;
    vec3 finalColour = vec3(0.1, 0.085, 0.07);
    // gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    vec3 intenseFlash = vec3(0.4, 0.38, 0.342);
    vec3 bgStripe = vec3(0.2, 0.16, 0.14);
    
    // BG stripe
    finalColour = mix(finalColour, bgStripe, floor(fract(uv.y * 10.0 + (uv.x * sin(uTime) * (3.0 + uIntensity)) + uTime) + 0.5) * uIntensity);
    
    // SUPERINTENSEMODE
    finalColour = mix(finalColour, rad_intense_BG(uv, uTime, uStripThicc), uSuperIntense);
    
    // Intense Flash
    finalColour = mix(finalColour, intenseFlash, uFlash);
    
    gl_FragColor = vec4(finalColour, 1.0);
}

