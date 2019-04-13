#ifdef BIG_RAINBOW
/*--------------------RAINBOW--------------------*/

/*--------------------Red--------------------*/

		vec2 flare_Red_scale = vec2(0.9f*flarescale2, 0.9f*flarescale2);
		float flare_Red_pow = 4.25f;
		float flare_Red_fill = 10.0f;
		float flare_Red_offset = -0.0f;

		vec2 flare_Red_pos = vec2(  ((1.0 - lPos.x)*(flare_Red_offset + 1.0) - (flare_Red_offset*0.5))  *aspectRatio*flare_Red_scale.x,  ((1.0 - lPos.y)*(flare_Red_offset + 1.0) - (flare_Red_offset*0.5))  *flare_Red_scale.y);
		float flare_Red_ = distance(flare_Red_pos, vec2(texcoord.s*aspectRatio*flare_Red_scale.x, texcoord.t*flare_Red_scale.y));
			  flare_Red_ = 0.5 - flare_Red_;
			  flare_Red_ = clamp(flare_Red_*flare_Red_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Red_ = sin(flare_Red_*1.57075);
			  flare_Red_ = pow(flare_Red_, 1.1f);
			  flare_Red_ *= flare_Red_pow;

	//subtract
		vec2 flare_RedD_scale = vec2(0.58*flarescale2, 0.58*flarescale2);
		float flare_RedD_pow = 8.0f;
		float flare_RedD_fill = 1.4f;
		float flare_RedD_offset = -0.2f;

		vec2 flare_RedD_pos = vec2(  ((1.0 - lPos.x)*(flare_RedD_offset + 1.0) - (flare_RedD_offset*0.5))  *aspectRatio*flare_RedD_scale.x,  ((1.0 - lPos.y)*(flare_RedD_offset + 1.0) - (flare_RedD_offset*0.5))  *flare_RedD_scale.y);
		float flare_RedD_ = distance(flare_RedD_pos, vec2(texcoord.s*aspectRatio*flare_RedD_scale.x, texcoord.t*flare_RedD_scale.y));
			  flare_RedD_ = 0.5 - flare_RedD_;
			  flare_RedD_ = clamp(flare_RedD_*flare_RedD_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_RedD_ = sin(flare_RedD_*1.57075);
			  flare_RedD_ = pow(flare_RedD_, 0.9f);
			  flare_RedD_ *= flare_RedD_pow;
			  flare_Red_ = clamp(flare_Red_ - flare_RedD_, 0.0, 10.0);
			  flare_Red_ *= sunmask;

			tempColor.r += flare_Red_*1.0f*flaremultR * tempColor2.r;
			tempColor.g += flare_Red_*0.0f*flaremultG * tempColor2.r;
			tempColor.b += flare_Red_*0.0f*flaremultB * tempColor2.r;

/*--------------------Orange--------------------*/

		vec2 flare_Orange_scale = vec2(0.86f*flarescale2, 0.86f*flarescale2);
			  float flare_Orange_pow = 4.25f;
			  float flare_Orange_fill = 10.0f;
			  float flare_Orange_offset = -0.0f;

		vec2 flare_Orange_pos = vec2(  ((1.0 - lPos.x)*(flare_Orange_offset + 1.0) - (flare_Orange_offset*0.5))  *aspectRatio*flare_Orange_scale.x,  ((1.0 - lPos.y)*(flare_Orange_offset + 1.0) - (flare_Orange_offset*0.5))  *flare_Orange_scale.y);
		float flare_Orange_ = distance(flare_Orange_pos, vec2(texcoord.s*aspectRatio*flare_Orange_scale.x, texcoord.t*flare_Orange_scale.y));
			  flare_Orange_ = 0.5 - flare_Orange_;
			  flare_Orange_ = clamp(flare_Orange_*flare_Orange_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Orange_ = sin(flare_Orange_*1.57075);
			  flare_Orange_ = pow(flare_Orange_, 1.1f);
			  flare_Orange_ *= flare_Orange_pow;

	//subtract
		vec2 flare_OrangeD_scale = vec2(0.5446f*flarescale2, 0.5446f*flarescale2);
			  float flare_OrangeD_pow = 8.0f;
			  float flare_OrangeD_fill = 1.4f;
			  float flare_OrangeD_offset = -0.2f;

		vec2 flare_OrangeD_pos = vec2(  ((1.0 - lPos.x)*(flare_OrangeD_offset + 1.0) - (flare_OrangeD_offset*0.5))  *aspectRatio*flare_OrangeD_scale.x,  ((1.0 - lPos.y)*(flare_OrangeD_offset + 1.0) - (flare_OrangeD_offset*0.5))  *flare_OrangeD_scale.y);
		float flare_OrangeD_ = distance(flare_OrangeD_pos, vec2(texcoord.s*aspectRatio*flare_OrangeD_scale.x, texcoord.t*flare_OrangeD_scale.y));
			  flare_OrangeD_ = 0.5 - flare_OrangeD_;
			  flare_OrangeD_ = clamp(flare_OrangeD_*flare_OrangeD_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_OrangeD_ = sin(flare_OrangeD_*1.57075);
			  flare_OrangeD_ = pow(flare_OrangeD_, 0.9f);
			  flare_OrangeD_ *= flare_OrangeD_pow;
			  flare_Orange_ = clamp(flare_Orange_ - flare_OrangeD_, 0.0, 10.0);
			  flare_Orange_ *= sunmask;

			tempColor.r += flare_Orange_*1.0f*flaremultR * tempColor2.r;
			tempColor.g += flare_Orange_*1.0f*flaremultG * tempColor2.r;
			tempColor.b += flare_Orange_*0.0f*flaremultB * tempColor2.r;

/*--------------------Green--------------------*/

		vec2 flare_Green_scale = vec2(0.82f*flarescale2, 0.82f*flarescale2);
			  float flare_Green_pow = 4.25f;
			  float flare_Green_fill = 10.0f;
			  float flare_Green_offset = -0.0f;

		vec2 flare_Green_pos = vec2(  ((1.0 - lPos.x)*(flare_Green_offset + 1.0) - (flare_Green_offset*0.5))  *aspectRatio*flare_Green_scale.x,  ((1.0 - lPos.y)*(flare_Green_offset + 1.0) - (flare_Green_offset*0.5))  *flare_Green_scale.y);
		float flare_Green_ = distance(flare_Green_pos, vec2(texcoord.s*aspectRatio*flare_Green_scale.x, texcoord.t*flare_Green_scale.y));
			  flare_Green_ = 0.5 - flare_Green_;
			  flare_Green_ = clamp(flare_Green_*flare_Green_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Green_ = sin(flare_Green_*1.57075);
			  flare_Green_ = pow(flare_Green_, 1.1f);
			  flare_Green_ *= flare_Green_pow;

	//subtract
		vec2 flare_GreenD_scale = vec2(0.5193f*flarescale2, 0.5193f*flarescale2);
			  float flare_GreenD_pow = 8.0f;
			  float flare_GreenD_fill = 1.4f;
			  float flare_GreenD_offset = -0.2f;

		vec2 flare_GreenD_pos = vec2(  ((1.0 - lPos.x)*(flare_GreenD_offset + 1.0) - (flare_GreenD_offset*0.5))  *aspectRatio*flare_GreenD_scale.x,  ((1.0 - lPos.y)*(flare_GreenD_offset + 1.0) - (flare_GreenD_offset*0.5))  *flare_GreenD_scale.y);
		float flare_GreenD_ = distance(flare_GreenD_pos, vec2(texcoord.s*aspectRatio*flare_GreenD_scale.x, texcoord.t*flare_GreenD_scale.y));
			  flare_GreenD_ = 0.5 - flare_GreenD_;
			  flare_GreenD_ = clamp(flare_GreenD_*flare_GreenD_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_GreenD_ = sin(flare_GreenD_*1.57075);
			  flare_GreenD_ = pow(flare_GreenD_, 0.9f);
			  flare_GreenD_ *= flare_GreenD_pow;
			  flare_Green_ = clamp(flare_Green_ - flare_GreenD_, 0.0, 10.0);
			  flare_Green_ *= sunmask;

			tempColor.r += flare_Green_*0.0f*flaremultR * tempColor2.r;
			tempColor.g += flare_Green_*1.0f*flaremultG * tempColor2.r;
			tempColor.b += flare_Green_*0.0f*flaremultB * tempColor2.r;

/*--------------------Blue--------------------*/

		vec2 flare_Blue_scale = vec2(0.78f*flarescale2, 0.78f*flarescale2);
			  float flare_Blue_pow = 4.25f;
			  float flare_Blue_fill = 10.0f;
			  float flare_Blue_offset = -0.0f;

		vec2 flare_Blue_pos = vec2(  ((1.0 - lPos.x)*(flare_Blue_offset + 1.0) - (flare_Blue_offset*0.5))  *aspectRatio*flare_Blue_scale.x,  ((1.0 - lPos.y)*(flare_Blue_offset + 1.0) - (flare_Blue_offset*0.5))  *flare_Blue_scale.y);
		float flare_Blue_ = distance(flare_Blue_pos, vec2(texcoord.s*aspectRatio*flare_Blue_scale.x, texcoord.t*flare_Blue_scale.y));
			  flare_Blue_ = 0.5 - flare_Blue_;
			  flare_Blue_ = clamp(flare_Blue_*flare_Blue_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Blue_ = sin(flare_Blue_*1.57075);
			  flare_Blue_ = pow(flare_Blue_, 1.1f);
			  flare_Blue_ *= flare_Blue_pow;


	//subtract
		vec2 flare_BlueD_scale = vec2(0.494f*flarescale2, 0.494f*flarescale2);
			  float flare_BlueD_pow = 8.0f;
			  float flare_BlueD_fill = 1.4f;
			  float flare_BlueD_offset = -0.2f;

		vec2 flare_BlueD_pos = vec2(  ((1.0 - lPos.x)*(flare_BlueD_offset + 1.0) - (flare_BlueD_offset*0.5))  *aspectRatio*flare_BlueD_scale.x,  ((1.0 - lPos.y)*(flare_BlueD_offset + 1.0) - (flare_BlueD_offset*0.5))  *flare_BlueD_scale.y);
		float flare_BlueD_ = distance(flare_BlueD_pos, vec2(texcoord.s*aspectRatio*flare_BlueD_scale.x, texcoord.t*flare_BlueD_scale.y));
			  flare_BlueD_ = 0.5 - flare_BlueD_;
			  flare_BlueD_ = clamp(flare_BlueD_*flare_BlueD_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_BlueD_ = sin(flare_BlueD_*1.57075);
			  flare_BlueD_ = pow(flare_BlueD_, 0.9f);
			  flare_BlueD_ *= flare_BlueD_pow;
			  flare_Blue_ = clamp(flare_Blue_ - flare_BlueD_, 0.0, 10.0);
			  flare_Blue_ *= sunmask;

			tempColor.r += flare_Blue_*0.0f*flaremultR * tempColor2.r;
			tempColor.g += flare_Blue_*0.0f*flaremultG * tempColor2.r;
			tempColor.b += flare_Blue_*1.0f*flaremultB * tempColor2.r;

/*--------------------RAINBOW--------------------*/
#endif