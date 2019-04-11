#include "EasyBMP.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

using namespace std;

void bmpToGray(BMP Input, BMP &Output, int picWidth, int picHeight)
{
	for (int i = 0; i < picWidth; ++i)
		for (int j = 0; j < picHeight; ++j) {

			Output(i,j)->Red = 0.2126*Input(i,j)->Red + 0.7152*Input(i,j)->Green + 0.0722*Input(i, j)->Blue;
			Output(i,j)->Blue = 0.2126*Input(i,j)->Red + 0.7152*Input(i,j)->Green + 0.0722*Input(i, j)->Blue;
			Output(i,j)->Green = 0.2126*Input(i,j)->Red + 0.7152*Input(i,j)->Green + 0.0722*Input(i,j)->Blue;
	}
}

int main( int argc, char* argv[] )
{
double czas=0;
BMP Input;
Input.ReadFromFile("in.bmp");
BMP Output;
int picWidth = Input.TellWidth();
int picHeight = Input.TellHeight();
Output.SetSize( Input.TellWidth() , Input.TellHeight() );
Output.SetBitDepth(24);

clock_t begin=clock(), end;
bmpToGray(Input, Output, picWidth, picHeight);
end=clock();
czas=(double)(end-begin)/CLOCKS_PER_SEC;
printf("Czas obliczen na CPU = %.9f sekund\n", czas);
Output.WriteToFile("in2.bmp");
return 0;
}
