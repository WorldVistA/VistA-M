IBDEI1WW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30525,0)
 ;;=F15.21^^120^1556^34
 ;;^UTILITY(U,$J,358.3,30525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30525,1,3,0)
 ;;=3^Oth Stimulant Dependence,Mod/Sev,In Remission
 ;;^UTILITY(U,$J,358.3,30525,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,30525,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,30526,0)
 ;;=Z91.120^^120^1557^1
 ;;^UTILITY(U,$J,358.3,30526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30526,1,3,0)
 ;;=3^Intentional Underdosing d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,30526,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,30526,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,30527,0)
 ;;=Z91.128^^120^1557^2
 ;;^UTILITY(U,$J,358.3,30527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30527,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,30527,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,30527,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,30528,0)
 ;;=Z91.130^^120^1557^15
 ;;^UTILITY(U,$J,358.3,30528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30528,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,30528,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,30528,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,30529,0)
 ;;=Z91.138^^120^1557^16
 ;;^UTILITY(U,$J,358.3,30529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30529,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,30529,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,30529,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,30530,0)
 ;;=T38.3X6A^^120^1557^3
 ;;^UTILITY(U,$J,358.3,30530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30530,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,30530,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,30530,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,30531,0)
 ;;=T38.3X6S^^120^1557^4
 ;;^UTILITY(U,$J,358.3,30531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30531,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,30531,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,30531,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,30532,0)
 ;;=T38.3X6D^^120^1557^5
 ;;^UTILITY(U,$J,358.3,30532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30532,1,3,0)
 ;;=3^Underdosing Insulin/Oral Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,30532,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,30532,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,30533,0)
 ;;=T46.5X6A^^120^1557^9
 ;;^UTILITY(U,$J,358.3,30533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30533,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,30533,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,30533,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,30534,0)
 ;;=T46.5X6D^^120^1557^10
 ;;^UTILITY(U,$J,358.3,30534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30534,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30534,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,30534,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,30535,0)
 ;;=T46.5X6S^^120^1557^11
 ;;^UTILITY(U,$J,358.3,30535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30535,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,30535,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,30535,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,30536,0)
 ;;=T43.206A^^120^1557^6
 ;;^UTILITY(U,$J,358.3,30536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30536,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
