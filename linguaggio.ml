
(* The language *)

type ide = string;;

type exp = CstInt of int
		| CstTrue 
		| CstFalse
		| Den of ide
		| CstString of string
		| EmptySet of ide
		| Singleton of exp * ide
		| Of of ide * valuesList
		| Union of exp * exp
		| Intersect of exp * exp
		| Difference of exp * exp
		| Add of exp * exp
		| Remove of exp * exp
		| IsEmpty of exp
		| Contains of exp * exp
		| SubSet of exp * exp
		| Max of exp
		| Min of exp
		| For_all of exp * exp
		| Exists of exp * exp
		| Filter of exp * exp
		| Map of exp * exp
		| Sum of exp * exp
		| Sub of exp * exp
		| Times of exp * exp
		| Ifthenelse of exp * exp * exp
		| Eq of exp * exp
		| And of exp * exp
		| Or of exp * exp
		| Not of exp
		| Let of ide * exp * exp
		| Fun of ide * exp
		| Letrec of ide * ide * exp * exp
		| Apply of exp * exp
		and valuesList = Empty | Val of exp * valuesList;;

type 'v env = (string * 'v) list;;

type evT = Int of int | Bool of bool | String of string | Set of ide * (evT list) | Closure of ide * exp * evT env | RecClosure of ide * ide * exp * evT env | Unbound;;

let emptyEnv  = [ ("", Unbound)] ;;

let bind (s: evT env) (i:string) (x:evT) = ( i, x ) :: s;;

let rec lookup (s:evT env) (i:string) = match s with
    | [] ->  Unbound
    | (j,v)::sl when j = i -> v
    | _::sl -> lookup sl i;;

let typecheck (x, y) = match x with	
    | "int" -> 
        (match y with 
         	| Int(u) -> true
            | _ -> false)

	| "bool" -> 
		(match y with 
			| Bool(u) -> true
			| _ -> false)

	| "string" ->
		(match y with
			| String(u) -> true
			| _ -> false)
	
	| "set" ->
		(match y with
			| Set(_, _) -> true
			| _ -> false)

	| _ -> failwith ("not a valid type");;

let rec check (x) =
match x with
| CstTrue | CstFalse | Eq(_, _) | And(_, _) | Or(_, _) | Not(_) -> "bool"
| Ifthenelse(guard, rthen, relse) -> let resType = check(rthen) in if resType = check(relse) then resType else failwith("branches mismatch")
| CstString(_) -> "string"
| CstInt(_) | Sum(_) | Sub(_) | Times(_) -> "int"
| Let(_, _, body) -> check(body)
| Fun(_, body) -> check(body)
| _ -> failwith("run-time error");;

let int_eq(x,y) =   
match (typecheck("int",x), typecheck("int",y), x, y) with
  | (true, true, Int(v), Int(w)) -> Bool(v = w)
  | (_,_,_,_) -> failwith("run-time error ");;
       
 let int_plus(x, y) = 
 match(typecheck("int",x), typecheck("int",y), x, y) with
  | (true, true, Int(v), Int(w)) -> Int(v + w)
  | (_,_,_,_) -> failwith("run-time error ");;

let int_sub(x, y) = 
 match(typecheck("int",x), typecheck("int",y), x, y) with
  | (true, true, Int(v), Int(w)) -> Int(v - w)
  | (_,_,_,_) -> failwith("run-time error ");;

let int_times(x, y) = 
 match(typecheck("int",x), typecheck("int",y), x, y) with
  | (true, true, Int(v), Int(w)) -> Int(v * w)
  | (_,_,_,_) -> failwith("run-time error ");;

let bool_and(x, y) =
 match (x, y) with
  | (Bool(i), Bool(j)) -> Bool(i && j);
  | (_, _) -> failwith("nonboolean expression");;

let bool_or(x, y) =
 match (x, y) with
  | (Bool(i), Bool(j)) -> Bool(i || j);
  | (_, _) -> failwith("nonboolean expression");;

let bool_not(x) =
 match x with
  | Bool(i) -> Bool(not i);
  | _ -> failwith("nonboolean expression");;

let rec isUnique(x, y) = 
	match x with
	| [] -> true
	| l::ls -> if l = y then false else isUnique(ls, y);;

let rec removeElem(x, y) =
	match x with
	| [] -> []
	| l::ls -> if l = y then removeElem(ls, y) else l::removeElem(ls, y);;

(*OPERAZIONI PRIMITIVE PER GLI INSIEMI*)
let union(x, y) =
	match (typecheck("set", x), typecheck("set", y), x, y) with
		| (true, true, Set(i, ls), Set(j, lx)) -> if i = j then
													let rec consLists(l1, l2) = 
													match l1 with
													| [] -> l2
													| ll::lll -> if isUnique(l2, ll) then ll::consLists(lll, l2) else consLists(lll, l2) in Set(i, consLists(ls, lx))
													else failwith("type mismatch")
		| (_, _, _, _) -> failwith("run-time error");;

