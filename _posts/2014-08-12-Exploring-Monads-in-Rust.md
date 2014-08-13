---
layout: post
title: Exploring Monads in Rust
---

<!-- TODO: Do it! -->

### Lets get some Options

One common monadic structure is the `Option` or `Maybe` type. This can be seen as an encapsulation type. Consider a function which may fail to produce a meaningful value for certain inputs. For example, something `get_from_database(non_existant_value)` might return a `null` in a language like Javascript, or C. In a language like Rust, we don't have that option, there is no `null`.

In Rust, the `Option` enum is either `Some(x)` or `None`.

```rust
enum Option<T> { None, Some(T) }
```

Options are widely used, for example, when parsing from a string.

```rust
fn main () {
    let maybe_monad: Option<int> = from_str("4");
    match maybe_monad {
        Some(x) => println!("Success, parsed {} from string.", x),
        None    => println!("No number parsed from string.")
    };
}
```

Because the Option is an explicit encapsulating structure, the author must explicitly deal with possible failures, instead of mistakenly ignoring them, leaving it to crash at runtime. This preserves the safety of the system.

Options help with function composition as well, allowing the author to transparently handle composition, without needing to explicitly handle possible null pointers in a chain. Some techniques for working with Option types are below.

```rust
fn main () {
    let maybe_number: Option<int> = from_str("4");
    
    // Unwrap, with a failure message if it doesn't work out.
    let number = maybe_number.expect("It wasn't 4i");
    assert_eq!(number, 4i);

    // Mutate in place.
    let mut mutable_number: Option<int> = Some(5);
    mutable_number.mutate(|x| x + 1);
    assert_eq!(mutable_number.expect("Failed to mutate"), 6);

    // This consumes maybe_number
    let maybe_true: Option<bool> = maybe_number.map(|x| x == 4i); 
    assert_eq!(maybe_true.expect("Failure message, won't print."), 
               true);
    
    // Multiple calls
    let maybe_chained: Option<bool> = from_str::<int>("4")
        .map(|x| x == 4i)
        .map(|x| !x);
    maybe_chained.expect("Failure message, won't print.");
    
    // Failure propagation
    let just_none: Option<bool> = from_str::<int>("Potato")
        .map(|x| x == 4i)
        .map(|x| !x);
    just_none.expect("Failure message, should print.");
}
```

In the last example, any function that results in a `None` will skip over the remaining functions in the map chain. This is particularly useful when you are want to have a number of functions waterfall over a variable, applying various operations, and do it safely, without a mess of error checking. 

Without an Option type, chaining together three functions which might fail would look like this:

```rust
// This code will not compile, don't try.
// Note, `Null` isn't a real type in Rust.
fn main () {
  let number: int = 4;
  match might_fail(number) {
    x => {
      match might_fail(x) {
        y => {
          match might_fail(y) {
            z => println!("Everything worked!"),
            Null => fail!("null from third function.")
          };
        },
        Null => fail!("null from second function.")
      };
    },
    Null => fail!("null from first function.");
  };
}
```

This is atrocious, not only is the code hard to read, but it is also unnecessarily complex. In a language where the author does not need to explicitly handle the `Null` results, there is a chance that one of the possible result branches may be missed. (This is not a problem in Rust, Haskell, OCaml, etc. as they force the author to handle each case.)

With an Option monadic type, the same code looks like this:

```rust
fn main () {
  let number: int = 4;
  match Some(number).map(might_fail).map(might_fail).map(might_fail) {
    Some(x)  => println!("Everything worked, was {}", x),
    None    => fail!("Something broke")
  };
}

fn might_fail(val: int) -> int {
    val + 1
}
```

This code handles all possible result branches cleanly, and the author need not explicitly deal with each possible `None` result, they only need to handle one.


### Further Resources:

* [Wikipedia's Article](http://en.wikipedia.org/wiki/Monad_(functional_programming))
* [Monads 101](http://www.intensivesystems.net/tutorials/monads_101.html)
* [A Monad Tutorial for Clojure Programmers](http://onclojure.com/2009/03/05/a-monad-tutorial-for-clojure-programmers-part-1/)
* [Clojure.algo.monads](https://github.com/clojure/algo.monads/blob/master/src/main/clojure/clojure/algo/monads.clj)
* [Functors, Applicatives, and Monads in Pictures](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html)
* [A fistful of monads](http://learnyouahaskell.com/a-fistful-of-monads)
