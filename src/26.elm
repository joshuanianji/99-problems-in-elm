module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- I had to get help lol, but it makes sense if you think about the combinations at the level of 3 elements in the list


combinations : Int -> List a -> List (List a)
combinations n list =
    if n <= 0 then
        [ [] ]

    else
        case list of
            [] ->
                []

            x :: xs ->
                List.map
                    ((::) x)
                    (combinations (n - 1) xs)
                    ++ combinations n xs


myList =
    [ 'a', 'b', 'c' ]


main : Html msg
main =
    combinations 2 myList
        |> Debug.toString
        |> Html.text
