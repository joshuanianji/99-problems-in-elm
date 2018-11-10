module Main exposing (Tree(..), Weight, binaryHuffman, main, myList, mySecondList, returnWeight, sortByWeights, toBinaryTrees)

import Debug
import Html exposing (..)



-- Construsting binary search trees
-- I AM ABLE TO OMPLETE THE BINARY TREE, ALL THAT IS LEFT IS THE DECODING


type alias Weight =
    Int


type Tree a
    = Empty
    | Node Weight a (Tree a) (Tree a)


returnWeight : Tree a -> Weight
returnWeight node =
    case node of
        Empty ->
            0

        Node weight a left right ->
            weight


sortByWeights : List (Tree a) -> List (Tree a)
sortByWeights list =
    List.sortBy returnWeight list


toBinaryTrees : List ( a, Int ) -> List (Tree a)
toBinaryTrees list =
    list
        |> List.map
            (\( element, weight ) ->
                Node weight element Empty Empty
            )
        |> sortByWeights


binaryHuffman : List (Tree a) -> Tree a
binaryHuffman list =
    case list of
        [] ->
            Empty

        -- this should never happen
        [ tree ] ->
            tree

        (Node weighta elementa lefta righta) :: (Node weightb elementb leftb rightb) :: xs ->
            let
                test =
                    "test"
            in
            Node
                (weighta + weightb)
                elementa
                (Node weighta elementa lefta righta)
                (Node weightb elementb leftb rightb)
                :: xs
                |> sortByWeights
                |> binaryHuffman

        _ ->
            Empty


myList =
    [ ( 'a', 45 ), ( 'b', 13 ), ( 'c', 12 ), ( 'd', 16 ), ( 'e', 9 ), ( 'f', 5 ) ]


mySecondList =
    [ ( 'g', 3 ), ( 'o', 3 ), ( ' ', 2 ), ( 'e', 1 ), ( 's', 1 ), ( 'h', 1 ), ( 'p', 1 ), ( 'r', 1 ) ]


main : Html msg
main =
    mySecondList
        |> toBinaryTrees
        |> binaryHuffman
        |> Debug.toString
        |> Html.text
