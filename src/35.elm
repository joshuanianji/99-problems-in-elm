module Main exposing (main)

import Debug
import Html exposing (Html)



-- I had to get help for my primesUntil function cuz it was heavily not optimized oops


primesUntil : Int -> List Int
primesUntil n =
    let
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
    in
    eratos (List.range 2 n) []


gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
        abs a

    else
        gcd b (remainderBy b a)


coprime : Int -> Int -> Bool
coprime a b =
    gcd a b == 1


primeFactors : Int -> List Int
primeFactors num =
    let
        primeList =
            List.reverse (primesUntil (num // 2))

        primeFactorIter n list answer =
            case list of
                [] ->
                    answer

                x :: xs ->
                    if coprime x n then
                        primeFactorIter n xs answer

                    else
                        primeFactorIter (n // x) list (x :: answer)
    in
    primeFactorIter num primeList []


main : Html msg
main =
    primeFactors 120
        |> Debug.toString
        |> Html.text
