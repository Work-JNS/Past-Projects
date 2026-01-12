/*
Jared Singh, G01416039
CS 262, Lab Section 201
Lab6

Takes 2 ints from commandline, makes array, shuffles then sorts
displays all steps

*/

#include <stdio.h>
#include <stdlib.h>

// Comparisson for qsort()
int cmpInt(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}

// prints int array in [ a b c ] format
void printIntArr(int *arr, int size)
{
    printf("[ ");
    for (int i = 0; i < size; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("]");

    printf("\n\n");
}

// shuffles an int array
void PerfectShuffle(int *numArr, int size)
{

    for (int i = size - 1; i >= 1; i--)
    {
        int temp = numArr[i];
        int j = rand() % i;
        numArr[i] = numArr[j];
        numArr[j] = temp;
    }
}

// fills an int array with 1-size
void InitArray(int *numArr, int size)
{
    for (int i = 0; i < size; i++)
    {
        numArr[i] = i + 1;
    }
}

// checks if size is valid, then allocates memory
void getMemory(int *numArr, int size)
{

    if (size > 500 || size < 2)
    {
        printf("Invalid size: Quitting...");
        exit(-1);
    }
    numArr = malloc(sizeof(int) * size);

    if (numArr == NULL)
    {
        printf("Memory Allocation Error: Quitting...\n");
        exit(-1);
    }
}

int main(int argc, char *argv[])
{
    // Check validity of Args
    if (argc < 2)
    {
        printf("Invalid Arguments: Quitting...\n");
        exit(-1);
    }

    // Set rand seed & Size vars from CLA
    srand(atoi(argv[1]));
    int size = atoi(argv[2]);
    int *numArr;
    getMemory(numArr, size);

    printf("**********\n1-%d arrays will generated, randomized, sorted and displayed 10 times:\n", size);

    // loops 10 times
    for (int i = 0; i < 10; i++)
    {
        printf("----------\n");

        InitArray(numArr, size);
        printf("Initilized Array: ");
        printIntArr(numArr, size);

        PerfectShuffle(numArr, size);
        printf("Shuffled Array: ");
        printIntArr(numArr, size);

        qsort(numArr, size, sizeof(int), cmpInt);
        printf("Sorted Array: ");
        printIntArr(numArr, size);

        printf("----------\n\n");
    }
    printf("**********");

    free(numArr);
}

