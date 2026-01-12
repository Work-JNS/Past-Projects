/* This is the only file you will be editing and submit.
 * - Copyright of Starter Code: Prof. Yutao Zhong, George Mason University.  All Rights Reserved
 * - Copyright of Student Code: You!  
 * - Restrictions on Student Code: Do not post your code on any public site (eg. Github).
 * -- Feel free to post your code on a PRIVATE Github and give interviewers access to it.
 * -- You are liable for the protection of your code from others.
 * - Date: Oct 2024
 */

/* CS367 Project 3, Fall Semester, 2024
 * Fill in your Name, GNumber, and Section Number in the following comment fields
 * Name: Jared Singh
 * GNumber: 01416039
 * Section Number: CS367-00_             (Replace the _ with your section number)
 */

/* Includes */ 
#include <sys/wait.h>
#include "zaku.h"
#include "parse.h"
#include "util.h"
#include "logging.h"

/* Constants */
#define DEBUG 0 /* You can set this to 0 to turn off the debug parse information */
#define STOP_SHELL  0
#define RUN_SHELL   1
#define NUM_PATHS 2
#define NUM_INSTRUCTIONS 13
static const char *task_path[] = { "./", "/usr/bin/", NULL };
static const char *instructions[] = { "quit", "help", "list", "delete", "start_fg", "start_bg", "kill", "suspend", "resume_fg", "resume_bg", "fg", "pipe", "chain", NULL};


/* Custom Global vars & func Defs */
int fg_num = -1;
sigset_t block, unblock;
void block_signals(sigset_t* new, sigset_t* old);


/*------- TASK STRUCT & METHODS -------*/
// defines a Task
typedef struct Task{
	char* cmd;
	char* instruction;
	char** argv;
	int task_id;
	int state;
	int pid;
	int exit_code;
	int is_bg; 
	struct Task* next;
}Task;
// initalizes a task
Task* makeTask(char* cmd, char *argv[], int tID, char* instruct){
	Task* rv = (Task*)malloc(sizeof(Task));
	if(rv == NULL)
		exit(-1);
	rv->cmd = string_copy(cmd);
	rv->instruction = string_copy(instruct);
	rv->argv = clone_argv(argv);
	rv->task_id = tID;
	rv->state = LOG_STATE_READY;
	rv->pid = 0;
	rv->exit_code = 0;
	rv->next = NULL;
	return rv;
	
}
// frees a task
void free_Task(Task* task){
	free_command(task->cmd, NULL, task->argv);
	free(task->instruction);
	free(task);
}


