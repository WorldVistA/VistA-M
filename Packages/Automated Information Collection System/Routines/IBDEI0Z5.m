IBDEI0Z5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16188,1,3,0)
 ;;=3^Hepatic Cirrhosis,Unspec
 ;;^UTILITY(U,$J,358.3,16188,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,16188,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,16189,0)
 ;;=K72.01^^88^843^40
 ;;^UTILITY(U,$J,358.3,16189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16189,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/ Coma
 ;;^UTILITY(U,$J,358.3,16189,1,4,0)
 ;;=4^K72.01
 ;;^UTILITY(U,$J,358.3,16189,2)
 ;;=^5008806
 ;;^UTILITY(U,$J,358.3,16190,0)
 ;;=K72.00^^88^843^41
 ;;^UTILITY(U,$J,358.3,16190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16190,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/o Coma
 ;;^UTILITY(U,$J,358.3,16190,1,4,0)
 ;;=4^K72.00
 ;;^UTILITY(U,$J,358.3,16190,2)
 ;;=^5008805
 ;;^UTILITY(U,$J,358.3,16191,0)
 ;;=K72.11^^88^843^42
 ;;^UTILITY(U,$J,358.3,16191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16191,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/ Coma
 ;;^UTILITY(U,$J,358.3,16191,1,4,0)
 ;;=4^K72.11
 ;;^UTILITY(U,$J,358.3,16191,2)
 ;;=^5008808
 ;;^UTILITY(U,$J,358.3,16192,0)
 ;;=K72.10^^88^843^43
 ;;^UTILITY(U,$J,358.3,16192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16192,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/o Coma
 ;;^UTILITY(U,$J,358.3,16192,1,4,0)
 ;;=4^K72.10
 ;;^UTILITY(U,$J,358.3,16192,2)
 ;;=^5008807
 ;;^UTILITY(U,$J,358.3,16193,0)
 ;;=K72.91^^88^843^44
 ;;^UTILITY(U,$J,358.3,16193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16193,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/ Coma
 ;;^UTILITY(U,$J,358.3,16193,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,16193,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,16194,0)
 ;;=K72.90^^88^843^45
 ;;^UTILITY(U,$J,358.3,16194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16194,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/o Coma
 ;;^UTILITY(U,$J,358.3,16194,1,4,0)
 ;;=4^K72.90
 ;;^UTILITY(U,$J,358.3,16194,2)
 ;;=^5008809
 ;;^UTILITY(U,$J,358.3,16195,0)
 ;;=K73.9^^88^843^50
 ;;^UTILITY(U,$J,358.3,16195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16195,1,3,0)
 ;;=3^Hepatitis,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,16195,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,16195,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,16196,0)
 ;;=K45.8^^88^843^52
 ;;^UTILITY(U,$J,358.3,16196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16196,1,3,0)
 ;;=3^Hernia,Abdominal w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,16196,1,4,0)
 ;;=4^K45.8
 ;;^UTILITY(U,$J,358.3,16196,2)
 ;;=^5008620
 ;;^UTILITY(U,$J,358.3,16197,0)
 ;;=K45.0^^88^843^51
 ;;^UTILITY(U,$J,358.3,16197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16197,1,3,0)
 ;;=3^Hernia,Abdominal w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,16197,1,4,0)
 ;;=4^K45.0
 ;;^UTILITY(U,$J,358.3,16197,2)
 ;;=^5008618
 ;;^UTILITY(U,$J,358.3,16198,0)
 ;;=K41.00^^88^843^53
 ;;^UTILITY(U,$J,358.3,16198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16198,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/ Obstructions w/o Gangrene
 ;;^UTILITY(U,$J,358.3,16198,1,4,0)
 ;;=4^K41.00
 ;;^UTILITY(U,$J,358.3,16198,2)
 ;;=^5008593
 ;;^UTILITY(U,$J,358.3,16199,0)
 ;;=K40.20^^88^843^54
 ;;^UTILITY(U,$J,358.3,16199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16199,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,16199,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,16199,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,16200,0)
 ;;=K42.0^^88^843^55
 ;;^UTILITY(U,$J,358.3,16200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16200,1,3,0)
 ;;=3^Hernia,Umbilical w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,16200,1,4,0)
 ;;=4^K42.0
 ;;^UTILITY(U,$J,358.3,16200,2)
 ;;=^5008605
 ;;^UTILITY(U,$J,358.3,16201,0)
 ;;=K42.9^^88^843^56
