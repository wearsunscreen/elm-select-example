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
            functions
                |> List.map Tuple.first

        selectedFunction1 =
            functions
                |> Dict.fromList
                |> Dict.get (Maybe.withDefault "" model.function1)
                |> Maybe.withDefault (identity)

        selectedFunction2 =
            functions
                |> Dict.fromList
                |> Dict.get (Maybe.withDefault "" model.function2)
                |> Maybe.withDefault (identity)
    in
        div [ style mainStyle ]
            [ h2 [] [ text helloWorld ]
            , viewSelect Device1Picked fs
            , h2 [] [ helloWorld |> selectedFunction1 |> monitor ]
            , viewSelect Device2Picked fs
            , h2 [] [ helloWorld |> selectedFunction1 |> selectedFunction2 |> monitor ]
            ]


viewSelect : (String -> msg) -> List String -> Html msg
viewSelect msg data =
    let
        optionize x =
            option [ value x ]
                [ text x ]
    in
        Debug.log "view"
            select
            [ onInput msg ]
            (List.map optionize data)


monitor : String -> Html Msg
monitor v =
    Html.text v
