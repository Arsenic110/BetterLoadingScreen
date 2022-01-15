Shader "FORGE3D/Billboard Nebula" {
	Properties {
		_CoronaNoise ("Texture", 2D) = "black" {}
		_CoronaColor ("Color", Vector) = (0.5,0.5,0.5,0.5)
		_EdgeMaskFalloff ("Edge Mask Falloff", Float) = 0
		_EdgeMaskPower ("Edge Mask Power", Float) = 0
		_MinFadeStart ("Min Fade Start", Float) = 0
		_MinFadeEnd ("Min Fade End", Float) = 0
		_MaxFadeStart ("Max Fade Start", Float) = 0
		_MaxFadeEnd ("Max Fade End", Float) = 0
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 25433
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    vs_TEXCOORD1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    vs_TEXCOORD1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_SINGLE_PASS_STEREO" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[24];
						mat4x4 unity_StereoMatrixVP[2];
						vec4 unused_1_2[40];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlati0 = unity_StereoEyeIndex << 2;
					    u_xlat2 = u_xlat1.yyyy * unity_StereoMatrixVP[(u_xlati0 + 1) / 4][(u_xlati0 + 1) % 4];
					    u_xlat2 = unity_StereoMatrixVP[u_xlati0 / 4][u_xlati0 % 4] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_StereoMatrixVP[(u_xlati0 + 2) / 4][(u_xlati0 + 2) % 4] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_StereoMatrixVP[(u_xlati0 + 3) / 4][(u_xlati0 + 3) % 4] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    vs_TEXCOORD1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    vs_TEXCOORD1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SOFTPARTICLES_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    vs_TEXCOORD1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    vs_TEXCOORD1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SOFTPARTICLES_ON" "UNITY_SINGLE_PASS_STEREO" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[24];
						mat4x4 unity_StereoMatrixVP[2];
						vec4 unused_1_2[40];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlati0 = unity_StereoEyeIndex << 2;
					    u_xlat2 = u_xlat1.yyyy * unity_StereoMatrixVP[(u_xlati0 + 1) / 4][(u_xlati0 + 1) % 4];
					    u_xlat2 = unity_StereoMatrixVP[u_xlati0 / 4][u_xlati0 % 4] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_StereoMatrixVP[(u_xlati0 + 2) / 4][(u_xlati0 + 2) % 4] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_StereoMatrixVP[(u_xlati0 + 3) / 4][(u_xlati0 + 3) % 4] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    vs_TEXCOORD1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    vs_TEXCOORD1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _CoronaColor;
						float _EdgeMaskFalloff;
						float _EdgeMaskPower;
						float _MinFadeStart;
						float _MinFadeEnd;
						float _MaxFadeStart;
						float _MaxFadeEnd;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _CoronaNoise;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat6);
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _EdgeMaskFalloff;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _EdgeMaskPower;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_CoronaNoise, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _CoronaColor.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.29999995, 1.29999995, 1.29999995);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat1.x = (-u_xlat6) + _MaxFadeEnd;
					    u_xlat6 = (-u_xlat6) + _MinFadeEnd;
					    u_xlat3 = (-_MaxFadeStart) + _MaxFadeEnd;
					    u_xlat1.x = u_xlat1.x / u_xlat3;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.x = (-_MinFadeEnd) + _MinFadeStart;
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.5, 1.5, 1.5);
					    SV_Target0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_SINGLE_PASS_STEREO" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _CoronaColor;
						float _EdgeMaskFalloff;
						float _EdgeMaskPower;
						float _MinFadeStart;
						float _MinFadeEnd;
						float _MaxFadeStart;
						float _MaxFadeEnd;
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[64];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					uniform  sampler2D _CoronaNoise;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					int u_xlati6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlati6 = unity_StereoEyeIndex;
					    u_xlat1.xyz = (-vs_TEXCOORD0.xyz) + unity_StereoWorldSpaceCameraPos[u_xlati6].xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat6);
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _EdgeMaskFalloff;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _EdgeMaskPower;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_CoronaNoise, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _CoronaColor.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.29999995, 1.29999995, 1.29999995);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat1.x = (-u_xlat6) + _MaxFadeEnd;
					    u_xlat6 = (-u_xlat6) + _MinFadeEnd;
					    u_xlat3 = (-_MaxFadeStart) + _MaxFadeEnd;
					    u_xlat1.x = u_xlat1.x / u_xlat3;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.x = (-_MinFadeEnd) + _MinFadeStart;
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.5, 1.5, 1.5);
					    SV_Target0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SOFTPARTICLES_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _CoronaColor;
						float _EdgeMaskFalloff;
						float _EdgeMaskPower;
						float _MinFadeStart;
						float _MinFadeEnd;
						float _MaxFadeStart;
						float _MaxFadeEnd;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _CoronaNoise;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat6);
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _EdgeMaskFalloff;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _EdgeMaskPower;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_CoronaNoise, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _CoronaColor.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.29999995, 1.29999995, 1.29999995);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat1.x = (-u_xlat6) + _MaxFadeEnd;
					    u_xlat6 = (-u_xlat6) + _MinFadeEnd;
					    u_xlat3 = (-_MaxFadeStart) + _MaxFadeEnd;
					    u_xlat1.x = u_xlat1.x / u_xlat3;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.x = (-_MinFadeEnd) + _MinFadeStart;
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.5, 1.5, 1.5);
					    SV_Target0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SOFTPARTICLES_ON" "UNITY_SINGLE_PASS_STEREO" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _CoronaColor;
						float _EdgeMaskFalloff;
						float _EdgeMaskPower;
						float _MinFadeStart;
						float _MinFadeEnd;
						float _MaxFadeStart;
						float _MaxFadeEnd;
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[64];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					uniform  sampler2D _CoronaNoise;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					int u_xlati6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlati6 = unity_StereoEyeIndex;
					    u_xlat1.xyz = (-vs_TEXCOORD0.xyz) + unity_StereoWorldSpaceCameraPos[u_xlati6].xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat6);
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _EdgeMaskFalloff;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _EdgeMaskPower;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_CoronaNoise, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _CoronaColor.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.29999995, 1.29999995, 1.29999995);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat1.x = (-u_xlat6) + _MaxFadeEnd;
					    u_xlat6 = (-u_xlat6) + _MinFadeEnd;
					    u_xlat3 = (-_MaxFadeStart) + _MaxFadeEnd;
					    u_xlat1.x = u_xlat1.x / u_xlat3;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.x = (-_MinFadeEnd) + _MinFadeStart;
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.5, 1.5, 1.5);
					    SV_Target0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}