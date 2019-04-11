#pragma once
#include "SceneObject.h"
class Tree :
	public SceneObject
{
public:
	Tree(vec3 pos, vec3 color, float size, std::string textureName = "");
	~Tree();

	void Render();
	void Update();

	float size;

	std::string textureName;

	float uvMultipler;
};

