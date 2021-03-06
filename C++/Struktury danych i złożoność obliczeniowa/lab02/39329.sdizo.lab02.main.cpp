// SDIZO I1 210A LAB02
// Michał Krug
// km39329@zut.edu.pl
#include "stdafx.h"
#include <iostream>
#include <ctime>
#include <fstream>
using namespace std;

class Wezel {
public:
	int static ilosc_wezlow;
	int klucz;
	double d;
	char c;
	Wezel* moj_adres;
	Wezel* nastepnik;
	Wezel* poprzednik;
};

Wezel *head = new Wezel;
Wezel *tail = new Wezel;
Wezel *aktualny = new Wezel;

static int ilosc_wezlow = 0;

void dodaj_jeden(int klucz);		// 1 wstaw jeden
void dodaj_wiele(int ile);			// 2 wstaw wiele
void wyszukaj(int klucz);			// 3 wyszukaj klucz
void usun_jeden(int klucz);			// 4 usun element o kluczu
void wyswietl_przod(int ile);		// 5 wyswietl x elem z przodu
void wyswietl_tyl(int ile);			// 6 wyswietl x elem od tylu
void wyswietl_ilosc_wezlow();		// 7 wyswietlanie wezlow
void usun_wszystko();				// 8 usuwanie wszystkiego


									//#################################################################			MAIN START
int main()
{
	int x, k1, k2, k3, k4, k5;
	fstream plik;
	plik.open("inlab02.txt", ios::in | ios::out);
	if (plik.good() == true)
	{
		cout << "  Uzyskano dostep do pliku!" << endl;
		plik >> x >> k1 >> k2 >> k3 >> k4 >> k5;
		plik.close();
	}
	else cout << "  Dostep do pliku zostal zabroniony!" << endl;

	clock_t begin, end;												// czas start
	double time_spent;
	begin = clock();
	srand(time(NULL));

	head->klucz = NULL;												// inicjacja listy
	head->d = NULL;
	head->c = NULL;
	head->moj_adres = head;
	head->nastepnik = nullptr;
	head->poprzednik = nullptr;
	tail = head;
	aktualny = head;

	wyszukaj(k1);													// wyszukanie k1
	dodaj_wiele(x);													// dodanie x elem
	wyswietl_ilosc_wezlow();										// ilosc wezlow

	wyswietl_przod(20);												// prezentacja 20 z przodu
	dodaj_jeden(k2);												// dodanie k2

	wyswietl_przod(20);												// prezentacja 20 z przodu
	dodaj_jeden(k3);												// dodanie k3

	wyswietl_przod(20);												// prezentacja 20 z przodu
	dodaj_jeden(k4);												// dodaj k4

	wyswietl_przod(20);												// prezentacja 20 z przodu
	dodaj_jeden(k5);												// dodaj k5

	usun_jeden(k3);													// usun k3
	wyswietl_przod(20);												// prezentacja 20 z przodu

	usun_jeden(k2);													// usun k2
	wyswietl_przod(20);												// prezentacja 20 z przodu

	usun_jeden(k5);													// usun k5
	wyswietl_ilosc_wezlow();										// ilosc wezlow

	wyszukaj(k5);													//wyszukaj k5

	wyswietl_tyl(11);												// prezentacja 11 od tylu
	usun_wszystko();												// usun wszystkie elem
	wyswietl_tyl(11);
	wyswietl_ilosc_wezlow();										// ilos wezlow




	end = clock();
	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	cout << "  Czas wykonania: " << time_spent << endl << endl;


	system("pause");
	return 0;
}
//#################################################################			MAIN KONIEC
void dodaj_jeden(int klucz) {
	if (head->nastepnik == nullptr) {
		Wezel *wezel = new Wezel;

		wezel->klucz = klucz;
		wezel->d = rand();
		wezel->c = 'T';
		wezel->poprzednik = wezel;
		wezel->moj_adres = wezel;
		wezel->nastepnik = wezel;

		head = wezel;
		tail = wezel;
		aktualny = wezel;
		ilosc_wezlow++;
	}
	else {
		aktualny = head;
		Wezel *wezel = new Wezel;
		int flaga = 0;
		int iteracja = 0;


		while ((aktualny->klucz < klucz) && (iteracja < ilosc_wezlow)) {
			aktualny = aktualny->nastepnik;
			iteracja++;
		}

		if (iteracja == 0) {
			wezel->klucz = klucz;		// wartosci nwoego wezla
			wezel->d = rand();			//
			wezel->c = 'T';				//
			wezel->moj_adres = wezel;	//
			wezel->poprzednik = head->poprzednik;
			wezel->nastepnik = head;

			tail->nastepnik = wezel;
			head->poprzednik = wezel;
			head = wezel;
			ilosc_wezlow++;
		}

		// ##########    jesli klucze sa rozne i jest to ostatni element
		else if ((aktualny->klucz != klucz) && (iteracja == ilosc_wezlow)) {
			wezel->klucz = klucz;		// wartosci nwoego wezla
			wezel->d = rand();			//
			wezel->c = 'T';				//
			wezel->moj_adres = wezel;	//

			aktualny = tail;			// podmiana adresow
			tail = wezel;				//

			aktualny->nastepnik = wezel;

			wezel->nastepnik = head;
			wezel->poprzednik = aktualny;

			head->poprzednik = tail;
			ilosc_wezlow++;
		}
		else if (aktualny->klucz != klucz) {
			wezel->klucz = klucz;		// wartosci nwoego wezla
			wezel->d = rand();			//
			wezel->c = 'T';				//
			wezel->moj_adres = wezel;	//

			wezel->poprzednik = aktualny->poprzednik;
			wezel->nastepnik = aktualny;

			aktualny->poprzednik = wezel;
			aktualny = wezel->poprzednik;
			aktualny->nastepnik = wezel;
			ilosc_wezlow++;
		}
		else {
			cout << "  Podany klucz juz istnieje." << endl;
		}

	}
}

