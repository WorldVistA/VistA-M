IBDEI0GV ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8191,1,3,0)
 ;;=3^Vitreous Detachment/Degeneration (Pvd)
 ;;^UTILITY(U,$J,358.3,8191,1,4,0)
 ;;=4^379.21
 ;;^UTILITY(U,$J,358.3,8191,2)
 ;;=Vitreous Detachment/Degeneration^88242
 ;;^UTILITY(U,$J,358.3,8192,0)
 ;;=379.24^^58^607^105
 ;;^UTILITY(U,$J,358.3,8192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8192,1,3,0)
 ;;=3^Vitreous Floaters
 ;;^UTILITY(U,$J,358.3,8192,1,4,0)
 ;;=4^379.24
 ;;^UTILITY(U,$J,358.3,8192,2)
 ;;=Vitreous Floaters^88242
 ;;^UTILITY(U,$J,358.3,8193,0)
 ;;=379.26^^58^607^107
 ;;^UTILITY(U,$J,358.3,8193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8193,1,3,0)
 ;;=3^Vitreous Prolapse
 ;;^UTILITY(U,$J,358.3,8193,1,4,0)
 ;;=4^379.26
 ;;^UTILITY(U,$J,358.3,8193,2)
 ;;=Vitreous Prolapse^269312
 ;;^UTILITY(U,$J,358.3,8194,0)
 ;;=379.23^^58^607^106
 ;;^UTILITY(U,$J,358.3,8194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8194,1,3,0)
 ;;=3^Vitreous Hemorrhage
 ;;^UTILITY(U,$J,358.3,8194,1,4,0)
 ;;=4^379.23
 ;;^UTILITY(U,$J,358.3,8194,2)
 ;;=Vitreous Hemorrhage^127096
 ;;^UTILITY(U,$J,358.3,8195,0)
 ;;=362.18^^58^607^89
 ;;^UTILITY(U,$J,358.3,8195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8195,1,3,0)
 ;;=3^Retinal Vasculitis
 ;;^UTILITY(U,$J,358.3,8195,1,4,0)
 ;;=4^362.18
 ;;^UTILITY(U,$J,358.3,8195,2)
 ;;=Retinal Vasculitis^264463
 ;;^UTILITY(U,$J,358.3,8196,0)
 ;;=360.21^^58^607^31
 ;;^UTILITY(U,$J,358.3,8196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8196,1,3,0)
 ;;=3^Degenerative Myopia
 ;;^UTILITY(U,$J,358.3,8196,1,4,0)
 ;;=4^360.21
 ;;^UTILITY(U,$J,358.3,8196,2)
 ;;=Degenerative Myopia^268553
 ;;^UTILITY(U,$J,358.3,8197,0)
 ;;=362.64^^58^607^80
 ;;^UTILITY(U,$J,358.3,8197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8197,1,3,0)
 ;;=3^Reticular Degeneration
 ;;^UTILITY(U,$J,358.3,8197,1,4,0)
 ;;=4^362.64
 ;;^UTILITY(U,$J,358.3,8197,2)
 ;;=Reticular Degeneration^268645
 ;;^UTILITY(U,$J,358.3,8198,0)
 ;;=362.61^^58^607^29
 ;;^UTILITY(U,$J,358.3,8198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8198,1,3,0)
 ;;=3^Degeneration, Paving Stone
 ;;^UTILITY(U,$J,358.3,8198,1,4,0)
 ;;=4^362.61
 ;;^UTILITY(U,$J,358.3,8198,2)
 ;;=Paving Stone Degeneration^268642
 ;;^UTILITY(U,$J,358.3,8199,0)
 ;;=362.42^^58^607^94
 ;;^UTILITY(U,$J,358.3,8199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8199,1,3,0)
 ;;=3^Rpe Detachment, Serous
 ;;^UTILITY(U,$J,358.3,8199,1,4,0)
 ;;=4^362.42
 ;;^UTILITY(U,$J,358.3,8199,2)
 ;;=Serous RPE Detachment^268633
 ;;^UTILITY(U,$J,358.3,8200,0)
 ;;=362.43^^58^607^93
 ;;^UTILITY(U,$J,358.3,8200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8200,1,3,0)
 ;;=3^Rpe Detachment, Hemorrhagic
 ;;^UTILITY(U,$J,358.3,8200,1,4,0)
 ;;=4^362.43
 ;;^UTILITY(U,$J,358.3,8200,2)
 ;;=Hemorrhagic RPE Detachment^268634
 ;;^UTILITY(U,$J,358.3,8201,0)
 ;;=250.00^^58^607^34
 ;;^UTILITY(U,$J,358.3,8201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8201,1,3,0)
 ;;=3^Dm Type II, No Retinopathy
 ;;^UTILITY(U,$J,358.3,8201,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,8201,2)
 ;;=DM Type II, No Retinopathy^33605
 ;;^UTILITY(U,$J,358.3,8202,0)
 ;;=250.01^^58^607^33
 ;;^UTILITY(U,$J,358.3,8202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8202,1,3,0)
 ;;=3^Dm Type I, No Retinopathy
 ;;^UTILITY(U,$J,358.3,8202,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,8202,2)
 ;;=DM Type I, No Retinopathy^33586
 ;;^UTILITY(U,$J,358.3,8203,0)
 ;;=250.50^^58^607^25
 ;;^UTILITY(U,$J,358.3,8203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8203,1,3,0)
 ;;=3^Csme In DM Type II
 ;;^UTILITY(U,$J,358.3,8203,1,4,0)
 ;;=4^250.50
 ;;^UTILITY(U,$J,358.3,8203,2)
 ;;=CSME in DM type II^267839^362.83
 ;;^UTILITY(U,$J,358.3,8204,0)
 ;;=250.51^^58^607^27
