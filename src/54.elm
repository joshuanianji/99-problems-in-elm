module Main exposing (MyTree(..), TheirTree(..), main)

import Debug
import Html exposing (..)



-- Binary Tree
-- Lmao we had different viewpoints on the Binary tree. I'll still use theirs, because it's the type of binary tree that the book will be using and  I shouldn't do my own crap


type MyTree a
    = MyNode a
    | MyBranch ( MyTree a, MyTree a )


type TheirTree a
    = Empty
    | TheirNode a (TheirTree a) (TheirTree a)


main : Html msg
main =
    "Hello World"
        |> Debug.toString
        |> Html.text
