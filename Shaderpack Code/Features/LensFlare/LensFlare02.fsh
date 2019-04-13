void LensFlare(inout vec3 color)
{
vec3 tempColor2 = vec3(0.0);
float pw = 1.0 / viewWidth;
float ph = 1.0 / viewHeight;
vec3 sP = sunPosition;

	vec4 tpos = vec4(sP,1.0)*gbufferProjection;
	tpos = vec4(tpos.xyz/tpos.w,1.0);
	vec2 lPos = tpos.xy / tpos.z;
	lPos = (lPos + 1.0f)/2.0f;
	//lPos = clamp(lPos, vec2(0.001f), vec2(0.999f));
	vec2 checkcoord = lPos;

if (checkcoord.x < 1.0f && checkcoord.x > 0.0f && checkcoord.y < 1.0f && checkcoord.y > 0.0f && timeMidnight < 1.0)
	{
	vec2 checkcoord;

	float sunmask = 0.0f;
	float sunstep = -4.5f;
	float masksize = 0.004f;

	for (int a = 0; a < 4; a++)
		{
		for(int b = 0; b < 4; b++)
			{
			checkcoord = lPos + vec2(pw*a*5.0f,ph*5.0f*b);
			bool sky = false;
			float matID = GetMaterialIDs(checkcoord);
			matID = floor(matID * 255.0f);

			//Catch last part of sky
			if (matID > 254.0f)
			{
				matID = 0.0f;
			}

			if (matID == 0)
			{
				sky = true;
			} else {
				sky = false;
			}


			if (checkcoord.x < 1.0f && checkcoord.x > 0.0f && checkcoord.y < 1.0f && checkcoord.y > 0.0f)
				{
					if (sky == true)
					{
						sunmask = 1.0f;
					} else {
						sunmask = 0.0f;
					}
				}
			}
		}

			sunmask *= 0.34 * (1.0f - timeMidnight);
			sunmask *= (1.0f - rainStrength);

		if (sunmask > 0.02)
		{
		//Detect if sun is on edge of screen
		float edgemaskx = clamp(distance(lPos.x, 0.5f)*8.0f - 3.0f, 0.0f, 1.0f);
		float edgemasky = clamp(distance(lPos.y, 0.5f)*8.0f - 3.0f, 0.0f, 1.0f);

		//Darken colors if the sun is visible
			float centermask = 1.0 - clamp(distance(lPos.xy, vec2(0.5f, 0.5f))*2.0, 0.0, 1.0);
				  centermask = pow(centermask, 1.0f);
				  centermask *= sunmask;

			color.r *= (1.0 - centermask * (1.0f - timeMidnight));
			color.g *= (1.0 - centermask * (1.0f - timeMidnight));
			color.b *= (1.0 - centermask * (1.0f - timeMidnight));

		 //Adjust global flare settings
			const float flaremultR = 0.8f;
			const float flaremultG = 1.0f;
			const float flaremultB = 1.5f;

			float flarescale = 1.0f;
			const float flarescaleconst = 1.0f;

		 //Flare gets bigger at center of screen

			//flarescale *= (1.0 - centermask);

//RAINBOW--------------------------------------------------------------------------------
//Lens

	float flarescale2 = 1.1f;
	float flarescale3 = 2.0f;
	float flarescale4 = 1.5f;

	vec3 tempColor = vec3(0.0);
	vec3 tempColor3 = vec3(0.0);
	vec3 tempColor4 = vec3(0.0);
	vec2 resolution = vec2(viewWidth, viewHeight);

	float PI = 3.141592;
	vec2 uv = (texcoord.xy);

	float random = fract(sin(dot(sunPosition.xy, vec2(12.9898, 78.233)))* 43758.5453);
		  random - 0.25f;

		if (random < 0.25f)
		{
			random = 0.25f;
		}

		float c = 0.0;
		float dx = uv.x - 0.5;
		float dy = uv.y - 0.5;
		c = (atan(dy, dx) / PI + 1.0) * 1.0;
		float t = (sin(random) + 1.0) * 1.0;
		c = tan(c * t * 1000.0);

		vec4 tempColor2 = vec4(c, c, c, 1.0 );

		if (tempColor2.r < 0.7f)
		{
			tempColor2.r = 0.7f;
		}
		else if (tempColor2.r > 1.0f)
		{
			tempColor2.r = 1.0f;
		}

	sin(tempColor2);

		//color.r = tempColor2.r;
		//color.g = tempColor2.r;
		//color.b = tempColor2.r;

//-------------------Red--------------------------------------------------------------------------------------

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

//--------------------------------------------------------------------------------------

//-------------------Orange--------------------------------------------------------------------------------------

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

//--------------------------------------------------------------------------------------

//-------------------Green--------------------------------------------------------------------------------------

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

//--------------------------------------------------------------------------------------

//-------------------Blue--------------------------------------------------------------------------------------

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

//--------------------------------------------------------------------------------------


//RAINBOW2--------------------------------------------------------------------------------


//-------------------Red2--------------------------------------------------------------------------------------

		 vec2 flare_Red2_scale = vec2(0.9f*flarescale3, 0.9f*flarescale3);
		float flare_Red2_pow = 4.25f;
		float flare_Red2_fill = 10.0f;
		float flare_Red2_offset = -0.0f;
		 vec2 flare_Red2_pos = vec2(  ((1.0 - lPos.x)*(flare_Red2_offset + 1.0) - (flare_Red2_offset*0.5))  *aspectRatio*flare_Red2_scale.x,  ((1.0 - lPos.y)*(flare_Red2_offset + 1.0) - (flare_Red2_offset*0.5))  *flare_Red2_scale.y);

		float flare_Red2_ = distance(flare_Red2_pos, vec2(texcoord.s*aspectRatio*flare_Red2_scale.x, texcoord.t*flare_Red2_scale.y));
			  flare_Red2_ = 0.5 - flare_Red2_;
			  flare_Red2_ = clamp(flare_Red2_*flare_Red2_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Red2_ = sin(flare_Red2_*1.57075);
			  flare_Red2_ = pow(flare_Red2_, 1.1f);
			  flare_Red2_ *= flare_Red2_pow;

	//subtract
		 vec2 flare_Red2D_scale = vec2(0.58*flarescale3, 0.58*flarescale3);
		float flare_Red2D_pow = 8.0f;
		float flare_Red2D_fill = 1.4f;
		float flare_Red2D_offset = -0.2f;
		 vec2 flare_Red2D_pos = vec2(  ((1.0 - lPos.x)*(flare_Red2D_offset + 1.0) - (flare_Red2D_offset*0.5))  *aspectRatio*flare_Red2D_scale.x,  ((1.0 - lPos.y)*(flare_Red2D_offset + 1.0) - (flare_Red2D_offset*0.5))  *flare_Red2D_scale.y);


		float flare_Red2D_ = distance(flare_Red2D_pos, vec2(texcoord.s*aspectRatio*flare_Red2D_scale.x, texcoord.t*flare_Red2D_scale.y));
			  flare_Red2D_ = 0.5 - flare_Red2D_;
			  flare_Red2D_ = clamp(flare_Red2D_*flare_Red2D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Red2D_ = sin(flare_Red2D_*1.57075);
			  flare_Red2D_ = pow(flare_Red2D_, 0.9f);
			  flare_Red2D_ *= flare_Red2D_pow;
			  flare_Red2_ = clamp(flare_Red2_ - flare_Red2D_, 0.0, 10.0);
			  flare_Red2_ *= sunmask;

		tempColor3.r += flare_Red2_*10.0f*flaremultR * (tempColor2.r / 16);
		tempColor3.g += flare_Red2_*0.0f*flaremultG * (tempColor2.r / 16);
		tempColor3.b += flare_Red2_*0.0f*flaremultB * (tempColor2.r / 16);

//--------------------------------------------------------------------------------------

//-------------------Orange2--------------------------------------------------------------------------------------

		 vec2 flare_Orange2_scale = vec2(0.86f*flarescale3, 0.86f*flarescale3);
		float flare_Orange2_pow = 4.25f;
		float flare_Orange2_fill = 10.0f;
		float flare_Orange2_offset = -0.0f;
		 vec2 flare_Orange2_pos = vec2(  ((1.0 - lPos.x)*(flare_Orange2_offset + 1.0) - (flare_Orange2_offset*0.5))  *aspectRatio*flare_Orange2_scale.x,  ((1.0 - lPos.y)*(flare_Orange2_offset + 1.0) - (flare_Orange2_offset*0.5))  *flare_Orange2_scale.y);

		float flare_Orange2_ = distance(flare_Orange2_pos, vec2(texcoord.s*aspectRatio*flare_Orange2_scale.x, texcoord.t*flare_Orange2_scale.y));
			  flare_Orange2_ = 0.5 - flare_Orange2_;
			  flare_Orange2_ = clamp(flare_Orange2_*flare_Orange2_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Orange2_ = sin(flare_Orange2_*1.57075);
			  flare_Orange2_ = pow(flare_Orange2_, 1.1f);
			  flare_Orange2_ *= flare_Orange2_pow;

	//subtract
		 vec2 flare_Orange2D_scale = vec2(0.5446f*flarescale3, 0.5446f*flarescale3);
		float flare_Orange2D_pow = 8.0f;
		float flare_Orange2D_fill = 1.4f;
		float flare_Orange2D_offset = -0.2f;
		 vec2 flare_Orange2D_pos = vec2(  ((1.0 - lPos.x)*(flare_Orange2D_offset + 1.0) - (flare_Orange2D_offset*0.5))  *aspectRatio*flare_Orange2D_scale.x,  ((1.0 - lPos.y)*(flare_Orange2D_offset + 1.0) - (flare_Orange2D_offset*0.5))  *flare_Orange2D_scale.y);

		float flare_Orange2D_ = distance(flare_Orange2D_pos, vec2(texcoord.s*aspectRatio*flare_Orange2D_scale.x, texcoord.t*flare_Orange2D_scale.y));
			  flare_Orange2D_ = 0.5 - flare_Orange2D_;
			  flare_Orange2D_ = clamp(flare_Orange2D_*flare_Orange2D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Orange2D_ = sin(flare_Orange2D_*1.57075);
			  flare_Orange2D_ = pow(flare_Orange2D_, 0.9f);
			  flare_Orange2D_ *= flare_Orange2D_pow;
			  flare_Orange2_ = clamp(flare_Orange2_ - flare_Orange2D_, 0.0, 10.0);
			  flare_Orange2_ *= sunmask;

		tempColor3.r += flare_Orange2_*10.0f*flaremultR * (tempColor2.r / 16);
		tempColor3.g += flare_Orange2_*5.0f*flaremultG * (tempColor2.r / 16);
		tempColor3.b += flare_Orange2_*0.0f*flaremultB * (tempColor2.r / 16);

//--------------------------------------------------------------------------------------

//-------------------Green2--------------------------------------------------------------------------------------

		 vec2 flare_Green2_scale = vec2(0.82f*flarescale3, 0.82f*flarescale3);
		float flare_Green2_pow = 4.25f;
		float flare_Green2_fill = 10.0f;
		float flare_Green2_offset = -0.0f;
		 vec2 flare_Green2_pos = vec2(  ((1.0 - lPos.x)*(flare_Green2_offset + 1.0) - (flare_Green2_offset*0.5))  *aspectRatio*flare_Green2_scale.x,  ((1.0 - lPos.y)*(flare_Green2_offset + 1.0) - (flare_Green2_offset*0.5))  *flare_Green2_scale.y);

		float flare_Green2_ = distance(flare_Green2_pos, vec2(texcoord.s*aspectRatio*flare_Green2_scale.x, texcoord.t*flare_Green2_scale.y));
			  flare_Green2_ = 0.5 - flare_Green2_;
			  flare_Green2_ = clamp(flare_Green2_*flare_Green2_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Green2_ = sin(flare_Green2_*1.57075);
			  flare_Green2_ = pow(flare_Green2_, 1.1f);
			  flare_Green2_ *= flare_Green2_pow;

	//subtract
		 vec2 flare_Green2D_scale = vec2(0.5193f*flarescale3, 0.5193f*flarescale3);
		float flare_Green2D_pow = 8.0f;
		float flare_Green2D_fill = 1.4f;
		float flare_Green2D_offset = -0.2f;
		 vec2 flare_Green2D_pos = vec2(  ((1.0 - lPos.x)*(flare_Green2D_offset + 1.0) - (flare_Green2D_offset*0.5))  *aspectRatio*flare_Green2D_scale.x,  ((1.0 - lPos.y)*(flare_Green2D_offset + 1.0) - (flare_Green2D_offset*0.5))  *flare_Green2D_scale.y);

		float flare_Green2D_ = distance(flare_Green2D_pos, vec2(texcoord.s*aspectRatio*flare_Green2D_scale.x, texcoord.t*flare_Green2D_scale.y));
			  flare_Green2D_ = 0.5 - flare_Green2D_;
			  flare_Green2D_ = clamp(flare_Green2D_*flare_Green2D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Green2D_ = sin(flare_Green2D_*1.57075);
			  flare_Green2D_ = pow(flare_Green2D_, 0.9f);
			  flare_Green2D_ *= flare_Green2D_pow;
			  flare_Green2_ = clamp(flare_Green2_ - flare_Green2D_, 0.0, 10.0);
			  flare_Green2_ *= sunmask;

		tempColor3.r += flare_Green2_*0.0f*flaremultR * (tempColor2.r / 2);
		tempColor3.g += flare_Green2_*1.0f*flaremultG * (tempColor2.r / 2);
		tempColor3.b += flare_Green2_*0.0f*flaremultB * (tempColor2.r / 2);

//--------------------------------------------------------------------------------------

//-------------------Blue2--------------------------------------------------------------------------------------

		 vec2 flare_Blue2_scale = vec2(0.78f*flarescale3, 0.78f*flarescale3);
		float flare_Blue2_pow = 4.25f;
		float flare_Blue2_fill = 10.0f;
		float flare_Blue2_offset = -0.0f;
		 vec2 flare_Blue2_pos = vec2(  ((1.0 - lPos.x)*(flare_Blue2_offset + 1.0) - (flare_Blue2_offset*0.5))  *aspectRatio*flare_Blue2_scale.x,  ((1.0 - lPos.y)*(flare_Blue2_offset + 1.0) - (flare_Blue2_offset*0.5))  *flare_Blue2_scale.y);

		float flare_Blue2_ = distance(flare_Blue2_pos, vec2(texcoord.s*aspectRatio*flare_Blue2_scale.x, texcoord.t*flare_Blue2_scale.y));
			  flare_Blue2_ = 0.5 - flare_Blue2_;
			  flare_Blue2_ = clamp(flare_Blue2_*flare_Blue2_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Blue2_ = sin(flare_Blue2_*1.57075);
			  flare_Blue2_ = pow(flare_Blue2_, 1.1f);
			  flare_Blue2_ *= flare_Blue2_pow;

	//subtract
		 vec2 flare_Blue2D_scale = vec2(0.494f*flarescale3, 0.494f*flarescale3);
		float flare_Blue2D_pow = 8.0f;
		float flare_Blue2D_fill = 1.4f;
		float flare_Blue2D_offset = -0.2f;
		 vec2 flare_Blue2D_pos = vec2(  ((1.0 - lPos.x)*(flare_Blue2D_offset + 1.0) - (flare_Blue2D_offset*0.5))  *aspectRatio*flare_Blue2D_scale.x,  ((1.0 - lPos.y)*(flare_Blue2D_offset + 1.0) - (flare_Blue2D_offset*0.5))  *flare_Blue2D_scale.y);

		float flare_Blue2D_ = distance(flare_Blue2D_pos, vec2(texcoord.s*aspectRatio*flare_Blue2D_scale.x, texcoord.t*flare_Blue2D_scale.y));
			  flare_Blue2D_ = 0.5 - flare_Blue2D_;
			  flare_Blue2D_ = clamp(flare_Blue2D_*flare_Blue2D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Blue2D_ = sin(flare_Blue2D_*1.57075);
			  flare_Blue2D_ = pow(flare_Blue2D_, 0.9f);
			  flare_Blue2D_ *= flare_Blue2D_pow;
			  flare_Blue2_ = clamp(flare_Blue2_ - flare_Blue2D_, 0.0, 10.0);
			  flare_Blue2_ *= sunmask;

		tempColor3.r += flare_Blue2_*0.0f*flaremultR * (tempColor2.r / 2);
		tempColor3.g += flare_Blue2_*0.0f*flaremultG * (tempColor2.r / 2);
		tempColor3.b += flare_Blue2_*1.0f*flaremultB * (tempColor2.r / 2);

//--------------------------------------------------------------------------------------


//-------------------Red3--------------------------------------------------------------------------------------

		 vec2 flare_Red3_scale = vec2(0.9f*flarescale4, 0.9f*flarescale4);
		float flare_Red3_pow = 4.25f;
		float flare_Red3_fill = 10.0f;
		float flare_Red3_offset = -2.0f;
		 vec2 flare_Red3_pos = vec2(  ((1.0 - lPos.x)*(flare_Red3_offset + 1.0) - (flare_Red3_offset*0.5))  *aspectRatio*flare_Red3_scale.x,  ((1.0 - lPos.y)*(flare_Red3_offset + 1.0) - (flare_Red3_offset*0.5))  *flare_Red3_scale.y);

		float flare_Red3_ = distance(flare_Red3_pos, vec2(texcoord.s*aspectRatio*flare_Red3_scale.x, texcoord.t*flare_Red3_scale.y));
			  flare_Red3_ = 0.5 - flare_Red3_;
			  flare_Red3_ = clamp(flare_Red3_*flare_Red3_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Red3_ = sin(flare_Red3_*1.57075);
			  flare_Red3_ = pow(flare_Red3_, 1.1f);
			  flare_Red3_ *= flare_Red3_pow;

	//subtract
		 vec2 flare_Red3D_scale = vec2(0.58*flarescale4, 0.58*flarescale4);
		float flare_Red3D_pow = 8.0f;
		float flare_Red3D_fill = 1.4f;
		float flare_Red3D_offset = -1.8f;
		 vec2 flare_Red3D_pos = vec2(  ((1.0 - lPos.x)*(flare_Red3D_offset + 1.0) - (flare_Red3D_offset*0.5))  *aspectRatio*flare_Red3D_scale.x,  ((1.0 - lPos.y)*(flare_Red3D_offset + 1.0) - (flare_Red3D_offset*0.5))  *flare_Red3D_scale.y);

		float flare_Red3D_ = distance(flare_Red3D_pos, vec2(texcoord.s*aspectRatio*flare_Red3D_scale.x, texcoord.t*flare_Red3D_scale.y));
			  flare_Red3D_ = 0.5 - flare_Red3D_;
			  flare_Red3D_ = clamp(flare_Red3D_*flare_Red3D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Red3D_ = sin(flare_Red3D_*1.57075);
			  flare_Red3D_ = pow(flare_Red3D_, 0.9f);
			  flare_Red3D_ *= flare_Red3D_pow;
			  flare_Red3_ = clamp(flare_Red3_ - flare_Red3D_, 0.0, 10.0);
			  flare_Red3_ *= sunmask;

		tempColor4.r += flare_Red3_*10.0f*flaremultR * (tempColor2.r / 16);
		tempColor4.g += flare_Red3_*0.0f*flaremultG * (tempColor2.r / 16);
		tempColor4.b += flare_Red3_*0.0f*flaremultB * (tempColor2.r / 16);

//--------------------------------------------------------------------------------------

//-------------------Orange3--------------------------------------------------------------------------------------

		 vec2 flare_Orange3_scale = vec2(0.86f*flarescale4, 0.86f*flarescale4);
		float flare_Orange3_pow = 4.25f;
		float flare_Orange3_fill = 10.0f;
		float flare_Orange3_offset = -2.0f;
		 vec2 flare_Orange3_pos = vec2(  ((1.0 - lPos.x)*(flare_Orange3_offset + 1.0) - (flare_Orange3_offset*0.5))  *aspectRatio*flare_Orange3_scale.x,  ((1.0 - lPos.y)*(flare_Orange3_offset + 1.0) - (flare_Orange3_offset*0.5))  *flare_Orange3_scale.y);

		float flare_Orange3_ = distance(flare_Orange3_pos, vec2(texcoord.s*aspectRatio*flare_Orange3_scale.x, texcoord.t*flare_Orange3_scale.y));
			  flare_Orange3_ = 0.5 - flare_Orange3_;
			  flare_Orange3_ = clamp(flare_Orange3_*flare_Orange3_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Orange3_ = sin(flare_Orange3_*1.57075);
			  flare_Orange3_ = pow(flare_Orange3_, 1.1f);
			flare_Orange3_ *= flare_Orange3_pow;

	//subtract
		 vec2 flare_Orange3D_scale = vec2(0.5446f*flarescale4, 0.5446f*flarescale4);
		float flare_Orange3D_pow = 8.0f;
		float flare_Orange3D_fill = 1.4f;
		float flare_Orange3D_offset = -1.8f;
		 vec2 flare_Orange3D_pos = vec2(  ((1.0 - lPos.x)*(flare_Orange3D_offset + 1.0) - (flare_Orange3D_offset*0.5))  *aspectRatio*flare_Orange3D_scale.x,  ((1.0 - lPos.y)*(flare_Orange3D_offset + 1.0) - (flare_Orange3D_offset*0.5))  *flare_Orange3D_scale.y);

		float flare_Orange3D_ = distance(flare_Orange3D_pos, vec2(texcoord.s*aspectRatio*flare_Orange3D_scale.x, texcoord.t*flare_Orange3D_scale.y));
			  flare_Orange3D_ = 0.5 - flare_Orange3D_;
			  flare_Orange3D_ = clamp(flare_Orange3D_*flare_Orange3D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Orange3D_ = sin(flare_Orange3D_*1.57075);
			  flare_Orange3D_ = pow(flare_Orange3D_, 0.9f);
			  flare_Orange3D_ *= flare_Orange3D_pow;
			  flare_Orange3_ = clamp(flare_Orange3_ - flare_Orange3D_, 0.0, 10.0);
			  flare_Orange3_ *= sunmask;

		tempColor4.r += flare_Orange3_*10.0f*flaremultR * (tempColor2.r / 16);
		tempColor4.g += flare_Orange3_*5.0f*flaremultG * (tempColor2.r / 16);
		tempColor4.b += flare_Orange3_*0.0f*flaremultB * (tempColor2.r / 16);

//--------------------------------------------------------------------------------------

//-------------------Green3--------------------------------------------------------------------------------------

		 vec2 flare_Green3_scale = vec2(0.82f*flarescale4, 0.82f*flarescale4);
		float flare_Green3_pow = 4.25f;
		float flare_Green3_fill = 10.0f;
		float flare_Green3_offset = -2.0f;
		 vec2 flare_Green3_pos = vec2(  ((1.0 - lPos.x)*(flare_Green3_offset + 1.0) - (flare_Green3_offset*0.5))  *aspectRatio*flare_Green3_scale.x,  ((1.0 - lPos.y)*(flare_Green3_offset + 1.0) - (flare_Green3_offset*0.5))  *flare_Green3_scale.y);

		float flare_Green3_ = distance(flare_Green3_pos, vec2(texcoord.s*aspectRatio*flare_Green3_scale.x, texcoord.t*flare_Green3_scale.y));
			  flare_Green3_ = 0.5 - flare_Green3_;
			  flare_Green3_ = clamp(flare_Green3_*flare_Green3_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Green3_ = sin(flare_Green3_*1.57075);
			  flare_Green3_ = pow(flare_Green3_, 1.1f);
			  flare_Green3_ *= flare_Green3_pow;

	//subtract
		 vec2 flare_Green3D_scale = vec2(0.5193f*flarescale4, 0.5193f*flarescale4);
		float flare_Green3D_pow = 8.0f;
		float flare_Green3D_fill = 1.4f;
		float flare_Green3D_offset = -1.8f;
		 vec2 flare_Green3D_pos = vec2(  ((1.0 - lPos.x)*(flare_Green3D_offset + 1.0) - (flare_Green3D_offset*0.5))  *aspectRatio*flare_Green3D_scale.x,  ((1.0 - lPos.y)*(flare_Green3D_offset + 1.0) - (flare_Green3D_offset*0.5))  *flare_Green3D_scale.y);

		float flare_Green3D_ = distance(flare_Green3D_pos, vec2(texcoord.s*aspectRatio*flare_Green3D_scale.x, texcoord.t*flare_Green3D_scale.y));
			  flare_Green3D_ = 0.5 - flare_Green3D_;
			  flare_Green3D_ = clamp(flare_Green3D_*flare_Green3D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Green3D_ = sin(flare_Green3D_*1.57075);
			  flare_Green3D_ = pow(flare_Green3D_, 0.9f);
			  flare_Green3D_ *= flare_Green3D_pow;
			  flare_Green3_ = clamp(flare_Green3_ - flare_Green3D_, 0.0, 10.0);
			  flare_Green3_ *= sunmask;

		tempColor4.r += flare_Green3_*0.0f*flaremultR * (tempColor2.r / 2);
		tempColor4.g += flare_Green3_*1.0f*flaremultG * (tempColor2.r / 2);
		tempColor4.b += flare_Green3_*0.0f*flaremultB * (tempColor2.r / 2);

//--------------------------------------------------------------------------------------

//-------------------Blue3--------------------------------------------------------------------------------------

		 vec2 flare_Blue3_scale = vec2(0.78f*flarescale4, 0.78f*flarescale4);
		float flare_Blue3_pow = 4.25f;
		float flare_Blue3_fill = 10.0f;
		float flare_Blue3_offset = -2.0f;
		 vec2 flare_Blue3_pos = vec2(  ((1.0 - lPos.x)*(flare_Blue3_offset + 1.0) - (flare_Blue3_offset*0.5))  *aspectRatio*flare_Blue3_scale.x,  ((1.0 - lPos.y)*(flare_Blue3_offset + 1.0) - (flare_Blue3_offset*0.5))  *flare_Blue3_scale.y);

		float flare_Blue3_ = distance(flare_Blue3_pos, vec2(texcoord.s*aspectRatio*flare_Blue3_scale.x, texcoord.t*flare_Blue3_scale.y));
			  flare_Blue3_ = 0.5 - flare_Blue3_;
			  flare_Blue3_ = clamp(flare_Blue3_*flare_Blue3_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Blue3_ = sin(flare_Blue3_*1.57075);
			  flare_Blue3_ = pow(flare_Blue3_, 1.1f);
			  flare_Blue3_ *= flare_Blue3_pow;

	//subtract
		 vec2 flare_Blue3D_scale = vec2(0.494f*flarescale4, 0.494f*flarescale4);
		float flare_Blue3D_pow = 8.0f;
		float flare_Blue3D_fill = 1.4f;
		float flare_Blue3D_offset = -1.8f;
		 vec2 flare_Blue3D_pos = vec2(  ((1.0 - lPos.x)*(flare_Blue3D_offset + 1.0) - (flare_Blue3D_offset*0.5))  *aspectRatio*flare_Blue3D_scale.x,  ((1.0 - lPos.y)*(flare_Blue3D_offset + 1.0) - (flare_Blue3D_offset*0.5))  *flare_Blue3D_scale.y);

		float flare_Blue3D_ = distance(flare_Blue3D_pos, vec2(texcoord.s*aspectRatio*flare_Blue3D_scale.x, texcoord.t*flare_Blue3D_scale.y));
			  flare_Blue3D_ = 0.5 - flare_Blue3D_;
			  flare_Blue3D_ = clamp(flare_Blue3D_*flare_Blue3D_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_Blue3D_ = sin(flare_Blue3D_*1.57075);
			  flare_Blue3D_ = pow(flare_Blue3D_, 0.9f);
			  flare_Blue3D_ *= flare_Blue3D_pow;
			  flare_Blue3_ = clamp(flare_Blue3_ - flare_Blue3D_, 0.0, 10.0);
			  flare_Blue3_ *= sunmask;

		tempColor4.r += flare_Blue3_*0.0f*flaremultR * (tempColor2.r / 2);
		tempColor4.g += flare_Blue3_*0.0f*flaremultG * (tempColor2.r / 2);
		tempColor4.b += flare_Blue3_*1.0f*flaremultB * (tempColor2.r / 2);

//--------------------------------------------------------------------------------------

		color += (tempColor3 / 4.0f);
		color += (tempColor4 / 1.0f);
		color += (tempColor * 1.0f);


//----------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------


	//Center white flare
		 vec2 flare1scale = vec2(1.7f*flarescale, 1.7f*flarescale);
		float flare1pow = 12.0f;
		 vec2 flare1pos = vec2(lPos.x*aspectRatio*flare1scale.x, lPos.y*flare1scale.y);

		float flare1 = distance(flare1pos, vec2(texcoord.s*aspectRatio*flare1scale.x, texcoord.t*flare1scale.y));
			  flare1 = 0.5 - flare1;
			  flare1 = clamp(flare1, 0.0, 10.0) * clamp(-sP.z, 0.0, 1.0);
			  flare1 *= sunmask;
			  flare1 = pow(flare1, 1.8f);
			  flare1 *= flare1pow;

		color.r += flare1*0.7f*flaremultR;
		color.g += flare1*0.4f*flaremultG;
		color.b += flare1*0.2f*flaremultB;


	//Center white flare
		 vec2 flare1Bscale = vec2(0.5f*flarescale, 0.5f*flarescale);
		float flare1Bpow = 6.0f;
		 vec2 flare1Bpos = vec2(lPos.x*aspectRatio*flare1Bscale.x, lPos.y*flare1Bscale.y);

		float flare1B = distance(flare1Bpos, vec2(texcoord.s*aspectRatio*flare1Bscale.x, texcoord.t*flare1Bscale.y));
			  flare1B = 0.5 - flare1B;
			  flare1B = clamp(flare1B, 0.0, 10.0) * clamp(-sP.z, 0.0, 1.0);
			  flare1B *= sunmask;
			  flare1B = pow(flare1B, 1.8f);
			  flare1B *= flare1Bpow;

		color.r += flare1B*0.7f*flaremultR;
		color.g += flare1B*0.2f*flaremultG;
		color.b += flare1B*0.0f*flaremultB;


	//Wide red flare
		vec2 flare2pos = vec2(lPos.x*aspectRatio*0.2, lPos.y);

		float flare2 = distance(flare2pos, vec2(texcoord.s*aspectRatio*0.2, texcoord.t));
			  flare2 = 0.3 - flare2;
			  flare2 = clamp(flare2, 0.0, 10.0) * clamp(-sP.z, 0.0, 1.0);
			  flare2 *= sunmask;
			  flare2 = pow(flare2, 1.8f);

		color.r += flare2*1.8f*flaremultR;
		color.g += flare2*0.6f*flaremultG;
		color.b += flare2*0.0f*flaremultB;


	//Wide red flare
		vec2 flare2posB = vec2(lPos.x*aspectRatio*0.2, lPos.y*4.0);

		float flare2B = distance(flare2posB, vec2(texcoord.s*aspectRatio*0.2, texcoord.t*4.0));
			  flare2B = 0.3 - flare2B;
			  flare2B = clamp(flare2B, 0.0, 10.0) * clamp(-sP.z, 0.0, 1.0);
			  flare2B *= sunmask;
			  flare2B = pow(flare2B, 1.8f);

		color.r += flare2B*1.2f*flaremultR;
		color.g += flare2B*0.5f*flaremultG;
		color.b += flare2B*0.0f*flaremultB;


	//Far blue flare MAIN
		 vec2 flare3scale = vec2(2.0f*flarescale, 2.0f*flarescale);
		float flare3pow = 0.7f;
		float flare3fill = 10.0f;
		float flare3offset = -0.5f;
		 vec2 flare3pos = vec2(  ((1.0 - lPos.x)*(flare3offset + 1.0) - (flare3offset*0.5))  *aspectRatio*flare3scale.x,  ((1.0 - lPos.y)*(flare3offset + 1.0) - (flare3offset*0.5))  *flare3scale.y);

		float flare3 = distance(flare3pos, vec2(texcoord.s*aspectRatio*flare3scale.x, texcoord.t*flare3scale.y));
			  flare3 = 0.5 - flare3;
			  flare3 = clamp(flare3*flare3fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare3 = sin(flare3*1.57075);
			  flare3 *= sunmask;
			  flare3 = pow(flare3, 1.1f);
			  flare3 *= flare3pow;

	//subtract from blue flare
		 vec2 flare3Bscale = vec2(1.4f*flarescale, 1.4f*flarescale);
		float flare3Bpow = 1.0f;
		float flare3Bfill = 2.0f;
		float flare3Boffset = -0.65f;
		 vec2 flare3Bpos = vec2(  ((1.0 - lPos.x)*(flare3Boffset + 1.0) - (flare3Boffset*0.5))  *aspectRatio*flare3Bscale.x,  ((1.0 - lPos.y)*(flare3Boffset + 1.0) - (flare3Boffset*0.5))  *flare3Bscale.y);


		float flare3B = distance(flare3Bpos, vec2(texcoord.s*aspectRatio*flare3Bscale.x, texcoord.t*flare3Bscale.y));
			  flare3B = 0.5 - flare3B;
			  flare3B = clamp(flare3B*flare3Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare3B = sin(flare3B*1.57075);
			  flare3B *= sunmask;
			  flare3B = pow(flare3B, 0.9f);
			  flare3B *= flare3Bpow;

			flare3 = clamp(flare3 - flare3B, 0.0, 10.0);

		color.r += flare3*0.5f*flaremultR;
		color.g += flare3*0.3f*flaremultG;
		color.b += flare3*0.0f*flaremultB;


	//Far blue flare MAIN 2
		 vec2 flare3Cscale = vec2(3.2f*flarescale, 3.2f*flarescale);
		float flare3Cpow = 1.4f;
		float flare3Cfill = 10.0f;
		float flare3Coffset = -0.0f;
		 vec2 flare3Cpos = vec2(  ((1.0 - lPos.x)*(flare3Coffset + 1.0) - (flare3Coffset*0.5))  *aspectRatio*flare3Cscale.x,  ((1.0 - lPos.y)*(flare3Coffset + 1.0) - (flare3Coffset*0.5))  *flare3Cscale.y);

		float flare3C = distance(flare3Cpos, vec2(texcoord.s*aspectRatio*flare3Cscale.x, texcoord.t*flare3Cscale.y));
			  flare3C = 0.5 - flare3C;
			  flare3C = clamp(flare3C*flare3Cfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare3C = sin(flare3C*1.57075);
			  flare3C = pow(flare3C, 1.1f);
			  flare3C *= flare3Cpow;

	//subtract from blue flare
		 vec2 flare3Dscale = vec2(2.1f*flarescale, 2.1f*flarescale);
		float flare3Dpow = 2.7f;
		float flare3Dfill = 1.4f;
		float flare3Doffset = -0.05f;
		 vec2 flare3Dpos = vec2(  ((1.0 - lPos.x)*(flare3Doffset + 1.0) - (flare3Doffset*0.5))  *aspectRatio*flare3Dscale.x,  ((1.0 - lPos.y)*(flare3Doffset + 1.0) - (flare3Doffset*0.5))  *flare3Dscale.y);

		float flare3D = distance(flare3Dpos, vec2(texcoord.s*aspectRatio*flare3Dscale.x, texcoord.t*flare3Dscale.y));
			  flare3D = 0.5 - flare3D;
			  flare3D = clamp(flare3D*flare3Dfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare3D = sin(flare3D*1.57075);
			  flare3D = pow(flare3D, 0.9f);
			  flare3D *= flare3Dpow;
			  flare3C = clamp(flare3C - flare3D, 0.0, 10.0);
			  flare3C *= sunmask;

		color.r += flare3C*0.5f*flaremultR;
		color.g += flare3C*0.3f*flaremultG;
		color.b += flare3C*0.0f*flaremultB;


	//far small pink flare
		 vec2 flare4scale = vec2(4.5f*flarescale, 4.5f*flarescale);
		float flare4pow = 0.3f;
		float flare4fill = 3.0f;
		float flare4offset = -0.1f;
		 vec2 flare4pos = vec2(  ((1.0 - lPos.x)*(flare4offset + 1.0) - (flare4offset*0.5))  *aspectRatio*flare4scale.x,  ((1.0 - lPos.y)*(flare4offset + 1.0) - (flare4offset*0.5))  *flare4scale.y);

		float flare4 = distance(flare4pos, vec2(texcoord.s*aspectRatio*flare4scale.x, texcoord.t*flare4scale.y));
			  flare4 = 0.5 - flare4;
			  flare4 = clamp(flare4*flare4fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare4 = sin(flare4*1.57075);
			  flare4 *= sunmask;
			  flare4 = pow(flare4, 1.1f);
			  flare4 *= flare4pow;

		color.r += flare4*0.6f*flaremultR;
		color.g += flare4*0.0f*flaremultG;
		color.b += flare4*0.8f*flaremultB;


	//far small pink flare2
		 vec2 flare4Bscale = vec2(7.5f*flarescale, 7.5f*flarescale);
		float flare4Bpow = 0.4f;
		float flare4Bfill = 2.0f;
		float flare4Boffset = 0.0f;
		 vec2 flare4Bpos = vec2(  ((1.0 - lPos.x)*(flare4Boffset + 1.0) - (flare4Boffset*0.5))  *aspectRatio*flare4Bscale.x,  ((1.0 - lPos.y)*(flare4Boffset + 1.0) - (flare4Boffset*0.5))  *flare4Bscale.y);

		float flare4B = distance(flare4Bpos, vec2(texcoord.s*aspectRatio*flare4Bscale.x, texcoord.t*flare4Bscale.y));
			  flare4B = 0.5 - flare4B;
			  flare4B = clamp(flare4B*flare4Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare4B = sin(flare4B*1.57075);
			  flare4B *= sunmask;
			  flare4B = pow(flare4B, 1.1f);
			  flare4B *= flare4Bpow;

		color.r += flare4B*0.4f*flaremultR;
		color.g += flare4B*0.0f*flaremultG;
		color.b += flare4B*0.8f*flaremultB;


	//far small pink flare3
		 vec2 flare4Cscale = vec2(37.5f*flarescale, 37.5f*flarescale);
		float flare4Cpow = 2.0f;
		float flare4Cfill = 2.0f;
		float flare4Coffset = -0.3f;
		 vec2 flare4Cpos = vec2(  ((1.0 - lPos.x)*(flare4Coffset + 1.0) - (flare4Coffset*0.5))  *aspectRatio*flare4Cscale.x,  ((1.0 - lPos.y)*(flare4Coffset + 1.0) - (flare4Coffset*0.5))  *flare4Cscale.y);

		float flare4C = distance(flare4Cpos, vec2(texcoord.s*aspectRatio*flare4Cscale.x, texcoord.t*flare4Cscale.y));
			  flare4C = 0.5 - flare4C;
			  flare4C = clamp(flare4C*flare4Cfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare4C = sin(flare4C*1.57075);
			  flare4C *= sunmask;
			  flare4C = pow(flare4C, 1.1f);
			  flare4C *= flare4Cpow;

		color.r += flare4C*0.6f*flaremultR;
		color.g += flare4C*0.3f*flaremultG;
		color.b += flare4C*0.1f*flaremultB;


	//far small pink flare4
		 vec2 flare4Dscale = vec2(67.5f*flarescale, 67.5f*flarescale);
		float flare4Dpow = 1.0f;
		float flare4Dfill = 2.0f;
		float flare4Doffset = -0.35f;
		 vec2 flare4Dpos = vec2(  ((1.0 - lPos.x)*(flare4Doffset + 1.0) - (flare4Doffset*0.5))  *aspectRatio*flare4Dscale.x,  ((1.0 - lPos.y)*(flare4Doffset + 1.0) - (flare4Doffset*0.5))  *flare4Dscale.y);

		float flare4D = distance(flare4Dpos, vec2(texcoord.s*aspectRatio*flare4Dscale.x, texcoord.t*flare4Dscale.y));
			  flare4D = 0.5 - flare4D;
			  flare4D = clamp(flare4D*flare4Dfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare4D = sin(flare4D*1.57075);
			  flare4D *= sunmask;
			  flare4D = pow(flare4D, 1.1f);
			  flare4D *= flare4Dpow;

		color.r += flare4D*0.2f*flaremultR;
		color.g += flare4D*0.2f*flaremultG;
		color.b += flare4D*0.2f*flaremultB;


	//far small pink flare5
		 vec2 flare4Escale = vec2(60.5f*flarescale, 60.5f*flarescale);
		float flare4Epow = 1.0f;
		float flare4Efill = 3.0f;
		float flare4Eoffset = -0.3393f;
		 vec2 flare4Epos = vec2(  ((1.0 - lPos.x)*(flare4Eoffset + 1.0) - (flare4Eoffset*0.5))  *aspectRatio*flare4Escale.x,  ((1.0 - lPos.y)*(flare4Eoffset + 1.0) - (flare4Eoffset*0.5))  *flare4Escale.y);

		float flare4E = distance(flare4Epos, vec2(texcoord.s*aspectRatio*flare4Escale.x, texcoord.t*flare4Escale.y));
			  flare4E = 0.5 - flare4E;
			  flare4E = clamp(flare4E*flare4Efill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare4E = sin(flare4E*1.57075);
			  flare4E *= sunmask;
			  flare4E = pow(flare4E, 1.1f);
			  flare4E *= flare4Epow;

		color.r += flare4E*0.2f*flaremultR;
		color.g += flare4E*0.2f*flaremultG;
		color.b += flare4E*0.0f*flaremultB;



		 vec2 flare5scale = vec2(3.2f*flarescale , 3.2f*flarescale );
		float flare5pow = 13.4f;
		float flare5fill = 1.0f;
		float flare5offset = -2.0f;
		 vec2 flare5pos = vec2(  ((1.0 - lPos.x)*(flare5offset + 1.0) - (flare5offset*0.5))  *aspectRatio*flare5scale.x,  ((1.0 - lPos.y)*(flare5offset + 1.0) - (flare5offset*0.5))  *flare5scale.y);

		float flare5 = distance(flare5pos, vec2(texcoord.s*aspectRatio*flare5scale.x, texcoord.t*flare5scale.y));
			  flare5 = 0.5 - flare5;
			  flare5 = clamp(flare5*flare5fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare5 *= sunmask;
			  flare5 = pow(flare5, 1.9f);
			  flare5 *= flare5pow;

		color.r += flare5*0.9f*flaremultR;
		color.g += flare5*0.4f*flaremultG;
		color.b += flare5*0.1f*flaremultB;



	//close ring flare red
		 vec2 flare6scale = vec2(1.2f*flarescale, 1.2f*flarescale);
		float flare6pow = 0.2f;
		float flare6fill = 5.0f;
		float flare6offset = -1.9f;
		 vec2 flare6pos = vec2(  ((1.0 - lPos.x)*(flare6offset + 1.0) - (flare6offset*0.5))  *aspectRatio*flare6scale.x,  ((1.0 - lPos.y)*(flare6offset + 1.0) - (flare6offset*0.5))  *flare6scale.y);

		float flare6 = distance(flare6pos, vec2(texcoord.s*aspectRatio*flare6scale.x, texcoord.t*flare6scale.y));
			  flare6 = 0.5 - flare6;
			  flare6 = clamp(flare6*flare6fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare6 = pow(flare6, 1.6f);
			  flare6 = sin(flare6*3.1415);
			  flare6 *= sunmask;

			  flare6 *= flare6pow;

		color.r += flare6*1.0f*flaremultR * (tempColor2.r);
		color.g += flare6*0.0f*flaremultG * (tempColor2.r);
		color.b += flare6*0.0f*flaremultB * (tempColor2.r);


	//close ring flare green
		 vec2 flare6Bscale = vec2(1.1f*flarescale, 1.1f*flarescale);
		float flare6Bpow = 0.2f;
		float flare6Bfill = 5.0f;
		float flare6Boffset = -1.9f;
		 vec2 flare6Bpos = vec2(  ((1.0 - lPos.x)*(flare6Boffset + 1.0) - (flare6Boffset*0.5))  *aspectRatio*flare6Bscale.x,  ((1.0 - lPos.y)*(flare6Boffset + 1.0) - (flare6Boffset*0.5))  *flare6Bscale.y);

		float flare6B = distance(flare6Bpos, vec2(texcoord.s*aspectRatio*flare6Bscale.x, texcoord.t*flare6Bscale.y));
			  flare6B = 0.5 - flare6B;
			  flare6B = clamp(flare6B*flare6Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare6B = pow(flare6B, 1.6f);
			  flare6B = sin(flare6B*3.1415);
			  flare6B *= sunmask;
			  flare6B *= flare6Bpow;

		color.r += flare6B*1.0f*flaremultR * (tempColor2.r);
		color.g += flare6B*0.4f*flaremultG * (tempColor2.r);
		color.b += flare6B*0.0f*flaremultB * (tempColor2.r);


	//close ring flare blue
		 vec2 flare6Cscale = vec2(0.9f*flarescale, 0.9f*flarescale);
		float flare6Cpow = 0.3f;
		float flare6Cfill = 5.0f;
		float flare6Coffset = -1.9f;
		 vec2 flare6Cpos = vec2(  ((1.0 - lPos.x)*(flare6Coffset + 1.0) - (flare6Coffset*0.5))  *aspectRatio*flare6Cscale.x,  ((1.0 - lPos.y)*(flare6Coffset + 1.0) - (flare6Coffset*0.5))  *flare6Cscale.y);

		float flare6C = distance(flare6Cpos, vec2(texcoord.s*aspectRatio*flare6Cscale.x, texcoord.t*flare6Cscale.y));
			  flare6C = 0.5 - flare6C;
			  flare6C = clamp(flare6C*flare6Cfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare6C = pow(flare6C, 1.8f);
			  flare6C = sin(flare6C*3.1415);
			  flare6C *= sunmask;
			  flare6C *= flare6Cpow;

		color.r += flare6C*0.5f*flaremultR * (tempColor2.r);
		color.g += flare6C*0.3f*flaremultG * (tempColor2.r);
		color.b += flare6C*0.0f*flaremultB * (tempColor2.r);


//----------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------


	//Edge blue strip 1
		 vec2 flareEscale = vec2(0.2f*flarescale, 5.0f*flarescale);
		float flareEpow = 1.0f;
		float flareEfill = 2.0f;
		vec2 flareEoffset = vec2(0.0f);
		 vec2 flareEpos = vec2(lPos.x*aspectRatio*flareEscale.x, lPos.y*flareEscale.y);

		float flareE = distance(flareEpos, vec2(texcoord.s*aspectRatio*flareEscale.x, texcoord.t*flareEscale.y));
			  flareE = 0.5 - flareE;
			  flareE = clamp(flareE*flareEfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flareE *= sunmask;
			  flareE = pow(flareE, 1.4f);
			  flareE *= flareEpow;

		color.r += flareE*1.0f*flaremultR;
		color.g += flareE*0.6f*flaremultG;
		color.b += flareE*0.0f*flaremultB;


	//Center orange strip 1
		 vec2 flare_strip1_scale = vec2(0.5f*flarescale, 40.0f*flarescale);
		float flare_strip1_pow = 0.25f;
		float flare_strip1_fill = 12.0f;
		float flare_strip1_offset = 0.0f;
		 vec2 flare_strip1_pos = vec2(lPos.x*aspectRatio*flare_strip1_scale.x, lPos.y*flare_strip1_scale.y);

		float flare_strip1_ = distance(flare_strip1_pos, vec2(texcoord.s*aspectRatio*flare_strip1_scale.x, texcoord.t*flare_strip1_scale.y));
			  flare_strip1_ = 0.5 - flare_strip1_;
			  flare_strip1_ = clamp(flare_strip1_*flare_strip1_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_strip1_ *= sunmask;
			  flare_strip1_ = pow(flare_strip1_, 1.4f);
			  flare_strip1_ *= flare_strip1_pow;

		color.r += flare_strip1_*0.5f*flaremultR;
		color.g += flare_strip1_*0.3f*flaremultG;
		color.b += flare_strip1_*0.0f*flaremultB;


	//Center orange strip 3
		 vec2 flare_strip3_scale = vec2(0.4f*flarescale, 35.0f*flarescale);
		float flare_strip3_pow = 0.5f;
		float flare_strip3_fill = 10.0f;
		float flare_strip3_offset = 0.0f;
		 vec2 flare_strip3_pos = vec2(lPos.x*aspectRatio*flare_strip3_scale.x, lPos.y*flare_strip3_scale.y);

		float flare_strip3_ = distance(flare_strip3_pos, vec2(texcoord.s*aspectRatio*flare_strip3_scale.x, texcoord.t*flare_strip3_scale.y));
			  flare_strip3_ = 0.5 - flare_strip3_;
			  flare_strip3_ = clamp(flare_strip3_*flare_strip3_fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_strip3_ *= sunmask;
			  flare_strip3_ = pow(flare_strip3_, 1.4f);
			  flare_strip3_ *= flare_strip3_pow;

		color.r += flare_strip3_*0.5f*flaremultR;
		color.g += flare_strip3_*0.3f*flaremultG;
		color.b += flare_strip3_*0.0f*flaremultB;


	//mid orange sweep
		 vec2 flare_extra3scale = vec2(32.0f*flarescale, 32.0f*flarescale);
		float flare_extra3pow = 2.5f;
		float flare_extra3fill = 1.1f;
		float flare_extra3offset = -1.3f;
		 vec2 flare_extra3pos = vec2(  ((1.0 - lPos.x)*(flare_extra3offset + 1.0) - (flare_extra3offset*0.5))  *aspectRatio*flare_extra3scale.x,  ((1.0 - lPos.y)*(flare_extra3offset + 1.0) - (flare_extra3offset*0.5))  *flare_extra3scale.y);


		float flare_extra3 = distance(flare_extra3pos, vec2(texcoord.s*aspectRatio*flare_extra3scale.x, texcoord.t*flare_extra3scale.y));
			  flare_extra3 = 0.5 - flare_extra3;
			  flare_extra3 = clamp(flare_extra3*flare_extra3fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_extra3 = sin(flare_extra3*1.57075);
			  flare_extra3 *= sunmask;
			  flare_extra3 = pow(flare_extra3, 1.1f);
			  flare_extra3 *= flare_extra3pow;

	//subtract
		 vec2 flare_extra3Bscale = vec2(5.1f*flarescale, 5.1f*flarescale);
		float flare_extra3Bpow = 1.5f;
		float flare_extra3Bfill = 1.0f;
		float flare_extra3Boffset = -0.77f;
		 vec2 flare_extra3Bpos = vec2(  ((1.0 - lPos.x)*(flare_extra3Boffset + 1.0) - (flare_extra3Boffset*0.5))  *aspectRatio*flare_extra3Bscale.x,  ((1.0 - lPos.y)*(flare_extra3Boffset + 1.0) - (flare_extra3Boffset*0.5))  *flare_extra3Bscale.y);

		float flare_extra3B = distance(flare_extra3Bpos, vec2(texcoord.s*aspectRatio*flare_extra3Bscale.x, texcoord.t*flare_extra3Bscale.y));
			  flare_extra3B = 0.5 - flare_extra3B;
			  flare_extra3B = clamp(flare_extra3B*flare_extra3Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_extra3B = sin(flare_extra3B*1.57075);
			  flare_extra3B *= sunmask;
			  flare_extra3B = pow(flare_extra3B, 0.9f);
			  flare_extra3B *= flare_extra3Bpow;

			  flare_extra3 = clamp(flare_extra3 - flare_extra3B, 0.0, 10.0);

		color.r += flare_extra3*0.5f*flaremultR;
		color.g += flare_extra3*0.4f*flaremultG;
		color.b += flare_extra3*0.1f*flaremultB;



	//mid orange sweep
		 vec2 flare_extra4scale = vec2(35.0f*flarescale, 35.0f*flarescale);
		float flare_extra4pow = 1.0f;
		float flare_extra4fill = 1.1f;
		float flare_extra4offset = -1.2f;
		 vec2 flare_extra4pos = vec2(  ((1.0 - lPos.x)*(flare_extra4offset + 1.0) - (flare_extra4offset*0.5))  *aspectRatio*flare_extra4scale.x,  ((1.0 - lPos.y)*(flare_extra4offset + 1.0) - (flare_extra4offset*0.5))  *flare_extra4scale.y);

		float flare_extra4 = distance(flare_extra4pos, vec2(texcoord.s*aspectRatio*flare_extra4scale.x, texcoord.t*flare_extra4scale.y));
			  flare_extra4 = 0.5 - flare_extra4;
			  flare_extra4 = clamp(flare_extra4*flare_extra4fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_extra4 = sin(flare_extra4*1.57075);
			  flare_extra4 *= sunmask;
			  flare_extra4 = pow(flare_extra4, 1.1f);
			  flare_extra4 *= flare_extra4pow;

	//subtract
		 vec2 flare_extra4Bscale = vec2(5.1f*flarescale, 5.1f*flarescale);
		float flare_extra4Bpow = 1.5f;
		float flare_extra4Bfill = 1.0f;
		float flare_extra4Boffset = -0.77f;
		 vec2 flare_extra4Bpos = vec2(  ((1.0 - lPos.x)*(flare_extra4Boffset + 1.0) - (flare_extra4Boffset*0.5))  *aspectRatio*flare_extra4Bscale.x,  ((1.0 - lPos.y)*(flare_extra4Boffset + 1.0) - (flare_extra4Boffset*0.5))  *flare_extra4Bscale.y);

		float flare_extra4B = distance(flare_extra4Bpos, vec2(texcoord.s*aspectRatio*flare_extra4Bscale.x, texcoord.t*flare_extra4Bscale.y));
			  flare_extra4B = 0.5 - flare_extra4B;
			  flare_extra4B = clamp(flare_extra4B*flare_extra4Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_extra4B = sin(flare_extra4B*1.57075);
			  flare_extra4B *= sunmask;
			  flare_extra4B = pow(flare_extra4B, 0.9f);
			  flare_extra4B *= flare_extra4Bpow;

			  flare_extra4 = clamp(flare_extra4 - flare_extra4B, 0.0, 10.0);

		color.r += flare_extra4*0.6f*flaremultR;
		color.g += flare_extra4*0.4f*flaremultG;
		color.b += flare_extra4*0.1f*flaremultB;


	//mid orange sweep
		 vec2 flare_extra5scale = vec2(25.0f*flarescale, 25.0f*flarescale);
		float flare_extra5pow = 4.0f;
		float flare_extra5fill = 1.1f;
		float flare_extra5offset = -0.9f;
		 vec2 flare_extra5pos = vec2(  ((1.0 - lPos.x)*(flare_extra5offset + 1.0) - (flare_extra5offset*0.5))  *aspectRatio*flare_extra5scale.x,  ((1.0 - lPos.y)*(flare_extra5offset + 1.0) - (flare_extra5offset*0.5))  *flare_extra5scale.y);

		float flare_extra5 = distance(flare_extra5pos, vec2(texcoord.s*aspectRatio*flare_extra5scale.x, texcoord.t*flare_extra5scale.y));
			  flare_extra5 = 0.5 - flare_extra5;
			  flare_extra5 = clamp(flare_extra5*flare_extra5fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_extra5 = sin(flare_extra5*1.57075);
			  flare_extra5 *= sunmask;
			  flare_extra5 = pow(flare_extra5, 1.1f);
			  flare_extra5 *= flare_extra5pow;

	//subtract
		 vec2 flare_extra5Bscale = vec2(5.1f*flarescale, 5.1f*flarescale);
		float flare_extra5Bpow = 1.5f;
		float flare_extra5Bfill = 1.0f;
		float flare_extra5Boffset = -0.77f;
		 vec2 flare_extra5Bpos = vec2(  ((1.0 - lPos.x)*(flare_extra5Boffset + 1.0) - (flare_extra5Boffset*0.5))  *aspectRatio*flare_extra5Bscale.x,  ((1.0 - lPos.y)*(flare_extra5Boffset + 1.0) - (flare_extra5Boffset*0.5))  *flare_extra5Bscale.y);


		float flare_extra5B = distance(flare_extra5Bpos, vec2(texcoord.s*aspectRatio*flare_extra5Bscale.x, texcoord.t*flare_extra5Bscale.y));
			  flare_extra5B = 0.5 - flare_extra5B;
			  flare_extra5B = clamp(flare_extra5B*flare_extra5Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare_extra5B = sin(flare_extra5B*1.57075);
			  flare_extra5B *= sunmask;
			  flare_extra5B = pow(flare_extra5B, 0.9f);
			  flare_extra5B *= flare_extra5Bpow;

			  flare_extra5 = clamp(flare_extra5 - flare_extra5B, 0.0, 10.0);

		color.r += flare_extra5*0.5f*flaremultR;
		color.g += flare_extra5*0.3f*flaremultG;
		color.b += flare_extra5*0.0f*flaremultB;


//----------------------------------------------------------------------------------------------------------------------------------------------------------------


	//far red glow
		 vec2 flare7Bscale = vec2(0.2f*flarescale, 0.2f*flarescale);
		float flare7Bpow = 0.1f;
		float flare7Bfill = 2.0f;
		float flare7Boffset = 2.9f;
		 vec2 flare7Bpos = vec2(  ((1.0 - lPos.x)*(flare7Boffset + 1.0) - (flare7Boffset*0.5))  *aspectRatio*flare7Bscale.x,  ((1.0 - lPos.y)*(flare7Boffset + 1.0) - (flare7Boffset*0.5))  *flare7Bscale.y);

		float flare7B = distance(flare7Bpos, vec2(texcoord.s*aspectRatio*flare7Bscale.x, texcoord.t*flare7Bscale.y));
			  flare7B = 0.5 - flare7B;
			  flare7B = clamp(flare7B*flare7Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare7B = pow(flare7B, 1.9f);
			  flare7B = sin(flare7B*3.1415*0.5);
			  flare7B *= sunmask;
			  flare7B *= flare7Bpow;

		color.r += flare7B*1.0f*flaremultR;
		color.g += flare7B*0.0f*flaremultG;
		color.b += flare7B*0.0f*flaremultB;


	//Edge blue strip 1
		 vec2 flare9scale = vec2(0.2f*flarescale, 5.5f*flarescale);
		float flare9pow = 1.9f;
		float flare9fill = 2.0f;
		vec2 flare9offset = vec2(1.0f, 0.0f);
		 vec2 flare9pos = vec2(  ((1.0 - lPos.x)*(flare9offset.x + 1.0) - (flare9offset.x*0.5))  *aspectRatio*flare9scale.x,  ((1.0 - lPos.y)*(flare9offset.y + 1.0) - (flare9offset.y*0.5))  *flare9scale.y);

		float flare9 = distance(flare9pos, vec2(texcoord.s*aspectRatio*flare9scale.x, texcoord.t*flare9scale.y));
			  flare9 = 0.5 - flare9;
			  flare9 = clamp(flare9*flare9fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare9 *= sunmask;
			  flare9 = pow(flare9, 1.4f);
			  flare9 *= flare9pow;
			  flare9 *= edgemaskx;

		color.r += flare9*0.2f*flaremultR;
		color.g += flare9*0.4f*flaremultG;
		color.b += flare9*0.9f*flaremultB;



//SMALL SWEEPS----------------------------------------------------------------------------------------------------------------------------------------------------


	//mid orange sweep
		 vec2 flare10scale = vec2(6.0f*flarescale, 6.0f*flarescale);
		float flare10pow = 1.9f;
		float flare10fill = 1.1f;
		float flare10offset = -0.7f;
		 vec2 flare10pos = vec2(  ((1.0 - lPos.x)*(flare10offset + 1.0) - (flare10offset*0.5))  *aspectRatio*flare10scale.x,  ((1.0 - lPos.y)*(flare10offset + 1.0) - (flare10offset*0.5))  *flare10scale.y);

		float flare10 = distance(flare10pos, vec2(texcoord.s*aspectRatio*flare10scale.x, texcoord.t*flare10scale.y));
			  flare10 = 0.5 - flare10;
			  flare10 = clamp(flare10*flare10fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare10 = sin(flare10*1.57075);
			  flare10 *= sunmask;
			  flare10 = pow(flare10, 1.1f);
			  flare10 *= flare10pow;

	//subtract
		 vec2 flare10Bscale = vec2(5.1f*flarescale, 5.1f*flarescale);
		float flare10Bpow = 1.5f;
		float flare10Bfill = 1.0f;
		float flare10Boffset = -0.77f;
		 vec2 flare10Bpos = vec2(  ((1.0 - lPos.x)*(flare10Boffset + 1.0) - (flare10Boffset*0.5))  *aspectRatio*flare10Bscale.x,  ((1.0 - lPos.y)*(flare10Boffset + 1.0) - (flare10Boffset*0.5))  *flare10Bscale.y);

		float flare10B = distance(flare10Bpos, vec2(texcoord.s*aspectRatio*flare10Bscale.x, texcoord.t*flare10Bscale.y));
			  flare10B = 0.5 - flare10B;
			  flare10B = clamp(flare10B*flare10Bfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare10B = sin(flare10B*1.57075);
			  flare10B *= sunmask;
			  flare10B = pow(flare10B, 0.9f);
			  flare10B *= flare10Bpow;

			  flare10 = clamp(flare10 - flare10B, 0.0, 10.0);

		color.r += flare10*0.5f*flaremultR;
		color.g += flare10*0.3f*flaremultG;
		color.b += flare10*0.0f*flaremultB;


	//mid blue sweep
		 vec2 flare10Cscale = vec2(6.0f*flarescale, 6.0f*flarescale);
		float flare10Cpow = 1.9f;
		float flare10Cfill = 1.1f;
		float flare10Coffset = -0.6f;
		 vec2 flare10Cpos = vec2(  ((1.0 - lPos.x)*(flare10Coffset + 1.0) - (flare10Coffset*0.5))  *aspectRatio*flare10Cscale.x,  ((1.0 - lPos.y)*(flare10Coffset + 1.0) - (flare10Coffset*0.5))  *flare10Cscale.y);

		float flare10C = distance(flare10Cpos, vec2(texcoord.s*aspectRatio*flare10Cscale.x, texcoord.t*flare10Cscale.y));
			  flare10C = 0.5 - flare10C;
			  flare10C = clamp(flare10C*flare10Cfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare10C = sin(flare10C*1.57075);
			  flare10C *= sunmask;
			  flare10C = pow(flare10C, 1.1f);
			  flare10C *= flare10Cpow;

	//subtract
		 vec2 flare10Dscale = vec2(5.1f*flarescale, 5.1f*flarescale);
		float flare10Dpow = 1.5f;
		float flare10Dfill = 1.0f;
		float flare10Doffset = -0.67f;
		 vec2 flare10Dpos = vec2(  ((1.0 - lPos.x)*(flare10Doffset + 1.0) - (flare10Doffset*0.5))  *aspectRatio*flare10Dscale.x,  ((1.0 - lPos.y)*(flare10Doffset + 1.0) - (flare10Doffset*0.5))  *flare10Dscale.y);

		float flare10D = distance(flare10Dpos, vec2(texcoord.s*aspectRatio*flare10Dscale.x, texcoord.t*flare10Dscale.y));
			  flare10D = 0.5 - flare10D;
			  flare10D = clamp(flare10D*flare10Dfill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare10D = sin(flare10D*1.57075);
			  flare10D *= sunmask;
			  flare10D = pow(flare10D, 0.9f);
			  flare10D *= flare10Dpow;

			  flare10C = clamp(flare10C - flare10D, 0.0, 10.0);

		color.r += flare10C*0.5f*flaremultR;
		color.g += flare10C*0.3f*flaremultG;
		color.b += flare10C*0.0f*flaremultB;


//Pointy fuzzy glow dots------------------------------------------------------------------------------------------------------------------------------------------


//RedGlow1
		 vec2 flare11scale = vec2(1.5f*flarescale, 1.5f*flarescale);
		float flare11pow = 1.1f;
		float flare11fill = 2.0f;
		float flare11offset = -0.523f;
		 vec2 flare11pos = vec2(  ((1.0 - lPos.x)*(flare11offset + 1.0) - (flare11offset*0.5))  *aspectRatio*flare11scale.x,  ((1.0 - lPos.y)*(flare11offset + 1.0) - (flare11offset*0.5))  *flare11scale.y);

		float flare11 = distance(flare11pos, vec2(texcoord.s*aspectRatio*flare11scale.x, texcoord.t*flare11scale.y));
			  flare11 = 0.5 - flare11;
			  flare11 = clamp(flare11*flare11fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare11 = pow(flare11, 2.9f);
			  flare11 *= sunmask;
			  flare11 *= flare11pow;

		color.r += flare11*1.0f*flaremultR;
		color.g += flare11*0.2f*flaremultG;
		color.b += flare11*0.0f*flaremultB;


	//PurpleGlow2
		 vec2 flare12scale = vec2(2.5f*flarescale, 2.5f*flarescale);
		float flare12pow = 0.5f;
		float flare12fill = 2.0f;
		float flare12offset = -0.323f;
		 vec2 flare12pos = vec2(  ((1.0 - lPos.x)*(flare12offset + 1.0) - (flare12offset*0.5))  *aspectRatio*flare12scale.x,  ((1.0 - lPos.y)*(flare12offset + 1.0) - (flare12offset*0.5))  *flare12scale.y);

		float flare12 = distance(flare12pos, vec2(texcoord.s*aspectRatio*flare12scale.x, texcoord.t*flare12scale.y));
			  flare12 = 0.5 - flare12;
			  flare12 = clamp(flare12*flare12fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare12 = pow(flare12, 2.9f);
			  flare12 *= sunmask;
			  flare12 *= flare12pow;

		color.r += flare12*0.7f*flaremultR;
		color.g += flare12*0.3f*flaremultG;
		color.b += flare12*0.0f*flaremultB;


		//BlueGlow3
		 vec2 flare13scale = vec2(1.0f*flarescale, 1.0f*flarescale);
		float flare13pow = 1.5f;
		float flare13fill = 2.0f;
		float flare13offset = +0.138f;
		 vec2 flare13pos = vec2(  ((1.0 - lPos.x)*(flare13offset + 1.0) - (flare13offset*0.5))  *aspectRatio*flare13scale.x,  ((1.0 - lPos.y)*(flare13offset + 1.0) - (flare13offset*0.5))  *flare13scale.y);

		float flare13 = distance(flare13pos, vec2(texcoord.s*aspectRatio*flare13scale.x, texcoord.t*flare13scale.y));
			  flare13 = 0.5 - flare13;
			  flare13 = clamp(flare13*flare13fill, 0.0, 1.0) * clamp(-sP.z, 0.0, 1.0);
			  flare13 = pow(flare13, 2.9f);
			  flare13 *= sunmask;
			  flare13 *= flare13pow;

		color.r += flare13*0.5f*flaremultR;
		color.g += flare13*0.3f*flaremultG;
		color.b += flare13*0.0f*flaremultB;

		}
	}
}