IBDEI0L2 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9981,1,3,0)
 ;;=3^Age Macular Degeneration, Dry (Armd)
 ;;^UTILITY(U,$J,358.3,9981,1,4,0)
 ;;=4^362.51
 ;;^UTILITY(U,$J,358.3,9981,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,9982,0)
 ;;=362.52^^44^560^3
 ;;^UTILITY(U,$J,358.3,9982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9982,1,3,0)
 ;;=3^Age Macular Degeneration, Wet (Armd)
 ;;^UTILITY(U,$J,358.3,9982,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,9982,2)
 ;;=Macular Degeneration, Wet^268637
 ;;^UTILITY(U,$J,358.3,9983,0)
 ;;=362.32^^44^560^6
 ;;^UTILITY(U,$J,358.3,9983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9983,1,3,0)
 ;;=3^Brao/Branch Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,9983,1,4,0)
 ;;=4^362.32
 ;;^UTILITY(U,$J,358.3,9983,2)
 ;;=ARTERIAL BRANCH OCCLUSION^16756
 ;;^UTILITY(U,$J,358.3,9984,0)
 ;;=362.15^^44^560^100
 ;;^UTILITY(U,$J,358.3,9984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9984,1,3,0)
 ;;=3^Telangiectasia
 ;;^UTILITY(U,$J,358.3,9984,1,4,0)
 ;;=4^362.15
 ;;^UTILITY(U,$J,358.3,9984,2)
 ;;=Retinal Telangiectasia^268616
 ;;^UTILITY(U,$J,358.3,9985,0)
 ;;=362.60^^44^560^30
 ;;^UTILITY(U,$J,358.3,9985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9985,1,3,0)
 ;;=3^Degeneration, Periph, Retina
 ;;^UTILITY(U,$J,358.3,9985,1,4,0)
 ;;=4^362.60
 ;;^UTILITY(U,$J,358.3,9985,2)
 ;;=Peripheral Retinal Degeneration^92193
 ;;^UTILITY(U,$J,358.3,9986,0)
 ;;=362.81^^44^560^86
 ;;^UTILITY(U,$J,358.3,9986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9986,1,3,0)
 ;;=3^Retinal Hemorrhage
 ;;^UTILITY(U,$J,358.3,9986,1,4,0)
 ;;=4^362.81
 ;;^UTILITY(U,$J,358.3,9986,2)
 ;;=Retinal Hemorrhage^105587
 ;;^UTILITY(U,$J,358.3,9987,0)
 ;;=190.6^^44^560^57
 ;;^UTILITY(U,$J,358.3,9987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9987,1,3,0)
 ;;=3^Malig Choroid
 ;;^UTILITY(U,$J,358.3,9987,1,4,0)
 ;;=4^190.6
 ;;^UTILITY(U,$J,358.3,9987,2)
 ;;=Malig Neoplasm of Choroid (Primary)^267276
 ;;^UTILITY(U,$J,358.3,9988,0)
 ;;=362.33^^44^560^45
 ;;^UTILITY(U,$J,358.3,9988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9988,1,3,0)
 ;;=3^Hollenhorst Plaque
 ;;^UTILITY(U,$J,358.3,9988,1,4,0)
 ;;=4^362.33
 ;;^UTILITY(U,$J,358.3,9988,2)
 ;;=Hollenhorst Plaque^268620
 ;;^UTILITY(U,$J,358.3,9989,0)
 ;;=361.00^^44^560^84
 ;;^UTILITY(U,$J,358.3,9989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9989,1,3,0)
 ;;=3^Retinal Detachment w/ Ret Defect,Unspec
 ;;^UTILITY(U,$J,358.3,9989,1,4,0)
 ;;=4^361.00
 ;;^UTILITY(U,$J,358.3,9989,2)
 ;;=Retinal Detachment, Unspecified^268585
 ;;^UTILITY(U,$J,358.3,9990,0)
 ;;=361.01^^44^560^77
 ;;^UTILITY(U,$J,358.3,9990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9990,1,3,0)
 ;;=3^Recent Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,9990,1,4,0)
 ;;=4^361.01
 ;;^UTILITY(U,$J,358.3,9990,2)
 ;;=Recent Retinal Detachment, Partial^268586
 ;;^UTILITY(U,$J,358.3,9991,0)
 ;;=361.05^^44^560^78
 ;;^UTILITY(U,$J,358.3,9991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9991,1,3,0)
 ;;=3^Recent Retinal Detachment, Total
 ;;^UTILITY(U,$J,358.3,9991,1,4,0)
 ;;=4^361.05
 ;;^UTILITY(U,$J,358.3,9991,2)
 ;;=Recent Retinal Detachment, Total^268590
 ;;^UTILITY(U,$J,358.3,9992,0)
 ;;=361.06^^44^560^65
 ;;^UTILITY(U,$J,358.3,9992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9992,1,3,0)
 ;;=3^Old Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,9992,1,4,0)
 ;;=4^361.06
 ;;^UTILITY(U,$J,358.3,9992,2)
 ;;=Old Retinal Detachment, Part^268591
 ;;^UTILITY(U,$J,358.3,9993,0)
 ;;=361.07^^44^560^66
 ;;^UTILITY(U,$J,358.3,9993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9993,1,3,0)
 ;;=3^Old Retinal Detachment,Total/Subtotal
 ;;^UTILITY(U,$J,358.3,9993,1,4,0)
 ;;=4^361.07
