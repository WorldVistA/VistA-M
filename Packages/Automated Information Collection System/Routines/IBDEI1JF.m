IBDEI1JF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26096,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26096,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,26096,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,26097,0)
 ;;=Z65.4^^98^1229^4
 ;;^UTILITY(U,$J,358.3,26097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26097,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,26097,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,26097,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,26098,0)
 ;;=Z65.0^^98^1229^1
 ;;^UTILITY(U,$J,358.3,26098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26098,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,26098,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,26098,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,26099,0)
 ;;=Z65.2^^98^1229^3
 ;;^UTILITY(U,$J,358.3,26099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26099,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,26099,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,26099,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,26100,0)
 ;;=Z65.3^^98^1229^2
 ;;^UTILITY(U,$J,358.3,26100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26100,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,26100,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,26100,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,26101,0)
 ;;=Z65.8^^98^1230^5
 ;;^UTILITY(U,$J,358.3,26101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26101,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,26101,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,26101,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,26102,0)
 ;;=Z64.0^^98^1230^4
 ;;^UTILITY(U,$J,358.3,26102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26102,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,26102,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,26102,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,26103,0)
 ;;=Z64.1^^98^1230^3
 ;;^UTILITY(U,$J,358.3,26103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26103,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,26103,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,26103,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,26104,0)
 ;;=Z64.4^^98^1230^1
 ;;^UTILITY(U,$J,358.3,26104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26104,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,26104,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,26104,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,26105,0)
 ;;=Z65.5^^98^1230^2
 ;;^UTILITY(U,$J,358.3,26105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26105,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,26105,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,26105,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,26106,0)
 ;;=Z62.820^^98^1231^4
 ;;^UTILITY(U,$J,358.3,26106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26106,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,26106,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,26106,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,26107,0)
 ;;=Z62.891^^98^1231^6
 ;;^UTILITY(U,$J,358.3,26107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26107,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,26107,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,26107,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,26108,0)
 ;;=Z62.898^^98^1231^1
 ;;^UTILITY(U,$J,358.3,26108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26108,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
