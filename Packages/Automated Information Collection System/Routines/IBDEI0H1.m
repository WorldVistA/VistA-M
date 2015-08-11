IBDEI0H1 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8239,2)
 ;;=Central Retinal Artery Occulusion^21255
 ;;^UTILITY(U,$J,358.3,8240,0)
 ;;=362.35^^52^580^11
 ;;^UTILITY(U,$J,358.3,8240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8240,1,3,0)
 ;;=3^Central Retinal Vein Occlusion
 ;;^UTILITY(U,$J,358.3,8240,1,4,0)
 ;;=4^362.35
 ;;^UTILITY(U,$J,358.3,8240,2)
 ;;=Central Retinal Vein Occlusion^268624
 ;;^UTILITY(U,$J,358.3,8241,0)
 ;;=362.41^^52^580^12
 ;;^UTILITY(U,$J,358.3,8241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8241,1,3,0)
 ;;=3^Central Serous Retinopathy (Csr)
 ;;^UTILITY(U,$J,358.3,8241,1,4,0)
 ;;=4^362.41
 ;;^UTILITY(U,$J,358.3,8241,2)
 ;;=Central Serous Retinopathy^265870
 ;;^UTILITY(U,$J,358.3,8242,0)
 ;;=224.6^^52^580^18
 ;;^UTILITY(U,$J,358.3,8242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8242,1,3,0)
 ;;=3^Choroidal Nevus
 ;;^UTILITY(U,$J,358.3,8242,1,4,0)
 ;;=4^224.6
 ;;^UTILITY(U,$J,358.3,8242,2)
 ;;=Choroidal Nevus^267676
 ;;^UTILITY(U,$J,358.3,8243,0)
 ;;=362.53^^52^580^26
 ;;^UTILITY(U,$J,358.3,8243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8243,1,3,0)
 ;;=3^Cystoid Macular Degeneration/Edema (Cme)
 ;;^UTILITY(U,$J,358.3,8243,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,8243,2)
 ;;=Cystoid Macular Degeneration/Edema^268638
 ;;^UTILITY(U,$J,358.3,8244,0)
 ;;=361.32^^52^580^46
 ;;^UTILITY(U,$J,358.3,8244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8244,1,3,0)
 ;;=3^Horseshoe Tear
 ;;^UTILITY(U,$J,358.3,8244,1,4,0)
 ;;=4^361.32
 ;;^UTILITY(U,$J,358.3,8244,2)
 ;;=^268606
 ;;^UTILITY(U,$J,358.3,8245,0)
 ;;=362.63^^52^580^49
 ;;^UTILITY(U,$J,358.3,8245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8245,1,3,0)
 ;;=3^Lattice Degeneration
 ;;^UTILITY(U,$J,358.3,8245,1,4,0)
 ;;=4^362.63
 ;;^UTILITY(U,$J,358.3,8245,2)
 ;;=^268644
 ;;^UTILITY(U,$J,358.3,8246,0)
 ;;=362.54^^52^580^54
 ;;^UTILITY(U,$J,358.3,8246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8246,1,3,0)
 ;;=3^Macular Hole
 ;;^UTILITY(U,$J,358.3,8246,1,4,0)
 ;;=4^362.54
 ;;^UTILITY(U,$J,358.3,8246,2)
 ;;=^268639
 ;;^UTILITY(U,$J,358.3,8247,0)
 ;;=362.56^^52^580^55
 ;;^UTILITY(U,$J,358.3,8247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8247,1,3,0)
 ;;=3^Macular Pucker/Epiretinal Membrane (Erm)
 ;;^UTILITY(U,$J,358.3,8247,1,4,0)
 ;;=4^362.56
 ;;^UTILITY(U,$J,358.3,8247,2)
 ;;=Macular Puckering^268641
 ;;^UTILITY(U,$J,358.3,8248,0)
 ;;=361.10^^52^580^92
 ;;^UTILITY(U,$J,358.3,8248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8248,1,3,0)
 ;;=3^Retinoschisis
 ;;^UTILITY(U,$J,358.3,8248,1,4,0)
 ;;=4^361.10
 ;;^UTILITY(U,$J,358.3,8248,2)
 ;;=^265856
 ;;^UTILITY(U,$J,358.3,8249,0)
 ;;=362.16^^52^580^90
 ;;^UTILITY(U,$J,358.3,8249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8249,1,3,0)
 ;;=3^Retinal/Subretinal Neovascularization
 ;;^UTILITY(U,$J,358.3,8249,1,4,0)
 ;;=4^362.16
 ;;^UTILITY(U,$J,358.3,8249,2)
 ;;=Subretinal Neovascularization^105601
 ;;^UTILITY(U,$J,358.3,8250,0)
 ;;=362.11^^52^580^47
 ;;^UTILITY(U,$J,358.3,8250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8250,1,3,0)
 ;;=3^Hypertensive Retinopathy
 ;;^UTILITY(U,$J,358.3,8250,1,4,0)
 ;;=4^362.11
 ;;^UTILITY(U,$J,358.3,8250,2)
 ;;=Hypertensive Retinopathy^265209
 ;;^UTILITY(U,$J,358.3,8251,0)
 ;;=363.30^^52^580^13
 ;;^UTILITY(U,$J,358.3,8251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8251,1,3,0)
 ;;=3^Chorioretinal Scar
 ;;^UTILITY(U,$J,358.3,8251,1,4,0)
 ;;=4^363.30
 ;;^UTILITY(U,$J,358.3,8251,2)
 ;;=Chorioretinal Scar^23910
 ;;^UTILITY(U,$J,358.3,8252,0)
 ;;=361.31^^52^580^69
 ;;^UTILITY(U,$J,358.3,8252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8252,1,3,0)
 ;;=3^Peripheral Retinal Hole
