module Main exposing (main)

import Debug
import Html exposing (Html)



-- abs because negative numbers


gcd a b =
    if b == 0 then
        abs a

    else
        gcd b (remainderBy b a)


main : Html msg
main =
    gcd 37 23
        |> Debug.toString
        |> Html.text
