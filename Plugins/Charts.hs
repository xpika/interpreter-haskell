 {-# LANGUAGE NoMonomorphismRestriction #-}
module Plugins.Charts where

import Graphics.Rendering.Chart
import qualified Graphics.Rendering.Chart.Backend.Diagrams 
import Data.Colour
import Data.Colour.Names
import Control.Lens
import Data.Default.Class
import System.Environment(getArgs)

import Diagrams.Core.Types ( renderDia )
import Diagrams.TwoD ( SizeSpec2D(..) )
import Diagrams.Backend.Cairo
import Diagrams.Backend.SVG
import Diagrams.Backend.Cairo.Internal
import qualified Graphics.Rendering.Chart.Renderable ( render, Renderable )
import System.Environment ( getArgs )

import qualified Diagrams.Prelude hiding (render)

import Plugins.DiagramStuff

import System.IO.Unsafe

chart = toRenderable layout
  where
    circle = [ (r a * sin (a*dr),r a * cos (a*dr)) | a <- [0,0.5..360::Double] ]
      where
        dr = 2 * pi / 360
        r a = 0.8 * cos (a * 20 * pi /360)

    circleP = plot_lines_values .~ [circle]
            $ plot_lines_style .~ solidLine 1.0 (opaque blue) 
            $ def

    layout = layout_title .~ "Parametric Plot"
           $ layout_plots .~ [toPlot circleP]
           $ def
           

cr = Graphics.Rendering.Chart.Renderable.render chart (500,500)

myChart = let env = unsafePerformIO $  Graphics.Rendering.Chart.Backend.Diagrams.defaultEnv bitmapAlignmentFns 500 500
          in (Diagrams.Prelude.scale 0.01 (fst $ Graphics.Rendering.Chart.Backend.Diagrams.runBackendR env chart))
