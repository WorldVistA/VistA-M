IBDEI0JZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8809,1,3,0)
 ;;=3^Impaired Renal Tubular Function Disorders,Other
 ;;^UTILITY(U,$J,358.3,8809,1,4,0)
 ;;=4^N25.89
 ;;^UTILITY(U,$J,358.3,8809,2)
 ;;=^5015618
 ;;^UTILITY(U,$J,358.3,8810,0)
 ;;=T82.590A^^69^600^28
 ;;^UTILITY(U,$J,358.3,8810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8810,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,8810,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,8810,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,8811,0)
 ;;=T82.590D^^69^600^29
 ;;^UTILITY(U,$J,358.3,8811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8811,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8811,1,4,0)
 ;;=4^T82.590D
 ;;^UTILITY(U,$J,358.3,8811,2)
 ;;=^5054885
 ;;^UTILITY(U,$J,358.3,8812,0)
 ;;=T85.691A^^69^600^26
 ;;^UTILITY(U,$J,358.3,8812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8812,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,8812,1,4,0)
 ;;=4^T85.691A
 ;;^UTILITY(U,$J,358.3,8812,2)
 ;;=^5055655
 ;;^UTILITY(U,$J,358.3,8813,0)
 ;;=T85.691D^^69^600^27
 ;;^UTILITY(U,$J,358.3,8813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8813,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8813,1,4,0)
 ;;=4^T85.691D
 ;;^UTILITY(U,$J,358.3,8813,2)
 ;;=^5055656
 ;;^UTILITY(U,$J,358.3,8814,0)
 ;;=T82.898A^^69^600^6
 ;;^UTILITY(U,$J,358.3,8814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8814,1,3,0)
 ;;=3^Complication of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,8814,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,8814,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,8815,0)
 ;;=T82.898D^^69^600^7
 ;;^UTILITY(U,$J,358.3,8815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8815,1,3,0)
 ;;=3^Complication of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8815,1,4,0)
 ;;=4^T82.898D
 ;;^UTILITY(U,$J,358.3,8815,2)
 ;;=^5054954
 ;;^UTILITY(U,$J,358.3,8816,0)
 ;;=N25.81^^69^600^36
 ;;^UTILITY(U,$J,358.3,8816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8816,1,3,0)
 ;;=3^Secondary Hyperparathyroidism of Renal Origin
 ;;^UTILITY(U,$J,358.3,8816,1,4,0)
 ;;=4^N25.81
 ;;^UTILITY(U,$J,358.3,8816,2)
 ;;=^5015617
 ;;^UTILITY(U,$J,358.3,8817,0)
 ;;=T82.858A^^69^600^37
 ;;^UTILITY(U,$J,358.3,8817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8817,1,3,0)
 ;;=3^Stenosis of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,8817,1,4,0)
 ;;=4^T82.858A
 ;;^UTILITY(U,$J,358.3,8817,2)
 ;;=^5054941
 ;;^UTILITY(U,$J,358.3,8818,0)
 ;;=T82.858D^^69^600^38
 ;;^UTILITY(U,$J,358.3,8818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8818,1,3,0)
 ;;=3^Stenosis of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8818,1,4,0)
 ;;=4^T82.858D
 ;;^UTILITY(U,$J,358.3,8818,2)
 ;;=^5054942
 ;;^UTILITY(U,$J,358.3,8819,0)
 ;;=T82.868A^^69^600^39
 ;;^UTILITY(U,$J,358.3,8819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8819,1,3,0)
 ;;=3^Thrombosis of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,8819,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,8819,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,8820,0)
 ;;=T82.868D^^69^600^40
 ;;^UTILITY(U,$J,358.3,8820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8820,1,3,0)
 ;;=3^Thrombosis of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8820,1,4,0)
 ;;=4^T82.868D
 ;;^UTILITY(U,$J,358.3,8820,2)
 ;;=^5054948
