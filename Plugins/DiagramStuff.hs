 {-# LANGUAGE NoMonomorphismRestriction #-}
module Plugins.DiagramStuff (
     module Diagrams.Backend.SVG 
    ,module Diagrams.Core 
    ,module Diagrams.Prelude
    ,module Text.Blaze.Svg.Renderer.String
    ,rdia
) where

import Diagrams.Backend.SVG 
import Diagrams.Core 
import Diagrams.Prelude
import Text.Blaze.Svg.Renderer.String
import Plugins.LiteralString

rdia dia = str $ renderSvg $ renderDia SVG (SVGOptions Absolute Nothing) ((dia # scale 100 # lw 1) :: Diagram SVG R2)