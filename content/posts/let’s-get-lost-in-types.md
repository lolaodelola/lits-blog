---
template: post
title: Let’s Get Lost in Types
slug: types
draft: false
date: 2019-03-07T00:00:14.969Z
description: Ruby’s dynamically typed fluidity vs Java’s statically typed rigidity.
category: Programming
tags:
  - Ruby
  - Java
---
I’m a Ruby coder, it’s the first language I fell in love with (although not the first language I learnt) and part of the reason I fell in love with Ruby is because I found it accessible. It reads really well and I found it super easy to understand. That’s great stuff for a beginner, but since then, I’ve come to love something else: Ruby is a dynamically typed language. Honestly, for a long time I didn’t even know what that meant, I just knew it to be true. Programming languages tend to fall into two camps, **statically typed** and **dynamically typed**.

**Type**: This refers to the kind of object. So an integer is a type of object, a string is a type of object, if you had car objects in your application, then a car would be a type of object.

**Statically typed**: These languages check the types that variables should contain and methods should return, at compile time, which means they need to be explicitly stated in the code. E.g. Java, C#, Go

**Dynamically typed**: These languages check types at run-time which means that the type doesn’t need to be explicitly stated, the program will compile and run regardless. E.g. Ruby, Python, JavaScript, PHP

- - -

It’s one thing to know the words and language but it’s a whole other thing to use and see it in practice. I didn’t realise the real difference until I began to learn Java. Moving from the fluidity of Ruby to the rigidity of Java has been a pain point. Let me explain.

Let’s say I want to write a method that searches for a contact in an address book when I give it the name of a contact. If the contact exists then I want to return the contact, if it doesn’t I want to put a message out to the user that says the contact doesn’t exist. I’d probably do something like

![Ruby search_contacts method](/media/types_ruby_search.png " Ruby search_contacts method. I’ve explicitly returned `result` but this is unnecessary in Ruby, Ruby methods return the last thing in the method.")

Depending on which part of the condition is met, the method will either return a `Contact` or a `String` . This makes perfect sense in Ruby. This is the joy of a dynamically typed language, your method isn’t constrained by what kind of object it should return, sometimes you want to return different types in the same method.

Now, when I tried to do the same thing in Java, I got errors on errors on errors. Well, actually, only one error but still.

![Wrong Java implementation of searchContact method](/media/types_wrong_java.png "Wrong Java implementation of searchContact method")

Java forces you to tell each method, in this case `searchContact` and each variable, `name` and `result` , what type it should return. So there, on the very first line, I’ve told it to return a `Contact` type but then I’ve said depending on which condition is met, return a `Contact` or a `String`. My program is confused, why will I give it the option of returning a `String` when I’ve already told it, it can only return a `Contact`? Don’t get me wrong, this also makes sense. I get it. However it took a minute to shift my mindset.

My next question was “but how do I tell the user that the contact doesn’t exist? Returning \`null\` isn’t helpful!”, this is what a friend had to say:

![whatsapp conversation with friend telling me Java won't let me get away with what Ruby does](/media/types_whatsapp.png "whatsapp conversation")

Jokes aside, it does spark a discussion about how to design your program and the assumptions each language allows you to make.

- - -

So how do I solve my original problem? Java is strict but it’s not unreasonable. Java really forces you to be intentional about your methods and variables. The best way I found to solve this issue was to keep the method small and contained and take care of one thing, that is, search for a contact.

![The correct Java implementation of Search method](/media/types_right_java.png "The correct Java implementation of search")

This method either returns a `Contact` or it returns `null` , that’s it. It will never return anything else and only does that one thing, it doesn’t care about communicating back to the user, and maybe it shouldn’t. Maybe somewhere else I can have an `if null` conditional that returns a message to the user. Where in Ruby I can make my method return different types and my variables are allowed to store different types, Java forces me to ask “why?”. Why do I want to make a method return more than one type, and is it appropriate?

Another way I could have solved this to return either a `Contact` or a `String` would have been to make the method return an `Object`. Just like Ruby, everything in Java inherits from the class `Object` and so everything is of type `Object`. Or instead of returning a `String`, in the else statement I could have printed out the message I wanted to be read by the user: `System.out.println("This contact does not exist")`.

- - -

_Thanks to_ [_TJ_](https://medium.com/@Tunji_D) _for proofreading this post, if you want to know about cool Android development things, definitely check out his profile._

_Also thanks to Ashwin Maroli for correcting my typo in the ruby example._

_This post first appeared on Medium._
