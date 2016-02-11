IBDEI02D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,340,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,340,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=Z65.3^^3^43^2
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,341,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,341,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=Z65.8^^3^44^5
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,342,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,342,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=Z64.0^^3^44^4
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,343,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,343,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=Z64.1^^3^44^3
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,344,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=Z64.4^^3^44^1
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,345,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=Z65.5^^3^44^2
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,346,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=Z62.820^^3^45^4
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,347,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=Z62.891^^3^45^6
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,348,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=Z62.898^^3^45^1
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,349,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,349,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=Z63.0^^3^45^5
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,350,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,350,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,350,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=Z63.5^^3^45^2
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,351,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,351,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,351,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=Z63.8^^3^45^3
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,352,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,352,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,352,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=Z63.4^^3^45^7
