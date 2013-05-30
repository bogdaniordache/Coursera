fun is_older (d1: int*int*int, d2: int*int*int)=
    if (#1 d1) < (#1 d2)
    then true
    else if (#2 d1) < (#2 d2)
    then true
    else if (#3 d1) < (#3 d2)
    then true
    else false

fun number_in_month (dl1: (int*int*int) list, m: int)=
    if null dl1
    then 0
    else if #2(hd dl1) = m
    then number_in_month ((tl dl1), m) + 1
    else number_in_month ((tl dl1), m)

fun number_in_months (dl2 : (int*int*int) list, ml : int list) = 
    if null ml
    then 0 
    else number_in_month(dl2, (hd ml)) + number_in_months(dl2, (tl ml))

fun dates_in_month (dl3: (int*int*int) list, m1: int)=
    if null dl3
    then []
    else if #2(hd dl3) = m1
    then (hd dl3) :: (dates_in_month((tl dl3), m1))
    else dates_in_month((tl dl3), m1)

fun dates_in_months (dl4: (int*int*int) list, ml1: int list)=
    if null ml1
    then []
    else dates_in_month (dl4, hd ml1) @ dates_in_months( dl4, tl ml1)

fun get_nth (s: string list, n: int)=
    if n = 1 
    then (hd s)
    else get_nth(tl s, n - 1)

fun month_name (index : int) = 
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] 
    in
        get_nth(months, index)
    end

fun date_to_string (date : (int*int*int)) = 
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
        month_name(#2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum : int, l : int list) = 
    let fun helper (acc : int, n : int, l : int list) = 
            if acc + hd l >= sum
            then n
            else helper (acc + hd l, n + 1, tl l) 
    in
        helper(0, 0, l)
    end

MULT MAI BINE ASA:
fun number_before_reaching_sum (sum : int, lst : int list) =
    if sum <= hd lst
    then 0
    else 1 + number_before_reaching_sum(sum - hd lst, tl lst)




fun what_month (day : int) = 
    let val days_of_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(day, days_of_months) + 1
    end

fun month_range (d1 : int, d2 : int) = 
    if d1 > d2
    then []
    else what_month(d1) :: month_range(d1 + 1, d2)

fun oldest (dates : (int*int*int) list) = 
    let fun helper (dates : (int*int*int) list) = 
            if null (tl dates)
            then hd dates
            else let val older = helper (tl dates) 
                 in
                     if is_older (hd dates, older)
                     then hd dates
                     else older
                 end
    in
        if null dates
        then NONE
        else SOME (helper dates)
    end

fun in_list(n : int, l : int list) = 
    if null l
    then false
    else if (hd l) = n
    then true
    else in_list(n, tl l)

fun ml_unique(l : int list) = 
    if null l
    then []
    else if in_list (hd l, tl l)
    then ml_unique(tl l)
    else (hd l) :: ml_unique(tl l)

fun number_in_months_challenge (dl2 : (int*int*int) list, ml : int list) = 
   number_in_months (dl2, ml_unique(ml))

fun dates_in_months_challenge (dl4 : (int*int*int) list, ml1 : int list) = 
    dates_in_months (dl4, ml_unique(ml1))

