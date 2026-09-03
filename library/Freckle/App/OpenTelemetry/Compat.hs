{-# LANGUAGE CPP #-}

-- | Stable signatures over parts of @hs-opentelemetry-sdk@'s API that
-- differ by version
--
-- Each function here presents one signature regardless of which
-- @hs-opentelemetry-sdk@ version is in the build plan.
module Freckle.App.OpenTelemetry.Compat
  ( shutdownTracerProvider
  , getTracerProviderPropagators
  ) where

#if MIN_VERSION_hs_opentelemetry_sdk(1,0,0)
import Prelude
#else
import Prelude ()
#endif

import Control.Monad.IO.Class (MonadIO)
import Network.HTTP.Types.Header (Header)
import OpenTelemetry.Context (Context)
import OpenTelemetry.Propagator (Propagator (..))
import OpenTelemetry.Trace.Core (TracerProvider)
import OpenTelemetry.Trace.Core qualified as Trace
#if MIN_VERSION_hs_opentelemetry_sdk(1,0,0)
import Data.CaseInsensitive qualified as CI
import Data.Functor (void)
import Data.Text.Encoding qualified as T
import OpenTelemetry.Propagator qualified as Propagator
#endif

-- | Shut down a 'TracerProvider'
shutdownTracerProvider :: MonadIO m => TracerProvider -> m ()
#if MIN_VERSION_hs_opentelemetry_sdk(1,0,0)
shutdownTracerProvider tracerProvider =
  void $ Trace.shutdownTracerProvider tracerProvider Nothing
#else
shutdownTracerProvider = Trace.shutdownTracerProvider
#endif

-- | The 'Propagator' registered on a 'TracerProvider', carrying HTTP headers
getTracerProviderPropagators
  :: TracerProvider -> Propagator Context [Header] [Header]
#if MIN_VERSION_hs_opentelemetry_sdk(1,0,0)
getTracerProviderPropagators tracerProvider =
  Propagator fields extractHeaders injectHeaders
 where
  Propagator fields extract inject = Trace.getTracerProviderPropagators tracerProvider

  extractHeaders headers = extract (headersToTextMap headers)
  injectHeaders ctx headers = textMapToHeaders <$> inject ctx (headersToTextMap headers)

  headersToTextMap = Propagator.textMapFromList . map headerToPair
  textMapToHeaders = map pairToHeader . Propagator.textMapToList

  headerToPair (name, value) = (T.decodeUtf8 (CI.original name), T.decodeUtf8 value)
  pairToHeader (k, v) = (CI.mk (T.encodeUtf8 k), T.encodeUtf8 v)
#else
getTracerProviderPropagators = Trace.getTracerProviderPropagators
#endif
