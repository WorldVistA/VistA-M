IBDEI0L4 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10006,2)
 ;;=Vitreous Floaters^88242
 ;;^UTILITY(U,$J,358.3,10007,0)
 ;;=379.26^^44^560^107
 ;;^UTILITY(U,$J,358.3,10007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10007,1,3,0)
 ;;=3^Vitreous Prolapse
 ;;^UTILITY(U,$J,358.3,10007,1,4,0)
 ;;=4^379.26
 ;;^UTILITY(U,$J,358.3,10007,2)
 ;;=Vitreous Prolapse^269312
 ;;^UTILITY(U,$J,358.3,10008,0)
 ;;=379.23^^44^560^106
 ;;^UTILITY(U,$J,358.3,10008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10008,1,3,0)
 ;;=3^Vitreous Hemorrhage
 ;;^UTILITY(U,$J,358.3,10008,1,4,0)
 ;;=4^379.23
 ;;^UTILITY(U,$J,358.3,10008,2)
 ;;=Vitreous Hemorrhage^127096
 ;;^UTILITY(U,$J,358.3,10009,0)
 ;;=362.18^^44^560^89
 ;;^UTILITY(U,$J,358.3,10009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10009,1,3,0)
 ;;=3^Retinal Vasculitis
 ;;^UTILITY(U,$J,358.3,10009,1,4,0)
 ;;=4^362.18
 ;;^UTILITY(U,$J,358.3,10009,2)
 ;;=Retinal Vasculitis^264463
 ;;^UTILITY(U,$J,358.3,10010,0)
 ;;=360.21^^44^560^31
 ;;^UTILITY(U,$J,358.3,10010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10010,1,3,0)
 ;;=3^Degenerative Myopia
 ;;^UTILITY(U,$J,358.3,10010,1,4,0)
 ;;=4^360.21
 ;;^UTILITY(U,$J,358.3,10010,2)
 ;;=Degenerative Myopia^268553
 ;;^UTILITY(U,$J,358.3,10011,0)
 ;;=362.64^^44^560^80
 ;;^UTILITY(U,$J,358.3,10011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10011,1,3,0)
 ;;=3^Reticular Degeneration
 ;;^UTILITY(U,$J,358.3,10011,1,4,0)
 ;;=4^362.64
 ;;^UTILITY(U,$J,358.3,10011,2)
 ;;=Reticular Degeneration^268645
 ;;^UTILITY(U,$J,358.3,10012,0)
 ;;=362.61^^44^560^29
 ;;^UTILITY(U,$J,358.3,10012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10012,1,3,0)
 ;;=3^Degeneration, Paving Stone
 ;;^UTILITY(U,$J,358.3,10012,1,4,0)
 ;;=4^362.61
 ;;^UTILITY(U,$J,358.3,10012,2)
 ;;=Paving Stone Degeneration^268642
 ;;^UTILITY(U,$J,358.3,10013,0)
 ;;=362.42^^44^560^94
 ;;^UTILITY(U,$J,358.3,10013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10013,1,3,0)
 ;;=3^Rpe Detachment, Serous
 ;;^UTILITY(U,$J,358.3,10013,1,4,0)
 ;;=4^362.42
 ;;^UTILITY(U,$J,358.3,10013,2)
 ;;=Serous RPE Detachment^268633
 ;;^UTILITY(U,$J,358.3,10014,0)
 ;;=362.43^^44^560^93
 ;;^UTILITY(U,$J,358.3,10014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10014,1,3,0)
 ;;=3^Rpe Detachment, Hemorrhagic
 ;;^UTILITY(U,$J,358.3,10014,1,4,0)
 ;;=4^362.43
 ;;^UTILITY(U,$J,358.3,10014,2)
 ;;=Hemorrhagic RPE Detachment^268634
 ;;^UTILITY(U,$J,358.3,10015,0)
 ;;=250.00^^44^560^34
 ;;^UTILITY(U,$J,358.3,10015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10015,1,3,0)
 ;;=3^Dm Type II, No Retinopathy
 ;;^UTILITY(U,$J,358.3,10015,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,10015,2)
 ;;=DM Type II, No Retinopathy^33605
 ;;^UTILITY(U,$J,358.3,10016,0)
 ;;=250.01^^44^560^33
 ;;^UTILITY(U,$J,358.3,10016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10016,1,3,0)
 ;;=3^Dm Type I, No Retinopathy
 ;;^UTILITY(U,$J,358.3,10016,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,10016,2)
 ;;=DM Type I, No Retinopathy^33586
 ;;^UTILITY(U,$J,358.3,10017,0)
 ;;=250.50^^44^560^25
 ;;^UTILITY(U,$J,358.3,10017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10017,1,3,0)
 ;;=3^Csme In DM Type II
 ;;^UTILITY(U,$J,358.3,10017,1,4,0)
 ;;=4^250.50
 ;;^UTILITY(U,$J,358.3,10017,2)
 ;;=CSME in DM type II^267839^362.83
 ;;^UTILITY(U,$J,358.3,10018,0)
 ;;=250.51^^44^560^27
 ;;^UTILITY(U,$J,358.3,10018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10018,1,3,0)
 ;;=3^DM Type I w/ Ophtharlmic Manifestation
 ;;^UTILITY(U,$J,358.3,10018,1,4,0)
 ;;=4^250.51
 ;;^UTILITY(U,$J,358.3,10018,2)
 ;;=CSME in DM Type I^267840^362.83
 ;;^UTILITY(U,$J,358.3,10019,0)
 ;;=362.01^^44^560^32
