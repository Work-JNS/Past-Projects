/*

*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define seqLEN 34
#define headerLEN 9
#define dataLEN 5

// Writing Functions:

// write sequence to file
void output_sequence(FILE *output, int *seq, int seqNum)
{
    fprintf(output, "Sequence %d: ", seqNum);
    for (int i = 0; i < seqLEN; i++)
    {
        fprintf(output, "%d ", seq[i]);
    }
    fprintf(output, "\n");
}

// write header to file
void output_header(FILE *output, int *header)
{
    fprintf(output, "       Header:\n              ");
    for (int i = 0; i < headerLEN; i++)
    {
        fprintf(output, "%d ", header[i]);
    }
    fprintf(output, "\n");
}

// write Data to file in 2d array format
void output_data(FILE *output, int **data)
{
    fprintf(output, "       Data: \n");

    for (int i = 0; i < dataLEN; i++) // CHANGE MAX VALs IF NEEDED
    {
        fprintf(output, "              ");
        if (i == 4)
            fprintf(output, "--------+--\n              ");

        for (int j = 0; j < dataLEN; j++)
        {
            if (j == 4)
                fprintf(output, "| ");
            fprintf(output, "%d ", data[i][j]);
        }
        fprintf(output, "\n");
    }
}

// write id to file
void output_id(FILE *output, int ID)
{
    fprintf(output, "       Value: \n              %d\n", ID);
}

// write color to file
void output_color(FILE *output, char *color)
{
    fprintf(output, "       Color: \n              %s\n\n", color);
}

// Create Functions:

// reads 1 line from a file, converts to int* of 0s & 1s
int *create_sequence(FILE *input)
{
    // initilize vars
    char buff[seqLEN * 2];
    buff[0] = '!';
    int *seq = (int *)malloc(seqLEN * sizeof(int));
    int j = 0;

    // get Line
    fgets(buff, sizeof(buff), input);

    // mem check
    if (seq == NULL)
    {
        printf("Error: Out of Memory.\n");
        exit(4);
    }
    // convert char[] to int[]
    for (int i = 0; i < strlen(buff); i++)
    {
        if (buff[i] == 48)
        {
            seq[j] = 0;
            j++;
        }
        else if (buff[i] == 49)
        {
            seq[j] = 1;
            j++;
        }
    }
    // clear the intermeidary garbage line that ruins everything
    fgets(buff, sizeof(buff), input);
    // return int*
    return seq;
}

// isolate header of sequence
int *create_header(int *seq)
{
    // allocate mem
    int *header = malloc(sizeof(int[9]));
    // mem check
    if (header == NULL)
    {
        printf("Error: Out of Memory.\n");
        exit(4);
    }
    for (int i = 0; i < headerLEN; i++)
    {
        header[i] = seq[i];
    }

    return header;
}

// loop last 25 vals of seq and set to array
int **create_data(int *seq)
{
    // allocate array
    int **data = (int **)malloc(dataLEN * sizeof(int *));
    // mem check
    if (data == NULL)
    {
        printf("Error: Out of Memory.\n");
        exit(4);
    }
    // mem allocat & check for rows
    for (int i = 0; i < dataLEN; i++)
    {
        data[i] = malloc(sizeof(int[dataLEN]));
        if (data[i] == NULL)
        {
            printf("Error: Out of Memory.\n");
            exit(4);
        }
    }

    int c = 9;
    // populate data
    for (int i = 0; i < dataLEN; i++)
    {
        for (int j = 0; j < dataLEN; j++)
        {
            data[i][j] = seq[c];
            c++;
        }
    }

    return data;
}

// Validation Functions:

// ret 1 if valid, 0 if invalid
int validate_row(int **data, int row)
{
    int parity = 0;
    for (int i = 0; i < 4; i++)
    {
        parity += data[row][i];
    }

    parity = parity % 2;

    if (parity == data[row][4])
        return 1;
    return 0;
}
// ret 1 if valid, 0 if invalid
int validate_col(int **data, int col)
{
    int parity = 0;
    for (int i = 0; i < 4; i++)
    {
        parity += data[i][col];
    }

    parity = parity % 2;

    if (parity == data[4][col])
        return 1;
    return 0;
}
// ret 1 if valid, 0 if invalid
int validate_data(int **data)
{
    for (int i = 0; i < dataLEN - 1; i++)
    {
        if (validate_row(data, i) == 0)
        {
            return 0;
        }
        if (validate_col(data, i) == 0)
        {
            return 0;
        }
    }

    if (data[4][4] != 0)
        return 0;

    return 1;
}
// ret 1 if valid, 0 if invalid
int validate_header(int *header)
{
    for (int i = 0; i < headerLEN; i++)
    {
        if (header[i] != 1)
            return 0;
    }
    return 1;
}
// ret 1 if valid, 0 if invalid
int validate_sequence(int *header, int **data)
{

    if (validate_header(header) == 1 && validate_data(data) == 1)
        return 1;

    return 0;
}

// returns ID val
int compute_id(int **data)
{
    // creates id from data vals
    int id = 0;
    int c = 15;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            id += data[i][j] * pow(2, c);
            c--;
        }
    }

    // references valid ids returns -1 if invalid
    switch (id)
    {
    case 3072:
    case 3076:
    case 3083:
    case 3085:
    case 3086:
    case 3087:
    case 3123:
        return id;
        break;
    default:
        return -1;
    }
}

// retruns color string
char *get_color(int id)
{
    // checks id to color library
    switch (id)
    {
    case 3072:
        return "White";
        break;
    case 3076:
        return "Green";
        break;
    case 3083:
        return "Yellow";
        break;
    case 3085:
        return "Red";
        break;
    case 3086:
        return "Blue";
        break;
    case 3087:
        return "Purple";
        break;
    case 3123:
        return "Black";
        break;
    default:
        return "Invalid";
        break;
    }
}

// Management Functions:

// frees a 2d array
void free_data(int **data)
{
    // frees each col
    for (int i = 0; i < 5; i++)
    {
        int *curPtr = data[i];
        free(curPtr);
    }
    // frees overall data array
    free(data);
}

// frees all allocated arrays
void free_arrays(int **data, int *seq, int *header)
{
    free(seq);
    free(header);
    free_data(data);
}

// Main
int main(int argc, char *argv[])
{
    // Verify if input file argument
    if (argc != 2)
    {
        printf("Error: You must specify an input filename: ./p2_jsingh51_201 <input_file>\n");
        exit(1);
    }

    // Initilize files vars
    FILE *input = fopen(argv[1], "r");
    char *outName = strtok(argv[1], ".");
    strcat(outName, ".out");
    int *sequence;
    int *header;
    int **data;
    int id, ln = 1;
    char *color;

    // Verify if Files are open
    if (!input)
    {
        printf("Error: Could not open %s for reading.\n", argv[1]);
        exit(2);
    }
    
    FILE *output = fopen(outName, "w");
    if (!output)
    {
        printf("Error: Could not open %s for writing.\n", outName);
        exit(3);
    }

    // do operation process until EOF
    do
    {
        sequence = create_sequence(input);
        header = create_header(sequence);
        data = create_data(sequence);

        output_sequence(output, sequence, ln);
        output_header(output, header);
        output_data(output, data);

        int valid = validate_sequence(header, data);
        if (valid == 1)
            id = compute_id(data);

        else
            id = -1;
        output_id(output, id);

        color = get_color(id);
        output_color(output, color);

        free_arrays(data, sequence, header);
        id = 0;
        ln++;
    } while (feof(input) == 0);

    // close files
    fclose(input);
    fclose(output);
    printf("Decoding Completed, written to %s\n", outName);
    return 0;
}
