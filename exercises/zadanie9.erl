-module(zadanie9) .

-compile(export_all) .

intersection(L1,L2) -> [ X || X <- L1, lists:member(X , L2)] .