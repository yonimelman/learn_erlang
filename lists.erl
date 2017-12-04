-module(lis).
-compile(export_all).


median(L) -> 
    Length = length(L),
    case Length rem 2 > 0 of 
        true -> find_element(L, Length div 2);
        false -> (find_element(L, Length div 2) + find_element(L, (Length div 2) + 1)) / 2
    end.

find_element([X|_Rest], 1) -> X;
find_element([_X|Rest], I) -> find_element(Rest, I-1). 
