// SDIZO I1 210A LAB03
// Michał Krug
// km39329@zut.edu.pl
#include "stdafx.h"
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <fstream>
using namespace std;


class Wezel {
public:
	int klucz;
	char c[10];
	Wezel* moj_adres;
	Wezel* lewy;
	Wezel* prawy;
};


class Drzewo {
public:
	friend void dodaj_jeden(int klucz);
	static Wezel *root;

};

Wezel *aktualny;
Wezel *rodzic;
Wezel *pomocniczy_lewy;
Wezel *pomocniczy_prawy;

void inicjacja(Wezel *&root);					// inicjuj puste drzewo
bool dodaj_jeden(Wezel *&root, int klucz);		// wstaw jeden klucz
void dodaj_wiele(Wezel *&root, int ile);		// wstaw x podanych
void wyszukaj(Wezel *&root, int klucz);			// wyszukaj klucz w drzewie
void usun(Wezel *&root, int klucz);				// usun wezel
void preorder(Wezel *root);
void inorder(Wezel *root);
void postorder(Wezel *root);

int ilosc_odwiedzonych = 0;
// ###############################################################################################			MAIN START
int main()
{	
	int x, k1, k2, k3, k4;
	fstream plik;
	plik.open("inlab03.txt", ios::in | ios::out);
	if (plik.good() == true)
	{
		cout << "  Uzyskano dostep do pliku!" << endl;
		plik >> x >> k1 >> k2 >> k3 >> k4;
		plik.close();
	}
	else cout << "  Dostep do pliku zostal zabroniony!" << endl;
	

	clock_t begin, end;
	double time_spent;
	begin = clock();
	srand(time(NULL));


	Wezel *korzen = new Wezel;
	inicjacja(korzen);

	
	usun(korzen, k1);
	dodaj_jeden(korzen, k1);
	preorder(korzen);
	dodaj_wiele(korzen, x);

	ilosc_odwiedzonych = 0;
	cout << "\n  Inorder:" << endl;
	inorder(korzen);
	cout << "  Ilosc odwiedzonych: " << ilosc_odwiedzonych << endl;

	ilosc_odwiedzonych = 0;
	cout << "\n  Preorder:" << endl;
	preorder(korzen);
	cout << "  Ilosc odwiedzonych: " << ilosc_odwiedzonych << endl;

	dodaj_jeden(korzen,k2);
	cout << "\n  Inorder:" << endl;
	inorder(korzen);
	dodaj_jeden(korzen,k3);
	dodaj_jeden(korzen,k4);

	usun(korzen, k1);
	cout << "\n  Preorder:" << endl;
	preorder(korzen);

	wyszukaj(korzen, k1);
	usun(korzen, k2);
	cout << "\n  Inorder:" << endl;
	inorder(korzen);

	usun(korzen, k3);
	usun(korzen, k4);
	


	end = clock();
	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	cout << "  Czas wykonania: " << time_spent << endl << endl;
	system("pause");
    return 0;
}
// ###############################################################################################			MAIN KONIEC

void inicjacja(Wezel *&root) {
	root->klucz=NULL;
	_itoa_s(root->klucz, root->c, 10);
	root->moj_adres = root;
	root->lewy = nullptr;
	root->prawy = nullptr;
	aktualny = root;
}

bool dodaj_jeden(Wezel *&root, int klucz) {

	aktualny = root;

	if (aktualny->klucz == NULL) {
		aktualny->klucz = klucz;
		_itoa_s(klucz, aktualny->c, 10);
		return 0;
	}

	while (aktualny->klucz != klucz) {
		if ((klucz < aktualny->klucz) && (aktualny->lewy != nullptr)) {
			aktualny = aktualny->lewy;
		}
		else if ((klucz > aktualny->klucz) && (aktualny->prawy != nullptr)) {
			aktualny = aktualny->prawy;
		}
		else if ((klucz < aktualny->klucz) && (aktualny->lewy == nullptr)) {
			Wezel *wezel = new Wezel;
			aktualny->lewy = wezel;
			aktualny = wezel;

			aktualny->moj_adres = wezel;
			aktualny->klucz = klucz;
			_itoa_s(klucz, aktualny->c, 10);
			aktualny->lewy = nullptr;
			aktualny->prawy = nullptr;
			//cout << "  Dodano klucz: " << klucz << endl;
			return 0;
		}
		else if ((klucz > aktualny->klucz) && (aktualny->prawy == nullptr)) {
			Wezel *wezel = new Wezel;
			aktualny->prawy = wezel;
			aktualny = wezel;

			aktualny->moj_adres = wezel;
			aktualny->klucz = klucz;
			_itoa_s(klucz, aktualny->c, 10);
			aktualny->lewy = nullptr;
			aktualny->prawy = nullptr;
			//cout << "  Dodano klucz: " << klucz << endl;
			return 0;
		}
	}

	if (aktualny->klucz == klucz) {
		//cout << "  Taki klucz juz isntieje." << endl;
		return 1;
	}
}

