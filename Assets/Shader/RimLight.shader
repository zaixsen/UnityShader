Shader "Custom/RimLight"
{
    // 边缘光
    // 视角和物体表面的 点乘 夹角 夹角越大颜色值越大 否则越小  设置自发光属性
    Properties
    {
        _Color ("Color", Color) = (0,0.5,0.5,0)
        _Color2 ("Color", Color) = (1,1,1,1)
        _MainTex("MainTex",2D)="write"{}
        _Power("Pow",Range(0.1,10))=3
        _UnGradualChange("UnGradualChange",Range(0,1))=0.2
    }

    SubShader
    {
        CGPROGRAM

            //表面                 兰伯特
            #pragma surface surf Lambert

            float4 _Color;
            float4 _Color2;
            sampler2D _MainTex;
            float _Power;
            float _UnGradualChange;

            struct Input
            {
                float3 viewDir;

                float2 uv_MainTex;

                //世界坐标
                float3 worldPos;
            };

            void surf(Input IN,inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;

                //点乘后，如果接近1，说明在视线正中，接近0则在视线边缘
                half dotp= dot(IN.viewDir,o.Normal);
                //参数控制 带渐变
                //o.Emission=_Color.rgb * pow((1-dotp),_Power);
                // 无渐变
                //o.Emission= _Color.rgb * dotp < _UnGradualChange?1:0;
                //同心圆
                //o.Emission= dotp < _UnGradualChange?_Color2.rgb:_Color.rgb;
                //世界坐标影响
                //o.Emission= IN.worldPos.y >0 ?_Color2.rgb:_Color.rgb;
                //斑马纹 坐标的奇数和偶数分开
                //o.Emission=(frac(IN.worldPos.y*10 %2)>0.5 ?_Color2.rgb:_Color.rgb );
                //效果合并
                o.Emission=(frac(IN.worldPos.y*10 %2)>0.5 ?_Color2.rgb:_Color.rgb )* pow((1-dotp),_Power);

            }

        ENDCG
    }

    FallBack "Diffuse"
}
