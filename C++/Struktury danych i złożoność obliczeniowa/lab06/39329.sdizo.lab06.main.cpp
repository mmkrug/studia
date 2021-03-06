// SDIZO IS1 210A LAB06
// Michał Krug
// km39329@zut.edu.pl
#include "stdafx.h"
#include <iostream>
#include <time.h>
#include <fstream>

using namespace std;

int *tab, *tab_2;
int wym = 997;
int wym_2 = 997;
int wstawione = 0;

int power(int a, int b) {
	if (b == 0) return 1;
	int wynik = a;
	for (int i = 1; i < b; i++) {
		wynik = wynik * a;
	}
	return wynik;
}

int H(int klucz) {
	return  ((klucz % 1000) + power(2, klucz % 10) + 1) % 997;
}

int Hprim(int klucz) {
	return 3 * klucz % 19 + 1;
}

/////////////////////////////////////////////////     adresowanie liniowe
 
void inicjalizacja() {
	tab = new int[wym];
	for (int i = 0; i<wym; i++) {
		tab[i] = 0;
	}
}

void usun_liniowe(int klucz) {
	int poz = H(klucz);
	if (tab[poz] == klucz){
		tab[poz] = -1;
	}
	else {
		bool flaga = false;
		int x = 1;
		for (int i = 1; i < wym; i++) {
			if (poz + x < wym) {
				if (tab[poz + x] == klucz) {
					tab[poz + x] = -1;
					flaga = true;
					break;
				}
				else if (tab[poz + x] == 0) {
					cout << "  Klucz " << klucz << " nie istnieje." << endl;
					return;
				}
				x++;
			}
			else {
				poz = 0;
				x = 0;
				i--;
			}
		}
		if (flaga == false) {
			cout << "  Klucz " << klucz << " nie znaleziony." << endl;
		}
	}
}

int wstaw_liniowe(int klucz) {	// 0: wstawilo klucz, -1: klucz juz istnieje, -2: nie ma miejsca
	int poz = H(klucz);
	if (tab[poz] == 0) {
		tab[poz] = klucz;
	}
	else {
		if (tab[poz] == klucz) {
			cout << "  Klucz " << klucz << " juz istnieje" << endl;
			return -1;
		}
		bool flaga = false;
		int x = 1;
		for (int i = 1; i < wym; i++) {
			if (tab[poz + x] == klucz) {
				cout << "  Klucz " << klucz << " juz istnieje" << endl;
				return -1;
			}
			if (poz + x < wym) {
				if (tab[poz + x] == 0) {
					tab[poz + x] = klucz;
					flaga = true;
					break;
				}
				x++;
			}
			else {
				poz = 0;
				x = 0;
				i--;
			}
		}
		if (flaga == false) {
			cout << "  Nie ma miejsca dla klucza " << klucz << endl;
			return -2;
		}
	}
	wstawione++;
	return 0;
}

void wstaw_liniowe_x(int ile) {
	int los;
	int status;
	wstawione = 0;
	for (int i = 0; i < ile; i++) {

		los = rand() % 20001 + 20000;
		status = wstaw_liniowe(los);

		if (status == -2) {
			cout << "  Brak miejsca.  i= " << i << endl;
			break;
		}
		else if (status == -1) {
			i--;
		}
	}
	cout << "  Wstawione: " << wstawione << endl;
}

void wyszukaj_liniowe(int klucz) {
	int poz = H(klucz);
	if (tab[poz] == klucz) {
		cout << "  Klucz " << klucz << " znaleziony na pozycji: " << poz << endl;
		return;
	}
	else {
		bool flaga = false;
		int x = 1;
		for (int i = 1; i < wym; i++) {
			if (poz + x < wym) {
				if (tab[poz + x] == klucz) {
					cout << "  Klucz " << klucz << " znaleziony na pozycji: " << poz + x << endl;
					flaga = true;
					break;
				}
				else if (tab[poz + x] == 0) {
					break;
				}
				x++;
			}
			else {
				poz = 0;
				x = 0;
				i--;
			}
		}
		if (flaga == false) {
			cout << "  Klucz " << klucz << " nie znaleziony." << endl;
		}
	}
}

void wyswietl_liniowe(int poczatek, int koniec) {
	if (poczatek > koniec) {
		cout << "  Bledne argumenty." << endl;
		return;
	}
	for (int i = poczatek; i <= koniec; i++) {
		cout << "  " << i << ": " << tab[i] << endl;
	}
	cout << endl;
}

////////////////////////////////////////////    mieszanie podwojne
void inicjalizacja_2() {
	tab_2 = new int[wym_2];
	for (int i = 0; i<wym_2; i++) {
		tab_2[i] = 0;
	}
}

