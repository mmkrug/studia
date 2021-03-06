#include "stdafx.h"
#include <iostream>
#include <sstream>
#include <cstdlib>
using namespace std;

class Unit;
class Item;

class Hero {
	friend class Item;
	static int max_exp;

	string imie;
	int lvl;
	int atak;
	int obrona;
	int max_hp;
	int hp;
	int exp;
	int kasa;

	class Plecak {
	private:
		friend class Hero;
		Item **tablica_itemow;
		int ilosc_slotow;
		int ilosc_zajetych_slotow;
	public:
		Plecak();
		~Plecak() {
			cout << "  Plecak zniszczony." << endl;
		}
	};

	Plecak *plecak;

public:
	void wyswietl();
	void wyswietl_plecak();
	void lvlup();
	void lvlup(bool x);
	Hero(){
		cout << "  Podaj imie bohatera: ";
		cin >> imie;
		lvl = 1;
		atak = 5;
		obrona = 5;
		max_hp = 50;
		hp = max_hp;
		exp = 0;
		max_exp = 30;
		kasa = 0;
		plecak = new Plecak();

		cout << "  Bohater utworzony." << endl;
	};
	~Hero(){
		cout << "  Bohater usuniety." << endl;
	}
	void atakuj(Unit* &przeciwnik);
	void kup(Item *&item);

};


class Item {
protected:
	string nazwa;
	int wartosc;
public:
	virtual int cena() = 0;
	virtual void wyswietl() = 0;
};

class Uzbrojenie : public Item {

	int atak;
	int obrona;

public:
	virtual void wyswietl() {
		cout << "  " << nazwa << " doda: " << atak << " ataku, " << obrona << " obrony, wartosc: " << wartosc << endl;
	}

	virtual int cena() {
		return wartosc;
	}
	
	Uzbrojenie(string nazwa_uzbrojenia = "<uzbrojenie>", int wartosc_uzbrojenia = 50, int atak_uzbrojenia = 10, int obrona_uzbrojenia = 5) {
		nazwa = nazwa_uzbrojenia;
		wartosc = wartosc_uzbrojenia;
		atak = atak_uzbrojenia;
		obrona = obrona_uzbrojenia;
	}
};

class Mikstura : public Item {
	
	int hp;

public:
	virtual void wyswietl() {
		cout << "  " << nazwa << " odnowi: " << hp << " HP, wartosc: " << wartosc << endl;
	}

	virtual int cena() {
		return wartosc;
	}

	Mikstura(string nazwa_mikstury = "<mikstura>", int wartosc_mikstury = 50, int ilosc_hp = 20) {
		nazwa = nazwa_mikstury;
		wartosc = wartosc_mikstury;
		hp = ilosc_hp;
	}
};

class Runa : public Uzbrojenie, public Mikstura, public Item {

	string nazwa;
	int wartosc;
	int atak;
	int obrona;
	int hp;

public:
	virtual void wyswietl() {
		cout << "  " << nazwa << " doda: " << atak << " ataku, " << obrona << " obrony, oraz odnowi: " << hp << " HP, wartosc: " << wartosc << endl;
	}

	virtual int cena() {
		return wartosc;
	}

	Runa(string nazwa_runy = "<mikstura>", int wartosc_runy = 50, int atak_runy = 5, int obrona_runy = 5, int ilosc_hp = 20) {
		nazwa = nazwa_runy;
		wartosc = wartosc_runy;
		atak = atak_runy;
		obrona = obrona_runy;
		hp = ilosc_hp;
	}
};

class Modyfikator {
	friend class Unit;
	static float atak;
	static float obrona;
	static float hp;
	static float exp;
	static float kasa;

public:
	Modyfikator() {
		atak = 1;
		obrona = 1;
		hp = 1;
		exp = 1;
		kasa = 1;
	}
	Modyfikator(float x) {
		atak = x;
		obrona = x;
		hp = x;
		exp = x;
		kasa = x;
	}
	~Modyfikator() {

	}

	void wyswietl();
};

float Modyfikator::atak = 1;
float Modyfikator::obrona = 1;
float Modyfikator::hp = 1;
float Modyfikator::exp = 1;
float Modyfikator::kasa = 1;

class Unit {
	
	friend void Hero::atakuj(Unit* &jednotski);
	friend void dodaj_jednostke();
	friend void dodaj_jednostke(Unit** &jednostki,bool bol);
	friend void wyswietl(Unit ** &jednostki);
	static int id;
	static int ilosc_jednostek;
	static Modyfikator* modyfikator;

