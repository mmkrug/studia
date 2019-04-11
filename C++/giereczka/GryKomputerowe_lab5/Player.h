#pragma once
#include "SceneObject.h"
class Player :
	public SceneObject
{
public:
	Player();
	~Player();

	void Render();
	void Update();

	vec3 dir;
	float speed;

	float velocity_vertical;
	float velocity_horizontal;

	bool flyingMode;

	float energy;
	float maxEnergy;
};

