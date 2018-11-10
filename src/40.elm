module Main exposing (eratos, goldbach, isOdd, main, primesUntil)

import Debug
import Html exposing (..)



-- executing the goldbach conjecture


eratos : List Int -> List Int -> List Int
eratos candidates primes =
    case candidates of
        [] ->
            List.reverse primes

        x :: xs ->
            let
                cs =
                    List.filter (\y -> remainderBy y x /= 0) xs
            in
            eratos cs (x :: primes)


primesUntil : Int -> List Int
primesUntil num =
    eratos (List.range 2 num) []


goldbach : Int -> Maybe ( Int, Int )
goldbach num =
    if isOdd num || num < 3 then
        Nothing

    else
        let
            primesList =
                primesUntil num

            goldbachIter list number =
                case list of
                    [] ->
                        Nothing

                    x :: xs ->
                        if List.member (num - x) primesList then
                            Just ( x, num - x )

                        else
                            goldbachIter xs number
        in
        goldbachIter primesList num


isOdd : Int -> Bool
isOdd n =
    n % 2 /= 0


main : Html msg
main =
    goldbach 90000
        |> Debug.toString
        |> Html.text
