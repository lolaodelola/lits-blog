---
layout: post
title: Let's Get Lost in Arrays
slug: get-lost-in-arrays
published: true
date: 2019-06-08T19:54:24.370Z
description: A deep dive into Ruby Arrays.
tags:
  - Programming
  - Ruby
  - Java
---
I thought I knew what an array is, in fact, when I began learning to code it was one of the easier data structures for me to pick up. It's basically just a list of stuff with square brackets around it, `[1,2,3,4,5]`, and my writing background taught me all about lists and their wonderful dynamicity. You can use them for anything in literature and in Ruby too; they're a wonderful multipurpose storage system and can contain an infinite amount of stuff (lol) and can store different types of stuff (also lol). Then I began learning Java.

![Tweet explaining that I don't know if I know what an array is](/images/uploads/arrays_tweet.png "Array tweet")

I thought I knew but, friends, I had no idea.

- - -

It started because I noticed that the Java notation for instantiating an array isn't as simple as it is in Ruby. As shown in the image, when instantiating an Array in Java, I have to pass also include a number. Naturally, my question was, what's does the number mean?

![array definitions in ruby and java](/images/uploads/carbon-1-.png "array definitions in ruby and java")

I've always said Rubyists don't need to worry too much about memory allocation (once again, lol) because Ruby is [garbage collected](https://medium.com/r/?url=https%3A%2F%2Fruby-hacking-guide.github.io%2Fgc.html) (though memory leaks **do** happen). Apart from that though, Ruby abstracts a lot of the stuff to do with memory that other languages don't. **When an object is created, in any language, it takes up a bit of memory, in the case of newly initialised arrays, adjoining blocks of memory are reserved for the array**. So, back to this number. In Java, you have to specify a max amount of objects you want you array to hold, so that the memory can be allocated when it's time. `anArray = new int[500];` says instantiate an array that has a default size of 500, basically, the array can't grow past 500 items.

- - -

But how comes Ruby doesn't do that? Remember what I said about Ruby abstracting a bunch of stuff so the programmer doesn't have to think about them? Good, so let's look at the `new` function in the `Array` class.

![New function in Ruby Source: https://github.com/ruby/ruby/blob/trunk/array.c](/images/uploads/array_c_in_ruby.png "New function in Ruby")
         -- Source: https://github.com/ruby/ruby/blob/trunk/array.c --

This was confusing to me when I first read it. Essentially, it's checking that the capacity of the new array isn't less than 0 nor is it more than the predetermined max size. Lines 9–11 are the important bit here, in the setup of the class `ARY_MAX_SIZE` is set to a ridiculously big number (StackOverflow says it's somewhere between 500,000,000 and 600,000,000), and if the capacity of the array exceeds that, then an error will be raised. Isn't this very similar to the Java way? Ruby handles the memory allocation for you so you don't have to think about it, and by setting it to a really big number, you're tricked into thinking it's dynamic. If your array is within 0 and `ARY_MAX_SIZE` the method goes ahead and creates an array (lines 16–22).

- - -

Ruby arrays seem to be just like static arrays under the hood, but there's more. Although Ruby sets a max size (which is necessary because memory is finite), it behaves like an `ArrayList`, which is a different type of data structure. An `ArrayList` is similar to an array, except that you don't have to set the default yourself because it's a concrete implementation of the List interface, which allows uninhibited growth (no need to worry too much about what List is for now). When an `ArrayList` grows or is pushed to, depending on some conditions, it's copied over or reallocated to a new object. In Ruby, the important method is `ary_resize_capa()` :

![Array resize capa function in Source: https://github.com/ruby/ruby/blob/trunk/array.c](/images/uploads/array_capa_method.png "Array resize capa function")
         -- Source: https://github.com/ruby/ruby/blob/trunk/array.c --

This long, complicated looking bit of code grows (lines 8–22) and shrinks (line 23 onwards) the array accordingly. The first part, the growth, does a check to see if the capacity is greater than `RARRAY_EMBED_LEN_MAX`, which, after doing some digging I found out is 3. If the array is embedded (I'm not entirely sure what embedded means in this context) then, similar to what happens in `new`, the array is allocated to a [heap](https://medium.com/r/?url=https%3A%2F%2Fwww.geeksforgeeks.org%2Fbinary-heap%2F) and unembedded. If it's false, then the data, memory, etc of the array is reallocated. Finally the capacity is set with the new capacity that's passed as an argument.

Java does something similar in its `grow` function on `ArrayList`.

![Grow function in Source: http://hg.openjdk.java.net/jdk8/jdk8/jdk/file/tip/src/share/classes/java/util/ArrayList.java](/images/uploads/array_java.png "Array grow function in java")

It makes sure the `newCapacity` is a positive number and the right size (lines 5–8), then it copies the data of the array to a new array with the new capacity (line 10).

- - -

So what was the point? Now you know that arrays in Ruby **are** `Array`s that behave like `ArrayList`s, what now? Do you need to know this for your everyday work, probably not if you're programming with Ruby and you probably already know it if you're programming with Java. However, peeling the layer back on Ruby gives more understanding to the magic of the language. Just as statically typed languages [force you to think about the objects you return](https://lostinthesource.com/lets-get-lost-in-types), they also force you to think about the kinds of data structures you need and when. Ruby arrays can also act similarly to `Stack`s and `Queue`s due to the different methods defined on the class, so an array kind of becomes this multi-purpose object that can store anything and can behave like many things, and that's useful sometimes.

- - -

_Thanks to [Marko Lindqvist](https://twitter.com/cazfi74) for helping me understand some of the tricky C code and [TJ](https://twitter.com/tunji\_d) for the Java bits and proof-reading._