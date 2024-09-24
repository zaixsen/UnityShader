Shader "Custom/AlphaTextrueMask"
{
    // 透明纹理

    // Tags
    // {
    //     "Queue"="Transparent"
    // }
    
    Properties
    {
        _MainTex("MainTex",2D)="write"{}
        
        _SRef("Stecil Ref",Float)=1
        //选项    引用UnityEngine.Rendering.CompareFunction作为enum
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp",Float) = 8
        //选项    引用UnityEngine.Rendering.StencilOp作为enum
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op",Float) = 2
    }
    /*
        struct SurfaceOutput
        {
            fixed3 Albedo;  // 贴图颜色
            fixed3 Normal;  // 法线
            fixed3 Emission;//自发光
            half Specular;  // 0..1 范围内的镜面反射能力
            fixed Gloss;    // 镜面反射强度
            fixed Alpha;    // 透明度 Alpha
        };
    */
    SubShader
    {
        //Cull Back（默认）:       只显示正面，不显示背面
        //Cull Front：             只显示背面，不显示正面
        //Cull Off                 都显示

        Cull Off

        Tags
        {
            "Queue" = "Transparent-1"  //遮罩就会提前渲染
        }

        Stencil
		{
            // Stencil ID ：在代码中是Ref
            // Stencil Comparison：在代码中是Comp
            // Stencil  Operation：在代码中是Pass

            Ref [_SRef]
            Comp [_SComp]
            Pass [_SOp]
		}

        CGPROGRAM

            //表面                 兰伯特  //本节关键 调用Alpha的类型
            #pragma surface surf Lambert alpha : fade

            sampler2D _MainTex;

            struct Input
            {
                float2 uv_MainTex;
            };

            void surf(Input IN,inout SurfaceOutput o)
            {
                fixed4 c = tex2D(_MainTex , IN.uv_MainTex);

                o.Albedo=c.rgb;

                o.Alpha=c.a;
            }

        ENDCG
    }

    FallBack "Diffuse"
}
