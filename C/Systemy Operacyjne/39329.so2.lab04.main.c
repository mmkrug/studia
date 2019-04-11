// SO2 IS1 210A LAB04
// Michał Krug
// km39329@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int x;
void zmien(){
	x = 0;
	return;
}

void nic(){return;}


int main(int argc, char **argv){

	sigset_t iset, waiting_set;

	sigemptyset(&iset);
	sigaddset(&iset, SIGTSTP);

	struct sigaction akcja;			// do Ctrl + C
	akcja.sa_handler = &zmien;		//
	akcja.sa_flags = 0;			//
	sigaction(SIGINT, &akcja, NULL);	//

	struct sigaction akcja2;		// do Ctrl + Z
	akcja2.sa_handler = &nic;		//
	akcja2.sa_flags = 0;			//
	sigaction(SIGTSTP, &akcja2, NULL);	//
	sigprocmask(SIG_BLOCK, &iset, NULL);	//

	int status;

	int dlugosc_argumentu= strlen(argv[1]);			//
	int dlugosc_docelowa =1;				//
	//printf("dlugosc argumentu: %d\n",dlugosc_argumentu);	//	Funkcja pobierajaca argument
	while(dlugosc_argumentu>=(dlugosc_docelowa*2)){		//	i odpowiendio ucina
		dlugosc_docelowa = dlugosc_docelowa*2;		//	zeby bylo potega dwojki
	}							//
	//printf("dlugosc docelowa: %d\n",dlugosc_docelowa);	//
								//
	char* argumenty = malloc(dlugosc_docelowa+1);		//	jak bedzie dlugosc 1
	strncpy(argumenty,argv[1],dlugosc_docelowa);		//	to przepisze
	//printf("napis koncowy: %s\n",argumenty);		//

	// jesli podany argument mozna podzielic na 2
	if(strlen(argumenty)%2==0){
		char* sciezka =malloc(1);		// deklaracja pustej sciezki
		strcat(sciezka,"\0");

		char* napis = argv[1];			// pobranie argumentu do "napisu"
		int polowa = strlen(argumenty)/2;		// polowa dlugosci argumentu
	

		char* s1 = malloc(polowa+1);		// pierwsza polowa napisu
		strncpy(s1,napis,polowa);
		strcat(s1,"\0");

		char* s2 = malloc(polowa+1);		// druga polowa napisu
		strncpy(s2,napis+polowa,polowa);
		strcat(s2,"\0");

		// jezeli nie ma podanego drugiego argumentu (nie ma wczesniejszej sciezki)
		if(argv[2]!=NULL){
			sciezka =  malloc(strlen(argv[2])+strlen(argumenty)+1); // poprzednie + aktualny + spacja
			strcpy(sciezka, argv[2]);
			strcat(sciezka, " ");
			strcat(sciezka, argumenty);
		}else{
			sciezka =  malloc(strlen(argumenty)+1); // aktualny + spacja
			strcpy(sciezka,argumenty);
			strcat(sciezka, " ");
		}

		pid_t child_1 = fork();
		if(child_1 < 0){					//error dziecka 1
			perror("fork() error");
			exit(-1);

		}else if(child_1 > 0){					//rodzic bo pid = child 1

			pid_t child_2 = fork();
			if(child_2 < 0){				//error dziecka 2
				perror("fork() error");
				exit(-1);
			}
			else if(child_2 > 0){				//rodzic bo pid = child 2

				x = 1;
				while(x){
				}
				
				kill(child_1, SIGINT);
				kill(child_2, SIGINT);

				wait(&status);
				if(WIFEXITED(status) == 0){
					exit(-1);
				}

				wait(&status);
				if(WIFEXITED(status) == 0){
					exit(-1);
				}
				
				printf("  pid: %d, sid:%d, %s\n",getpid(), getsid(0), sciezka);
				sigpending(&waiting_set);
				if(sigismember(&waiting_set, SIGTSTP) && argv[2] == NULL){
					printf("  Wykryto oczekujace Ctrl+Z.\n");
				}
				free(sciezka);
				sigprocmask(SIG_UNBLOCK, &iset, NULL);

			}
			else{	// dziecko 2
				setsid();
				execl("39329", "39329", s2, sciezka, (char *) NULL);
				//printf("  %d: %s\n",getpid(),sciezka);
				free(sciezka);
			}
		}else{	// dziecko 1
			setsid();
			execl("39329", "39329", s1, sciezka, (char *) NULL);
			//printf("  %d: %s\n",getpid(),sciezka);
			free(sciezka);
		}




	// jesli podany argument nie jest podzielny przez dwa (jest ostatnim symbolem)
	}else{	
		x=1;
		while(x){}

		char* sciezka;
		if(argv[2]!=NULL){
			sciezka =  malloc(strlen(argv[2])+strlen(argumenty)+1); // poprzednie + aktualny + spacja
			strcpy(sciezka, argv[2]);
			strcat(sciezka, " ");
			strcat(sciezka, argumenty);
		}else{
			sciezka =  malloc(strlen(argumenty)+1); // aktualny + spacja
			strcat(sciezka,argumenty);
			strcat(sciezka, " ");
		}

		printf("  pid: %d, sid:%d, %s\n",getpid(), getsid(0), sciezka);
		free(sciezka);
		//exit(0);
		return 0;
	}
}