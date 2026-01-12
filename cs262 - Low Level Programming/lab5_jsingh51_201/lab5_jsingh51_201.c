/*
    Jared Singh, G01416039
    CS 262, Lab Section 201
    Lab 5

    Creates a movie title given an input

*/

#include <stdio.h>
#include <string.h>
#define SIZE 20
#define WSIZE 50

// copy a specifc string into adjective given a char
void get_adjective(char letter, char adjective[])
{
    if (letter > 64 && letter < 70)
        strcpy(adjective, "The awesome ");
    else if (letter > 69 && letter < 75)
        strcpy(adjective, "The funny ");
    else if (letter > 74 && letter < 80)
        strcpy(adjective, "The dangerous ");
    else if (letter > 79 && letter < 85)
        strcpy(adjective, "The lovely ");
    else
        strcpy(adjective, "The electrifying ");
    return;
}
// copy a specific string into subject given an int coresponding to the month
void get_subject(int month, char subject[])
{
    if (month < 3)
        strcpy(subject, "biography ");
    else if (month < 6)
        strcpy(subject, "revenge ");
    else if (month < 9)
        strcpy(subject, "battle ");
    else if (month < 13)
        strcpy(subject, "fairy tale ");
}
// copy a specific string to a complement given an int
void get_complement(int digit, char complement[])
{

    if (digit < 2)
        strcpy(complement, "of a movie star");
    else if (digit < 4)
        strcpy(complement, "of a hero");
    else if (digit < 6)
        strcpy(complement, "of a jedi");
    else if (digit < 8)
        strcpy(complement, "of an ogre");
    else
        strcpy(complement, "of a dreamer");
}

int main()
{

    // define variables
    char adjective[SIZE], subject[SIZE], complement[SIZE], movieTitle[WSIZE] = "";
    char buffer[4], month[4];
    char lnChar, quit;
    int digit;
    short run = 1, valid = 1;

    printf("*** Welcome to the Title Movie creator program ***\n");

    while (run == 1)
    {
        printf("\n");

        // get adjective
        do
        {
            valid = 1;
            printf("enter the first Letter of your Last name [a-z]: ");
            // get char input
            fgets(buffer, 5, stdin);
            sscanf(buffer, "%c", &lnChar);

            // set to upper case
            if (lnChar > 96 && lnChar < 123)
                lnChar = lnChar - 32;

            // send uppercase letter through method
            if (lnChar > 64 && lnChar < 91)
                get_adjective(lnChar, adjective);
            else // invalid input case
            {
                valid = 0;
                printf("invalid input, please ");
            }

        } while (valid == 0);          // loop if input not valid
        strcat(movieTitle, adjective); // cat adj to movie titel

        // get subject
        do
        {
            valid = 0;
            printf("enter your birth month [JAN|FEB|...|DEC]: ");
            // get input
            fgets(buffer, 5, stdin);
            sscanf(buffer, "%s", month);

            // send input to uppercase
            {
                for (int i = 0; i < sizeof(month); i++)
                {
                    if (month[i] > 96 && month[i] < 123)
                        month[i] = month[i] - 32;
                }
            }
            // compare input to month & stor cmp val in int[]
            int cv[13];
            cv[0] = strcmp("JAN", month);
            cv[1] = strcmp("FEB", month);
            cv[2] = strcmp("MAR", month);
            cv[3] = strcmp("APR", month);
            cv[4] = strcmp("MAY", month);
            cv[5] = strcmp("JUN", month);
            cv[6] = strcmp("JUL", month);
            cv[8] = strcmp("AUG", month);
            cv[9] = strcmp("SEP", month);
            cv[10] = strcmp("OCT", month);
            cv[11] = strcmp("NOV", month);
            cv[12] = strcmp("DEC", month);

            // search int[] for 0
            for (int i = 0; i < 13; i++)
            {
                if (cv[i] == 0)
                {
                    get_subject(i, subject); // send int coresponding to month
                    valid = 1;               // valid flag
                    break;                   // exit for loop
                }
            }

            if (valid == 0)
            {
                printf("invalid input, please ");
            }

        } while (valid == 0);

        strcat(movieTitle, subject); // cat subject to movie title

        // get complement
        do
        {

            valid = 1;
            printf("enter the Last digit of your phone number [0-9]: ");
            // get input
            fgets(buffer, 5, stdin);
            sscanf(buffer, "%d", &digit);

            // check for valid input
            if (digit < 10 && digit > -1)
                get_complement(digit, complement);
            else
            {
                valid = 0;

                printf("invalid input, please ");
            }

        } while (valid == 0);

        strcat(movieTitle, complement); // cat complement to movie title

        printf("\nThe Movie Title for your life is:\n   %s%s\n", adjective, movieTitle); // display title

        printf("Do you want to quit [Y|y]? "); // quit prompt
        // get input
        fgets(buffer, 3, stdin);
        sscanf(buffer, "%c", &quit);

        if (quit == 'y' || quit == 'Y') // if y or Y quit
            run = 0;
    }
}