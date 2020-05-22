IBDEI1PS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27388,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,27388,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,27389,0)
 ;;=T38.3X6S^^110^1325^4
 ;;^UTILITY(U,$J,358.3,27389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27389,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,27389,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,27389,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,27390,0)
 ;;=T38.3X6D^^110^1325^5
 ;;^UTILITY(U,$J,358.3,27390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27390,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,27390,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,27390,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,27391,0)
 ;;=T46.5X6A^^110^1325^9
 ;;^UTILITY(U,$J,358.3,27391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27391,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,27391,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,27391,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,27392,0)
 ;;=T46.5X6D^^110^1325^10
 ;;^UTILITY(U,$J,358.3,27392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27392,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27392,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,27392,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,27393,0)
 ;;=T46.5X6S^^110^1325^11
 ;;^UTILITY(U,$J,358.3,27393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27393,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,27393,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,27393,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,27394,0)
 ;;=T43.206A^^110^1325^6
 ;;^UTILITY(U,$J,358.3,27394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27394,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
 ;;^UTILITY(U,$J,358.3,27394,1,4,0)
 ;;=4^T43.206A
 ;;^UTILITY(U,$J,358.3,27394,2)
 ;;=^5050543
 ;;^UTILITY(U,$J,358.3,27395,0)
 ;;=T43.206S^^110^1325^7
 ;;^UTILITY(U,$J,358.3,27395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27395,1,3,0)
 ;;=3^Underdosing of Antidepressants,Sequela
 ;;^UTILITY(U,$J,358.3,27395,1,4,0)
 ;;=4^T43.206S
 ;;^UTILITY(U,$J,358.3,27395,2)
 ;;=^5050545
 ;;^UTILITY(U,$J,358.3,27396,0)
 ;;=T43.206D^^110^1325^8
 ;;^UTILITY(U,$J,358.3,27396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27396,1,3,0)
 ;;=3^Underdosing of Antidepressants,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27396,1,4,0)
 ;;=4^T43.206D
 ;;^UTILITY(U,$J,358.3,27396,2)
 ;;=^5050544
 ;;^UTILITY(U,$J,358.3,27397,0)
 ;;=T43.506A^^110^1325^12
 ;;^UTILITY(U,$J,358.3,27397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27397,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Init Encntr
 ;;^UTILITY(U,$J,358.3,27397,1,4,0)
 ;;=4^T43.506A
 ;;^UTILITY(U,$J,358.3,27397,2)
 ;;=^5050651
 ;;^UTILITY(U,$J,358.3,27398,0)
 ;;=T43.506S^^110^1325^13
 ;;^UTILITY(U,$J,358.3,27398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27398,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Sequela
 ;;^UTILITY(U,$J,358.3,27398,1,4,0)
 ;;=4^T43.506S
 ;;^UTILITY(U,$J,358.3,27398,2)
 ;;=^5050653
 ;;^UTILITY(U,$J,358.3,27399,0)
 ;;=T43.506D^^110^1325^14
 ;;^UTILITY(U,$J,358.3,27399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27399,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27399,1,4,0)
 ;;=4^T43.506D
 ;;^UTILITY(U,$J,358.3,27399,2)
 ;;=^5050652
 ;;^UTILITY(U,$J,358.3,27400,0)
 ;;=99211^^111^1326^1
