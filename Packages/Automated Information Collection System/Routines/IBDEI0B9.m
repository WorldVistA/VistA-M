IBDEI0B9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5079,1,3,0)
 ;;=3^Impaired Renal Tubular Function Disorders,Other
 ;;^UTILITY(U,$J,358.3,5079,1,4,0)
 ;;=4^N25.89
 ;;^UTILITY(U,$J,358.3,5079,2)
 ;;=^5015618
 ;;^UTILITY(U,$J,358.3,5080,0)
 ;;=T82.590A^^27^327^28
 ;;^UTILITY(U,$J,358.3,5080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5080,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,5080,1,4,0)
 ;;=4^T82.590A
 ;;^UTILITY(U,$J,358.3,5080,2)
 ;;=^5054884
 ;;^UTILITY(U,$J,358.3,5081,0)
 ;;=T82.590D^^27^327^29
 ;;^UTILITY(U,$J,358.3,5081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5081,1,3,0)
 ;;=3^Mech Comp,Surgically Created AV Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,5081,1,4,0)
 ;;=4^T82.590D
 ;;^UTILITY(U,$J,358.3,5081,2)
 ;;=^5054885
 ;;^UTILITY(U,$J,358.3,5082,0)
 ;;=T85.691A^^27^327^26
 ;;^UTILITY(U,$J,358.3,5082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5082,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,5082,1,4,0)
 ;;=4^T85.691A
 ;;^UTILITY(U,$J,358.3,5082,2)
 ;;=^5055655
 ;;^UTILITY(U,$J,358.3,5083,0)
 ;;=T85.691D^^27^327^27
 ;;^UTILITY(U,$J,358.3,5083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5083,1,3,0)
 ;;=3^Mech Comp,Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,5083,1,4,0)
 ;;=4^T85.691D
 ;;^UTILITY(U,$J,358.3,5083,2)
 ;;=^5055656
 ;;^UTILITY(U,$J,358.3,5084,0)
 ;;=T82.898A^^27^327^6
 ;;^UTILITY(U,$J,358.3,5084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5084,1,3,0)
 ;;=3^Complication of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,5084,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,5084,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,5085,0)
 ;;=T82.898D^^27^327^7
 ;;^UTILITY(U,$J,358.3,5085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5085,1,3,0)
 ;;=3^Complication of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,5085,1,4,0)
 ;;=4^T82.898D
 ;;^UTILITY(U,$J,358.3,5085,2)
 ;;=^5054954
 ;;^UTILITY(U,$J,358.3,5086,0)
 ;;=N25.81^^27^327^36
 ;;^UTILITY(U,$J,358.3,5086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5086,1,3,0)
 ;;=3^Secondary Hyperparathyroidism of Renal Origin
 ;;^UTILITY(U,$J,358.3,5086,1,4,0)
 ;;=4^N25.81
 ;;^UTILITY(U,$J,358.3,5086,2)
 ;;=^5015617
 ;;^UTILITY(U,$J,358.3,5087,0)
 ;;=T82.858A^^27^327^37
 ;;^UTILITY(U,$J,358.3,5087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5087,1,3,0)
 ;;=3^Stenosis of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,5087,1,4,0)
 ;;=4^T82.858A
 ;;^UTILITY(U,$J,358.3,5087,2)
 ;;=^5054941
 ;;^UTILITY(U,$J,358.3,5088,0)
 ;;=T82.858D^^27^327^38
 ;;^UTILITY(U,$J,358.3,5088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5088,1,3,0)
 ;;=3^Stenosis of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,5088,1,4,0)
 ;;=4^T82.858D
 ;;^UTILITY(U,$J,358.3,5088,2)
 ;;=^5054942
 ;;^UTILITY(U,$J,358.3,5089,0)
 ;;=T82.868A^^27^327^39
 ;;^UTILITY(U,$J,358.3,5089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5089,1,3,0)
 ;;=3^Thrombosis of Vascular Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,5089,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,5089,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,5090,0)
 ;;=T82.868D^^27^327^40
 ;;^UTILITY(U,$J,358.3,5090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5090,1,3,0)
 ;;=3^Thrombosis of Vascular Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,5090,1,4,0)
 ;;=4^T82.868D
 ;;^UTILITY(U,$J,358.3,5090,2)
 ;;=^5054948
 ;;^UTILITY(U,$J,358.3,5091,0)
 ;;=N28.1^^27^328^1
 ;;^UTILITY(U,$J,358.3,5091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5091,1,3,0)
 ;;=3^Cyst of Kidney,Acquired
 ;;^UTILITY(U,$J,358.3,5091,1,4,0)
 ;;=4^N28.1
 ;;^UTILITY(U,$J,358.3,5091,2)
 ;;=^270380
