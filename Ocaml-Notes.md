# Ocaml-Notes

## 5 Aspects of Learning a Programming Language

1. Syntax: How do you write language constructs?
2. Semantics: What do programs mean? (Type checking, evaluation rules)
3. Idioms: What are typical patterns for using language features to express your computation?
4. Libraries: What facilities does the language or a third party project provide as "standard"? (file access, data
   structures)
5. Tools: What do language implementations provide to make work easier? (debugger, GUI editor, toplevel)

```ocaml
dune exec ./readme_cli.exe -- "my project" -d "my description"
```
## General

LISP - first garbage collection
Meta Language - first generics - parametric polymorphism / let identity x = x
Higher Order Functions - HOF -
Type Inference -
Pattern Matching

ABC - Always Be Compiling

==> is "evaluates to"

Good programmers abstract commonalities from code and try to write code that's parametric with respect to whatever the changeable parts may be
In Ocaml, use parameterized variants

Use begin and end around pattern matches

### Imperative Programming

mutability breaks referential transparency - ability to replace expression with its value without affecting result of
computation

side effect - how to compute by destructively changing the state

### Functional Programming

Expressions specify what to compute
variables never change value
Value - expression that does not need any further evaluation
All values are expressions, not all expressions are values (generally)

### Commands

utop

opam switch create <program-name> <opam-version>

update shell environment
```eval $(opam env)```

dashes - are not allowed, use _

dune init exe <name>

dune exec ./readme_cli.exe -- "my project" -d "my description"




## Expressions

1. Syntax - key words
2. Semantics - meaning
    1. Type-checking rules (static semantics) - program at rest produces a type or fails with an error message
    2. Evaluation rules (dynamic semantics) - produce a value, exception, or infinite loop
3. if expressions
    1. Syntax: if e1 then e2 else e3 is the same as ternary in TS
    2. Evaluation Rules:
        1. if e1 evalutes to true, and if e2 evaluates to v, then if e1 then e2 else e3 evalutes to v
        2. e1 ==> true and e2 ==> v, then (if e1 then e2 else e3 ==> v)
    3. Type Checking: if e1 has type bool and e2 has type t and e3 has type t then if e1 then e2 else e3 has type t
4. let expressions
    1. let [expression] in [definition] expressions - limits scope to definition
    2. let a = 0 in a;;
    3. can be nested - let a = 2 in (let b = 4 in a + b) (* evaluates to 6 *)
5. Principle of Name Irrelevance: the name of a variable shouldn't intrinsically matter - stop substituting when you
   reach a binding of the same name

## Definitions

Definitions are not expressions, but they syntactically contain expressions

1. Syntax let x = expression where x is an identifier (starts as lowercase only)
2. Evaluation:
    1. evaluate e to a value v
    2. Bind v to x; henceforth, x will evaluate to v (memory location x that contains
       v)[records.ml](readme_cli/scratches/records.ml)
    3. let definition is not an expression itself

## Directives

Directives are designated by `#` in front of the command
Use a File

```ocaml
#use "./scratches/records.ml"
```

Trace/Untrace a call

```ocaml
#trace <>;;
#untrace <>;;
```

## Functions

1. Functions are values.
2. Functions can take functions as arguments.
3. Functions can return functions as results.

### Anonymous Functions: use ()

Function application is writing the function next to the argument  
Body of the function is not evaluated until the time the function is applied (lamda expression)

1. (fun x -> x + 1) 42 (* evaluates to 43 *)
2. (fun x y -> (x +. y) /. 2.) 42. 45. (* evaluates to 43 *)
3. Syntax: fun x1 ... xn -> e
4. Evaluation:
    1. Evaluate Subexpressions
    2. Substitute argument values for names of parameters
    3. Results is v

### Named Functions

1. let inc = (fun x -> x + 1) 2;;
2. let inc = x + 1 (* syntactic sugar but semantically equivalent *)
    1. inc 42 (* evaluates to 43 *)

### Recusrive Functions

Must explictly state that function is recursive with rec keyword
let rec fact n =
if n = 0 then 1
else n * fact (n - 1);;

### Function types

-> is used for function types and function values.  
t -> u is the type of function that takes input of type t and returns output u.  
t1 -> t2 -> u is the type of a function that takes 2 inputs and returns an output u.

### Partial Function Application

