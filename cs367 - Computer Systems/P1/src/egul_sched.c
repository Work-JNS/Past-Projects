/* This is the only file you will be editing.
 * - egul_sched.c (Egul Scheduler Library Code)
 * - Copyright of Starter Code: Prof. Kevin Andrea, George Mason University. All Rights Reserved
 * - Copyright of Student Code: You!  
 * - Copyright of ASCII Art: Modified from Joan Stark (jgs)'s work:
 * -- https://www.asciiart.eu/animals/birds-land
 * - Restrictions on Student Code: Do not post your code on any public site (eg. Github).
 * -- Feel free to post your code on a PRIVATE Github and give interviewers access to it.
 * -- You are liable for the protection of your code from others.
 * - Date: Aug 2024
 */

/* CS367 Project 1, Fall Semester, 2024
 * Fill in your Name, GNumber, and Section Number in the following comment fields
 * Name:
 * GNumber:
 * Section Number: CS367-00_             (Replace the _ with your section number)
 */

/* egul CPU Scheduling Library
                                                              __..-'
                                                        _.--''
                                              _...__..-'
                                            .'
                                          .'
                                        .'
                                      .'
           .------._                 ;
     .-"""`-.<')    `-._           .'
    (.--. _   `._       `'---.__.-'
     `   `;'-.-'         '-    ._ 
       .--'``  '._      - '   .   
        `""'-.    `---'    ,
''--..__      `\ 
        ``''---'`\      .'
             jgs  `'. '
                    `'.

*/
 
/* Standard Library Includes */
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
/* Unix System Includes */
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <pthread.h>
#include <sched.h>
/* Local Includes */
#include "egul_sched.h"
#include "strawhat_scheduler.h"
#include "strawhat_support.h"
#include "strawhat_process.h"

/* Feel free to create any definitions or constants you like! */

/* Feel free to create any helper functions you like! */

/* return 0 if a comes first
 * retrun -1 of b comes first
 * return 1 if a is critical
 */
int priorityComp(Egul_process_s* a, Egul_process_s* b){
	
	//is same
	if(a->pid == b->pid)
		return 0;
		
		
	
	//critical cases
	if(a->state > 0x8000)
		return 1;
	if(b->state > 0x8000)
		return -1;
	
	//starving cases
	if(a->age > STARVING_AGE)
		return 0;
	if(b->age > STARVING_AGE)
		return -1;
	if(a->priority > b->priority)
		return -1;
	
	return 0;
	
	
}

/*Deallocates a node*/
void deallocateNode(Egul_process_s* node){
	free(node->cmd);
	free(node);
}

/*Deallocates a queue*/
void deallocateQueue(Egul_queue_s*queue){
	
	//set tail to null
	queue->tail = NULL;
	Egul_process_s*next = queue->head;
	Egul_process_s*curr;
	
	//traverse list & free each node
	while(next!=NULL){
		curr = next;
		next = next->next;
		if(curr!=NULL)
			deallocateNode(curr);
	}
	
	//free the queue struct
	free(queue);
}

/*** Egul Library API Functions to Complete ***/
/* Initializes the Egul_schedule_s Struct and all of the Egul_queue_s Structs
 * Follow the project documentation for this function.
 * Returns a pointer to the new Egul_schedule_s or NULL on any error.
 */
Egul_schedule_s *egul_initialize() {
	

	Egul_schedule_s *schedule = (Egul_schedule_s *)malloc(sizeof(Egul_schedule_s));
	if(schedule == NULL)
		return NULL;
	schedule->ready_queue = (Egul_queue_s*)malloc(sizeof(Egul_queue_s));
	if(schedule->ready_queue == NULL)
		return NULL;
	
	schedule->suspended_queue = (Egul_queue_s*)malloc(sizeof(Egul_queue_s));
	if(schedule->suspended_queue == NULL)
		return NULL;
	
	schedule->terminated_queue = (Egul_queue_s*)malloc(sizeof(Egul_queue_s));
	if(schedule->terminated_queue == NULL)
		return NULL;
	
	return schedule;
}

/* Allocate and Initialize a new Egul_process_s with the given information.
 * - Malloc and copy the command string, don't just assign it!
 * Follow the project documentation for this function.
 * - You may assume all arguments within data are Legal and Correct for this Function Only
 * Returns a pointer to the Egul_process_s on success or a NULL on any error.
 */
Egul_process_s *egul_create(Egul_create_data_s *data) {
	
	//allocate mem & check
	Egul_process_s *process = (Egul_process_s*)malloc(sizeof(Egul_process_s));
	if(process == NULL)
		return NULL;
	//set crit 
	if(data->is_critical == 1)
		process->state = 0xC000;
	else
		process->state = 0x4000;
	
	//format data
	process->priority = data->priority_level;
	process->age = 0;
	process->pid = data->pid;
	process->cmd = (char*)malloc(sizeof(data->original_cmd));
	strncpy(process->cmd, data->original_cmd, MAX_CMD);
	process->next = NULL;
	
	return process;
	
}

