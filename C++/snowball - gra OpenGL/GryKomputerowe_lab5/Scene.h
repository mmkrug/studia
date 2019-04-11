#pragma once

#include "Skydome.h"

class Scene
{
public:
	Scene(void);
	~Scene(void);

	void Render();
	void Update();

	void HeadUpDisplay();

	void AddObject(SceneObject* object);
	void AddTriangleCollider(vec3 v1, vec3 v2, vec3 v3, vec3 uv1 = vec3(0, 0, 0), vec3 uv2 = vec3(0, 0, 0), vec3 uv3 = vec3(0, 0, 0), std::string textureName = "");

	vec3 boundaryMin;
	vec3 boundaryMax;

	struct HUD
	{
		float energy;
		float maxEnegry;
		float fps;
	}hud;

	Skydome* skydome;

	bool showSphereColliders;

private:

	struct Triangle
	{
		vec3 v1, v2, v3;
		vec3 uv1, uv2, uv3;
		std::string textureName;
		vec3 n;
		float A, B, C, D;
	};

	std::vector<SceneObject*> sceneObjects;
	std::vector<Triangle> collisionTriangles;
};

