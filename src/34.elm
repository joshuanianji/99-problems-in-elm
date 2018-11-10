module Main exposing (main)

import Debug
import Html exposing (Html)



-- Should have done list.filter


gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
        abs a

    else
        gcd b (remainderBy b a)


coprime : Int -> Int -> Bool
coprime a b =
    gcd a b == 1


totientIter : Int -> Int -> Int -> Int
totientIter n m answer =
    if m == 0 then
        answer

    else if coprime n m then
        totientIter n (m - 1) (answer + 1)

    else
        totientIter n (m - 1) answer


totient : Int -> Int
totient n =
    if n == 1 then
        1

    else if n < 1 then
        0

    else
        totientIter n (n - 1) 0


main : Html msg
main =
    totient 10
        |> Debug.toString
        |> Html.text
