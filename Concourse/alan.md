Thanks Matt.

Early on we saw concourse as a viable CI/CD solution to help us tackle our desire in automation. At the beginning we did not have a clear idea of how this would ultimately look like. Not over thinking the end solution was key to iterating our way to success. It gave us the opportunity to build the tools we needed among the way.

Before I start showing you the different iterations of our automation solution, I would like to introduce some basic concourse concepts for those of you who are new to the technology.  I will quickly cover three different concepts, which are resources, jobs, and task.


Lets start with resources. 
Concourse documentation defines a resource as: 'Any entity that can be checked for new versions, pulled down at a specific version, and/or pushed up to idempotently create new versions'
To put it in other words resources are the preferred way to manage input/output across the pipeline. 


Which brings me to our next topic,  jobs.
Jobs can be defined as: Some actions to perform when dependent resources change (or when manually triggered). 
Among this actions that the definition mention there can be tasks.

Which brings me to our final topic, Tasks. They can be defined as: “the execution of a script in an isolated environment with dependent resources available to it” 

While learning concourse we identified a basic pattern for our pipelines. This pattern ended up repeating across all our automation. It consists of 2 types of inputs: Configurations and software. This inputs are ideally managed through concourse resources and get piped into a job to deploy a piece of software.

Lets take a closer look at this process. Once a resources changes and a build gets triggered, resources are pulled by the job. The job takes care of performing all of the different tasks that are defined to deploy that software. It takes care of getting the targeted environment to a desired state.

Once the job finishes successfully, the lifecycle of this pattern is concluded.

We can also extend this pattern to multiple environments; horizontally and vertically.
In this example once the dev job goes green, it will pipe all of its resource inputs to the next job, which is prod.

Our journey with concourse went through 3 main phases or iterations so far. The first of which was the most challenging. Mainly because we needed to improvise. 

Lets tackle some technical details of this implementation.

In our first implementation we would get component dependencies with tasks and not with resources. Nowadays a pivnet resource is available, but back then you could only pull from the internet or vendor those file.
Being a large corporation, we were presented with the typical challenges (firewalls, proxies, etc).  So we ended up vendoring the components into our internal artifact repository.
We began tracking all of our configurations in git repositories and started leveraging concourse git resources to consume them.
For deploying ops manager into vsphere we wrote bash tasks to handle downloading and deploying the appliance.
To handle lifecycle management of products deployed in the platform, we used the experimental API’s that Ops Manager provided wrapped by pretty bash scripts.


And this is what came out of it. We used to call it the monstrosity. Still it was pretty to see it running.

Regardless of its size and complexity, it allowed us to codified tile dependencies. Achieve consistency across all environments, and dramatically increase our ability to turn things around quickly.

Working with this pipeline we found ourselves modifying really large and growingly unmanageable pipeline manifests.
As ops manager was evolving rapidly with an unsupported API, it became quite challenging to support and maintain our bash scripts.
We notice we had very large overhead vendoring dependencies which we could eventually be removed with a proxy.
