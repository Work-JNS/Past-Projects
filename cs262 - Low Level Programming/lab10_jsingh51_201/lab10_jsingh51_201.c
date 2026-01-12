#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Bday Bday;

struct Bday
{
    char name[50];
    int month, day, year;
    Bday *next;
};

// prompts input -> returns Bday* to newData
Bday *createData()
{

    char buff[50];
    Bday *newData = malloc(sizeof(Bday));
    int m = 0, d = 0, y = 0;

    printf("Name: ");
    fgets(buff, 50, stdin);
    buff[strlen(buff) - 1] = '\0';
    strcpy(newData->name, buff);

    // Get Input - Assume INT
    while (m < 1 || m > 12)
    {
        printf("Month of Birth: ");
        fgets(buff, 10, stdin);
        sscanf(buff, "%d", &m);
    }
    while (d < 1 || d > 31)
    {
        printf("Day of Birth: ");
        fgets(buff, 10, stdin);
        sscanf(buff, "%d", &d);
    }
    while (y < 1930 || y > 2022)
    {
        printf("Year of Birth: ");
        fgets(buff, 10, stdin);
        sscanf(buff, "%d", &y);
    }

    // Set Inputs to New Node
    newData->month = m;
    newData->day = d;
    newData->year = y;
    newData->next = NULL;

    return newData;
}

// ret 0 if diff
// ret 1 if same
int isSame(Bday *a, Bday *b)
{

    if (strcmp(a->name, b->name) == 0)
    {
        if (a->month == b->month)
        {
            if (a->day == b->day)
            {
                if (a->year == b->year)
                    return 1;
            }
        }
    }
    return 0;
}

// ret + if a comes first
// ret - if b comes first
// Ascending via month -> day -> year -> name
int comp(Bday *a, Bday *b)
{
    if (a->month < b->month)
        return 1;
    else if (a->month > b->month)
        return -1;
    if (a->day < b->day)
        return 1;
    else if (a->day > b->day)
        return -1;
    if (a->year < b->year)
        return 1;
    else if (a->year > b->year)
        return -1;
    int x = strcmp(a->name, b->name);
    if (x > 0)
        return 1;
    else
        return -1;
}

// takes head * & newData *
// adds & sorts newData in list if data not in list
int insertData(Bday **head, Bday *newData)
{
    // Init Head
    if (*head == NULL)
    {
        *head = newData;
        printf("################ Data Added ################\n");
        return 1;
    }

    Bday *current = *head;

    // Check if newData in List
    while (current->next != NULL)
    {
        if (isSame(current, newData) == 1)
        {
            printf("################ Data Already Exists ################\n");
            return -1;
        }

        current = current->next;
    }

    current = *head;
    Bday *prev = NULL;

    // Find location to Insert
    while (current != NULL && comp(current, newData) > 0)
    {
        prev = current;
        current = current->next;
    }

    // Replace head Case
    if (prev == NULL)
    {
        newData->next = *head;
        *head = newData;
        printf("################ Data Added ################\n");
        return 1;
    }

    // Other casses
    newData->next = prev->next;
    prev->next = newData;
    printf("################ Data Added ################\n");

    return 1;
}

Bday *deleteHead(Bday **head)
{
    Bday *temp = *head;
    return temp;
}
// removes data from list
// ret pointer to removed Data
// ret NULL if data does not exist
Bday *deleteData(Bday *head, Bday *data)
{
    if (head == NULL){
        return NULL;
    }

    if (isSame(head, data) == 1)
    {
        free(data);
        return deleteHead(&head);
    }

    Bday *current = head->next;
    Bday *prev = head;

    while (current != NULL)
    {
        if (isSame(current, data) == 1)
        {
            free(data);
            prev->next = current->next;
            return current;
        }

        prev = current;
        current = current->next;
    }

    return NULL;
}

// print linked list in specified format
void printList(Bday *head, int size)
{
    Bday *temp = head;
    printf("\n************ List content ************\n");
    if (temp != NULL || size != 0)
    {
        while (temp != NULL)
        {
            printf("%.2d/%.2d/%.4d  %s\n", temp->month, temp->day, temp->year, temp->name);
            temp = temp->next;
        }
    }
    else
        printf("################ Nothing to Print ################\n");

    printf("**************************************\n\n");
}

// print selection ment
void printMenu(int size)
{
    printf("************ Friends birthday list ************\n");
    printf("Friends in the list: %d\n", size);
    printf("    (1)  Insert Data\n");
    printf("    (2)  Delete Data\n");
    printf("    (3)  Print List\n");
    printf("    (4)  Quit\n");
    printf("***********************************************\n");
    printf("Enter your choice: ");
}

// frees all nodes in Bday List
void freeList(Bday *head)
{
    Bday *temp = NULL;
    while (head->next != NULL)
    {
        temp = head;
        head = head->next;
        free(temp);
    }
    free(head);
    printf("Memory Freed\n");
}

int main()
{
    Bday *head = NULL;
    int size = 0;
    int option = 0;
    char buffer[50];

    while (option != 4)
    {
        // get & verif input
        printMenu(size);
        fgets(buffer, 50, stdin);
        sscanf(buffer, "%d", &option);
        while (option < 1 || option > 4)
        {
            printf("Invalid choice, try again: ");
            fgets(buffer, 50, stdin);
            sscanf(buffer, "%d", &option);
        }

        // Responses to valid input

        if (option == 1)
        {
            printf("\n*** Insert Data ***\n");
            int x = 0;

            Bday *newData = createData();
            x = insertData(&head, newData);

            if (x > 0)
            {
                size++;
            }
            printf("*******************\n\n");
        }
        else if (option == 2)
        {

            printf("\n*** Delete Data ***\n");
            // Null check
            if (head == NULL)
                printf("################ Nothing to Delete ################\n");
            else
            {
                // removal procedure
                Bday *data = createData();
                Bday *verif = deleteData(head, data);

                if (verif == NULL)
                    printf("################ Data Does Not Exist ################\n");
                else
                {

                    printf("################ Data Deleted ################\n");
                    free(verif);
                    head = head->next;
                    size--;
                }
            }
            printf("*******************\n\n");
        }
        else if (option == 3)
            printList(head, size);
    }

    if (head != NULL)
        freeList(head);
    else
        printf("No Memory Allocated\n");

    return 1;
}
