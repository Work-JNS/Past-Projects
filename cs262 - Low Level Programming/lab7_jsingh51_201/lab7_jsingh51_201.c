/*
    Jared Singh, G01416039
    CS 262, Lab Section 201
    Lab7

    Takes a formatted input file from CLA & a filename for output
    formats and writes to output file

*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    char buffer[50];
    int ln;

    // Incorrect File Errors
    if (argc < 3)
    {
        printf("Incorrect number of files\n");
        exit(1);
    }

    FILE *input = fopen(argv[1], "r");
    FILE *output = fopen(argv[2], "w");

    //Checks if files are open
    if (input == NULL || output == NULL)
    {
        printf("file opening error");
        exit(1);
    }

    // get line num
    fgets(buffer, 50, input);
    sscanf(buffer, "%d", &ln);

    char Data[ln][6][20];
    char nm[20];
    char lnm[10];

    // read data from file
    for (int i = 0; i < ln; i++)
    {
        fgets(buffer, 50, input);
        sscanf(buffer, "%s %s %s %s %s %s %s", Data[i][0], nm, lnm,
               Data[i][2], Data[i][3], Data[i][4], Data[i][5]);

        strcat(nm, " ");
        lnm[strlen(lnm) - 1] = '\0';
        strcat(nm, lnm);
        strcpy(Data[i][1], nm);
    }
    fclose(input);

    // format Data
    for (int i = 0; i < ln; i++)
    {
        char temp[20];
        // Name to pos1, gnum to pos2
        strcpy(temp, Data[i][0]);
        strcpy(Data[i][0], Data[i][1]);
        strcpy(Data[i][1], temp);

        // Semester to pos6, Grade to pos3
        strcpy(temp, Data[i][2]);
        strcpy(Data[i][2], Data[i][5]);
        strcpy(Data[i][5], temp);
    }

    // write data
    for (int i = 0; i < ln; i++)
    {
        fprintf(output, "%-20s", Data[i][0]);
        fprintf(output, "%-10s", Data[i][1]);
        fprintf(output, "%-8.2f", atof(Data[i][2]));
        fprintf(output, "%-10s", Data[i][3]);
        fprintf(output, "%-3s", Data[i][4]);
        fprintf(output, "%-3s\n", Data[i][5]);
    }
}
