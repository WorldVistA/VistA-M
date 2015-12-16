IBDEI01S ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,278,2)
 ;;=^5002300
 ;;^UTILITY(U,$J,358.3,279,0)
 ;;=D55.8^^2^12^12
 ;;^UTILITY(U,$J,358.3,279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,279,1,3,0)
 ;;=3^Anemias due to enzyme disorders
 ;;^UTILITY(U,$J,358.3,279,1,4,0)
 ;;=4^D55.8
 ;;^UTILITY(U,$J,358.3,279,2)
 ;;=^5002303
 ;;^UTILITY(U,$J,358.3,280,0)
 ;;=D58.9^^2^12^25
 ;;^UTILITY(U,$J,358.3,280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,280,1,3,0)
 ;;=3^Hereditary hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,280,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,280,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,281,0)
 ;;=D59.1^^2^12^15
 ;;^UTILITY(U,$J,358.3,281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,281,1,3,0)
 ;;=3^Autoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,281,1,4,0)
 ;;=4^D59.1
 ;;^UTILITY(U,$J,358.3,281,2)
 ;;=^5002324
 ;;^UTILITY(U,$J,358.3,282,0)
 ;;=D59.0^^2^12^17
 ;;^UTILITY(U,$J,358.3,282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,282,1,3,0)
 ;;=3^Drug-induced autoimmune hemolytic anemia
 ;;^UTILITY(U,$J,358.3,282,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,282,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,283,0)
 ;;=D59.3^^2^12^23
 ;;^UTILITY(U,$J,358.3,283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,283,1,3,0)
 ;;=3^Hemolytic-uremic syndrome
 ;;^UTILITY(U,$J,358.3,283,1,4,0)
 ;;=4^D59.3
 ;;^UTILITY(U,$J,358.3,283,2)
 ;;=^55823
 ;;^UTILITY(U,$J,358.3,284,0)
 ;;=D59.4^^2^12^30
 ;;^UTILITY(U,$J,358.3,284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,284,1,3,0)
 ;;=3^Nonautoimmune hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,284,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,284,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,285,0)
 ;;=D59.5^^2^12^34
 ;;^UTILITY(U,$J,358.3,285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,285,1,3,0)
 ;;=3^Paroxysmal nocturnal hemoglobinuria [Marchiafava-Micheli]
 ;;^UTILITY(U,$J,358.3,285,1,4,0)
 ;;=4^D59.5
 ;;^UTILITY(U,$J,358.3,285,2)
 ;;=^5002327
 ;;^UTILITY(U,$J,358.3,286,0)
 ;;=D59.6^^2^12^22
 ;;^UTILITY(U,$J,358.3,286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,286,1,3,0)
 ;;=3^Hemoglobinuria due to hemolysis from other external causes
 ;;^UTILITY(U,$J,358.3,286,1,4,0)
 ;;=4^D59.6
 ;;^UTILITY(U,$J,358.3,286,2)
 ;;=^5002328
 ;;^UTILITY(U,$J,358.3,287,0)
 ;;=D59.8^^2^12^2
 ;;^UTILITY(U,$J,358.3,287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,287,1,3,0)
 ;;=3^Acquired hemolytic anemias NEC
 ;;^UTILITY(U,$J,358.3,287,1,4,0)
 ;;=4^D59.8
 ;;^UTILITY(U,$J,358.3,287,2)
 ;;=^5002329
 ;;^UTILITY(U,$J,358.3,288,0)
 ;;=D59.9^^2^12^1
 ;;^UTILITY(U,$J,358.3,288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,288,1,3,0)
 ;;=3^Acquired hemolytic anemia, unspecified
 ;;^UTILITY(U,$J,358.3,288,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,288,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,289,0)
 ;;=D61.810^^2^12^13
 ;;^UTILITY(U,$J,358.3,289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,289,1,3,0)
 ;;=3^Antineoplastic chemotherapy induced pancytopenia
 ;;^UTILITY(U,$J,358.3,289,1,4,0)
 ;;=4^D61.810
 ;;^UTILITY(U,$J,358.3,289,2)
 ;;=^5002339
 ;;^UTILITY(U,$J,358.3,290,0)
 ;;=D61.811^^2^12^19
 ;;^UTILITY(U,$J,358.3,290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,290,1,3,0)
 ;;=3^Drug-induced pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,290,1,4,0)
 ;;=4^D61.811
 ;;^UTILITY(U,$J,358.3,290,2)
 ;;=^5002340
 ;;^UTILITY(U,$J,358.3,291,0)
 ;;=D61.818^^2^12^33
 ;;^UTILITY(U,$J,358.3,291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,291,1,3,0)
 ;;=3^Pancytopenia NEC
 ;;^UTILITY(U,$J,358.3,291,1,4,0)
 ;;=4^D61.818
 ;;^UTILITY(U,$J,358.3,291,2)
 ;;=^340501
 ;;^UTILITY(U,$J,358.3,292,0)
 ;;=D61.82^^2^12^29
 ;;^UTILITY(U,$J,358.3,292,1,0)
 ;;=^358.31IA^4^2
