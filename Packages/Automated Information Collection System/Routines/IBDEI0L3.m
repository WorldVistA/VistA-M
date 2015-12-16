IBDEI0L3 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9993,2)
 ;;=Old Retinal Detacment, Total^268592
 ;;^UTILITY(U,$J,358.3,9994,0)
 ;;=362.57^^44^560^35
 ;;^UTILITY(U,$J,358.3,9994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9994,1,3,0)
 ;;=3^Drusen
 ;;^UTILITY(U,$J,358.3,9994,1,4,0)
 ;;=4^362.57
 ;;^UTILITY(U,$J,358.3,9994,2)
 ;;=Drusen^105561
 ;;^UTILITY(U,$J,358.3,9995,0)
 ;;=362.55^^44^560^101
 ;;^UTILITY(U,$J,358.3,9995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9995,1,3,0)
 ;;=3^Toxic Maculopathy
 ;;^UTILITY(U,$J,358.3,9995,1,4,0)
 ;;=4^362.55
 ;;^UTILITY(U,$J,358.3,9995,2)
 ;;=Toxic Maculopathy^268640
 ;;^UTILITY(U,$J,358.3,9996,0)
 ;;=363.31^^44^560^99
 ;;^UTILITY(U,$J,358.3,9996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9996,1,3,0)
 ;;=3^Solar Retinopathy
 ;;^UTILITY(U,$J,358.3,9996,1,4,0)
 ;;=4^363.31
 ;;^UTILITY(U,$J,358.3,9996,2)
 ;;=Solar Retinopathy^265207
 ;;^UTILITY(U,$J,358.3,9997,0)
 ;;=363.32^^44^560^56
 ;;^UTILITY(U,$J,358.3,9997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9997,1,3,0)
 ;;=3^Macular Scars
 ;;^UTILITY(U,$J,358.3,9997,1,4,0)
 ;;=4^363.32
 ;;^UTILITY(U,$J,358.3,9997,2)
 ;;=Macular Scars^268680
 ;;^UTILITY(U,$J,358.3,9998,0)
 ;;=362.83^^44^560^53
 ;;^UTILITY(U,$J,358.3,9998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9998,1,3,0)
 ;;=3^Macular Edema (Csme)
 ;;^UTILITY(U,$J,358.3,9998,1,4,0)
 ;;=4^362.83
 ;;^UTILITY(U,$J,358.3,9998,2)
 ;;=Macular Edema (CSME)^89576
 ;;^UTILITY(U,$J,358.3,9999,0)
 ;;=362.84^^44^560^87
 ;;^UTILITY(U,$J,358.3,9999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9999,1,3,0)
 ;;=3^Retinal Ischemia
 ;;^UTILITY(U,$J,358.3,9999,1,4,0)
 ;;=4^362.84
 ;;^UTILITY(U,$J,358.3,9999,2)
 ;;=Retinal Ischemia^276868
 ;;^UTILITY(U,$J,358.3,10000,0)
 ;;=363.20^^44^560^14
 ;;^UTILITY(U,$J,358.3,10000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10000,1,3,0)
 ;;=3^Chorioretinitis
 ;;^UTILITY(U,$J,358.3,10000,1,4,0)
 ;;=4^363.20
 ;;^UTILITY(U,$J,358.3,10000,2)
 ;;=Chorioretinitis^23913
 ;;^UTILITY(U,$J,358.3,10001,0)
 ;;=115.92^^44^560^43
 ;;^UTILITY(U,$J,358.3,10001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10001,1,3,0)
 ;;=3^Histoplamosis (Pohs)
 ;;^UTILITY(U,$J,358.3,10001,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,10001,2)
 ;;=Histoplamosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,10002,0)
 ;;=363.70^^44^560^15
 ;;^UTILITY(U,$J,358.3,10002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10002,1,3,0)
 ;;=3^Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,10002,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,10002,2)
 ;;=Choroidal Detachment^276841
 ;;^UTILITY(U,$J,358.3,10003,0)
 ;;=363.63^^44^560^19
 ;;^UTILITY(U,$J,358.3,10003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10003,1,3,0)
 ;;=3^Choroidal Rupture
 ;;^UTILITY(U,$J,358.3,10003,1,4,0)
 ;;=4^363.63
 ;;^UTILITY(U,$J,358.3,10003,2)
 ;;=Choroidal Rupture^268698
 ;;^UTILITY(U,$J,358.3,10004,0)
 ;;=379.22^^44^560^5
 ;;^UTILITY(U,$J,358.3,10004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10004,1,3,0)
 ;;=3^Asteroid Hyalosis
 ;;^UTILITY(U,$J,358.3,10004,1,4,0)
 ;;=4^379.22
 ;;^UTILITY(U,$J,358.3,10004,2)
 ;;=Asteroid Hyalosis^269310
 ;;^UTILITY(U,$J,358.3,10005,0)
 ;;=379.21^^44^560^104
 ;;^UTILITY(U,$J,358.3,10005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10005,1,3,0)
 ;;=3^Vitreous Detachment/Degeneration (Pvd)
 ;;^UTILITY(U,$J,358.3,10005,1,4,0)
 ;;=4^379.21
 ;;^UTILITY(U,$J,358.3,10005,2)
 ;;=Vitreous Detachment/Degeneration^88242
 ;;^UTILITY(U,$J,358.3,10006,0)
 ;;=379.24^^44^560^105
 ;;^UTILITY(U,$J,358.3,10006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10006,1,3,0)
 ;;=3^Vitreous Floaters
 ;;^UTILITY(U,$J,358.3,10006,1,4,0)
 ;;=4^379.24
