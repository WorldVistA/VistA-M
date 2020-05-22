IBDEI1V4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29743,1,3,0)
 ;;=3^Cocaine Use DO,Mild,In Remiss
 ;;^UTILITY(U,$J,358.3,29743,1,4,0)
 ;;=4^F14.11
 ;;^UTILITY(U,$J,358.3,29743,2)
 ;;=^268249
 ;;^UTILITY(U,$J,358.3,29744,0)
 ;;=F15.21^^118^1502^34
 ;;^UTILITY(U,$J,358.3,29744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29744,1,3,0)
 ;;=3^Oth Stimulant Dependence,Mod/Sev,In Remission
 ;;^UTILITY(U,$J,358.3,29744,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,29744,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,29745,0)
 ;;=Z91.120^^118^1503^1
 ;;^UTILITY(U,$J,358.3,29745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29745,1,3,0)
 ;;=3^Intentional Underdosing d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,29745,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,29745,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,29746,0)
 ;;=Z91.128^^118^1503^2
 ;;^UTILITY(U,$J,358.3,29746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29746,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,29746,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,29746,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,29747,0)
 ;;=Z91.130^^118^1503^15
 ;;^UTILITY(U,$J,358.3,29747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29747,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,29747,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,29747,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,29748,0)
 ;;=Z91.138^^118^1503^16
 ;;^UTILITY(U,$J,358.3,29748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29748,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,29748,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,29748,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,29749,0)
 ;;=T38.3X6A^^118^1503^3
 ;;^UTILITY(U,$J,358.3,29749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29749,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,29749,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,29749,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,29750,0)
 ;;=T38.3X6S^^118^1503^4
 ;;^UTILITY(U,$J,358.3,29750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29750,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,29750,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,29750,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,29751,0)
 ;;=T38.3X6D^^118^1503^5
 ;;^UTILITY(U,$J,358.3,29751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29751,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,29751,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,29751,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,29752,0)
 ;;=T46.5X6A^^118^1503^9
 ;;^UTILITY(U,$J,358.3,29752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29752,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,29752,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,29752,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,29753,0)
 ;;=T46.5X6D^^118^1503^10
 ;;^UTILITY(U,$J,358.3,29753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29753,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,29753,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,29753,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,29754,0)
 ;;=T46.5X6S^^118^1503^11
 ;;^UTILITY(U,$J,358.3,29754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29754,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,29754,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,29754,2)
 ;;=^5051355
