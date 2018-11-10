module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Debug


-- I had to look at the solutions. It is very clever


myList =
    [ 1, 1, 2, 2, 3, 3, 3, 4, 5, 4, 4, 4]

--

noDupes : List a -> List a
noDupes xs =
    foldr noDupCons [] xs


noDupCons : a -> List a -> List a
noDupCons x xs =
    case head xs of
        Nothing -> [x]
        Just a  -> 
            if x == a then
                xs
            else
                x :: xs
                

main : Html msg
main =
    noDupes myList
        |> Debug.toString
        |> Html.text
