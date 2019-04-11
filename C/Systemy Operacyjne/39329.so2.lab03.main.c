// SO2 IS1 210A LAB03
// Michał Krug
// km39329@zut.edu.pl
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(int argc, char **argv){

	int status;

	int dlugosc_argumentu= strlen(argv[1]);
	int dlugosc_docelowa =1;

	while(dlugosc_argumentu>=(dlugosc_docelowa*2)){
		dlugosc_docelowa = dlugosc_docelowa*2;
	}


	char* argumenty = malloc(dlugosc_docelowa+1);
	strncpy(argumenty,argv[1],dlugosc_docelowa);


	if(strlen(argumenty)%2==0){
		char* sciezka =malloc(1);
		strcat(sciezka,"\0");

		char* napis = argv[1];
		int polowa = strlen(argumenty)/2;
	

		char* s1 = malloc(polowa+1);
		strncpy(s1,napis,polowa);
		strcat(s1,"\0");

		char* s2 = malloc(polowa+1);
		strncpy(s2,napis+polowa,polowa);
		strcat(s2,"\0");


		if(argv[2]!=NULL){
			sciezka =  malloc(strlen(argv[2])+strlen(argumenty)+1);
			strcpy(sciezka, argv[2]);
			strcat(sciezka, " ");
			strcat(sciezka, argumenty);
		}else{
			sciezka =  malloc(strlen(argumenty)+1);
			strcpy(sciezka,argumenty);
			strcat(sciezka, " ");
		}

		pid_t child_1 = fork();
		if(child_1 < 0){
			perror("fork() error");
			exit(-1);

		}else if(child_1 > 0){

			pid_t child_2 = fork();
			if(child_2 < 0){
				perror("fork() error");
				exit(-1);
			}
			else if(child_2 > 0){

				wait(&status);
				if(WIFEXITED(status) == 0){
					exit(-1);
				}

				wait(&status);
				if(WIFEXITED(status) == 0){
					exit(-1);
				}

				printf("  %d: %s\n",getpid(),sciezka);
				free(sciezka);

			}
			else{
				execl("39329", "39329", s2, sciezka, (char *) NULL);
				free(sciezka);
			}
		}else{
			execl("39329", "39329", s1, sciezka, (char *) NULL);
			free(sciezka);
		}


	}else{	

		char* sciezka;
		if(argv[2]!=NULL){
			sciezka =  malloc(strlen(argv[2])+strlen(argumenty)+1);
			strcpy(sciezka, argv[2]);
			strcat(sciezka, " ");
			strcat(sciezka, argumenty);
		}else{
			sciezka =  malloc(strlen(argumenty)+1);
			strcat(sciezka,argumenty);
			strcat(sciezka, " ");
		}

		printf("  %d: %s\n",getpid(), sciezka);
		free(sciezka);
		return 0;
	}
}