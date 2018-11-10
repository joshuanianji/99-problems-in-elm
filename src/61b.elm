module Main exposing (Tree(..), getLeaves, main, myTree)

import Debug
import Html exposing (..)



-- Gathering all the leaves and putting their values in a list


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


myTree : Tree Int
myTree =
    Node 1
        (Node 2 Empty (Node 4 Empty Empty))
        (Node 2 Empty Empty)


getLeaves : Tree a -> List a
getLeaves tree =
    case tree of
        Empty ->
            []

        Node n Empty Empty ->
            [ n ]

        Node n left right ->
            getLeaves left ++ getLeaves right


main : Html msg
main =
    getLeaves myTree
        |> Debug.toString
        |> Html.text
