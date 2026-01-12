/*
    Jared Singh, G01416039
    CS 262, Lab Section 201
    Lab 4

    prints all possible times of an analoge clock given an angle in degrees

*/

#include <stdio.h>
#include <stdlib.h>

void printTimes(int angleKey);

// Takes a number between 0 and 180 inclusive
int main()
{

    char buffer[10];
    int angleDeg;

    printf("Enter an angle(in degrees) between 0 and 180 inclusive: ");

    fgets(buffer, 4, stdin);
    sscanf(buffer, "%d", &angleDeg);

    if (angleDeg >= 0 && angleDeg <= 180)
        printTimes(angleDeg);
}

// Loops throgh all possible positions
// Calculates their angle
// If pos matches input, prints the hour and min to screen
void printTimes(int angleKey)
{
    printf("The times where the hands on a clock are: %d degrees apart are:\n", angleKey);
    int count = 0;

    for (int h = 1; h <= 12; h++)
    {

        for (int m = 0; m < 60; m++)
        {
            int hrsH = 30 * h;
            int minH = ((6 - 0.5) * m);
            int angleHands = abs(hrsH - minH);

            if (angleKey == angleHands || angleKey == (360 - angleHands))
            {
                printf("angle: %d/%d, time: ", angleHands, (360 - angleHands));
                count++;
                if (h == 0)
                    printf("12:");
                else
                    printf("%d:", h);

                if (m < 10)
                    printf("0%d\n", m);
                else
                    printf("%d\n", m);
            }
        }
    }

    if (count > 0)
        printf("There are %d times where the hands have a %d degree angle\n", count, angleKey);
    else
        printf("There are no hands with such a position");
}