IBDEI0TB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13042,1,3,0)
 ;;=3^Incisional Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,13042,1,4,0)
 ;;=4^K43.0
 ;;^UTILITY(U,$J,358.3,13042,2)
 ;;=^5008607
 ;;^UTILITY(U,$J,358.3,13043,0)
 ;;=K43.1^^80^793^22
 ;;^UTILITY(U,$J,358.3,13043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13043,1,3,0)
 ;;=3^Incisional Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,13043,1,4,0)
 ;;=4^K43.1
 ;;^UTILITY(U,$J,358.3,13043,2)
 ;;=^5008608
 ;;^UTILITY(U,$J,358.3,13044,0)
 ;;=K43.2^^80^793^24
 ;;^UTILITY(U,$J,358.3,13044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13044,1,3,0)
 ;;=3^Incisional Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,13044,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,13044,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,13045,0)
 ;;=K43.3^^80^793^26
 ;;^UTILITY(U,$J,358.3,13045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13045,1,3,0)
 ;;=3^Parastomal Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,13045,1,4,0)
 ;;=4^K43.3
 ;;^UTILITY(U,$J,358.3,13045,2)
 ;;=^5008610
 ;;^UTILITY(U,$J,358.3,13046,0)
 ;;=K43.4^^80^793^25
 ;;^UTILITY(U,$J,358.3,13046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13046,1,3,0)
 ;;=3^Parastomal Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,13046,1,4,0)
 ;;=4^K43.4
 ;;^UTILITY(U,$J,358.3,13046,2)
 ;;=^5008611
 ;;^UTILITY(U,$J,358.3,13047,0)
 ;;=K43.5^^80^793^27
 ;;^UTILITY(U,$J,358.3,13047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13047,1,3,0)
 ;;=3^Parastomal Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,13047,1,4,0)
 ;;=4^K43.5
 ;;^UTILITY(U,$J,358.3,13047,2)
 ;;=^5008612
 ;;^UTILITY(U,$J,358.3,13048,0)
 ;;=K43.6^^80^793^44
 ;;^UTILITY(U,$J,358.3,13048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13048,1,3,0)
 ;;=3^Ventral Hernia w/ Obs w/o Gangrene,Other and Unspec
 ;;^UTILITY(U,$J,358.3,13048,1,4,0)
 ;;=4^K43.6
 ;;^UTILITY(U,$J,358.3,13048,2)
 ;;=^5008613
 ;;^UTILITY(U,$J,358.3,13049,0)
 ;;=K43.7^^80^793^43
 ;;^UTILITY(U,$J,358.3,13049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13049,1,3,0)
 ;;=3^Ventral Hernia w/ Gangrene,Other and Unspec
 ;;^UTILITY(U,$J,358.3,13049,1,4,0)
 ;;=4^K43.7
 ;;^UTILITY(U,$J,358.3,13049,2)
 ;;=^5008614
 ;;^UTILITY(U,$J,358.3,13050,0)
 ;;=K43.9^^80^793^45
 ;;^UTILITY(U,$J,358.3,13050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13050,1,3,0)
 ;;=3^Ventral Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,13050,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,13050,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,13051,0)
 ;;=K44.0^^80^793^20
 ;;^UTILITY(U,$J,358.3,13051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13051,1,3,0)
 ;;=3^Diaphragmatic Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,13051,1,4,0)
 ;;=4^K44.0
 ;;^UTILITY(U,$J,358.3,13051,2)
 ;;=^5008616
 ;;^UTILITY(U,$J,358.3,13052,0)
 ;;=K44.1^^80^793^19
 ;;^UTILITY(U,$J,358.3,13052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13052,1,3,0)
 ;;=3^Diaphragmatic Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,13052,1,4,0)
 ;;=4^K44.1
 ;;^UTILITY(U,$J,358.3,13052,2)
 ;;=^270225
 ;;^UTILITY(U,$J,358.3,13053,0)
 ;;=K44.9^^80^793^21
 ;;^UTILITY(U,$J,358.3,13053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13053,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,13053,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,13053,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,13054,0)
 ;;=K45.0^^80^793^3
 ;;^UTILITY(U,$J,358.3,13054,1,0)
 ;;=^358.31IA^4^2