let intersect(x, y) = 
	match (typecheck("set", x), typecheck("set", y), x, y) with
		| (true, true, Set(i, ls), Set(j, lx)) -> if i = j then
													let rec consLists(l1, l2) = 
													match l1 with
													| [] -> []
													| ll::lll -> if not (isUnique(l2, ll)) then ll::consLists(lll, l2) else consLists(lll, l2) in Set(i, consLists(ls, lx))
													else failwith("type mismatch")
		| (_, _, _, _) -> failwith("run-time error");;

let difference(x, y) =
	match (typecheck("set", x), typecheck("set", y), x, y) with
		| (true, true, Set(i, ls), Set(j, lx)) -> if i = j then
													let rec consLists(l1, l2) = 
													match l1 with
													| [] -> []
													| ll::lll -> if isUnique(l2, ll) then ll::consLists(lll, l2) else consLists(lll, l2) in Set(i, consLists(ls, lx))
													else failwith("type mismatch")
		| (_, _, _, _) -> failwith("run-time error");;

let add(x, y) =
	match (typecheck("set", x), x) with
		| (true, Set(i, ls)) -> (match (typecheck(i, y)) with
									| true -> if isUnique(ls, y) then Set(i, y::ls) else Set(i, ls)
									| _ -> failwith("type mismatch"))
		| (_, _) -> failwith("run-time error");;

let remove(x, y) =
	match (typecheck("set", x), x) with
		| (true, Set(i, ls)) -> (match (typecheck(i, y)) with
									| true -> Set(i, removeElem(ls, y))
									| _ -> failwith("type mismatch"))
		| (_, _) -> failwith("run-time error");;

let isEmpty(x) = 
	match (typecheck("set", x), x) with
		| (true, Set(i, ls)) -> ( match ls with
        	| [] -> Bool(true)
        	| _ -> Bool(false) )
		| (_, _) -> failwith("run-time error ");;

let contains(x, y) = 
	match (typecheck("set", x), x) with
		| (true, Set(i, ls)) -> (match (typecheck(i, y)) with
									| true -> if not (isUnique(ls, y)) then Bool(true) else Bool(false)
									| _ -> failwith("type mismatch"))
		| (_, _) -> failwith("run-time error");;

let isSubSet(x, y) =
	match (typecheck("set", x), typecheck("set", y), x, y) with
		| (true, true, Set(i, ls), Set(j, lx)) -> if i = j then
													let rec containsList(l1, l2) = 
													match l1 with
													| [] -> Bool(true)
													| ll::lll -> if isUnique(l2, ll) then Bool(false) else containsList(lll, l2) in containsList(ls, lx)
													else failwith("type mismatch")
		| (_, _, _, _) -> failwith("run-time error");;

let max(x) =
  match (typecheck("set", x), x) with
    | (true, Set(i, ls)) -> let rec findMax(lista) =
                        match lista with
                        | [] -> failwith("empty list")
                        | i::[] -> i
                        | i::xs -> if i > findMax(xs) then i else findMax(xs) in findMax(ls)
    | (_, _) -> failwith("run-time error");;

let min(x) =
  match (typecheck("set", x), x) with
    | (true, Set(i, ls)) -> let rec findMin(lista) =
                        match lista with
                        | [] -> failwith("empty list")
                        | i::[] -> i
                        | i::xs -> if i < findMin(xs) then i else findMin(xs) in findMin(ls)
    | (_, _) -> failwith("run-time error");;

(* Interprete full *)

let rec eval  (e:exp) (s:evT env) = match e with
 | CstInt(n) -> Int(n)
 | CstTrue -> Bool(true)
 | CstFalse -> Bool(false)
 | CstString(s) -> String(s)
 | EmptySet(i) -> (match i with
			| "int" -> Set(i, [])
			| "bool" -> Set(i, [])
			| "string" -> Set(i, [])
			| _ -> failwith("Invalid type"))
 | Singleton(e, i) -> let g = eval e s in
	(match (typecheck(i, g)) with
		| true -> Set(i, [g])
		| _ -> failwith ("type mismatch"))
 | Of(i, lst) -> let rec addList(lista) =
					match lista with
					| [] -> Set(i, [])
					| x::xs -> add(addList(xs), x) in addList(evalList(lst, s, i))
 | Union(e1, e2) -> union((eval e1 s), (eval e2 s))
 | Intersect(e1, e2) -> intersect((eval e1 s), (eval e2 s))
 | Difference(e1, e2) -> difference((eval e1 s), (eval e2 s))
 | Add(e1, e2) -> add((eval e1 s), (eval e2 s))
 | Remove(e1, e2) -> remove((eval e1 s), (eval e2 s))
 | IsEmpty(e) -> isEmpty((eval e s))
 | Contains(e1, e2) -> contains((eval e1 s), (eval e2 s))
 | SubSet(e1, e2) -> isSubSet((eval e1 s), (eval e2 s))
 | Max(e) -> max((eval e s))
 | Min(e) -> min((eval e s))
 | For_all(f, e) -> forall((eval f s), (eval e s))
 | Exists(f, e) -> exists((eval f s), (eval e s))
 | Filter(f, e) -> filter((eval f s), (eval e s))
 | Map(f, e) -> map((eval f s), (eval e s))
 | Eq(e1, e2) -> int_eq((eval e1 s), (eval e2 s))
 | And(e1, e2) -> bool_and((eval e1 s), (eval e2 s))
 | Or(e1, e2) -> bool_or((eval e1 s), (eval e2 s))
 | Not(e) -> bool_not(eval e s)
 | Times(e1,e2) -> int_times((eval e1 s), (eval e2 s))
 | Sum(e1, e2) -> int_plus((eval e1 s), (eval e2 s))
 | Sub(e1, e2) -> int_sub((eval e1 s), (eval e2 s))
 | Ifthenelse(e1,e2,e3) -> let g = eval e1 s in
    (match (typecheck("bool", g), g, check(e2)=check(e3)) with
		| (true, Bool(true), true) -> eval e2 s
        | (true, Bool(false), true) -> eval e3 s
       	| (_, _, _) -> failwith ("nonboolean guard or branches mismatch"))
