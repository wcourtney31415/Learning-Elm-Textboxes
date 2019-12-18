module Main exposing (..)

import Browser
import Html exposing (Html, div, input)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { username : String, password : String }


init : Model
init =
    { username = "john@company.com", password = "B35tP@55W0RD" }


type Msg
    = UsernameTextboxChange String
    | PasswordTextboxChange String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UsernameTextboxChange str ->
            { model | username = str }

        PasswordTextboxChange str ->
            { model | password = str }


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput UsernameTextboxChange, value model.username ] []
        , input [ onInput PasswordTextboxChange, value model.password ] []
        ]
