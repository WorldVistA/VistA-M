IBDEI0GS ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8153,0)
 ;;=362.31^^58^607^10
 ;;^UTILITY(U,$J,358.3,8153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8153,1,3,0)
 ;;=3^Central Retinal Artery Occlusion
 ;;^UTILITY(U,$J,358.3,8153,1,4,0)
 ;;=4^362.31
 ;;^UTILITY(U,$J,358.3,8153,2)
 ;;=Central Retinal Artery Occulusion^21255
 ;;^UTILITY(U,$J,358.3,8154,0)
 ;;=362.35^^58^607^11
 ;;^UTILITY(U,$J,358.3,8154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8154,1,3,0)
 ;;=3^Central Retinal Vein Occlusion
 ;;^UTILITY(U,$J,358.3,8154,1,4,0)
 ;;=4^362.35
 ;;^UTILITY(U,$J,358.3,8154,2)
 ;;=Central Retinal Vein Occlusion^268624
 ;;^UTILITY(U,$J,358.3,8155,0)
 ;;=362.41^^58^607^12
 ;;^UTILITY(U,$J,358.3,8155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8155,1,3,0)
 ;;=3^Central Serous Retinopathy (Csr)
 ;;^UTILITY(U,$J,358.3,8155,1,4,0)
 ;;=4^362.41
 ;;^UTILITY(U,$J,358.3,8155,2)
 ;;=Central Serous Retinopathy^265870
 ;;^UTILITY(U,$J,358.3,8156,0)
 ;;=224.6^^58^607^18
 ;;^UTILITY(U,$J,358.3,8156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8156,1,3,0)
 ;;=3^Choroidal Nevus
 ;;^UTILITY(U,$J,358.3,8156,1,4,0)
 ;;=4^224.6
 ;;^UTILITY(U,$J,358.3,8156,2)
 ;;=Choroidal Nevus^267676
 ;;^UTILITY(U,$J,358.3,8157,0)
 ;;=362.53^^58^607^26
 ;;^UTILITY(U,$J,358.3,8157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8157,1,3,0)
 ;;=3^Cystoid Macular Degeneration/Edema (Cme)
 ;;^UTILITY(U,$J,358.3,8157,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,8157,2)
 ;;=Cystoid Macular Degeneration/Edema^268638
 ;;^UTILITY(U,$J,358.3,8158,0)
 ;;=361.32^^58^607^46
 ;;^UTILITY(U,$J,358.3,8158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8158,1,3,0)
 ;;=3^Horseshoe Tear
 ;;^UTILITY(U,$J,358.3,8158,1,4,0)
 ;;=4^361.32
 ;;^UTILITY(U,$J,358.3,8158,2)
 ;;=^268606
 ;;^UTILITY(U,$J,358.3,8159,0)
 ;;=362.63^^58^607^49
 ;;^UTILITY(U,$J,358.3,8159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8159,1,3,0)
 ;;=3^Lattice Degeneration
 ;;^UTILITY(U,$J,358.3,8159,1,4,0)
 ;;=4^362.63
 ;;^UTILITY(U,$J,358.3,8159,2)
 ;;=^268644
 ;;^UTILITY(U,$J,358.3,8160,0)
 ;;=362.54^^58^607^54
 ;;^UTILITY(U,$J,358.3,8160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8160,1,3,0)
 ;;=3^Macular Hole
 ;;^UTILITY(U,$J,358.3,8160,1,4,0)
 ;;=4^362.54
 ;;^UTILITY(U,$J,358.3,8160,2)
 ;;=^268639
 ;;^UTILITY(U,$J,358.3,8161,0)
 ;;=362.56^^58^607^55
 ;;^UTILITY(U,$J,358.3,8161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8161,1,3,0)
 ;;=3^Macular Pucker/Epiretinal Membrane (Erm)
 ;;^UTILITY(U,$J,358.3,8161,1,4,0)
 ;;=4^362.56
 ;;^UTILITY(U,$J,358.3,8161,2)
 ;;=Macular Puckering^268641
 ;;^UTILITY(U,$J,358.3,8162,0)
 ;;=361.10^^58^607^92
 ;;^UTILITY(U,$J,358.3,8162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8162,1,3,0)
 ;;=3^Retinoschisis
 ;;^UTILITY(U,$J,358.3,8162,1,4,0)
 ;;=4^361.10
 ;;^UTILITY(U,$J,358.3,8162,2)
 ;;=^265856
 ;;^UTILITY(U,$J,358.3,8163,0)
 ;;=362.16^^58^607^90
 ;;^UTILITY(U,$J,358.3,8163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8163,1,3,0)
 ;;=3^Retinal/Subretinal Neovascularization
 ;;^UTILITY(U,$J,358.3,8163,1,4,0)
 ;;=4^362.16
 ;;^UTILITY(U,$J,358.3,8163,2)
 ;;=Subretinal Neovascularization^105601
 ;;^UTILITY(U,$J,358.3,8164,0)
 ;;=362.11^^58^607^47
 ;;^UTILITY(U,$J,358.3,8164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8164,1,3,0)
 ;;=3^Hypertensive Retinopathy
 ;;^UTILITY(U,$J,358.3,8164,1,4,0)
 ;;=4^362.11
 ;;^UTILITY(U,$J,358.3,8164,2)
 ;;=Hypertensive Retinopathy^265209
 ;;^UTILITY(U,$J,358.3,8165,0)
 ;;=363.30^^58^607^13
 ;;^UTILITY(U,$J,358.3,8165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8165,1,3,0)
 ;;=3^Chorioretinal Scar
 ;;^UTILITY(U,$J,358.3,8165,1,4,0)
 ;;=4^363.30
