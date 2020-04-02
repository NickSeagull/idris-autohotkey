module Drahko.Generate.Program where

import qualified Drahko.Generate.TopLevel as TopLevel
import qualified Drahko.Generate.Variable as Variable
import Drahko.Syntax
import qualified IRTS.Lang as Idris
import qualified Idris.Core.TT as IdrisCore
import Relude

generate :: MonadIO m => [(IdrisCore.Name, Idris.LDecl)] -> m Program
generate definitions = do
  functions <- traverse TopLevel.generate definitions
  let mainName = Variable.generate (IdrisCore.sMN 0 "runMain")
  let start = Call mainName []
  let statements = functions <> [start]
  pure $ Program statements
