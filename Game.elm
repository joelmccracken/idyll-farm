module Game where
import Html exposing (div, button, text, p)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp

main =
  StartApp.start { model = initialModel, view = view, update = update }


type alias GameInstance =
  { totalPlants : Int
  , money       : Int
  , day         : Int
  , actionsLeft : Int
  }

type alias Model =
  -- logic model
  {
    currentGame        : GameInstance
  -- view model
  , currentDisplay     : CurrentDisplay
  , greetingDismissed  : Bool
  }

type CurrentDisplay = FrontScreen
                    | GameWindow
                    | Settings

type GameState      = NotStarted
                    | InProgress

initialModel = { currentGame =
                   { totalPlants = 0
                   , money       = 100
                   , day         = 0
                   , actionsLeft = 10
                   }
               , currentDisplay = FrontScreen
               , greetingDismissed  = False
               }

type Action = Increment
            | Decrement
            | DismissGreeting
            | NewGame

update action model =
  case action of
    Increment       -> { model | totalPlants = model.totalPlants + 1 }
    Decrement       -> { model | totalPlants = model.totalPlants - 1 }
    DismissGreeting -> { model | greetingDismissed = True }
    NewGame         -> { model | currentDisplay = }

view address model =
  let viewMethod =
        case model.currentDisplay of
          FrontScreen -> viewFrontScreen
          GameWindow  -> viewGame
          Settings    -> viewSettings
  in
    viewMethod address model

viewFrontScreen address model =
  div []
        [ text "Idyll Farm"
        , button [ onClick address NewGame ] [ text "New Game" ]
        ]


viewSettings address model =
  text "not implemented yet!"

viewGame address model =
  div []
        [ greetingView address model
        , button [ onClick address Decrement ] [ text "-" ]
        , div [] [ text (toString model.totalPlants) ]
        , button [ onClick address Increment ] [ text "+" ]
        ]

greetingView address model =
  case model.greetingDismissed of
    True -> text ""
    False ->
      div []
          [ text """
                    Hi <yourname>!

                    You just inherited some land.

                    Start growing!
                    """
          , button [ onClick address DismissGreeting ] [ text "dismiss" ]
          ]
