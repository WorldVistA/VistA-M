IBDEI1LY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27279,1,4,0)
 ;;=4^T85.71XD
 ;;^UTILITY(U,$J,358.3,27279,2)
 ;;=^5055671
 ;;^UTILITY(U,$J,358.3,27280,0)
 ;;=T82.7XXA^^106^1346^19
 ;;^UTILITY(U,$J,358.3,27280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27280,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,27280,1,4,0)
 ;;=4^T82.7XXA
 ;;^UTILITY(U,$J,358.3,27280,2)
 ;;=^5054911
 ;;^UTILITY(U,$J,358.3,27281,0)
 ;;=T82.7XXD^^106^1346^20
 ;;^UTILITY(U,$J,358.3,27281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27281,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27281,1,4,0)
 ;;=4^T82.7XXD
 ;;^UTILITY(U,$J,358.3,27281,2)
 ;;=^5054912
 ;;^UTILITY(U,$J,358.3,27282,0)
 ;;=T85.631A^^106^1346^23
 ;;^UTILITY(U,$J,358.3,27282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27282,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,27282,1,4,0)
 ;;=4^T85.631A
 ;;^UTILITY(U,$J,358.3,27282,2)
 ;;=^5055643
 ;;^UTILITY(U,$J,358.3,27283,0)
 ;;=T85.631D^^106^1346^24
 ;;^UTILITY(U,$J,358.3,27283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27283,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27283,1,4,0)
 ;;=4^T85.631D
 ;;^UTILITY(U,$J,358.3,27283,2)
 ;;=^5055644
 ;;^UTILITY(U,$J,358.3,27284,0)
 ;;=H54.8^^106^1346^25
 ;;^UTILITY(U,$J,358.3,27284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27284,1,3,0)
 ;;=3^Legal Blindness,USA Definition
 ;;^UTILITY(U,$J,358.3,27284,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,27284,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,27285,0)
 ;;=N25.89^^106^1346^18
 ;;^UTILITY(U,$J,358.3,27285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27285,1,3,0)
 ;;=3^Impaired Renal Tubular Function Disorders,Other
 ;;^UTILITY(U,$J,358.3,27285,1,4,0)
 ;;=4^N25.89
 ;;^UTILITY(U,$J,358.3,27285,2)
 ;;=^5015618
 ;;^UTILITY(U,$J,358.3,27286,0)
 ;;=T82.590A^^106^1346^28
 ;;^UTILITY(U,$J,358.3,27286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27286,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,27286,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,27286,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,27287,0)
 ;;=T82.590D^^106^1346^29
 ;;^UTILITY(U,$J,358.3,27287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27287,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27287,1,4,0)
 ;;=4^T82.590D
 ;;^UTILITY(U,$J,358.3,27287,2)
 ;;=^5054885
 ;;^UTILITY(U,$J,358.3,27288,0)
 ;;=T85.691A^^106^1346^26
 ;;^UTILITY(U,$J,358.3,27288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27288,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,27288,1,4,0)
 ;;=4^T85.691A
 ;;^UTILITY(U,$J,358.3,27288,2)
 ;;=^5055655
 ;;^UTILITY(U,$J,358.3,27289,0)
 ;;=T85.691D^^106^1346^27
 ;;^UTILITY(U,$J,358.3,27289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27289,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27289,1,4,0)
 ;;=4^T85.691D
 ;;^UTILITY(U,$J,358.3,27289,2)
 ;;=^5055656
 ;;^UTILITY(U,$J,358.3,27290,0)
 ;;=T82.898A^^106^1346^6
 ;;^UTILITY(U,$J,358.3,27290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27290,1,3,0)
 ;;=3^Complication of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,27290,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,27290,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,27291,0)
 ;;=T82.898D^^106^1346^7
 ;;^UTILITY(U,$J,358.3,27291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27291,1,3,0)
 ;;=3^Complication of Vascular Graft,Subs Encntr
