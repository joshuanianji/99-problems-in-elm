module Main exposing (main)

-- Issue!!

import Debug
import Html exposing (Html, button, div, h2, p, text)
import Html.Events exposing (onClick)
import Random



-- randomly select n items from a list


randomSelect : Random.Seed -> Int -> List a -> ( List a, Random.Seed )
randomSelect seed n list =
    let
        ( acc, l, s ) =
            randSelect n ( [], list, seed )
    in
    ( acc, s )


randSelect : Int -> ( List a, List a, Random.Seed ) -> ( List a, List a, Random.Seed )
randSelect n ( acc, list, seed ) =
    if n > 0 then
        let
            ( randPosition, seed_ ) =
                Random.step (Random.int 1 (List.length list)) seed

            remainingList =
                dropAt randPosition list

            randElement =
                elementAt randPosition list
        in
        case randElement of
            Nothing ->
                ( acc, list, seed )

            Just element ->
                randSelect (n - 1) ( element :: acc, remainingList, seed_ )

    else
        ( acc, list, seed )



-- helper functions


elementAt : Int -> List a -> Maybe a
elementAt n list =
    case list of
        [] ->
            Nothing

        x :: xs ->
            if n == 1 then
                Just x

            else
                elementAt (n - 1) xs


dropAt : Int -> List a -> List a
dropAt n list =
    case list of
        [] ->
            []

        hd :: tl ->
            if n == 1 then
                tl

            else
                hd :: dropAt (n - 1) tl



-- Main


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { intSeed : Int
    , tested : Bool
    , failedCount : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1 False 0, Cmd.none )



-- UPDATE


type Msg
    = Test
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Test ->
            ( model, Random.generate NewFace (Random.int Random.minInt Random.maxInt) )

        NewFace newSeed ->
            ( Model newSeed True 0, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Hello" ]
        , p [] [ text ("Seed value: " ++ Debug.toString model.intSeed) ]
        , p [] [ text ("Your random list is : " ++ Debug.toString (Tuple.first (randomSelect (Random.initialSeed model.intSeed) 3 myList))) ]
        , button [ onClick Test ] [ text "Test" ]
        ]


myList =
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
