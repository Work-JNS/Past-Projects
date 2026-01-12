#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
    int month, day, yr;
} DOB;

typedef struct
{
    int ID;
    char fname[24];
    char lname[24];
    DOB bday;
    double salary;

} Employee;

// Loop through all entries in a database
// Look for matching ID, return Index of match
// Not found return -1
int findEmployee(Employee *database, int ID, int size)
{

    for (int i = 0; i < size; i++)
    {
        if (database[i].ID == ID)
            return i;
    }

    return -1;
}

// Allocate new database with size+1
// Copy old entries to new database
// free old memory
// return address of new array
Employee *updateSize(Employee *database, int size)
{

    Employee *temp = (Employee *)malloc(sizeof(Employee) * (size + 1));

    if (temp == NULL)
    {
        printf("Out of Memory\n");
        exit(-1);
    }

    for (int i = 0; i < size; i++)
    {

        temp[i] = database[i];
    }
    free(database);
    return temp;
}

// Updates Employee Data
void updateData(Employee *database, int size)
{
    int choice;
    int index;
    int id;
    char buff[21];

    // prompt user until valid ID
    do
    {

        printf("enter a valid ID: ");
        fgets(buff, 20, stdin);
        sscanf(buff, "%d", &id);
        index = findEmployee(database, id, size);
        if (index == -1)
            printf("Invalid ID, ");

    } while (index == -1);

    // prompt user until valid input
    // on valid input, prompt user for coresponding data
    do
    {

        choice = -1;

        printf("Which data do you want to update?\n");
        printf("    1 - First Name\n");
        printf("    2 - Last Name\n");
        printf("    3 - Date of Birth\n");
        printf("    4 - Salary\n");
        printf("    5 - Do not update\n");

        fgets(buff, 4, stdin);
        sscanf(buff, "%d", &choice);

        if (choice < 1 || choice > 5)
            printf("Invalid Input:\n");

        else if (choice == 1)
        {
            printf("enter first name: ");
            fgets(buff, 20, stdin);
            sscanf(buff, "%s", database[index].fname);
        }

        else if (choice == 2)
        {
            printf("enter last name: ");
            fgets(buff, 20, stdin);
            sscanf(buff, "%s", database[index].lname);
        }

        else if (choice == 3)
        {
            printf("enter a month of birth: ");
            fgets(buff, 4, stdin);
            sscanf(buff, "%d", &database[index].bday.month);

            printf("enter a day of birth: ");
            fgets(buff, 4, stdin);
            sscanf(buff, "%d", &database[index].bday.day);

            printf("enter a year of birth: ");
            fgets(buff, 6, stdin);
            sscanf(buff, "%d", &database[index].bday.yr);
        }

        else if (choice == 4)
        {
            printf("enter a new salary: ");
            fgets(buff, 20, stdin);
            sscanf(buff, "%lf", &database[index].salary);
        }

        else if (choice == 5)
            return;

    } while (choice < 1 || choice > 5);
}

// ASSUME size-1 is free
// append an employee to database
void makeEmployee(Employee *database, int size)
{
    char buff[50];
    int index;
    int id;

    // prompt until valid ID
    do
    {

        printf("enter a valid id: ");
        fgets(buff, 4, stdin);
        sscanf(buff, "%d", &id);

        index = findEmployee(database, id, size);

        if (index != -1)
            printf("Invalid ID, ");

    } while (index != -1);

    // Prompt for each field & set ID
    database[size - 1].ID = id;

    printf("enter first name: ");
    fgets(buff, 20, stdin);
    sscanf(buff, "%s", database[size - 1].fname);

    printf("enter last name: ");
    fgets(buff, 20, stdin);
    sscanf(buff, "%s", database[size - 1].lname);

    printf("enter month of birth: ");
    fgets(buff, 4, stdin);
    sscanf(buff, "%d", &database[size - 1].bday.month);

    printf("enter day of birth: ");
    fgets(buff, 4, stdin);
    sscanf(buff, "%d", &database[size - 1].bday.day);

    printf("enter year of birth: ");
    fgets(buff, 6, stdin);
    sscanf(buff, "%d", &database[size - 1].bday.yr);

    printf("enter a salary: ");
    fgets(buff, 50, stdin);
    sscanf(buff, "%lf", &database[size - 1].salary);
}

// print singlular employee data in specific format
void printEmployee(Employee employee)
{
    printf("*********************************************************\n");
    printf("    ID: %d\n", employee.ID);
    printf("    First Name: %s\n", employee.fname);
    printf("    Last Name: %s\n", employee.lname);
    printf("    Date of Birth: %.2d/%.2d/%.4d\n", employee.bday.month,
           employee.bday.day, employee.bday.yr);
    printf("    Salary: $%.2lf\n", employee.salary);
    printf("*********************************************************\n");
}

// print entire database of employees in specific format
void printDatabase(Employee *database, int size)
{

    printf("*********************************************************\n");
    printf("      ID    Name             DOB            Salary       \n");

    for (int i = 0; i < size - 1; i++)
    {
        char temp[50];

        strcpy(temp, database[i].fname);
        strcat(temp, " ");
        strcat(temp, database[i].lname);

        printf("      %.3d   %-15.16s  %.2d/%.2d/%.4d     %.2lf\n",
               database[i].ID, temp, database[i].bday.month, database[i].bday.day, database[i].bday.yr, database[i].salary);
    }
    printf("*********************************************************\n");
}

int main()
{
    // initilize vars
    int size = 1;
    Employee *database = (Employee *)malloc(sizeof(Employee) * (size));
    char option;

    // check memory
    if (database == NULL)
    {
        printf("Out of Memory\n");
        exit(-1);
    }
    // prompt user for inputs until quit
    while (option != 'q')
    {
        printf("Enter your choice:\n'i' - Insert data\n'u' - Update data\n's' - Search employee\n'p' - Print database\n'q' - Quit\nChoice: ");

        // get input
        option = getc(stdin);
        // clear \n char
        getc(stdin);

        // set to lower case
        if (option < 91)
        {
            option += 32;
        }

        // append new employee & update size
        if (option == 'i')
        {
            makeEmployee(database, size);
            database = updateSize(database, size);
            size++;
        }
        // update data of employee
        else if (option == 'u')
        {
            updateData(database, size);
        }
        // search and print a specific employee
        else if (option == 's')
        {

            int index;
            char buff[10];
            int getID;
            // prompt user until valid emlployee
            do
            {
                printf("enter a valid ID: ");
                fgets(buff, 10, stdin);
                sscanf(buff, "%d", &getID);
                index = findEmployee(database, getID, size);
                if (index != -1)
                    printEmployee(database[index]);
                else
                    printf("Invalid ID, ");

            } while (index == -1);
        }
        // print full database
        else if (option == 'p')
            printDatabase(database, size);
    }
    // free database
    free(database);
    return 0;
}
