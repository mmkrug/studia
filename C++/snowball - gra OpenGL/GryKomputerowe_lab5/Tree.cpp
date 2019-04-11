#include "stdafx.h"
#include "Tree.h"


Tree::Tree(vec3 pos, vec3 color, float size, std::string textureName)
{
	this->pos = pos;
	this->diffuse = color;
	this->size = size;
	this->textureName = textureName;

	this->radius = 0;// sqrt(3) * size / 2;

	uvMultipler = 1;
}


Tree::~Tree()
{
}

void Tree::Render()
{
	if (!textureName.empty())
	{
		glEnable(GL_TEXTURE_2D);
		glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
		TextureManager::getInstance()->BindTexture(textureName);
	}


	glMaterialfv(GL_FRONT, GL_AMBIENT, &ambient.x);
	glMaterialfv(GL_FRONT, GL_DIFFUSE, &diffuse.x);
	glMaterialfv(GL_FRONT, GL_SPECULAR, &specular.x);

	glPushMatrix();

	glTranslatef(pos.x, pos.y, pos.z);

	glBegin(GL_QUADS);


	glNormal3f(-1.0f, 0.0f, 0.0f);
	glTexCoord2f(0, 0);
	glVertex3f(50, -size / 4, -size / 2);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(50, -size / 4, size / 2);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(60, size / 2, size / 2);
	glTexCoord2f(0, 1);
	glVertex3f(60, size / 2, -size / 2);

	glNormal3f(1.0f, 0.0f, 0.0f);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(-60, size / 2, -size / 2);
	glTexCoord2f(0, 1 * uvMultipler);
	glVertex3f(-60, size / 2, size / 2);
	glTexCoord2f(0, 0);
	glVertex3f(-50, -size / 4, size / 2);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(-50, -size / 4, -size / 2);

	glEnd();

	glPopMatrix();

	glDisable(GL_TEXTURE_2D);
}

void Tree::Update()
{

}