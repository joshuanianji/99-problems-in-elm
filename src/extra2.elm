module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- exactly the same as the solutions as well!


myList =
    [ 2, 4, 6, 1, 3 ]


takeWhile : (a -> Bool) -> List a -> List a
takeWhile predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if predicate x then
                x :: takeWhile predicate xs

            else
                []


isEven x =
    remainderBy x 2 == 0


isOdd x =
    remainderBy x 2 /= 0


main : Html msg
main =
    takeWhile isEven myList
        |> Debug.toString
        |> Html.text