/*------- TASKLIST STRUCT & METHODS -------*/
// defines list of task
typedef struct TaskList{
	Task* head;
	Task* tail;
	int numTasks;
	int lastID;
}TaskList;
// global list varibale
TaskList* list = NULL;
// initalizes a TaskList
TaskList* makeTaskList(){
	TaskList* rv = (TaskList*)malloc(sizeof(TaskList));
	rv->numTasks = 0;
	rv->lastID = 0;
	rv->head = NULL;
	rv->tail = NULL;
	return rv;
}
// Adds task to list
void add(TaskList *list, Task* task){
	if(list->head == NULL){
		list->head = task;
		list->tail = task;
		list->numTasks = 1;
		list->lastID = 1;
		return;
	}
	list->tail->next = task;
	list->tail = list->tail->next;
	list->numTasks++;
	list->lastID++;
}
// Removes task from List
void delete(int task_id, TaskList* list, int bg){
	
	Task* reader = list->head;
	Task* prev = NULL;
	
	while(reader != NULL){
		
		if(reader->task_id == task_id){
			// status error
			if(reader->state == LOG_STATE_RUNNING || reader->state == LOG_STATE_SUSPENDED){
				log_status_error(task_id, reader->state);
				return;
			}
			
			//success
			if(prev == NULL)
				list->head = list->head->next;
			else{
				prev->next = reader->next;
				// tail case
				if(prev->next == NULL)
					list->tail = prev;	
			}
			reader->next = NULL;
			if(!bg)
				free_Task(reader);
			list->numTasks--;
			return;
		}
		
		
		prev = reader;
		reader = reader->next;
	}
	//not found;
	log_task_num_error(task_id);
}
// gets a task from a task list
Task* get(int task_id, TaskList* list, int bg_op){
	if(task_id < 0){
		log_task_num_error(task_id);
		return NULL;
	}
	Task* reader= list->head;
	while(reader != NULL){
		if(reader->task_id == task_id)
			break;
		reader = reader->next;
	}
	// Task not in list
	if(reader == NULL){
		log_task_num_error(task_id);
		return NULL;
	}
	// Task in invalid state
	if(bg_op == 0){
		if(reader->state != LOG_STATE_READY){ // get ready
			log_status_error(reader->task_id, reader->state);
			return NULL;
		}
	}else{
		if(bg_op == 1 && reader->state != LOG_STATE_RUNNING){ // get running
			log_status_error(reader->task_id, reader->state);
			return NULL;
		}else if(bg_op == 2 && (reader->state != LOG_STATE_RUNNING && reader->state != LOG_STATE_SUSPENDED)){ // get running | suspended
			log_status_error(reader->task_id, reader->state);
			return NULL;
		}else if(bg_op == 3 && reader->state != LOG_STATE_SUSPENDED){ // get suspended
			log_status_error(reader->task_id, reader->state);
			return NULL;
		}
	}
	return reader;
	
}
// Prints a TaskList
void printList(TaskList list){
	int counter = 0;
	Task* reader = list.head;
	log_num_tasks(list.numTasks);
	while(counter < list.numTasks && reader != NULL){
		log_task_info(reader->task_id, reader->state, reader->exit_code, reader->pid, reader->cmd);
		reader = reader->next;
		counter++;
	}
}
// frees a task List
void free_TaskList(TaskList* list){
	Task* cur = list->head;
	Task* prev;
	while(cur != NULL){
		prev = cur;
		cur = cur->next;
		free_Task(prev);
		
	}
	free(list);
}


/*------- RUNNING & LOGGING METHODS -------*/
// reaps finished background tasks
void bg_cleaner(TaskList* list){
	if(list->numTasks <= 0)
		return;
	
	Task* test = list->head;
	
	while(test != NULL){
		if(test->is_bg == 1 && test->state == LOG_STATE_RUNNING){
			int exit_code;
			int pid = waitpid(test->pid, &exit_code, WNOHANG);
			if(pid != 0){
				test->state = LOG_STATE_FINISHED;
				log_status_change(test->task_id, pid, LOG_BG, test->cmd, LOG_TERM);
			}else{
			}
		}
		test = test->next;
	}
}
// mange task status & log updates
void log_run_task(Task* task, int pid, int type){
	// set task to running & log prompt
	block_signals(&unblock, NULL);	
	task->state = LOG_STATE_RUNNING;
	task->pid = pid;
	log_status_change(task->task_id, pid, type, task->cmd, LOG_START);
	// fg task
	if(type == LOG_FG){
		// wait for termination
		fg_num = task->task_id;
		int exit_code;
		waitpid(pid, &exit_code, 0);
		// update task info on termination if not handled by signal
		if(task->state == LOG_STATE_RUNNING){
			task->exit_code = exit_code;
			task->state = LOG_STATE_FINISHED;
			log_status_change(task->task_id, pid, LOG_FG, task->cmd, LOG_TERM);
		}
		fg_num = -1;	
		
	}
	// bg task
	else if(type == LOG_BG){task->is_bg = 1;}
}
// redirects input & output
void reDir(Instruction inst, int* fds){
	// 0 is in, 1 is out
	fds[0] = -1;
	fds[1] = -1;
	if(inst.infile){
		fds[0] = open(inst.infile, O_RDONLY);
		//file not found
		if(fds[0] < 0){
			log_file_error(inst.num, inst.infile);
			exit(1);
		}
		log_redir(inst.num, LOG_REDIR_IN ,inst.infile);
		dup2(fds[0], STDIN_FILENO);
	}
						
	if(inst.outfile){// TODO: fix: not readable on create
		fds[1] = open(inst.outfile, O_CREAT|O_APPEND|O_WRONLY);
		log_redir(inst.num, LOG_REDIR_OUT ,inst.outfile);
		dup2(fds[1], STDOUT_FILENO);
	}
}
// executes a task
void execute(Task* task, int* fds){
	// construct path:
	char path[100];
	strcpy(path, task_path[0]);
	strncat(path, task->instruction, 98*sizeof(char));
	//execute:
	int err = execv(path, task->argv);
	if(err < 0){
		//alt path:
		strcpy(path, task_path[1]);
		strncat(path, task->instruction, 91*sizeof(char));
		err = execv(path, task->argv);
		//start err:
		if(err < 0){
			log_start_error(task->cmd);
			if(fds != NULL){
				if(fds[0] != -1){close(fds[0]);}
				if(fds[1] != -1){close(fds[1]);}
			}
			exit(1);
			
		}
	}
}


