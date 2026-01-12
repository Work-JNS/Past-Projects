/*
    Jared Singh, G01416039
    CS 262, Lab Section 201
    Project 1

    Character Soup

*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define SOUPSIZE 11


/*----- Menu Functions -----*/

// checks if an input is valid
//  return 1 if valid
//  print invalid & return 0 if invald
int is_Valid_Input(int input)
{
    if (input > 0 && input < 5)
        return 1;
    else
    {
        printf("Option %d, is not an option\n", input);
        return 0;
    }
}

// Prompts User for name
// continue prompting until valid input
// set rv pointer to name
void set_name(char *rv)
{
    short valid = 1;
    char name[26];

    // Gets name - Prompts user to input their name until name is < 25 chars & only letters
    do
    {
        if (valid != 1) // resets the valid check
        {
            valid = 1;
            name[0] = '\0';
        }

        printf("Please Enter Your Name: ");

        fgets(name, sizeof(name), stdin); // get a string input from the user

        for (int i = 0; i < strlen(name) - 1; i++) // check each index: if invalid: valid = 0 & reiterate while loop
        {
            int x = name[i];

            if (x >= 65 && x <= 90)
                continue;
            else if (x >= 97 && x <= 122)
                continue;
            else if (x == 32)
                continue;
            else
            {
                valid = 0;
                break;
            }
        }

    } while (valid != 1);

    strcpy(rv, name);
}

/*----- Soup Functions -----*/

// prints ACII code of a soup
void printSoupCode(char soup[])
{
    printf("[");
    for (int i = 0; i < SOUPSIZE - 1; i++)
    {
        printf("%d ", soup[i]);
    }
    printf("]\n");
}

// Returns # of matches and formats matches string
int calcPoints(char userSoup[], char gameSoup[], char *matches)
{
    int match = 0;
    for (int i = 0; i < SOUPSIZE - 1; i++)
    {
        if (userSoup[i] == gameSoup[i])
        {
            match++;
            matches[i] = 'X';
        }
    }
    return match;
}

