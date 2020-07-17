module Storybook exposing (main)

import Json.Encode as JE
import Pages.Index as Index
import Realm.Storybook as RSB exposing (Story)


main =
    RSB.app { stories = stories, title = "Realm-Starter" }


stories : List ( String, List Story )
stories =
    [ ( "Index"
      , [ index "todo-1"
            "1 ToDo"
            { list =
                [ { value = "My first Todo", status = False }
                , { value = "My second Todo", status = True }
                ]
            }
        ]
      )
    ]


index : String -> String -> Index.Config -> Story
index id title c =
    { id = id
    , title = title
    , pageTitle = title
    , elmId = "Pages.Index"
    , config = Index.configE c
    }
