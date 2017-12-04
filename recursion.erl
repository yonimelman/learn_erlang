-module(recursion).
-compile(export_all).


fib(1) -> 1;
fib(0) -> 0;
fib(N) -> fib(N-1) + fib(N-2).


pieces(1) -> 2;
pieces(N) -> pieces(N-1) + N.
