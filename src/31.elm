module Main exposing (main)

import Debug
import Html exposing (Html)
import List



-- using the Sieve of Eratosthenes


isPrime : Int -> Bool
isPrime num =
    let
        iterList =
            List.range 2 num

        isPrimeListIter n test list =
            if test * test > n then
                list

            else
                isPrimeListIter
                    n
                    (test + 1)
                    (List.filter
                        (\x -> remainderBy x test /= 0)
                        list
                    )
    in
    List.member num (isPrimeListIter num 2 iterList)


main : Html msg
main =
    isPrime 13
        |> Debug.toString
        |> Html.text
