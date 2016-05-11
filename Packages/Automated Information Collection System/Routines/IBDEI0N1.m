IBDEI0N1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10746,0)
 ;;=K72.01^^47^520^40
 ;;^UTILITY(U,$J,358.3,10746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10746,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/ Coma
 ;;^UTILITY(U,$J,358.3,10746,1,4,0)
 ;;=4^K72.01
 ;;^UTILITY(U,$J,358.3,10746,2)
 ;;=^5008806
 ;;^UTILITY(U,$J,358.3,10747,0)
 ;;=K72.00^^47^520^41
 ;;^UTILITY(U,$J,358.3,10747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10747,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/o Coma
 ;;^UTILITY(U,$J,358.3,10747,1,4,0)
 ;;=4^K72.00
 ;;^UTILITY(U,$J,358.3,10747,2)
 ;;=^5008805
 ;;^UTILITY(U,$J,358.3,10748,0)
 ;;=K72.11^^47^520^42
 ;;^UTILITY(U,$J,358.3,10748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10748,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/ Coma
 ;;^UTILITY(U,$J,358.3,10748,1,4,0)
 ;;=4^K72.11
 ;;^UTILITY(U,$J,358.3,10748,2)
 ;;=^5008808
 ;;^UTILITY(U,$J,358.3,10749,0)
 ;;=K72.10^^47^520^43
 ;;^UTILITY(U,$J,358.3,10749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10749,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/o Coma
 ;;^UTILITY(U,$J,358.3,10749,1,4,0)
 ;;=4^K72.10
 ;;^UTILITY(U,$J,358.3,10749,2)
 ;;=^5008807
 ;;^UTILITY(U,$J,358.3,10750,0)
 ;;=K72.91^^47^520^44
 ;;^UTILITY(U,$J,358.3,10750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10750,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/ Coma
 ;;^UTILITY(U,$J,358.3,10750,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,10750,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,10751,0)
 ;;=K72.90^^47^520^45
 ;;^UTILITY(U,$J,358.3,10751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10751,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/o Coma
 ;;^UTILITY(U,$J,358.3,10751,1,4,0)
 ;;=4^K72.90
 ;;^UTILITY(U,$J,358.3,10751,2)
 ;;=^5008809
 ;;^UTILITY(U,$J,358.3,10752,0)
 ;;=K73.9^^47^520^50
 ;;^UTILITY(U,$J,358.3,10752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10752,1,3,0)
 ;;=3^Hepatitis,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,10752,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,10752,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,10753,0)
 ;;=K45.8^^47^520^52
 ;;^UTILITY(U,$J,358.3,10753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10753,1,3,0)
 ;;=3^Hernia,Abdominal w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,10753,1,4,0)
 ;;=4^K45.8
 ;;^UTILITY(U,$J,358.3,10753,2)
 ;;=^5008620
 ;;^UTILITY(U,$J,358.3,10754,0)
 ;;=K45.0^^47^520^51
 ;;^UTILITY(U,$J,358.3,10754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10754,1,3,0)
 ;;=3^Hernia,Abdominal w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10754,1,4,0)
 ;;=4^K45.0
 ;;^UTILITY(U,$J,358.3,10754,2)
 ;;=^5008618
 ;;^UTILITY(U,$J,358.3,10755,0)
 ;;=K41.00^^47^520^53
 ;;^UTILITY(U,$J,358.3,10755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10755,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/ Obstructions w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10755,1,4,0)
 ;;=4^K41.00
 ;;^UTILITY(U,$J,358.3,10755,2)
 ;;=^5008593
 ;;^UTILITY(U,$J,358.3,10756,0)
 ;;=K40.20^^47^520^54
 ;;^UTILITY(U,$J,358.3,10756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10756,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,10756,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,10756,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,10757,0)
 ;;=K42.0^^47^520^55
 ;;^UTILITY(U,$J,358.3,10757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10757,1,3,0)
 ;;=3^Hernia,Umbilical w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10757,1,4,0)
 ;;=4^K42.0
 ;;^UTILITY(U,$J,358.3,10757,2)
 ;;=^5008605
 ;;^UTILITY(U,$J,358.3,10758,0)
 ;;=K42.9^^47^520^56
 ;;^UTILITY(U,$J,358.3,10758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10758,1,3,0)
 ;;=3^Hernia,Umbilical w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,10758,1,4,0)
 ;;=4^K42.9
