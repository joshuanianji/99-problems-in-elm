module Main exposing (isPalindrome, main)

import Debug
import Html exposing (text)



-- This is arguable the less optimized one, since it compares the whole list, and just not half. Still, it's more simple and easy to read.


isPalindrome : List a -> Bool
isPalindrome list =
    list == List.reverse list


main =
    isPalindrome [ 1, 2, 3, 2, 1 ]
        |> Debug.toString
        |> Html.text
