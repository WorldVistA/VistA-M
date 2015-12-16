IBDEI1PH ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30233,1,3,0)
 ;;=3^Maternal care for damag to fts from viral dis in mother, fts5
 ;;^UTILITY(U,$J,358.3,30233,1,4,0)
 ;;=4^O35.3XX5
 ;;^UTILITY(U,$J,358.3,30233,2)
 ;;=^5016801
 ;;^UTILITY(U,$J,358.3,30234,0)
 ;;=O35.4XX0^^178^1916^86
 ;;^UTILITY(U,$J,358.3,30234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30234,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, unsp
 ;;^UTILITY(U,$J,358.3,30234,1,4,0)
 ;;=4^O35.4XX0
 ;;^UTILITY(U,$J,358.3,30234,2)
 ;;=^5016803
 ;;^UTILITY(U,$J,358.3,30235,0)
 ;;=O35.4XX1^^178^1916^87
 ;;^UTILITY(U,$J,358.3,30235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30235,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, fetus 1
 ;;^UTILITY(U,$J,358.3,30235,1,4,0)
 ;;=4^O35.4XX1
 ;;^UTILITY(U,$J,358.3,30235,2)
 ;;=^5016804
 ;;^UTILITY(U,$J,358.3,30236,0)
 ;;=O35.4XX2^^178^1916^88
 ;;^UTILITY(U,$J,358.3,30236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30236,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, fetus 2
 ;;^UTILITY(U,$J,358.3,30236,1,4,0)
 ;;=4^O35.4XX2
 ;;^UTILITY(U,$J,358.3,30236,2)
 ;;=^5016805
 ;;^UTILITY(U,$J,358.3,30237,0)
 ;;=O35.4XX3^^178^1916^89
 ;;^UTILITY(U,$J,358.3,30237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30237,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, fetus 3
 ;;^UTILITY(U,$J,358.3,30237,1,4,0)
 ;;=4^O35.4XX3
 ;;^UTILITY(U,$J,358.3,30237,2)
 ;;=^5016806
 ;;^UTILITY(U,$J,358.3,30238,0)
 ;;=O35.4XX4^^178^1916^90
 ;;^UTILITY(U,$J,358.3,30238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30238,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, fetus 4
 ;;^UTILITY(U,$J,358.3,30238,1,4,0)
 ;;=4^O35.4XX4
 ;;^UTILITY(U,$J,358.3,30238,2)
 ;;=^5016807
 ;;^UTILITY(U,$J,358.3,30239,0)
 ;;=O35.4XX5^^178^1916^91
 ;;^UTILITY(U,$J,358.3,30239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30239,1,3,0)
 ;;=3^Maternal care for damage to fetus from alcohol, fetus 5
 ;;^UTILITY(U,$J,358.3,30239,1,4,0)
 ;;=4^O35.4XX5
 ;;^UTILITY(U,$J,358.3,30239,2)
 ;;=^5016808
 ;;^UTILITY(U,$J,358.3,30240,0)
 ;;=O35.8XX0^^178^1916^140
 ;;^UTILITY(U,$J,358.3,30240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30240,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, unsp
 ;;^UTILITY(U,$J,358.3,30240,1,4,0)
 ;;=4^O35.8XX0
 ;;^UTILITY(U,$J,358.3,30240,2)
 ;;=^5016830
 ;;^UTILITY(U,$J,358.3,30241,0)
 ;;=O35.8XX1^^178^1916^141
 ;;^UTILITY(U,$J,358.3,30241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30241,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 1
 ;;^UTILITY(U,$J,358.3,30241,1,4,0)
 ;;=4^O35.8XX1
 ;;^UTILITY(U,$J,358.3,30241,2)
 ;;=^5016831
 ;;^UTILITY(U,$J,358.3,30242,0)
 ;;=O35.8XX2^^178^1916^142
 ;;^UTILITY(U,$J,358.3,30242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30242,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 2
 ;;^UTILITY(U,$J,358.3,30242,1,4,0)
 ;;=4^O35.8XX2
 ;;^UTILITY(U,$J,358.3,30242,2)
 ;;=^5016832
 ;;^UTILITY(U,$J,358.3,30243,0)
 ;;=O35.8XX3^^178^1916^143
 ;;^UTILITY(U,$J,358.3,30243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30243,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 3
 ;;^UTILITY(U,$J,358.3,30243,1,4,0)
 ;;=4^O35.8XX3
 ;;^UTILITY(U,$J,358.3,30243,2)
 ;;=^5016833
 ;;^UTILITY(U,$J,358.3,30244,0)
 ;;=O35.8XX4^^178^1916^144
 ;;^UTILITY(U,$J,358.3,30244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30244,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 4
 ;;^UTILITY(U,$J,358.3,30244,1,4,0)
 ;;=4^O35.8XX4
 ;;^UTILITY(U,$J,358.3,30244,2)
 ;;=^5016834
