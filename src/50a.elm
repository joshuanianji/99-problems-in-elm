module Main exposing (freqs, main, pack, packIter, removeNothings, runLengths)

import Debug
import Html exposing (..)



-- Huffman Encoding


freqs : List comparable -> List ( Int, comparable )
freqs list =
    list
        |> List.sort
        |> pack
        |> runLengths


packIter : List (List a) -> List a -> List a -> List (List a)
packIter acc stAcc list =
    case list of
        [] ->
            acc

        [ a, b ] ->
            if a == b then
                List.append acc [ List.append [ a, b ] stAcc ]

            else
                List.append (List.append acc [ a :: stAcc ]) [ [ b ] ]

        [ x ] ->
            List.append [ [ x ] ] acc

        a :: b :: xs ->
            if a == b then
                packIter acc (a :: stAcc) (b :: xs)

            else
                packIter (List.append acc [ a :: stAcc ]) [] (b :: xs)


pack : List a -> List (List a)
pack list =
    packIter [] [] list


runLengths : List (List a) -> List ( Int, a )
runLengths lists =
    List.map
        (\subList ->
            ( List.length subList, List.head subList )
        )
        lists
        |> removeNothings


removeNothings : List ( Int, Maybe a ) -> List ( Int, a )
removeNothings list =
    case list of
        [] ->
            []

        ( length, Nothing ) :: xs ->
            removeNothings xs

        ( length, Just a ) :: xs ->
            ( length, a ) :: removeNothings xs


main : Html msg
main =
    freqs [ 1, 20, 20, 3, 3, 3, 3 ]
        |> Debug.toString
        |> Html.text
