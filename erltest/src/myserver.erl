-module(myserver).
-behavior(gen_server).
-export([code_change/3,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    init/1,
    terminate/2]).

code_change(_OldVsn, _State, _Extra) ->
    {error, "NYI"}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Request, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

init(_Args) ->
    process_flag(trap_exit, true),
    io:format("myserver init~n"),
    {ok, []}.

terminate(_Reason, _State) ->
    io:format("myserver terminate~n"),
    [].