/*------- SIGNAL METHODS METHODS -------*/
// resumes a process in fg/bg depending on type
void resume_process(int num, TaskList* list, int type){
	// verif task
	Task* task;
	if(num > 0){
		// get suspended task 
		task = get(num, list, 3);
		if(task != NULL){
			log_sig_sent(LOG_CMD_RESUME, task->task_id, task->pid);
			kill(task->pid, SIGCONT);
			task->state = LOG_STATE_RUNNING;
			log_status_change(task->task_id, task->pid, type, task->cmd, LOG_RESUME);
			if(type == LOG_FG){
				fg_num = task->task_id;
				task->is_bg = 0;
				// wait for termination
				int exit_code = -1;
				waitpid(task->pid, &exit_code, 0);
				// update task info on termination
				if(task->state == LOG_STATE_RUNNING){
					task->state = LOG_STATE_FINISHED;
					task->exit_code = exit_code;
					log_status_change(task->task_id, task->pid, LOG_FG, task->cmd, LOG_TERM);
				}
			}else{task->is_bg = 1;}
			fg_num = -1;
			
			
		}
	}else{log_task_num_error(num);}
}
// suspends a process
void suspend_process(int num, TaskList* list, int formalCall){
	// verif task
	Task* task;
	if(num > 0){
		// get running task 
		task = get(num, list, 2);
		if(task != NULL){
			if(formalCall){log_sig_sent(LOG_CMD_SUSPEND, task->task_id, task->pid);}
			kill(task->pid, SIGTSTP);
			task->state = LOG_STATE_SUSPENDED;
			
			int type = LOG_FG;
			if(task->is_bg == 1){type = LOG_BG;}
			
			log_status_change(task->task_id, task->pid, type, task->cmd, LOG_SUSPEND);
													
		}
	}else{log_task_num_error(num);}
}
//kills a process
void kill_process(int num, TaskList* list, int formalCall){
	// verif task
	Task* task;
	if(num > 0){
		// get running task 
		task = get(num, list, 1);
		if(task != NULL){
			if(formalCall){log_sig_sent(LOG_CMD_KILL, task->task_id, task->pid);}
			kill(task->pid, SIGINT);
			task->state = LOG_STATE_KILLED;
			int type = LOG_FG;
			if(task->is_bg == 1){type = LOG_BG;}
			
			log_status_change(task->task_id, task->pid, type, task->cmd, LOG_TERM_SIG);
		}	
	}else{log_task_num_error(num);}
}
// custom signal handler
void handler(int sig){
	switch(sig){
		case SIGINT:
			log_ctrl_c();
			if(fg_num == -1){return;}
			kill_process(fg_num, list, 0);
			break;
		case SIGTSTP:
			log_ctrl_z();
			if(fg_num == -1){return;}
			suspend_process(fg_num, list, 0);
			// suspend pid
			break;
		case SIGCHLD:
			break;
	}
	
		
	fg_num = -1;
}
// blocks signals
void block_signals(sigset_t* new, sigset_t* old){
	if(old != NULL){sigprocmask(SIG_BLOCK, new, old);}
	else{sigprocmask(SIG_SETMASK, new, NULL);}
}
// switches signals to custom handler
void switch_to_custom(){
	struct sigaction sa;
	sa.sa_handler = handler;
	if(sigaction(SIGTSTP, &sa, NULL) == -1){printf("ERR\n");}
	if(sigaction(SIGINT, &sa, NULL) == -1){printf("ERR\n");}
	if(sigaction(SIGCHLD, &sa, NULL) == -1){printf("ERR\n");}
}

