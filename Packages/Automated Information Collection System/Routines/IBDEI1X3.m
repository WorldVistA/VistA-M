IBDEI1X3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32106,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32106,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,32106,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,32107,0)
 ;;=Z65.4^^141^1494^4
 ;;^UTILITY(U,$J,358.3,32107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32107,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,32107,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,32107,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,32108,0)
 ;;=Z65.0^^141^1494^1
 ;;^UTILITY(U,$J,358.3,32108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32108,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,32108,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,32108,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,32109,0)
 ;;=Z65.2^^141^1494^3
 ;;^UTILITY(U,$J,358.3,32109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32109,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,32109,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,32109,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,32110,0)
 ;;=Z65.3^^141^1494^2
 ;;^UTILITY(U,$J,358.3,32110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32110,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,32110,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,32110,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,32111,0)
 ;;=Z65.8^^141^1495^5
 ;;^UTILITY(U,$J,358.3,32111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32111,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,32111,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,32111,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,32112,0)
 ;;=Z64.0^^141^1495^4
 ;;^UTILITY(U,$J,358.3,32112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32112,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,32112,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,32112,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,32113,0)
 ;;=Z64.1^^141^1495^3
 ;;^UTILITY(U,$J,358.3,32113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32113,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,32113,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,32113,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,32114,0)
 ;;=Z64.4^^141^1495^1
 ;;^UTILITY(U,$J,358.3,32114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32114,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,32114,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,32114,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,32115,0)
 ;;=Z65.5^^141^1495^2
 ;;^UTILITY(U,$J,358.3,32115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32115,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,32115,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,32115,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,32116,0)
 ;;=Z62.820^^141^1496^4
 ;;^UTILITY(U,$J,358.3,32116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32116,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,32116,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,32116,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,32117,0)
 ;;=Z62.891^^141^1496^6
 ;;^UTILITY(U,$J,358.3,32117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32117,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,32117,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,32117,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,32118,0)
 ;;=Z62.898^^141^1496^1
 ;;^UTILITY(U,$J,358.3,32118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32118,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
