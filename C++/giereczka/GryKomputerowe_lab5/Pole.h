#pragma once
#include "SceneObject.h"

class Pole :
	public SceneObject
{
public:
	Pole(vec3 pos, vec3 color, float size, std::string textureName = "");
	~Pole();


	void Render();
	void Update();

	float size;

	std::string textureName;

	float uvMultipler;
};

