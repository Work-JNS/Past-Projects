/* Do Not Modify This File */

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "logging.h"

#define BUFSIZE 255

#define textproc_log(s) fprintf(stderr,"\033[1;31m%s%s\033[0m",log_head, s); fflush(stderr)
#define textproc_unmarked_log(s) fprintf(stderr,"\033[1;31m%s\033[0m", s); fflush(stderr)

#define textproc_write(s) char output[BUFSIZE] = {0}; snprintf(output,BUFSIZE-1,"\033[1;31m%s%s\033[0m", log_head, s); write(STDERR_FILENO, output, strlen(output));

static const char *log_head = "[ZAKU-LOG] ";
static const char *task_state[] = { "Ready", "Running", "Suspended", "Finished", "Killed", NULL };

/* Outputs an Introductory message at the start of the program */
void log_intro() { 
  textproc_log("Welcome to the ZAKU Task Manager!\n");
  textproc_log("\n");
}

/* Outputs the Help: All the Built-in Commands */
void log_help() { 
  textproc_log("Instructions:\n");
  textproc_log("    <COMMAND> [<ARGS>...],\n");
  textproc_log("    help, quit, list, delete <TASK>,\n");
  textproc_log("    start_fg <TASK> [<FILE>], start_bg <TASK> [<FILE>],\n");
  textproc_log("    kill <TASK>, suspend <TASK>,\n");
  textproc_log("    resume_fg <TASK>, resume_bg <TASK>,\n");
  textproc_log("    fg <TASK>,\n");
  textproc_log("    pipe <TASK1> <TASK2>\n");
  textproc_log("    chain <TASK1> <TASK2>\n");
  textproc_log("\n");
  textproc_log("Brackets denote optional arguments\n");
}

/* Outputs the message after running quit */
void log_quit(){
  textproc_log("Thanks for using the ZAKU Task Manager! Good-bye!\n");
}

/* Outputs the prompt */
void log_prompt() {
  printf("ZAKU$ ");
  fflush(stdout);
}

/* Outputs a notification of a task deletion */
void log_delete(int task_id) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Deleting Task ID %d\n", task_id);
  textproc_log(buffer);
}

/* Outputs a notification of an error due to action in an incompatible state. */
void log_status_error(int task_id, int status) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Error acting on Task ID %d due to process in %s state\n", task_id, task_state[status]);
  textproc_log(buffer);
}

/* Outputs a notification of an file error */
void log_file_error(int task_id, const char *file) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Error opening file %s for Task %d\n", file, task_id);
  textproc_log(buffer);
}

/* Output when the command is not found
 * eg. User typed in lss instead of ls and run returns an error
 */ 
void log_run_error(const char *line) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Error: %s: Command Cannot Load\n", line);
  textproc_log(buffer);
}

/* Output when activating a new task */
void log_task_init(int task_id, const char *cmd) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Adding Task ID %d: %s (Ready)\n", task_id, cmd);
  textproc_write(buffer);
} 

/* Output when the given task id is not found */
void log_task_id_error(int task_id) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Error: Task ID %d Not Found in Task List\n", task_id);
  textproc_write(buffer);
}

/* Output when ctrl-c is received */
void log_ctrl_c() {
  textproc_write("Keyboard Combination control-c Received\n");
}

/* Output when ctrl-z is received */
void log_ctrl_z() {
  textproc_write("Keyboard Combination control-z Received\n");
}

/* Output when a signal is sent to a task's process */
void log_sig_sent(int sig_type, int task_id, int pid) {
  char buffer[BUFSIZE] = {0};
  static const char* sigs[] = {"Suspend", "Resume", "Cancel"};
  if (sig_type < 0 || sig_type >= 3) {
          textproc_write("Invalid input to log_sig_sent\n");
          return;
  }
  sprintf(buffer,"%s message sent to Task ID %d (PID %d)\n", sigs[sig_type], task_id, pid);
  textproc_log(buffer);
}

/* Output when a job changes state.
 * (Signal Handler Safe Outputting)
 */
