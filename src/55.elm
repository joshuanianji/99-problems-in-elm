module Main exposing (Tree(..), balancedTree, emptyNode, isEven, main)

import Debug
import Html exposing (..)



-- Construsting balanced binary trees


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


emptyNode : a -> Tree a
emptyNode value =
    Node value Empty Empty


balancedTree : Int -> Tree Char
balancedTree numNodes =
    if numNodes < 1 then
        Empty

    else if numNodes == 1 then
        Node 'x' Empty Empty

    else
        let
            n_ =
                (numNodes - 1) // 2
        in
        if isEven numNodes then
            Node 'x' (balancedTree (n_ + 1)) (balancedTree n_)

        else
            Node 'x' (balancedTree n_) (balancedTree n_)


isEven x =
    remainderBy x 2 == 0


main : Html msg
main =
    balancedTree 7
        |> Debug.toString
        |> Html.text
