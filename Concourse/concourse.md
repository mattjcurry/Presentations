footer: © Matt Curry, 2016
slidenumbers: true
autoscale: true 

![fit] (../common/images/cl_wallpaper9.jpg)

---

# [fit] Untangling Platform Complexity with Concourse CI

---

# [fit] Summary
  - Product mindset drives an automation heavy culture
  - We iterated our way to success
  - We have created engineering capacity through automation
  - You can do it too!

---

# [fit] Culture

---

# Platform as a Product
  - Customer
      - Developers that need to deploy operable software quickly and reliably without friction. 
  - Problem
      - Developers spend too much time on process heavy lifing and non-business value added work.
      - Developers expect access to the latest and greatest technolgy for use with their products.
  - Solution
      - An integrated platform with connected services that make the right thing the easy thing.
      - Minimize the operational burdon of operating the overall platform.

(https://public-media.interaction-design.org/images/encyclopedia/activity_theory/activity_theory_triangle_engestrom.gif)

---

# The Starting Point
  - ELK
  - 6 Cloud Foundry Foundations in 3 environments (Need a pic)
  - No Production
  - No Automation
  - Several tiles (Mobile push, mySQL, Redis)

---

# % of time Upgrading CF
  - Basically 100% of engineering time
  - Tiles broke frequently
  - Lack of consistency

(Operational Tax Rate was high)

---

# Our Goal

  - Reduce the operational burden of running and scaling the platform.
  - No more #@$*^$ GUI's.
  - Be able to reliably and quickly build new environments
  - Ensure that our CF environments look consistent

---

# Solution Requirements

  - Environments can be represented and versioned through source control
  - Automated testing for all platform components
  - Support the complex workflow of deploying CF
  - Manage all the things

---

Doing the right thing vs Doing the thing right now

---

# [fit] The Journey

---

# Attempt number one

Single pipeline to rule them all (pic)

- Let concourse manage binary dependencies through resources
- Let git be our source of configuration for our environments
- Bash to interact with experimental ops manager api

---

# Problems

- Concourse manifest was large and repetitive
- Managing multiple concurrent versions of Ops Manager was difficult with bash
- Concourse didnt support proxies

---

# Attempt number two

- Generate single pipelines per product
- Build ops manager cli to manage concurrent versions of the api
- Manage, release and deploy our own fork of concourse

---

# Problems

- Concourse manifest were still large and repetitive






- writting a template tool specifically develop for concourse









# We started with a really big pipeline

---

# Initial success
    - What did we gain?
    - Do we have numbers?

---

# There were some issues with it
    - was difficult to maintain
    - XYZ

---

# [fit] We iterated

---

