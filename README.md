# erltest

Erlang example application. I created this for myself to understand how an Erlang application goes without Elixir's Mix doing everything for you.

## Directory structure

```
erltest/
  Your directory's application. If you add its parent directory to ERL_LIBS,
  Erlang will be able to find it. This could also be called Name-VSN if we
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
./build-erl
```

This compiles erltest/ebin/*.erl to erltest/ebin/*.beam.

To create our boot file, we run build-boot:

```
ERL_LIBS=. ./build-boot
```

The creates erltest.boot, a blob that describes how to start your release. We need `ERL_LIBS=.` because Erlang needs to be able to find the erltest application we specified in erltest.rel, and the current directory is not its load path by default.

To finally bring up our system, we run erl:

```
ERL_LIBS=. erl -boot erltest
```

You should see an "Erlang/OTP..." and an Eshell prompt, with "myserver init" mixed in somewhere. This time we need `ERL_LIBS=.` so Erlang can find our .beam files. `-boot erltest` tells Erlang to execute erltest.boot, which essentially starts the kernel, stdlib, and erltest applications.
