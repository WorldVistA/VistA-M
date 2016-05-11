IBDEI1TN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30946,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,30946,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,30947,0)
 ;;=Z65.2^^123^1549^3
 ;;^UTILITY(U,$J,358.3,30947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30947,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,30947,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,30947,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,30948,0)
 ;;=Z65.3^^123^1549^2
 ;;^UTILITY(U,$J,358.3,30948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30948,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,30948,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,30948,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,30949,0)
 ;;=Z65.8^^123^1550^5
 ;;^UTILITY(U,$J,358.3,30949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30949,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,30949,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,30949,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,30950,0)
 ;;=Z64.0^^123^1550^4
 ;;^UTILITY(U,$J,358.3,30950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30950,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,30950,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,30950,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,30951,0)
 ;;=Z64.1^^123^1550^3
 ;;^UTILITY(U,$J,358.3,30951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30951,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,30951,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,30951,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,30952,0)
 ;;=Z64.4^^123^1550^1
 ;;^UTILITY(U,$J,358.3,30952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30952,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,30952,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,30952,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,30953,0)
 ;;=Z65.5^^123^1550^2
 ;;^UTILITY(U,$J,358.3,30953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30953,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,30953,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,30953,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,30954,0)
 ;;=Z62.820^^123^1551^4
 ;;^UTILITY(U,$J,358.3,30954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30954,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,30954,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,30954,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,30955,0)
 ;;=Z62.891^^123^1551^6
 ;;^UTILITY(U,$J,358.3,30955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30955,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,30955,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,30955,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,30956,0)
 ;;=Z62.898^^123^1551^1
 ;;^UTILITY(U,$J,358.3,30956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30956,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
 ;;^UTILITY(U,$J,358.3,30956,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,30956,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,30957,0)
 ;;=Z63.0^^123^1551^5
 ;;^UTILITY(U,$J,358.3,30957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30957,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,30957,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,30957,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,30958,0)
 ;;=Z63.5^^123^1551^2
 ;;^UTILITY(U,$J,358.3,30958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30958,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,30958,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,30958,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,30959,0)
 ;;=Z63.8^^123^1551^3
