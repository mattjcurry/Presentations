Thanks Matt.

At CompoZed we currently deploy an ecosystem of 15 different products. Some of them are part of PCF ecosystem, some of them are OpenSource. Each of these products can be deployed in up to 10 different environments. We as platform engineers work on managing the complexity of this setup.

Early on we saw concourse as a viable CI/CD solution to help us tackle our desire in automation. 
We like concourse because it scales nicely, all configuration are in declarative files and its core concepts are simple.

At the beginning we did not have a clear vision of how our solution would ultimately look like. Not over thinking the end solution was key to iterating our way to success. It gave us the opportunity to build the tools we needed  along the way.

Before I dive into the different iterations of our automation solution, I would like to quickly cover three concourse concepts, which are resources, jobs, and task.

Resources are in charge of managing inputs and outputs across the pipeline. 
a good example are Stemcells, which are versioned OS images. When a stemcell is
released on pivotal network, we want to apply it in our infrastructure. In this case A pivnet concourse resource checks for  the latest released Stemcell and pipes it into a job that performs the upgrade.

Jobs are set of actions. Going back to our stemcell example. When a new Stemcell gets released it can trigger a job that perform the upgrade.

Jobs can be compose of various actions among which we can find tasks. Task are isolated steps that we perform in our jobs.

While learning concourse we identified a basic pattern for our pipelines. This pattern ended up repeating across all our automated pipelines. It consists of 2 
types of inputs: Configurations and software. These inputs are ideally managed through concourse resources and get piped into a job that performs a deployment.

Let’s take a closer look at this process. Once a job gets trigger, either by the resource or manually, resources are pulled by the job. The job takes care of performing all of the different tasks that are defined for a given deployment. 

Once the job finishes successfully, the lifecycle of this pattern is concluded.

We can also extend this pattern to multiple environments.
In this example our pipeline deploys a PCF tile to dev and prod environments. Here once the dev job goes green, it will pipe all of its resource inputs to prod.

With this knowledge in place we started working on our pipelines. We ended up going through 3 phases or iterations.

In our first iteration we would use tasks instead of resources to manage product dependencies. Nowadays a pivnet resource is available, but back then you had 2 options, you could  store dependencies as local artifacts or pull them from the internet.
Being a large corporation, accessing the public internet is not always possible. So we ended up storing artifacts in local repositories. 
We put configurations in git repositories and used concourse git resources to consume them.
For deploying ops manager appliance into vsphere we wrote bash tasks.
To handle lifecycle management of products deployed in the platform, we used the experimental API’s that Ops Manager provided wrapped by pretty bash scripts.


Here is a picture of how this looked back then in concourse. We used to call it the monstrosity. Still it was pretty to see it running.

Regardless of its size and complexity, it allowed us to codify tile dependencies. Achieve consistency across all environments, and dramatically increase our ability to turn things around quickly.

Working with this pipeline we found ourselves modifying really large and growingly unmanageable pipeline manifests.
As ops manager was evolving rapidly with an unsupported API, it became quite challenging to support and maintain our bash scripts.
We also notice we had very large overhead vendoring dependencies which we could eventually be removed with a proxy.

On our next iteration we changed our strategy.
To solve the size and complexity of our pipeline manifests we moved to a single pipelines per product approach.
We managed to remove the effort that we had vendoring dependencies internally by pulling them from the internet. Concourse did not have proxy support so we ended up forking, managing and releasing our own concourse internally.

And finally To support the continuously changing experimental APIs we developed a command line application to interact with OpsManagerAPI. We did this the compozed way with high test coverage and integration test suites.

With these changes pipeline definitions became granular and responsible for a single product.
Managing multiple experimental versions of ops manager api was now possible and we felt better knowing our tool was tested cross version.
We could now pull dependencies directly from the internet.

Moving to the one pipeline per product approach brought some problems too. Now our concourse manifests were repetitive. Specially the jobs as we would have to repeat the exact same definition per job per environment.
Also with our own fork of concourse we gain an effort overhead that we were not satisfied with.

Our third and most recent iteration solved most of these problems.

We went ahead and wrote another tool that we named travel agent. This tool let us codify and test concourse manifest templates.

Newer features in concourse included the ones we were missing. This let us migrate to the main trunk removing the overhead of merging changes internally.
Our friends from pivotal developed a pivnet resource which we leverage for all our pipelines to pull ops manager , Stemcells and tiles.

Travel agent was probably one of the best tools we could have made for our use case, though I am not particularly proud of how we wrote it. It drastically reduce size and complexity of pipeline definitions, it let us validate generated pipelines against expected values, It reduce human error and brings consistency to all jobs in a pipeline.
Nowadays we no longer maintain a fork for concourse which is nice.
We no longer maintain bash scripts to pull dependencies from the internet




