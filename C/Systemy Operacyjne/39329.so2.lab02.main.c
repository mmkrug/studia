// SO2 IS1 210A LAB02
// Michał Krug
// km39329@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <utmp.h>
#include <dlfcn.h>


char* (*pobierz_grupy)(char* ut_user);

int main(int argc, char **argv){	

	void *handle = dlopen( "./39329.so2.lab02.lib.so", RTLD_LAZY);
	if( !handle){
		dlerror();
		printf(" Blad wczytywania biblioteki.\n");
	}
	else{
		if(dlsym(handle, "pobierz_grupy")!= NULL){
			pobierz_grupy = dlsym(handle, "pobierz_grupy");
		}else{
			printf(" Blad wczytywania funkcji");
		}
	}
	
	struct utmp* uzytkownik;
	setutent();

	int host=0, grupa=0, ret, index,ile_grup;
	opterr = 0;

	while( (ret = getopt(argc, argv, "gh")) != -1 ){
		switch(ret){
			case 'g': grupa=1;break;
			case 'h': host=1;break;
			default: abort();
		}

	}

	while(uzytkownik = getutent()){
		if(uzytkownik -> ut_type == 7){
			printf("  |Użytkownik: %s", uzytkownik -> ut_user);
			if(host==1) printf("\t|Host: (%s)", uzytkownik -> ut_host);
			if(grupa==1){
				printf("\t|Grupa: %s",pobierz_grupy(uzytkownik -> ut_user));

			}
			printf("\n");
		}
	}
	endutent();
	if(handle){
		dlclose(handle);
	}

return 0;
}