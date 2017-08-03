%%%-------------------------------------------------------------------
%%% @author  <>
%%% @copyright (C) 2016, 
%%% @doc
%%% write 2 functions that:
%%% 1. will convert an integer number to BCD binary
%%% 2. vice-versa
%%% @end
%%% Created : 11 Feb 2016 by  <>
%%%-------------------------------------------------------------------
-module(codecs).
-export([int_2_bcd/1,
	 bcd_2_int/1,
	 int_to_bcd/1,
	 bcd_to_int/1]).

int_2_bcd(Integer) when is_integer(Integer) ->
    Digits = integer_to_list(Integer),
    << <<(X-$0):4>> || X <- Digits >>.
%    << <<X:4>> || X <- Digits >>.

%% Let's take an integer: 95740. integer_to_list will
%% create a list of ASCII values: [$9, $5, $7, $4, $0],
%% or [57, 53, 55, 52, 48]. Next step is to take each
%% element from the list and write it on 4 bits in some
%% new bitstring. First, 48 must be substracted from
%% every element (equal to $0) so we get [9, 5, 7, 4, 0]
%% as input. This is not really necessary, as e.g.
%% 57 = 0011 1001, so if the 4 most significant bits will
%% be cut off due to bitstring construction (only 4 bits are
%% allowed), it is the same as to substract 48 from the number
%% ((0011) 1001 -> 1001)
%% (   57(-48)  ->    9)
%% That's why the commented code above works exactly the same
%% without errors.

bcd_2_int(BCD) when is_binary(BCD) ->
    Digits = [D+$0 || <<D:4>> <= BCD],
    list_to_integer(Digits).

%% Alternative solution using recursion:
int_to_bcd(Integer) when is_integer(Integer) ->
    Digits = integer_to_list(Integer),
    int_to_bcd(Digits);
int_to_bcd(List) when is_list(List) ->
    int_to_bcd(List, <<>>).
int_to_bcd([], Bin) -> reverse(Bin);
int_to_bcd([H|T], Bin) ->
    int_to_bcd(T, <<(H-$0):4, Bin/bits>>).

bcd_to_int(BCD) when is_bitstring(BCD) ->
    bcd_to_int(BCD, []).

bcd_to_int(<<>>, Digits) ->
    list_to_integer(lists:reverse(Digits));
bcd_to_int(<<D:4, Rest/bits>>, Acc) ->
    bcd_to_int(Rest, [D+$0|Acc]).

reverse(Bin) ->
    reverse(Bin, <<>>).
reverse(<<>>, Acc) ->
    Acc;
reverse(<<X:4,Rest/bits>>, Acc) ->
    reverse(Rest, <<X:4, Acc/bits>>).
