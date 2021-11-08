module Main exposing (..)

import Css exposing (hex, px)
import Html.Styled exposing (Html, button, text)
import Html.Styled.Attributes exposing (class)
import Html.Styled.Events exposing (onClick)
import Slides exposing (..)
import Slides.Styles


main =
    Slides.app
        { slidesDefaultOptions
            | title = "Web development with Elm"
            , style =
                Slides.Styles.elmMinimalist
                    (hex "#fefefe")
                    (hex "#eee")
                    (px 16)
                    (hex "#333")
        }
        [ md
            """
            # Web development with Elm
            ## Impressions from a Typescript developer

            _Jan Tuomi 2021_
            """
        , md
            """
            ## Agenda
            1. Presentation about the cool parts of the Elm language & ecosystem (30min)

            2. Demos & interactive learning (30min)

            3. Learning Elm in an online IDE w/ 🍺 (60min)
            """
        , md
            """
            ![Elm logo](assets/elm-logo.png)

            * Designed for web UI development

            * Pure functional (no side-effects, yes managed effects)

            * Compiles to Javascript

            * Enforces a specific app architecture

            * Ships with useful tools (debugger, compiler, package manager...)

            * Aims to be simple to learn and delightful to use

            """
        , md
            """
            ## A snippet of Elm
            ```elm
            module Main exposing (..)

            import Css exposing (hex, px)
            import Slides exposing (..)
            import Slides.Styles


            main =
                Slides.app
                    { slidesDefaultOptions
                        | style =
                            Slides.Styles.elmMinimalist
                                (hex "#fefefe")
                                (hex "#ccc")
                                (px 16)
                                (hex "#333")
                    }
                    [ md
                        \"\"\"
                        # Web development with Elm
                        ## Impressions from a Typescript developer

                        _Jan Tuomi 2021_
                        \"\"\"
                    ]
            ```
            """
        , md
            """
            ## Elm architecture

            ![Elm architecture](assets/elm-arch-1.png)
            """
        , md
            """
            ## Similarities to Typescript & React + Redux

            * Immutable functional style in modern TS (filter, map, reduce)

            * Declarative & reactive, VDOM based

            * Elm architecture ≈ Redux state architecture

            * Similar typing experience:

              * TS intersection types ≈ Elm records

              * TS union types ≈ Elm custom types
            """
        , md
            """
            ### Immutable functional style in modern TS (filter, map, reduce)

            TS:

            ```typescript
            const sumOfNonNegativeCubes: Number = [1, -2, 3]
                .map(num => Math.pow(num, 3))
                .filter(num => num >= 0)
                .reduce((sum, val) => sum + val, 0)
            // Result: sumOfNonNegativeCubes == 28
            ```

            Elm:

            ```elm
            sumOfNonNegativeCubes : Int
            sumOfNonNegativeCubes =
                [ 1, -2, 3 ]
                    |> List.map (\\num -> num ^ 3)
                    |> List.filter (\\num -> num >= 0)
                    |> List.foldl (\\sum val -> sum + val) 0
            -- Result: sumOfNonNegativeCubes == 28
            ```
            """
        , md
            """
            ## Declarative & reactive, VDOM based

            TS:

            ```typescript
            const Button = ({ onClick, className }: Props) =>
                <button onClick={onClick} className={className}>Click me</button>;
            ```

            Elm:

            ```elm
            viewButton : Msg -> String -> Html Msg
            viewButton handleClick className =
                button [ onClick handleClick, class className ] [ text "Click me" ]
            ```
            """
        , md
            """
            ## Elm architecture ≈ Redux state architecture

            Redux + Redux Saga (left) vs Elm (right):

            ![Elm architecture](assets/redux-saga-elm-combo.png)

            Some differences:

            * Elm runtime performs effects, while in TS any user code can have side effects

            * All state in Elm must be managed this way, TS can have any state anywhere
            """
        , md
            """
            ## Similar typing experience: TS intersection types ≈ Elm records

            TS:

            ```typescript
            interface Store {
                user: {
                    id: string;
                };
                data: Thing[];
            }
            ```

            Elm:

            ```elm
            type alias Store =
                { user :
                    { id : String
                    }
                , data : List Thing
                }
            }
            ```
            """
        , md
            """
            ## TS union types ≈ Elm custom types

            TS:

            ```typescript
            type T = A | B | C | null;
            ```

            Elm:

            ```elm
            type Enum = A | B | C
            type T = Maybe Enum
            ```
            """
        , md
            """
            ## Cool things that I like about Elm
            """
        , md
            """
            ## Cool thing #1: _A really smart type system_

            Elm compiler can infer types very well (Hindley-Milner type system, ML languages)

            Example: an implementation for `List.flatten`:
            ```elm
            flatten listOfLists = List.foldl List.append [] listOfLists
            -- or alternatively, with partial application
            flatten = List.foldl List.append []
            ```

            Elm automatically infers the function type:

            ```elm
            flatten : List (List a) -> List a
            ```
            """
        , md
            """
            ## Cool thing #2: _No null, undefined or exceptions_

            * Possibly missing data is represented by monads like `Maybe` or `Result` and handled with pattern matching, pipelining

              * Remember kids: monads are just monoids in the category of endofunctors

            * "No exceptions" simplifies reasoning about code

              * Functions only use parameters as input and return values as output -> _pure functions_

              * Failures are represented as data, just like successes


            ```elm
            processData: Maybe Data -> String
            processData maybeData = maybeData
                |> Maybe.andThen transformData
                |> Maybe.andThen prettifyData
                |> \\md -> case md of
                    Just data -> Data.toString data
                    Nothing -> "No data"
            ```
            """
        , md
            """
            ## Cool thing #3: _Match expressions_

            ```elm
            viewItemList : RemoteData (List Item) -> Html Msg
            viewItemList itemsRemoteData =
                case itemsRemoteData of
                    NotRequested ->
                        button [ onClick GetItems ] [ text "Click to load items" ]

                    Loading ->
                        div [] [ text "Loading items..." ]

                    Received (Err err) ->
                        div [ class "error" ] [ "Failed to load items. Error: " ++ errToString err ]

                    Received (Ok items) ->
                        div [ class "itemList" ] List.map viewItem items
            ```

            * The match expression can go arbitrarily deep

            * Type system ensures that all possible cases are always considered
            """
        , md
            """
            ## Cool thing #4: _Fast development loop_

            * Compilation times are short

            * HMR works well

            * Compile errors are helpful: fix errors -> fix software

            * Good VS Code integration
            """
        , md
            """
            ## Cool thing #5: _Time traveling debugger_

            **[Demo](assets/Counter_debug_demo.html)**
            """
        , md
            """
            ## Cool thing #6: _Javascript interoperability_

            * If something is hard to do in Elm, you can do it outside of Elm, e.g.

              * components like date pickers (web components are supported directly)

              * specific 3rd party JS libraries (authentication)

              * LocalStorage or other browser storage

              * styling, especially with preprocessors

            * Safety: Javascript interop is typed, arbitrary calls not supported in either direction
            """
        , md
            """
            # Next up...

            1. Project demo: a barebones social media app called "Somebook"

              * [book.jan.systems](https://book.jan.systems)

            2. Kahoot quiz about this presentation

            3. Hack: Elm in an online IDE
            """
        , md
            """
            ## Elm exercises in ellie-app.com

            Two exercises that you can do on your own computer:

            * [List rendering](https://ellie-app.com/fN5YPKXNsq3a1) (easier)

            * [Data transform and pipelining](https://ellie-app.com/fN6PQmwvypYa1) (harder)

            Grab a 🍺. We'll go through example solutions at the end of the time slot (15min).
            """
        ]


flatten : List (List a) -> List a
flatten =
    List.foldl List.append []


nonNegativeCubes =
    [ 1, -2, 3 ]
        |> List.map (\num -> num ^ 3)
        |> List.filter (\num -> num >= 0)
        |> List.foldl (\sum val -> sum + val) 0


viewButton : Msg -> String -> Html Msg
viewButton handleClick className =
    button [ onClick handleClick, class className ] [ text "Click me" ]



-- viewItemList : RemoteData Item -> Html Msg
-- viewItemList itemsRemoteData =
--     case itemsRemoteData of
--         NotRequested ->
--             button [ onClick GetItems ] [ text "Click to load items" ]
--         Loading ->
--             div [] [ text "Loading items..." ]
--         Received (Err err) ->
--             div [ class "error" ] [ "Failed to load items. Error:" ++ errToString err ]
--         Received (Ok items) ->
--             div [ class "itemList" ] List.map viewItem items
-- processData: Maybe Data -> String
-- processData maybeData = maybeData
--     |> Maybe.andThen transformData
--     |> Maybe.andThen prettifyData
--     |> \md -> case md of
--         Just data -> Data.toString data
--         Nothing -> "No data"

