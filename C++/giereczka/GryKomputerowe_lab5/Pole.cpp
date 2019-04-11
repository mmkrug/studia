#include "stdafx.h"
#include "Pole.h"


Pole::Pole(vec3 pos, vec3 color, float size, std::string textureName)
{
	this->pos = pos;
	this->diffuse = color;
	this->size = size;
	this->textureName = textureName;

	this->radius = 0;// sqrt(3) * size / 4;

	uvMultipler = 1;
}


Pole::~Pole()
{
}

void Pole::Render()
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

	glNormal3f(0.0f, -1.0f, 0.0f);
	glTexCoord2f(0, 1 * uvMultipler);
	glVertex3f(size / 4, -size, -size / 4);
	glTexCoord2f(0, 0);
	glVertex3f(size / 4, -size, size / 4);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(-size / 4, -size, size / 4);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(-size / 4, -size, -size / 4);

	glNormal3f(0.0f, 1.0f, 0.0f);
	glTexCoord2f(0, 1 * uvMultipler);
	glVertex3f(-size / 4, size*2, -size / 4);
	glTexCoord2f(0, 0);
	glVertex3f(-size / 4, size * 2, size / 4);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(size / 4, size * 2, size / 4);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(size / 4, size * 2, -size / 4);

	glNormal3f(-1.0f, 0.0f, 0.0f);
	glTexCoord2f(0, 0);
	glVertex3f(-size / 4, -size, -size / 4);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(-size / 4, -size, size / 4);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(-size / 4, size * 2, size / 4);
	glTexCoord2f(0, 1);
	glVertex3f(-size / 4, size * 2, -size / 4);

	glNormal3f(1.0f, 0.0f, 0.0f);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(size / 4, size * 2, -size / 4);
	glTexCoord2f(0, 1 * uvMultipler);
	glVertex3f(size / 4, size * 2, size / 4);
	glTexCoord2f(0, 0);
	glVertex3f(size / 4, -size, size / 4);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(size / 4, -size, -size / 4);

	glNormal3f(0.0f, 0.0f, -1.0f);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(-size / 4, size * 2, -size / 4);
	glTexCoord2f(0, 1 * uvMultipler);
	glVertex3f(size / 4, size * 2, -size / 4);
	glTexCoord2f(0, 0);
	glVertex3f(size / 4, -size, -size / 4);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(-size / 4, -size, -size / 4);

	glNormal3f(0.0f, 0.0f, 1.0f);
	glTexCoord2f(1 * uvMultipler, 1 * uvMultipler);
	glVertex3f(size / 4, size * 2, size / 4);
	glTexCoord2f(0, 1 * uvMultipler);
	glVertex3f(-size / 4, size * 2, size / 4);
	glTexCoord2f(0, 0);
	glVertex3f(-size / 4, -size, size / 4);
	glTexCoord2f(1 * uvMultipler, 0);
	glVertex3f(size / 4, -size, size / 4);

	glEnd();

	glPopMatrix();

	glDisable(GL_TEXTURE_2D);
}

void Pole::Update()
{

}