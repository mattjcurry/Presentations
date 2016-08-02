## Script for Concourse Preso

### Matt

Hello everyone and welcome to our talk about untangling platform complexity with Concourse.  My name is Matt Curry and I am the Director of Cloud Engineering at Allstate.  Joining me is one of our Platform leads, Alan Moran.  We are here to talk to you today about how we are using Concourse CI to manage multiple Cloud Foundry Environments.

As many of you know, upgrading, maintaining, and deploying cloud platforms is complex.  Cloud Foundry has buildpacks, tiles, stemcells, and many other components that make managing it at scale not for the faint of heart.  Rich Hickey, the author of the clojoure programming language, gave a talk called "Simple Made Easy."  In that talk, he hilighted how complexity is not driven by the number of moving parts, but how interwoven they are.  We are going to talk to you today about how we used Continuous Integration as a discipline to untangle some of the complexity that is inherent in running multiple Cloud Foundry environments.

We will begin our talk discussing how we have adopted a product mindset as a part of our cultural shift.  We have started to put users first, which has created unprescidented demand for new features from users.  Then, we will tak you through our journey as we iterated from a large monolithic pipeline, to a more manageable configuration with smaller moving parts.  We will close with some of the results of our effort as well as some resources that can enable and empower you to tackle this problem on your own.

One key component to our success in driving the level of automation was culture.  We really emphasize empowerment and collaboration within our teams.  Our platform engineers pair everyday.  They have embraced the agile methodology.  As such, we really focused on iterating our way to success and building quality controls into everything we do.  We talk to our customers everyday and view the platform offering as a product.  We maintain an ongoing backlog of requested platform features.  Based on incoming demand to the team, they decided that the only way they could maintain a sustainable velocity was to reduce the operational overhead of Cloud Foundry to the bare minimum without sacrificing quality.

When we started this journey we had a small team that was managing a few pre-production environments.  We had multiple tiles that were mostly consistently applied across the three environments.  We had no production environment and were spending quite a bit of time on manual upgrades of tiles and stemcells. The amount of time it was taking to upgrade the different tiles was causing us to have different versions across the different platform environments.

With all of our development teams embodying agile, we decided that we needed to take platform operations through that same transformation.  We wanted to continuously diliver the platform.  

When we started, our initial goals were simple.  We wanted to reduce the operational burden of adding and managing new environments.  We wanted to ensure that we could reliably recover from failure, and we wanted to automate all the things.  Massive automation means give me API's or give me death.

There is an incredibly famous book called continuous delivery.  In that book, they talk about the need for releasing software to be easy.  Deploying software should be as simple as pressing a button.  They keys to making that happen is to automate everyhing and to keep everything in version control.  At the end of the day, the platform is just software.  In fact it is lots of software.

---

Hand off to Alan....

---

And through this automation and continuous delivery we have scale.  As you can see, using concourse, we have been able to massively scale the team.  Our developers went from having a small amount of innovation and lots of swearing at GUI's to lots of innovation with someone who is very closely watching the pipeline.

We have acheived substantial results.  Our new environment prep time went from about 60 hours to about half an hour.  Stemcell and tile upgrades are something that we no longer think about. As a result, our team's capacity for innovation went through the roof.

 In summary, we leaned a few lessons a long the way.  Success requires iteration and learning.  It's really important that you are not afraid to do a bit of coding.  And smaller composable pipelines with clear responsibility will set your free of the operational burden of running your platform.


