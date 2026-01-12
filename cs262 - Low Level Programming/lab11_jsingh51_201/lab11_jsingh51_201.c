#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define BYTETOBINARYPATTERN " %d%d%d%d%d%d%d%d"
#define BYTETOBINARY(byte)     \
    (byte & 0x80 ? 1 : 0),     \
        (byte & 0x40 ? 1 : 0), \
        (byte & 0x20 ? 1 : 0), \
        (byte & 0x10 ? 1 : 0), \
        (byte & 0x08 ? 1 : 0), \
        (byte & 0x04 ? 1 : 0), \
        (byte & 0x02 ? 1 : 0), \
        (byte & 0x01 ? 1 : 0)
#define PRINTBIN(x) printf(BYTETOBINARYPATTERN, BYTETOBINARY(x));

void setlsbs(unsigned char *p, unsigned char b0)
{
    for (int i = 0; i < 8; i++)
    {
        unsigned char x = b0;
        x = x >> i;
        x = x & 1;

        p[i] = p[i] | x;
        if (x == 0 && p[i] % 2 == 1)
            p[i]--;
    }
}

unsigned char getlsbs(unsigned char *p)
{
    unsigned char x = 0;
    for (int i = 0; i < 8; i++)
    {
        x += pow(2, i) * (p[i] % 2);
    }
    return x;
}

void printAll(unsigned char *p, unsigned char b0)
{
    printf("P(decimal): [");
    for (int i = 0; i < 8; i++)
    {
        printf(" %d", p[i]);
    }
    printf(" ]\n");

    printf("P(binary): [");
    for (int i = 0; i < 8; i++)
    {
        PRINTBIN(p[i]);
    }
    printf(" ]\n");

    printf("Byte0(decimal): %d\n", b0);
    printf("Byte0(binary): ");
    PRINTBIN(b0);
    printf("\n\n");
}

int main(int argc, char *argv[])
{

    if (argc < 2)
    {
        printf("Not enough args\n");
        exit(-1);
    }

    int seed;
    unsigned char *p = malloc(sizeof(unsigned char));
    sscanf(argv[1], "%d", &seed);
    srand(seed);

    for (int i = 0; i < 8; i++)
    {
        p[i] = rand() % 256;
    }
    unsigned char b0 = rand() % 256;
    
    printf("UNMODIFIED: ");
    printAll(p, b0);

    setlsbs(p, b0);
    printf("MODIFIED: ");
    printAll(p, b0);

    unsigned char B0 = getlsbs(p);
    printf("Original B0: %d\n", b0);
    printf("Decoded B0:  %d\n", B0);

    free(p);
}