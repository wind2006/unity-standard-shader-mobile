// Standard shader for mobile
// Written by Nihal Mirpuri @nylonee

// Notes:

// The property toggles are used to turn on and off shader features
// You can't toggle shader features at run-time. Only during the build

// Doesn't support shadow casting

// Only supports exponential2 fog (the cheapest)

// Detail mask will only kick in if detail map is toggled on

// Point light accepts a single point light, which you can modify via script if needed
// For example, a sun moving across the sky.
// No other lighting (except lightmaps) are passed in.
// If you need more lighting options, consider using Standard shader instead

// TODO: Normal mapping not working properly
// TODO: Phong light should be additive onto lightmapped light
// TODO: Add comments and documentation

Shader "Mobile/Standard"
{
  Properties
  {
    _MainTex("Albedo", 2D) = "white" {}

    [Toggle(COLOR_ON)] _ColorToggle("Color, Brightness, Contrast Toggle", Int) = 0
    _Color("Color", Color) = (1,1,1)
    _Brightness ("Brightness", Range(-10.0, 10.0)) = 0.0
    _Contrast ("Contrast", Range(0.0, 3.0)) = 1

    [Toggle(PHONG_ON)] _Phong("Point Light Toggle", Int) = 0
    _PointLightColor("Point Light Color", Color) = (1,1,1,1)
    _PointLightPosition("Point Light Position", Vector) = (0.0,0.0,0.0)
    _AmbiencePower("Ambience intensity", Range(0.0,2.0)) = 1.0
    _SpecularPower("Specular intensity", Range(0.0,2.0)) = 1.0
    _DiffusePower("Diffuse intensity", Range(0.0,2.0)) = 1.0

    [Toggle(DETAIL_ON)] _Detail("Detail Map Toggle", Int) = 0
    _DetailMap("Detail Map", 2D) = "white" {}
    _DetailStrength("Detail Map Strength", Range(0.0, 2.0)) = 1
    [Toggle(DETAIL_MASK_ON)] _Mask("Detail Mask Toggle", Int) = 0
    _DetailMask("Detail Mask", 2D) = "white" {}

    [Toggle(EMISSION_ON)] _Emission("Emission Map Toggle", Int) = 0
    _EmissionMap("Emission", 2D) = "white" {}
    _EmissionStrength("Emission Strength", Range(0.0,10.0)) = 1

    [Toggle(NORMAL_ON)] _Normal("Normal Map Toggle", Int) = 0
    _NormalMap("Normal Map", 2D) = "bump" {}
  }

  SubShader {
  	Tags { "RenderType" = "Opaque" }
  	LOD 150

    Pass {
      Tags { "LightMode" = "VertexLM" }
      Lighting Off
      Cull Back
  		CGPROGRAM
      #pragma vertex vert_lm
      #pragma fragment frag_lm

      #pragma debug

      #pragma multi_compile_fog
      #pragma skip_variants FOG_LINEAR FOG_EXP

      #pragma shader_feature COLOR_ON
      #pragma shader_feature PHONG_ON
      #pragma shader_feature DETAIL_ON
      #pragma shader_feature DETAIL_MASK_ON
      #pragma shader_feature EMISSION_ON
      #pragma shader_feature NORMAL_ON

      #include "StandardMobile.cginc"
      ENDCG
    }

    Pass {
      Tags { "LightMode" = "VertexLMRGBM" }
      Lighting Off
      Cull Back
      CGPROGRAM
      #pragma vertex vert_lm
      #pragma fragment frag_lm

      #pragma debug

      #pragma multi_compile_fog
      #pragma skip_variants FOG_LINEAR FOG_EXP

      #pragma shader_feature COLOR_ON
      #pragma shader_feature PHONG_ON
      #pragma shader_feature DETAIL_ON
      #pragma shader_feature DETAIL_MASK_ON
      #pragma shader_feature EMISSION_ON
      #pragma shader_feature NORMAL_ON

      #include "StandardMobile.cginc"
      ENDCG
    }

    Pass {
      Tags { "LightMode" = "Vertex" }
      Lighting Off
      Cull Back
      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag

      #pragma debug

      #pragma multi_compile_fog
      #pragma skip_variants FOG_LINEAR FOG_EXP

      #pragma shader_feature COLOR_ON
      #pragma shader_feature PHONG_ON
      #pragma shader_feature DETAIL_ON
      #pragma shader_feature DETAIL_MASK_ON
      #pragma shader_feature EMISSION_ON
      #pragma shader_feature NORMAL_ON

      #include "StandardMobile.cginc"
      ENDCG
    }
  }

  FallBack "Mobile/VertexLit"
}
