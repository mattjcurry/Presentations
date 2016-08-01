Thanks Matt.

At CompoZed we currently deploy an ecosystem of 15 different products. Some of them belong to the PCF ecosystem, some of them are OpenSource. Each of this products can be deployed in up to 10 different environments. We as part of the the platform team work on managing the complexity of this setup.

Early on we saw concourse as a viable CI/CD solution to help us tackle our desire in automation. At the beginning we did not have a clear vision of how this would ultimately look like. Not over thinking the end solution was key to iterating our way to success. It gave us the opportunity to build the tools we needed among the way.

Before I dive into the different iterations of our automation solution, I would like to quickly cover three concourse concepts, which are resources, jobs, and task.

Lets start with resources. 
Concourse documentation defines a resource as: 'Any entity that can be checked for new versions, pulled down at an specific version, and/or pushed up to idempotently create new versions'
Another way to think about resources is as the preferred way to manage input/output across the the different jobs of a pipeline. 

Which brings me to our next topic, jobs.
Jobs can be defined as: Some actions to perform when dependent resources change (or when manually triggered). 
Among this actions that the definition mention we can find task.

Tasks can be defined as: “the execution of a script in an isolated environment with dependent resources available to it” 

Lets put this concepts in a concrete example. 
While learning concourse we identified a basic pattern for our pipelines. This pattern would end up repeating across all our automation. It consists of 2 types of inputs: Configurations and software. This inputs are ideally managed through concourse resources and get piped into a job that performs a deployment.

Lets take a closer look at this process. Once job gets trigger, either by the resource or manually, resources are pulled by the job. The job takes care of performing all of the different tasks that are defined to perform a deployment. Getting a product to a desire state in a targeted environment.

Once the job finishes successfully, the lifecycle of this pattern is concluded.

We can also extend this pattern to multiple environments; horizontally and vertically.
In this example our pipeline deploys a PCF tile to dev and prod environment. Here once the dev job goes green, it will pipe all of its resource inputs to the next job, which is prod.

With this knowledge in place we started working on our pipelines. We ended up going through 3 phases or iterations.

In our first iteration we would use tasks instead of resources to manage product dependencies. Nowadays a pivnet resource is available, but back then you had 2 options, you could vendor those dependencies or pull them from the internet.
Being a large corporation, we were presented with the typical challenges (firewalls, proxies, etc).  So we ended up vendoring the components into our internal artifact repository.
We put configurations in git repositories and started leveraging concourse git resources to consume them.
For deploying ops manager into vsphere we wrote bash tasks for deploying the appliance.
To handle lifecycle management of products deployed in the platform, we used the experimental API’s that Ops Manager provided wrapped by pretty bash scripts.


show you a picture of how this looked back then in concourse. We used to call it the monstrosity. Still it was pretty to see it running.

Regardless of its size and complexity, it allowed us to codified tile dependencies. Achieve consistency across all environments, and dramatically increase our ability to turn things around quickly.

Working with this pipeline we found ourselves modifying really large and growingly unmanageable pipeline manifests.
As ops manager was evolving rapidly with an unsupported API, it became quite challenging to support and maintain our bash scripts.
We also notice we had very large overhead vendoring dependencies which we could eventually be removed with a proxy.

On our next iteration we changed our stategy.
To solve the size and complexity of our pipeline manifests we move to a having single pipelines per product approach. 
We manage to remove the effort that we had vendoring dependencies internally by pulling them from the internet. Concourse did not have proxy support to so we ended up forking, releasing our own concourse internally.

And finally To support the continiously changing experimental APIs we developed a command line application to interact with OpsManagerAPI. We did the compozed way with high test coverage and integration test suites.

With this changes pipeline definitions became granular and responsible for a single product.
We remove any dependencies between products as each pipeline independent from the rest. This also mean that we had quicker feedback when there was something wrong on a deployment.
Managing multiple experimental versions of ops manager api was now possible and we felt better knowing our tool was tested cross verksion.
We could now pull dependencies directly from the internet.

Moving to the one pipeline per product approach brough some problems too. Now our concourse manifests were repetitive. Specially the jobs as we would have to repeat the exact same definition per job per environment.
Also with our own fork of concourse we gain a effort overhead that we were not satisfied with.

Our third and most recent iteration solved most of this problems.

We went ahead and wrote another tool that we named travel agent. This tool let us codify and test concourse manifest templates.

Newer features in concourse included the ones we were missing. This let us migrate to the main trunk removing the overhead of merging changes internally.
Our friends from pivotal release a pivnet resource which we leverage for all our pipelines to pull ops manager , stemcells and tiles.

Travel agent was probably one of the best tools we could have made for our use case, though I am not particulary proude of how we wrote it. It drastically reduce size and complexity of pipeline definitions, it let us validate generated pipelines against expected values, It reduce human error and brings consistency to all jobs in a pipeline.
Nowadays we no longer maintain a fork for concourse which is nice. 
We no longer mantain bash scripts to pull from pivotal network

our team is partially satisfied with this solutions, eventually

DEMO



