**Matt:**

- Intro
- Present yourself

**Alan:**

- My name is Alan Moran. 
- I am a CloudFoundry Architect working with the compozed platform team
- I been working with CF for the past 4 years

**Matt:**

Culture influences Automation.  Why did we do this?

**Matt:**

Alan will cover now cover some of the implementations details of our pipelines.

**Alan:**

Thanks Matt.

<span style="color:orange;">Getting started</span>

- Over the last year our pipelines went through several iterations
- We did not have a clear view of how this would ultimately look like.  So not over thinking the end solution was key to iterating our way to success.
- The team decided that Concourse was a viable tool to help us tackle our desire in automation.  
- However the team did not have any experience with Concourse, so through our journey, we have acquired the knowledge and understanding of the tool that has allowed us to mature our automation pipelines.

<span style="color:orange;">Basic pipeline pattern for the platform</span>

**Slide:**
<span style="color:green;"> Basic pipeline pattern for the platform</span>

- Early on we identify the basic pattern for our pipelines
- This pattern ended up repeating across all of our product pipelines
- It consists of 2 types of inputs: Configurations and software. And actions that use these inputs to deploy a particular piece of software

<span style="color:orange;">How this pattern would work ideally in concourse</span>

**Slide:**
<span style="color:green;"> Basic concourse pipeline #slide1</span>

- Ideally concourse manages inputs through resources.
- Concourse documentation defines a resource as:
- "any entity that can be checked for new versions, pulled down at a specific version, and/or pushed up to idempotently create new versions" _source concourse.ci_
- This resources get pulled by a job
- Concourse documentation defines a job as:
- "some actions to perform when dependent resources change (or when manually triggered)" _source concourse.ci_
- The job take care of performing all the different actions to deploy software to a desire state
- This set of actions within the job are concourse task.
- Concourse documentation defines a task as:
- “the execution of a script in an isolated environment with dependent resources available to it" _source concourse.ci_

**Slide:**
<span style="color:green;"> Basic concourse pipeline #slide2</span>


- Once jobs build successfully the resources get promoted to the next job, which from a platform perspective would be the next environment


<span style="color:orange;">Our first attempt</span>

**Slide:**
<span style="color:green;">Attempt Number One</span>

