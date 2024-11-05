(* Record - Student *)
  type student = {
    name: string;
    graduation_year: int;
  }

  let rbg = {
    name = "Ruth Bader";
    graduation_year = 1954;
  }

(* Tuples *)
type time = int * int * string
let t = (10, 10, "am")

(* Pattern Matching *)

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
  | h :: t -> h

