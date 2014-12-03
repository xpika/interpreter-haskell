 {-# LANGUAGE NoMonomorphismRestriction #-}
 {-# LANGUAGE FlexibleInstances #-}
 {-# LANGUAGE IncoherentInstances #-}
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
--import Diagrams.Backend.Cairo
import Diagrams.Backend.SVG
--import Diagrams.Backend.Cairo.Internal
import qualified Graphics.Rendering.Chart.Renderable ( render, Renderable )
import System.Environment ( getArgs )

import qualified Diagrams.Prelude hiding (render)

import Plugins.DiagramStuff

import System.IO.Unsafe

chart vs = toRenderable layout
  where
    circleP = plot_lines_values .~ vs
            $ plot_lines_style .~ solidLine 1.0 (opaque blue) 
            $ def
    layout =  layout_plots .~ [toPlot circleP]
           $ def

myChart vs = let env = unsafePerformIO $ Graphics.Rendering.Chart.Backend.Diagrams.defaultEnv bitmapAlignmentFns 500 500
             in (Diagrams.Prelude.scale 0.01 (fst $ Graphics.Rendering.Chart.Backend.Diagrams.runBackendR env ((chart [  getVs vs ::[(Double,Double)]]))))
             
rChart vs = rdia  ( myChart vs)

             
class GetVs a where
    getVs :: a -> [(Double,Double)]

instance (Enum a, Real a, Fractional a) => GetVs (a -> a) where
    getVs f = zip [1..] (map realToFrac (map f [0,0.1..(2*realToFrac pi)]))
    
instance (Enum a, Real a, Fractional a,Real t0,Real t1) => GetVs ((a -> a),t0,t1) where
    getVs (f,s,e) = zip range (map realToFrac (map f range))
     where range = [s',(s'+abs(s'-e')/300.0)..e']
           s' = realToFrac s
           e' = realToFrac e

instance Real a => GetVs [a] where
    getVs xs = zip [1..] (map realToFrac xs)
    
instance (Real a ,Fractional a,Real b,Fractional b) => GetVs [(a,b)] where
    getVs xs = map (\(x,y)-> (realToFrac x , realToFrac y)) xs
    
instance GetVs [(Double,Double)] where
    getVs xs = xs
    
coordToReals (x,y) = (x',y')
  where x' = realToFrac x
        y' = realToFrac y

toPolar :: GetVs a => a -> [(Double,Double)]
toPolar a = map toPolar' (getVs a)

toPolar' :: (Real a , Real b) => (a,b) -> (Double,Double)
toPolar' (x,y) = (x'',y'')
    where x'' = y' * (cos x')
          y'' = y' * (sin x')
          x' = realToFrac x
          y' = realToFrac y
    
