-module(mysuper).
-behavior(supervisor).
-export([init/1]).

init(_Args) ->
	SupFlags = #{},
	ChildSpecs = [
		#{id => myserver, start => {gen_server, start_link, [myserver, [], []]}}
	],
	{ok, {SupFlags, ChildSpecs}}.
