IBDEI0KR ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9340,0)
 ;;=J43.2^^39^411^19
 ;;^UTILITY(U,$J,358.3,9340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9340,1,3,0)
 ;;=3^Emphysema,Centrilobular
 ;;^UTILITY(U,$J,358.3,9340,1,4,0)
 ;;=4^J43.2
 ;;^UTILITY(U,$J,358.3,9340,2)
 ;;=^5008237
 ;;^UTILITY(U,$J,358.3,9341,0)
 ;;=J43.8^^39^411^20
 ;;^UTILITY(U,$J,358.3,9341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9341,1,3,0)
 ;;=3^Emphysema,Other
 ;;^UTILITY(U,$J,358.3,9341,1,4,0)
 ;;=4^J43.8
 ;;^UTILITY(U,$J,358.3,9341,2)
 ;;=^87569
 ;;^UTILITY(U,$J,358.3,9342,0)
 ;;=J45.902^^39^411^4
 ;;^UTILITY(U,$J,358.3,9342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9342,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,9342,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,9342,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,9343,0)
 ;;=J45.901^^39^411^3
 ;;^UTILITY(U,$J,358.3,9343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9343,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec
 ;;^UTILITY(U,$J,358.3,9343,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,9343,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,9344,0)
 ;;=J47.9^^39^411^9
 ;;^UTILITY(U,$J,358.3,9344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9344,1,3,0)
 ;;=3^Bronchiectasis,Uncomplicated
 ;;^UTILITY(U,$J,358.3,9344,1,4,0)
 ;;=4^J47.9
 ;;^UTILITY(U,$J,358.3,9344,2)
 ;;=^5008260
 ;;^UTILITY(U,$J,358.3,9345,0)
 ;;=J47.1^^39^411^7
 ;;^UTILITY(U,$J,358.3,9345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9345,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,9345,1,4,0)
 ;;=4^J47.1
 ;;^UTILITY(U,$J,358.3,9345,2)
 ;;=^5008259
 ;;^UTILITY(U,$J,358.3,9346,0)
 ;;=J47.0^^39^411^8
 ;;^UTILITY(U,$J,358.3,9346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9346,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Lower Respiratory Infection
 ;;^UTILITY(U,$J,358.3,9346,1,4,0)
 ;;=4^J47.0
 ;;^UTILITY(U,$J,358.3,9346,2)
 ;;=^5008258
 ;;^UTILITY(U,$J,358.3,9347,0)
 ;;=R09.1^^39^411^37
 ;;^UTILITY(U,$J,358.3,9347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9347,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,9347,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,9347,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,9348,0)
 ;;=J94.9^^39^411^33
 ;;^UTILITY(U,$J,358.3,9348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9348,1,3,0)
 ;;=3^Pleural Condition,Unspec
 ;;^UTILITY(U,$J,358.3,9348,1,4,0)
 ;;=4^J94.9
 ;;^UTILITY(U,$J,358.3,9348,2)
 ;;=^5008320
 ;;^UTILITY(U,$J,358.3,9349,0)
 ;;=J92.9^^39^411^36
 ;;^UTILITY(U,$J,358.3,9349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9349,1,3,0)
 ;;=3^Pleural Plaque w/o Asbestos
 ;;^UTILITY(U,$J,358.3,9349,1,4,0)
 ;;=4^J92.9
 ;;^UTILITY(U,$J,358.3,9349,2)
 ;;=^5008313
 ;;^UTILITY(U,$J,358.3,9350,0)
 ;;=J94.8^^39^411^34
 ;;^UTILITY(U,$J,358.3,9350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9350,1,3,0)
 ;;=3^Pleural Conditions,Other Spec
 ;;^UTILITY(U,$J,358.3,9350,1,4,0)
 ;;=4^J94.8
 ;;^UTILITY(U,$J,358.3,9350,2)
 ;;=^5008319
 ;;^UTILITY(U,$J,358.3,9351,0)
 ;;=J86.9^^39^411^38
 ;;^UTILITY(U,$J,358.3,9351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9351,1,3,0)
 ;;=3^Pyothorax w/o Fistula
 ;;^UTILITY(U,$J,358.3,9351,1,4,0)
 ;;=4^J86.9
 ;;^UTILITY(U,$J,358.3,9351,2)
 ;;=^5008309
 ;;^UTILITY(U,$J,358.3,9352,0)
 ;;=J91.8^^39^411^35
 ;;^UTILITY(U,$J,358.3,9352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9352,1,3,0)
 ;;=3^Pleural Effusion in Other Conditions
 ;;^UTILITY(U,$J,358.3,9352,1,4,0)
 ;;=4^J91.8
