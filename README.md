# queuer: A simple job scheduler and build system for R
A simple job scheduler and build system for R, written entirely in base R with no dependencies (packages or external applications). 

Jobs (i.e. an R script to run) are defined using a simple R function and saved to an arbitrary queue file. A separate script is called (e.g. as a cron job) to run the jobs sequentially.

Alternatively, a build file may be created for a project, defining the jobs to be run and the prerequisites for each script. The `build` function can then be used to build all or part of the project.

__Project status:__ queuer is new under active development. The core functionality appears to work reliably (at least in a Windows environment) but further testing is necessary.


Why use queuer?
---------------
queuer has the following primary use cases:

1. To schedule scripts from multiple projects to run sequentially at a convenient time (e.g. over night)
2. As a simple client-server solution. For example, jobs can be scheduled from a notebook and run automatically from a server.
3. As a simple build system (like GNU Make) to bring order to a project, enabling multiple scripts to be run automatically in a defined order.

The primary advantage of queuer is that it is written purely in base R. There are no package dependencies and no external software to install and configure. 
queuer is intended as a simple solution for single users or small groups of users. It is not intended as an enterprise solution (lacking security, scalability and auditing features) and is not a cluster management tool (such as LSF).


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

## Build files
Build files help to structure a project by defining which script need to be run and in which order. The file defines the job name, script and optionally the prerequisite jobs:

```
Name: Data_Query
Script: data_query.R

Name: Data_Processing
Script: data_processing.R
Prerequisites: Data_Query

Name: Data_Analysis
Script: data_analysis.R
Prerequisites: Data_Processing
```

The `build` function can be used to create and process a queue from a given build file. By default, the jobs are run immediately (`process = TRUE`); alternatively, the queue can be processed at a later data (e.g. jobs added to an existing queue with scheduled cron job).

## Alternative Solutions

* `scheduler` (https://github.com/Bart6114/scheduleR) is very similar in conception but has a number of dependencies (shiny, mongodb, node.js) that make installation difficult or impossible.
* `batch` (https://cran.r-project.org/web/packages/batch/) makes it easier to pass arguments to R scripts and queue jobs using dedicated cluster tools (e.g. bsub).
* `BatchJobs` provides Map/Reduce/Filter functionality to interface with dedicated batch computing systems

Alternative build systems:

* `GNU Make` is powerful and widely used with R, especially on UNIX-like systems. However, the syntax can be complex and Make is an external dependency that can be difficult to get running under Windows.
* `luigi` (https://github.com/spotify/luigi) is a pipeline manager for python. An R-based version is available at https://github.com/kirillseva/ruigi. These systems are more complex than queuer and have dependencies.

Work in progress
----------------

* Schedule jobs to repeat at regular intervals (separate queue with additional repeat field)
* Specify job dependencies and run jobs in the correct order
* Test job success