	string imie;
	int atak;
	int obrona;
	int max_hp;
	int hp;
	int exp;
	int kasa;

public:
	void wyswietl();
	Unit() {
		cout << "\n  imie: "; cin >> imie;
		cout << "  Atak: "; cin >> atak;
		cout << "  Obrona: "; cin >> obrona;
		cout << "  HP: "; cin >> max_hp;
		hp = max_hp;
		exp = id / 4;
		kasa = id / 4;
		ilosc_jednostek += 1;
	}
	Unit(bool bol) {
		id++;
		imie = "Unit " + to_string(id);
		atak = 2 * id;
		obrona = 2 * id;
		max_hp = 10 * id;
		hp = max_hp;
		exp = 10 + (0, 5 * id);
		kasa = 10 * id;
		ilosc_jednostek += 1;
	}
	Unit(const Unit &unit) {
		cout << "  Konstruktor kopiujacy." << endl;
		imie = unit.imie;
		atak = unit.atak;
		obrona = unit.obrona;
		max_hp = unit.max_hp;
		hp = max_hp;
		exp = unit.exp;
		kasa = unit.kasa;
	}
	~Unit(){
		ilosc_jednostek -= 1;
	}

	static void zmien(int a, float b);
	static void odswiez_jednostki(Unit** jednostki);
};

Hero::Plecak::Plecak() {
	ilosc_slotow = 5;
	ilosc_zajetych_slotow = 0;
	tablica_itemow = new Item*[5];
}

class Temp {
	friend void wyswyetltempy();
	friend ostream & operator<<(ostream &wyjscie, Temp klasa);
	friend istream & operator>>(istream &wyjscie, Temp &klasa);
	int klucz;
	int tab[2];
public:
	Temp() {
		klucz = 1;
		tab[0] = 0;
		tab[1] = 0;
	}
	void wyswietl() {
		cout << "  Klucz: " << klucz << endl;
		cout << "  Tab[0]=" << tab[0] << "\tTab[1]=" << tab[1] << endl;
	}

	// funkcje operatorow
	void operator()(int x) {
		klucz += x;
	}

	int& operator[](int x) {
		return tab[x];
	}

	void operator=(const Temp &temp) {
		klucz = temp.klucz;
		tab[0] = temp.tab[0];
		tab[1] = temp.tab[1];
	}


};

void dodaj_jednostke(int x,bool bol);
void dodaj_jednostke(int x);
void usun_jednostke(int x);
void usun_jednostke(int x, bool bol);

void stworz(Hero* &bohater);
void stworz(Unit** &jednostki, int ilosc);
void stworz_sklep();

int Hero::max_exp = 0;
int Unit::id = 0;
int Unit::ilosc_jednostek=0;
int n = 0;

Temp temp;
Temp* tempy = new Temp[5];
Hero* bohater;
Unit** jednostki;
Item** sklep;


