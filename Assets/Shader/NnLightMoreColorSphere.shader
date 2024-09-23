Shader "Custom/NoLightMoreColorSphere"  //定义Shader名称
{
	SubShader  //Shader的主要部分  每个 Shader 有多个 SubShader
	{
		pass	//每个 SubShader 有多个 pass
		{
			CGPROGRAM  // 标志着一个 CG/HLSL 程序块的开始
			#pragma vertex vert   //顶点着色器
			#pragma fragment frag //片源着色器

			#include "UnityCG.cginc"  //引入的是一些常用的数学和图形函数

			appdata_base vert(appdata_base v)
			{
				v.vertex = UnityObjectToClipPos(v.vertex);   //顶点坐标从对象空间变换为裁剪坐标
				return v;  //返回给渲染管线 
			}
			
			float4 frag(appdata_base v) : SV_TARGET  // 表示这个函数的返回值是一个颜色输出 (在屏幕上渲染的颜色)
			{

				float3 n = v.normal / 2 + float3(0.5,0.5,0.5);  //将法线范围从 [-1, 1] 转换为 [0, 1]
					
				return float4(n,1);	//R G B A 最后一位是Alpha
				
			}

			ENDCG  //标志着 CG/HLSL 程序块的结束，结束之前定义的 CG 代码段
		} 
	}
}
