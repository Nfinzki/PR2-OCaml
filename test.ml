                                (*EmptySet test*)
(*Creazione di un insieme vuoto di interi*)
let s = EmptySet("int");;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)


(*Creazione di un insieme vuoto di booleani*)
let s = EmptySet("bool");;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", []) *)


(*Creazione di un insieme vuoto di stringhe*)
let s = EmptySet("string");;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", []) *)


(*Creazione di un insieme vuoto di un tipo non corretto*)
let s = EmptySet("if");;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "Invalid type". *)



                                (*Singleton test*)
(*Creazione di un insieme di interi contenente un solo valore*)
let s = Singleton(CstInt(2), "int");;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 2]) *)


(*Creazione di un insieme di booleani contenente un solo valore*)
let s = Singleton(CstTrue, "bool");;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool true]) *)


(*Creazione di un insieme di stringhe contenente un solo valore*)
let s = Singleton(CstString("Hello"), "string");;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", [String "Hello"]) *)


(*Creazione di un insieme di interi contenente un valore errato*)
let s = Singleton(CstString("Hello"), "int");;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)



                                (*Of test*)
(*Creazione di un insieme di interi contenente una serie di valori*)
let s = Of("int", Val(Sum(CstInt(3), CstInt(5)), Val(Apply(Fun("x", Sum(Den("x"), CstInt(1))), CstInt(5)), Empty)));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 8; Int 6]) *)
let s = Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(3), Val(CstInt(2), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 1; Int 3; Int 2]) *)


(*Creazione di un insieme di booleani contenente una serie di valori*)
let s = Of("bool", Val(CstTrue, Val(CstFalse, Val(CstTrue, Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool false; Bool true]) *)


(*Creazione di un insieme di stringhe contenente una serie di valori*)
let s = Of("string", Val(CstString("hello"), Val(CstString("world"), Empty)));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", [String "hello"; String "world"]) *)


(*Creazione di un insieme di booleani contenente una serie di valori errati*)
let s = Of("bool", Val(CstString("hello"), Val(CstTrue, Empty)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)



                                (*Union test*)
(*Unione di due set di interi*)
let s = Union(Of("int", Val(Sum(CstInt(3), CstInt(5)), Val(Apply(Fun("x", Sum(Den("x"), CstInt(1))), CstInt(5)), Empty))), Of("int", Val(CstInt(8), Val(CstInt(7) , Val(CstInt(1), Val(CstInt(10) , Empty))))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 6; Int 8; Int 7; Int 1; Int 10]) *)


(*Unione di due set di booleani*)
let s = Union(Of("bool", Val(CstTrue, Val(CstFalse , Empty))), Singleton(CstTrue, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool false; Bool true]) *)


