IBDEI0JX ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8785,1,3,0)
 ;;=3^Obesity,Morbid,d/t Excess Calories
 ;;^UTILITY(U,$J,358.3,8785,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,8785,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,8786,0)
 ;;=D50.9^^69^600^2
 ;;^UTILITY(U,$J,358.3,8786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8786,1,3,0)
 ;;=3^Anemia,Iron Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,8786,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,8786,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,8787,0)
 ;;=D63.1^^69^600^1
 ;;^UTILITY(U,$J,358.3,8787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8787,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,8787,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,8787,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,8788,0)
 ;;=G60.9^^69^600^31
 ;;^UTILITY(U,$J,358.3,8788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8788,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,8788,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,8788,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,8789,0)
 ;;=I73.9^^69^600^34
 ;;^UTILITY(U,$J,358.3,8789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8789,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,8789,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,8789,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,8790,0)
 ;;=N04.9^^69^600^30
 ;;^UTILITY(U,$J,358.3,8790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8790,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,8790,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,8790,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,8791,0)
 ;;=N25.0^^69^600^35
 ;;^UTILITY(U,$J,358.3,8791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8791,1,3,0)
 ;;=3^Renal Osteodystrophy
 ;;^UTILITY(U,$J,358.3,8791,1,4,0)
 ;;=4^N25.0
 ;;^UTILITY(U,$J,358.3,8791,2)
 ;;=^104747
 ;;^UTILITY(U,$J,358.3,8792,0)
 ;;=T80.211A^^69^600^3
 ;;^UTILITY(U,$J,358.3,8792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8792,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,8792,1,4,0)
 ;;=4^T80.211A
 ;;^UTILITY(U,$J,358.3,8792,2)
 ;;=^5054350
 ;;^UTILITY(U,$J,358.3,8793,0)
 ;;=T80.211D^^69^600^4
 ;;^UTILITY(U,$J,358.3,8793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8793,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8793,1,4,0)
 ;;=4^T80.211D
 ;;^UTILITY(U,$J,358.3,8793,2)
 ;;=^5054351
 ;;^UTILITY(U,$J,358.3,8794,0)
 ;;=E83.59^^69^600^5
 ;;^UTILITY(U,$J,358.3,8794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8794,1,3,0)
 ;;=3^Calciphylaxis
 ;;^UTILITY(U,$J,358.3,8794,1,4,0)
 ;;=4^E83.59
 ;;^UTILITY(U,$J,358.3,8794,2)
 ;;=^5003006
 ;;^UTILITY(U,$J,358.3,8795,0)
 ;;=T85.621A^^69^600^8
 ;;^UTILITY(U,$J,358.3,8795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8795,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,8795,1,4,0)
 ;;=4^T85.621A
 ;;^UTILITY(U,$J,358.3,8795,2)
 ;;=^5055625
 ;;^UTILITY(U,$J,358.3,8796,0)
 ;;=T85.621D^^69^600^9
 ;;^UTILITY(U,$J,358.3,8796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8796,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,8796,1,4,0)
 ;;=4^T85.621D
 ;;^UTILITY(U,$J,358.3,8796,2)
 ;;=^5055626
 ;;^UTILITY(U,$J,358.3,8797,0)
 ;;=K65.0^^69^600^10
 ;;^UTILITY(U,$J,358.3,8797,1,0)
 ;;=^358.31IA^4^2
