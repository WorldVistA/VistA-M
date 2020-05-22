IBDEI26D ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34724,0)
 ;;=F15.21^^134^1762^34
 ;;^UTILITY(U,$J,358.3,34724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34724,1,3,0)
 ;;=3^Oth Stimulant Dependence,Mod/Sev,In Remission
 ;;^UTILITY(U,$J,358.3,34724,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,34724,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,34725,0)
 ;;=Z91.120^^134^1763^1
 ;;^UTILITY(U,$J,358.3,34725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34725,1,3,0)
 ;;=3^Intentional Underdosing d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,34725,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,34725,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,34726,0)
 ;;=Z91.128^^134^1763^2
 ;;^UTILITY(U,$J,358.3,34726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34726,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,34726,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,34726,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,34727,0)
 ;;=Z91.130^^134^1763^15
 ;;^UTILITY(U,$J,358.3,34727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34727,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,34727,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,34727,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,34728,0)
 ;;=Z91.138^^134^1763^16
 ;;^UTILITY(U,$J,358.3,34728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34728,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,34728,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,34728,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,34729,0)
 ;;=T38.3X6A^^134^1763^3
 ;;^UTILITY(U,$J,358.3,34729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34729,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,34729,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,34729,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,34730,0)
 ;;=T38.3X6S^^134^1763^4
 ;;^UTILITY(U,$J,358.3,34730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34730,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,34730,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,34730,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,34731,0)
 ;;=T38.3X6D^^134^1763^5
 ;;^UTILITY(U,$J,358.3,34731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34731,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,34731,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,34731,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,34732,0)
 ;;=T46.5X6A^^134^1763^9
 ;;^UTILITY(U,$J,358.3,34732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34732,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,34732,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,34732,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,34733,0)
 ;;=T46.5X6D^^134^1763^10
 ;;^UTILITY(U,$J,358.3,34733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34733,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,34733,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,34733,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,34734,0)
 ;;=T46.5X6S^^134^1763^11
 ;;^UTILITY(U,$J,358.3,34734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34734,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,34734,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,34734,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,34735,0)
 ;;=T43.206A^^134^1763^6
 ;;^UTILITY(U,$J,358.3,34735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34735,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
