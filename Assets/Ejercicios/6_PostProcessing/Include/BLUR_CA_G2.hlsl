#ifndef BLUR_CA_G2
#define BLUR_CA_G2

//#include "Packages/com.unity.render-pipelines.universal/shaderLibrary/Core.hlsl"

#ifndef SHADERGRAPH_PREVIEW
Texture2D_X(_BlitTexture);
#endif

#define ITERATIONS 64

float4 SampleTextureChannel(float2 pixelCoords, float2 direction, float pixelOffset)
{
    float4 result = 0;
    #ifndef SHADERGRAPH_PREVIEW
    float2 sampleCoords = pixelCoords + direction * pixelOffset;
    result += LOAD_TEXTURE2D_X_LOD(_BlitTexture, sampleCoords, 0);
    sampleCoords = pixelCoords - direction * pixelOffset;
    result += LOAD_TEXTURE2D_X_LOD(_BlitTexture, sampleCoords, 0);
    #endif
    return result;
}

void RadialBlurChromaticAberration_float(float2 pixelCoords, float2 direction, float3 perChannelOffsets, out float4 result)
{
    result = float4(0, 1, 1, 0);
    
    #ifndef SHADERGRAPH_PREVIEW
    result = 0;
    
    
    for (int i = 0; i < ITERATIONS; i++)
    {
    
        float pixelR = SampleTextureChannel(pixelCoords, direction, perChannelOffsets.x).r;
        float pixelG = SampleTextureChannel(pixelCoords, direction, perChannelOffsets.y).g; 
        float pixelB = SampleTextureChannel(pixelCoords, direction, perChannelOffsets.z).b;
        result += float4(pixelR, pixelG, pixelB, 1);
        
       
    }
    
    result /= ITERATIONS;
    #endif
}

#endif 


