IBDEI0F4 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7273,0)
 ;;=361.07^^49^556^66
 ;;^UTILITY(U,$J,358.3,7273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7273,1,3,0)
 ;;=3^Old Retinal Detachment,Total/Subtotal
 ;;^UTILITY(U,$J,358.3,7273,1,4,0)
 ;;=4^361.07
 ;;^UTILITY(U,$J,358.3,7273,2)
 ;;=Old Retinal Detacment, Total^268592
 ;;^UTILITY(U,$J,358.3,7274,0)
 ;;=362.57^^49^556^35
 ;;^UTILITY(U,$J,358.3,7274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7274,1,3,0)
 ;;=3^Drusen
 ;;^UTILITY(U,$J,358.3,7274,1,4,0)
 ;;=4^362.57
 ;;^UTILITY(U,$J,358.3,7274,2)
 ;;=Drusen^105561
 ;;^UTILITY(U,$J,358.3,7275,0)
 ;;=362.55^^49^556^101
 ;;^UTILITY(U,$J,358.3,7275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7275,1,3,0)
 ;;=3^Toxic Maculopathy
 ;;^UTILITY(U,$J,358.3,7275,1,4,0)
 ;;=4^362.55
 ;;^UTILITY(U,$J,358.3,7275,2)
 ;;=Toxic Maculopathy^268640
 ;;^UTILITY(U,$J,358.3,7276,0)
 ;;=363.31^^49^556^99
 ;;^UTILITY(U,$J,358.3,7276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7276,1,3,0)
 ;;=3^Solar Retinopathy
 ;;^UTILITY(U,$J,358.3,7276,1,4,0)
 ;;=4^363.31
 ;;^UTILITY(U,$J,358.3,7276,2)
 ;;=Solar Retinopathy^265207
 ;;^UTILITY(U,$J,358.3,7277,0)
 ;;=363.32^^49^556^56
 ;;^UTILITY(U,$J,358.3,7277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7277,1,3,0)
 ;;=3^Macular Scars
 ;;^UTILITY(U,$J,358.3,7277,1,4,0)
 ;;=4^363.32
 ;;^UTILITY(U,$J,358.3,7277,2)
 ;;=Macular Scars^268680
 ;;^UTILITY(U,$J,358.3,7278,0)
 ;;=362.83^^49^556^53
 ;;^UTILITY(U,$J,358.3,7278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7278,1,3,0)
 ;;=3^Macular Edema (Csme)
 ;;^UTILITY(U,$J,358.3,7278,1,4,0)
 ;;=4^362.83
 ;;^UTILITY(U,$J,358.3,7278,2)
 ;;=Macular Edema (CSME)^89576
 ;;^UTILITY(U,$J,358.3,7279,0)
 ;;=362.84^^49^556^87
 ;;^UTILITY(U,$J,358.3,7279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7279,1,3,0)
 ;;=3^Retinal Ischemia
 ;;^UTILITY(U,$J,358.3,7279,1,4,0)
 ;;=4^362.84
 ;;^UTILITY(U,$J,358.3,7279,2)
 ;;=Retinal Ischemia^276868
 ;;^UTILITY(U,$J,358.3,7280,0)
 ;;=363.20^^49^556^14
 ;;^UTILITY(U,$J,358.3,7280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7280,1,3,0)
 ;;=3^Chorioretinitis
 ;;^UTILITY(U,$J,358.3,7280,1,4,0)
 ;;=4^363.20
 ;;^UTILITY(U,$J,358.3,7280,2)
 ;;=Chorioretinitis^23913
 ;;^UTILITY(U,$J,358.3,7281,0)
 ;;=115.92^^49^556^43
 ;;^UTILITY(U,$J,358.3,7281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7281,1,3,0)
 ;;=3^Histoplamosis (Pohs)
 ;;^UTILITY(U,$J,358.3,7281,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,7281,2)
 ;;=Histoplamosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,7282,0)
 ;;=363.70^^49^556^15
 ;;^UTILITY(U,$J,358.3,7282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7282,1,3,0)
 ;;=3^Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,7282,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,7282,2)
 ;;=Choroidal Detachment^276841
 ;;^UTILITY(U,$J,358.3,7283,0)
 ;;=363.63^^49^556^19
 ;;^UTILITY(U,$J,358.3,7283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7283,1,3,0)
 ;;=3^Choroidal Rupture
 ;;^UTILITY(U,$J,358.3,7283,1,4,0)
 ;;=4^363.63
 ;;^UTILITY(U,$J,358.3,7283,2)
 ;;=Choroidal Rupture^268698
 ;;^UTILITY(U,$J,358.3,7284,0)
 ;;=379.22^^49^556^5
 ;;^UTILITY(U,$J,358.3,7284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7284,1,3,0)
 ;;=3^Asteroid Hyalosis
 ;;^UTILITY(U,$J,358.3,7284,1,4,0)
 ;;=4^379.22
 ;;^UTILITY(U,$J,358.3,7284,2)
 ;;=Asteroid Hyalosis^269310
 ;;^UTILITY(U,$J,358.3,7285,0)
 ;;=379.21^^49^556^104
 ;;^UTILITY(U,$J,358.3,7285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7285,1,3,0)
 ;;=3^Vitreous Detachment/Degeneration (Pvd)
 ;;^UTILITY(U,$J,358.3,7285,1,4,0)
 ;;=4^379.21
 ;;^UTILITY(U,$J,358.3,7285,2)
 ;;=Vitreous Detachment/Degeneration^88242
