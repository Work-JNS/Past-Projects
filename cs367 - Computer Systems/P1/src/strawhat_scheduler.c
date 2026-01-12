#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>
/* StrawHat VM Includes */
#include "strawhat.h"
#include "egul_sched.h"
#include "strawhat_scheduler.h"
#include "strawhat_support.h"
#include "strawhat_process.h"
#include "strawhat_printing.h"
#include "strawhat_cs.h"

Scheduler_fns_s sched = {0};

void strawhat_scheduler_initialize() {
  sched.scheduler_initialize = egul_initialize;
  sched.scheduler_create = egul_create;
  sched.scheduler_enqueue = egul_insert;
  sched.scheduler_get_count = egul_count;
  sched.scheduler_select = egul_select;
#if FEATURE_SUSPEND  
  sched.scheduler_suspend = egul_suspend;
  sched.scheduler_resume = egul_resume;
#endif
#if FEATURE_MLFQ  
  sched.scheduler_promote = egul_promote;
#endif  
  sched.scheduler_exited = egul_exited;
  sched.scheduler_killed = egul_killed;
#if FEATURE_REAP  
  sched.scheduler_reap = egul_reap;
#endif  
  sched.scheduler_get_ec = egul_get_ec;
  sched.scheduler_cleanup = egul_deallocate;
}

Scheduler_create_data_s *strawhat_scheduler_initialize_data(Process_data_s *pdata) {
  Scheduler_create_data_s *sdata = calloc(1, sizeof(Scheduler_create_data_s));
  sdata->priority_level = pdata->priority_level;
  sdata->is_critical = pdata->is_critical;
  sdata->pid = pdata->pid;

  strncpy(sdata->original_cmd, pdata->input_orig, strlen(pdata->input_orig) + 1);
  return sdata;
}