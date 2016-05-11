IBDEI1HW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25378,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,25378,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,25379,0)
 ;;=F60.89^^95^1158^9
 ;;^UTILITY(U,$J,358.3,25379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25379,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,25379,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,25379,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,25380,0)
 ;;=F60.9^^95^1158^10
 ;;^UTILITY(U,$J,358.3,25380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25380,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25380,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,25380,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,25381,0)
 ;;=Z65.4^^95^1159^4
 ;;^UTILITY(U,$J,358.3,25381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25381,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,25381,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,25381,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,25382,0)
 ;;=Z65.0^^95^1159^1
 ;;^UTILITY(U,$J,358.3,25382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25382,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,25382,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,25382,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,25383,0)
 ;;=Z65.2^^95^1159^3
 ;;^UTILITY(U,$J,358.3,25383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25383,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,25383,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,25383,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,25384,0)
 ;;=Z65.3^^95^1159^2
 ;;^UTILITY(U,$J,358.3,25384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25384,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,25384,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,25384,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,25385,0)
 ;;=Z65.8^^95^1160^5
 ;;^UTILITY(U,$J,358.3,25385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25385,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,25385,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,25385,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,25386,0)
 ;;=Z64.0^^95^1160^4
 ;;^UTILITY(U,$J,358.3,25386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25386,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,25386,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,25386,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,25387,0)
 ;;=Z64.1^^95^1160^3
 ;;^UTILITY(U,$J,358.3,25387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25387,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,25387,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,25387,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,25388,0)
 ;;=Z64.4^^95^1160^1
 ;;^UTILITY(U,$J,358.3,25388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25388,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,25388,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,25388,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,25389,0)
 ;;=Z65.5^^95^1160^2
 ;;^UTILITY(U,$J,358.3,25389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25389,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,25389,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,25389,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,25390,0)
 ;;=Z62.820^^95^1161^4
 ;;^UTILITY(U,$J,358.3,25390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25390,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,25390,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,25390,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,25391,0)
 ;;=Z62.891^^95^1161^6
