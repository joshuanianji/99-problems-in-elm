module Main exposing (eratos, goldbach, goldbachGT, isOdd, main, primesUntil)

import Debug
import Html exposing (..)



-- finds all numbers that are the sum of primes greater than a specified limit


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


isOdd : Int -> Bool
isOdd n =
    remainderBy n 2 /= 0


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

                    -- THIS SHOULD NEVER HAPPEN
                    x :: xs ->
                        if List.member (num - x) primesList then
                            Just ( x, num - x )

                        else
                            goldbachIter xs number
        in
        goldbachIter primesList num


goldbachGT : Int -> Int -> Int -> List ( Int, Int )
goldbachGT low high limit =
    List.filterMap
        (\x ->
            case goldbach x of
                Just ( a, b ) ->
                    if a > limit then
                        Just ( a, b )

                    else
                        Nothing

                Nothing ->
                    Nothing
        )
        (List.range low high)


main : Html msg
main =
    goldbachGT 1 2000 50
        |> Debug.toString
        |> Html.text
