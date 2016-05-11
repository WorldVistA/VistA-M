IBDEI01U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,369,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,369,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,370,0)
 ;;=F60.9^^3^42^10
 ;;^UTILITY(U,$J,358.3,370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,370,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,370,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,370,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,371,0)
 ;;=Z65.4^^3^43^4
 ;;^UTILITY(U,$J,358.3,371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,371,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,371,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,371,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,372,0)
 ;;=Z65.0^^3^43^1
 ;;^UTILITY(U,$J,358.3,372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,372,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,372,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,372,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,373,0)
 ;;=Z65.2^^3^43^3
 ;;^UTILITY(U,$J,358.3,373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,373,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,373,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,373,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,374,0)
 ;;=Z65.3^^3^43^2
 ;;^UTILITY(U,$J,358.3,374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,374,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,374,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,374,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,375,0)
 ;;=Z65.8^^3^44^5
 ;;^UTILITY(U,$J,358.3,375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,375,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,375,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,375,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,376,0)
 ;;=Z64.0^^3^44^4
 ;;^UTILITY(U,$J,358.3,376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,376,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,376,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,376,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,377,0)
 ;;=Z64.1^^3^44^3
 ;;^UTILITY(U,$J,358.3,377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,377,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,377,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,377,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,378,0)
 ;;=Z64.4^^3^44^1
 ;;^UTILITY(U,$J,358.3,378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,378,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,378,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,378,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,379,0)
 ;;=Z65.5^^3^44^2
 ;;^UTILITY(U,$J,358.3,379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,379,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,379,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,379,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,380,0)
 ;;=Z62.820^^3^45^4
 ;;^UTILITY(U,$J,358.3,380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,380,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,380,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,380,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,381,0)
 ;;=Z62.891^^3^45^6
 ;;^UTILITY(U,$J,358.3,381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,381,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,381,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,381,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,382,0)
 ;;=Z62.898^^3^45^1
 ;;^UTILITY(U,$J,358.3,382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,382,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,382,1,4,0)
 ;;=4^Z62.898
