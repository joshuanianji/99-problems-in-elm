module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Debug


-- ya answer is a lot better


type RleCode a
    = Run Int a
    | Single a


toRleCode amount a =
    if amount == 1 then
        Single a
    else
        Run amount a


myList =
    [ 1, 1, 1, 1, 2, 3, 3, 4, 5, 5, 5, 5, 5, 5 ]


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


pack list =
    packIter [] [] list


rleEncode : List a -> List (RleCode a)
rleEncode list =
    map
        (\subList ->
            toRleCode (length subList) (head subList)
        )
        (pack list)
        |> removeNothings


removeNothings : List (RleCode (Maybe a)) -> List (RleCode a)
removeNothings list =
    case list of
        [] ->
            []

        (Run amount a) :: xs ->
            case a of
                Nothing ->
                    removeNothings xs

                Just b ->
                    Run amount b :: removeNothings xs

        (Single a) :: xs ->
            case a of
                Nothing ->
                    removeNothings xs

                Just b ->
                    Single b :: removeNothings xs


main : Html msg
main =
    rleEncode myList
        |> Debug.toString
        |> Html.text
