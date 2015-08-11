IBDEI0F2 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7247,2)
 ;;=Central Retinal Artery Occulusion^21255
 ;;^UTILITY(U,$J,358.3,7248,0)
 ;;=362.35^^49^556^11
 ;;^UTILITY(U,$J,358.3,7248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7248,1,3,0)
 ;;=3^Central Retinal Vein Occlusion
 ;;^UTILITY(U,$J,358.3,7248,1,4,0)
 ;;=4^362.35
 ;;^UTILITY(U,$J,358.3,7248,2)
 ;;=Central Retinal Vein Occlusion^268624
 ;;^UTILITY(U,$J,358.3,7249,0)
 ;;=362.41^^49^556^12
 ;;^UTILITY(U,$J,358.3,7249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7249,1,3,0)
 ;;=3^Central Serous Retinopathy (Csr)
 ;;^UTILITY(U,$J,358.3,7249,1,4,0)
 ;;=4^362.41
 ;;^UTILITY(U,$J,358.3,7249,2)
 ;;=Central Serous Retinopathy^265870
 ;;^UTILITY(U,$J,358.3,7250,0)
 ;;=224.6^^49^556^18
 ;;^UTILITY(U,$J,358.3,7250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7250,1,3,0)
 ;;=3^Choroidal Nevus
 ;;^UTILITY(U,$J,358.3,7250,1,4,0)
 ;;=4^224.6
 ;;^UTILITY(U,$J,358.3,7250,2)
 ;;=Choroidal Nevus^267676
 ;;^UTILITY(U,$J,358.3,7251,0)
 ;;=362.53^^49^556^26
 ;;^UTILITY(U,$J,358.3,7251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7251,1,3,0)
 ;;=3^Cystoid Macular Degeneration/Edema (Cme)
 ;;^UTILITY(U,$J,358.3,7251,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,7251,2)
 ;;=Cystoid Macular Degeneration/Edema^268638
 ;;^UTILITY(U,$J,358.3,7252,0)
 ;;=361.32^^49^556^46
 ;;^UTILITY(U,$J,358.3,7252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7252,1,3,0)
 ;;=3^Horseshoe Tear
 ;;^UTILITY(U,$J,358.3,7252,1,4,0)
 ;;=4^361.32
 ;;^UTILITY(U,$J,358.3,7252,2)
 ;;=^268606
 ;;^UTILITY(U,$J,358.3,7253,0)
 ;;=362.63^^49^556^49
 ;;^UTILITY(U,$J,358.3,7253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7253,1,3,0)
 ;;=3^Lattice Degeneration
 ;;^UTILITY(U,$J,358.3,7253,1,4,0)
 ;;=4^362.63
 ;;^UTILITY(U,$J,358.3,7253,2)
 ;;=^268644
 ;;^UTILITY(U,$J,358.3,7254,0)
 ;;=362.54^^49^556^54
 ;;^UTILITY(U,$J,358.3,7254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7254,1,3,0)
 ;;=3^Macular Hole
 ;;^UTILITY(U,$J,358.3,7254,1,4,0)
 ;;=4^362.54
 ;;^UTILITY(U,$J,358.3,7254,2)
 ;;=^268639
 ;;^UTILITY(U,$J,358.3,7255,0)
 ;;=362.56^^49^556^55
 ;;^UTILITY(U,$J,358.3,7255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7255,1,3,0)
 ;;=3^Macular Pucker/Epiretinal Membrane (Erm)
 ;;^UTILITY(U,$J,358.3,7255,1,4,0)
 ;;=4^362.56
 ;;^UTILITY(U,$J,358.3,7255,2)
 ;;=Macular Puckering^268641
 ;;^UTILITY(U,$J,358.3,7256,0)
 ;;=361.10^^49^556^92
 ;;^UTILITY(U,$J,358.3,7256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7256,1,3,0)
 ;;=3^Retinoschisis
 ;;^UTILITY(U,$J,358.3,7256,1,4,0)
 ;;=4^361.10
 ;;^UTILITY(U,$J,358.3,7256,2)
 ;;=^265856
 ;;^UTILITY(U,$J,358.3,7257,0)
 ;;=362.16^^49^556^90
 ;;^UTILITY(U,$J,358.3,7257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7257,1,3,0)
 ;;=3^Retinal/Subretinal Neovascularization
 ;;^UTILITY(U,$J,358.3,7257,1,4,0)
 ;;=4^362.16
 ;;^UTILITY(U,$J,358.3,7257,2)
 ;;=Subretinal Neovascularization^105601
 ;;^UTILITY(U,$J,358.3,7258,0)
 ;;=362.11^^49^556^47
 ;;^UTILITY(U,$J,358.3,7258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7258,1,3,0)
 ;;=3^Hypertensive Retinopathy
 ;;^UTILITY(U,$J,358.3,7258,1,4,0)
 ;;=4^362.11
 ;;^UTILITY(U,$J,358.3,7258,2)
 ;;=Hypertensive Retinopathy^265209
 ;;^UTILITY(U,$J,358.3,7259,0)
 ;;=363.30^^49^556^13
 ;;^UTILITY(U,$J,358.3,7259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7259,1,3,0)
 ;;=3^Chorioretinal Scar
 ;;^UTILITY(U,$J,358.3,7259,1,4,0)
 ;;=4^363.30
 ;;^UTILITY(U,$J,358.3,7259,2)
 ;;=Chorioretinal Scar^23910
 ;;^UTILITY(U,$J,358.3,7260,0)
 ;;=361.31^^49^556^69
 ;;^UTILITY(U,$J,358.3,7260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7260,1,3,0)
 ;;=3^Peripheral Retinal Hole
