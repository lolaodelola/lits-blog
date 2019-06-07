---
template: post
title: Let’s Get Lost in Types
slug: types
draft: false
date: 2019-06-07T14:18:14.969Z
description: Ruby’s dynamically typed fluidity vs Java’s statically typed rigidity.
category: Programming
tags:
  - Ruby
---
I’m a Ruby coder, it’s the first language I fell in love with (although not the first language I learnt) and part of the reason I fell in love with Ruby is because I found it accessible. It reads really well and I found it super easy to understand. That’s great stuff for a beginner, but since then, I’ve come to love something else: Ruby is a dynamically typed language. Honestly, for a long time I didn’t even know what that meant, I just knew it to be true. Programming languages tend to fall into two camps, **statically typed** and **dynamically typed**.

**Type**: This refers to the kind of object. So an integer is a type of object, a string is a type of object, if you had car objects in your application, then a car would be a type of object.

**Statically typed**: These languages check the types that variables should contain and methods should return, at compile time, which means they need to be explicitly stated in the code. E.g. Java, C#, Go

**Dynamically typed**: These languages check types at run-time which means that the type doesn’t need to be explicitly stated, the program will compile and run regardless. E.g. Ruby, Python, JavaScript, PHP

***

It’s one thing to know the words and language but it’s a whole other thing to use and see it in practice. I didn’t realise the real difference until I began to learn Java. Moving from the fluidity of Ruby to the rigidity of Java has been a pain point. Let me explain.

Let’s say I want to write a method that searches for a contact in an address book when I give it the name of a contact. If the contact exists then I want to return the contact, if it doesn’t I want to put a message out to the user that says the contact doesn’t exist. I’d probably do something like