| Den(i) -> lookup s i
| Let(i, e, ebody) -> eval ebody (bind s i (eval e s))
| Fun(arg, ebody) -> Closure(arg,ebody,s)
| Letrec(f, arg, fBody, letBody) -> 
  let benv = bind (s) (f) (RecClosure(f, arg, fBody,s)) in eval letBody benv
| Apply(eF, eArg) ->
    let fclosure = eval eF s in 
         (match fclosure with 
           | Closure(arg, fbody, fDecEnv) ->
             let aVal = eval eArg s in
	      		let aenv = bind fDecEnv arg aVal in 
                	eval fbody aenv
           | RecClosure(f, arg, fbody, fDecEnv) ->
             let aVal = eval eArg s in
               let rEnv = bind fDecEnv f fclosure in
	          let aenv = bind rEnv arg aVal in 
                    eval fbody aenv
           | _ -> failwith("non functional value"))

and evalList(list, amb, typ) =
	let rec aux(l, a, y) = 
	match l with
	| Empty -> []
	| Val(e, ls) -> let v = (eval e a) in
		if typecheck(y, v) then v::(evalList(ls, a, y)) else failwith("type mismatch") in aux(list, amb, typ)

and forall(predicate, aSet) = 
	(match (predicate, typecheck("set", aSet), aSet) with
	| (Closure(arg, fbody, fDecEnv), true, Set(i, lst)) -> (let rec aux(a, fb, fde, lst) =
															(match lst with
															| [] -> Bool(true)
															| x::xs -> let aenv = bind fde a x in let res = (eval fb aenv) in if res = Bool(true) then aux(a, fb, fde, xs) else Bool(false))
															in if check(fbody) = "bool" then aux(arg, fbody, fDecEnv, lst) else failwith("not a predicate"))
	| (_, _, _) -> failwith("run-time error"))

and exists(predicate, aSet) = 
	(match (predicate, typecheck("set", aSet), aSet) with
	| (Closure(arg, fbody, fDecEnv), true, Set(i, lst)) -> (let rec aux(a, fb, fde, lst) =
															(match lst with
															| [] -> Bool(false)
															| x::xs -> let aenv = bind fde a x in let res = (eval fb aenv) in if res = Bool(true) then Bool(true) else aux(a, fb, fde, xs)) 
															in if check(fbody) = "bool" then aux(arg, fbody, fDecEnv, lst) else failwith("not a predicate"))
	| (_, _, _) -> failwith("run-time error"))

and filter(predicate, aSet) =
(match (predicate, typecheck("set", aSet), aSet) with
	| (Closure(arg, fbody, fDecEnv), true, Set(i, lst)) -> (let rec aux(a, fb, fde, lst) =
															(match lst with
															| [] -> []
															| x::xs -> let aenv = bind fde a x in let res = (eval fb aenv) in if res = Bool(true) then x::aux(a, fb, fde, xs) else aux(a, fb, fde, xs))
															in if check(fbody) = "bool" then Set(i ,aux(arg, fbody, fDecEnv, lst)) else failwith("not a predicate"))
	| (_, _, _) -> failwith("run-time error"))

and map(funct, aSet) =
(match (funct, typecheck("set", aSet), aSet) with
	| (Closure(arg, fbody, fDecEnv), true, Set(i, lst)) -> (let rec aux(a, fb, fde, lst) =
															match lst with
															| [] -> []
															| x::xs -> let aenv = bind fde a x in (eval fb aenv)::aux(a, fb, fde, xs) in Set(check(fbody), aux(arg, fbody, fDecEnv, lst)))
	| (_, _, _) -> failwith("run-time error"))
;;
