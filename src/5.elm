module Main exposing (main, myReverse)

import Debug
import Html exposing (text)



-- This was really easy because I remember Dad helping me with this lol.


myReverse : List a -> List a
myReverse list =
    List.foldl (::) [] list


main =
    myReverse (List.range 1 10)
        |> Debug.toString
        |> Html.text
