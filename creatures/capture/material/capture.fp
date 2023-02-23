varying mediump vec2 var_texcoord0; // as it was
uniform lowp vec4 resolution;
uniform lowp sampler2D texture_sampler; // as it was
uniform lowp vec4 tint;

float circular_crop(vec2 position, float crop_size){
    float radius = length(position.xy);
    float angle = degrees(atan(-position.x, -position.y)) + 180.0; // angle clockwise from the top
    float fa = radians(angle - crop_size * 360.0) * radius + 1.0; // angle edge function
    fa = clamp(fa, 0.0, 1.0);

    return fa;
}

void main()
{
    float progress = 0.5;
    lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    
    vec2 pos = gl_FragCoord.xy - 0.5 * resolution.xy;
    
    float to_crop = circular_crop(pos, progress); 
    vec4 deadzone = vec4(0.0, 1.0, 0.0, 1);
    vec4 col = mix(tint_pm, deadzone, to_crop);

    
    gl_FragColor = texture2D(texture_sampler, var_texcoord0.xy) * col;
}