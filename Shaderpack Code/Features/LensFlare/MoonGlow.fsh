void MoonGlow(inout vec3 color)
{
	vec4 tpos = vec4(moonPosition, 1.0) * gbufferProjection;
	tpos = vec4(tpos.xyz / tpos.w, 1.0);
	vec2 lPos = tpos.xy / tpos.z;
	lPos = (lPos + 1.0f) / 2.0f;
	vec2 checkcoord = lPos;

	if (checkcoord.x < 1.0f && checkcoord.x > 0.0f && checkcoord.y < 1.0f && checkcoord.y > 0.0f && timeNoon < 1.0)
	{
	float sunmask = 0.0f;
	for (int i = 0; i < 4; i++)
		{
		for(int j = 0; j < 4; j++)
			{
			checkcoord = lPos + vec2((1.0 / viewWidth) * i * 5.0f, (1.0 / viewHeight) * 5.0f * j);
			float matID = GetMaterialIDs(checkcoord);
			if (floor(matID * 255.0f) == 0)
				{
				if (checkcoord.x < 1.0f && checkcoord.x > 0.0f && checkcoord.y < 1.0f && checkcoord.y > 0.0f)
					{
					sunmask = 1.0f;
					}
				}
			}
		}
	sunmask *= 0.34 * (1.0f - timeNoon);
	sunmask *= (1.0f - rainStrength);

	if (sunmask > 0.02)
		{
		vec2 flareScale = vec2(0.35f, 7.0f);
		vec2 flarePos = vec2(lPos.x * aspectRatio * flareScale.x, lPos.y * flareScale.y);
		float flare = distance(flarePos, vec2(texcoord.s * aspectRatio * flareScale.x, texcoord.t * flareScale.y));
		flare = 0.5 - flare;
		flare = clamp(flare * 2.0f, 0.0f, 1.0f) * clamp(-moonPosition.z, 0.0f, 0.5f);
		flare *= sunmask;
		flare = pow(flare, 1.0f);
		color.r += flare * 0.50f * 0.4f;
		color.g += flare * 0.50f * 0.7f;
		color.b += flare * 0.85f * 1.0f;
		}
	}
}