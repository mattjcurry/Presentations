---
Thanks Matt.

At CompoZed we currently deploy an ecosystem of 15 different products. Some of them are part of PCF ecosystem, some of them are OpenSource. Each of these products can be deployed in up to 10 different environments. With this setup managing our infrastructure manually is not an option.

Early on we saw concourse as a viable CI/CD solution to help us tackle our desire in automation. 
We like concourse because it scales with our platform, all configuration are in declarative files and its core concepts are simple.

Before I dive into the details of our automation solution, I would like to quickly cover three concourse concepts, which are resources, jobs, and task.

Resources are versionable entities that can be pulled by a job.
a good example are Stemcells, which are versioned OS images. When a stemcell is released on pivotal network, we want to apply it in our infrastructure. In this case A pivnet resource checks for the latest released Stemcell and pipes it into a job that performs the upgrade.

Which bring me to my next topic jobs.
Jobs are set of actions. Going back to our stemcell example. When a new Stemcell gets released it can trigger a job that perform the upgrade.

Jobs can be compose of various actions among which we can find tasks. Task are scripts that can run in isolated environment and form part of the build plan of a job.

While learning concourse we identified a basic pattern or building block for our pipelines. This pattern ended up repeating across all our automated pipelines. It consists of 2 
types of inputs: Configurations and software. These inputs are ideally managed through concourse resources and get piped into a job that performs a deployment.

Let’s take a closer look at this process. Once a job gets trigger, either by the resource or manually, resources are pulled by the job. The job takes care of performing all of the different actions that are defined for a given deployment. Once all of then run successfuly the job goes green.


We can also extend this pattern to multiple environments.
In this example our pipeline deploys a PCF tile to dev and prod environments. Here once the dev job goes green, it will promote all of its resource dependencies the the next environment, which is prod. Once the job finishes successfully, the lifecycle of this pattern is concluded.

At the beginning we did not have a clear vision of how our solution would ultimately look like. Not over thinking the end solution was key to iterating our way to success. It gave us the opportunity to build the tools we needed along the way.  We ended up going through 3 phases or iterations.

In our first iteration we would use tasks instead of resources to manage product dependencies.
Being a large corporation, accessing the public internet is not always possible. So we ended up storing artifacts in local repositories. 
We track configurations git repositories and consume them with concourse resource.

For deploying ops manager appliance and tiles we used concourse tasks written in bash.
and to manage tiles lifecycle we would make use of the Ops Manager api. 

this pipeline allowed us to codified tile dependencies, Achieve consistency across all environments and reduced the overall engineering time.

Here is a picture of how this looked back then in concourse. it was a mounstrous pipeline. we were proud of it still.

Working with this pipeline we found ourselves modifying really large and growingly unmanageable pipeline manifests.
As ops manager was evolving rapidly with an unsupported API, it became challenging to support and maintain our bash scripts.

On our next iteration we changed our strategy.
To solve the complexity of our pipeline manifests we moved to a single pipelines per product approach.
we ended up forking, managing and releasing our own concourse internally to add proxy support. this way we could pull  dependencies directly from the interent.

We deprecated our bash task and build a ruby gem that we could cross test with differnt ops_manager versions

With these changes pipeline definitions became granular and responsible for a single product.
Managing multiple experimental versions of ops manager api was now possible and we felt better knowing our tool was tested cross version.
We could now pull dependencies directly from the internet.

Moving to the one pipeline per product approach was not enough. Now our concourse manifests were repetitive. Especially the jobs as we would have to repeat the exact same definition per job per environment.
Also with our own fork of concourse we gain an effort overhead that we were not satisfied with.

Our third and most recent iteration solved most of these problems.

We wrote another tool that we named travel agent. This tool enable us to codify and test concourse manifest templates makeing it easier to keep consistency in our pipelines.

As new features made their way into concourse, we were able to stop mantaining a fork and just use the OS release.
we started using pivnet resource which further simplified our deployment process.

With these efforts we werable able to massible reduce the size of the pipeline definitions which reduced human error. yet again we saw a reduction in engineering time.

I am going to let Matt finish off with results, learnings and how to get started.


