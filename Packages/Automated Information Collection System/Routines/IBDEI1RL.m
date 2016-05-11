IBDEI1RL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29992,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,29993,0)
 ;;=D59.1^^118^1493^15
 ;;^UTILITY(U,$J,358.3,29993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29993,1,3,0)
 ;;=3^Autoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,29993,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,29993,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,29994,0)
 ;;=D59.0^^118^1493^17
 ;;^UTILITY(U,$J,358.3,29994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29994,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,29994,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,29994,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,29995,0)
 ;;=D59.3^^118^1493^25
 ;;^UTILITY(U,$J,358.3,29995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29995,1,3,0)
 ;;=3^Hemolytic-uremic syndrome
 ;;^UTILITY(U,$J,358.3,29995,1,4,0)
 ;;=4^D59.3
 ;;^UTILITY(U,$J,358.3,29995,2)
 ;;=^55823
 ;;^UTILITY(U,$J,358.3,29996,0)
 ;;=D59.4^^118^1493^33
 ;;^UTILITY(U,$J,358.3,29996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29996,1,3,0)
 ;;=3^Nonautoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,29996,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,29996,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,29997,0)
 ;;=D59.5^^118^1493^37
 ;;^UTILITY(U,$J,358.3,29997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29997,1,3,0)
 ;;=3^Paroxysmal nocturnal hemoglobinuria [Marchiafava-Micheli]
 ;;^UTILITY(U,$J,358.3,29997,1,4,0)
 ;;=4^D59.5
 ;;^UTILITY(U,$J,358.3,29997,2)
 ;;=^5002327
 ;;^UTILITY(U,$J,358.3,29998,0)
 ;;=D59.6^^118^1493^24
 ;;^UTILITY(U,$J,358.3,29998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29998,1,3,0)
 ;;=3^Hemoglobinuria due to hemolysis from other external causes
 ;;^UTILITY(U,$J,358.3,29998,1,4,0)
 ;;=4^D59.6
 ;;^UTILITY(U,$J,358.3,29998,2)
 ;;=^5002328
 ;;^UTILITY(U,$J,358.3,29999,0)
 ;;=D59.8^^118^1493^2
 ;;^UTILITY(U,$J,358.3,29999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29999,1,3,0)
 ;;=3^Acquired hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,29999,1,4,0)
 ;;=4^D59.8
 ;;^UTILITY(U,$J,358.3,29999,2)
 ;;=^5002329
 ;;^UTILITY(U,$J,358.3,30000,0)
 ;;=D59.9^^118^1493^1
 ;;^UTILITY(U,$J,358.3,30000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30000,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,30000,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,30000,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,30001,0)
 ;;=D61.810^^118^1493^13
 ;;^UTILITY(U,$J,358.3,30001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30001,1,3,0)
 ;;=3^Antineoplastic chemotherapy induced pancytopenia
 ;;^UTILITY(U,$J,358.3,30001,1,4,0)
 ;;=4^D61.810
 ;;^UTILITY(U,$J,358.3,30001,2)
 ;;=^5002339
 ;;^UTILITY(U,$J,358.3,30002,0)
 ;;=D61.811^^118^1493^20
 ;;^UTILITY(U,$J,358.3,30002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30002,1,3,0)
 ;;=3^Drug-induced pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,30002,1,4,0)
 ;;=4^D61.811
 ;;^UTILITY(U,$J,358.3,30002,2)
 ;;=^5002340
 ;;^UTILITY(U,$J,358.3,30003,0)
 ;;=D61.818^^118^1493^36
 ;;^UTILITY(U,$J,358.3,30003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30003,1,3,0)
 ;;=3^Pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,30003,1,4,0)
 ;;=4^D61.818
 ;;^UTILITY(U,$J,358.3,30003,2)
 ;;=^340501
 ;;^UTILITY(U,$J,358.3,30004,0)
 ;;=D61.82^^118^1493^32
 ;;^UTILITY(U,$J,358.3,30004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30004,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,30004,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,30004,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,30005,0)
 ;;=D61.9^^118^1493^14
 ;;^UTILITY(U,$J,358.3,30005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30005,1,3,0)
 ;;=3^Aplastic anemia, unspecified
