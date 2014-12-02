IBDEI0GT ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8165,2)
 ;;=Chorioretinal Scar^23910
 ;;^UTILITY(U,$J,358.3,8166,0)
 ;;=361.31^^58^607^69
 ;;^UTILITY(U,$J,358.3,8166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8166,1,3,0)
 ;;=3^Peripheral Retinal Hole
 ;;^UTILITY(U,$J,358.3,8166,1,4,0)
 ;;=4^361.31
 ;;^UTILITY(U,$J,358.3,8166,2)
 ;;=Peripheral Retinal Hole^268605
 ;;^UTILITY(U,$J,358.3,8167,0)
 ;;=362.51^^58^607^2
 ;;^UTILITY(U,$J,358.3,8167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8167,1,3,0)
 ;;=3^Age Macular Degeneration, Dry (Armd)
 ;;^UTILITY(U,$J,358.3,8167,1,4,0)
 ;;=4^362.51
 ;;^UTILITY(U,$J,358.3,8167,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,8168,0)
 ;;=362.52^^58^607^3
 ;;^UTILITY(U,$J,358.3,8168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8168,1,3,0)
 ;;=3^Age Macular Degeneration, Wet (Armd)
 ;;^UTILITY(U,$J,358.3,8168,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,8168,2)
 ;;=Macular Degeneration, Wet^268637
 ;;^UTILITY(U,$J,358.3,8169,0)
 ;;=362.32^^58^607^6
 ;;^UTILITY(U,$J,358.3,8169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8169,1,3,0)
 ;;=3^Brao/Branch Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,8169,1,4,0)
 ;;=4^362.32
 ;;^UTILITY(U,$J,358.3,8169,2)
 ;;=ARTERIAL BRANCH OCCLUSION^16756
 ;;^UTILITY(U,$J,358.3,8170,0)
 ;;=362.15^^58^607^100
 ;;^UTILITY(U,$J,358.3,8170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8170,1,3,0)
 ;;=3^Telangiectasia
 ;;^UTILITY(U,$J,358.3,8170,1,4,0)
 ;;=4^362.15
 ;;^UTILITY(U,$J,358.3,8170,2)
 ;;=Retinal Telangiectasia^268616
 ;;^UTILITY(U,$J,358.3,8171,0)
 ;;=362.60^^58^607^30
 ;;^UTILITY(U,$J,358.3,8171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8171,1,3,0)
 ;;=3^Degeneration, Periph, Retina
 ;;^UTILITY(U,$J,358.3,8171,1,4,0)
 ;;=4^362.60
 ;;^UTILITY(U,$J,358.3,8171,2)
 ;;=Peripheral Retinal Degeneration^92193
 ;;^UTILITY(U,$J,358.3,8172,0)
 ;;=362.81^^58^607^86
 ;;^UTILITY(U,$J,358.3,8172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8172,1,3,0)
 ;;=3^Retinal Hemorrhage
 ;;^UTILITY(U,$J,358.3,8172,1,4,0)
 ;;=4^362.81
 ;;^UTILITY(U,$J,358.3,8172,2)
 ;;=Retinal Hemorrhage^105587
 ;;^UTILITY(U,$J,358.3,8173,0)
 ;;=190.6^^58^607^57
 ;;^UTILITY(U,$J,358.3,8173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8173,1,3,0)
 ;;=3^Malig Choroid
 ;;^UTILITY(U,$J,358.3,8173,1,4,0)
 ;;=4^190.6
 ;;^UTILITY(U,$J,358.3,8173,2)
 ;;=Malig Neoplasm of Choroid (Primary)^267276
 ;;^UTILITY(U,$J,358.3,8174,0)
 ;;=362.33^^58^607^45
 ;;^UTILITY(U,$J,358.3,8174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8174,1,3,0)
 ;;=3^Hollenhorst Plaque
 ;;^UTILITY(U,$J,358.3,8174,1,4,0)
 ;;=4^362.33
 ;;^UTILITY(U,$J,358.3,8174,2)
 ;;=Hollenhorst Plaque^268620
 ;;^UTILITY(U,$J,358.3,8175,0)
 ;;=361.00^^58^607^84
 ;;^UTILITY(U,$J,358.3,8175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8175,1,3,0)
 ;;=3^Retinal Detachment w/ Ret Defect,Unspec
 ;;^UTILITY(U,$J,358.3,8175,1,4,0)
 ;;=4^361.00
 ;;^UTILITY(U,$J,358.3,8175,2)
 ;;=Retinal Detachment, Unspecified^268585
 ;;^UTILITY(U,$J,358.3,8176,0)
 ;;=361.01^^58^607^77
 ;;^UTILITY(U,$J,358.3,8176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8176,1,3,0)
 ;;=3^Recent Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,8176,1,4,0)
 ;;=4^361.01
 ;;^UTILITY(U,$J,358.3,8176,2)
 ;;=Recent Retinal Detachment, Partial^268586
 ;;^UTILITY(U,$J,358.3,8177,0)
 ;;=361.05^^58^607^78
 ;;^UTILITY(U,$J,358.3,8177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8177,1,3,0)
 ;;=3^Recent Retinal Detachment, Total
 ;;^UTILITY(U,$J,358.3,8177,1,4,0)
 ;;=4^361.05
 ;;^UTILITY(U,$J,358.3,8177,2)
 ;;=Recent Retinal Detachment, Total^268590
 ;;^UTILITY(U,$J,358.3,8178,0)
 ;;=361.06^^58^607^65
