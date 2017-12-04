-module(first).
-export([
         double/1, mult/2, area/3, triple/1, square/1]).

mult(X, Y) ->
    X*Y.

double(X) ->
    2 * X.

triple(X) ->
    3 * X.

square(X) ->
    mult(X, X).


area(A,B,C) ->
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C)).
