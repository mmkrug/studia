// assembly_01.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"


int main()
{
	unsigned char wej, wyj;
	unsigned char a, y;

	// y = a * 7,75;
	// 4 + 2 + 1 + 0,5 + 0,25
	/*
	_asm{
		MOV AL, a;
		MOV BL, AL;

		SHL AL, 1;
		ADD BL, AL;
		SHL AL, 1;
		ADD BL, AL;

		MOV AL, a;	// a
		SHR AL, 1;	// 0,5 a
		ADD BL, AL;
		SHR AL, 1;	// 0,25 a
		ADD BL, AL;
		
		
		MOV wyj, BL;
	}

	printf("\t%x\n\t%d\n\n", wyj,wyj);
	*/

	// zliczanie zer
	/*
	a = 0x01;
	_asm {
		MOV AL, a
		MOV BL, 0x08;
		AND AL, 0x01;
		SUB BL, AL;

		MOV AL, a;
		SHR AL, 1;
		AND AL, 0x01;
		SUB BL, AL;

		MOV AL, a;
		SHR AL, 2;
		AND AL, 0x01;
		SUB BL, AL;

		MOV AL, a;
		SHR AL, 3;
		AND AL, 0x01;
		SUB BL, AL;

		MOV AL, a;
		SHR AL, 4;
		AND AL, 0x01;
		SUB BL, AL;

		MOV AL, a;
		SHR AL, 5;
		AND AL, 0x01;
		SUB BL, AL;

		MOV AL, a;
		SHR AL, 6;
		AND AL, 0x01;
		SUB BL, AL;

		MOV AL, a;
		SHR AL, 7;
		AND AL, 0x01;
		SUB BL, AL;

		MOV wyj, bL;
	}
	*/

	/*
	a = 0x0F;
	_asm {
		MOV AL, a;
		MOV BL, 0;

		AND AL, 0x01;
		ADD BL, AL;

		MOV AL, a;
		SHR AL, 1;
		AND AL, 0x01;
		ADD BL, AL;
		// zrob 8 razy

		MOV wyj, BL;

	}
	*/

	// if a > 5, y=0;
	//	  czyli dla  6, 7 ,8
	//	  a< 6 , y=1
	a = 0x06;
	_asm {
		MOV AL, a;
		MOV wyj, 0;
		ADD Al, 0xFA;
		JNC et
			MOV wyj, 1;
		et:

	}

	printf("\t%x\n\t%d\n\n", wyj, wyj);


    return 0;
}