void usun_podwojne(int klucz) {
	int poz = H(klucz);
	if (tab_2[poz] == klucz) {
		tab_2[poz] = -1;
	}
	else {
		if (tab_2[poz] == 0) {
			cout << "  Klucz " << klucz << " nie istnieje." << endl;
			return;
		}
		bool flaga = false;
		int x = Hprim(klucz);
		for (int i = 1; i < wym_2; i++) {

			poz = (poz + x) % wym_2;
			if (tab_2[poz] == klucz) {
				tab_2[poz] = -1;
				flaga = true;
				break;
			}
			else if (tab[poz] == 0) {
				cout << "  Klucz " << klucz << " nie istnieje." << endl;
				return;
			}
		}
		if (flaga == false) {
			cout << "  Klucz " << klucz << " nie znaleziony." << endl;
		}
	}
}

int wstaw_podwojne(int klucz) {	// 0: wstawilo klucz, -1: klucz juz istnieje, -2: nie ma miejsca
	int poz = H(klucz);
	if (tab_2[poz] == 0) {
		tab_2[poz] = klucz;
	}
	else {
		if (tab_2[poz] == klucz) {
			cout << "  Klucz " << klucz << " juz istnieje" << endl;
			return -1;
		}
		bool flaga = false;
		int x = Hprim(klucz);
		for (int i = 1; i < wym_2; i++) {

			poz = (poz + x) % wym_2;
			if (tab_2[poz] == 0) {
				tab_2[poz] = klucz;
				flaga = true;
				break;
			}
			else if (tab_2[poz] == klucz) {
				cout << "  Klucz " << klucz << " juz istnieje" << endl;
				return -1;
			}
		}
		if (flaga == false) {
			cout << "  Nie ma miejsca dla klucza " << klucz << endl;
			return -2;
		}
	}
	wstawione++;
	return 0;
}

void wstaw_podwojne_x(int ile) {
	int los;
	int status;
	wstawione = 0;
	for (int i = 0; i < ile; i++) {

		los = rand() % 20001 + 20000;
		status = wstaw_podwojne(los);

		if (status == -2) {
			cout << "  Brak miejsca.  i= " << i << endl;
			break;
		}
		else if (status == -1) {
			i--;
		}
	}
	cout << "  Wstawione: " << wstawione << endl;
}

void wyszukja_podwojne(int klucz) {
	int poz = H(klucz);
	if (tab_2[poz] == klucz) {
		cout << "  Klucz " << klucz << " znaleziony na pozycji: " << poz << endl;
		return;
	}
	else {
		if (tab_2[poz] == 0) {
			cout << "  Klucz " << klucz << " nie istnieje." << endl;
			return;
		}
		int x = Hprim(klucz);
		for (int i = 1; i < wym_2; i++) {

			poz = (poz + x) % wym_2;
			if (tab_2[poz] == klucz) {
				cout << "  Klucz " << klucz << " znaleziony na pozycji: " << poz << endl;
				return;
			}
			else if (tab_2[poz] == 0) {
				cout << "  Klucz " << klucz << " nie istnieje." << endl;
				return;
			}
		}
	}
}

void wyswietl_podwojne(int poczatek, int koniec) {
	if (poczatek > koniec) {
		cout << "  Bledne argumenty." << endl;
		return;
	}
	for (int i = poczatek; i <= koniec; i++) {
		cout << "  " << i << ": " << tab_2[i] << endl;
	}
	cout << endl;
}


int main()
{

	clock_t begin, end;
	double time_spent;
	srand(time(NULL));

	int k1, k2, k3, k4, X;
	fstream plik;
	if (plik.good()) {
		plik.open("inlab06.txt", ios::in);
		plik >> X >> k1 >> k2 >> k3 >> k4;
	}
	plik.close();
	



	begin = clock();

	inicjalizacja();
	usun_liniowe(k1);
	wstaw_liniowe(k1);
	wyswietl_liniowe(0, 100);
	wstaw_liniowe_x(X);
	wyswietl_liniowe(0, 100);
	wstaw_liniowe(k2);
	wstaw_liniowe(k3);
	wstaw_liniowe(k4);
	wyswietl_liniowe(0, 100);
	wyswietl_liniowe(500, 600);
	usun_liniowe(k3);
	usun_liniowe(k4);
	wyswietl_liniowe(0, 100);
	wyswietl_liniowe(500, 600);

	end = clock();
	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	cout << endl << endl << "Czas wykonania: " << time_spent << endl;
	



	begin = clock();

	inicjalizacja_2();
	usun_podwojne(k1);
	wstaw_podwojne(k1);
	wyswietl_podwojne(0, 100);
	wstaw_podwojne_x(X);
	wyswietl_podwojne(0, 100);
	wstaw_podwojne(k2);
	wstaw_podwojne(k3);
	wstaw_podwojne(k4);
	wyswietl_podwojne(0, 100);
	wyswietl_podwojne(500, 600);
	usun_podwojne(k3);
	usun_podwojne(k4);
	wyswietl_podwojne(0, 100);
	wyswietl_podwojne(500, 600);

	end = clock();
	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	cout << endl << endl << "Czas wykonania: " << time_spent << endl;


	system("pause");
    return 0;
}