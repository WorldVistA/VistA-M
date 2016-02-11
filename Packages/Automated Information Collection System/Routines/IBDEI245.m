IBDEI245 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35491,2)
 ;;=^340611
 ;;^UTILITY(U,$J,358.3,35492,0)
 ;;=O02.1^^166^1820^18
 ;;^UTILITY(U,$J,358.3,35492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35492,1,3,0)
 ;;=3^Missed abortion
 ;;^UTILITY(U,$J,358.3,35492,1,4,0)
 ;;=4^O02.1
 ;;^UTILITY(U,$J,358.3,35492,2)
 ;;=^1259
 ;;^UTILITY(U,$J,358.3,35493,0)
 ;;=O00.8^^166^1820^15
 ;;^UTILITY(U,$J,358.3,35493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35493,1,3,0)
 ;;=3^Ectopic Pregnancy NEC
 ;;^UTILITY(U,$J,358.3,35493,1,4,0)
 ;;=4^O00.8
 ;;^UTILITY(U,$J,358.3,35493,2)
 ;;=^5015974
 ;;^UTILITY(U,$J,358.3,35494,0)
 ;;=O08.7^^166^1820^45
 ;;^UTILITY(U,$J,358.3,35494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35494,1,3,0)
 ;;=3^Venous comp following an ectopic and molar pregnancy NEC
 ;;^UTILITY(U,$J,358.3,35494,1,4,0)
 ;;=4^O08.7
 ;;^UTILITY(U,$J,358.3,35494,2)
 ;;=^5016042
 ;;^UTILITY(U,$J,358.3,35495,0)
 ;;=O08.81^^166^1820^13
 ;;^UTILITY(U,$J,358.3,35495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35495,1,3,0)
 ;;=3^Cardiac arrest following an ectopic and molar pregnancy
 ;;^UTILITY(U,$J,358.3,35495,1,4,0)
 ;;=4^O08.81
 ;;^UTILITY(U,$J,358.3,35495,2)
 ;;=^5016043
 ;;^UTILITY(U,$J,358.3,35496,0)
 ;;=O08.83^^166^1820^44
 ;;^UTILITY(U,$J,358.3,35496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35496,1,3,0)
 ;;=3^Urinary tract infection fol an ectopic and molar pregnancy
 ;;^UTILITY(U,$J,358.3,35496,1,4,0)
 ;;=4^O08.83
 ;;^UTILITY(U,$J,358.3,35496,2)
 ;;=^5016045
 ;;^UTILITY(U,$J,358.3,35497,0)
 ;;=O08.89^^166^1820^14
 ;;^UTILITY(U,$J,358.3,35497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35497,1,3,0)
 ;;=3^Complications following an ectopic and molar pregnancy NEC
 ;;^UTILITY(U,$J,358.3,35497,1,4,0)
 ;;=4^O08.89
 ;;^UTILITY(U,$J,358.3,35497,2)
 ;;=^5016046
 ;;^UTILITY(U,$J,358.3,35498,0)
 ;;=O20.0^^166^1820^43
 ;;^UTILITY(U,$J,358.3,35498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35498,1,3,0)
 ;;=3^Threatened abortion
 ;;^UTILITY(U,$J,358.3,35498,1,4,0)
 ;;=4^O20.0
 ;;^UTILITY(U,$J,358.3,35498,2)
 ;;=^1287
 ;;^UTILITY(U,$J,358.3,35499,0)
 ;;=O44.01^^166^1820^20
 ;;^UTILITY(U,$J,358.3,35499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35499,1,3,0)
 ;;=3^Placenta previa specified as w/o hemorrhage, first trimester
 ;;^UTILITY(U,$J,358.3,35499,1,4,0)
 ;;=4^O44.01
 ;;^UTILITY(U,$J,358.3,35499,2)
 ;;=^5017437
 ;;^UTILITY(U,$J,358.3,35500,0)
 ;;=O44.02^^166^1820^19
 ;;^UTILITY(U,$J,358.3,35500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35500,1,3,0)
 ;;=3^Placenta previa specified as w/o hemor, second trimester
 ;;^UTILITY(U,$J,358.3,35500,1,4,0)
 ;;=4^O44.02
 ;;^UTILITY(U,$J,358.3,35500,2)
 ;;=^5017438
 ;;^UTILITY(U,$J,358.3,35501,0)
 ;;=O44.03^^166^1820^21
 ;;^UTILITY(U,$J,358.3,35501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35501,1,3,0)
 ;;=3^Placenta previa specified as w/o hemorrhage, third trimester
 ;;^UTILITY(U,$J,358.3,35501,1,4,0)
 ;;=4^O44.03
 ;;^UTILITY(U,$J,358.3,35501,2)
 ;;=^5017439
 ;;^UTILITY(U,$J,358.3,35502,0)
 ;;=O44.11^^166^1820^22
 ;;^UTILITY(U,$J,358.3,35502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35502,1,3,0)
 ;;=3^Placenta previa with hemorrhage, first trimester
 ;;^UTILITY(U,$J,358.3,35502,1,4,0)
 ;;=4^O44.11
 ;;^UTILITY(U,$J,358.3,35502,2)
 ;;=^5017441
 ;;^UTILITY(U,$J,358.3,35503,0)
 ;;=O44.12^^166^1820^23
 ;;^UTILITY(U,$J,358.3,35503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35503,1,3,0)
 ;;=3^Placenta previa with hemorrhage, second trimester
 ;;^UTILITY(U,$J,358.3,35503,1,4,0)
 ;;=4^O44.12
 ;;^UTILITY(U,$J,358.3,35503,2)
 ;;=^5017442
 ;;^UTILITY(U,$J,358.3,35504,0)
 ;;=O44.13^^166^1820^24
