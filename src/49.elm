module Main exposing (grayCodes, main)

import Debug
import Html exposing (..)



-- Graycodes (e.g. grayCode 2 == [ [ 0, 0 ], [ 0, 1 ], [ 1, 1 ], [ 1, 0 ] ])


grayCodes : Int -> List (List Int)
grayCodes n =
    case n of
        0 ->
            [ [] ]

        1 ->
            [ [ 0 ], [ 1 ] ]

        a ->
            List.map
                (\x -> 0 :: x)
                (grayCodes (a - 1))
                ++ List.map
                    (\x -> 1 :: x)
                    (a
                        - 1
                        |> grayCodes
                        |> List.reverse
                    )


main : Html msg
main =
    grayCodes 3
        |> Debug.toString
        |> Html.text
