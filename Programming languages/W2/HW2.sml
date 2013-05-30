(*Problem 1*)

fun same_string(s1 : string, s2 : string) =
    s1 = s2

(*a*)
fun all_except_option (str, strings) =
    case strings of
        [] => NONE
      | s :: tail =>
        if not(same_string(str, s))
        then
            case all_except_option(str, tail) of
                SOME x => SOME(s :: x)
              | NONE => NONE
        else
            SOME(tail)

(*b*)
fun get_substitutions1 (substitutions, s) =
    case substitutions of
        [] => []
      | names_list :: tail =>
        case all_except_option(s, names_list) of
            NONE => get_substitutions1(tail, s)
          | SOME x => x @ get_substitutions1(tail, s)

(*c*)
fun get_substitutions2 (substitutions, s) =
    let
        fun get_substitutions2_internal (substitutions, s, curr_result) =
            case substitutions of
                [] => curr_result
              | names_list :: tail =>
                case all_except_option(s, names_list) of
                    NONE => get_substitutions2_internal(tail, s, curr_result)
                  | SOME x => get_substitutions2_internal(tail, s, x @ curr_result)
    in
        get_substitutions2_internal(substitutions, s, [])
    end

(*d*)
fun similar_names (substitutions, full_name) =
    let
        val {first = first_, middle = middle_, last = last_} = full_name

        fun get_similar_full_names (names) =
            case names of
                [] => []
              | name :: tail =>
                {first = name, middle = middle_, last = last_} :: get_similar_full_names(tail)
    in
        full_name :: get_similar_full_names(get_substitutions1(substitutions, first_))
    end


(*Problem 2*)

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int

type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove


(*a*)
fun card_color (card) =
    let
        val (suit_type, _) = card
    in
        case suit_type of
            Clubs => Black
          | Spades => Black
          | Diamonds => Red
          | Hearts => Red
    end

(*b*)
fun card_value (card) =
    let
        val (_, rank_type) = card
    in
        case rank_type of
            Num n => n
          | Ace => 11
          | _ => 10
    end

(*c*)
fun remove_card (cs, c : card, e) =
    case cs of
        [] => raise e
      | card :: rest =>
        if c <> card then
            card :: remove_card(rest, c, e)
        else
            rest

(*d*)
fun all_same_color (cards) =
    case cards of
        [] => true
      | head :: [] => true
      | head :: (neck :: tail) =>
        if card_color(head) <> card_color(neck) then
            false
        else
            all_same_color(neck :: tail)

(*e*)
fun sum_cards (cards) =
    let
        fun sum_cards_internal(cards, curr_result) =
            case cards of
                [] => curr_result
              | head :: tail => sum_cards_internal(tail, curr_result + card_value(head))
    in
        sum_cards_internal(cards, 0)
    end

(*f*)
fun score (cards, goal) =
    let
        val sum = sum_cards(cards)
        val prelim_score = if sum > goal then 3 * (sum - goal) else (goal - sum)
    in
        if all_same_color(cards) then prelim_score div 2 else prelim_score
    end

(*g*)
fun officiate (card_list, move_list, goal) =
    let
        fun game_loop (cards, moves, held_cards) =
            case moves of
                [] => score(held_cards, goal)

              | Draw :: rest_moves =>
                (case cards of
                    [] => score(held_cards, goal)

                  | head_card :: rest_cards =>
                    if (card_value(head_card) + sum_cards(held_cards)) > goal then
                        score(head_card :: held_cards, goal)
                    else
                        game_loop(rest_cards, rest_moves, head_card :: held_cards))

              | (Discard card_to_discard) :: rest_moves =>
                game_loop(cards, rest_moves,
                          remove_card(held_cards, card_to_discard, IllegalMove))
    in 
        game_loop(card_list, move_list, [])
    end

