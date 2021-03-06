//  SDIZO I1 210A LAB01
//  Michał Krug
//  km39329@zut.edu.pl
#include "stdafx.h"
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <fstream>
using namespace std;

//###################################			Struktura
struct Struktura {
	int i;
	char c;
	float f;
};

//###################################			funkcja losowania, alokacja wskaznikow oraz struktur
Struktura losowanie(int N, Struktura **&tab_adr) {

	//	alokacja N adresów na struktury w tab_adr
	tab_adr = new Struktura*[N];

	// alokacja Struktur dla kolejnych adresów
	for (int i = 0; i < N; i++) {
		tab_adr[i] = new Struktura;
	}

	// przypisanie losowych wartosci kolejnym struktorom
	for (int i = 0; i < N; i++) {
		tab_adr[i]->i = (rand() % 10001) - 1000;
		tab_adr[i]->c = (rand() % 23) + 66;
		tab_adr[i]->f = (1001 + i);

		// porównywanie po kolei wszystkich intów z aktualnym   // losowanie nowego, zerowanie pętli
		for (int k = 0; k < i; k++) {
			if ((tab_adr[i]->i) == (tab_adr[k]->i)) {
				tab_adr[i]->i = (rand() % 10001) - 1000;
				k = 0;
			}
		}
	}

	return **tab_adr;
}

//###################################			funkcja kasowania
void kasowanie(int N, Struktura **&tab_adr) {

	for (int i = 0; i < N; i++) {
		// usuwanie konkretnych struktur
		delete tab_adr[i];
	}
	//usuwanie tablicy adresow
	delete[] tab_adr;
}

//###################################			funkcja sortowania
void sortowanie(int N, Struktura **&tab_adr) {

		int flag = 0;
		for (int i = 0; i<N - 1; i++) {
			flag = 0;
			for (int j = 0; j<N - i; j++) {
				if (tab_adr[i]->i > tab_adr[i + j]->i) {
					swap(tab_adr[i], tab_adr[i + j]);
					flag = 1;
				}
			}
			if (flag == 0) {
				break;
			}
		}

}

//###################################			funkcja zliczania znaków

int zliczanie(int N, Struktura **&tab_adr, char znak) {
	int ile = 0;

	for (int i = 0; i < N; i++) {
		if (tab_adr[i]->c == znak) {
			ile += 1;
		}
	}
	return ile;
}

//###################################			funkcja wyswietlania
void wyswietl(int N, Struktura **&tab_adr) {

	if (N > 20) {
		for (int i = 0; i < 20; i++) {
			cout << "  Rekord " << (i + 1) << endl;
			cout << "  i= " << tab_adr[i]->i << ",  f= " << tab_adr[i]->f << ", znak= " << tab_adr[i]->c << endl;
		}

	}
	else {
		for (int i = 0; i < N; i++) {

			cout << "  Rekord " << (i + 1) << endl;
			cout << "  i= " << tab_adr[i]->i << ",  f= " << tab_adr[i]->f << ", znak= " << tab_adr[i]->c << endl;
		}
	}
}
int main()
{
	//wczytanie pliku
	int N;
	char X;
	fstream plik;
	plik.open("inlab01.txt", ios::in | ios::out);
	if (plik.good() == true)
	{
		cout << "  Uzyskano dostep do pliku!" << endl;
		plik >> N;
		plik >> X;
		plik.close();
	}
	else cout << "  Dostep do pliku zostal zabroniony!" << endl;



	//czas start
	clock_t begin, end;
	double time_spent;
	begin = clock();

	// losowanie N elementów
	srand(time(NULL));
	Struktura **strukt;
	**strukt = losowanie(N, strukt);

	// sortowanie
	sortowanie(N, strukt);

	// zliczanie znaków X
	int ile_znakow = zliczanie(N, strukt, X);
	wyswietl(N, strukt);

	// kasowanie
	kasowanie(N, strukt);

	// czas stop
	end = clock();
	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;

	// Podsumowanie
	cout << endl << "  Struktur: " << N << endl;
	cout << "  Ilosc znakow \"" << X << "\": " << ile_znakow << endl;
	cout << "  Czas wykonania: " << time_spent << endl << endl;

	system("pause");
    return 0;
}