/* Inserts a process into the Ready Queue (singly linked list).
 * Follow the project documentation for this function.
 * - Do not create a new process to insert, insert the SAME process passed in.
 * Returns a 0 on success or a -1 on any error.
 */
int egul_insert(Egul_schedule_s *schedule, Egul_process_s *process) {
	//if invalid process
	if(process == NULL || schedule->ready_queue == NULL)
		return -1;
	
	process->state = (process->state)&0x8000;
	process->state = (process->state)|0x4000;
	//init linked list
	if(schedule->ready_queue->count == 0){
		schedule->ready_queue->tail = process;
		schedule->ready_queue->head = process;
		schedule->ready_queue->count++;
		return 0;
	}
	//append using tail
	schedule->ready_queue->tail->next = process;
	schedule->ready_queue->tail = schedule->ready_queue->tail->next;
	schedule->ready_queue->count++;
	return 0;
	
	
}

/* Returns the number of items in a given Egul Queue (singly linked list).
 * Follow the project documentation for this function.
 * Returns the number of processes in the list or -1 on any errors.
 */
int egul_count(Egul_queue_s *queue) {
	if(queue ==NULL)
		return -1;
  return queue->count;
}

/* Selects the best process to run from the Ready Queue (singly linked list).
 * Follow the project documentation for this function.
 * Returns a pointer to the process selected or NULL if none available or on any errors.
 * - Do not create a new process to return, return a pointer to the SAME process selected.
 * - Return NULL if the ready queue was empty OR there were any errors.
 */
Egul_process_s *egul_select(Egul_schedule_s *schedule) {
	
	//NULL checks
	if(schedule == NULL || schedule->ready_queue == NULL)
		return NULL;
	Egul_process_s*node = schedule->ready_queue->head;
	if(node == NULL)
		return NULL;
	
	
	//find best process
	Egul_process_s*best = node;
	Egul_process_s*prev = NULL;
	while(node->next != NULL){
		int comp = priorityComp(best, node->next);
		if(comp == 1)
			break;
		if(comp == -1){
			prev = node;
			best = node->next;
		}
		
		//increment age & interate through list
		node->age++;
		node = node->next;
		
	}
	
	//remove best from list
	if(prev == NULL)
		schedule->ready_queue->head = best->next;
	else
		prev->next = best->next;
	
	if(best->pid == schedule->ready_queue->tail->pid)
		schedule->ready_queue->tail = prev;
	
	schedule->ready_queue->count--;
	
	
	//format best
	best->next = NULL;
	best->age = 0;
	best->state = (best->state^0x6000);
	
	return best;
	
		

	
}

/* Move the process with matching pid from Ready to Suspended Queue.
 * Follow the specification for this function.
 * Returns a 0 on success or a -1 on any error (such as process not found).
 */
int egul_suspend(Egul_schedule_s *schedule, pid_t pid) {
	
	Egul_process_s *search = schedule->ready_queue->head;
	Egul_process_s *prev = NULL;
	
	//nothing to suspend
	if(search == NULL)
		return -1;
	
	//look in ready if pid != 0
	if(pid != 0){
		
		
		while(search != NULL){
			if(search->pid == pid)
				break;
			prev = search;
			search = search->next;
		}
	}
	//if not found
	if(search == NULL)
		return -1;
	
	
	//remove from ready
	//head case
	if(pid == 0 || prev == NULL)
		schedule->ready_queue->head = schedule->ready_queue->head->next;
	else
		prev->next = search->next;
	
	
	
	//update count & tail if needed
	if(search->pid == schedule->ready_queue->tail->pid)
		schedule->ready_queue->tail = prev;
	schedule->ready_queue->count--;
	
	//format for suspended_queue
	search->next = NULL;
	search->state = search->state^0x5000;
	
	if(schedule->suspended_queue->count == 0){
		schedule->suspended_queue->head = search;
		schedule->suspended_queue->tail = search;
		
	}else{
		schedule->suspended_queue->tail->next = search;
		schedule->suspended_queue->tail = search;
	}
	schedule->suspended_queue->count++;
	
	return 0;
	
	
}

/* Move the process with matching pid from Suspended to Ready Queue.
 * Follow the specification for this function.
 * Returns a 0 on success or a -1 on any error (such as process not found).
 */
