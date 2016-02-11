IBDEI06L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2484,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,2484,1,4,0)
 ;;=4^I06.0
 ;;^UTILITY(U,$J,358.3,2484,2)
 ;;=^269573
 ;;^UTILITY(U,$J,358.3,2485,0)
 ;;=I06.1^^19^204^1
 ;;^UTILITY(U,$J,358.3,2485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2485,1,3,0)
 ;;=3^Rheumatic Aortic Insufficiency
 ;;^UTILITY(U,$J,358.3,2485,1,4,0)
 ;;=4^I06.1
 ;;^UTILITY(U,$J,358.3,2485,2)
 ;;=^269575
 ;;^UTILITY(U,$J,358.3,2486,0)
 ;;=I06.2^^19^204^3
 ;;^UTILITY(U,$J,358.3,2486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2486,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,2486,1,4,0)
 ;;=4^I06.2
 ;;^UTILITY(U,$J,358.3,2486,2)
 ;;=^269577
 ;;^UTILITY(U,$J,358.3,2487,0)
 ;;=I06.8^^19^204^4
 ;;^UTILITY(U,$J,358.3,2487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2487,1,3,0)
 ;;=3^Rheumatic Aortic Valve Diseases NEC
 ;;^UTILITY(U,$J,358.3,2487,1,4,0)
 ;;=4^I06.8
 ;;^UTILITY(U,$J,358.3,2487,2)
 ;;=^5007045
 ;;^UTILITY(U,$J,358.3,2488,0)
 ;;=I09.89^^19^204^6
 ;;^UTILITY(U,$J,358.3,2488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2488,1,3,0)
 ;;=3^Rheumatic Heart Diseases
 ;;^UTILITY(U,$J,358.3,2488,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,2488,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,2489,0)
 ;;=I08.8^^19^204^11
 ;;^UTILITY(U,$J,358.3,2489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2489,1,3,0)
 ;;=3^Rheumatic Multiple Valve Dieases NEC
 ;;^UTILITY(U,$J,358.3,2489,1,4,0)
 ;;=4^I08.8
 ;;^UTILITY(U,$J,358.3,2489,2)
 ;;=^5007056
 ;;^UTILITY(U,$J,358.3,2490,0)
 ;;=T82.9XXA^^19^205^2
 ;;^UTILITY(U,$J,358.3,2490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2490,1,3,0)
 ;;=3^Complication of Cardiac/Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2490,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,2490,2)
 ;;=^5054956
 ;;^UTILITY(U,$J,358.3,2491,0)
 ;;=T82.857A^^19^205^9
 ;;^UTILITY(U,$J,358.3,2491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2491,1,3,0)
 ;;=3^Stenosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2491,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,2491,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,2492,0)
 ;;=T82.867A^^19^205^10
 ;;^UTILITY(U,$J,358.3,2492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2492,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2492,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,2492,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,2493,0)
 ;;=T82.897A^^19^205^3
 ;;^UTILITY(U,$J,358.3,2493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2493,1,3,0)
 ;;=3^Complications of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2493,1,4,0)
 ;;=4^T82.897A
 ;;^UTILITY(U,$J,358.3,2493,2)
 ;;=^5054950
 ;;^UTILITY(U,$J,358.3,2494,0)
 ;;=T82.817A^^19^205^4
 ;;^UTILITY(U,$J,358.3,2494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2494,1,3,0)
 ;;=3^Ebolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2494,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,2494,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,2495,0)
 ;;=T82.827A^^19^205^5
 ;;^UTILITY(U,$J,358.3,2495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2495,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2495,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,2495,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,2496,0)
 ;;=T82.837A^^19^205^6
 ;;^UTILITY(U,$J,358.3,2496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2496,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
