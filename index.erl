-module(index).
%-export([get_file_contents/1,show_file_contents/1]).
-compile(export_all).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)
  

% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.

get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    Rev = get_all_lines(File,[]),
lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                get_all_lines(File,[Strip|Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
    io:format("~s~n",[L]),
    show_file_contents(Ls);
 show_file_contents([]) ->
    ok.    
     
rem_punc([]) -> [];
rem_punc([X| Xs]) ->
    case lists:member(X, ",.\t\'\"-\\") of
        true -> rem_punc(Xs);
        false -> [X| rem_punc(Xs)]
    end.


pre_process_sentence(Sentence) -> string:tokens(string:to_lower(rem_punc(string:strip(Sentence))), " ").
pre_process_content([]) -> [];
pre_process_content([Sentence| Rest]) -> [pre_process_sentence(Sentence)| pre_process_content(Rest)].

process_sentences(Sentences) -> process_sentences(Sentences, 1, []).
process_sentences([], _Line, _Seen) -> [];
process_sentences(Sentences=[Words| Rest], Line, Seen) ->
    process_words(Words, Sentences, Line, Seen) ++ process_sentences(Rest, Line+1, Seen ++ Words).

process_words([], _Sentences, _CurrentLine, _Seen) -> [];
process_words([Word| Words], Sentences, CurrentLine, Seen) ->
    case lists:member(Word, Seen) of
        true -> process_words(Words, Sentences, CurrentLine, Seen);
        false -> [
                  {Word, count_word(Word, Sentences, CurrentLine, [])}| 
                  process_words(Words, Sentences, CurrentLine, [Word| Seen])
                 ]
    end.

count_word(_Word, [], _CurrentLine, Lines) -> format_lines(lists:sort(Lines));
count_word(Word, [Sentence| Rest], CurrentLine, Lines) -> 
    case lists:member(Word, Sentence) of
        true -> count_word(Word, Rest, CurrentLine+1, [CurrentLine| Lines]);
        false -> count_word(Word, Rest, CurrentLine+1, Lines)
    end.
        
format_lines([]) -> [];
format_lines([Line| Lines]) -> format_lines(Lines, {Line, Line}, Line).
format_lines([], Tuple, _Last) -> [Tuple];
format_lines([Line| Lines], {Start, End}, Last) ->
    case Line == Last + 1 of
        true -> format_lines(Lines, {Start, Line}, Line);
        false -> [{Start, End}| format_lines(Lines, {Line, Line}, Line)]
    end.


main() ->
    Content = get_file_contents("gettysburg-address.txt"),
    PreContent = pre_process_content(Content),
    process_sentences(PreContent).