//############################			MAIN START
int main()
{
	
	stworz_sklep();
	stworz(bohater);
	
	cout << "  Ile utworzyc jednostek? ";
	cin >> n;
	stworz(jednostki, n);

	int status1 = 0;	bool petla1 = true;	// do glownego menu
	int status2 = 0;	bool petla2 = true;	// do menu wyswietlania
	int status3 = 0;						// do menu walki
	int status4 = 0;	bool petla4 = true; // do menu sklepu

	int status5 = 0;	bool petla5 = true;	// do menu modyfikacji
	int status6 = 0;	bool petla6 = true; // do menu modyfikatora
	int status7 = 0;	bool petla7 = true; // do operatorow
	int x;

	system("cls");
	bohater->wyswietl();
	while (petla1) {
		cout << endl;
		cout << "  1 - Wyswietl" << endl;
		cout << "  2 - Lvl up." << endl;
		cout << "  3 - Atakuj" << endl;
		cout << "  4 - Sklep" << endl;
		cout << "  5 - Modyfikacja" << endl;
		cout << "  6 - Operatory" << endl;
		cout << "  0 - Wyjscie z gry" << endl;
		cout << "\t";
		cin >> status1;

		switch (status1) {

		//			Menu wyswietlania
		case 1: {
			petla2 = true;

			system("cls");
			bohater->wyswietl();
			while (petla2) {

				cout << "  1 - Jednostki" << endl;
				cout << "  2 - Tempy" << endl;
				cout << "  3 - Temp" << endl;
				cout << "  4 - Plecak" << endl;
				cout << "  0 - Powrot" << endl;
				cout << "\t";
				cin >> status2;

				switch (status2) {
				//			Wyswietl jednostki
				case 1:
					system("cls");
					bohater->wyswietl();
					wyswietl(jednostki);
					petla2 = false;
					break;

				case 2:
					wyswyetltempy();
					petla2 = false;
					break;

				case 3:
					temp.wyswietl();
					petla2 = false;
					break;

				case 4:
					bohater->wyswietl_plecak();

				default:
					petla2 = false;
					break;
				}
			}
			break;
		}
		//			Menu lvlup'u
		case 2:
			system("cls");
			bohater->lvlup(1);
			bohater->wyswietl();
			break;
		//			Menu walki
		case 3: {
			system("cls");
			bohater->wyswietl();

			cout << "\n  Z kim chcesz walczyc?" << endl;
			wyswietl(jednostki);
			cin >> status3;
			if (status3-1 < n) {
				system("cls");
				bohater->atakuj(jednostki[status3-1]);
			}
			break;
		}
		//			Menu sklepu
		case 4: {
			petla4 = true;
			while (petla4) {
				system("cls");
				bohater->wyswietl();
				for (int i = 0; i < 10; i++) {
					cout << "  " << i+1 << ". ";
					sklep[i]->wyswietl();
				}
				cout << "  0 - Powrot" << endl;
				cout << "\t";
				cin >> status4;

				if (status4 == 0) {
					break;
				}

				if (status4 <= 10) {
					bohater->kup(sklep[status4-1]);
				}
			}

			break;
		}
		//			Menu modyfikacji
		case 5: {
			petla5 = true;
			while (petla5)
			{
				system("cls");
				cout << "  1 - Dodaj Jednostke (automat)" << endl;
				cout << "  2 - Dodaj wiele (automat)" << endl;
				cout << "  3 - Dodaj Jednostke" << endl;
				cout << "  4 - Dodaj wiele" << endl;
				cout << "  5 - Usun jednostke" << endl;
				cout << "  6 - Usun wiele jednostek" << endl;
				cout << "  7 - Menu modyfikatora" << endl;
				cout << "  0 - Powrot" << endl;
				cout << "\t";
				cin >> status5;

				switch (status5) {

				case 1:
					dodaj_jednostke(jednostki,true);
					cout << "  Jednostki zaktualizowane." << endl;
					petla5 = false;
					break;

				case 2:
					cout << "  Ile dodac?\t"; cin >> x;
					dodaj_jednostke(x,true);
					cout << "  Jednostki zaktualizowane." << endl;
					petla5 = false;
					break;

				case 3:
					dodaj_jednostke();
					cout << "  Jednostki zaktualizowane." << endl;
					petla5 = false;
					break;

				case 4:
					cout << "  Ile dodac?\t"; cin >> x;
					dodaj_jednostke(x);
					cout << "  Jednostki zaktualizowane." << endl;
					petla5 = false;
					break;

				case 5:
					wyswietl(jednostki);
					cout << "  Ktora chcesz usunac?\t"; cin >> x;
					usun_jednostke(x);
					cout << "  Jednostki zaktualizowane." << endl;
					petla5 = false;
					break;

				case 6:
					wyswietl(jednostki);
					cout << "  Do ktorej (wlacznie) chcesz usunac?\t"; cin >> x;
					usun_jednostke(x, true);
					cout << "  Jednostki zaktualizowane." << endl;
					petla5 = false;
					break;

				// Menu modyfikatora
				case 7:{
					petla6 = true;
					float y;
					while (petla6) {
						system("cls");
						cout << "  1 - Modyfikator wszystkiego" << endl;
						cout << "  2 - Atak" << endl;
						cout << "  3 - Obrona" << endl;
						cout << "  4 - HP" << endl;
						cout << "  5 - Exp" << endl;
						cout << "  6 - Kasa" << endl;
						cout << "  0 - Wroc" << endl;
						cin >> status6;

						switch (status6) {
						case 1:
							cout << "  Wartosc: ";
							cin >> y;
							Unit::zmien(0, y);
							Unit::odswiez_jednostki(jednostki);
							petla6 = false;
							break;

						case 2:
							cout << "  Modyfikator ataku: ";
							cin >> y;
							Unit::zmien(1, y);
							Unit::odswiez_jednostki(jednostki);
							petla6 = false;
							break;	

						case 3:
							cout << "  Modyfikator obrony: ";
							cin >> y;
							Unit::zmien(2, y);
							Unit::odswiez_jednostki(jednostki);
							petla6 = false;
							break; 

						case 4:
							cout << "  Modyfikator hp: ";
							cin >> y;
							Unit::zmien(3, y);
							Unit::odswiez_jednostki(jednostki);
							petla6 = false;
							break; 

						case 5:
							cout << "  Modyfikator exp'a: ";
							cin >> y;
							Unit::zmien(4, y);
							Unit::odswiez_jednostki(jednostki);
							petla6 = false;
							break; 

						case 6:
							cout << "  Modyfikator kasy: ";
							cin >> y;
							Unit::zmien(5, y);
							Unit::odswiez_jednostki(jednostki);
							petla6 = false;
							break; 

						default:
							petla6 = false;
							break;
						}
					}
				}

				default:
					petla5 = false;
					break;
				}
			}
			break;
		}
		
		// Menu operatorów
		case 6: {
			petla7 = true;
			system("cls");
			bohater->wyswietl();
			while (petla7) {
		
				cout << "  1 - Operatory ()" << endl;
				cout << "  2 - Operatory []" << endl;
				cout << "  3 - Operatory <<" << endl;
				cout << "  4 - Operatory >>" << endl;
				cout << "  5 - Operatory =" << endl;
				cout << "  0 - Powrot" << endl;
				cout << "\t";
				cin >> status7;

				switch (status7) {
					int poz;
				case 1:
					cout << "  Zwiekszenie klucza: ";
					cin >> x;
					cout << "  Pozycja: ";
					cin >> poz;
					tempy[poz-1](x);
					
					petla7 = false;
					break;

				case 2:
					cout << "  Pozycja w tab: ";
					cin >> poz;
					cout << temp[poz - 1];
					
					petla7 = false;
					break;

				case 3:
					cout << temp;
					petla7 = false;
					break;

				case 4:
					cin >> temp;
					petla7 = false;
					break;

				case 5:
					cout << "  Ktory z tempow ma byc customowy?";
					cin >> poz;
					tempy[poz - 1] = temp;
					petla7 = false;
					break;

				default:
					petla7 = false;
					break;
				}
			}
			break;
		}

		default:
			petla1 = false;
			break;
		}
	}

	cout << "  Zakonczno." << endl;
    return 0;
}
//############################			MAIN KONIEC