/*-------------------------------------------*/
/*-------------------------------------------*/
/* The entry of your task manager program */
int main() {
	
	// init blocking sigmask
	sigemptyset(&block);
	sigaddset(&block, SIGTSTP);
	sigaddset(&block, SIGINT);
	
	// init vars
    char *cmd = NULL;	
    int do_run_shell = RUN_SHELL;
	list = makeTaskList();
	
	
    /* Intial Prompt and Welcome */
    log_intro();
    log_help();

    /* Shell looping here to accept user command and execute */
    while (do_run_shell == RUN_SHELL) {
		bg_cleaner(list);					  /* Run bg_task checks */
        char *argv[MAXARGS+1] = {0};        /* Argument list */
        Instruction inst = {0};           /* Instruction structure: check parse.h */
		switch_to_custom();				/* Change handler to custom */

        /* Print prompt */
        log_prompt();
        
        /* Get Input - Allocates memory for the cmd copy */
        cmd = get_input(); 
        /* If the input is whitespace/invalid, get new input from the user. */
        if(cmd == NULL) {continue;}
        
		
        /* Parse the Command and Populate the Instruction and Arguments */
        initialize_command(&inst, argv);    /* initialize arg lists and instruction */
        parse(cmd, &inst, argv);            /* call provided parse() */
		
		if (DEBUG) {debug_print_parse(cmd, &inst, argv, "main (after parse)");}
        /* After parsing: your code to continue from here */
		
		
		
        /*==BUILT_IN: quit===*/
        if (strcmp(inst.instruct, instructions[0])==0){do_run_shell = STOP_SHELL;}
		/*==BUILT_IN: help===*/
		else if(strcmp(inst.instruct, instructions[1])==0){log_help();}
		/*==BUILT_IN: list===*/
		else if(strcmp(inst.instruct, instructions[2])==0){printList(*list);}
		/*==BUILT_IN: delete===*/
		else if(strcmp(inst.instruct, instructions[3])==0){delete(inst.num, list, 0);}
		/*==BUILT_IN: start_fg===*/
		else if(strcmp(inst.instruct, instructions[4])==0){
			Task* task;
			task = get(inst.num, list, 0);
			if(task != NULL){
				block_signals(&block, &unblock); // block signals
				pid_t pid = fork(); // fork
				if(pid < 0){exit(-1);} // if fork fail
				if(pid != 0){log_run_task(task, pid, LOG_FG);} // parent
				else{	// child
					block_signals(&unblock, NULL); //unblock child signals
					setpgid(0,0); // init new pidgroup
					int fds[2];
					reDir(inst, fds); // update read & write locations:
					execute(task, fds); // execute command
				}
				
			}	
		}
		/*==BUILT_IN: start_bg===*/
		else if(strcmp(inst.instruct, instructions[5])==0){
			Task* task = get(inst.num, list, 0);
				if(task != NULL){
					block_signals(&block, &unblock); // block signals
					pid_t pid = fork();	// fork
					if(pid < 0){exit(-1);} // if fork fail
					if(pid != 0){log_run_task(task, pid, LOG_BG);} // parent
					//CHILD:
					else{
						block_signals(&block, &unblock); // unblock signals
						int fds[2];
						reDir(inst, fds); // update read & write locations:
						execute(task, fds); // execute
					}
				}	
			
		}	
		/*==BUILT_IN: kill===*/
		else if(strcmp(inst.instruct, instructions[6])==0){kill_process(inst.num, list, 0);}
		/*==BUILT_IN: suspend===*/
		else if(strcmp(inst.instruct, instructions[7])==0){suspend_process(inst.num, list, 0);}
		/*==BUILT_IN: resume_fg===*/
		else if(strcmp(inst.instruct, instructions[8])==0){resume_process(inst.num, list, LOG_FG);}
		/*==BUILT_IN: resume_bg===*/
		else if(strcmp(inst.instruct, instructions[9])==0){resume_process(inst.num, list, LOG_BG);}		
		/*==BUILT_IN: fg===*/
		else if(strcmp(inst.instruct, instructions[10])==0){
			Task* task = get(inst.num, list, 1); // get process
			if(task != NULL){ // check NULL
				if(task->is_bg == 1){
					log_fg(inst.num, task->pid, task->cmd); // log req
					int exit_code;
					task->is_bg = 0;
					fg_num = task->task_id;
					waitpid(task->pid, &exit_code, 0); // wait for process
					if(task->state == LOG_STATE_RUNNING){ // cleanup
						task->state = LOG_STATE_FINISHED;
						task->exit_code = exit_code;
						log_status_change(task->task_id, task->pid, LOG_FG, task->cmd, LOG_TERM);
					}
					fg_num = -1;	
				}
			}
			
		}
		/*==BUILT_IN: pipe===*/
		else if(strcmp(inst.instruct, instructions[11])==0){
			// inst must have num 1 && 2
			if(inst.num > 0 && inst.num2 > 0){
				
				if(inst.num == inst.num2){ // same src & dest
					log_pipe_error(inst.num);
					continue;
				}	
				Task* task1 = get(inst.num, list, 0);
				Task* task2 = get(inst.num2, list, 0);
				if(task1 != NULL && task2 != NULL){	//tasks are valid
					log_pipe(task1->task_id, task2->task_id); //log pipe
					
					// backend pipes
					int pidPipe[2];
					int exitPipe[2];
					if(pipe(pidPipe) == -1){exit(EXIT_FAILURE);}
					if(pipe(exitPipe) == -1){exit(EXIT_FAILURE);}
					
					// update task states
					task1->state = LOG_STATE_RUNNING;
					task2->state = LOG_STATE_RUNNING;
					fg_num = task1->task_id; //enable signals for task 2
					block_signals(&block, &unblock); // block signals
					
					pid_t pid = fork(); // fork for task 2
					if(pid < 0){exit(1);} // fork fail
					
					if(pid == 0){
						
						int pipefd[2]; 
						if(pipe(pipefd) == -1){exit(EXIT_FAILURE);} // open pipe for command
						
						
						pid_t cpid = fork(); //fork for task 1
						if(cpid < 0){exit(1);} // fork for task 1 fail
						block_signals(&unblock, NULL); // unblock signals
						
						if(cpid == 0){ // Task 1 - BG
							close(pipefd[0]); // close unused
							dup2(pipefd[1], STDOUT_FILENO); // redir output to pipe
							execute(task1, NULL); // execute
						}else{ // Task 2 - FG
							block_signals(&unblock, NULL); // unblock signals
							close(pidPipe[0]);
							write(pidPipe[1], &cpid, sizeof(cpid)); //save pid of task 1
							close(pidPipe[1]);
							// start prompts
							log_status_change(task1->task_id, cpid, LOG_BG, task1->cmd, LOG_START);
							log_status_change(task2->task_id, getpid(), LOG_FG, task2->cmd, LOG_START);
							int t1exit;
							waitpid(cpid, &t1exit, 0); // wait for t1
							close(exitPipe[0]);
							write(exitPipe[1], &t1exit, sizeof(t1exit)); // save exit code of t1
							close(exitPipe[1]);
							close(pipefd[1]);
							dup2(pipefd[0], STDIN_FILENO); // redir input to pipe
							execute(task2, NULL); // execute
						}
						
					}else{ // Parent
						int t2exit = -1;
						waitpid(pid, &t2exit, 0); // wait for t2
						pid_t t1Pid;
						int t1Exit;
						close(pidPipe[1]);
						read(pidPipe[0], &t1Pid, sizeof(pid_t)); // get t1 pid
						close(pidPipe[0]);
						close(exitPipe[1]);
						read(exitPipe[0], &t1Exit, sizeof(t1Exit)); // get t1 exit_code
						close(exitPipe[0]);
						
						if(task1->state == LOG_STATE_RUNNING){ //update task 1 - if not signaled
							task1->state = LOG_STATE_FINISHED;
							task1->pid = t1Pid;
							task1->exit_code = t1Exit;
							log_status_change(task1->task_id, t1Pid, LOG_BG, task1->cmd, LOG_TERM); // log termination
						}
						
						if(task2->state == LOG_STATE_RUNNING){ //update task 2 - if not signaled
							task2->state = LOG_STATE_FINISHED;
							task2->pid = pid;
							task2->exit_code = t2exit;
							log_status_change(task2->task_id, pid, LOG_FG, task2->cmd, LOG_TERM); // log termination
						}
						fg_num = -1; // reset signals
					}
				}
			}else{
				if(inst.num > inst.num2){log_task_num_error(inst.num2);}
				else{log_task_num_error(inst.num);}
			}
		}
		/*==BUILT_IN: chain===*/
		else if(strcmp(inst.instruct, instructions[12])==0){
			// inst must have num 1 && 2
			if(inst.num > 0 && inst.num2 > 0){
				
				Task* task1 = get(inst.num, list, 0);
				Task* task2 = get(inst.num2, list, 0);
				if(task1 == NULL){log_task_num_error(inst.num);}	// task num error
				else if(task2 == NULL){log_task_num_error(inst.num2);}	// task num error
				else{
					log_chain(task1->task_id, 0, task2->task_id, LOG_CHAIN_START);
					pid_t pid = fork();
					if(pid<0){exit(1);}
					//child
					if(pid == 0){execute(task1, NULL);}
					else{
						// start task 1
						log_run_task(task1, pid, LOG_FG);
						// continue chain
						if(task1->exit_code == 0){
							//start task 2
							log_chain(task1->task_id, task1->exit_code, task2->task_id, LOG_CHAIN_PASS);
							pid = fork();
							if(pid < 0){exit(1);}
							
							if(pid == 0){execute(task2, NULL);} // Child
							else{log_run_task(task2, pid, LOG_BG);} // Parent
							
						}else{log_chain(task1->task_id, task1->exit_code, task2->task_id, LOG_CHAIN_FAIL);}
					}
				}
				}else{
					if(inst.num > inst.num2){log_task_num_error(inst.num2);}
					else{log_task_num_error(inst.num);}
				}
			}
		/*==USER: Commands===*/
		else{
			Task* task = makeTask(cmd, argv, list->lastID+1, inst.instruct);
			// save task
			add(list, task);
			// prompt
			log_task_init(task->task_id, cmd);
		}

        /*.===============================================.
         *| After your code: We cleanup before Looping to the next command.
         *| free_command WILL free the cmd, inst and argv data.
         *| Make sure you've copied any needed information to your Task first.
         *| Hint: You can use the util.c functions for copying this information.
         *+===============================================*/
		bg_cleaner(list);
        free_command(cmd, &inst, argv);
	      cmd = NULL;
    }  // end while
	free_TaskList(list);
	log_quit();

    return 0;
}
  // end main()