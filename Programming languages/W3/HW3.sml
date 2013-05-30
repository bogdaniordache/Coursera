(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun const x _ = x

fun curry f x y = f (x, y)

(* option that will short-circuit on NONE *)
fun optfoldl f acc lst =
            case (lst, acc) of
                (x :: xs, SOME y) => optfoldl f (f (x, y)) xs
              | _ => acc

(* when f x returns NONE will short-circuit with NONE  *)
fun optmap f =
    Option.map rev o
    optfoldl (fn (x, acc) => Option.map (fn a => a :: acc) (f x)) (SOME [])

(* 1 *)
val only_capitals =
    List.filter (fn s => Char.isUpper (String.sub (s, 0)))

(* 2 *)
val longest_string1 =
    List.foldl (fn (a, b) => if String.size a > String.size b
                             then a
                             else b) ""

(* 3 *)
val longest_string2 =
    List.foldl (fn (a, b) => if String.size a >= String.size b
                             then a
                             else b) ""

(* 4 *)
fun longest_string_helper cmp =
    List.foldl (fn (a, b) => if cmp (String.size a, String.size b)
                             then a
                             else b) ""

val longest_string3 = longest_string_helper (op >)

val longest_string4 = longest_string_helper (op >=)

(* 5 *)
val longest_capitalized = longest_string1 o only_capitals

(* 6 *)
val rev_string = String.implode o rev o String.explode

(* 7 *)
fun first_answer f =
    let fun go xs =
            case xs of
                (x :: xs') => (case f x of
                                   SOME v => v
                                 | NONE   => go xs')
              | _ => raise NoAnswer
    in
        go
    end

(* 8 *)
fun all_answers f = (Option.map List.concat) o (optmap f)

(* 9 *)
(* a *)
val count_wildcards = g (const 1) (const 0)

(* b *)
val count_wild_and_variable_lengths = g (const 1) String.size

(* c *)
fun count_some_var (s, p) = g (const 0) (fn v => if v = s then 1 else 0) p

(* 10 *)
fun check_pat pattern =
    let fun go pacc =
            case pacc of
                (_, NONE) => NONE
              | (TupleP ps, acc)  => List.foldl go acc ps
              | (ConstructorP(_, pc), acc) => go (pc, acc)
              | (Variable x, SOME xs) =>
                if List.exists (curry op = x) xs
                then NONE
                else SOME (x :: xs)
              | (_, acc) => acc
    in
        isSome (go (pattern, SOME []))
    end

(* 11 *)
fun match (v0, p0) =
    let fun go vpacc =
            case vpacc of
                (_, _, NONE) => NONE
              | (_, Wildcard, acc) => acc
              | (v, Variable x, SOME lst) => SOME ((x, v) :: lst)
              | (Unit, UnitP, acc) => acc
              | (Const x, ConstP y, acc) => if x = y then acc else NONE
              | (Tuple vs, TupleP ps, acc) =>
                (ListPair.foldlEq go acc (vs, ps)
                 handle ListPair.UnequalLengths => NONE)
              | (Constructor(sv, v), ConstructorP(pv, p), acc) =>
                if sv = pv then go (v, p, acc) else NONE
              | _ => NONE
    in
        Option.map rev (go (v0, p0, SOME []))
    end

(* 12 *)
fun first_match v ps = SOME (first_answer (curry match v) ps)
                       handle NoAnswer => NONE

(* Challenge *)
fun typecheck_patterns (datatypes, patterns) =
    let fun join_types pair =
            case pair of
                (Anything, y)  => SOME y
              | (x, Anything)  => SOME x
              | (TupleT xs, TupleT ys) =>
                Option.map
                    TupleT
                    (optmap join_types (ListPair.zipEq (xs, ys))
                     handle ListPair.UnequalLengths => NONE)
              | (x, y) => if x = y then SOME x else NONE
        fun pat_to_typ p =
            case p of
                Wildcard => SOME Anything
              | Variable _ => SOME Anything
              | UnitP => SOME UnitT
              | ConstP _ => SOME IntT
              | TupleP ps => Option.map TupleT (optmap pat_to_typ ps)
              | ConstructorP (s, cp) =>
                case (pat_to_typ cp,
                      List.find (fn (cs, _, _) => cs = s) datatypes) of
                    (SOME pt, SOME (cs, ds, dt)) =>
                    if isSome (join_types (pt, dt))
                    then SOME (Datatype ds)
                    else NONE
                  | _ => NONE
    in
        Option.mapPartial
            (optfoldl join_types (SOME Anything))
            (optmap pat_to_typ patterns)
    end

