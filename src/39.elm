module Main exposing (main)

import Debug
import Html exposing (Html)



-- finds primes between bounds (inclusive)


isPrime : Int -> Bool
isPrime n =
    if n < 2 then
        False

    else
        eratos (abs n) (List.range 2 (n // 2))


eratos : Int -> List Int -> Bool
eratos n cs =
    case cs of
        [] ->
            True

        x :: xs ->
            if n % x == 0 then
                False

            else
                eratos n (List.filter (\y -> remainderBy y x /= 0) xs)


primesInRange : Int -> Int -> List Int
primesInRange lower upper =
    List.filter
        isPrime
        (List.range lower upper)


main : Html msg
main =
    primesInRange 10 20
        |> Debug.toString
        |> Html.text
