IBDEI031 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,995,1,2,0)
 ;;=2^33237
 ;;^UTILITY(U,$J,358.3,995,1,3,0)
 ;;=3^Remove Electrode/Thoracotomy Dual
 ;;^UTILITY(U,$J,358.3,996,0)
 ;;=33249^^10^103^47^^^^1
 ;;^UTILITY(U,$J,358.3,996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,996,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,996,1,3,0)
 ;;=3^Remove ICD Leads/Thoracotomy
 ;;^UTILITY(U,$J,358.3,997,0)
 ;;=92992^^10^104^1^^^^1
 ;;^UTILITY(U,$J,358.3,997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,997,1,2,0)
 ;;=2^92992
 ;;^UTILITY(U,$J,358.3,997,1,3,0)
 ;;=3^Atrial Septectomy Trans Balloon (Inc Cath)
 ;;^UTILITY(U,$J,358.3,998,0)
 ;;=92993^^10^104^21^^^^1
 ;;^UTILITY(U,$J,358.3,998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,998,1,2,0)
 ;;=2^92993
 ;;^UTILITY(U,$J,358.3,998,1,3,0)
 ;;=3^Park Septostomy,Includes Cath
 ;;^UTILITY(U,$J,358.3,999,0)
 ;;=92975^^10^104^27^^^^1
 ;;^UTILITY(U,$J,358.3,999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,999,1,2,0)
 ;;=2^92975
 ;;^UTILITY(U,$J,358.3,999,1,3,0)
 ;;=3^Thrombo Cor Includes Cor Angiog
 ;;^UTILITY(U,$J,358.3,1000,0)
 ;;=92977^^10^104^28^^^^1
 ;;^UTILITY(U,$J,358.3,1000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1000,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,1000,1,3,0)
 ;;=3^Thrombo Cor,Inc Cor Angio Iv Inf
 ;;^UTILITY(U,$J,358.3,1001,0)
 ;;=92978^^10^104^6^^^^1
 ;;^UTILITY(U,$J,358.3,1001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1001,1,2,0)
 ;;=2^92978
 ;;^UTILITY(U,$J,358.3,1001,1,3,0)
 ;;=3^Intr Vasc U/S During Diag Eval
 ;;^UTILITY(U,$J,358.3,1002,0)
 ;;=92979^^10^104^7^^^^1
 ;;^UTILITY(U,$J,358.3,1002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1002,1,2,0)
 ;;=2^92979
 ;;^UTILITY(U,$J,358.3,1002,1,3,0)
 ;;=3^     Each Add'L Vessel (W/92978)
 ;;^UTILITY(U,$J,358.3,1003,0)
 ;;=36010^^10^104^4^^^^1
 ;;^UTILITY(U,$J,358.3,1003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1003,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,1003,1,3,0)
 ;;=3^Cath Place Svc/Ivc (Sheath)
 ;;^UTILITY(U,$J,358.3,1004,0)
 ;;=36011^^10^104^5^^^^1
 ;;^UTILITY(U,$J,358.3,1004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1004,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1004,1,3,0)
 ;;=3^Cath Place Vein 1St Order(Sheath
 ;;^UTILITY(U,$J,358.3,1005,0)
 ;;=76930^^10^104^29^^^^1
 ;;^UTILITY(U,$J,358.3,1005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1005,1,2,0)
 ;;=2^76930
 ;;^UTILITY(U,$J,358.3,1005,1,3,0)
 ;;=3^U/S Guide (W/33010)
 ;;^UTILITY(U,$J,358.3,1006,0)
 ;;=76000^^10^104^2^^^^1
 ;;^UTILITY(U,$J,358.3,1006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1006,1,2,0)
 ;;=2^76000
 ;;^UTILITY(U,$J,358.3,1006,1,3,0)
 ;;=3^Cardiac Fluoro<1Hr(No Cath Proc)
 ;;^UTILITY(U,$J,358.3,1007,0)
 ;;=92973^^10^104^22^^^^1
 ;;^UTILITY(U,$J,358.3,1007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1007,1,2,0)
 ;;=2^92973
 ;;^UTILITY(U,$J,358.3,1007,1,3,0)
 ;;=3^Perc Coronary Thrombectomy Mechanical
 ;;^UTILITY(U,$J,358.3,1008,0)
 ;;=92974^^10^104^3^^^^1
 ;;^UTILITY(U,$J,358.3,1008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1008,1,2,0)
 ;;=2^92974
 ;;^UTILITY(U,$J,358.3,1008,1,3,0)
 ;;=3^Cath Place Cardio Brachytx
 ;;^UTILITY(U,$J,358.3,1009,0)
 ;;=92920^^10^104^17^^^^1
 ;;^UTILITY(U,$J,358.3,1009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1009,1,2,0)
 ;;=2^92920
 ;;^UTILITY(U,$J,358.3,1009,1,3,0)
 ;;=3^PRQ Cardia Angioplast 1 Art
 ;;^UTILITY(U,$J,358.3,1010,0)
 ;;=92921^^10^104^18^^^^1
 ;;^UTILITY(U,$J,358.3,1010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1010,1,2,0)
 ;;=2^92921
 ;;^UTILITY(U,$J,358.3,1010,1,3,0)
 ;;=3^PRQ Cardiac Angio Addl Art
 ;;^UTILITY(U,$J,358.3,1011,0)
 ;;=92924^^10^104^8^^^^1
 ;;^UTILITY(U,$J,358.3,1011,1,0)
 ;;=^358.31IA^3^2
