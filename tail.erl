-module(tail).
-compile(export_all).

fib(0) -> 0;
fib(1) -> 1;
fib(N) when N > 0-> fib(N, 0, 1).

fib(2, L1, L2) -> L1 + L2;
fib(N, L1, L2) -> fib(N-1, L1+L2, L1).


perfect(N) -> perfect(N, 1, 0).

perfect(N, N, N) -> true;
perfect(N, N, _) -> false;
perfect(N, Div, T) when N rem Div > 0 -> perfect(N, Div + 1, T);
perfect(N, Div, T) -> perfect(N, Div + 1, T + Div).