//		 HERO

void stworz(Hero* &bohater) {
	bohater = new Hero();
}

void Hero::wyswietl() {
	cout << endl;
	cout << "  " << imie << "   Lv. " << lvl << endl;
	cout << "  HP: " << hp << "/" << max_hp << endl;
	cout << "  Exp: " << exp << "/" << max_exp << endl;
	cout << "  Plecak: " << plecak->ilosc_zajetych_slotow << "/" << plecak->ilosc_slotow << endl;
	cout << "  Atak: " << atak << "\tObrona: " << obrona << endl;
	cout << "  Kasa: " << kasa << "\tPlecak: " << plecak->ilosc_zajetych_slotow << "/" << plecak->ilosc_slotow << endl << endl;
};

void Hero::atakuj(Unit* &unit) {
	
	Unit przeciwnik = Unit(*unit);
	wyswietl();
	cout << "\t\t\t\t\t VS\t\t" << przeciwnik.imie << endl << endl;
	
	int Hero_dmg;
	int Unit_dmg;

	if (atak >= przeciwnik.obrona) {
		Hero_dmg = atak + (atak - przeciwnik.obrona);
		if (Hero_dmg > atak * 2) {
			Hero_dmg = atak * 2;
		}
	}
	else {
		Hero_dmg = atak - (przeciwnik.obrona - atak);
		if (Hero_dmg < atak / 2) {
			Hero_dmg = atak / 2;
		}
	}

	if (przeciwnik.atak >= obrona) {
		Unit_dmg = przeciwnik.atak + (przeciwnik.atak - obrona);
		if (Unit_dmg > przeciwnik.atak * 2) {
			Unit_dmg = przeciwnik.atak * 2;
		}
	}
	else {
		Unit_dmg = przeciwnik.atak - (atak - przeciwnik.obrona);
		if (Unit_dmg < przeciwnik.atak / 2) {
			Unit_dmg = przeciwnik.atak / 2;
		}
	}

	int ilosc_tur = 0;
	while ((hp > 0) && (przeciwnik.hp > 0)) {
		ilosc_tur += 1;

		przeciwnik.hp = przeciwnik.hp - Hero_dmg;
		cout << "\t\t" << imie << " zadal " << Hero_dmg
			<< " obrazen dla " << przeciwnik.imie << " zostalo mu " << przeciwnik.hp << " punktow zdrowia!" << endl;

		if (przeciwnik.hp <= 0)break;

		hp = hp - Unit_dmg;
		cout << "\t\t" << przeciwnik.imie << " zadal " << Unit_dmg
			<< " obrazen dla " << imie << " zostalo mu " << hp << " punktow zdrowia!" << endl;
	}
	if (przeciwnik.hp <= 0) {
		exp = exp + przeciwnik.exp;
		kasa = kasa + przeciwnik.kasa;
		lvlup();

		cout << "\n\t\t\tZwyciestwo! Walka trwala " << ilosc_tur << " tur(y).\t(+" << przeciwnik.exp << " exp)" << endl;
	}
	else {
		cout << "  Game Over." << endl;
		string x;
		cin >> x;
		exit(0);
	}
	
	wyswietl();
}

