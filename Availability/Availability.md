autoscale: true
footer: © Matt Curry, 2016
slidenumbers: true
theme: Letters from Sweden, 1

![fit] (../common/images/this_is_fine.jpg)

# Availability
## Everything is on fire

---

# Availability

In reliability theory and reliability engineering, the term availability has the following meanings: The degree to which a system, subsystem or equipment is in a specified operable and committable state at the start of a mission, when the mission is called for at an unknown, i.e. a random, time.

---

# Ops vs Dev


**Ops:** The app teams need to make more resilient apps

**Dev:** The infrastructure needs to not fail

**Reality:** The problem must be solved from both directions simultaneously

---

#SLA's

Your customer does not give a crap about your SLA's.  They care if they can access your service or not when they need it.

---

![fit original] (../common/images/disaster_girl.jpg)

# Who Owns Your Availability?

---

![left] (../common/images/uncle_sam.jpg)

# [fit] YOU DO!

---

# [fit] But a dependency failed!

---

# [fit] You own your availability

---

# [fit] But data corruption

---

![fit original] (../common/images/trump-pointing.jpg)

<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
# [fit] You still own your availability

---

# [fit] But an Oracle/IBM/HP/Vendor Bug

---

![fit original] (../common/images/mr-t-pointing.jpg)

<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>

# [fit] You and only you own your availability

---

# Now that we have got the point across.

---

# The failed promise of ITIL 
## Operational frameworks won't help you engineer better systems.

- X% of outages are caused my change is not an actionable metric.
- Human Error is not a legitimate root cause because it does not address the problem that humans should not be able to make an entire system fail.
- Most ITIL shops have many root causes that all mean Human Error:
    - Did not follow process
    - Did not file change ticket
    - Did not go through CAB
- ITIL mostly improves availability by slowing change velocity to a crawl.

---

![right] (../common/images/ghost_rider.jpg)


# Something Different

- Expect Failures [^1]
- Keep things simple [^1]
- Automate Everything [^1]

