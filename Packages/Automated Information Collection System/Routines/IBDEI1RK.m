IBDEI1RK ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28175,0)
 ;;=F15.21^^113^1378^34
 ;;^UTILITY(U,$J,358.3,28175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28175,1,3,0)
 ;;=3^Oth Stimulant Dependence,Mod/Sev,In Remission
 ;;^UTILITY(U,$J,358.3,28175,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,28175,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,28176,0)
 ;;=Z91.120^^113^1379^1
 ;;^UTILITY(U,$J,358.3,28176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28176,1,3,0)
 ;;=3^Intentional Underdosing d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,28176,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,28176,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,28177,0)
 ;;=Z91.128^^113^1379^2
 ;;^UTILITY(U,$J,358.3,28177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28177,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,28177,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,28177,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,28178,0)
 ;;=Z91.130^^113^1379^15
 ;;^UTILITY(U,$J,358.3,28178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28178,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,28178,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,28178,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,28179,0)
 ;;=Z91.138^^113^1379^16
 ;;^UTILITY(U,$J,358.3,28179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28179,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,28179,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,28179,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,28180,0)
 ;;=T38.3X6A^^113^1379^3
 ;;^UTILITY(U,$J,358.3,28180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28180,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,28180,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,28180,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,28181,0)
 ;;=T38.3X6S^^113^1379^4
 ;;^UTILITY(U,$J,358.3,28181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28181,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,28181,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,28181,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,28182,0)
 ;;=T38.3X6D^^113^1379^5
 ;;^UTILITY(U,$J,358.3,28182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28182,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,28182,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,28182,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,28183,0)
 ;;=T46.5X6A^^113^1379^9
 ;;^UTILITY(U,$J,358.3,28183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28183,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,28183,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,28183,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,28184,0)
 ;;=T46.5X6D^^113^1379^10
 ;;^UTILITY(U,$J,358.3,28184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28184,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28184,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,28184,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,28185,0)
 ;;=T46.5X6S^^113^1379^11
 ;;^UTILITY(U,$J,358.3,28185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28185,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,28185,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,28185,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,28186,0)
 ;;=T43.206A^^113^1379^6
 ;;^UTILITY(U,$J,358.3,28186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28186,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