// Soup Functions
void mixed_soup(char name[])
{
    char soup[SOUPSIZE], psoup[SOUPSIZE], csoup[SOUPSIZE];
    int pTotMtcScr = 0, pRndScr = 0, cTotMtcScr = 0, cRndScr = 0;
    int round = 1;

    printf("\n****************************\n*       Number Soup        *\n");
    printf("****************************\n");
    while (round < 11)
    {

        for (int i = 0; i < SOUPSIZE - 1; i++)
        {
            int valid = 1;
            // The first slot needs no check
            if (i < 1)
            {
                soup[i] = (rand() % (126 + 1 - 33)) + 33;
                psoup[i] = (rand() % (126 + 1 - 33)) + 33;
                csoup[i] = (rand() % (126 + 1 - 33)) + 33;
            }
            else
            {

                do
                {
                    // reset valid coutner
                    valid = 1;
                    // generate random int
                    soup[i] = (rand() % (126 + 1 - 33)) + 33;

                    // if int = prev entry
                    // if int = prev entry +/- 1, valid = 0
                    if ((soup[i - 1] == soup[i]) || (soup[i - 1] == soup[i] + 1) || (soup[i - 1] == soup[i] - 1))
                        valid = 0;

                } while (valid == 0);
                // SAME AS FIRST
                do
                {
                    valid = 1;
                    csoup[i] = (rand() % (126 + 1 - 33)) + 33;
                    if ((csoup[i - 1] == csoup[i]) || (csoup[i - 1] == csoup[i] + 1) || (csoup[i - 1] == csoup[i] - 1))
                        valid = 0;

                } while (valid == 0);
                // SAME AS FIRST
                do
                {
                    valid = 1;
                    psoup[i] = (rand() % (126 + 1 - 33)) + 33;
                    if ((psoup[i - 1] == psoup[i]) || (psoup[i - 1] == psoup[i] + 1) || (psoup[i - 1] == psoup[i] - 1))
                        valid = 0;

                } while (valid == 0);
            }
        }

        // Size doubles if I don't t=do this
        csoup[10] = '\0';
        psoup[10] = '\0';

        // Vars for interface
        char cMatches[SOUPSIZE] = "----------";
        char pMatches[SOUPSIZE] = "----------";
        int pMatch = 0;
        int cMatch = 0;

        // print scores and prompt continue

        printf("%s, match points: %d round points: %d\n", name, pTotMtcScr, pRndScr);
        printf("Computer, match points: %d round points: %d\n\n", cTotMtcScr, cRndScr);
        if (round == 1)
            printf("[Play]");
        else
            printf("[Contiune]");
        getchar(); // pauses until return is pressed

        // print current soup
        printf("\nRound: %d/10\nSoup: [%s]\nSoup Code: ", round, soup);
        printSoupCode(soup);
        printf("\n************************************\n");

        pMatch = calcPoints(psoup, soup, pMatches);

        // Player stats
        printf("%s's soup: [%s]\nSoup Code: ", name, psoup);
        printSoupCode(psoup);
        printf("Match: %d [%s]\n\n", pMatch, pMatches);

        cMatch = calcPoints(csoup, soup, cMatches);

        // Computer Stats
        printf("Computer's soup: [%s]\nSoup Code: ", csoup);
        printSoupCode(csoup);
        printf("Match: %d [%s]\n", cMatch, cMatches);

        // if tie +2 for both round score
        if (pMatch == cMatch)
        {
            cRndScr += 2;
            pRndScr += 2;
        }
        else if (pMatch > cMatch) // if player wins +5 to player round score
            pRndScr += 5;
        else // if computer wins
            cRndScr += 5;

        // add round matches to total match score
        pTotMtcScr += pMatch;
        cTotMtcScr += cMatch;
        // increment round
        round++;
    }
    // exit score and winner decalres
    int pTot = pTotMtcScr + pRndScr;
    int cTot = cTotMtcScr + cRndScr;
    printf("\n%s, score:%d \n     match points: %d round points: %d\n", name, pTot, pTotMtcScr, pRndScr);
    printf("\nComputer's, score:%d \n     match points: %d round points: %d\n", cTot, cTotMtcScr, cRndScr);
    if (cTot == pTot)
        printf("\nIt is a Tie");
    else if (cTot > pTot)
        printf("Computer Wins");
    else
        printf("%s Wins", name);
}
void alphabet_soup(char name[])
{
    char soup[SOUPSIZE], psoup[SOUPSIZE], csoup[SOUPSIZE];
    int pTotMtcScr = 0, pRndScr = 0, cTotMtcScr = 0, cRndScr = 0;
    int round = 1;

    printf("\n****************************\n*      Alphabet Soup       *\n");
    printf("****************************\n");
    while (round < 11)
    {

        for (int i = 0; i < SOUPSIZE - 1; i++)
        {
            int valid = 1;
            // The first slot needs no check
            if (i < 1)
            {
                soup[i] = (rand() % (90 + 1 - 65)) + 65;
                psoup[i] = (rand() % (90 + 1 - 65)) + 65;
                csoup[i] = (rand() % (90 + 1 - 65)) + 65;
            }
            else
            {

                do
                {
                    // reset valid coutner
                    valid = 1;
                    // generate random int
                    soup[i] = (rand() % (90 + 1 - 65)) + 65;

                    // if int = prev entry
                    // if int = prev entry +/- 1, valid = 0
                    if ((soup[i - 1] == soup[i]) || (soup[i - 1] == soup[i] + 1) || (soup[i - 1] == soup[i] - 1))
                        valid = 0;

                } while (valid == 0);
                // SAME AS FIRST
                do
                {
                    valid = 1;
                    csoup[i] = (rand() % (90 + 1 - 65)) + 65;
                    if ((csoup[i - 1] == csoup[i]) || (csoup[i - 1] == csoup[i] + 1) || (csoup[i - 1] == csoup[i] - 1))
                        valid = 0;

                } while (valid == 0);
                // SAME AS FIRST
                do
                {
                    valid = 1;
                    psoup[i] = (rand() % (90 + 1 - 65)) + 65;
                    if ((psoup[i - 1] == psoup[i]) || (psoup[i - 1] == psoup[i] + 1) || (psoup[i - 1] == psoup[i] - 1))
                        valid = 0;

                } while (valid == 0);
            }

            int upper = rand() % 2;
            if (upper == 1)
            {
                soup[i] += 32;
            }
            upper = rand() % 2;
            if (upper == 1)
            {
                psoup[i] += 32;
            }
            upper = rand() % 2;
            if (upper == 1)
            {
                csoup[i] += 32;
            }
        }

        // Size doubles if I don't do this
        csoup[10] = '\0';
        psoup[10] = '\0';

        // Vars for interface
        char cMatches[SOUPSIZE] = "----------";
        char pMatches[SOUPSIZE] = "----------";
        int pMatch = 0;
        int cMatch = 0;

        // print scores and prompt continue

        printf("%s, match points: %d round points: %d\n", name, pTotMtcScr, pRndScr);
        printf("Computer, match points: %d round points: %d\n\n", cTotMtcScr, cRndScr);
        if (round == 1)
            printf("[Play]");
        else
            printf("[Contiune]");
        getchar(); // pauses until return is pressed

        // print current soup
        printf("\nRound: %d/10\nSoup: [%s]\nSoup Code: ", round, soup);
        printSoupCode(soup);
        printf("\n************************************\n");

        pMatch = calcPoints(psoup, soup, pMatches);

        // Player stats
        printf("%s's soup: [%s]\nSoup Code: ", name, psoup);
        printSoupCode(psoup);
        printf("Match: %d [%s]\n\n", pMatch, pMatches);

        cMatch = calcPoints(csoup, soup, cMatches);

        // Computer Stats
        printf("Computer's soup: [%s]\nSoup Code: ", csoup);
        printSoupCode(csoup);
        printf("Match: %d [%s]\n", cMatch, cMatches);

        // if tie +2 for both round score
        if (pMatch == cMatch)
        {
            cRndScr += 2;
            pRndScr += 2;
        }
        else if (pMatch > cMatch) // if player wins +5 to player round score
            pRndScr += 5;
        else // if computer wins
            cRndScr += 5;

        // add round matches to total match score
        pTotMtcScr += pMatch;
        cTotMtcScr += cMatch;
        // increment round
        round++;
    }
    // exit score and winner decalres
    int pTot = pTotMtcScr + pRndScr;
    int cTot = cTotMtcScr + cRndScr;
    printf("\n%s, score:%d \n     match points: %d round points: %d\n", name, pTot, pTotMtcScr, pRndScr);
    printf("\nComputer's, score:%d \n     match points: %d round points: %d\n", cTot, cTotMtcScr, cRndScr);
    if (cTot == pTot)
        printf("\nIt is a Tie");
    else if (cTot > pTot)
        printf("Computer Wins");
    else
        printf("%s Wins", name);
}
void number_soup(char name[])
{
    char soup[SOUPSIZE], psoup[SOUPSIZE], csoup[SOUPSIZE];
    int pTotMtcScr = 0, pRndScr = 0, cTotMtcScr = 0, cRndScr = 0;
    int round = 1;

    printf("\n****************************\n*       Number Soup        *\n");
    printf("****************************\n");
    while (round < 11)
    {

        for (int i = 0; i < SOUPSIZE - 1; i++)
        {
            int valid = 1;
            // The first slot needs no check
            if (i < 1)
            {
                soup[i] = (rand() % (57 + 1 - 48)) + 48;
                psoup[i] = (rand() % (57 + 1 - 48)) + 48;
                csoup[i] = (rand() % (57 + 1 - 48)) + 48;
            }
            else
            {

                do
                {
                    // reset valid coutner
                    valid = 1;
                    // generate random int
                    soup[i] = (rand() % (57 + 1 - 48)) + 48;

                    // if int = prev entry
                    // if int = prev entry +/- 1, valid = 0
                    if ((soup[i - 1] == soup[i]) || (soup[i - 1] == soup[i] + 1) || (soup[i - 1] == soup[i] - 1))
                        valid = 0;

                } while (valid == 0);
                // SAME AS FIRST
                do
                {
                    valid = 1;
                    csoup[i] = (rand() % (57 + 1 - 48)) + 48;
                    if ((csoup[i - 1] == csoup[i]) || (csoup[i - 1] == csoup[i] + 1) || (csoup[i - 1] == csoup[i] - 1))
                        valid = 0;

                } while (valid == 0);
                // SAME AS FIRST
                do
                {
                    valid = 1;
                    psoup[i] = (rand() % (57 + 1 - 48)) + 48;
                    if ((psoup[i - 1] == psoup[i]) || (psoup[i - 1] == psoup[i] + 1) || (psoup[i - 1] == psoup[i] - 1))
                        valid = 0;

                } while (valid == 0);
            }
        }

        // Size doubles if I don't t=do this
        csoup[10] = '\0';
        psoup[10] = '\0';

        // Vars for interface
        char cMatches[SOUPSIZE] = "----------";
        char pMatches[SOUPSIZE] = "----------";
        int pMatch = 0;
        int cMatch = 0;

        // print scores and prompt continue

        printf("%s, match points: %d round points: %d\n", name, pTotMtcScr, pRndScr);
        printf("Computer, match points: %d round points: %d\n\n", cTotMtcScr, cRndScr);
        if (round == 1)
            printf("[Play]");
        else
            printf("[Contiune]");
        getchar(); // pauses until return is pressed

        // print current soup
        printf("\nRound: %d/10\nSoup: [%s]\nSoup Code: ", round, soup);
        printSoupCode(soup);
        printf("\n************************************\n");

        pMatch = calcPoints(psoup, soup, pMatches);

        // Player stats
        printf("%s's soup: [%s]\nSoup Code: ", name, psoup);
        printSoupCode(psoup);
        printf("Match: %d [%s]\n\n", pMatch, pMatches);

        cMatch = calcPoints(csoup, soup, cMatches);

        // Computer Stats
        printf("Computer's soup: [%s]\nSoup Code: ", csoup);
        printSoupCode(csoup);
        printf("Match: %d [%s]\n", cMatch, cMatches);

        // if tie +2 for both round score
        if (pMatch == cMatch)
        {
            cRndScr += 2;
            pRndScr += 2;
        }
        else if (pMatch > cMatch) // if player wins +5 to player round score
            pRndScr += 5;
        else // if computer wins
            cRndScr += 5;

        // add round matches to total match score
        pTotMtcScr += pMatch;
        cTotMtcScr += cMatch;
        // increment round
        round++;
    }
    // exit score and winner decalres
    int pTot = pTotMtcScr + pRndScr;
    int cTot = cTotMtcScr + cRndScr;
    printf("\n%s, score:%d \n     match points: %d round points: %d\n", name, pTot, pTotMtcScr, pRndScr);
    printf("\nComputer's, score:%d \n     match points: %d round points: %d\n", cTot, cTotMtcScr, cRndScr);
    if (cTot == pTot)
        printf("\nIt is a Tie");
    else if (cTot > pTot)
        printf("Computer Wins");
    else
        printf("%s Wins", name);
}

