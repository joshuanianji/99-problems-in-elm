module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- Wow this code sure looks bad.


myList =
    [ 1, 2, 3, 4, 5 ]


rotate : Int -> List a -> List a
rotate amount list =
    if amount == 0 || length list == 0 then
        list

    else if amount < 0 then
        -- rotate right
        let
            modAmount =
                abs (remainderBy amount (length list))

            endSplice =
                drop (length list - modAmount) list

            startSplice =
                take (length list - modAmount) list
        in
        append endSplice startSplice

    else
        -- rotate left
        let
            modAmount =
                remainderBy amount (length list)

            startSplice =
                take modAmount list

            endSplice =
                drop modAmount list
        in
        append endSplice startSplice



-- LMAO LOOK AT THE ANSWER
{-
   rotate n list =
       case list of
           [] ->
               []

           _ ->
               let
                   -- I DON'T NEED SEPARATE CASES FOR WHEN THE AMOUNT OF ABOVE OR BELOW ZERO BECAUSE THE MODULUS DOES THE SAME THING LMAO
                   rotate =
                       n % (length list)
               in
                   drop r list ++ take r list
-}


main : Html msg
main =
    rotate -1 myList
        |> Debug.toString
        |> Html.text