void Hero::lvlup() {
	int ilosc_leveli = 0;
	while (exp > max_exp-1) {
		ilosc_leveli++;
		exp = exp - max_exp;
		max_exp += 10;
	}

	if (ilosc_leveli>0) {
		cout << "\n  Gratulacje! Zdobywasz poziom " << lvl + ilosc_leveli << "!!" << endl;
		atak += 2*ilosc_leveli;
		obrona += 2 * ilosc_leveli;
		max_hp += 5 * ilosc_leveli;
		hp += 5 * ilosc_leveli;
		lvl += ilosc_leveli;
	}
}

void Hero::kup(Item *&item) {
	if (kasa >= item->cena()) {
		if (plecak->ilosc_zajetych_slotow < plecak->ilosc_slotow) {
			kasa -= item->cena();
			plecak->tablica_itemow[plecak->ilosc_zajetych_slotow] = item;
			plecak->ilosc_zajetych_slotow++;
			cout << "  Przedmiot kupiony!" << endl;
		}
		else {
			cout << "  Brak miejsc w plecaku" << endl;
		}
	}
	else {
		cout << "  Brakuje kasy." << endl;
	}
}

void Hero::lvlup(bool x) {
	exp += (max_exp - exp);
	lvlup();
}


//		 PLECAK

void Hero::wyswietl_plecak() {
	if (plecak->ilosc_zajetych_slotow == 0) {
		cout << "  Brak itemow w plecaku.\n\n";
		return;
	}
	for (int i = 0; i < plecak->ilosc_zajetych_slotow; i++) {
		cout << "  " << i + 1 << ". ";
		plecak->tablica_itemow[i]->wyswietl();
	}
}

//		 SKLEP

void stworz_sklep() {
	sklep = new Item*[10];
	int los;
	for (int i = 0; i < 10; i++) {
		los = (rand() % 100) + 11;
		if (los % 3 == 0) {
			sklep[i] = new Uzbrojenie("<uzbrojenie" + to_string(i) + '>', los * 2, los, los / 2);
		}
		else if (los % 3 == 1) {
			sklep[i] = new Mikstura("<mikstura" + to_string(i) + '>', los, los*2);
		}
		else {
			sklep[i] = new Runa("<runa" + to_string(i) + '>', los * 3, los / 2, los / 2, los * 2);
		}
	}
}



//		 MODYFIKATOR

void Modyfikator::wyswietl() {
	cout << "  Aktualny modyfikatory ";
	cout << "  Atak: " << atak << endl;
	cout << "  Obrona: " << obrona << endl;
	cout << "  HP: " << hp << endl;
	cout << "  Exp: " << exp << endl;
	cout << "  Kasa: " << kasa << endl;
}

//		UNIT
void stworz(Unit** &jednostki, int ilosc) {
	jednostki = new Unit*[ilosc];
	for (int i = 0; i < ilosc; i++) {
		jednostki[i] = new Unit(true);
	}
}

