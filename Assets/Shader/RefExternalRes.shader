Shader "Custom/RefExternalRes"  //定义Shader名称
{
	Properties 
	{
		//颜色
		_Color("Color",Color)=(1,1,1,1)

		//纹理
		_MainTex("MainTex",2D)="write"{}
		//3D 图片
		_Tex3("Textrue 3D",3D)="write"{}
		_Cube("Cube图片",Cube)=""{}

		//数字
		_Float("Float 数字",Float) = 0.5
		_Int("Int 数字",Int) = 1
		_Range("范围",Range(0,100)) = 1
		_Vector("坐标",Vector)=(1,1,1,1)

		//Toggle
		[Toggle] _MyToggle("MyToggle",float) = 0
	}

	SubShader  //Shader的主要部分  每个 Shader 有多个 SubShader
	{
		pass
		{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				//引用方式
				float4 _Color;
				sampler2D _MainTex;
				sampler3D _Tex3;
				samplerCUBE _Cube;

				float _Float;
				int _Int;

				half _Range;
				float4 _Vector;

				appdata_base vert(appdata_base v)
				{
					v.vertex=UnityObjectToClipPos(v.vertex);
					return v;
				}

				float4 frag(appdata_base v):SV_TARGET
				{ 
					//颜色和颜色的叠加一般用相乘。（这里和数学矩阵有关，可自行学习）
					return tex2D(_MainTex,v.texcoord.xy) *_Color;
				}
			ENDCG
		}	
	
	}
}
