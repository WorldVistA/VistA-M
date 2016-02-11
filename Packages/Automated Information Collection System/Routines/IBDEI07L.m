IBDEI07L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2979,1,4,0)
 ;;=4^K76.9
 ;;^UTILITY(U,$J,358.3,2979,2)
 ;;=^5008836
 ;;^UTILITY(U,$J,358.3,2980,0)
 ;;=K74.60^^28^245^39
 ;;^UTILITY(U,$J,358.3,2980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2980,1,3,0)
 ;;=3^Hepatic Cirrhosis,Unspec
 ;;^UTILITY(U,$J,358.3,2980,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,2980,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,2981,0)
 ;;=K72.01^^28^245^40
 ;;^UTILITY(U,$J,358.3,2981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2981,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/ Coma
 ;;^UTILITY(U,$J,358.3,2981,1,4,0)
 ;;=4^K72.01
 ;;^UTILITY(U,$J,358.3,2981,2)
 ;;=^5008806
 ;;^UTILITY(U,$J,358.3,2982,0)
 ;;=K72.00^^28^245^41
 ;;^UTILITY(U,$J,358.3,2982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2982,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/o Coma
 ;;^UTILITY(U,$J,358.3,2982,1,4,0)
 ;;=4^K72.00
 ;;^UTILITY(U,$J,358.3,2982,2)
 ;;=^5008805
 ;;^UTILITY(U,$J,358.3,2983,0)
 ;;=K72.11^^28^245^42
 ;;^UTILITY(U,$J,358.3,2983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2983,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/ Coma
 ;;^UTILITY(U,$J,358.3,2983,1,4,0)
 ;;=4^K72.11
 ;;^UTILITY(U,$J,358.3,2983,2)
 ;;=^5008808
 ;;^UTILITY(U,$J,358.3,2984,0)
 ;;=K72.10^^28^245^43
 ;;^UTILITY(U,$J,358.3,2984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2984,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/o Coma
 ;;^UTILITY(U,$J,358.3,2984,1,4,0)
 ;;=4^K72.10
 ;;^UTILITY(U,$J,358.3,2984,2)
 ;;=^5008807
 ;;^UTILITY(U,$J,358.3,2985,0)
 ;;=K72.91^^28^245^44
 ;;^UTILITY(U,$J,358.3,2985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2985,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/ Coma
 ;;^UTILITY(U,$J,358.3,2985,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,2985,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,2986,0)
 ;;=K72.90^^28^245^45
 ;;^UTILITY(U,$J,358.3,2986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2986,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/o Coma
 ;;^UTILITY(U,$J,358.3,2986,1,4,0)
 ;;=4^K72.90
 ;;^UTILITY(U,$J,358.3,2986,2)
 ;;=^5008809
 ;;^UTILITY(U,$J,358.3,2987,0)
 ;;=K73.9^^28^245^50
 ;;^UTILITY(U,$J,358.3,2987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2987,1,3,0)
 ;;=3^Hepatitis,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,2987,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,2987,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,2988,0)
 ;;=K45.8^^28^245^52
 ;;^UTILITY(U,$J,358.3,2988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2988,1,3,0)
 ;;=3^Hernia,Abdominal w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,2988,1,4,0)
 ;;=4^K45.8
 ;;^UTILITY(U,$J,358.3,2988,2)
 ;;=^5008620
 ;;^UTILITY(U,$J,358.3,2989,0)
 ;;=K45.0^^28^245^51
 ;;^UTILITY(U,$J,358.3,2989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2989,1,3,0)
 ;;=3^Hernia,Abdominal w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2989,1,4,0)
 ;;=4^K45.0
 ;;^UTILITY(U,$J,358.3,2989,2)
 ;;=^5008618
 ;;^UTILITY(U,$J,358.3,2990,0)
 ;;=K41.00^^28^245^53
 ;;^UTILITY(U,$J,358.3,2990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2990,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/ Obstructions w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2990,1,4,0)
 ;;=4^K41.00
 ;;^UTILITY(U,$J,358.3,2990,2)
 ;;=^5008593
 ;;^UTILITY(U,$J,358.3,2991,0)
 ;;=K40.20^^28^245^54
 ;;^UTILITY(U,$J,358.3,2991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2991,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,2991,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,2991,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,2992,0)
 ;;=K42.0^^28^245^55
 ;;^UTILITY(U,$J,358.3,2992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2992,1,3,0)
 ;;=3^Hernia,Umbilical w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2992,1,4,0)
 ;;=4^K42.0
