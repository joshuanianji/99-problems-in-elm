import Html exposing (div, button, p, program, text)
import Html.Events exposing (onClick)
import Task
import Time exposing (Time)
import Debug

-- measures the time to calculate phi of 10090

{- ======================================================
   Test 1
-}


test1 : Int -> Int
test1 n =
    test totient n


totient : Int -> Int
totient n =
    List.length <| List.filter (\x -> coprime n x) (1..n)


coprime : Int -> Int -> Bool
coprime a b =
    gcd a b == 1


gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
        abs a
    else
        gcd b (a % b)



{- ======================================================
   Test 2
-}


test2 : Int -> Int
test2 n =
    test phi n


phi : Int -> Int
phi n =
    if n < 1 then
        0
    else
        List.product
            <| List.map (\( p, m ) -> (p - 1) * p ^ (m - 1))
            <| primeFactorsM n


primeFactorsM : Int -> List ( Int, Int )
primeFactorsM n =
    toTuples <| primeFactors n


primeFactors : Int -> List Int
primeFactors n =
    if n < 2 then
        []
    else
        let
            prime =
                Maybe.withDefault 0
                    <| List.head
                    <| dropWhile (\x -> n % x /= 0) (2..n)
        in
            prime :: (primeFactors <| n // prime)


dropWhile : (a -> Bool) -> List a -> List a
dropWhile predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if (predicate x) then
                dropWhile predicate xs
            else
                list


takeWhile : (a -> Bool) -> List a -> List a
takeWhile predicate xs =
    case xs of
        [] ->
            []

        hd :: tl ->
            if (predicate hd) then
                hd :: takeWhile predicate tl
            else
                []


toTuples : List a -> List ( a, Int )
toTuples fs =
    case fs of
        [] ->
            []

        x :: xs ->
            ( x, List.length (takeWhile (\y -> y == x) fs) )
                :: toTuples (dropWhile (\y -> y == x) fs)



{- ======================================================
   Timing test app
-}


test : (Int -> Int) -> Int -> Int
test f n =
    List.length
        <| List.map f (1..n)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


view model =
    div []
        [ button [ onClick (ExecuteTest 1) ] [ text "Test 1" ]
        , div []
            [ text
                <| case Tuple.first model.testTimes1 of
                    Err msg ->
                        msg

                    Ok s ->
                        case Tuple.second model.testTimes1 of
                            Err msg ->
                                msg

                            Ok e ->
                                ("totient completed in " ++ Debug.toString (e - s) ++ " milliseconds.")
            , p [] []
            , text
                <| case Tuple.first model.testTimes2 of
                    Err msg ->
                        msg

                    Ok s ->
                        case Tuple.second model.testTimes2 of
                            Err msg ->
                                msg

                            Ok e ->
                                ("phi completed in " ++ Debug.toString (e - s) ++ " milliseconds.")
            ]
        , button [ onClick (ExecuteTest 2) ] [ text "Test 2" ]
        ]


type Msg
    = NoOp
    | ExecuteTest Int
    | GetTimeFailure String
    | StartTime Int Time
    | RunTest Int Time
    | EndTest Int Time


type alias TestTimes =
    ( TestTime, TestTime )


type alias TestTime =
    Result String Time


type alias Model =
    { testReps :
        Int
        -- don't hard code this or Elm will memoize the test functions
    , testTimes1 : TestTimes
    , testTimes2 : TestTimes
    }


init : ( Model, Cmd Msg )
init =
    ( { testReps = 1000
      , testTimes1 = ( Err "Please Run Test 1", Err "No end time yet!" )
      , testTimes2 = ( Err "Please Run Test 2", Err "No end time yet!" )
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EndTest n time ->
            ( case n of
                1 ->
                    { model | testTimes1 = ( Tuple.first model.testTimes1, Ok time ) }

                2 ->
                    { model | testTimes2 = ( Tuple.first model.testTimes2, Ok time ) }

                _ ->
                    model
            , Cmd.none
            )

        ExecuteTest n ->
            ( model
            , Task.perform (StartTime n) Time.now
            )

        GetTimeFailure msg ->
            ( { model | testTimes1 = ( Err "No start time yet!", Err "No end time yet!" ) }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )

        RunTest n time ->
            ( case n of
                1 ->
                    { model
                        | testTimes1 = ( Ok time, Err "No end time yet!" )
                        , testReps = always model.testReps (test1 model.testReps)
                    }

                2 ->
                    { model
                        | testTimes2 = ( Ok time, Err "No end time yet!" )
                        , testReps = always model.testReps (test2 model.testReps)
                    }

                _ ->
                    model
            , Task.perform (EndTest n) Time.now
            )

        StartTime n time ->
            ( model
            , Task.perform (RunTest n) Time.now
            )



(..) : Int -> Int -> List Int
(..) start end =
    List.range start end