# queuer: A simple job scheduler and build system for R
A simple job scheduler and build system for R, written entirely in base R with no dependencies (packages or external applications). 

Jobs (i.e. an R script to run) are defined using a simple R function and saved to an arbitrary queue file. A separate script is called (e.g. as a cron job) to run the jobs sequentially.

Alternatively, a build file may be created for a project, defining the jobs to be run and the prerequisites for each script. The `build` function can then be used to build all or part of the project.


Why use queuer?
---------------

queuer has two primary use cases:

1. To schedule scripts from multiple projects to run sequentially at a convenient time (e.g. over night)
2. As a simple client-server solution. For example, jobs can be scheduled from a notebook and run automatically from a server.

queuer is intended as a simple solution for single users or small groups of users. It is not intended as an enterprise solution (lacking security, scalability and auditing features) and is not a cluster management tool (such as LSF).

Alternative schedulers:

* `scheduler` (https://github.com/Bart6114/scheduleR) is very similar in conception but has a number of dependencies (shiny, mongodb, node.js) that make installation difficult or impossible.
* `batch` (https://cran.r-project.org/web/packages/batch/) makes it easier to pass arguments to R scripts and queue jobs using dedicated cluster tools (e.g. bsub).
* `BatchJobs` provides Map/Reduce/Filter functionality to interface with dedicated batch computing systems

Alternative build systems:

* `GNU Make` is powerful and widely used with R, especially on UNIX-like systems. However, the syntax can be complex and Make is an external dependency that can be difficult to get running under Windows.
* `luigi` (https://github.com/spotify/luigi) is a pipeline manager for python. An R-based version is available at https://github.com/kirillseva/ruigi. These systems are more complex than queuer and have dependencies.


Quick start
-----------
Create a new job and add to a queue:
```
create_job(
  script = "test_script.R",
  queue = "~/my_queue.txt",
  name = "A test job"
)
```

Add a second job to the same queue with higher priority:
```
create_job(
  script = "test_script_important.R",
  queue = "~/my_queue.txt",
  name = "An important test job",
  priority = 1
)
```

Process all jobs in a given queue:
```
process_queue("~/my_queue.txt")
```

Because "An important test job" was allocated a higher priority than "A test job", it will be processed first, although it was added later.


Work in progress
----------------

* Schedule jobs to repeat at regular intervals (separate queue with additional repeat field)
* Specify job dependencies and run jobs in the correct order
* Test job success
