-module(tests).
-import(bs00, [to_object/1]).
-import(bs01, [first_word/1]).
-import(bs02, [words/1]).
-import(bs03, [split/2]).
-import(bs04, [decode/2]).
-include_lib("eunit/include/eunit.hrl").


%bs00 module test:
to_object_test_() -> [
    ?_assertEqual(to_object(<<"5">>), 5),
    ?_assertEqual(to_object(<<"test">>), test),
    ?_assertEqual(to_object(<<"Qwerty">>), {error, not_atom_or_number}),
    ?_assertException(error, function_clause, to_object([])),
    ?_assertException(error, function_clause, to_object({})), 
    ?_assertException(error, function_clause, to_object(atom)),
    ?_assertException(error, function_clause, to_object(12))
].

%bs01 module test:
first_word_test_() -> [
    ?_assertEqual(first_word(<<"          text">>), <<"text">>),
    ?_assertEqual(first_word(<<"qwert ">>), <<"qwert">>),
    ?_assertEqual(first_word(<<" test ">>), <<"test">>),
    ?_assertEqual(first_word(<<"      ">>), {error, not_content_to_show}),
    ?_assertEqual(first_word(<<"">>), {error, not_content_to_show}),
    ?_assertException(error, function_clause, first_word([])),
    ?_assertException(error, function_clause, first_word({})), 
    ?_assertException(error, function_clause, first_word(atom)),
    ?_assertException(error, function_clause, first_word(12))
].

%bs02 module test:
words_test_() -> [
    ?_assertEqual(words(<<"  hello  world  ">>), [<<"hello">>, <<"world">>]),
    ?_assertEqual(words(<<"qwert">>), [<<"qwert">>]),
    ?_assertEqual(words(<<"simple text">>), [<<"simple">>, <<"text">>]),
    ?_assertEqual(words(<<"      ">>), []),
    ?_assertException(error, function_clause, words([])),
    ?_assertException(error, function_clause, words({})), 
    ?_assertException(error, function_clause, words(atom)),
    ?_assertException(error, function_clause, words(12))
].

%bs03 module test:
split_test_() -> [
    ?_assertEqual(split(<<"brave??new??world">>, "??"), [<<"brave">>, <<"new">>, <<"world">>]),
    ?_assertEqual(split(<<"??simple ??text ??test??">>, "??"), [<<>>, <<"simple ">>, <<"text ">>, <<"test">>]),
    ?_assertEqual(split(<<"??">>, "??"), [<<>>]),
    ?_assertEqual(split(<<"">>, "??"), []),
    ?_assertEqual(split([], "-:-"), {error, not_a_binary}),
    ?_assertEqual(split({}, ":"), {error, not_a_binary}),
    ?_assertEqual(split(atom, "--"), {error, not_a_binary}),
    ?_assertEqual(split(125, "//"), {error, not_a_binary})
].

%bs04 module test:
decode_test_() -> [
    ?_assertEqual(decode(<<"{}">>, proplist), []),
    ?_assertEqual(decode(<<"{'simple' : 'test'}">>, proplist), [{<<"simple">>, <<"test">>}]),
    ?_assertEqual(decode(<<"{'simple' : 'test', 'all': rights}">>, proplist), [{<<"simple">>, <<"test">>}, {<<"all">>, rights}]),
    ?_assertEqual(decode(<<"{'simple' : 'test', 'name': ['Alex', 'Alice']}">>, proplist), [{<<"simple">>, <<"test">>}, {<<"name">>, [<<"Alex">>, <<"Alice">>]}]),
    ?_assertEqual(decode(<<"{'simple' : 'test', 'name': [{'new': 'qwerty'}, {'how': 'are'}]}">>, proplist), [{<<"simple">>,<<"test">>},{<<"name">>,[[{<<"new">>,<<"qwerty">>}],[{<<"how">>,<<"are">>}]]}]),
    ?_assertEqual(decode(<<"{'simple' : 'test', 'name': [{'new': ['special', 'needs']}, {'how': 'are'}]}">>, proplist),
    [{<<"simple">>,<<"test">>},{<<"name">>,[[{<<"new">>,[<<"special">>,<<"needs">>]}],[{<<"how">>,<<"are">>}]]}]),
    ?_assertException(error, function_clause, decode([], proplist)),
    ?_assertException(error, function_clause, decode({}, proplist)), 
    ?_assertException(error, function_clause, decode(atom, proplist)),
    ?_assertException(error, function_clause, decode(12, proplist))
].  
