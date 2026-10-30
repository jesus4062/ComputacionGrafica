#ifndef BLUR_CA_G2
#define BLUR_CA_G2

// Función auxiliar para muestrear dos puntos simétricos en una dirección
float4 SampleTextureChannel(float2 pixelCoords, float2 direction, float pixelOffset)
{
    float4 result = 0;
    
    float2 sampleCoords = pixelCoords + direction * pixelOffset;
    result += LOAD_TEXTURE2D_X_LOD(_BlitTexture, sampleCoords, 0);
    
    sampleCoords = pixelCoords - direction * pixelOffset;
    result += LOAD_TEXTURE2D_X_LOD(_BlitTexture, sampleCoords, 0);
    
    return result;
}

void RadialBlurChromaticAberration_float(float2 pixelCoords, float2 direction, float3 perChannelOffsets, out float4 result)
{
    result = float4(0, 1, 1, 0);
    
    #ifndef SHADERGRAPH_PREVIEW
    result = 0;
    
    [unroll]
    for (int i = 0; i < ITERATIONS; i++)
    {
        // Se calcula el offset de forma independiente para cada canal de color (R, G, B)
        float pixelR = SampleTextureChannel(pixelCoords, direction, perChannelOffsets.x).r;
        float pixelG = SampleTextureChannel(pixelCoords, direction, perChannelOffsets.y).g; 
        float pixelB = SampleTextureChannel(pixelCoords, direction, perChannelOffsets.z).b;
        result += float4(pixelR, pixelG,pixelB,1)
        
        // Nota: Asigna los valores muestreados a los canales correspondientes de 'result'
        // Por ejemplo: result += float4(pixelR, pixelG, pixelB, 1.0f);
    }
    
    result /= ITERATIONS;
    #endif
}

#endif // BLUR_CA_G2


