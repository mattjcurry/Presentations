
<span style="color:orange;">Concourse logo</span>

Thanks Matt and thanks everyone for joining us. 

Early on our team decided that Concourse was a viable CI/CD solution to help us tackle our desire in automation. At the beginning we did not have a clear view of how this would ultimately look like. Not over thinking the end solution was key to iterating our way to success. It gave us the opportunity to build the tools we needed among the way.

Before I start showing you the different iterations of our automation solution, I would like to introduce some basic concourse concepts for those of you who are new to the technology.  I will quickly cover resources, tasks, and jobs.

<span style="color:orange;">Resources</span>

First item will be resources. 
Concourse documentation defines a resource as: 'Any entity that can be checked for new versions, pulled down at a specific version, and/or pushed up to idempotently create new versions'
An example of a resource could be stemcells, tiles or a git repo, essentially it is an abstraction of an entity that you can version.

<span style="color:orange;">Jobs</span>

Which brings me to our next topic,  jobs.
Jobs can be defined as: Some actions to perform when dependent resources change (or when manually triggered). 
This can be, for example, an update to a deployment configuration when a git repo is modified

<span style="color:orange;">Tasks</span>

Which brings me to our NEXT topic, Tasks. A task can be defined as: “the execution of a script in an isolated environment with dependent resources available to it”
An example of a task could be a bash script performing a change on a file.

<span style="color:orange;"> Basic pattern #slide1</span>

From a platform perspective we identified a pattern for our pipelines. This pattern ended up repeating across all our pipelines. It consists of 2 types of inputs: Configurations and software. Ideally managed through concourse resources. And a job that uses these inputs to deploy a particular piece of software in a particular environment.

<span style="color:orange;"> Basic pattern #slide2</span>


Once a resources changes and a build gets triggered, resources are pulled by the job. The job takes care of performing all of the different tasks that are defined to deploy that software. It takes care of getting the targeted environment to a desired state.

<span style="color:orange;"> Basic pattern #slide3</span>

Once the job finishes successfully, the lifecycle of this pattern is concluded

<span style="color:orange;"> Basic concourse pipeline</span>

Now we can also extend this pattern to multiple environments; horizontally and vertically.
In this example once the DEV job goes green, it will pipe all of its resource inputs to the next job, which is PROD

<span style="color:orange;"> The Journey </span>

During our year working with concourse, we went through 3 main phases or iterations. The first of which was the most challenging. Mainly because we needed to improvise. 

<span style="color:orange;"> Iteration 1 </span>

In this implementation we would get component dependencies with tasks and not with resources. Nowadays a pivnet resource is available, but back then you could only pull from the internet or vendor those file.
Being a large corporation, we were presented with the typical challenges (firewalls, proxies, etc).  So we ended up vendoring the components into our internal artifact repository.
We began tracking all of our configurations in git repositories and started leveraging concourse git resources to consume them.
For deploying ops manager into vsphere we wrote bash tasks to handle downloading and deploying the appliance.
To handle the required level of automation for lifecycle management of products, we used the experimental API’s that Ops Manager provided wrapped by pretty bash scripts.

<span style="color:orange;"> Iteration 1 #</span>

And this is what came out of it. We used to call it the monstrosity. But boy was it pretty when it ran.

<span style="color:orange;"> Benefits </span>

Regardless of its size and complexity, it allowed us to codified tile dependencies. Achieve consistency across all environments, and dramatically increase our ability to turn things around quickly.

<span style="color:orange;"> Opportunities </span>

Working with this pipeline we found ourselves modifying really large and growingly unmanageable pipeline manifests.
As ops manager was evolving rapidly with an unsupported api, it became quite challenging to support and maintain our bash scripts.
We notice we had very large overhead vendoring dependencies which we could remove with a proxy.