let add x y = x + y;;  
(add 2) 3;; (* evaluates to 5 *).
fun x y -> e is syntactic sugar for fun x -> (fun y -> e)

### Polymorphic Functions

write function that works with many arguments regardless of their type.  
id keyword returns an unknown type variable.  
single quote followed by the identifier 'a (tick alpha or prime).  
let id x = x;; (* returns 'a -> 'a = <fun> *).

## Operators as functions

infix - goes between two arguments, wrapped in ()
a binary operator wrapped in () becomes a function +, -, /, *
use ( * ) to disregard as a comment (* comment *)
equality (=) 1 2;;

### Create new infix operator

let ( <^> ) x y = max x y;;
( <^> ) 1 2;;

## Application Operators

@@ avoid parenthesis
|> pipeline operator - take a value and run it through the pipeline
5 |> succ |> succ;; (* evaluates to 7 *)

## Lists

separate list elements with ;
[1; 2;]

add to a list with ::
1 :: 2 :: [];;

Lists are immutable in Ocaml
Singly-linked - Good for sequential access of short to medium length lists (up to 10k elements)

Syntax:

1. [] empty list - nil - any type t
2. e1 :: e2 prepends element e1 to list e2 (:: is cons)
    1. e1 and e2 must be of the same type
3. [e1; e2] is sugar for e1 :: e2 :: []

## Records

Records contain fields. Field names are identifiers. Order of fields is irrelevant. Up to 4 million fields are allowed.

Record types must be defined prior to use.

Define a record and an object:

```ocaml
(* Type Student *)
type student = {
   name: string;
   graduation_year: int;
}

let rbg = {
   name = "Ruth Bader";
   graduation_year = 1954;
}
```

Record copy `{e with f1 = e1}`

```ocaml
let newRBG =  {rbg with name= "Ruth Bader Ginsburg"};;
```

## Tuples

Accessed by position, not by name

```ocaml
type time = int * int * string
let t = (10, 10, "am")
```

### Built in Functions

fst <tuple>;; first element in tuple pair
snd <tuple>;; second element in tuple pair

## Ocaml Data Types

Unbounded - List
Bounded & position - Tuple
Bounded & name - Record

## Pattern Matching

```ocaml
let x = match not true with
  | true -> "evaluated as true" (* this line is called a branch *)
  | false -> "evaluated as false"

let y =
  match 42 with
    | fooo -> fooo (* pattern variable - matched on right hand side of the arrow *)

let z =
  match "foo" with
  | "bar" -> 0
  | _. -> 1 (* _ designates wildcard *)

let a =
  match [] with
  | [] -> "empty"
  | _ -> "not empty"

let b =
  match ["taylor"; "swift"] with
  | -> "folklore"
  | h :: t -> h (* h is head, tail is t *)
```

Pattern Match Tuple - return head

```ocaml
let fst3 t =
    match t with
    | (a, b, c) -> a
```

Pattern Match Record

```ocaml
let name_with_year s =
  match s with
    | {name; graduation_year} -> name ^ " " ^ string_of_int graduation_year
```

Pattern Match List
Empty List

```ocaml
let empty lst = 
  match lst with 
    | [] -> true
    | h :: t - > true
```

Length of a List

```ocaml
let rec length lst =
  match lst with
    | [] -> 0
    | h :: t -> 1 + length t
```

Append a list to another list using `@`

```ocaml
let rec append lst1 lst2 =
  match lst1 with
  | [] -> lst2
  | h :: t -> h :: append t lst2 (* Append List 1 to list 2*)
  | h :: t -> h :: t @ lst2 (* Syntactic Sugar*)
```

`Function` keyword - immediately pattern match against the last argument

```ocaml
let f x y z = 
  match z with
  | p1 -> e1
  | p2 -> e2
(* Syntactic Sugar *)
let f x y = function
  | p1 -> e1
  | p2 -> e2
```

:: vs @
::

1. "cons"
2. Add element to head of a list
3. Constant time: O(1)

@

1. "append"
2. combine two lists
3. Linear time in first list O(length lst1)

## Variants
essentially Enums  
Constant - if it carries no data
Non-constant - it carries data (which could change)
Known as algebraic data types

### Constructors
1. start with Capital letter
2. data is carried along with tag(aka constructor)


Basic Enum  
```ocaml
type primary_color = Red | Green | Blue
let r = Red
```

Keep pairs in ()

