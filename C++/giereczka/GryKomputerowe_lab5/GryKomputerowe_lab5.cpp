#include "stdafx.h"
#include <iostream>
// podlogi z snow3, trees
void OnRender();
void OnReshape(int, int);
void OnKeyPress(unsigned char, int, int);
void OnKeyDown(unsigned char, int, int);
void OnKeyUp(unsigned char, int, int);
void OnTimer(int);
void OnMouseMove(int, int);
void OnMouseClick(int, int, int, int);

Player* player;
Sphere* movableSphere;
Sphere* kula;
Model3D* dino1;
Model3D* dino2;
Scene scene;
Pole *Tab[12];
Tree *Trees[4];
Floor *Floors[4];

vec3 mousePosition;

bool captureMouse;

bool light1state = true;
bool light2state = true;

int w = 0, s = 0, a = 0, d = 0;
int boost_w = 1;
int boost_s = 1;
int odbicie = 0;
float speed_X = 0;
float speed_Y = 0;

float T = 0;
float speed = 1;
float bonus = 0;
float lvl = 1;
int licznik = 0;
int licznik_tree = 0;
int licznik_floor = 0;


float windowResolutionX = 1280;
float windowResolutionY = 720;
float windowCenterX = windowResolutionX / 2;
float windowCenterY = windowResolutionY / 2;

