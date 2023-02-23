varying mediump vec2 var_texcoord0; // as it was
uniform lowp sampler2D texture_sampler; // as it was
uniform lowp vec4 blink_effect_trigger;

void main()
{
    // write a color of the current fragment to a variable (lowp = low precision (it's enough))
    lowp vec4 color_of_pixel = texture2D(texture_sampler, var_texcoord0.xy);

    if((blink_effect_trigger.r == 1.0) && (color_of_pixel.a != 0.0)) // when alpha value of the color is not 0 (not transparent) (you can get components of this vector like .r, .b, .g and .a)
    {
        color_of_pixel = vec4(1.0, 1.0, 1.0, 1.0);  // then it's your character - turn the color to white
    }
    gl_FragColor = color_of_pixel;  // write the color_of_pixel to the output gl_FragColor
}