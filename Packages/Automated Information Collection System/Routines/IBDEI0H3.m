IBDEI0H3 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8265,0)
 ;;=361.07^^52^580^66
 ;;^UTILITY(U,$J,358.3,8265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8265,1,3,0)
 ;;=3^Old Retinal Detachment,Total/Subtotal
 ;;^UTILITY(U,$J,358.3,8265,1,4,0)
 ;;=4^361.07
 ;;^UTILITY(U,$J,358.3,8265,2)
 ;;=Old Retinal Detacment, Total^268592
 ;;^UTILITY(U,$J,358.3,8266,0)
 ;;=362.57^^52^580^35
 ;;^UTILITY(U,$J,358.3,8266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8266,1,3,0)
 ;;=3^Drusen
 ;;^UTILITY(U,$J,358.3,8266,1,4,0)
 ;;=4^362.57
 ;;^UTILITY(U,$J,358.3,8266,2)
 ;;=Drusen^105561
 ;;^UTILITY(U,$J,358.3,8267,0)
 ;;=362.55^^52^580^101
 ;;^UTILITY(U,$J,358.3,8267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8267,1,3,0)
 ;;=3^Toxic Maculopathy
 ;;^UTILITY(U,$J,358.3,8267,1,4,0)
 ;;=4^362.55
 ;;^UTILITY(U,$J,358.3,8267,2)
 ;;=Toxic Maculopathy^268640
 ;;^UTILITY(U,$J,358.3,8268,0)
 ;;=363.31^^52^580^99
 ;;^UTILITY(U,$J,358.3,8268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8268,1,3,0)
 ;;=3^Solar Retinopathy
 ;;^UTILITY(U,$J,358.3,8268,1,4,0)
 ;;=4^363.31
 ;;^UTILITY(U,$J,358.3,8268,2)
 ;;=Solar Retinopathy^265207
 ;;^UTILITY(U,$J,358.3,8269,0)
 ;;=363.32^^52^580^56
 ;;^UTILITY(U,$J,358.3,8269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8269,1,3,0)
 ;;=3^Macular Scars
 ;;^UTILITY(U,$J,358.3,8269,1,4,0)
 ;;=4^363.32
 ;;^UTILITY(U,$J,358.3,8269,2)
 ;;=Macular Scars^268680
 ;;^UTILITY(U,$J,358.3,8270,0)
 ;;=362.83^^52^580^53
 ;;^UTILITY(U,$J,358.3,8270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8270,1,3,0)
 ;;=3^Macular Edema (Csme)
 ;;^UTILITY(U,$J,358.3,8270,1,4,0)
 ;;=4^362.83
 ;;^UTILITY(U,$J,358.3,8270,2)
 ;;=Macular Edema (CSME)^89576
 ;;^UTILITY(U,$J,358.3,8271,0)
 ;;=362.84^^52^580^87
 ;;^UTILITY(U,$J,358.3,8271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8271,1,3,0)
 ;;=3^Retinal Ischemia
 ;;^UTILITY(U,$J,358.3,8271,1,4,0)
 ;;=4^362.84
 ;;^UTILITY(U,$J,358.3,8271,2)
 ;;=Retinal Ischemia^276868
 ;;^UTILITY(U,$J,358.3,8272,0)
 ;;=363.20^^52^580^14
 ;;^UTILITY(U,$J,358.3,8272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8272,1,3,0)
 ;;=3^Chorioretinitis
 ;;^UTILITY(U,$J,358.3,8272,1,4,0)
 ;;=4^363.20
 ;;^UTILITY(U,$J,358.3,8272,2)
 ;;=Chorioretinitis^23913
 ;;^UTILITY(U,$J,358.3,8273,0)
 ;;=115.92^^52^580^43
 ;;^UTILITY(U,$J,358.3,8273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8273,1,3,0)
 ;;=3^Histoplamosis (Pohs)
 ;;^UTILITY(U,$J,358.3,8273,1,4,0)
 ;;=4^115.92
 ;;^UTILITY(U,$J,358.3,8273,2)
 ;;=Histoplamosis Retinitis^266905
 ;;^UTILITY(U,$J,358.3,8274,0)
 ;;=363.70^^52^580^15
 ;;^UTILITY(U,$J,358.3,8274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8274,1,3,0)
 ;;=3^Choroidal Detachment
 ;;^UTILITY(U,$J,358.3,8274,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,8274,2)
 ;;=Choroidal Detachment^276841
 ;;^UTILITY(U,$J,358.3,8275,0)
 ;;=363.63^^52^580^19
 ;;^UTILITY(U,$J,358.3,8275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8275,1,3,0)
 ;;=3^Choroidal Rupture
 ;;^UTILITY(U,$J,358.3,8275,1,4,0)
 ;;=4^363.63
 ;;^UTILITY(U,$J,358.3,8275,2)
 ;;=Choroidal Rupture^268698
 ;;^UTILITY(U,$J,358.3,8276,0)
 ;;=379.22^^52^580^5
 ;;^UTILITY(U,$J,358.3,8276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8276,1,3,0)
 ;;=3^Asteroid Hyalosis
 ;;^UTILITY(U,$J,358.3,8276,1,4,0)
 ;;=4^379.22
 ;;^UTILITY(U,$J,358.3,8276,2)
 ;;=Asteroid Hyalosis^269310
 ;;^UTILITY(U,$J,358.3,8277,0)
 ;;=379.21^^52^580^104
 ;;^UTILITY(U,$J,358.3,8277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8277,1,3,0)
 ;;=3^Vitreous Detachment/Degeneration (Pvd)
 ;;^UTILITY(U,$J,358.3,8277,1,4,0)
 ;;=4^379.21
 ;;^UTILITY(U,$J,358.3,8277,2)
 ;;=Vitreous Detachment/Degeneration^88242
