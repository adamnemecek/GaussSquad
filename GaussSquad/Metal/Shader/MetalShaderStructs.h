#ifndef MetalShaderStructs_h
#define MetalShaderStructs_h

struct vertex_source
{
    float2 coords;
};

struct vertex_destination
{
    float4 coords [[position]];
};

struct projection_matrix
{
    float project_width;
    float project_height;
};

struct position_matrix
{
    float move_x;
    float move_y;
};

struct rotation_matrix
{
    float2x2 rotate;
};

#endif
