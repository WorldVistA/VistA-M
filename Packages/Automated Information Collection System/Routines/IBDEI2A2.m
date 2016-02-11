IBDEI2A2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38250,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,38250,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,38250,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,38251,0)
 ;;=Z64.0^^177^1935^4
 ;;^UTILITY(U,$J,358.3,38251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38251,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,38251,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,38251,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,38252,0)
 ;;=Z64.1^^177^1935^3
 ;;^UTILITY(U,$J,358.3,38252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38252,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,38252,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,38252,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,38253,0)
 ;;=Z64.4^^177^1935^1
 ;;^UTILITY(U,$J,358.3,38253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38253,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,38253,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,38253,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,38254,0)
 ;;=Z65.5^^177^1935^2
 ;;^UTILITY(U,$J,358.3,38254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38254,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,38254,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,38254,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,38255,0)
 ;;=Z62.820^^177^1936^4
 ;;^UTILITY(U,$J,358.3,38255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38255,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,38255,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,38255,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,38256,0)
 ;;=Z62.891^^177^1936^6
 ;;^UTILITY(U,$J,358.3,38256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38256,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,38256,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,38256,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,38257,0)
 ;;=Z62.898^^177^1936^1
 ;;^UTILITY(U,$J,358.3,38257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38257,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,38257,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,38257,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,38258,0)
 ;;=Z63.0^^177^1936^5
 ;;^UTILITY(U,$J,358.3,38258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38258,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,38258,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,38258,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,38259,0)
 ;;=Z63.5^^177^1936^2
 ;;^UTILITY(U,$J,358.3,38259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38259,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,38259,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,38259,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,38260,0)
 ;;=Z63.8^^177^1936^3
 ;;^UTILITY(U,$J,358.3,38260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38260,1,3,0)
 ;;=3^High Exporessed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,38260,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,38260,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,38261,0)
 ;;=Z63.4^^177^1936^7
 ;;^UTILITY(U,$J,358.3,38261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38261,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,38261,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,38261,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,38262,0)
 ;;=F20.9^^177^1937^5
 ;;^UTILITY(U,$J,358.3,38262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38262,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,38262,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,38262,2)
 ;;=^5003476
