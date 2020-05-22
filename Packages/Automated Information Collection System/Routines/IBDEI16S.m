IBDEI16S ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19063,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,19063,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,19063,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,19064,0)
 ;;=T46.5X6A^^91^977^9
 ;;^UTILITY(U,$J,358.3,19064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19064,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,19064,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,19064,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,19065,0)
 ;;=T46.5X6D^^91^977^10
 ;;^UTILITY(U,$J,358.3,19065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19065,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,19065,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,19065,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,19066,0)
 ;;=T46.5X6S^^91^977^11
 ;;^UTILITY(U,$J,358.3,19066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19066,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,19066,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,19066,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,19067,0)
 ;;=T43.206A^^91^977^6
 ;;^UTILITY(U,$J,358.3,19067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19067,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
 ;;^UTILITY(U,$J,358.3,19067,1,4,0)
 ;;=4^T43.206A
 ;;^UTILITY(U,$J,358.3,19067,2)
 ;;=^5050543
 ;;^UTILITY(U,$J,358.3,19068,0)
 ;;=T43.206S^^91^977^7
 ;;^UTILITY(U,$J,358.3,19068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19068,1,3,0)
 ;;=3^Underdosing of Antidepressants,Sequela
 ;;^UTILITY(U,$J,358.3,19068,1,4,0)
 ;;=4^T43.206S
 ;;^UTILITY(U,$J,358.3,19068,2)
 ;;=^5050545
 ;;^UTILITY(U,$J,358.3,19069,0)
 ;;=T43.206D^^91^977^8
 ;;^UTILITY(U,$J,358.3,19069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19069,1,3,0)
 ;;=3^Underdosing of Antidepressants,Subs Encntr
 ;;^UTILITY(U,$J,358.3,19069,1,4,0)
 ;;=4^T43.206D
 ;;^UTILITY(U,$J,358.3,19069,2)
 ;;=^5050544
 ;;^UTILITY(U,$J,358.3,19070,0)
 ;;=T43.506A^^91^977^12
 ;;^UTILITY(U,$J,358.3,19070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19070,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Init Encntr
 ;;^UTILITY(U,$J,358.3,19070,1,4,0)
 ;;=4^T43.506A
 ;;^UTILITY(U,$J,358.3,19070,2)
 ;;=^5050651
 ;;^UTILITY(U,$J,358.3,19071,0)
 ;;=T43.506S^^91^977^13
 ;;^UTILITY(U,$J,358.3,19071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19071,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Sequela
 ;;^UTILITY(U,$J,358.3,19071,1,4,0)
 ;;=4^T43.506S
 ;;^UTILITY(U,$J,358.3,19071,2)
 ;;=^5050653
 ;;^UTILITY(U,$J,358.3,19072,0)
 ;;=T43.506D^^91^977^14
 ;;^UTILITY(U,$J,358.3,19072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19072,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Subs Encntr
 ;;^UTILITY(U,$J,358.3,19072,1,4,0)
 ;;=4^T43.506D
 ;;^UTILITY(U,$J,358.3,19072,2)
 ;;=^5050652
 ;;^UTILITY(U,$J,358.3,19073,0)
 ;;=97760^^92^978^1^^^^1
 ;;^UTILITY(U,$J,358.3,19073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19073,1,2,0)
 ;;=2^Orthotic Mgmt and Training
 ;;^UTILITY(U,$J,358.3,19073,1,3,0)
 ;;=3^97760
 ;;^UTILITY(U,$J,358.3,19074,0)
 ;;=97761^^92^978^2^^^^1
 ;;^UTILITY(U,$J,358.3,19074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19074,1,2,0)
 ;;=2^Prosthetic Training
 ;;^UTILITY(U,$J,358.3,19074,1,3,0)
 ;;=3^97761
 ;;^UTILITY(U,$J,358.3,19075,0)
 ;;=97763^^92^978^3^^^^1
