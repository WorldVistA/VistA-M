IBDEI1PI ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30245,0)
 ;;=O35.8XX5^^178^1916^145
 ;;^UTILITY(U,$J,358.3,30245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30245,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 5
 ;;^UTILITY(U,$J,358.3,30245,1,4,0)
 ;;=4^O35.8XX5
 ;;^UTILITY(U,$J,358.3,30245,2)
 ;;=^5016835
 ;;^UTILITY(U,$J,358.3,30246,0)
 ;;=O35.5XX0^^178^1916^73
 ;;^UTILITY(U,$J,358.3,30246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30246,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, unsp
 ;;^UTILITY(U,$J,358.3,30246,1,4,0)
 ;;=4^O35.5XX0
 ;;^UTILITY(U,$J,358.3,30246,2)
 ;;=^5016810
 ;;^UTILITY(U,$J,358.3,30247,0)
 ;;=O35.5XX1^^178^1916^74
 ;;^UTILITY(U,$J,358.3,30247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30247,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 1
 ;;^UTILITY(U,$J,358.3,30247,1,4,0)
 ;;=4^O35.5XX1
 ;;^UTILITY(U,$J,358.3,30247,2)
 ;;=^5016811
 ;;^UTILITY(U,$J,358.3,30248,0)
 ;;=O35.5XX2^^178^1916^75
 ;;^UTILITY(U,$J,358.3,30248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30248,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 2
 ;;^UTILITY(U,$J,358.3,30248,1,4,0)
 ;;=4^O35.5XX2
 ;;^UTILITY(U,$J,358.3,30248,2)
 ;;=^5016812
 ;;^UTILITY(U,$J,358.3,30249,0)
 ;;=O35.5XX3^^178^1916^76
 ;;^UTILITY(U,$J,358.3,30249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30249,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 3
 ;;^UTILITY(U,$J,358.3,30249,1,4,0)
 ;;=4^O35.5XX3
 ;;^UTILITY(U,$J,358.3,30249,2)
 ;;=^5016813
 ;;^UTILITY(U,$J,358.3,30250,0)
 ;;=O35.5XX4^^178^1916^77
 ;;^UTILITY(U,$J,358.3,30250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30250,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 4
 ;;^UTILITY(U,$J,358.3,30250,1,4,0)
 ;;=4^O35.5XX4
 ;;^UTILITY(U,$J,358.3,30250,2)
 ;;=^5016814
 ;;^UTILITY(U,$J,358.3,30251,0)
 ;;=O35.5XX5^^178^1916^78
 ;;^UTILITY(U,$J,358.3,30251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30251,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 5
 ;;^UTILITY(U,$J,358.3,30251,1,4,0)
 ;;=4^O35.5XX5
 ;;^UTILITY(U,$J,358.3,30251,2)
 ;;=^5016815
 ;;^UTILITY(U,$J,358.3,30252,0)
 ;;=O35.5XX9^^178^1916^79
 ;;^UTILITY(U,$J,358.3,30252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30252,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs NEC
 ;;^UTILITY(U,$J,358.3,30252,1,4,0)
 ;;=4^O35.5XX9
 ;;^UTILITY(U,$J,358.3,30252,2)
 ;;=^5016816
 ;;^UTILITY(U,$J,358.3,30253,0)
 ;;=O35.6XX0^^178^1916^80
 ;;^UTILITY(U,$J,358.3,30253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30253,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, unsp
 ;;^UTILITY(U,$J,358.3,30253,1,4,0)
 ;;=4^O35.6XX0
 ;;^UTILITY(U,$J,358.3,30253,2)
 ;;=^5016817
 ;;^UTILITY(U,$J,358.3,30254,0)
 ;;=O35.6XX1^^178^1916^81
 ;;^UTILITY(U,$J,358.3,30254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30254,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 1
 ;;^UTILITY(U,$J,358.3,30254,1,4,0)
 ;;=4^O35.6XX1
 ;;^UTILITY(U,$J,358.3,30254,2)
 ;;=^5016818
 ;;^UTILITY(U,$J,358.3,30255,0)
 ;;=O35.6XX2^^178^1916^82
 ;;^UTILITY(U,$J,358.3,30255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30255,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 2
 ;;^UTILITY(U,$J,358.3,30255,1,4,0)
 ;;=4^O35.6XX2
 ;;^UTILITY(U,$J,358.3,30255,2)
 ;;=^5016819
 ;;^UTILITY(U,$J,358.3,30256,0)
 ;;=O35.6XX3^^178^1916^83
 ;;^UTILITY(U,$J,358.3,30256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30256,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 3
 ;;^UTILITY(U,$J,358.3,30256,1,4,0)
 ;;=4^O35.6XX3
