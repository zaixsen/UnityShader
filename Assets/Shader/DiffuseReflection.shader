Shader "Custom/DiffuseReflection"  //漫反射
{

//	兰伯特逐顶点算法                                            
// 屏幕上对应点的颜色 = （光的颜色*物体的颜色）* max（0，该点的法向量 ·（点乘） 该点的光照方向）
/*  兰伯特逐顶点算法 
	SubShader  //Shader的主要部分  每个 Shader 有多个 SubShader
	{
		pass
		{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"
				#include "Lighting.cginc"

				appdata_full vert(appdata_full v)
				{
					//模型顶点坐标转屏幕坐标
					v.vertex = UnityObjectToClipPos(v.vertex);

					//获取法线坐标并转换成世界坐标下的法线坐标
					float3 worldNormal = UnityObjectToWorldNormal(v.normal);

					//世界坐标下的光线坐标  //单位化坐标   //获取世界坐标下的光线坐标
					float3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
					
					float3 diffuse =_LightColor0.rgb * v.color.rgb * max(0,dot(worldNormal,worldLight));
					
					//算出的值给颜色
					v.color = float4(diffuse,1);
                
					return v;
				}

				float4 frag (appdata_full v) : SV_Target
				{    
					//输出颜色    
					return float4(v.color) ;
				}
	
			ENDCG
		}	
	}
*/

//	兰伯特逐像素算法
/* SubShader伯特逐像素算法
	{
		Pass
		{
			CGPROGRAM 
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"
				#include "Lighting.cginc"

				appdata_full vert(appdata_full v)
				{
					v.vertex=UnityObjectToClipPos(v.vertex);
					return v;
				}

				float4 frag(appdata_full v) : SV_Target
				{
					//法线世界坐标
					float3 worldNormal=v.normal;
					
					//光线世界坐标
					float3 worldLight = normalize(_WorldSpaceLightPos0.xyz);

					//计算颜色            //光的颜色 * 物体的颜色 * max(0,该点的法向量和该点的光照)
					float3 diffuse = _LightColor0.rgb * v.color.rgb * max(0,dot(worldNormal , worldLight));

					return float4(diffuse,1);
				}

			ENDCG
		}

	}
*/

// 半兰伯特算法  比上两个光照要淡一点
	SubShader 
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			appdata_full vert(appdata_full v)
			{
				v.vertex = UnityObjectToClipPos(v.vertex);
				return v;
			}

			float4 frag(appdata_full v) : SV_TARGET
			{
				float3 worldNormal = v.normal;
				float3 worldLight=normalize(_WorldSpaceLightPos0.xyz);

				//获取环境光
				float3 anbient=UNITY_LIGHTMODEL_AMBIENT.xyz;

				//计算范围
				float3 halfLamient=dot(worldNormal,worldLight)*0.5+0.5;

				//计算发射强度
				float3 diffuse = _LightColor0.rgb*v.color.rgb*halfLamient;
				
				float3 c = diffuse + anbient;

				return float4(diffuse,1);

			}
			ENDCG
		}

	}	

}
