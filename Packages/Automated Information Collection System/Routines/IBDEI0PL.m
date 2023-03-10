IBDEI0PL ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11503,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,11503,1,4,0)
 ;;=4^T82.7XXA
 ;;^UTILITY(U,$J,358.3,11503,2)
 ;;=^5054911
 ;;^UTILITY(U,$J,358.3,11504,0)
 ;;=T82.7XXD^^46^556^20
 ;;^UTILITY(U,$J,358.3,11504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11504,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11504,1,4,0)
 ;;=4^T82.7XXD
 ;;^UTILITY(U,$J,358.3,11504,2)
 ;;=^5054912
 ;;^UTILITY(U,$J,358.3,11505,0)
 ;;=T85.631A^^46^556^23
 ;;^UTILITY(U,$J,358.3,11505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11505,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,11505,1,4,0)
 ;;=4^T85.631A
 ;;^UTILITY(U,$J,358.3,11505,2)
 ;;=^5055643
 ;;^UTILITY(U,$J,358.3,11506,0)
 ;;=T85.631D^^46^556^24
 ;;^UTILITY(U,$J,358.3,11506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11506,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11506,1,4,0)
 ;;=4^T85.631D
 ;;^UTILITY(U,$J,358.3,11506,2)
 ;;=^5055644
 ;;^UTILITY(U,$J,358.3,11507,0)
 ;;=H54.8^^46^556^25
 ;;^UTILITY(U,$J,358.3,11507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11507,1,3,0)
 ;;=3^Legal Blindness,USA Definition
 ;;^UTILITY(U,$J,358.3,11507,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,11507,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,11508,0)
 ;;=N25.89^^46^556^18
 ;;^UTILITY(U,$J,358.3,11508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11508,1,3,0)
 ;;=3^Impaired Renal Tubular Function Disorders,Other
 ;;^UTILITY(U,$J,358.3,11508,1,4,0)
 ;;=4^N25.89
 ;;^UTILITY(U,$J,358.3,11508,2)
 ;;=^5015618
 ;;^UTILITY(U,$J,358.3,11509,0)
 ;;=T82.590A^^46^556^28
 ;;^UTILITY(U,$J,358.3,11509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11509,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,11509,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,11509,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,11510,0)
 ;;=T82.590D^^46^556^29
 ;;^UTILITY(U,$J,358.3,11510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11510,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11510,1,4,0)
 ;;=4^T82.590D
 ;;^UTILITY(U,$J,358.3,11510,2)
 ;;=^5054885
 ;;^UTILITY(U,$J,358.3,11511,0)
 ;;=T85.691A^^46^556^26
 ;;^UTILITY(U,$J,358.3,11511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11511,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,11511,1,4,0)
 ;;=4^T85.691A
 ;;^UTILITY(U,$J,358.3,11511,2)
 ;;=^5055655
 ;;^UTILITY(U,$J,358.3,11512,0)
 ;;=T85.691D^^46^556^27
 ;;^UTILITY(U,$J,358.3,11512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11512,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11512,1,4,0)
 ;;=4^T85.691D
 ;;^UTILITY(U,$J,358.3,11512,2)
 ;;=^5055656
 ;;^UTILITY(U,$J,358.3,11513,0)
 ;;=T82.898A^^46^556^6
 ;;^UTILITY(U,$J,358.3,11513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11513,1,3,0)
 ;;=3^Complication of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,11513,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,11513,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,11514,0)
 ;;=T82.898D^^46^556^7
 ;;^UTILITY(U,$J,358.3,11514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11514,1,3,0)
 ;;=3^Complication of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11514,1,4,0)
 ;;=4^T82.898D
