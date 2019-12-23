module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { items : List Float
    , itemPriceTextboxValue : String
    , laborPriceTextboxValue : String
    , total : Float
    }


init : Model
init =
    { items = []
    , itemPriceTextboxValue = ""
    , laborPriceTextboxValue = ""
    , total = 0
    }


type Msg
    = ItemPriceTextboxChange String
    | AddButtonClicked
    | LaborPriceTextboxChange String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddButtonClicked ->
            { model
                | items = Maybe.withDefault -1 (String.toFloat model.itemPriceTextboxValue) :: model.items
                , itemPriceTextboxValue = ""
                , total = List.sum model.items + Maybe.withDefault -1 (String.toFloat model.itemPriceTextboxValue) * 1.07 + Maybe.withDefault -1000 (String.toFloat model.laborPriceTextboxValue)
            }

        ItemPriceTextboxChange str ->
            { model | itemPriceTextboxValue = str }

        LaborPriceTextboxChange str ->
            { model | laborPriceTextboxValue = str }


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text "Labor: "
            , input [ onInput LaborPriceTextboxChange, value model.laborPriceTextboxValue ] []
            ]
        , div []
            [ text "Item Price: "
            , input [ onInput ItemPriceTextboxChange, value model.itemPriceTextboxValue ] []
            ]
        , button [ onClick AddButtonClicked ] [ text "Add" ]
        , renderList model.items
        , text ("Total: " ++ String.fromFloat model.total)
        ]


renderList : List Float -> Html msg
renderList list =
    ul [] (List.map renderLiElement list)


renderLiElement : Float -> Html msg
renderLiElement myFloat =
    li [] [ text (String.fromFloat myFloat) ]
