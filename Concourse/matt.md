## Script for Concourse Preso

### Matt

Hello everyone and welcome to our talk about untangling platform complexity with Concourse.  My name is Matt Curry and I am the Director of Cloud Engineering at Allstate.  Joining me is one of our Platform leads, Alan Moran.  We are here to talk to you today about how we are using Concourse CI to manage multiple Cloud Foundry Environments.

As many of you know, upgrading, maintaining, and deploying cloud platforms is complex.  Cloud Foundry has buildpacks, tiles, stemcells, and many other components that make managing it at scale not for the faint of heart.  Rich Hickey, the author of the clojoure programming language, gave a talk called "Simple Made Easy."  In that talk, he hilighted how complexity is not driven by the number of moving parts, but how interwoven they are.  We are going to talk to you today about how we used Continuous Integration as a discipline to untangle some of the complexity that is inherent in running multiple Cloud Foundry environments.

We will begin our talk discussing how we have adopted a product mindset as a part of our cultural shift.  We have started to put users first, which has created unprescidented demand for new features from users.  Then, we will tak you through our journey as we iterated from a large monolithic pipeline, to a much more complex configuration with smaller moving parts.  We will close with some of the results of our effort as well as some resources that can enable and empower you to tackle this problem on your own.

One key component to our success in driving the level of automation was culture.  We really emphasize empowerment and collaboration within our teams.  Our platform engineers pair everyday.  They have embraced the agile methodology.  As such, we really focused on iterating our way to success and building quality controls into everything we do.  We talk to our customers everyday and view the platform offering as a product.  We maintain an ongoing backlog of requested platform features.  Based on incoming demand to the team, they decided that the only way they could maintain a sustainable velocity was to reduce the operational overhead of Cloud Foundry to the bare minimum without sacrificing quality.