(*Unione di due set di stringhe*)
let s = Union(Singleton(CstString("hello"), "string"), Of("string", Val(CstString("hello"), Val(CstString("world"), Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", [String "hello"; String "world"]) *)


(*Unione di due set di cui uno vuoto*)
let s = Union(Singleton(CstInt(1), "int"), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 1]) *)


(*Unione di due set con tipi diversi*)
let s = Union(Singleton(CstTrue, "bool"), Singleton(CstInt(3), "int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)


(*Unione di un'espressione con un set*)
let s = Union(Sum(CstInt(1), CstInt(2)), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Intersect test*)
(*Intersezione di due set di interi*)
let s = Intersect(Of("int", Val(Sum(CstInt(3), CstInt(5)), Val(Apply(Fun("x", Sum(Den("x"), CstInt(1))), CstInt(5)), Empty))), Of("int", Val(CstInt(8), Val(CstInt(7) , Val(CstInt(1), Val(CstInt(6) , Empty))))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 8; Int 6]) *)


(*Intersezione di due set di booleani*)
let s = Intersect(Of("bool", Val(CstTrue, Val(CstFalse , Empty))), Singleton(CstTrue, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool true]) *)


(*Intersezione di due set di stringhe*)
let s = Intersect(Singleton(CstString("hello"), "string"), Of("string", Val(CstString("hello"), Val(CstString("world"), Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", [String "hello"]) *)


(*Intersezione di due set di interi con elementi distinti*)
let s = Intersect(Singleton(CstInt(1), "int"), Singleton(CstInt(2), "int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)


(*Intersezione di due set di cui uno vuoto*)
let s = Intersect(Singleton(CstInt(1), "int"), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)


(*Intersezione di due set con tipi diversi*)
let s = Intersect(Singleton(CstTrue, "bool"), Singleton(CstInt(3), "int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)


(*Intersezione di un'espressione con un set*)
let s = Intersect(Sum(CstInt(1), CstInt(2)), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Difference test*)
(*Differenza di due set di interi*)
let s = Difference(Of("int", Val(Sum(CstInt(3), CstInt(5)), Val(Apply(Fun("x", Sum(Den("x"), CstInt(1))), CstInt(5)), Empty))), Of("int", Val(CstInt(8), Val(CstInt(7) , Val(CstInt(1), Val(CstInt(6) , Empty))))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)
let s = Difference(Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(3), Empty)))), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 2]) *)


(*Differenza di due set di booleani*)
let s = Difference(Of("bool", Val(CstTrue, Empty)), Of("bool", Val(CstFalse, Val(CstTrue, Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", []) *)


(*Differenza di due set di stringhe*)
let s = Difference(Of("string", Val(CstString("hello"), Val(CstString("prova"), Val(CstString("test"), Val(CstString("world"), Empty))))), Of("string", Val(CstString("test"), Val(CstString("prova"), Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", [String "hello"; String "world"]) *)


(*Differenza di due set con tipi diversi*)
let s = Difference(Of("string", Val(CstString("hello"), Val(CstString("prova"), Val(CstString("test"), Val(CstString("world"), Empty))))), Of("int", Val(CstInt(1), Val(CstInt(2), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)


(*Differenza di due set vuoti*)
let s = Difference(EmptySet("int"), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)


(*Differenza di un'espressione con un set*)
let s = Difference(Sum(CstInt(1), CstInt(2)), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Add test*)
(*Aggiunge un intero ad un set*)
let s = Add(Of("int", Val(CstInt(1) , Val(CstInt(3), Empty))), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 2; Int 1; Int 3]) *)


(*Aggiunge un booleano ad un set*)
let s = Add(Singleton(CstTrue, "bool"), CstFalse);;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool false; Bool true]) *)
let s = Add(Of("bool", Val(CstTrue, Val(CstFalse, Empty))), CstFalse);;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool true; Bool false]) *)


(*Aggiunge una stringa ad un set*)
let s = Add(Singleton(CstString("world"), "string"), CstString("hello"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", [String "hello"; String "world"]) *)


(*Aggiunge un intero ad un set di stringhe*)
let s = Add(Singleton(CstString("world"), "string"), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)


(*Aggiunge un elemento ad un'espressione*)
let s = Add(Sum(CstInt(1), CstInt(2)), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)


(*Aggiunge un set ad un set*)
let s = Add(Singleton(CstString("world"), "string"), EmptySet("string"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)



                                (*Remove test*)
(*Rimuove un intero da un set*)
let s = Remove(Of("int", Val(CstInt(1) , Val(CstInt(3), Val(CstInt(2), Empty)))), CstInt(3));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 1; Int 2]) *)


(*Rimuove un booleano da un set*)
let s = Remove(Singleton(CstTrue, "bool"), CstFalse);;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool true]) *)
let s = Remove(Of("bool", Val(CstTrue, Val(CstFalse, Empty))), CstFalse);;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool true]) *)


(*Rimuove una stringa da un set*)
let s = Remove(Singleton(CstString("world"), "string"), CstString("world"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", []) *)


(*Rimove un intero da un set di stringhe*)
let s = Remove(Singleton(CstString("world"), "string"), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)


(*Rimuove un elemento da un'espressione*)
let s = Remove(Sum(CstInt(1), CstInt(2)), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)


(*Rimuove un set da un set*)
let s = Remove(Singleton(CstString("world"), "string"), EmptySet("string"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)



                                (*IsEmpty test*)
(*Controlla se un set è vuoto*)
let s = IsEmpty(Of("int", Empty));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)
let s = IsEmpty(EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)
let s = IsEmpty(Singleton(CstString("hello"), "string"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)
let s = IsEmpty(Of("bool", Val(CstTrue, Empty)));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se un'espressione è vuota*)
let s = IsEmpty(Sum(CstInt(1), CstInt(2)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error ". *)



                                (*Contains test*)
(*Controlla se un intero è presente all'interno di un set*)
let s = Contains(Of("int", Empty), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)
let s = Contains(Of("int", Val(CstInt(1), Val(CstInt(3), Val(CstInt(2), Empty)))), CstInt(3));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)
let s = Contains(Of("int", Val(CstInt(1), Val(CstInt(2), Empty))), CstInt(3));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se un booleano è presente all'interno di un set*)
let s = Contains(Singleton(CstTrue, "bool"), CstTrue);;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)
let s = Contains(Singleton(CstTrue, "bool"), CstFalse);;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se una stringa è presente all'interno di un set*)
let s = Contains(Of("string", Val(CstString("hello"), Val(CstString("world"), Empty))), CstString("world"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)


(*Controlla se un intero è presente all'interno di un set di stringhe*)
let s = Contains(Of("string", Val(CstString("hello"), Val(CstString("world"), Empty))), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)


(*Controlla se un intero è presente all'interno di un'espressione*)
let s = Contains(Sum(CstInt(1), CstInt(2)), CstInt(2));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*SubSet test*)
(*ATTENZIONE: La signature dell'operazione primitiva SubSet è (SubSet_da_cercare, Set_in_cui_cercare)*)
(*Controlla se un set è un sottoinsieme di un altro set*)
let s = SubSet(Of("int", Val(CstInt(1), Val(CstInt(3), Empty))), Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(3), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)
let s = SubSet(Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(3), Empty)))), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)
let s = SubSet(Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(3), Empty)))), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se un set è un sottoinsieme di un set vuoto*)
let s = SubSet(EmptySet("bool"), Singleton(CstTrue, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)


(*Controlla se un set di interi è sottoinsieme di un set di stringhe*)
let s = SubSet(Singleton(CstInt(1), "int"), Of("string", Val(CstString("hello"), Val(CstString("world"), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "type mismatch". *)


(*Controlla se un'espressione è sottoinsieme di un set di booleani*)
let s = SubSet(Sum(CstInt(1), CstInt(2)), Singleton(CstInt(1), "int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Max test*)
(*Restituisce l'elemento massimo in un set di interi*)
let s = Max(Of("int", Val(CstInt(2), Val(CstInt(5), Val(CstInt(1), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Int 5 *)


(*Restituisce l'elemento massimo in un set di booleani*)
let s = Max(Of("bool", Val(CstTrue, Val(CstFalse, Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)


(*Restituisce l'elemento massimo in un set di stringhe. Ovvero l'ultimo elemento in ordine alfabetico*)
let s = Max(Of("string", Val(CstString("hello"), Val(CstString("world"), Val(CstString("prova"), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = String "world" *)


(*Restituisce l'elemento massimo in un set vuoto di interi*)
let s = Max(EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "empty list". *)


(*Restituisce l'elemento massimo in un'espressione*)
let s = Max(Sum(CstInt(1), CstInt(4)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Min test*)
(*Restituisce l'elemento minimo in un set di interi*)
let s = Min(Of("int", Val(CstInt(2), Val(CstInt(5), Val(CstInt(1), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Int 1 *)


(*Restituisce l'elemento minimo in un set di booleani*)
let s = Min(Of("bool", Val(CstTrue, Val(CstFalse, Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Restituisce l'elemento minimo in un set di stringhe. Ovvero il primo elemento in ordine alfabetico*)
let s = Min(Of("string", Val(CstString("hello"), Val(CstString("world"), Val(CstString("prova"), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = String "hello" *)


(*Restituisce l'elemento minimo in un set vuoto di interi*)
let s = Min(EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "empty list". *)


(*Restituisce l'elemento minimo in un'espressione*)
let s = Min(Sum(CstInt(1), CstInt(4)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*For_all test*)
(*Controlla se per tutti gli elementi di un set di interi vale il predicato if(elem == 2) then true else false *)
let s = For_all(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), Of("int", Val(CstInt(1), Val(CstInt(3), Val(CstInt(4), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)
let s = For_all(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), Of("int", Val(CstInt(1), Val(CstInt(3), Val(CstInt(2), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se per tutti gli elementi di un set vuoto vale il predicato precedente*)
let s = For_all(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)


(*Controlla se per tutti gli elementi di un set di booleani vale il predicato (elem && true) *)
let s = For_all(Fun("n", And(Den("n"), CstTrue)), Singleton(CstTrue, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)


(*Controlla se per tutti gli elementi di un set di booleani vale il predicato (elem && true) *)
let s = For_all(Fun("n", And(Den("n"), CstTrue)), Singleton(CstFalse, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se per tutti gli elementi di un dato che non è un set vale il predicato if(elem == 2) then true else false *)
let s = For_all(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), Sum(CstInt(1), CstInt(3)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)


(*Controlla se per tutti gli elementi di un set di interi vale una fuznione che non è un predicato*)
let s = For_all(Fun("n", Sum(Den("n"), CstInt(1))), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "not a predicate". *)


(*Controlla se per tutti gli elementi di un set di interi vale una espressione*)
let s = For_all(Times(CstInt(1), CstInt(2)), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Exists test*)
(*Controlla se esiste almeno un elemento di un set di interi per cui vale il predicato if(elem == 2) then true else false *)
let s = Exists(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(4), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)
let s = Exists(Fun("n", Ifthenelse(Eq(CstInt(2), Den("n")), CstTrue, CstFalse)), Of("int", Val(CstInt(1), Val(CstInt(3), Val(CstInt(5), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se esiste almeno un elemento di un set vuoto per cui vale il predicato precedente*)
let s = Exists(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se esiste almeno un elemento di un set di booleani per cui vale il predicato (elem && true) *)
let s = Exists(Fun("n", And(Den("n"), CstTrue)), Singleton(CstTrue, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool true *)


(*Controlla se esiste almeno un elemento di un set di booleani per cui vale il predicato (elem && true) *)
let s = Exists(Fun("n", And(Den("n"), CstTrue)), Singleton(CstFalse, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Bool false *)


(*Controlla se esiste almeno un elemento di un dato che non è un set vale il predicato if(elem == 2) then true else false *)
let s = Exists(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), Sum(CstInt(1), CstInt(3)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)


(*Controlla se esiste almeno un elemento di un set di interi vale una fuznione che non è un predicato*)
let s = Exists(Fun("n", Sum(Den("n"), CstInt(1))), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "not a predicate". *)


(*Controlla se esiste almeno un elemento di un set di interi per cui vale una espressione*)
let s = Exists(Times(CstInt(1), CstInt(2)), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Filter test*)
(*Restituisce un set di elementi per cui vale il predicato if(elem == 2) then true else false applicato ad un set di interi*)
let s = Filter(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(4), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 1; Int 4]) *)
let s = Filter(Fun("n", Ifthenelse(Eq(CstInt(2), Den("n")), CstTrue, CstFalse)), Of("int", Val(CstInt(1), Val(CstInt(3), Val(CstInt(5), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)


(*Restituisce un set di elementi per cui vale il predicato precedente, applicato ad un set vuoto*)
let s = Filter(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)


(*Restituisce un set di elementi per cui vale (elem && true), applicato ad un set di booleani*)
let s = Filter(Fun("n", And(Den("n"), CstTrue)), Of("bool", Val(CstTrue, Val(CstTrue, Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool true]) *)


(*Restituisce un set di elementi per cui vale (elem && true), applicato ad un set di booleani*)
let s = Filter(Fun("n", And(Den("n"), CstTrue)), Singleton(CstFalse, "bool"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", []) *)


(*Restituisce un set di elementi per cui vale il predicato, applicato ad un'espressione*)
let s = Filter(Fun("n", Ifthenelse(Not(Eq(CstInt(2), Den("n"))), CstTrue, CstFalse)), Sum(CstInt(1), CstInt(3)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)


(*Restituisce un set di elementi per cui vale una funzione che non è un predicato, applicato ad un set di interi*)
let s = Filter(Fun("n", Sum(Den("n"), CstInt(1))), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "not a predicate". *)


(*Restituisce un set di elementi per cui vale una espressione, applicata ad un set di interi*)
let s = Filter(Times(CstInt(1), CstInt(2)), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)



                                (*Map test*)
(*Restituisce un set di elementi che sono il risultato dell'applicazione di una funzione agli elementi di un set di interi*)
let s = Map(Fun("n", Sum(Den("n"), CstInt(1))), Of("int", Val(CstInt(1), Val(CstInt(2), Val(CstInt(3), Empty)))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", [Int 2; Int 3; Int 4]) *)


(*Restituisce un set di elementi che sono il risultato dell'applicazione di una funzione agli elementi di un set vuoto di interi*)
let s = Map(Fun("n", Sum(Den("n"), CstInt(1))), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("int", []) *)


(*Restituisce un set di elementi che sono il risultato dell'applicazione di una funzione agli elementi di un set di booleani*)
let s = Map(Fun("n", And(Den("n"), CstTrue)), Of("bool", Val(CstTrue, Val(CstFalse, Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("bool", [Bool true; Bool false]) *)


(*Restituisce un set di stringhe che sono il risultato dell'applicazione di una funzione agli elementi di un set di interi*)
let s = Map(Fun("n", Ifthenelse(Eq(CstInt(2), Den("n")), CstString("Due"), CstString("Non due"))), EmptySet("int"));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", []) *)
let s = Map(Fun("n", Ifthenelse(Eq(CstInt(2), Den("n")), CstString("Due"), CstString("Non due"))), Of("int", Val(CstInt(1), Val(CstInt(2), Empty))));;
(*Risultato ottenuto dopo la valutazione:
- : evT = Set ("string", [String "Non due"; String "Due"]) *)


(*Restituisce un set di elementi che sono il risultato dell'applicazione di una funzione ad una espressione*)
let s = Map(Fun("n", Times(Den("n"), CstInt(2))), Sum(CstInt(1), CstInt(3)));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)


(*Restituisce un set di elementi che sono il risultato dell'applicazione di una espressione ad un set di interi*)
let s = Map(Sum(CstInt(1), CstInt(2)), Of("int", Val(CstInt(1), Val(CstInt(3), Empty))));;
(*Risultato ottenuto dopo la valutazione:
Exception: Failure "run-time error". *)