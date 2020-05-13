module Archive
  ( archive
  ) where

import Data.Monoid (mappend)
import Hakyll
import Lib

archive :: Rules ()
archive = create [archiveIdentifier] $ do
    route idRoute
    compile $ do
        posts <- recentFirst =<< loadAll postPattern
        let archiveCtx =
                listField "posts" postCtx (return posts) `mappend`
                constField "title" "Archives"            `mappend`
                defaultContext

        makeItem ""
            >>= loadAndApplyTemplate archiveTemplate archiveCtx
            >>= loadAndApplyTemplate defaultTemplate archiveCtx
            >>= relativizeUrls
