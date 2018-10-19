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
#define quality 5.0

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uBloomness;
uniform vec2 uPixelSize;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

const vec3 kernel = vec3(0.38774, 0.24477, 0.06136);

void main()
{
    // gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    vec4 bloomTint = vec4(1.0);
    float qualityCoeff = 0.1 / quality * uBloomness;
    
    vec2 noise = qualityCoeff * (vec2(rand(v_vTexcoord), rand(v_vTexcoord.yx)) - vec2(0.5));
    
    vec2 o1 = kernel.z * noise + v_vTexcoord + vec2(0.0, uPixelSize.y * 2.0);
    vec2 o2 = kernel.y * noise + v_vTexcoord + vec2(0.0, uPixelSize.y);
    vec2 o3 = kernel.x * noise + v_vTexcoord + vec2(0.0, 0.0);
    vec2 o4 = kernel.y * noise + v_vTexcoord + vec2(0.0, -uPixelSize.y);
    vec2 o5 = kernel.z * noise + v_vTexcoord + vec2(0.0, -(uPixelSize.y * 2.0));
    
    float noiseNess = 0.1 - length(noise);
    gl_FragColor += bloomTint * texture2D( gm_BaseTexture, o1) * kernel.z;
    gl_FragColor += bloomTint * texture2D( gm_BaseTexture, o2) * kernel.y;
    gl_FragColor += bloomTint * texture2D( gm_BaseTexture, o3) * kernel.x;
    gl_FragColor += bloomTint * texture2D( gm_BaseTexture, o4) * kernel.y;
    gl_FragColor += bloomTint * texture2D( gm_BaseTexture, o5) * kernel.z;
}

