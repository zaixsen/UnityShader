Shader "Custom/RockNormalMap"
{
        Properties
        {
            //首先先放两个图片进来
            //正常图片
            _MainTexture ("Texture", 2D) = "white" {}
            //法线图片
            _MainNormal ("NormalTexture",2D) = "bump" {}
        }
     
        SubShader
        {
            CGPROGRAM
     
            //引入已有的脚本
            #pragma surface surf Lambert
     
            //把上面资源里的图，接收到shader语法里
            //注意事项:名字必须和上面一样
            sampler2D _MainTexture;
            sampler2D _MainNormal;
     
            //待会我们需要把 图片数据 转换成 坐标数据
            struct Input
            {   
                //准备接受主图的坐标数据
                float2 uv_MainTexture;
                //准备接收法线图片的坐标数据
                float2 uv_MainNormal;
     
                //注意事项:名字只能是上面的名字前面加uv
            };
     
            //写了一个方法，把shader原有的数据引入进来  把输出的接口也拿过来
            void surf(Input IN, inout SurfaceOutput o )
            {
                //改反射的内容    获取图片上的rgba改成坐标信息，但我们只要rgb的数据
                o.Albedo = tex2D(_MainTexture,IN.uv_MainTexture).rgb;
        
                //改法线信息    //这里因为rgb的数据是（0,1），但法线数据是（-1,1），所以需要二次转换一下
                o.Normal = UnpackNormal(tex2D(_MainNormal,IN.uv_MainNormal));
        
                //备注：这里的unpackNormal的全称是UnpackNormalFromTexture,
                //     意思是，从texture恢复（解压）成Normal
            }
     
            ENDCG
            }
     
        FallBack "Diffuse"
}
