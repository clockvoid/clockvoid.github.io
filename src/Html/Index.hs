{-# LANGUAGE OverloadedStrings #-}

module Html.Index
  ( indexPage
  ) where

import Data.Text
import Lucid

imgClockvoid :: Text
imgClockvoid = "https://i.imgur.com/rLs5sRT.png"

indexPage :: (FilePath, Html ())
indexPage = (indexPath, indexHtml)

indexPath :: FilePath
indexPath = "index.html"

indexHtml :: Html ()
indexHtml = do
  doctype_
  html_ $ do
    head_ $ do
      title_ "clockvoid - $title$"
      meta_ [charset_ "utf-8"]
      meta_ [httpEquiv_ "x-ua-compatible", content_ "ie=edge"]
      meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1"]
      link_ [rel_ "stylesheet", href_ "/css/mystyles.css"]
    body_ $
      section_ [class_ "hero is-primary is-fullheight"] $
        div_ [class_ "hero-body"] $
          div_ [class_ "container has-text-centered"] $ do
            figure_ [class_ "image is-128x128", style_ "margin: 0 auto 1.5rem auto"] $
              img_ [class_ "is-rounded", src_ imgClockvoid]
            h1_ [class_ "title is-size-1-desktop is-size-2-touch"] "clockvoid"
            nav_ [class_ "breadcrumb is-centered has-bullet-separator"] $
              ul_ $ do
                li_ $ a_ [class_ "navbar-item"] "About"
                li_ $ a_ [class_ "navbar-item"] "Blog"
                li_ $ a_ [class_ "navbar-item"] "Works"

