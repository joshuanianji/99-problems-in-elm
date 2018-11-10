module Main exposing (Tree(..), countLeaves, main, myTree)

import Debug
import Html exposing (..)



-- Counting aount of nodes with all empty children (leaves)


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


myTree : Tree Int
myTree =
    Node 1
        (Node 2 Empty (Node 4 Empty Empty))
        (Node 2 Empty Empty)


countLeaves : Tree Int -> Int
countLeaves tree =
    case tree of
        Empty ->
            0

        Node n Empty Empty ->
            1

        Node n left right ->
            countLeaves left + countLeaves right


main : Html msg
main =
    countLeaves myTree
        |> Debug.toString
        |> Html.text
