
New =: 3 : 0
size =. y
dsize =. _1 + 2 * size
size ; 0 ; (size # 0) ; (dsize # 0) ; (dsize # 0)
)

Ok =: 4 : 0
'size row cols diags1 diags2' =. x
col =. y
-. (col{cols) +. ((col+row){diags1) +. (((row-col)+size-1){diags2)
)

Place =: 4 : 0
'size row cols diags1 diags2' =. x
col =. y
size ; (row+1) ; (1(<col)}cols) ; (1(<row+col)}diags1) ; (1(<(row-col)+size-1)}diags2)
)

Solve =: 3 : 0
board =. y
'size row cols diags1 diag2' =. board
if. row = size do. 1
else.
  place =. board & Place
  ok =. board ([: I. Ok) i.size
  placed =. place each ok
  solutions =. Solve each placed
  +/ > solutions
end.
)