int main(int argc, char* argv[])
{
	glutInit(&argc, argv);

	glutInitWindowPosition(600, 100);
	glutInitWindowSize(windowResolutionX, windowResolutionY);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);

	glutCreateWindow("Snowball");

	glutDisplayFunc(OnRender);
	glutReshapeFunc(OnReshape);
	glutKeyboardFunc(OnKeyPress);
	glutKeyboardUpFunc(OnKeyUp);
	glutTimerFunc(17, OnTimer, 0);
	glutPassiveMotionFunc(OnMouseMove);
	glutMotionFunc(OnMouseMove);
	//glutMouseFunc(OnMouseClick);

	glClearColor(0.1f, 0.2f, 0.3f, 0.0);

	glEnable(GL_DEPTH_TEST);

	float gl_amb[] = { 0.0f, 0.0f, 0.0f, 1.0f };
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, gl_amb);

	glEnable(GL_LIGHTING);
	glShadeModel(GL_SMOOTH);

	glEnable(GL_CULL_FACE);
	glFrontFace(GL_CCW);
	glCullFace(GL_BACK);

	glutSetCursor(GLUT_CURSOR_NONE);
	captureMouse = false;
	glutWarpPointer(windowCenterX, windowCenterY);

	player = new Player();
	scene.AddObject(player);

	movableSphere = new Sphere(vec3(0, 10, -20), vec3(1, 0, 0), 0.5f, 2);
	movableSphere->ambient = vec3(0.7f, 0.7f, 0.7f);
	//scene.AddObject(movableSphere);

	//for(int i = -2; i <= 2; i++)
	//{
	//	for (int j = -2; j <= 2; j++)
	//	{
	//		if (i == 0 && j == 0) continue;
	//		scene.AddObject(new Sphere(vec3(i * 2.5f, 0, j * 2.5f), vec3(0.0f, i*0.1f + 0.3f, j*0.1f + 0.3f), 0.5f, 2));
	//	}
	//}

	//Cube* cube1 = new Cube(vec3(-25, 0, 22.5), vec3(1, 1, 1), 7, "checkboard_nearest");
	//Cube* cube2 = new Cube(vec3(-25, 0, 7.5), vec3(1, 1, 1), 7, "checkboard_linear");
	//Cube* cube3 = new Cube(vec3(-25, 0, -7.5), vec3(1, 1, 1), 7, "checkboard_linear_mipmap_nearest");
	//Cube* cube4 = new Cube(vec3(-25, 0, -22.5), vec3(1, 1, 1), 7, "checkboard_linear_mipmap_linear");

	//cube3->uvMultipler = 2;
	//cube4->uvMultipler = 2;

	//scene.AddObject(cube1);
	//scene.AddObject(cube2);
	//scene.AddObject(cube3);
	//scene.AddObject(cube4);

	//Pole* slup = new Pole(vec3(0, 0, 0), vec3(1, 1, 1), 2, "wood");
	//scene.AddObject(slup);


	Cube* cube1 = new Cube(vec3(25, 0, -22.5), vec3(1, 1, 1), 7, "tree");
	//scene.AddObject(cube1);

	//	TREES
	for (int i = 0; i < 4; i++) {
		Trees[i] = new Tree(vec3(0, 0, 0 - (i * 50)), vec3(1, 1, 1), 50, "tree");
		scene.AddObject(Trees[i]);
	}

	//Tree* tree1 = new Tree(vec3(0, 0, 0), vec3(1, 1, 1), 50, "tree");
	//tree1->weight = 0;
	//scene.AddObject(tree1);
	//Tree* tree2 = new Tree(vec3(0, 0, -50), vec3(1, 1, 1), 50, "tree");
	//scene.AddObject(tree2);

	//	PODLOGA
	for (int i = 0; i < 4; i++) {
		Floors[i] = new Floor(vec3(0, 0, 0-(i*100)), vec3(1, 1, 1), 100, "snow3");
		scene.AddObject(Floors[i]);
	}

	//Floor* floor1 = new Floor(vec3(0, 0, 0), vec3(1, 1, 1), 100, "snow3");
	//scene.AddObject(floor1);

	//Floor* floor2 = new Floor(vec3(-50, 0, 0), vec3(1, 1, 1), 100, "snow");
	//scene.AddObject(floor2);

	//	PACHOLKI

	for (int i = 0; i < 6; i++) {
		Tab[i] = new Pole(vec3(-25, 0, 30 - (i * 35)), vec3(1, 1, 1), 2, "wood");
		scene.AddObject(Tab[i]);
		Tab[6+i] = new Pole(vec3(25, 0, 30 - (i * 35)), vec3(1, 1, 1), 2, "wood");
		scene.AddObject(Tab[6+i]);
	}


	kula = new Sphere(vec3(0, 0, 25), vec3(1, 1, 1), 0.5f, 222);
	scene.AddObject(kula);

	//Cube* podloga = new Cube(vec3(0, 0, 0), vec3(1, 1, 1), 15,"snow");
	//podloga->radius = 0;
	//scene.AddObject(podloga);

	//Model3D* 
	dino1 = new Model3D(vec3(0, 1, -20), vec3(1, 1, 1));
	dino1->load("../Resources/Models/dino.obj");
	dino1->textureName = "dino";
	dino1->modelTranslation = vec3(0, -0.8f, 0);
	dino1->modelScale = vec3(0.1, 0.1, 0.1);
	dino1->radius *= 0.1f;
	scene.AddObject(dino1);


	//Model3D* 
	dino2 = new Model3D(vec3(0, 5, -100), vec3(1, 1, 1));
	dino2->load("../Resources/Models/dino.obj");
	dino2->textureName = "dino";
	dino2->modelTranslation = vec3(0, -0.8f, 0);
	dino2->modelScale = vec3(0.2, 0.2, 0.2);
	dino2->radius *= 0.2f;
	scene.AddObject(dino2);



	scene.boundaryMin = vec3(-200, 0, -50000);
	scene.boundaryMax = vec3(200, 50, 50);

	//scene.AddTriangleCollider(vec3(120, 0, -120), vec3(-120, 0, -120), vec3(120, 0, 120), vec3(1, 1), vec3(0, 1), vec3(1, 0), "snow2");
	//scene.AddTriangleCollider(vec3(-120, 0, -120), vec3(-120, 0, 120), vec3(120, 0, 120), vec3(0, 1), vec3(0, 0), vec3(1, 0), "snow2");

	//scene.AddTriangleCollider(vec3(120, 0, -120), vec3(0, 0, -120), vec3(120, 0, 0), vec3(1, 1), vec3(0, 1), vec3(1, 0), "snow2");
	//scene.AddTriangleCollider(vec3(0, 0, -120), vec3(0, 0, 0), vec3(120, 0, 0), vec3(0, 1), vec3(0, 0), vec3(1, 0), "snow2");
	//scene.AddTriangleCollider(vec3(120, 0, -120), vec3(-120, 0, -120), vec3(120, 0, 120), vec3(1, 1), vec3(0, 1), vec3(1, 0), "snow2");
	//scene.AddTriangleCollider(vec3(-120, 0, -120), vec3(-120, 0, 120), vec3(120, 0, 120), vec3(0, 1), vec3(0, 0), vec3(1, 0), "snow2");

	scene.AddTriangleCollider(vec3(-10, 3, -10), vec3(-10, 3, 10), vec3(-9, 3, 10), vec3(1, 1), vec3(0, 1), vec3(1, 0), "wood");
	scene.AddTriangleCollider(vec3(-9, 3, 10), vec3(-9, 3, -10), vec3(-10, 3, -10), vec3(1, 1), vec3(0, 1), vec3(1, 0), "wood");

	
	//scene.AddTriangleCollider(vec3(-15, 0, 15), vec3(-15, 15, 15), vec3(15, 15, 15), vec3(1, 0), vec3(1, 1), vec3(0, 1), "brick");


	//scene.AddTriangleCollider(vec3(-15, 0, 15), vec3(-15, 15, 15), vec3(15, 15, 15), vec3(1, 0), vec3(1, 1), vec3(0, 1), "brick");
	//scene.AddTriangleCollider(vec3(15, 15, 15), vec3(15, 0, 15), vec3(-15, 0, 15), vec3(0, 1), vec3(0, 0), vec3(1, 0), "brick");
	//scene.AddTriangleCollider(vec3(-15, 15, 15), vec3(-15, 0, 15), vec3(-15, 15, 30), vec3(0, 1), vec3(0, 0), vec3(1, 1), "brick");
	//scene.AddTriangleCollider(vec3(-15, 0, 15), vec3(-15, 0, 30), vec3(-15, 15, 30), vec3(0, 0), vec3(1, 0), vec3(1, 1), "brick");
	//scene.AddTriangleCollider(vec3(-35, 0, 30), vec3(-35, 15, 30), vec3(-15, 15, 30), vec3(1, 0), vec3(1, 1), vec3(0, 1), "brick");
	//scene.AddTriangleCollider(vec3(-15, 15, 30), vec3(-15, 0, 30), vec3(-35, 0, 30), vec3(0, 1), vec3(0, 0), vec3(1, 0), "brick");
	//scene.AddTriangleCollider(vec3(-35, 15, 30), vec3(-35, 0, 30), vec3(-35, 15, -30), vec3(0, 1), vec3(0, 0), vec3(1, 1), "brick");
	//scene.AddTriangleCollider(vec3(-35, 0, 30), vec3(-35, 0, -30), vec3(-35, 15, -30), vec3(0, 0), vec3(1, 0), vec3(1, 1), "brick");
	//scene.AddTriangleCollider(vec3(25, 0, -30), vec3(25, 15, -30), vec3(-35, 15, -30), vec3(1, 0), vec3(1, 1), vec3(0, 1), "brick");
	//scene.AddTriangleCollider(vec3(-35, 15, -30), vec3(-35, 0, -30), vec3(25, 0, -30), vec3(0, 1), vec3(0, 0), vec3(1, 0), "brick");
	//scene.AddTriangleCollider(vec3(25, 15, -30), vec3(25, 0, -30), vec3(25, 15, 25), vec3(0, 1), vec3(0, 0), vec3(1, 1), "brick");
	//scene.AddTriangleCollider(vec3(25, 0, -30), vec3(25, 0, 25), vec3(25, 15, 25), vec3(0, 0), vec3(1, 0), vec3(1, 1), "brick");
	//scene.AddTriangleCollider(vec3(25, 15, 25), vec3(25, 0, 25), vec3(15, 15, 15), vec3(0, 1), vec3(0, 0), vec3(1, 1), "brick");
	//scene.AddTriangleCollider(vec3(25, 0, 25), vec3(15, 0, 15), vec3(15, 15, 15), vec3(0, 0), vec3(1, 0), vec3(1, 1), "brick");

	//scene.AddTriangleCollider(vec3(5, 5, -21), vec3(-5, 5, -21), vec3(5, 5, -13), vec3(1, 1), vec3(0, 1), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(-5, 5, -21), vec3(-5, 5, -13), vec3(5, 5, -13), vec3(0, 1), vec3(0, 0), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(-5, 5, -21), vec3(-10, 0, -21), vec3(-5, 5, -13), vec3(1, 1), vec3(0, 1), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(-10, 0, -21), vec3(-10, 0, -13), vec3(-5, 5, -13), vec3(0, 1), vec3(0, 0), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(10, 0, -21), vec3(5, 5, -21), vec3(10, 0, -13), vec3(1, 1), vec3(0, 1), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(5, 5, -21), vec3(5, 5, -13), vec3(10, 0, -13), vec3(0, 1), vec3(0, 0), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(5, 5, -13), vec3(-5, 5, -13), vec3(5, 0, -13), vec3(1, 1), vec3(0, 1), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(-5, 5, -13), vec3(-5, 0, -13), vec3(5, 0, -13), vec3(0, 1), vec3(0, 0), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(-5, 5, -13), vec3(-10, 0, -13), vec3(-5, 0, -13), vec3(1, 1), vec3(0, 0), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(5, 5, -13), vec3(5, 0, -13), vec3(10, 0, -13), vec3(0, 1), vec3(0, 0), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(-5, 5, -21), vec3(5, 5, -21), vec3(-5, 0, -21), vec3(1, 1), vec3(0, 1), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(5, 5, -21), vec3(5, 0, -21), vec3(-5, 0, -21), vec3(0, 1), vec3(0, 0), vec3(1, 0), "wood");
	//scene.AddTriangleCollider(vec3(-5, 5, -21), vec3(-5, 0, -21), vec3(-10, 0, -21), vec3(1, 1), vec3(1, 0), vec3(0, 0), "wood");
	//scene.AddTriangleCollider(vec3(5, 5, -21), vec3(10, 0, -21), vec3(5, 0, -21), vec3(0, 1), vec3(1, 0), vec3(0, 0), "wood");

	TextureManager::getInstance()->LoadTexture("checkboard_nearest", "../Resources/Textures/checkboard.bmp", GL_NEAREST, GL_NEAREST);
	TextureManager::getInstance()->LoadTexture("checkboard_linear", "../Resources/Textures/checkboard.bmp", GL_LINEAR, GL_LINEAR);
	TextureManager::getInstance()->LoadTexture("checkboard_linear_mipmap_nearest", "../Resources/Textures/checkboard.bmp", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("checkboard_linear_mipmap_linear", "../Resources/Textures/checkboard.bmp", GL_LINEAR, GL_LINEAR_MIPMAP_LINEAR);

	TextureManager::getInstance()->LoadTexture("dino", "../Resources/Textures/DINO.bmp", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("wood", "../Resources/Textures/wood.jpg", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("brick", "../Resources/Textures/brick.jpg", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("grass", "../Resources/Textures/grass.jpg", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("skydome", "../Resources/Textures/skydome.bmp", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("snow", "../Resources/Textures/snow.jpg", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("snow2", "../Resources/Textures/snow2.jpg", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("snow3", "../Resources/Textures/snow3.jpg", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);
	TextureManager::getInstance()->LoadTexture("tree", "../Resources/Textures/trees.jpg", GL_LINEAR, GL_LINEAR_MIPMAP_NEAREST);

	glutMainLoop();

	return 0;
}

bool keystate[256];

void OnKeyPress(unsigned char key, int x, int y) {
	if (!keystate[key]) {
		OnKeyDown(key, x, y);
	}
	keystate[key] = true;
}

void OnKeyDown(unsigned char key, int x, int y) {
	if (key == 27) {
		glutLeaveMainLoop();
	}
	if (key == 'y')
	{
		player->flyingMode = !player->flyingMode;
	}
	if (key == 'v')
	{
		player->energy += 19;
	}
	if (key == 'm')
	{
		if (captureMouse)
		{
			glutSetCursor(GLUT_CURSOR_LEFT_ARROW);
			captureMouse = false;
		}
		else
		{
			glutSetCursor(GLUT_CURSOR_NONE);
			glutWarpPointer(windowCenterX, windowCenterY);
			captureMouse = true;
		}
	}
	if (key == '1')
	{
		light1state = !light1state;
	}

	if (key == '2')
	{
		light2state = !light2state;
	}

	if (key == 'c')
	{
		scene.showSphereColliders = !scene.showSphereColliders;
	}
}

void OnKeyUp(unsigned char key, int x, int y) {
	if (keystate['w']) {
		w = 1;
		boost_w = 1;
	}
	if (keystate['s']) {
		s = 1;
		boost_s = 1;
	}
	if (keystate['d']) {
		d = 1;
	}
	if (keystate['a']) {
		a = 1;
	}
	keystate[key] = false;
}

void OnMouseMove(int x, int y)
{
	mousePosition.x = x;
	mousePosition.y = y;
}

//void OnMouseClick(int button, int state, int x, int y)
//{
//	if (button == GLUT_LEFT_BUTTON && state == GLUT_DOWN)
//	{
//		if (player->energy >= 5)
//		{
//			Sphere* newSphere = new Sphere(player->pos + player->dir * 3, vec3(0, 0, 1), 0.5, 2);
//			newSphere->force = player->dir * 10.0f;
//			player->energy -= 5;
//			newSphere->radiusChangePerUpdate = -0.005f;
//			scene.AddObject(newSphere);
//		}
//	}
//}


void OnTimer(int id) {
	std::cout << "Speed: "<< speed << "\t R:" << kula->radius << std::endl;


	if (keystate['t']) {
		player->velocity_vertical = 5;
	}
	if (keystate['g']) {
		player->velocity_vertical = -5;
	}
	if (keystate['f']) {
		player->velocity_horizontal = 5;
	}
	if (keystate['h']) {
		player->velocity_horizontal = -5;
	}
	if (keystate['r']) {
		player->pos.y += 0.5f;
	}
	if (keystate['y']) {
		player->pos.y -= 0.5f;
	}

	if (keystate['w']) {
		boost_w = 2;
		kula->pos.z += player->dir.z * speed_Y;
		if (speed_Y < speed * 2) {
			speed_Y += 0.0078125;
		}
	}
	if (keystate['s']) {
		
		boost_s = 0.5;
		kula->pos.z += player->dir.z * speed_Y;
		if (speed_Y > speed / 2) {
			speed_Y -= 0.005;
		}

	}


	if (keystate['a']) {
		if (d == 1 && speed_X > 0) {
			kula->pos.x -= player->dir.z * speed_X;//speed_Y2;
			//kula->pos.z += player->dir.x * speed_X;//speed_Y2;

			//speed_X += (0.03125 / kula->radius) * 2;///////////////
			//speed_X -= 0.03125;
			speed_X -= (0.03125 / kula->radius) * 2;///////////////

			speed_X += 0.03125;
		}
		else {
			kula->pos.x += player->dir.z * speed_X;//speed_Y2;
			//kula->pos.z -= player->dir.x * speed_X;//speed_Y2;
			speed_X += (0.03125 / kula->radius) * 2;
			//speed_X += 0.03125 - kula->radius/ 0.03125;

		}
	}
	if (keystate['d']) {
		if (a == 1 && speed_X > 0) {
			kula->pos.x += player->dir.z * speed_X;//speed_Y2;
			//kula->pos.z -= player->dir.x * speed_X;//speed_Y2;

			//speed_X += (0.03125 / kula->radius) * 2;
			//speed_X -= 0.03125;
			speed_X -= (0.03125 / kula->radius) * 2;
			speed_X += 0.03125;
		}
		else {
			kula->pos.x -= player->dir.z * speed_X;//speed_Y2;
			//kula->pos.z += player->dir.x * speed_X;//speed_Y2;
			speed_X += (0.03125 / kula->radius)*2;
			//speed_X += 0.03125 - kula->radius / 0.03125;

		}

	}

	if (speed_Y > 0 && !keystate['w'] && !keystate['s']) {
		// poslizg do przodu
		if (w) {
			kula->pos.x += player->dir.x * speed_Y;
			//kula->pos.y += player->dir.y * speed_Y;
			kula->pos.z += player->dir.z * speed_Y;
			speed_Y -= 0.005;
		}
		if (s && !keystate['w']) {
			kula->pos.x -= player->dir.x * speed_Y;
			//kula->pos.y -= player->dir.y * speed_Y;
			kula->pos.z -= player->dir.z * speed_Y;
			speed_Y -= 0.005;
		}
	}

	if (speed_X > 0 && !keystate['a'] && !keystate['d']) {
		// poslizg na boki
		if (a) {
			kula->pos.x += player->dir.z * speed_X;//speed_Y2;
			kula->pos.z -= player->dir.x * speed_X;//speed_Y2;
			speed_X -= 0.005;
		}
		if (d && !keystate['a']) {
			kula->pos.x -= player->dir.z * speed_X;//speed_Y2;
			kula->pos.z += player->dir.x * speed_X;//speed_Y2;
			speed_X -= 0.005;
		}
	}

	if (speed_Y <= 0) {
		w = 0; s = 0;
	}

	if (speed_X <= 0) {
		a = 0; d = 0;
	}


	if (captureMouse)
	{
		float theta = atan2(player->dir.z, player->dir.x);
		float phi = asin(player->dir.y);

		theta += (round(mousePosition.x) - windowCenterX) * 0.01;
		phi -= (round(mousePosition.y) - windowCenterY) * 0.01;

		if (phi > 1.4) phi = 1.4;
		if (phi < -1.4) phi = -1.4;

		player->dir.x = cos(theta) * cos(phi);
		player->dir.y = sin(phi);
		player->dir.z = sin(theta) * cos(phi);

		glutWarpPointer(windowCenterX, windowCenterY);
	}

	if (keystate['i']) {
		movableSphere->force.z -= 0.2;
	}
	if (keystate['k']) {
		movableSphere->force.z += 0.2;
	}
	if (keystate['j']) {
		movableSphere->force.x -= 0.2;
	}
	if (keystate['l']) {
		movableSphere->force.x += 0.2;
	}
	if (keystate['o']) {
		movableSphere->pos = vec3(0, 0, 0);
	}

	//if (speed > 0) {
	//	speed -= 0.0625;
	//}
	//else if (speed < 0) {
	//	speed += 0.0625;
	//}
	
	//speed += 0.000244140625;

	movableSphere->pos.x = kula->pos.x - 20;
	movableSphere->pos.y = 10;
	movableSphere->pos.z = kula->pos.z - 10;

	if (player->energy < 100) {
		player->energy += (0.0625 + bonus);
	}
	else {
		//kula->radius += 1;
		lvl++;
		bonus += 0.0625;
		speed += 1/speed;
		player->energy = 0;
	}

	// BAZA
	kula->radius += speed / 256 / lvl;
	kula->pos.z -= ((speed / 2) * lvl / 4) * boost_w * boost_s*kula->radius / 128;
	player->pos.z = kula->pos.z+20;
	player->pos.x = kula->pos.x;

	if (kula->pos.z-kula->radius*2 <= dino1->pos.z && ((kula->pos.x - kula->radius < dino1->pos.x) && kula->pos.x + kula->radius > dino1->pos.x)) {
		player->energy += 20 * lvl;
		dino1->pos.z -= 140;
		dino1->pos.x = (int)((float)kula->radius * 374) % 40 - 20;
	}
	else {
		if (dino1->pos.z > kula->pos.z + 20) {
			dino1->pos.z -= 140;
			dino1->pos.x = (int)((float)kula->radius * 374) % 40 - 20;
		}
	}


	if (kula->pos.z - kula->radius * 2 <= dino2->pos.z && ((kula->pos.x - kula->radius < dino2->pos.x) && kula->pos.x + kula->radius > dino2->pos.x)) {
		player->energy = 0;
		lvl = 1;
		kula->radius -= 1;
		dino2->pos.z -= 600;
		dino2->pos.x = (int)((float)kula->radius * 374) % 40 - 20;
	}
	else {
		if (dino2->pos.z > kula->pos.z + 20) {
			dino2->pos.z -= 156;
			dino2->pos.x = (int)((float)kula->radius * 374) % 40 - 20;
		}
	}



	if (speed_Y > 10) {
		speed_Y = 10;
	}

	if (kula->pos.x < -25) {
		//kula->pos.x -= 0.005;
		d = 1;
		a = 0;
		speed_X /= 2;
		if (speed > 0.02) {
			speed -= 0.01;
		}

		if (kula->radius > 0.5 && kula->radius > speed/5) {
			kula->radius -= speed / 4;
		}
	}
	if (kula->pos.x > 25) {
		a = 1;
		d = 0;
		speed_X /= 2;
		if (speed > 0.02) {
			speed -= 0.01;
		}

		if (kula->radius > 0.5 && kula->radius > speed/5 ) {
			kula->radius -= speed / 4;
		}
	}

	//	PACHOLKI
	if (Tab[licznik]->pos.z > player->pos.z) {
		Tab[licznik]->pos.z -= 210;
		Tab[6 + licznik]->pos.z -= 210;
		licznik++;
		if (licznik == 6) {
			licznik = 0;
		}
	}
	
	//	DRZEWA
	if (Trees[licznik_tree]->pos.z > kula->pos.z+30) {
		Trees[licznik_tree]->pos.z -= 200;
		licznik_tree++;
		if (licznik_tree == 4) {
			licznik_tree = 0;
		}
	}

	//	PODLOGI
	if (Floors[licznik_floor]->pos.z > kula->pos.z + 100) {
		Floors[licznik_floor]->pos.z -= 300;
		licznik_floor++;
		if (licznik_floor == 4) {
			licznik_floor = 0;
		}
	}


	scene.Update();

	glutTimerFunc(17, OnTimer, 0);
}

void OnRender() {


	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();

	float previousT = T;
	T = glutGet(GLUT_ELAPSED_TIME);
	scene.hud.fps = 1.0f / (T - previousT) * 1000;

	scene.hud.energy = player->energy;
	scene.hud.maxEnegry = player->maxEnergy;
	scene.HeadUpDisplay();


	gluLookAt(
		player->pos.x, player->pos.y, player->pos.z,
		player->pos.x + player->dir.x, player->pos.y + player->dir.y, player->pos.z + player->dir.z,
		0.0f, 1.0f, 0.0f
	);

	//{
	//	int size = 10;
	//	int uvMultipler = 1;
	//	glEnable(GL_TEXTURE_2D);
	//	glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
	//	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	//	TextureManager::getInstance()->BindTexture("snow");
	//	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	//	glPushMatrix();

	//	glTranslatef(0, 0, 0);

	//	glBegin(GL_QUADS);

	//		//glNormal3f(0.0f, 1.0f, 0.0f);


	//		glTexCoord2f(0, 0);

	//		glVertex3f(-120.0f, 0.1f, 30.0f);
	//		glTexCoord2f(1, 0);

	//		glVertex3f(120.0f, 0.1f, 30.0f);
	//		glTexCoord2f(1, 1);

	//		glVertex3f(120.0f, 0.1f, -5000.0f);
	//		glTexCoord2f(0, 1);

	//		glVertex3f(-120.0f, 0.1f, -5000.0f);
	//	



	//	glEnd();

	//	glPopMatrix();

	//	glDisable(GL_TEXTURE_2D);
	//}



	if (light1state)
	{
		GLfloat l0_ambient[] = { 0.2f, 0.2f, 0.2f};
		GLfloat l0_diffuse[] = { 1.0f, 1.0f, 1.0f};
		GLfloat l0_specular[] = { 0.5f, 0.5f, 0.5f};
		GLfloat l0_position[] = { movableSphere->pos.x, movableSphere->pos.y, movableSphere->pos.z, 1.0f };

		glEnable(GL_LIGHT0);
		glLightfv(GL_LIGHT0, GL_AMBIENT, l0_ambient);
		glLightfv(GL_LIGHT0, GL_DIFFUSE, l0_diffuse);
		glLightfv(GL_LIGHT0, GL_SPECULAR, l0_specular);
		glLightfv(GL_LIGHT0, GL_POSITION, l0_position);
		glLightf(GL_LIGHT0, GL_CONSTANT_ATTENUATION, 0);
		glLightf(GL_LIGHT0, GL_LINEAR_ATTENUATION, 0.2);
		glLightf(GL_LIGHT0, GL_QUADRATIC_ATTENUATION, 0);
	}
	else
	{
		glDisable(GL_LIGHT0);
	}

	if (light2state)
	{
		GLfloat l1_ambient[] = { 0.4f, 0.4f, 0.4f };
		GLfloat l1_diffuse[] = { 0.5f, 0.5f, 0.5 };
		GLfloat l1_specular[] = { 0.2f, 0.2f, 0.2f };
		GLfloat l1_position[] = { -player->dir.x, -player->dir.y, -player->dir.z, 0.0f };

		glEnable(GL_LIGHT1);
		glLightfv(GL_LIGHT1, GL_AMBIENT, l1_ambient);
		glLightfv(GL_LIGHT1, GL_DIFFUSE, l1_diffuse);
		glLightfv(GL_LIGHT1, GL_SPECULAR, l1_specular);
		glLightfv(GL_LIGHT1, GL_POSITION, l1_position);
		glLightf(GL_LIGHT1, GL_CONSTANT_ATTENUATION, 0);
		glLightf(GL_LIGHT1, GL_LINEAR_ATTENUATION, 0.8);
		glLightf(GL_LIGHT1, GL_QUADRATIC_ATTENUATION, 0);
	}
	else
	{
		glDisable(GL_LIGHT1);
	}



	scene.Render();

	glFlush();
	glutSwapBuffers();
	glutPostRedisplay();
}

void OnReshape(int width, int height) {

	windowResolutionX = width;
	windowCenterY = height;
	windowCenterX = width / 2;
	windowCenterY = height / 2;

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glViewport(0, 0, width, height);
	gluPerspective(60.0f, (float) width / height, .01f, 250.0f);
}