void Unit::wyswietl() {
	cout << "  Nazwa: " << imie;
	cout << "  Atak: " << atak;
	cout << "  Obrona: " << obrona;
	cout << "  Zdrowie: " << max_hp << endl;
}

void wyswietl(Unit **&jednostki) {
	for (int i = 0; i < n; i++) {
		cout << "  " << i + 1 << ". ";
		cout << jednostki[i]->imie;
		cout << " Atak: " << jednostki[i]->atak;
		cout << " Obrona: " << jednostki[i]->obrona;
		cout << " Zdrowie: " << jednostki[i]->max_hp << endl;
	}
}

// dodanie jednostki z automatu
void dodaj_jednostke(Unit** &jednostki,bool bol) {
	Unit **temp = new Unit*[n + 1];

	for (int i = 0; i < n; i++) {
		temp[i] = jednostki[i];
	}

	Unit *unit = new Unit(true);
	temp[n] = unit;
	n++;
	delete[]jednostki;

	jednostki = temp;
}

// dodanie wiele jednostek z automatu
void dodaj_jednostke(int x,bool bol) {
	for (int i = 0; i < x; i++) {
		dodaj_jednostke(jednostki,true);
	}
}

// dodanie jednostki recznie
void dodaj_jednostke() {
	Unit *unit = new Unit();
	Unit **temp = new Unit*[n + 1];
	bool x = true;
	int k = 0;
	for (int i = 0; i < n; i++) {
		if (x == true && unit->hp < jednostki[i]->hp) {
			temp[i] = unit;
			k = 1;
			temp[i + k] = jednostki[i];
			x = false;
			i++;
		}
		temp[i + k] = jednostki[i];
	}

	if (x == true) {
		temp[n] = unit;
	}
	n++;
	delete[]jednostki;
	jednostki = temp;
}

//dodanie wielu jednostek recznie
void dodaj_jednostke(int x) {
	for (int i = 0; i < x; i++) {
		dodaj_jednostke();
	}
}

// usuniecie wybranej jednostki
void usun_jednostke(int x) {
	Unit **temp = new Unit*[n - 1];
	int k = 0;
	for (int i = 0; i < n; i++) {
		if (i == x - 1) {
			k = 1;
			i++;
		}
		temp[i-k] = jednostki[i];
	}
	n--;
	delete jednostki[x-1];
	delete[]jednostki;

	jednostki = temp;
}

void usun_jednostke(int x, bool bol) {
	Unit **temp = new Unit*[n - x];
	int k = x;
	for (int i = x; i < n; i++) {
		temp[i - k] = jednostki[i];
	}
	
	for (int i = 0; i < x; i++) {
		delete jednostki[i];
	}
	n -= x;
	delete[]jednostki;
	jednostki = temp;
}

void wyswyetltempy(){
	for (int i = 0; i < 5; i++) {
		cout << tempy[i].klucz << " ";
	}
	cout << endl;
}

ostream & operator<<(ostream &wyjscie, Temp klasa) {
	return wyjscie << endl << "  Klucz: " << klasa.klucz << endl;
}

istream & operator>>(istream &wyjscie, Temp &klasa) {
	cout << "  Nowa wartosc klucza: ";
	wyjscie >> klasa.klucz;
	return wyjscie;
}

void Unit::zmien(int a, float b) {
	switch (a) {
	case 0:
		modyfikator->atak = b;
		modyfikator->obrona = b;
		modyfikator->hp = b;
		modyfikator->exp = b;
		modyfikator->kasa = b;
		break;

	case 1:
		modyfikator->atak = b;
		break;

	case 2:
		modyfikator->obrona = b;
		break;
	case 3:
		modyfikator->hp = b;
		break;
	case 4:
		modyfikator->exp = b;
		break;
	case 5:
		modyfikator->kasa = b;
		break;

	default:
		break;
	}
}

void Unit::odswiez_jednostki(Unit** jednostki) {
	for (int i = 0; i < n; i++) {
		jednostki[i]->atak *= modyfikator->atak;
		jednostki[i]->obrona *= modyfikator->obrona;
		jednostki[i]->max_hp *= modyfikator->hp;
		jednostki[i]->hp = jednostki[i]->max_hp;
		jednostki[i]->exp *= modyfikator->exp;
		jednostki[i]->kasa *= modyfikator->kasa;
		cout << "  Odswiezone " << i + 1 << "/" << n << endl;
	}
}