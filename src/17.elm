module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Debug


-- This was pretty good


myList =
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]


split list n =
    if n <= 0 then
        ([], list)
    else
        (take n list, drop n list)
    
    
    
main : Html msg
main =
    split myList 0
        |> Debug.toString
        |> Html.text