Advanced Variant
```ocaml
type point = float * float
type shape =
  | Circle of {center : point; radius : float}
  | Rectangle of {lower_left : point; upper_right : point}

let circle1 = Circle {center = (0., 0.); radius = 1.}

let avg x y =
  (x +. y) /. 2.

let rect1 = Rectangle {lower_left = -1., -1.; upper_right = (1., 1.)}
let center s =
  match s with
    | Circle {center; radius} -> center
    | Rectangle {lower_left; upper_right} ->
        let (x_ll, y_ll) = lower_left in
        let (x_ur, y_ur) = upper_right in
        (avg x_ll x_ur, avg y_ll y_ur)
```

### Algebraic Data Types (ADT but not Abstract Data Type)
Record or variant?
1. Coin - variant (aka enum) - one of many options - OR (sum type)
2. Student - record - 2 pieces of data simultaneously - AND (product type)
3. Dessert - record - many pieces of data simultaneously - AND (product type)


### Recursive Variant
```ocaml
type intlist =
  | Nil
  | Cons of int * intlist
  ```

### Parameterized Variants
Lists are just recursive, parameterized Variants
list is a type constructor parameterized on type variable 'a
[] aka Nil
:: aka cons
Nil [] and Cons (::) are just constructors for the list variant

### Options
Either nothing or something in it
type 'a option = None | Some of 'a
Deconstruct an option
```ocaml
let get_val default o = function
  | None -> default
  | Some x -> x
```

When to use an option
```ocaml
let rec list_max (lst: 'a list): 'a option = match lst with
  | h :: t -> begin (* Use begin and end around pattern matches *)
    match list_max t with
    | None -> Some h
    | Some m -> Some (max h m)
  end
  | [] -> None

let x = list_max [1;2;3]
let y = list_max []
```

## Exceptions
type exn is a built in extensible variant

Define your own:
```ocaml
exception MyException
exception MyException of string (* Passes a string to the Exception *)
```

raise built in function - raises an exception - raise : exn -> 'a
```ocaml
raise MyException "error"
```

Failure of string
1. Exception raised by library functions to signal they are undefined on the given arguments
2. `failwith "error message"`

InvalidArgument of string
1. Exception raised by library functions to signal that the given arguments do not make sense
2. ``invalid_arg "my error message";;``


Pattern Match: try ... with  
```ocaml
let safe_div x y =
  try x / y with
    | Division_by_zero -> 0
```

## Binary Tree Variant (TODO)
Nodes, which may have two successors
```ocaml
type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree
let t =
  Node (2,
        Node (1, Leaf, Leaf),
        Node (3, Leaf, Leaf)
        )
let rec size = function
  | Leaf -> 0
  | Node (_, l, r) -> 1 + size l + size r
```

## Higher Order Functions (HOF)
A function is considered higher order if it takes other functions as arguments, returns a function, or both.
Pipeline operator
```ocaml
let double x = 2 * x;;
let quad x  = x |> double |> double;;
```
Applying a function twice - can you factor or abstract that functionality?
```ocaml
let twice f x = f (f x);;
```

### Map (List.map)
Transforms elements of a list

Abstraction principle - factor out recurring code patterns. Don't duplicate them.

```ocaml
let lst3 = List.map string_of_int lst1;;
```

### Combine (List.combine)
Combines two lists of any type
```ocaml
let lst3' = List.combine lst2 lst3;;
```

### Fold - fold_right / fold_left
accumulates an answer by repeatedly applying f to an element of a list and answer so far

#### fold_left
operates from first to last
tail-recursive (takes up less stack space)
```ocaml
let sum = List.fold_left (fun x acc -> acc + x) 0 lst1
```

#### fold_right
operates from last element to first
takes up more stack space
take up less stack space by reversing list then folding left
```ocaml
let fold_right_list = List.fold_left (fun acc x -> acc + x) 0 reversedList
```
### Filter
create a new list containing only the elements that satisfy a given condition (the predicate)
```ocaml
let is_even x = x mod 2 = 0
let evens = List.filter is_even reversedList
```

#### Tail Recursive Filter
```ocaml
let filter_tail_recursive predicate lst =
  let rec aux acc = function
    | [] -> List.rev acc
    | x :: xs ->
      if predicate x then
        aux (x::acc) xs
      else
        aux acc xs
  in
  aux [] lst;
```