void log_status_change(int task_id, int pid, int type, const char *cmd, int transition) {
  char buffer[BUFSIZE] = {0};
  static const char* msgs[] = {"Terminated Normally", "Terminated by Signal", "Continued", "Stopped", "Started"};
  static const char* types[] = {"Foreground", "Background", "Logged Background"};
  if (transition < 0 || transition >= 5) {
          textproc_write("Invalid input to log_status_change\n");
          return;
  }
  sprintf(buffer,"%s Process %d (Task %d): %s (%s)\n",types[type], pid, task_id, cmd, msgs[transition]);
  textproc_write(buffer);
}

/* Output when a bg job switch to fg.
 * (Signal Handler Safe Outputting)
 */
void log_fg(int task_id, int pid, const char *cmd){
  char buffer[BUFSIZE] = {0};
  sprintf(buffer,"Background Process %d (Task %d): %s switched to Foreground\n", pid, task_id, cmd);
  textproc_write(buffer);
  
}



/* Output to list the task counts */
void log_num_tasks(int num_tasks){
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "%d Task(s)\n", num_tasks);
  textproc_log(buffer);
}

/* Output info about a single task */
void log_task_info(int task_id, int status, int exit_code, int pid, const char *cmd){
  char buffer[BUFSIZE] = {0};
  if (status < 0 || status >= 5) {
          textproc_write("Invalid input to log_task_info\n");
          return;
  }
  if (!cmd) 
  { sprintf(buffer, "Task %d: (%s)\n", task_id, task_state[status]); }
  else if (!pid) 
  { sprintf(buffer, "Task %d: %s (%s)\n", task_id, cmd, task_state[status]); }
  else if (status != LOG_STATE_FINISHED && status != LOG_STATE_KILLED) 
  { sprintf(buffer, "Task %d: %s (PID %d; %s)\n", task_id, cmd, pid, task_state[status]); }
  else
  { sprintf(buffer, "Task %d: %s (PID %d; %s; exit code %d)\n", task_id, cmd, pid, task_state[status], exit_code); }

  textproc_log(buffer);
}


/* Output when the given task number is not found */
void log_task_num_error(int task_num) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Error: Task %d Not Found in Task List\n", task_num);
  textproc_write(buffer);
}

void log_redir(int task_num, int redir_type, const char *file) {
  char buffer[BUFSIZE] = {0};
  static const char* types[] = {"input", "output"};
  static const char* polarity[] = {"from", "to"};
  if (redir_type < 0 || redir_type >= 2) {
	  textproc_write("Invalid input to log_anav_redir\n");
	  return;
  }
  sprintf(buffer, "Redirecting %s %s %s for Task %d\n", types[redir_type], polarity[redir_type], file, task_num);
  textproc_log(buffer);
}

/* Outputs a notification of the creation of a pipe */
void log_pipe(int task_id1, int task_id2) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Opening a pipe from Task %d to Task %d\n", task_id1, task_id2);
  textproc_log(buffer);
}

/* Outputs a notification of an error piping a program's output to itself */
void log_pipe_error(int task_num) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Error attempting to pipe Task %d's output to itself\n", task_num);
  textproc_log(buffer);
}

/* Outputs a notification of the task chaining */
void log_chain(int task_id1, int exit_code, int task_id2, int option) {
  char buffer[BUFSIZE] = {0};
  if (option == LOG_CHAIN_START) {
    sprintf(buffer, "Executing a chain of Task %d followed by Task %d\n", task_id1, task_id2);
  }
  else if (option == LOG_CHAIN_PASS){
    sprintf(buffer, "Task %d terminated with exit code %d (success). \nTask %d will start next.\n", task_id1, exit_code, task_id2);
  }
  else if (option == LOG_CHAIN_FAIL){
    sprintf(buffer, "Task %d terminated with exit code %d (fail). \nTask %d will NOT start.\n", task_id1, exit_code, task_id2);
  }
  else{
    sprintf(buffer, "log_chain with invalid option: %d.\n", option);
  }
  textproc_log(buffer);
}

/* Output when the command is not found
 * eg. User typed in lss instead of ls and start_fg returns an error
 */ 
void log_start_error(const char *line) {
  char buffer[BUFSIZE] = {0};
  sprintf(buffer, "Error: %s: Command Cannot Load\n", line);
  textproc_log(buffer);
}
