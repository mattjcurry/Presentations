
![fit] (../common/images/cl_wallpaper9.jpg)

---

# Spring Boot for the Uninitiated

---

## Objectives

- Understand Interfaces
- Understand Abstract Factories
- Understand Inversion of Control
- Understand using Spring for it
- Get a better Grasp on spring boot
- Depoloy something cool!

-

# What is an interface?

---

# Why do we use them?
##Loose Coupling

---

# An exercise using an interface...

---

# The abstract factory pattern

---

# An exercise using Abstract Factory

---

# @WhatTheEffIsAnAnnotation?

---

# Replacing an abstract factory with @autowired

---

# Spring Boot

---

# start.spring.io
### using curl
### brew install spring_boot

---

```bash
touch hello.groovy
atom hello.groovy
```

---

```java
@RestController
class GreetingsRestController {
    @RequestMapping("/hi/{name}")
    def hi(@PathVariable String name) {
        [ greeting: "Hello, " + name + "!" ]
    }
}
```

---

```bash
spring run hello.groovy
```

---

# Let's do something interesting with boot

---


