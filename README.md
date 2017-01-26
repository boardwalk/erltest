# erltest

Erlang example application. I created this for myself to understand how an Erlang application goes together without Elixir's Mix doing everything for me.

## Directory structure

```
erltest/
  Our application's directory. This could also be called Name-VSN if we
  cared about versioning.

erltest/src/
  All of our Erlang source code.

erltest/src/myapp.erl
  Implements the application behavior. Starts a supervisor named 'mysuper'.

erltest/src/mysuper.erl
  Implements the supervisor behavior. Starts a child named 'myserver'.

erltest/src/myserver.erl
  Implements the gen_server behavior. Doesn't do anything except print on startup.

erltest/ebin/
  Compiled source code as .beam files and our .app file.

erltest/ebin/erltest.app
  Describes our application. The 'applications' key specifies what applications
  must be started before this one. The optional 'mod' key specifies what module
  implements the 'application' behavior to start and stop it.

erltest.rel
  Describes our release, including all of the applications it contains.
```

## Usage

To compile our source code, we run build-erl:

```
$ ./build-erl
```

This compiles `erltest/src/*.erl` to `erltest/ebin/*.beam`.

To create our boot file, we run build-boot:

```
$ ERL_LIBS=. ./build-boot
```

The creates erltest.script, a script that describes how to start our release as well as erltest.boot, a binary version of the script. We need `ERL_LIBS=.` because Erlang needs to be able to find the erltest.app file of the erltest application we referenced in erltest.rel, and the current directory is not in its load path by default.

To finally bring up our system, we run erl:

```
$ ERL_LIBS=. erl -boot erltest
Erlang/OTP 19 [erts-8.6] [source] [128-bit] [smp:32:32] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

myserver init
Eshell V8.6  (abort with ^G)
```

This time we need `ERL_LIBS=.` so Erlang can find our .beam files. `-boot erltest` tells Erlang to execute erltest.boot, which essentially starts the kernel, stdlib, and erltest applications.

Now we stop our application:

```
> application:stop(erltest).
myserver terminate
ok
=INFO REPORT==== 25-Jan-2027::20:47:00 ===
    application: erltest
    exited: stopped
    type: permanent
```

And restart it if we want:

```
> application:start(erltest).
myserver init
ok
```

We can see our supervisor and server running with i:

```
> i().
Pid                   Initial Call                          Heap     Reds Msgs
Registered            Current Function                     Stack              
...
<0.67.0>              supervisor:mysuper/1                   233       96    0
mysuper               gen_server:loop/6                        9              
<0.68.0>              myserver:init/1                        233       34    0
myserver              gen_server:loop/6                        9              
...
```

You can talk to the server too:

```
> gen_server:call(myserver, "jabba").
"hello jabba from myserver"
```

That's it! Not too bad.
