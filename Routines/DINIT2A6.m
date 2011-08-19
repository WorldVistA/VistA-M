DINIT2A6 ;SFISC/MKO-KEY AND INDEX FILES ;10:50 AM  30 Mar 1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2AA
Q Q
 ;;^DD(.312,1,21,0)
 ;;=^^4^4^2980911^
 ;;^DD(.312,1,21,1,0)
 ;;=Answer will determine the order in which this field appears within the
 ;;^DD(.312,1,21,2,0)
 ;;=key. This affects the order of prompts, subscripts, and returned values
 ;;^DD(.312,1,21,3,0)
 ;;=throughout FileMan. The first field of every key should receive sequence
 ;;^DD(.312,1,21,4,0)
 ;;=number 1, the second 2, and so on.
 ;;^DD(.312,1,"DT")
 ;;=2980611
