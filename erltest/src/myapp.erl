-module(myapp).
-behavior(application).
-export([start/2, stop/1]).

start(_Type, Args) ->
	supervisor:start_link({local, mysuper}, mysuper, Args).

stop(_State) ->
	[].

