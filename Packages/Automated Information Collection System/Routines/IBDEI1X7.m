IBDEI1X7 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30673,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,30673,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,30673,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,30674,0)
 ;;=T82.590D^^123^1580^29
 ;;^UTILITY(U,$J,358.3,30674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30674,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30674,1,4,0)
 ;;=4^T82.590D
 ;;^UTILITY(U,$J,358.3,30674,2)
 ;;=^5054885
 ;;^UTILITY(U,$J,358.3,30675,0)
 ;;=T85.691A^^123^1580^26
 ;;^UTILITY(U,$J,358.3,30675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30675,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,30675,1,4,0)
 ;;=4^T85.691A
 ;;^UTILITY(U,$J,358.3,30675,2)
 ;;=^5055655
 ;;^UTILITY(U,$J,358.3,30676,0)
 ;;=T85.691D^^123^1580^27
 ;;^UTILITY(U,$J,358.3,30676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30676,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30676,1,4,0)
 ;;=4^T85.691D
 ;;^UTILITY(U,$J,358.3,30676,2)
 ;;=^5055656
 ;;^UTILITY(U,$J,358.3,30677,0)
 ;;=T82.898A^^123^1580^6
 ;;^UTILITY(U,$J,358.3,30677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30677,1,3,0)
 ;;=3^Complication of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,30677,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,30677,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,30678,0)
 ;;=T82.898D^^123^1580^7
 ;;^UTILITY(U,$J,358.3,30678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30678,1,3,0)
 ;;=3^Complication of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30678,1,4,0)
 ;;=4^T82.898D
 ;;^UTILITY(U,$J,358.3,30678,2)
 ;;=^5054954
 ;;^UTILITY(U,$J,358.3,30679,0)
 ;;=N25.81^^123^1580^36
 ;;^UTILITY(U,$J,358.3,30679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30679,1,3,0)
 ;;=3^Secondary Hyperparathyroidism of Renal Origin
 ;;^UTILITY(U,$J,358.3,30679,1,4,0)
 ;;=4^N25.81
 ;;^UTILITY(U,$J,358.3,30679,2)
 ;;=^5015617
 ;;^UTILITY(U,$J,358.3,30680,0)
 ;;=T82.858A^^123^1580^37
 ;;^UTILITY(U,$J,358.3,30680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30680,1,3,0)
 ;;=3^Stenosis of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,30680,1,4,0)
 ;;=4^T82.858A
 ;;^UTILITY(U,$J,358.3,30680,2)
 ;;=^5054941
 ;;^UTILITY(U,$J,358.3,30681,0)
 ;;=T82.858D^^123^1580^38
 ;;^UTILITY(U,$J,358.3,30681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30681,1,3,0)
 ;;=3^Stenosis of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30681,1,4,0)
 ;;=4^T82.858D
 ;;^UTILITY(U,$J,358.3,30681,2)
 ;;=^5054942
 ;;^UTILITY(U,$J,358.3,30682,0)
 ;;=T82.868A^^123^1580^39
 ;;^UTILITY(U,$J,358.3,30682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30682,1,3,0)
 ;;=3^Thrombosis of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,30682,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,30682,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,30683,0)
 ;;=T82.868D^^123^1580^40
 ;;^UTILITY(U,$J,358.3,30683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30683,1,3,0)
 ;;=3^Thrombosis of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30683,1,4,0)
 ;;=4^T82.868D
 ;;^UTILITY(U,$J,358.3,30683,2)
 ;;=^5054948
 ;;^UTILITY(U,$J,358.3,30684,0)
 ;;=N28.1^^123^1581^1
 ;;^UTILITY(U,$J,358.3,30684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30684,1,3,0)
 ;;=3^Cyst of Kidney,Acquired
 ;;^UTILITY(U,$J,358.3,30684,1,4,0)
 ;;=4^N28.1
 ;;^UTILITY(U,$J,358.3,30684,2)
 ;;=^270380
