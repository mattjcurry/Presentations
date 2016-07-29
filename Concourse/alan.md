
<span style="color:orange;">Concourse logo</span>

Thanks Matt and thanks everyone for joining us. 

Early on our team decided that Concourse was a viable CI/CD solution to help us tackle our desire in automation. At the begining We did not have a clear view of how this would ultimately look like. Not over thinking the end solution was key to iterating our way to success. it gave us the oportunity to build the tools we needed among the way.

Before starting showing the different iterations of our automation solution I would like to introduce some concourse concepts for anyone new to the technology.

<span style="color:orange;">Resources</span>

Concourse documentation defines a resource as: 'Any entity that can be checked for new versions, pulled down at a specific version, and/or pushed up to idempotently create new versions'
An example of a resource could be stemcells, tiles or a git repo, esentially is an abstraction of an entity that you can version.

<span style="color:orange;">Tasks</span>

- the execution of a script in an isolated environment with dependent resources available to it
- An example of a task could be uploading stemcell to bosh, performing a change on a file, running a command.

<span style="color:orange;">Jobs</span>

Some actions to perform when dependent resources change (or when manually triggered)
- This can be a deploy CF on a particular environment.

<span style="color:orange;"> Basic pipeline #slide1</span>

- From a plataform perspective we identified a pattern for our pipelines.
- This pattern ended up repeating for all our product pipelines
- It consists of 2 types of inputs: Configurations and software. And jobs that use these inputs to deploy a particular piece of software in a particular environment
- Ideally concourse manages inputs through resources.

<span style="color:orange;"> Basic concourse pipeline #slide2</span>

- Ones a job build gets trigger, either manually or automatically, resources are pulled by a job
- The job takes care of performing all the different tasks to deploy that software to a desire state on a particular environment

<span style="color:orange;"> Basic concourse pipeline #slide2</span>

- Once the job finish successfully the lifecycle of this pattern finishes

<span style="color:orange;"> Basic concourse pipeline</span>

- Now we can also extend this pattern to multiple environmenthorizontally and vertically.
- In this example once Dev job goes green those resource versions that when green on Dev get promoted to Prod.

<span style="color:orange;"> The Journey </span>

- During our year working with concourse we went through 3 main phases or iteration

<span style="color:orange;"> Iteration 1 </span>

- There was no pivnet resource back in the day so we would manage plataform components with tasks.
- We let concourse git resource manage our configurations so we starting tracking all our configs in git.
- We would use concourse tasks and bash to deploy ops manager appliance.
- We would interact with ops managar through its experimental API so that wo








