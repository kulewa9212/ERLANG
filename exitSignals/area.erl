-module(area).

-export([area/1,b_not/1,b_and/2,b_nand/2,sum/1,sum/2]).

area({square, Side}) ->
Side * Side ;
area({circle, Radius}) ->
math:pi() * Radius * Radius;
area({triangle, A, B, C}) ->
S = (A + B + C)/2,
math:sqrt(S*(S-A)*(S-B)*(S-C));
area(_Other) ->
{error, invalid_object}.

b_not(true) -> false;
b_not(false) -> true;
b_not(_) -> {error,invalid_object}.

b_and(true,true) -> true;
b_and(true,false) -> false;
b_and(false,true) -> false;
b_and(false,false) -> false;
b_and(_,_) -> {error,invalid_object}.

b_nand(true,true) -> false;
b_nand(true,false) -> true;
b_nand(false,true) -> true;
b_nand(false,false) -> true;
b_nand(_,_) -> {error,invalid_object}.


sum(0) -> 0;
sum(N) -> N+sum(N-1).


sum(N,N) -> N ;
sum(0,N) -> N;
sum(N,0) -> N;
sum(M,N) when (M>N) -> M+sum(M-1,N);
sum(M,N) when (M<N) -> N+sum(M,N-1) .





























