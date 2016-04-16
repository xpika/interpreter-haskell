FROM mchakravarty/ghc-7.10.2
MAINTAINER Alan Hawkins

RUN apt-get update
RUN apt-get install -y git
RUN git clone https://github.com/xpika/interpreter-haskell.git
RUN cabal update
RUN cd interpreter-haskell && cabal install
ADD . .
RUN cabal install
ENTRYPOINT /root/.cabal/bin/interpreter-haskell
#ENTRYPOINT /bin/bash