void dodaj_wiele(Wezel *&root, int ile) {
	int los;
	for (int i = 0; i < ile; i++) {
		los = (rand() % 20001) - 10000;
		
		if (dodaj_jeden(root, los)) {
			i--;
		}
	}
}

void wyszukaj(Wezel *&root, int klucz) {
	aktualny = root;

	while (aktualny->klucz != klucz) {
		if ((klucz < aktualny->klucz) && (aktualny->lewy != nullptr)) {
			aktualny = aktualny->lewy;
		}
		else if ((klucz > aktualny->klucz) && (aktualny->prawy != nullptr)) {
			aktualny = aktualny->prawy;
		}
		else if ((klucz < aktualny->klucz) && (aktualny->lewy == nullptr)) {
			cout << "  Klucz: " << klucz << " nie znaleziony" << endl;
			return;
		}
		else if ((klucz > aktualny->klucz) && (aktualny->prawy == nullptr)) {
			cout << "  Klucz: " << klucz << " nie znaleziony" << endl;
			return;
		}
	}

	if (aktualny->klucz == klucz) {
		cout << "  Klucz " << klucz << " znaleziony!" << endl;
		cout << aktualny << " " << aktualny->lewy << " " << aktualny->prawy << endl;
	}
}

void usun(Wezel *&root, int klucz) {

	// sprawdzenie czy klucz istnieje
	aktualny = root;
	while (aktualny->klucz != klucz) {
		if ((klucz < aktualny->klucz) && (aktualny->lewy != nullptr)) {
			rodzic = aktualny;
			aktualny = aktualny->lewy;
		}
		else if ((klucz > aktualny->klucz) && (aktualny->prawy != nullptr)) {
			rodzic = aktualny;
			aktualny = aktualny->prawy;
		}
		else if ((klucz < aktualny->klucz) && (aktualny->lewy == nullptr)) {
			cout << "  Klucz: " << klucz << " nie istnieje." << endl;
			return;
		}
		else if ((klucz > aktualny->klucz) && (aktualny->prawy == nullptr)) {
			cout << "  Klucz: " << klucz << " nie istnieje." << endl;
			return;
		}
	}

	// jesli jest rootem
	if (aktualny == root) {

		pomocniczy_lewy = root->lewy;
		pomocniczy_prawy = root->prawy;

		// jesli ma obydwoch potomkow
		if (root->lewy != nullptr && root->prawy != nullptr) {

			rodzic = aktualny;
			aktualny = aktualny->lewy;
			while (aktualny->prawy != nullptr) {
				rodzic = aktualny;
				aktualny = aktualny->prawy;
			}

			//jesli jest to pierwszy poziom
			if (root->lewy == aktualny) {
				delete root;
				root = aktualny;
				root->prawy = pomocniczy_prawy;
			}
			else {
				pomocniczy_lewy = root->lewy;
				pomocniczy_prawy = root->prawy;

				if (aktualny->lewy != nullptr) {
					rodzic->prawy = aktualny->lewy;
				}
				else {
					rodzic->prawy = nullptr;
				}
				delete root;
				aktualny->lewy = pomocniczy_lewy;
				aktualny->prawy = pomocniczy_prawy;
				root = aktualny;

			}
		}// jesli ma tylko lewego potomka
		else if (pomocniczy_lewy != nullptr) {
			delete root;
			root = pomocniczy_lewy;
		}// jesli ma tylko prawego potomka
		else {
			delete root;
			root = pomocniczy_prawy;
		}
	}


	// jesli nie jest rootem i ma dwoch potomkow
	else if (aktualny->lewy != nullptr && aktualny->prawy != nullptr) {

		// jesli jest lewym potomkiem
		if (aktualny == rodzic->lewy) {
			cout << "elo z lewej";
			pomocniczy_lewy = rodzic;
			pomocniczy_prawy = aktualny->prawy;

			rodzic = aktualny;
			aktualny = aktualny->lewy;
			while (aktualny->prawy != nullptr) {
				rodzic = aktualny;
				aktualny = aktualny->prawy;
			}

			// jesli jest na 1 poziomie 
			if (aktualny == rodzic->lewy) {
				aktualny->prawy = pomocniczy_prawy;
				delete pomocniczy_lewy->lewy;
				pomocniczy_lewy->lewy = aktualny;
			}
			else {
				rodzic->prawy = aktualny->lewy;
				aktualny->prawy = pomocniczy_prawy;
				aktualny->lewy = pomocniczy_lewy->lewy->lewy;
				delete pomocniczy_lewy->lewy;
				pomocniczy_lewy->lewy = aktualny;
			}
		}
		// jesli jest prawym potomkiem
		else {
			pomocniczy_lewy = rodzic;
			pomocniczy_prawy = aktualny->prawy;

			rodzic = aktualny;
			aktualny = aktualny->lewy;
			while (aktualny->prawy != nullptr) {
				rodzic = aktualny;
				aktualny = aktualny->prawy;
			}

			// jesli jest na 1 poziomie 
			if (aktualny == rodzic->lewy) {
				aktualny->prawy = pomocniczy_prawy;
				delete pomocniczy_lewy->prawy;
				pomocniczy_lewy->prawy = aktualny;
			}
			else {
				rodzic->prawy = aktualny->lewy;
				aktualny->prawy = pomocniczy_prawy;
				aktualny->lewy = pomocniczy_lewy->prawy->lewy;
				delete pomocniczy_lewy->prawy;
				pomocniczy_lewy->prawy = aktualny;
			}
		}
	}

	// jesli nie jest rootem i ma tylko lewego potomka
	else if (aktualny->lewy != nullptr) {
		// sprawdzenie czy jest lewym czy prawym potomkiem
		if (rodzic->lewy == aktualny) {
			rodzic->lewy = aktualny->lewy;
			delete aktualny;
		}
		else {
			rodzic->prawy = aktualny->lewy;
			delete aktualny;
		}
	}

	// jesli nie jest rootem i ma tylko prawego potomka
	else if (aktualny->prawy!= nullptr) {
		// sprawdzenie czy jest lewym czy prawym potomkiem
		if (rodzic->lewy == aktualny) {
			rodzic->lewy = aktualny->prawy;
			delete aktualny;
		}
		else {
			rodzic->prawy = aktualny->prawy;
			delete aktualny;
		}
	}

	// jesli jest lisciem
	else if (aktualny->lewy == nullptr && aktualny->prawy == nullptr) {
		// sprawdzenie czy jest lewym czy prawym potomkiem
		if (rodzic->lewy == aktualny) {
			delete aktualny;
			rodzic->lewy = nullptr;
		}
		else {
			delete aktualny;
			rodzic->prawy = nullptr;
		}
	}
}

void preorder(Wezel *aktualny) {
	if (aktualny == NULL) {
		return;
	}
	ilosc_odwiedzonych++;
	cout << "  Klucz: " << aktualny->klucz << endl;
	preorder(aktualny->lewy);
	preorder(aktualny->prawy);
}

void inorder(Wezel *aktualny) {
	if (aktualny == NULL) {
		return;
	}
	ilosc_odwiedzonych++;
	inorder(aktualny->lewy);
	cout << "  Klucz: " << aktualny->klucz << endl;
	preorder(aktualny->prawy);
}

void postorder(Wezel *aktualny) {
	if (aktualny == NULL) {
		return;
	}
	ilosc_odwiedzonych++;
	postorder(aktualny->lewy);
	postorder(aktualny->prawy);
	cout << "  Klucz: " << aktualny->klucz << endl;
}