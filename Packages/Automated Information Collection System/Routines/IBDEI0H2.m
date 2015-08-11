IBDEI0H2 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8252,1,4,0)
 ;;=4^361.31
 ;;^UTILITY(U,$J,358.3,8252,2)
 ;;=Peripheral Retinal Hole^268605
 ;;^UTILITY(U,$J,358.3,8253,0)
 ;;=362.51^^52^580^2
 ;;^UTILITY(U,$J,358.3,8253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8253,1,3,0)
 ;;=3^Age Macular Degeneration, Dry (Armd)
 ;;^UTILITY(U,$J,358.3,8253,1,4,0)
 ;;=4^362.51
 ;;^UTILITY(U,$J,358.3,8253,2)
 ;;=^268636
 ;;^UTILITY(U,$J,358.3,8254,0)
 ;;=362.52^^52^580^3
 ;;^UTILITY(U,$J,358.3,8254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8254,1,3,0)
 ;;=3^Age Macular Degeneration, Wet (Armd)
 ;;^UTILITY(U,$J,358.3,8254,1,4,0)
 ;;=4^362.52
 ;;^UTILITY(U,$J,358.3,8254,2)
 ;;=Macular Degeneration, Wet^268637
 ;;^UTILITY(U,$J,358.3,8255,0)
 ;;=362.32^^52^580^6
 ;;^UTILITY(U,$J,358.3,8255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8255,1,3,0)
 ;;=3^Brao/Branch Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,8255,1,4,0)
 ;;=4^362.32
 ;;^UTILITY(U,$J,358.3,8255,2)
 ;;=ARTERIAL BRANCH OCCLUSION^16756
 ;;^UTILITY(U,$J,358.3,8256,0)
 ;;=362.15^^52^580^100
 ;;^UTILITY(U,$J,358.3,8256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8256,1,3,0)
 ;;=3^Telangiectasia
 ;;^UTILITY(U,$J,358.3,8256,1,4,0)
 ;;=4^362.15
 ;;^UTILITY(U,$J,358.3,8256,2)
 ;;=Retinal Telangiectasia^268616
 ;;^UTILITY(U,$J,358.3,8257,0)
 ;;=362.60^^52^580^30
 ;;^UTILITY(U,$J,358.3,8257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8257,1,3,0)
 ;;=3^Degeneration, Periph, Retina
 ;;^UTILITY(U,$J,358.3,8257,1,4,0)
 ;;=4^362.60
 ;;^UTILITY(U,$J,358.3,8257,2)
 ;;=Peripheral Retinal Degeneration^92193
 ;;^UTILITY(U,$J,358.3,8258,0)
 ;;=362.81^^52^580^86
 ;;^UTILITY(U,$J,358.3,8258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8258,1,3,0)
 ;;=3^Retinal Hemorrhage
 ;;^UTILITY(U,$J,358.3,8258,1,4,0)
 ;;=4^362.81
 ;;^UTILITY(U,$J,358.3,8258,2)
 ;;=Retinal Hemorrhage^105587
 ;;^UTILITY(U,$J,358.3,8259,0)
 ;;=190.6^^52^580^57
 ;;^UTILITY(U,$J,358.3,8259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8259,1,3,0)
 ;;=3^Malig Choroid
 ;;^UTILITY(U,$J,358.3,8259,1,4,0)
 ;;=4^190.6
 ;;^UTILITY(U,$J,358.3,8259,2)
 ;;=Malig Neoplasm of Choroid (Primary)^267276
 ;;^UTILITY(U,$J,358.3,8260,0)
 ;;=362.33^^52^580^45
 ;;^UTILITY(U,$J,358.3,8260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8260,1,3,0)
 ;;=3^Hollenhorst Plaque
 ;;^UTILITY(U,$J,358.3,8260,1,4,0)
 ;;=4^362.33
 ;;^UTILITY(U,$J,358.3,8260,2)
 ;;=Hollenhorst Plaque^268620
 ;;^UTILITY(U,$J,358.3,8261,0)
 ;;=361.00^^52^580^84
 ;;^UTILITY(U,$J,358.3,8261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8261,1,3,0)
 ;;=3^Retinal Detachment w/ Ret Defect,Unspec
 ;;^UTILITY(U,$J,358.3,8261,1,4,0)
 ;;=4^361.00
 ;;^UTILITY(U,$J,358.3,8261,2)
 ;;=Retinal Detachment, Unspecified^268585
 ;;^UTILITY(U,$J,358.3,8262,0)
 ;;=361.01^^52^580^77
 ;;^UTILITY(U,$J,358.3,8262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8262,1,3,0)
 ;;=3^Recent Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,8262,1,4,0)
 ;;=4^361.01
 ;;^UTILITY(U,$J,358.3,8262,2)
 ;;=Recent Retinal Detachment, Partial^268586
 ;;^UTILITY(U,$J,358.3,8263,0)
 ;;=361.05^^52^580^78
 ;;^UTILITY(U,$J,358.3,8263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8263,1,3,0)
 ;;=3^Recent Retinal Detachment, Total
 ;;^UTILITY(U,$J,358.3,8263,1,4,0)
 ;;=4^361.05
 ;;^UTILITY(U,$J,358.3,8263,2)
 ;;=Recent Retinal Detachment, Total^268590
 ;;^UTILITY(U,$J,358.3,8264,0)
 ;;=361.06^^52^580^65
 ;;^UTILITY(U,$J,358.3,8264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8264,1,3,0)
 ;;=3^Old Retinal Detachment, Partial
 ;;^UTILITY(U,$J,358.3,8264,1,4,0)
 ;;=4^361.06
 ;;^UTILITY(U,$J,358.3,8264,2)
 ;;=Old Retinal Detachment, Part^268591
