IBDEI0EJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6251,0)
 ;;=I48.19^^53^404^9
 ;;^UTILITY(U,$J,358.3,6251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6251,1,3,0)
 ;;=3^Atrial Fibrillation,Other Persistent
 ;;^UTILITY(U,$J,358.3,6251,1,4,0)
 ;;=4^I48.19
 ;;^UTILITY(U,$J,358.3,6251,2)
 ;;=^5158047
 ;;^UTILITY(U,$J,358.3,6252,0)
 ;;=I48.21^^53^404^10
 ;;^UTILITY(U,$J,358.3,6252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6252,1,3,0)
 ;;=3^Atrial Fibrillation,Permanent
 ;;^UTILITY(U,$J,358.3,6252,1,4,0)
 ;;=4^I48.21
 ;;^UTILITY(U,$J,358.3,6252,2)
 ;;=^304710
 ;;^UTILITY(U,$J,358.3,6253,0)
 ;;=I25.110^^53^405^15
 ;;^UTILITY(U,$J,358.3,6253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6253,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6253,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,6253,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,6254,0)
 ;;=I25.700^^53^405^34
 ;;^UTILITY(U,$J,358.3,6254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6254,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6254,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,6254,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,6255,0)
 ;;=I25.710^^53^405^10
 ;;^UTILITY(U,$J,358.3,6255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6255,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6255,1,4,0)
 ;;=4^I25.710
 ;;^UTILITY(U,$J,358.3,6255,2)
 ;;=^5007121
 ;;^UTILITY(U,$J,358.3,6256,0)
 ;;=I25.720^^53^405^6
 ;;^UTILITY(U,$J,358.3,6256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6256,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6256,1,4,0)
 ;;=4^I25.720
 ;;^UTILITY(U,$J,358.3,6256,2)
 ;;=^5007125
 ;;^UTILITY(U,$J,358.3,6257,0)
 ;;=I25.730^^53^405^24
 ;;^UTILITY(U,$J,358.3,6257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6257,1,3,0)
 ;;=3^Athscl Nonautologous Biological CABG w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,6257,1,4,0)
 ;;=4^I25.730
 ;;^UTILITY(U,$J,358.3,6257,2)
 ;;=^5007127
 ;;^UTILITY(U,$J,358.3,6258,0)
 ;;=I25.750^^53^405^19
 ;;^UTILITY(U,$J,358.3,6258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6258,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unstable Angina
 ;;^UTILITY(U,$J,358.3,6258,1,4,0)
 ;;=4^I25.750
 ;;^UTILITY(U,$J,358.3,6258,2)
 ;;=^5007131
 ;;^UTILITY(U,$J,358.3,6259,0)
 ;;=I25.760^^53^405^11
 ;;^UTILITY(U,$J,358.3,6259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6259,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Unstable Angina
 ;;^UTILITY(U,$J,358.3,6259,1,4,0)
 ;;=4^I25.760
 ;;^UTILITY(U,$J,358.3,6259,2)
 ;;=^5007135
 ;;^UTILITY(U,$J,358.3,6260,0)
 ;;=I25.790^^53^405^35
 ;;^UTILITY(U,$J,358.3,6260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6260,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6260,1,4,0)
 ;;=4^I25.790
 ;;^UTILITY(U,$J,358.3,6260,2)
 ;;=^5007139
 ;;^UTILITY(U,$J,358.3,6261,0)
 ;;=I20.0^^53^405^42
 ;;^UTILITY(U,$J,358.3,6261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6261,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,6261,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,6261,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,6262,0)
 ;;=I25.759^^53^405^20
 ;;^UTILITY(U,$J,358.3,6262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6262,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,6262,1,4,0)
 ;;=4^I25.759
