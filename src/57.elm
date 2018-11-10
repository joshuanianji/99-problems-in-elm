module Main exposing (Tree(..), addNode, main, toBSTree)

import Debug
import Html exposing (..)



-- Construsting binary search trees


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


toBSTree : List Int -> Tree Int
toBSTree list =
    List.foldl
        addNode
        Empty
        list


addNode : Int -> Tree Int -> Tree Int
addNode number tree =
    case tree of
        Empty ->
            Node number Empty Empty

        Node nodeValue left right ->
            if number == nodeValue then
                tree

            else if number > nodeValue then
                Node nodeValue left (addNode number right)

            else
                Node nodeValue (addNode number left) right


main : Html msg
main =
    toBSTree [ 6, 2, 4, 20, 1, 11, 12, 14 ]
        |> Debug.toString
        |> Html.text
