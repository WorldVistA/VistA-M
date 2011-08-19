DINIT012 ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^DD(.85,10.3,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.3,9)
 ;;=@
 ;;^DD(.85,10.3,21,0)
 ;;=^^5^5^2941121^^
 ;;^DD(.85,10.3,21,1,0)
 ;;=MUMPS code used to transfer a number in Y to its cardinal equivalent in
 ;;^DD(.85,10.3,21,2,0)
 ;;=this language. The code should set Y to the cardinal equivalent without
 ;;^DD(.85,10.3,21,3,0)
 ;;=altering any other variables in the environment.  Ex. in English:
 ;;^DD(.85,10.3,21,4,0)
 ;;=       Y=2000     becomes         Y=2,000
 ;;^DD(.85,10.3,21,5,0)
 ;;=       Y=1234567  becomes         Y=1,234,567
 ;;^DD(.85,10.3,"DT")
 ;;=2940308
 ;;^DD(.85,10.4,0)
 ;;=UPPERCASE CONVERSION^K^^UC;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.4,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.4,9)
 ;;=@
 ;;^DD(.85,10.4,21,0)
 ;;=^^4^4^2941121^
 ;;^DD(.85,10.4,21,1,0)
 ;;=MUMPS code used to convert text in Y to its upper-case equivalent in
 ;;^DD(.85,10.4,21,2,0)
 ;;=this language. The code should set Y to the external format without
 ;;^DD(.85,10.4,21,3,0)
 ;;=altering any other variables in the environment.  In English, changes
 ;;^DD(.85,10.4,21,4,0)
 ;;=   abCdeF      to: ABCDEF
 ;;^DD(.85,10.4,"DT")
 ;;=2940308
 ;;^DD(.85,10.5,0)
 ;;=LOWERCASE CONVERSION^K^^LC;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,10.5,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,10.5,9)
 ;;=@
 ;;^DD(.85,10.5,21,0)
 ;;=^^4^4^2941121^
 ;;^DD(.85,10.5,21,1,0)
 ;;=MUMPS code used to convert text in Y to its lower-case equivalent in  
 ;;^DD(.85,10.5,21,2,0)
 ;;=this language. The code should set Y to the external format without
 ;;^DD(.85,10.5,21,3,0)
 ;;=altering any other variables in the environment.  In English, changes:
 ;;^DD(.85,10.5,21,4,0)
 ;;=    ABcdEFgHij         to:  abcdefghij
 ;;^DD(.85,10.5,"DT")
 ;;=2940308
 ;;^DD(.85,20.2,0)
 ;;=DATE INPUT^K^^20.2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.85,20.2,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.85,20.2,9)
 ;;=@
 ;;^DD(.85,20.2,"DT")
 ;;=2940714
