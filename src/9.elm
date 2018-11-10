module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- this is disgusting


myList =
    [ 4, 5, 4 ]



-- stAcc is the short term accumulator


packIter : List (List a) -> List a -> List a -> List (List a)
packIter acc stAcc list =
    case list of
        [] ->
            acc

        [ a, b ] ->
            if a == b then
                append acc [ append [ a, b ] stAcc ]

            else
                append (append acc [ a :: stAcc ]) [ [ b ] ]

        [ x ] ->
            append [ [ x ] ] acc

        a :: b :: xs ->
            if a == b then
                packIter acc (a :: stAcc) (b :: xs)

            else
                packIter (append acc [ a :: stAcc ]) [] (b :: xs)


pack : List a -> List (List a)
pack list =
    packIter [] [] list


main : Html msg
main =
    pack myList
        |> Debug.toString
        |> Html.text