int egul_resume(Egul_schedule_s *schedule, pid_t pid) {
	
	Egul_process_s *search = schedule->suspended_queue->head;
	Egul_process_s *prev = NULL;
	
	//nothing to resume
	if(search == NULL)
		return -1;
	
	//look in ready if pid != 0
	if(pid != 0){
		
		
		while(search != NULL){
			if(search->pid == pid)
				break;
			prev = search;
			search = search->next;
		}
	}
	
	//if not found
	if(search == NULL)
		return -1;
	
	
	//remove from suspended_queue
	//head case
	if(pid == 0 || prev == NULL)
		schedule->suspended_queue->head = schedule->suspended_queue->head->next;
	else
		prev->next = search->next;
	
	//update count
	schedule->suspended_queue->count--;
	//update tail if needed
	if(search->pid == schedule->suspended_queue->tail->pid)
		schedule->suspended_queue->tail = prev;
	
	
	//format for ready_queue
	search->next = NULL;
	search->state = search->state^0x5000;
	
	if(schedule->ready_queue->count == 0){
		schedule->ready_queue->head = search;
		schedule->ready_queue->tail = search;
		
	}else{
		schedule->ready_queue->tail->next = search;
		schedule->ready_queue->tail = search;
	}
	schedule->ready_queue->count++;
	
	return 0;
  
}

/* This is called when a process exits normally that was just Running.
 * Put the given node into the Terminated Queue and set the Exit Code 
 * - Do not create a new process to insert, insert the SAME process passed in.
 * Follow the project documentation for this function.
 * Returns a 0 on success or a -1 on any error.
 */
 
 //TODO FIX Exit code + check oneNotes
int egul_exited(Egul_schedule_s *schedule, Egul_process_s *process, int exit_code) {
	
	//format process
	if(schedule == NULL || process == NULL)
		return -1;
	
	//set code, state, next
	process->next = NULL;
	
	//maintian crit
	unsigned int x = process->state;
	//keep crit
	x = x&0x8000;
	//add terminated flag
    x = x|0x800;
	//add code
    x = x|((unsigned int)exit_code);
	
	process->state = x;
	
	//append to terminated_queue
	if(schedule->terminated_queue->count == 0){
		schedule->terminated_queue->head = process;
		schedule->terminated_queue->tail = process;
	}else{
		schedule->terminated_queue->tail->next = process;
		schedule->terminated_queue->tail = schedule->terminated_queue->tail->next;
	}
	schedule->terminated_queue->count++;
	
	return 0;
	
	
	
}


//TODO implement
/* This is called when the OS terminates a process early. 
 * - This will either be in your Ready or Suspended Queue.
 * - The difference with egul_exited is that this process is in one of your Queues already.
 * Remove the process with matching pid from the Ready or Suspended Queue and add the Exit Code to it.
 * - You have to check both since it could be in either queue.
 * Follow the project documentation for this function.
 * Returns a 0 on success or a -1 on any error.
 */
int egul_killed(Egul_schedule_s *schedule, pid_t pid, int exit_code) {
	
	Egul_process_s* kill = NULL;
	Egul_process_s* node = schedule->ready_queue->head;
	
	
	//FIND
	if(node != NULL){
		
		//if kill is head
		if(node->pid == pid){
			kill = node;
			schedule->ready_queue->head = schedule->ready_queue->head->next;
		}
		//else
		while(node->next != NULL && kill == NULL){
			//remove kill from queue & move to formatting
			if(node->next->pid == pid){
				kill = node->next;
				node->next = node->next->next;
				schedule->ready_queue->count--;
				break;
			}
			//increment node
			node = node->next;
		}
	}
	
	
	//if not in ready
	if(kill != NULL){
		
		node = schedule->suspended_queue->head;
			if(node != NULL){
			
			//if kill is head
			if(node->pid == pid){
				kill = node;
				schedule->suspended_queue->head = schedule->suspended_queue->head->next;
			}
			//else
			while(node->next != NULL && kill == NULL){
				//remove kill from queue & move to formatting
				if(node->next->pid == pid){
					kill = node->next;
					node->next = node->next->next;
					schedule->suspended_queue->count--;
					break;
				}
				//increment node
				node = node->next;
			}
		}
		
		
	}
	
	if (kill == NULL)
		return -1;
	
	
	//formatting & appending handled here
	return egul_exited(schedule, kill, exit_code);
}

/* Gets the exit code from a terminated process.
 * (All Linux exit codes are between 0 and 255)
 * Follow the project documentation for this function.
 * Returns the exit code if the process is terminated.
 * If the process is not terminated, return -1.
 */
int egul_get_ec(Egul_process_s *process) {
	//isolate exit code
	if(process == NULL || (process->state&0x800) != 0x800)
		return -1;
	return (unsigned int)(process->state&0x7FF);
}

/* Frees all allocated memory in the Egul_schedule_s, all of the Queues, and all of their Nodes.
 * Follow the project documentation for this function.
 * Returns void.
 */
void egul_deallocate(Egul_schedule_s *schedule) {
	
	deallocateQueue(schedule->ready_queue);  
	deallocateQueue(schedule->suspended_queue);
	deallocateQueue(schedule->terminated_queue);
	free(schedule);
}