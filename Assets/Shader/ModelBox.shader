Shader "Custom/ModelBox"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        //边框的大小（膨胀的大了，边框就大，反之就小）
        _Outline ("Outline Width", Range(0.002,0.1)) = 0.005
        //边框的颜色，我们要做黑影，所以就先来个黑色
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)

    }
    SubShader
    {
        ZWrite Off
        //画第一次
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;
        float4 _OutlineColor;
        float _Outline;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        void vert(inout appdata_full v)
        {
            v.vertex.xyz +=v.normal * _Outline;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor.rgb;
        }

        ENDCG

        //画第二次
        ZWrite On

        CGPROGRAM
        #pragma surface surf Lambert 
        struct Input{
            float2 uv_MainTex;
        };
        
        sampler2D _MainTex;
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
        
    }
    
    FallBack "Diffuse"
}
