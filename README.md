# ocaml-cs3110

## Commands

utop

opam switch create <program-name> <opam-version>

update shell environment
```eval $(opam env)```

dashes - are not allowed, use _

dune init exe <name>

dune exec ./readme_cli.exe -- "my project" -d "my description"

dune build --watch

## Usage

dune exec ./readme_cli.exe -- "my project" -d "my description"

## Imperative Programming

mutability breaks referential transparency - ability to replace expression with its value without affecting result of
computation

side effect - how to compute by destructively changing the state

## Functional Programming

Expressions specify what to compute
variables never change value
Value - expression that does not need any further evaluation
All values are expressions, not all expressions are values (generally)

## Dependencies

cmdliner - CLI parsing
yojson - working with JSON data

## Notes

LISP - first garbage collection
Meta Language - first generics - parametric polymorphism / let identity x = x
Higher Order Functions - HOF -
Type Inference -
Pattern Matching

## 5 Aspects of Learning a Programming Language

1. Syntax: How do you write language constructs?
2. Semantics: What do programs mean? (Type checking, evaluation rules)
3. Idioms: What are typical patterns for using language features to express your computation?
4. Libraries: What facilities does the language or a third party project provide as "standard"? (file access, data
   structures)
5. Tools: What do language implementations provide to make work easier? (debugger, GUI editor, toplevel)

dune exec ./readme_cli.exe -- "my project" -d "my description"

## Ocaml

### Expressions

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

### Definitions

Definitions are not expressions, but they syntactically contain expressions

1. Syntax let x = expression where x is an identifier (starts as lowercase only)
2. Evaluation:
    1. evaluate e to a value v
    2. Bind v to x; henceforth, x will evaluate to v (memory location x that contains
       v)[records.ml](readme_cli/scratches/records.ml)
    3. let definition is not an expression itself

### Directives

Directives are designated by `#` in front of the command
Use a File
```#use "./scratches/records.ml"```

Trace a call
```#trace <>```

### Functions

1. Functions are values.
2. Functions can take functions as arguments.
3. Functions can return functions as results.

#### Anonymous Functions: use ()

Function application is writing the function next to the argument  
Body of the function is not evaluated until the time the function is applied (lamda expression)

1. (fun x -> x + 1) 42 (* evaluates to 43 *)
2. (fun x y -> (x +. y) /. 2.) 42. 45. (* evaluates to 43 *)
3. Syntax: fun x1 ... xn -> e
4. Evaluation:
    1. Evaluate Subexpressions
    2. Substitute argument values for names of parameters
    3. Results is v

#### Named Functions

1. let inc = (fun x -> x + 1) 2;;
2. let inc = x + 1 (* syntactic sugar but semantically equivalent *)
    1. inc 42 (* evaluates to 43 *)

#### Recusrive Functions

Must explictly state that function is recursive with rec keyword
let rec fact n =
if n = 0 then 1
else n * fact (n - 1);;

#### Function types

-> is used for function types and function values.  
t -> u is the type of function that takes input of type t and returns output u.  
t1 -> t2 -> u is the type of a function that takes 2 inputs and returns an output u.

#### Partial Function Application

let add x y = x + y;;  
(add 2) 3;; (* evaluates to 5 *).
fun x y -> e is syntactic sugar for fun x -> (fun y -> e)

#### Polymorphic Functions

write function that works with many arguments regardless of their type.  
id keyword returns an unknown type variable.  
single quote followed by the identifier 'a (tick alpha or prime).  
let id x = x;; (* returns 'a -> 'a = <fun> *).

### Operators as functions

infix - goes between two arguments, wrapped in ()
a binary operator wrapped in () becomes a function +, -, /, *
use ( * ) to disregard as a comment (* comment *)
equality (=) 1 2;;

#### Create new infix operator

let ( <^> ) x y = max x y;;
( <^> ) 1 2;;

### Application Operators

@@ avoid parenthesis
|> pipeline operator - take a value and run it through the pipeline
5 |> succ |> succ;; (* evaluates to 7 *)

### Lists

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

### Records

Records contain fields. Field names are identifiers. Order of fields is irrelevant. Up to 4 million fields are allowed.

Record types must be defined prior to use.

Define a record and an object:

```
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

```
let newRBG =  {rbg with name= "Ruth Bader Ginsburg"};;
```

### Tuples

Accessed by position, not by name

```
type time = int * int * string
let t = (10, 10, "am")
```

#### Built in Functions

fst <tuple>;; first element in tuple pair
snd <tuple>;; second element in tuple pair

### Ocaml Data Types

Unbounded - List
Bounded & position - Tuple
Bounded & name - Record

### Pattern Matching
