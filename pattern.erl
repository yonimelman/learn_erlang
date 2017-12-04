-module(pattern).
-compile(export_all).

maxThree(X, Y, Z) ->
    max(X, max(Y, Z)).

howManyEqual(X, X, X) -> 3;
howManyEqual(X, X, _) -> 2;
howManyEqual(X, _, X) -> 2;
howManyEqual(_, X, X) -> 2;
howManyEqual(_, _, _) -> 0.


test1() ->
    howManyEqual(34, 25, 36) == 0,
    howManyEqual(1, 1, 2) == 2,
    howManyEqual(2, 1, 2) == 2,
    howManyEqual(1, 1, 1) == 3.
