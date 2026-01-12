/*
	Jared Singh, G01416039
	CS 262, Lab Section 201
	Project 3

	CS262 shell

*/

#include "fork.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#define LINESIZE 10000

// frees all memory in a command
Command *freeNode(Command *node)
{
	free(node->command);
	for (int i = 0; i < node->arguments_length + 1; i++)
	{
		free(node->arguments[i]);
	}
	free(node->arguments);
	free(node);
	return NULL;
}

// formats char* to Command - Works
Command *makeCommand(char line[], int histSize)
{
	// create cmd pointer
	Command *cmd = malloc(sizeof(Command));
	int argc = 0;

	// init size & max args len
	cmd->next = NULL;
	cmd->index = histSize;

	cmd->arguments = malloc(sizeof(char *) * MAX_ARGS);

	char *temp = strtok(line, " ");

	while (temp != NULL)
	{
		if (argc < MAX_ARGS)
		{
			// init & populate each arg
			if (temp != NULL)
			{
				cmd->arguments[argc] = malloc(sizeof(char) * strlen(temp) + 1);
				strcpy(cmd->arguments[argc], temp);
				temp = strtok(NULL, " ");
				argc++;
			}
		}
		else
		{
			// if args exceeded - print err & free cmd
			fprintf(stderr, "error: %s\n", "too many arguments");
			freeNode(cmd);
			return NULL;
		}
	}
	// final population of command struct
	cmd->arguments_length = argc;

	cmd->command = malloc(sizeof(char) * (strlen(cmd->arguments[0]) + 1));
	strcpy(cmd->command, cmd->arguments[0]);

	// ret pointer
	return cmd;
}

// cd /directory/
void cDir(char *Dir)
{
	// make directory immutable
	char dir[40];
	sprintf(dir, "%s", Dir);
	// run chdir & print err
	if (chdir(dir) != 0)
	{
		perror("error");
	}
}

// works
Command *addHistory(Command *cmd, Command *histHead)
{
	// init history
	if (histHead == NULL)
	{
		return cmd;
	}
	// append cmd to hist
	Command *temp = histHead;

	while (temp->next != NULL)
	{
		temp = temp->next;
	}
	temp->next = cmd;
	return histHead;
}

// history -c - Works
Command *clrHist(Command *histHead)
{
	// quit if no hist
	if (histHead == NULL)
		return NULL;

	// free all nodes in history
	Command *prev = histHead;
	histHead = histHead->next;
	while (histHead != NULL)
	{
		prev = freeNode(prev);

		prev = histHead;
		histHead = histHead->next;
	}
	prev = freeNode(prev);
	return NULL;
}

// history - works
void printHist(Command *histHead)
{
	// print all nodes in history
	Command *temp = histHead;
	while (temp != NULL)
	{
		// print command
		printf("%d: %s ", temp->index, temp->command);
		// print args
		for (int i = 1; i < temp->arguments_length + 1; i++)
		{
			if (temp->arguments[i] != NULL)
				printf("%s", temp->arguments[i]);
		}
		printf("\n");
		temp = temp->next;
	}
}

// history %d - works
Command *repHist(Command *histHead, int index, int histCount)
{

	Command *temp = histHead;

	// get temp to index
	for (int i = 0; i < histCount + 1; i++)
	{

		if (i == index)
		{
			// reconstruct full cmd line
			char *x = malloc(sizeof(char) * LINESIZE);
			strcpy(x, temp->command);
			for (int i = 1; i < temp->arguments_length + 1; i++)
			{
				strcat(x, temp->arguments[i]);
			}
			// parse command
			Command *cmd = makeCommand(x, histCount + 1);
			// free alloc arr
			free(x);
			// ret new func
			return cmd;
		}
		temp = temp->next;
	}

	// if index out of bounds
	printf("Invalid Index: %d", index);
	return NULL;
}

int main()
{

	// int vars
	Command *head = NULL;
	Command *cmd = NULL;
	int histSize = 0;
	int histCall = 0;
	char line[LINESIZE];

	printf("262$");

	// get input
	while (fgets(line, LINESIZE, stdin) != NULL)
	{

		histCall = 0;
		fflush(stdout);
		// remove \n
		if (strlen(line) > 1)
			line[strlen(line) - 1] = '\0';

		// parse command
		cmd = makeCommand(line, histSize);

		if (strcmp(cmd->arguments[0], "history") == 0)
		{

			if (cmd->arguments_length > 1)
			{
				int index;

				if (strcmp(cmd->arguments[1], "-c") == 0)
				{
					//clr hist & reset mangement vars
					head = clrHist(head);
					histSize = 0;
					head = NULL;
					cmd = freeNode(cmd);
					histCall = 1;
				}
				else if (sscanf(cmd->arguments[1], "%d", &index) != 0)
				{
					//repeat command from history
					cmd = freeNode(cmd);
					cmd = repHist(head, index, histSize);
				}
			}
			else
			{
				//print history
				printHist(head);
				cmd = freeNode(cmd);
				histCall = 1;
			}
		}
		if (histCall != 1)
		{
			//add cmd to history if not a history call
			head = addHistory(cmd, head);
			histSize++;

			//cd case
			if (strcmp(cmd->arguments[0], "cd") == 0)
			{
				cDir(cmd->arguments[1]);
			}
			//exit case
			else if (strcmp(cmd->arguments[0], "exit") == 0)
			{
				// EXIT
				clrHist(head);
				return 1;
			}
			else
			{
				//sys call functions
				if (cmd->command[0] != '/')
					system(cmd->command);
				else
					call_exe(cmd);
			}
		}

		printf("262$");
		
		//check Eof
		if (feof(stdin))
		{

			// EXIT
			head = clrHist(head);
			return 1;
		}
	}
	head = clrHist(head);
	return 1;
	// EXIT
}
