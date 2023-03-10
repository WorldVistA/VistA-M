IBDEI1LS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25974,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,25974,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,25975,0)
 ;;=Z91.128^^92^1189^2
 ;;^UTILITY(U,$J,358.3,25975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25975,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,25975,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,25975,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,25976,0)
 ;;=Z91.130^^92^1189^15
 ;;^UTILITY(U,$J,358.3,25976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25976,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,25976,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,25976,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,25977,0)
 ;;=Z91.138^^92^1189^16
 ;;^UTILITY(U,$J,358.3,25977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25977,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,25977,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,25977,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,25978,0)
 ;;=T38.3X6A^^92^1189^3
 ;;^UTILITY(U,$J,358.3,25978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25978,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,25978,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,25978,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,25979,0)
 ;;=T38.3X6S^^92^1189^4
 ;;^UTILITY(U,$J,358.3,25979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25979,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,25979,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,25979,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,25980,0)
 ;;=T38.3X6D^^92^1189^5
 ;;^UTILITY(U,$J,358.3,25980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25980,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,25980,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,25980,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,25981,0)
 ;;=T46.5X6A^^92^1189^9
 ;;^UTILITY(U,$J,358.3,25981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25981,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,25981,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,25981,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,25982,0)
 ;;=T46.5X6D^^92^1189^10
 ;;^UTILITY(U,$J,358.3,25982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25982,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,25982,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,25982,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,25983,0)
 ;;=T46.5X6S^^92^1189^11
 ;;^UTILITY(U,$J,358.3,25983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25983,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,25983,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,25983,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,25984,0)
 ;;=T43.206A^^92^1189^6
 ;;^UTILITY(U,$J,358.3,25984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25984,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
 ;;^UTILITY(U,$J,358.3,25984,1,4,0)
 ;;=4^T43.206A
 ;;^UTILITY(U,$J,358.3,25984,2)
 ;;=^5050543
 ;;^UTILITY(U,$J,358.3,25985,0)
 ;;=T43.206S^^92^1189^7
 ;;^UTILITY(U,$J,358.3,25985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25985,1,3,0)
 ;;=3^Underdosing of Antidepressants,Sequela
 ;;^UTILITY(U,$J,358.3,25985,1,4,0)
 ;;=4^T43.206S
 ;;^UTILITY(U,$J,358.3,25985,2)
 ;;=^5050545
 ;;^UTILITY(U,$J,358.3,25986,0)
 ;;=T43.206D^^92^1189^8
 ;;^UTILITY(U,$J,358.3,25986,1,0)
 ;;=^358.31IA^4^2
