Shader "VRChat/Panosphere" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		[MaterialToggle] _StereoEnabled ("Stereo Enabled", Float) = 0
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 62072
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 unused_0_1[7];
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
					out vec4 vs_TEXCOORD0;
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
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[21];
						int unity_StereoEyeIndex;
						vec4 unused_2_2;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + _WorldSpaceCameraPos.yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[64];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = unity_StereoEyeIndex;
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + unity_StereoWorldSpaceCameraPos[u_xlati0].yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[21];
						int unity_StereoEyeIndex;
						vec4 unused_2_2;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + _WorldSpaceCameraPos.yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[64];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = unity_StereoEyeIndex;
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + unity_StereoWorldSpaceCameraPos[u_xlati0].yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[21];
						int unity_StereoEyeIndex;
						vec4 unused_2_2;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + _WorldSpaceCameraPos.yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[64];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = unity_StereoEyeIndex;
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + unity_StereoWorldSpaceCameraPos[u_xlati0].yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[21];
						int unity_StereoEyeIndex;
						vec4 unused_2_2;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + _WorldSpaceCameraPos.yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "UNITY_SINGLE_PASS_STEREO" }
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
						vec4 _MainTex_ST;
						float _StereoEnabled;
					};
					layout(std140) uniform UnityStereoGlobals {
						vec4 unused_1_0[64];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityStereoEyeIndex {
						int unity_StereoEyeIndex;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					int u_xlati1;
					bvec2 u_xlatb1;
					vec2 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat6;
					bool u_xlatb7;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = unity_StereoEyeIndex;
					    u_xlat0.xyz = (-vs_TEXCOORD0.yzx) + unity_StereoWorldSpaceCameraPos[u_xlati0].yzx;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * (-u_xlat0.xyz);
					    u_xlat9 = max(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat0.z)<abs(u_xlat0.y);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat1.x + u_xlat4;
					    u_xlatb1.xy = lessThan(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
					    u_xlat4 = u_xlatb1.y ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat9 + u_xlat4;
					    u_xlat4 = min(u_xlat0.z, u_xlat0.y);
					    u_xlatb4 = u_xlat4<(-u_xlat4);
					    u_xlat3 = max(u_xlat0.z, u_xlat0.y);
					    u_xlatb3 = u_xlat3>=(-u_xlat3);
					    u_xlatb3 = u_xlatb3 && u_xlatb4;
					    u_xlat2.x = (u_xlatb3) ? (-u_xlat9) : u_xlat9;
					    u_xlat3 = abs(u_xlat0.x) * -0.0187292993 + 0.0742610022;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + -0.212114394;
					    u_xlat3 = u_xlat3 * abs(u_xlat0.x) + 1.57072878;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat6.x = u_xlat0.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * -2.0 + 3.14159274;
					    u_xlat6.x = u_xlatb1.x ? u_xlat6.x : float(0.0);
					    u_xlat2.y = u_xlat3 * u_xlat0.x + u_xlat6.x;
					    u_xlat0 = (-u_xlat2.xyxy) * vec4(0.318309873, 0.318309873, 0.159154937, 0.318309873) + vec4(1.0, 1.0, 0.0, 1.0);
					    u_xlati1 = (-unity_StereoEyeIndex) + 1;
					    u_xlat1.y = float(u_xlati1);
					    u_xlat1.x = float(0.0);
					    u_xlat1.w = float(0.5);
					    u_xlat0 = u_xlat0 + u_xlat1.xywy;
					    u_xlat6.xy = u_xlat0.zw * vec2(1.0, 0.5) + (-u_xlat0.xy);
					    u_xlat0.xy = vec2(_StereoEnabled) * u_xlat6.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "ShaderForgeMaterialInspector"
}