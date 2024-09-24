Shader "Custom/HoloGraphic"
{
    Properties
    {
        _Color ("Color", Color) = (0,0.5,0.5,0)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Power("Power",Range(0,10)) = 1
    }

    SubShader
    {
        Tags
        {
            "Queue" ="Transparent"
        }
        //这里先把遮挡的都清空
        Pass
        {
            ColorMask 0
        }

        CGPROGRAM

        #pragma surface surf Lambert alpha:fade

        float4 _Color;
        float _Power;

        struct Input
        {
            float2 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            half dotp = 1 - saturate(dot(normalize(IN.viewDir),o.Normal));

            o.Emission = _Color.rgb * pow(dotp,_Power) * 100;
            
            o.Alpha = pow(dotp,_Power);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
