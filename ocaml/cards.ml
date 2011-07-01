(* 
   http://caml.inria.fr/pub/docs/oreilly-book/html/book-ora016.html#toc21
 *)

type suit = Spades | Hearts | Diamonds | Clubs ;;
type card = 
      King of suit
    | Queen of suit
    | Knight of suit
    | Knave of suit
    | Minor_card of suit * int
    | Trump of int
    | Joker ;;

(* The creation of a value of type card is carried out through the application of a constructor to a value of the appropriate type. *)

King Spades ;;
Minor_card(Hearts, 10) ;;
Trump 21 ;;


(* And here, for example, is the function all_cards which constructs a list of all the cards of a suit passed as a parameter. *)

let rec interval a b =  if a = b then [b] else a::(interval (a+1) b) ;;

let all_cards s = 
    let face_cards = [ Knave s; Knight s; Queen s; King s ]
    and other_cards  = List.map (function n -> Minor_card(s,n)) (interval 1 10)
    in face_cards @ other_cards ;;

all_cards Hearts ;;


let string_of_suit = function
       Spades   -> "spades"
    |  Diamonds -> "diamonds"
    |  Hearts   -> "hearts"
    |  Clubs    -> "clubs"  ;;

let string_of_card = function 
       King c            -> "king of " ^ (string_of_suit c)
    |  Queen c           -> "queen of " ^ (string_of_suit c)
    |  Knave c           -> "knave of " ^ (string_of_suit c)
    |  Knight c          -> "knight of " ^ (string_of_suit c)
    |  Minor_card (c, n) -> (string_of_int n) ^ " of "^(string_of_suit c)
    |  Trump n           -> (string_of_int n) ^ " of trumps"
    |  Joker             -> "joker" ;;
