IBDEI0L1 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9968,1,3,0)
 ;;=3^Central Retinal Vein Occlusion
 ;;^UTILITY(U,$J,358.3,9968,1,4,0)
 ;;=4^362.35
 ;;^UTILITY(U,$J,358.3,9968,2)
 ;;=Central Retinal Vein Occlusion^268624
 ;;^UTILITY(U,$J,358.3,9969,0)
 ;;=362.41^^44^560^12
 ;;^UTILITY(U,$J,358.3,9969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9969,1,3,0)
 ;;=3^Central Serous Retinopathy (Csr)
 ;;^UTILITY(U,$J,358.3,9969,1,4,0)
 ;;=4^362.41
 ;;^UTILITY(U,$J,358.3,9969,2)
 ;;=Central Serous Retinopathy^265870
 ;;^UTILITY(U,$J,358.3,9970,0)
 ;;=224.6^^44^560^18
 ;;^UTILITY(U,$J,358.3,9970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9970,1,3,0)
 ;;=3^Choroidal Nevus
 ;;^UTILITY(U,$J,358.3,9970,1,4,0)
 ;;=4^224.6
 ;;^UTILITY(U,$J,358.3,9970,2)
 ;;=Choroidal Nevus^267676
 ;;^UTILITY(U,$J,358.3,9971,0)
 ;;=362.53^^44^560^26
 ;;^UTILITY(U,$J,358.3,9971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9971,1,3,0)
 ;;=3^Cystoid Macular Degeneration/Edema (Cme)
 ;;^UTILITY(U,$J,358.3,9971,1,4,0)
 ;;=4^362.53
 ;;^UTILITY(U,$J,358.3,9971,2)
 ;;=Cystoid Macular Degeneration/Edema^268638
 ;;^UTILITY(U,$J,358.3,9972,0)
 ;;=361.32^^44^560^46
 ;;^UTILITY(U,$J,358.3,9972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9972,1,3,0)
 ;;=3^Horseshoe Tear
 ;;^UTILITY(U,$J,358.3,9972,1,4,0)
 ;;=4^361.32
 ;;^UTILITY(U,$J,358.3,9972,2)
 ;;=^268606
 ;;^UTILITY(U,$J,358.3,9973,0)
 ;;=362.63^^44^560^49
 ;;^UTILITY(U,$J,358.3,9973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9973,1,3,0)
 ;;=3^Lattice Degeneration
 ;;^UTILITY(U,$J,358.3,9973,1,4,0)
 ;;=4^362.63
 ;;^UTILITY(U,$J,358.3,9973,2)
 ;;=^268644
 ;;^UTILITY(U,$J,358.3,9974,0)
 ;;=362.54^^44^560^54
 ;;^UTILITY(U,$J,358.3,9974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9974,1,3,0)
 ;;=3^Macular Hole
 ;;^UTILITY(U,$J,358.3,9974,1,4,0)
 ;;=4^362.54
 ;;^UTILITY(U,$J,358.3,9974,2)
 ;;=^268639
 ;;^UTILITY(U,$J,358.3,9975,0)
 ;;=362.56^^44^560^55
 ;;^UTILITY(U,$J,358.3,9975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9975,1,3,0)
 ;;=3^Macular Pucker/Epiretinal Membrane (Erm)
 ;;^UTILITY(U,$J,358.3,9975,1,4,0)
 ;;=4^362.56
 ;;^UTILITY(U,$J,358.3,9975,2)
 ;;=Macular Puckering^268641
 ;;^UTILITY(U,$J,358.3,9976,0)
 ;;=361.10^^44^560^92
 ;;^UTILITY(U,$J,358.3,9976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9976,1,3,0)
 ;;=3^Retinoschisis
 ;;^UTILITY(U,$J,358.3,9976,1,4,0)
 ;;=4^361.10
 ;;^UTILITY(U,$J,358.3,9976,2)
 ;;=^265856
 ;;^UTILITY(U,$J,358.3,9977,0)
 ;;=362.16^^44^560^90
 ;;^UTILITY(U,$J,358.3,9977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9977,1,3,0)
 ;;=3^Retinal/Subretinal Neovascularization
 ;;^UTILITY(U,$J,358.3,9977,1,4,0)
 ;;=4^362.16
 ;;^UTILITY(U,$J,358.3,9977,2)
 ;;=Subretinal Neovascularization^105601
 ;;^UTILITY(U,$J,358.3,9978,0)
 ;;=362.11^^44^560^47
 ;;^UTILITY(U,$J,358.3,9978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9978,1,3,0)
 ;;=3^Hypertensive Retinopathy
 ;;^UTILITY(U,$J,358.3,9978,1,4,0)
 ;;=4^362.11
 ;;^UTILITY(U,$J,358.3,9978,2)
 ;;=Hypertensive Retinopathy^265209
 ;;^UTILITY(U,$J,358.3,9979,0)
 ;;=363.30^^44^560^13
 ;;^UTILITY(U,$J,358.3,9979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9979,1,3,0)
 ;;=3^Chorioretinal Scar
 ;;^UTILITY(U,$J,358.3,9979,1,4,0)
 ;;=4^363.30
 ;;^UTILITY(U,$J,358.3,9979,2)
 ;;=Chorioretinal Scar^23910
 ;;^UTILITY(U,$J,358.3,9980,0)
 ;;=361.31^^44^560^69
 ;;^UTILITY(U,$J,358.3,9980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9980,1,3,0)
 ;;=3^Peripheral Retinal Hole
 ;;^UTILITY(U,$J,358.3,9980,1,4,0)
 ;;=4^361.31
 ;;^UTILITY(U,$J,358.3,9980,2)
 ;;=Peripheral Retinal Hole^268605
 ;;^UTILITY(U,$J,358.3,9981,0)
 ;;=362.51^^44^560^2
 ;;^UTILITY(U,$J,358.3,9981,1,0)
 ;;=^358.31IA^4^2
