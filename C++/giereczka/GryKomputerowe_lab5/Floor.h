#pragma once
#include "SceneObject.h"
class Floor :
	public SceneObject
{
public:
	Floor(vec3 pos, vec3 color, float size, std::string textureName = "");
	~Floor();

	void Render();
	void Update();

	float size;

	std::string textureName;

	float uvMultipler;
};

