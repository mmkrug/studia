// SO2 IS1 210A LAB02
// Michał Krug
// km39329@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <grp.h>
#include <pwd.h>

char* pobierz_grupy(char* ut_user){
	char* napis;
	struct group* gr;
	gid_t *lista_grup;
	struct passwd* uzytkownik_pw;
	int ile_grup=0;


	uzytkownik_pw = getpwnam(ut_user);
	if(getgrouplist(ut_user,uzytkownik_pw->pw_gid,NULL,&ile_grup)==-1){
		lista_grup = malloc(ile_grup*sizeof(gid_t));
		getgrouplist(ut_user, uzytkownik_pw -> pw_gid, lista_grup, &ile_grup);
	}


	int ilosc_znakow=0;
	for (int j = 0; j < ile_grup; j++) {
		ilosc_znakow += strlen(getgrgid(lista_grup[j])->gr_name);
		ilosc_znakow++;
	}
	ilosc_znakow+=3;


	napis = malloc(ilosc_znakow*sizeof(char));
	strcpy(napis, "");
	strcat(napis, "[");
	for (int j = 0; j < ile_grup; j++) {
		strcat(napis, getgrgid(lista_grup[j])->gr_name);
		strcat(napis, " ");
	}
	strcat(napis, "]");
	free(lista_grup);
	return napis;
}