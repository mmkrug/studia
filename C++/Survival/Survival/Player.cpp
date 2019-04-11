#include "stdafx.h"
#include "Player.h"


Player::Player()
{
	pos.x = 0.0f;
	pos.y = 1.0f;
	pos.z = 10.0f;

	dir.x = 0.0f;
	dir.y = 0.0f;
	dir.z = -1.0f;

	speed = 0.1f;
	radius = 2.0f;

	velocity_horizontal = 0;
	velocity_vertical = 0;

	flyingMode = false;

	weight = 2;

	energy = 100;
	maxEnergy = 100;
}


Player::~Player()
{
}

void Player::Render()
{

}

void Player::Update()
{
	pos.x += dir.x * speed * velocity_vertical;
	pos.z += dir.z * speed * velocity_vertical;

	pos.x += dir.z * speed * velocity_horizontal;
	pos.z -= dir.x * speed * velocity_horizontal;

	if(flyingMode)
		pos.y += dir.y * speed * velocity_vertical;
	else
		pos.y = 9.0;

	velocity_vertical /= 1.2;
	velocity_horizontal /= 1.2;

	pos.x += force.x / weight;
	pos.y += force.y / weight;
	pos.z += force.z / weight;

	force.x /= 1.2;
	force.y /= 1.2;
	force.z /= 1.2;

	energy += 0.5f;

	if (energy > maxEnergy)
		energy = maxEnergy;
}