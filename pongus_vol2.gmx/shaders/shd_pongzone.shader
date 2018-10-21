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
#define iteration 8.0

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uTime;
uniform float uIntensity;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

mat2 rotate2d(float _angle)
{
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

void main()
{
    vec4 finalColour = vec4(0.0); //v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    for (float i=1.0; i<iteration; i+=1.0)
    {
        float angle = radians((i * 0.5) + sin(uTime * 0.1) * 4.0 * (i * 0.5));
        vec2 zoomUV = (v_vTexcoord - 0.5);
        zoomUV *= rotate2d(angle);
        
        zoomUV = (zoomUV * (sin(uTime * 0.062) * 0.32 * uIntensity + 1.0) * max(i * uIntensity, 1.0)) + 0.5;
        
        if (zoomUV.x > 0.0 && zoomUV.x < 1.0 &&
            zoomUV.y > 0.0 && zoomUV.y < 1.0)
        {
            vec4 tint = vec4(hsv2rgb(vec3(i / iteration + uTime * 0.01, 0.8, 0.64)), 1.0);
            tint *= texture2D( gm_BaseTexture, zoomUV );
            
            tint.a *= (1.0 - (i / iteration)) * 0.42;
            
            finalColour.rgb += (tint.rgb * tint.a) + vec3(0.01, 0.015, 0.02) * uIntensity;
            finalColour.a = 1.0;
        }
    }
    
    gl_FragColor = finalColour;
}

