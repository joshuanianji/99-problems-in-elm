module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- my function was exactly as the solution! These x::xs things are pretty handy


myList =
    [ 1, 2, 3, 4, 5 ]


dropWhile : (a -> Bool) -> List a -> List a
dropWhile predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if predicate x then
                dropWhile predicate xs

            else
                list


isEven x =
    remainderBy x 2 == 0


isOdd x =
    remainderBy x 2 /= 0


main : Html msg
main =
    dropWhile isOdd myList
        |> Debug.toString
        |> Html.text