void dodaj_wiele(int ile) {
	if (ile > 0) {
		int los;
		int iteracja;
		for (int i = 0; i < ile; i++) {

			los = ((rand()*rand()) % 99901) + 99;
			aktualny = head;
			iteracja = 0;
			while ((aktualny->klucz != los) && (iteracja < ilosc_wezlow)) {
				aktualny = aktualny->nastepnik;
				iteracja++;
			}
			if (iteracja == ilosc_wezlow) {
				dodaj_jeden(los);
			}
			else {
				i--;
			}
		}
	}
	else cout << "  bledny parametr." << endl;
}

void wyszukaj(int klucz) {
	aktualny = head;
	int iteracja = 0;
	while ((aktualny->klucz != klucz) && (iteracja < ilosc_wezlow)) {
		aktualny = aktualny->nastepnik;
		iteracja++;
	}

	if (iteracja < ilosc_wezlow) {
		cout << "  Klucz:     " << klucz << " znaleziony." << endl;
		cout << "  Moj adres: " << aktualny->moj_adres << endl;
		cout << "  Kl adr: " << aktualny->klucz << endl;
	}
	else {
		cout << "  Klucz: " << klucz << " nie znaleziony." << endl;

	}
}

void usun_jeden(int klucz) {
	if (head->nastepnik == head && head->klucz == klucz) {
		delete head;
		ilosc_wezlow--;
		head->nastepnik = nullptr;
		head->poprzednik = nullptr;
	}
	else {
		aktualny = head;
		int iteracja = 0;
		while ((aktualny->klucz != klucz) && (iteracja < ilosc_wezlow)) {
			aktualny = aktualny->nastepnik;
			iteracja++;
		}

		if (iteracja < ilosc_wezlow) {
			aktualny->poprzednik->nastepnik = aktualny->nastepnik;
			aktualny->nastepnik->poprzednik = aktualny->poprzednik;
			delete aktualny;
			cout << "  Obiekt o kluczu: " << klucz << " usuniety." << endl;
			ilosc_wezlow--;
		}
		else {
			cout << "  Klucz: " << klucz << " nie znaleziony." << endl;

		}
	}
}

void wyswietl_przod(int ile) {
	if (ilosc_wezlow == 0 && head->nastepnik == nullptr) {
		cout << "  Lista jest pusta." << endl;
	}
	else if (ilosc_wezlow == 0 && head->nastepnik != nullptr) {
		cout << "  Lista nie istnieje." << endl;
	}
	else {
		aktualny = head;
		int n = 0;
		if (ile < ilosc_wezlow) {
			n = ile;
		}
		else {
			n = ilosc_wezlow;
		}
		for (int i = 0; i < n; i++) {
			cout << "  klucz:      " << aktualny->klucz << endl;

			aktualny = aktualny->nastepnik;
		}
	}
	cout << endl;
}

void wyswietl_tyl(int ile) {
	if (ilosc_wezlow == 0 && head->nastepnik == nullptr) {
		cout << "  Lista jest pusta." << endl;
	}
	else if (ilosc_wezlow == 0 && head->nastepnik != nullptr) {
		cout << "  Lista nie istnieje." << endl;
	}
	else {
		int n = 0;
		if (ile < ilosc_wezlow) {
			n = ile;
		}
		else {
			n = ilosc_wezlow;
		}
		tail = head->poprzednik;
		aktualny = tail;
		for (int i = 0; i < n; i++) {
			cout << "  klucz:      " << aktualny->klucz << endl;

			aktualny = aktualny->poprzednik;
		}
	}
	cout << endl;
}

void wyswietl_ilosc_wezlow() {
	cout << "  Liczba wezlow: " << ilosc_wezlow << endl;
}

void usun_wszystko() {
	if (ilosc_wezlow > 0) {
		aktualny = head;

		while (aktualny->moj_adres != tail->moj_adres) {
			aktualny = aktualny->nastepnik;
			delete head;
			head = aktualny;
			ilosc_wezlow--;
		}
		delete tail;
		head->nastepnik = nullptr;
		head->poprzednik = nullptr;
		ilosc_wezlow--;
	}
	else {
		cout << "  Lista jest pusta. Nie ma nic do usuniecia." << endl;
	}
}