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
uniform float uKernel[5];

uniform float uH;
uniform float uV;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main()
{
    // gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    //vec4 bloomTint = vec4(0.9, 0.85, 0.8, 1.0);
    vec4 sum = texture2D( gm_BaseTexture, v_vTexcoord) * uKernel[0];
    float scale = 1;
    for (int i=1; i<5; i++)
    {
        vec2 offset = vec2(uPixelSize.x * float(i) * uH, uPixelSize.y * float(i) * uV);
        // offset += (vec2(rand(v_vTexcoord + offset), rand(v_vTexcoord - offset)) - 0.5) * 0.005 * scale;
        
        sum += texture2D( gm_BaseTexture, v_vTexcoord + offset) * uKernel[i];
        sum += texture2D( gm_BaseTexture, v_vTexcoord - offset) * uKernel[i];
    }
    
    gl_FragColor = sum;
}

