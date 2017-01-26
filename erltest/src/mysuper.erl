-module(mysuper).
-behavior(supervisor).
-export([init/1]).

init(_Args) ->
    SupFlags = #{},
    Args = [{local, myserver}, myserver, [], []],
    ChildSpecs = [
        #{id => myserver, start => {gen_server, start_link, Args}}
    ],
    {ok, {SupFlags, ChildSpecs}}.