//
int menu()
{

    int input;
    char name[26], buffer[4];
    // Ensure the name is empty on first run
    name[strlen(name) - 1] = 0;

    short valid = 1;

    do
    {
        printf("\n*****************************\n");
        printf("* Welcome to Character Soup *\n");
        printf("*****************************\n");

        // If name != null setname
        if (name[0] == '\0')
            set_name(name);

        // remove a \n that appears
        if (name[strlen(name) - 1] == '\n')
            name[strlen(name) - 1] = 0;

        printf("\nPlayer Name: %s\n", name);

        printf("1) Mixed Soup\n2) Alphabet Soup\n3) Number Soup\n4) Quit\n");
        // menu selction
        do
        {
            printf("Select an Option: ");
            fgets(buffer, 3, stdin);
            sscanf(buffer, "%d", &input);

            valid = is_Valid_Input(input);
        } while (valid == 0);

        // input cases
        if (input == 4)
        {
            return 0;
        }
        else if (input == 1)
        {
            mixed_soup(name);
        }
        else if (input == 2)
        {
            alphabet_soup(name);
        }
        else if (input == 3)
        {
            number_soup(name);
        }

    } while (valid != -1);

    return 0;
}

int main()
{
    // SEED generator
    srand(time(NULL));
    return menu();
}
