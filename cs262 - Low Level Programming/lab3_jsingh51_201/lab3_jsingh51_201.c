#include <stdio.h>
void printMenu(int size, char pen)
{

	printf("\n----MENU----\n");
	printf("\nCurrent Pen: %c\n", pen);
	printf("Current size: %d\n\n", size);
	printf("Enter c/C to change pen\n");
	printf("Enter n/N to change size\n");
	printf("Enter l/L to draw a line\n");
	printf("Enter s/S to draw a square\n");
	printf("Enter r/R to draw a rectangle\n");
	printf("Enter t/T to draw a triangle\n");
	printf("Enter q/Q to quit");
	printf("\n-------------\nUSER INPUT: ");
}

int setSize()
{

	char buff[10];
	int size;
	do
	{
		printf("\nenter a number between 1 & 15: ");

		fgets(buff, 10, stdin);
		sscanf(buff, "%d", &size);

		if (!(size > 0 && size < 16))
			printf("\nInvalid input, please ");
	} while (!(size > 0 && size < 16));

	return size;
}

char setPen()
{

	char in[10];
	char out;
	printf("\nenter a character: ");
	fgets(in, 10, stdin);
	sscanf(in, "%c", &out);
	return out;
}

void drawLn(int size, char pen)
{

	for (int i = 0; i < size; i++)
	{
		printf("\n%c", pen);
	}
	printf("\n");
}

void drawSqr(int size, char pen)
{

	printf("\n");

	for (int i = 0; i < size; i++)
	{

		for (int j = 0; j < size; j++)
		{
			printf("%c", pen);
		}
		printf("\n");
	}
}

void drawRect(int size, char pen)
{
	printf("\n");

	for (int i = 0; i < size; i++)
	{

		for (int j = 0; j < size + 5; j++)
		{
			printf("%c", pen);
		}
		printf("\n");
	}
}

void drawTri(int size, char pen)
{
	printf("\n");

	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < i + 1; j++)
		{
			printf("%c", pen);
		}
		printf("\n");
	}
}

int menu(int size, char pen)
{
	char buffer[10], choice;

	printMenu(size, pen);
	fgets(buffer, 3, stdin);
	sscanf(buffer, "%c", &choice);

	switch (choice)
	{

	case 'c':
	case 'C':
		return 1;
	case 'n':
	case 'N':
		return 2;
	case 'l':
	case 'L':
		drawLn(size, pen);
		break;
	case 's':
	case 'S':
		drawSqr(size, pen);
		break;
	case 'r':
	case 'R':
		drawRect(size, pen);
		break;
	case 't':
	case 'T':
		drawTri(size, pen);
		break;
	case 'q':
	case 'Q':
		return -1;
	default:
		printf("Invalid input\n");
	}

	return 3;
}

int main()
{

	int run = 0, size = 0;
	char pen = '\0';

	while (run != -1)
	{

		run = menu(size, pen);

		if (run == 1)
			pen = setPen();
		else if (run == 2)
			size = setSize();
	}
}
