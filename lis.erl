-module(lis).
-compile(export_all).


median(L) -> 
    Length = length(L),
    case Length rem 2 > 0 of 
        true -> find_element(L, Length div 2);
        false -> (find_element(L, Length div 2) + find_element(L, (Length div 2) - 1)) / 2
    end.

find_element([X|_Rest], 0) -> X;
find_element([_X|Rest], I) -> find_element(Rest, I-1). 


mode(L) -> mode(lists:sort(L), none, 0, 0).
mode([X| T], X, Acc, Max) -> mode(T, X, Acc + 1, max(Max, Acc + 1));
mode([X| T], _X, _, Max) -> mode(T, X, 1, Max);
mode([], _X, _Acc, Max) -> Max.

take(I, L) -> lists:reverse(take(I, L, [])).
take(0, _L, Res) -> Res;
take(_I, [], Res) -> Res;
take(I, [H| T], Res) -> take(I-1, T, [H| Res]). 


count(I, L) -> count(I, L, 0).
count(_I, [], Acc) -> Acc;
count(I, [I| T], Acc) -> count(I, T, Acc + 1);
count(I, [_H| T], Acc) -> count(I, T, Acc).


nub(L) -> nub(lists:sort(L),none, []).
nub([],_Last, Nub) -> Nub;
nub([H| T], H, Nub) -> nub(T, H, Nub);
nub([H| T], _Last, Nub) -> nub(T, H, [H| Nub]).

palindrome(L) -> L == lists:reverse(L).
