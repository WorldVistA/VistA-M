IBDEI1OS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28218,1,3,0)
 ;;=3^Osteitis Deformans of Vertebrae
 ;;^UTILITY(U,$J,358.3,28218,1,4,0)
 ;;=4^M88.1
 ;;^UTILITY(U,$J,358.3,28218,2)
 ;;=^5014875
 ;;^UTILITY(U,$J,358.3,28219,0)
 ;;=M88.89^^132^1326^65
 ;;^UTILITY(U,$J,358.3,28219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28219,1,3,0)
 ;;=3^Osteitis Deformans of Mult Sites
 ;;^UTILITY(U,$J,358.3,28219,1,4,0)
 ;;=4^M88.89
 ;;^UTILITY(U,$J,358.3,28219,2)
 ;;=^5014898
 ;;^UTILITY(U,$J,358.3,28220,0)
 ;;=M94.0^^132^1326^15
 ;;^UTILITY(U,$J,358.3,28220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28220,1,3,0)
 ;;=3^Chondrocostal Junction Syndrome/Costochondritis
 ;;^UTILITY(U,$J,358.3,28220,1,4,0)
 ;;=4^M94.0
 ;;^UTILITY(U,$J,358.3,28220,2)
 ;;=^5015327
 ;;^UTILITY(U,$J,358.3,28221,0)
 ;;=M94.20^^132^1326^18
 ;;^UTILITY(U,$J,358.3,28221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28221,1,3,0)
 ;;=3^Chondromalacia,Unspec Site
 ;;^UTILITY(U,$J,358.3,28221,1,4,0)
 ;;=4^M94.20
 ;;^UTILITY(U,$J,358.3,28221,2)
 ;;=^5015329
 ;;^UTILITY(U,$J,358.3,28222,0)
 ;;=M94.261^^132^1326^17
 ;;^UTILITY(U,$J,358.3,28222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28222,1,3,0)
 ;;=3^Chondromalacia,Right Knee
 ;;^UTILITY(U,$J,358.3,28222,1,4,0)
 ;;=4^M94.261
 ;;^UTILITY(U,$J,358.3,28222,2)
 ;;=^5015345
 ;;^UTILITY(U,$J,358.3,28223,0)
 ;;=M94.262^^132^1326^16
 ;;^UTILITY(U,$J,358.3,28223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28223,1,3,0)
 ;;=3^Chondromalacia,Left Knee
 ;;^UTILITY(U,$J,358.3,28223,1,4,0)
 ;;=4^M94.262
 ;;^UTILITY(U,$J,358.3,28223,2)
 ;;=^5015346
 ;;^UTILITY(U,$J,358.3,28224,0)
 ;;=R25.2^^132^1326^36
 ;;^UTILITY(U,$J,358.3,28224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28224,1,3,0)
 ;;=3^Cramp and Spasm
 ;;^UTILITY(U,$J,358.3,28224,1,4,0)
 ;;=4^R25.2
 ;;^UTILITY(U,$J,358.3,28224,2)
 ;;=^5019301
 ;;^UTILITY(U,$J,358.3,28225,0)
 ;;=R70.0^^132^1326^38
 ;;^UTILITY(U,$J,358.3,28225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28225,1,3,0)
 ;;=3^Elevated Erythrocyte Sedimentation Rate
 ;;^UTILITY(U,$J,358.3,28225,1,4,0)
 ;;=4^R70.0
 ;;^UTILITY(U,$J,358.3,28225,2)
 ;;=^5019559
 ;;^UTILITY(U,$J,358.3,28226,0)
 ;;=M25.511^^132^1326^98
 ;;^UTILITY(U,$J,358.3,28226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28226,1,3,0)
 ;;=3^Pain in Right Shoulder
 ;;^UTILITY(U,$J,358.3,28226,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,28226,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,28227,0)
 ;;=M25.512^^132^1326^88
 ;;^UTILITY(U,$J,358.3,28227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28227,1,3,0)
 ;;=3^Pain in Left Shoulder
 ;;^UTILITY(U,$J,358.3,28227,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,28227,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,28228,0)
 ;;=M25.521^^132^1326^92
 ;;^UTILITY(U,$J,358.3,28228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28228,1,3,0)
 ;;=3^Pain in Right Elbow
 ;;^UTILITY(U,$J,358.3,28228,1,4,0)
 ;;=4^M25.521
 ;;^UTILITY(U,$J,358.3,28228,2)
 ;;=^5011605
 ;;^UTILITY(U,$J,358.3,28229,0)
 ;;=M25.522^^132^1326^82
 ;;^UTILITY(U,$J,358.3,28229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28229,1,3,0)
 ;;=3^Pain in Left Elbow
 ;;^UTILITY(U,$J,358.3,28229,1,4,0)
 ;;=4^M25.522
 ;;^UTILITY(U,$J,358.3,28229,2)
 ;;=^5011606
 ;;^UTILITY(U,$J,358.3,28230,0)
 ;;=M25.531^^132^1326^99
 ;;^UTILITY(U,$J,358.3,28230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28230,1,3,0)
 ;;=3^Pain in Right Wrist
 ;;^UTILITY(U,$J,358.3,28230,1,4,0)
 ;;=4^M25.531
 ;;^UTILITY(U,$J,358.3,28230,2)
 ;;=^5011608
 ;;^UTILITY(U,$J,358.3,28231,0)
 ;;=M25.532^^132^1326^89
 ;;^UTILITY(U,$J,358.3,28231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28231,1,3,0)
 ;;=3^Pain in Left Wrist