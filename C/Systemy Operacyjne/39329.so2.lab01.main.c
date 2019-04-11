// SO2 IS1 210A LAB01
// Michał Krug
// km39329@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <utmp.h>
#include <grp.h>
#include <pwd.h>

int main(int argc, char **argv){	
	struct utmp* uzytkownik;
	struct passwd* uzytkownik_pw;
	gid_t *lista_grup;
	struct group* gr;

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
				ile_grup=0;
				uzytkownik_pw = getpwnam(uzytkownik -> ut_user);
				if(getgrouplist(uzytkownik->ut_user,uzytkownik_pw->pw_gid,NULL,&ile_grup)==-1){
					lista_grup = malloc(ile_grup*sizeof(gid_t));
					getgrouplist(uzytkownik->ut_user, uzytkownik_pw -> pw_gid, lista_grup, &ile_grup);
				}
				printf("\t|Grupy: [");
				for (int j = 0; j < ile_grup; j++) {
					gr = getgrgid(lista_grup[j]);
					printf("%s", gr->gr_name);
					if(j==ile_grup-1)
						continue;
					printf(", ");
					
				}
				free(lista_grup);
				optind = 0;
				printf("]");
			}
			printf("\n");
		}
	}
	endutent();
return 0;
}