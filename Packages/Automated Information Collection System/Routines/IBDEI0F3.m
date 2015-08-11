IBDEI0F3 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7260,1,4,0)
 ;;=4^361.31
 ;;^UTILITY(U,$J,358.3,7260,2)
 ;;=Peripheral Retinal Hole^268605
 ;;^UTILITY(U,$J,358.3,7261,0)
 ;;=362.51^^49^556^2
 ;;^UTILITY(U,$J,358.3,7261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7261,1,3,0)
 ;;=3^Age Macular Degeneration, Dry (Armd)
 ;;^UTILITY(U,$J,358.3,7261,1,4,0)
 ;;=4^362.51
 ;;^UTILITY(U,$J,358.3,7261,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,7262,0)
 ;;=362.52^^49^556^3
 ;;^UTILITY(U,$J,358.3,7262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7262,1,3,0)
 ;;=3^Age Macular Degeneration, Wet (Armd)
 ;;^UTILITY(U,$J,358.3,7262,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,7262,2)
 ;;=Macular Degeneration, Wet^268637
 ;;^UTILITY(U,$J,358.3,7263,0)
 ;;=362.32^^49^556^6
 ;;^UTILITY(U,$J,358.3,7263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7263,1,3,0)
 ;;=3^Brao/Branch Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,7263,1,4,0)
 ;;=4^362.32
 ;;^UTILITY(U,$J,358.3,7263,2)
 ;;=ARTERIAL BRANCH OCCLUSION^16756
 ;;^UTILITY(U,$J,358.3,7264,0)
 ;;=362.15^^49^556^100
 ;;^UTILITY(U,$J,358.3,7264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7264,1,3,0)
 ;;=3^Telangiectasia
 ;;^UTILITY(U,$J,358.3,7264,1,4,0)
 ;;=4^362.15
 ;;^UTILITY(U,$J,358.3,7264,2)
 ;;=Retinal Telangiectasia^268616
 ;;^UTILITY(U,$J,358.3,7265,0)
 ;;=362.60^^49^556^30
 ;;^UTILITY(U,$J,358.3,7265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7265,1,3,0)
 ;;=3^Degeneration, Periph, Retina
 ;;^UTILITY(U,$J,358.3,7265,1,4,0)
 ;;=4^362.60
 ;;^UTILITY(U,$J,358.3,7265,2)
 ;;=Peripheral Retinal Degeneration^92193
 ;;^UTILITY(U,$J,358.3,7266,0)
 ;;=362.81^^49^556^86
 ;;^UTILITY(U,$J,358.3,7266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7266,1,3,0)
 ;;=3^Retinal Hemorrhage
 ;;^UTILITY(U,$J,358.3,7266,1,4,0)
 ;;=4^362.81
 ;;^UTILITY(U,$J,358.3,7266,2)
 ;;=Retinal Hemorrhage^105587
 ;;^UTILITY(U,$J,358.3,7267,0)
 ;;=190.6^^49^556^57
 ;;^UTILITY(U,$J,358.3,7267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7267,1,3,0)
 ;;=3^Malig Choroid
 ;;^UTILITY(U,$J,358.3,7267,1,4,0)
 ;;=4^190.6
 ;;^UTILITY(U,$J,358.3,7267,2)
 ;;=Malig Neoplasm of Choroid (Primary)^267276
 ;;^UTILITY(U,$J,358.3,7268,0)
 ;;=362.33^^49^556^45
 ;;^UTILITY(U,$J,358.3,7268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7268,1,3,0)
 ;;=3^Hollenhorst Plaque
 ;;^UTILITY(U,$J,358.3,7268,1,4,0)
 ;;=4^362.33
 ;;^UTILITY(U,$J,358.3,7268,2)
 ;;=Hollenhorst Plaque^268620
 ;;^UTILITY(U,$J,358.3,7269,0)
 ;;=361.00^^49^556^84
 ;;^UTILITY(U,$J,358.3,7269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7269,1,3,0)
 ;;=3^Retinal Detachment w/ Ret Defect,Unspec
 ;;^UTILITY(U,$J,358.3,7269,1,4,0)
 ;;=4^361.00
 ;;^UTILITY(U,$J,358.3,7269,2)
 ;;=Retinal Detachment, Unspecified^268585
 ;;^UTILITY(U,$J,358.3,7270,0)
 ;;=361.01^^49^556^77
 ;;^UTILITY(U,$J,358.3,7270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7270,1,3,0)
 ;;=3^Recent Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,7270,1,4,0)
 ;;=4^361.01
 ;;^UTILITY(U,$J,358.3,7270,2)
 ;;=Recent Retinal Detachment, Partial^268586
 ;;^UTILITY(U,$J,358.3,7271,0)
 ;;=361.05^^49^556^78
 ;;^UTILITY(U,$J,358.3,7271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7271,1,3,0)
 ;;=3^Recent Retinal Detachment, Total
 ;;^UTILITY(U,$J,358.3,7271,1,4,0)
 ;;=4^361.05
 ;;^UTILITY(U,$J,358.3,7271,2)
 ;;=Recent Retinal Detachment, Total^268590
 ;;^UTILITY(U,$J,358.3,7272,0)
 ;;=361.06^^49^556^65
 ;;^UTILITY(U,$J,358.3,7272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7272,1,3,0)
 ;;=3^Old Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,7272,1,4,0)
 ;;=4^361.06
 ;;^UTILITY(U,$J,358.3,7272,2)
 ;;=Old Retinal Detachment, Part^268591
