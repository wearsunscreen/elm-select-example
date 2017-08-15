module View exposing (..)

import Dict exposing (Dict, get)
import Html exposing (..)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)


helloWorld =
    "Hello World"


mainStyle : List ( String, String )
mainStyle =
    [ ( "padding", "16px" )
    ]


view : Model -> Html Msg
view model =
    case model.startTime of
        Nothing ->
            viewWelcome model

        Just t ->
            viewStuff model


viewWelcome : Model -> Html Msg
viewWelcome model =
    div [ style mainStyle ]
        [ p [] [ h1 [] [ text "Welcome!" ] ]
        , button [ onClick CloseWelcomeScreen ] [ text "Ok" ]
        ]


viewStuff : Model -> Html Msg
viewStuff model =
    let
        fs =
            items
                |> List.map Tuple.first

        selected1 =
            items
                |> Dict.fromList
                |> Dict.get (Maybe.withDefault "" model.selection1)
                |> Maybe.withDefault (identity)

        selected2 =
            items
                |> Dict.fromList
                |> Dict.get (Maybe.withDefault "" model.selection2)
                |> Maybe.withDefault (identity)
    in
        div [ style mainStyle ]
            [ h2 [] [ text helloWorld ]
            , viewSelect Dropdown1Picked fs
            , h2 [] [ helloWorld |> selected1 |> monitor ]
            , viewSelect Dropdown2Picked fs
            , h2 [] [ helloWorld |> selected1 |> selected2 |> monitor ]
            ]


viewSelect : (String -> msg) -> List String -> Html msg
viewSelect msg data =
    let
        optionize x =
            option [ value x ]
                [ text x ]
    in
        select
            [ onInput msg ]
            (List.map optionize data)


monitor : String -> Html Msg
monitor v =
    Html.text v