[^1]: [On Designing and Deploying Internet-Scale Services, James Hamilton] (https://www.usenix.org/legacy/event/lisa07/tech/full_papers/hamilton/hamilton_html/)

---

![left] (../common/images/james_hamilton.jpg)

# James Hamilton
## Amazon Architect

If you only read one paper on IT operations at scale, this is the one you should read.

[On Designing and Deploying Internet-Scale Services] (https://www.usenix.org/legacy/event/lisa07/tech/full_papers/hamilton/hamilton_html/)


---

>  If development is frequently called
in the middle of the night, automation is the likely
outcome. If operations is frequently called, the
usual reaction is to grow the operations team.

-- James Hamilton

---

![left](../common/images/jeff_dean.jpg)

# Jeff Dean
## Google Architect

[Building Software Systems at Google and Lessons Learned] (http://static.googleusercontent.com/media/research.google.com/en//people/jeff/Stanford-DL-Nov-2010.pdf)

---

![left](../common/images/billy_joel.jpg)

# Billy Joel
## Song Writer

[We Didn't Start the Fire] (https://play.google.com/music/preview/Tco7uco7jqcs3tm4zebdwxm46ea?lyrics=1&utm_source=google&utm_medium=search&utm_campaign=lyrics&pcampaignid=kp-lyrics)

> We didn't start the fire
No, we didn't light it, but we tried to fight it

---

![fit original] (../common/images/tirefire.jpg)

# Availability Zone Limitations on PCF

- With Vsphere, you cannot have more than one Vcenter per CF Install
- You must have shared storage across all VMWare clusters.

---

# [fit] Core 4 Principles of Availability
- **Isolation** - Bulkhead - Shared nothing processing.
- **Data Locality** - Return requests to original zone where possible.
- **Laziness** - Eventual consistency for all state interactions
- **Resilience** - Retry or Rerouting of traffic

Bonus: Fail open / circuit breaker for centralized services.

---

![fit] (../common/images/bulkhead.jpg)

# Bulkhead

---

# Bulkheads

- How the application maps on to physical infrastructure matters.
- Fault isolation should include fire suppression systems and power facilities.
- How applications map onto bare metal matters.
- We will refer to the bulkheads as processing zones.
- Running processing zones in an active/active pattern constantly validates that they can take traffic.
- Moving traffic is faster than fixing root cause.
- Allows higher level understanding of application interactions, without having to understand deep details.

---

# Isolation Benefits:

- Decouples service restoration from fixing root cause.
- Provides silos for testing that impact a subset of traffic.
- Humans can only impact 1/n of traffic.
- Maintenance can be typically done without downtime.
- Keeps complexity out of infrastructure by keeping clean separation of processing units.

---

# A little Math

4 9's infrastructure is almost impossible to achieve with a single fault domain.

Required Availability of each zone if you have 2

$$.00001 = x^2$$

$$x = 99.7\%$$

<br><br>
Required Availability of each zone if you have 3

$$.00001 = x^3$$

$$x = 97.8\%$$

---

![fit original] (../common/images/CF_AWS_AZ.png)

---

# Data Locality

- Session affinity is bad in that a request fails if it does not go back to the same data center.
- However, preference to the same data center should be given where possible.
- Benefits:
    - Cache warming
    - Local Data access
    - Reduce odds of replication delay as a failure mode

---

![](../common/images/glue.jpg)

# Stickiness

---

![fit original] (../common/images/CF_Stickiness.png)


---

# Data is hard

- Eventual consistency is a must for replication across processing zones.
- Apps should read local wherever possible, even if they need to write to a remote master.
- Know your replication delay vs your typical request/response cycle.  What are the odds that you can route a customer to a new zone before their data gets replicated?
- Journaling enables playback at a later time in case of System of Record failure.

---

# Retry failed requests at the top

- If a request fails because of a missing dependency or version mismatch, re-route the request to a different processing zone and try there.
- This can be done in front of the applications, but you must be able to process requests out of all zones.
- Most of us are deploying webapps.  Standard HTTP codes can be used to re-route traffic.

---
  
![left] (../common/images/human_torch.jpg)

# Extra Credit for Serious Availability

---

# Environmental consistency

- Test environments should look like production.
    - Firewalls
    - Databases
    - Multiple processing zones

---

# Shared resources

- Async communication prevents cascading failure.
- Have reasonable timeouts.
- Core resources need to be able to shed load. (Big red switch) [^1]
    - Shed slow requests
    - Shed by client application
    - Shed by user priority
- When talking downstream to shared resources, patterns like circuit breaker will allow for failing open.

[^1]: [On Designing and Deploying Internet-Scale Services, James Hamilton] (https://www.usenix.org/legacy/event/lisa07/tech/full_papers/hamilton/hamilton_html/)

---

# Release management

- **Prevent Zombies:** Apps should not start if they are not in a working state. 
    - Check for dependencies on startup
    - Check that configs are valid on startup 
    - Prevents missed firewall rule in environment X.

- **Maintain release independence**
    - Means that you have to support good API versioning and service compatibility.
    - Don't make backwards incompatible changes.

- **Use canary releases**
    - Have a way to test new code in production on a subset of users. 

---

# Summary

- **Isolation** - Simplify and contain complexity. 
- **Data Locality** - Send traffic where the most correct data is likely to be.
- **Laziness** - Eventual consistency for all state interactions
- **Resilience** - Retry requests that are likely to fail.

---

![left 30%] (../common/images/deployadactyl.jpeg)

# Announcing Deployadactyl
### An open source for deploying to multiple CF foundations

Deployadactyl is a Go library for deploying applications to multiple Cloud Foundry instances. Deployadactyl utilizes blue green deployments and if it's unable to push your application it will rollback to the previous version. Deployadactyl utilizes Gochannels for concurrent deployments across the multiple Cloud Foundry instances.

[Star us on Github] (https://github.com/compozed/deployadactyl)

