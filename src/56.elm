module Main exposing (Tree(..), isSymmetric, main, mirror, tree1)

import Debug
import Html exposing (..)



-- testing the symmetry of a binary tree


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


mirror : Tree a -> Tree a -> Bool
mirror left right =
    case left of
        Empty ->
            case right of
                Empty ->
                    True

                _ ->
                    False

        Node lv ll lr ->
            case right of
                Empty ->
                    False

                Node rv rl rr ->
                    mirror lr rl && mirror ll rr


isSymmetric : Tree a -> Bool
isSymmetric tree =
    case tree of
        Empty ->
            True

        Node value left right ->
            mirror left right


tree1 =
    Node 1
        (Node 2
            (Node 3 Empty Empty)
            (Node 4
                Empty
                (Node 5 Empty Empty)
            )
        )
        (Node 6
            (Node 8
                (Node 9 Empty Empty)
                Empty
            )
            (Node 7 Empty Empty)
        )


main : Html msg
main =
    isSymmetric tree1
        |> Debug.toString
        |> Html.text
