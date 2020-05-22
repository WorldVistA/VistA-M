IBDEI1X6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30661,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,30662,0)
 ;;=T82.838A^^123^1580^12
 ;;^UTILITY(U,$J,358.3,30662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30662,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,30662,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,30662,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,30663,0)
 ;;=T82.838D^^123^1580^13
 ;;^UTILITY(U,$J,358.3,30663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30663,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30663,1,4,0)
 ;;=4^T82.838D
 ;;^UTILITY(U,$J,358.3,30663,2)
 ;;=^5054930
 ;;^UTILITY(U,$J,358.3,30664,0)
 ;;=E83.81^^123^1580^15
 ;;^UTILITY(U,$J,358.3,30664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30664,1,3,0)
 ;;=3^Hungry Bone Syndrome
 ;;^UTILITY(U,$J,358.3,30664,1,4,0)
 ;;=4^E83.81
 ;;^UTILITY(U,$J,358.3,30664,2)
 ;;=^336538
 ;;^UTILITY(U,$J,358.3,30665,0)
 ;;=T85.71XA^^123^1580^21
 ;;^UTILITY(U,$J,358.3,30665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30665,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,30665,1,4,0)
 ;;=4^T85.71XA
 ;;^UTILITY(U,$J,358.3,30665,2)
 ;;=^5055670
 ;;^UTILITY(U,$J,358.3,30666,0)
 ;;=T85.71XD^^123^1580^22
 ;;^UTILITY(U,$J,358.3,30666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30666,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30666,1,4,0)
 ;;=4^T85.71XD
 ;;^UTILITY(U,$J,358.3,30666,2)
 ;;=^5055671
 ;;^UTILITY(U,$J,358.3,30667,0)
 ;;=T82.7XXA^^123^1580^19
 ;;^UTILITY(U,$J,358.3,30667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30667,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,30667,1,4,0)
 ;;=4^T82.7XXA
 ;;^UTILITY(U,$J,358.3,30667,2)
 ;;=^5054911
 ;;^UTILITY(U,$J,358.3,30668,0)
 ;;=T82.7XXD^^123^1580^20
 ;;^UTILITY(U,$J,358.3,30668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30668,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30668,1,4,0)
 ;;=4^T82.7XXD
 ;;^UTILITY(U,$J,358.3,30668,2)
 ;;=^5054912
 ;;^UTILITY(U,$J,358.3,30669,0)
 ;;=T85.631A^^123^1580^23
 ;;^UTILITY(U,$J,358.3,30669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30669,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,30669,1,4,0)
 ;;=4^T85.631A
 ;;^UTILITY(U,$J,358.3,30669,2)
 ;;=^5055643
 ;;^UTILITY(U,$J,358.3,30670,0)
 ;;=T85.631D^^123^1580^24
 ;;^UTILITY(U,$J,358.3,30670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30670,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30670,1,4,0)
 ;;=4^T85.631D
 ;;^UTILITY(U,$J,358.3,30670,2)
 ;;=^5055644
 ;;^UTILITY(U,$J,358.3,30671,0)
 ;;=H54.8^^123^1580^25
 ;;^UTILITY(U,$J,358.3,30671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30671,1,3,0)
 ;;=3^Legal Blindness,USA Definition
 ;;^UTILITY(U,$J,358.3,30671,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,30671,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,30672,0)
 ;;=N25.89^^123^1580^18
 ;;^UTILITY(U,$J,358.3,30672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30672,1,3,0)
 ;;=3^Impaired Renal Tubular Function Disorders,Other
 ;;^UTILITY(U,$J,358.3,30672,1,4,0)
 ;;=4^N25.89
 ;;^UTILITY(U,$J,358.3,30672,2)
 ;;=^5015618
 ;;^UTILITY(U,$J,358.3,30673,0)
 ;;=T82.590A^^123^1580^28
 ;;^UTILITY(U,$J,358.3,30673,1,0)
 ;;=^358.31IA^4^2
