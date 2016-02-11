IBDEI1ZZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33449,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33449,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,33449,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,33450,0)
 ;;=Z65.4^^148^1651^4
 ;;^UTILITY(U,$J,358.3,33450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33450,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,33450,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,33450,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,33451,0)
 ;;=Z65.0^^148^1651^1
 ;;^UTILITY(U,$J,358.3,33451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33451,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,33451,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,33451,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,33452,0)
 ;;=Z65.2^^148^1651^3
 ;;^UTILITY(U,$J,358.3,33452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33452,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,33452,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,33452,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,33453,0)
 ;;=Z65.3^^148^1651^2
 ;;^UTILITY(U,$J,358.3,33453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33453,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,33453,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,33453,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,33454,0)
 ;;=Z65.8^^148^1652^5
 ;;^UTILITY(U,$J,358.3,33454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33454,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,33454,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,33454,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,33455,0)
 ;;=Z64.0^^148^1652^4
 ;;^UTILITY(U,$J,358.3,33455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33455,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,33455,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,33455,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,33456,0)
 ;;=Z64.1^^148^1652^3
 ;;^UTILITY(U,$J,358.3,33456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33456,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,33456,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,33456,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,33457,0)
 ;;=Z64.4^^148^1652^1
 ;;^UTILITY(U,$J,358.3,33457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33457,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,33457,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,33457,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,33458,0)
 ;;=Z65.5^^148^1652^2
 ;;^UTILITY(U,$J,358.3,33458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33458,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,33458,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,33458,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,33459,0)
 ;;=Z62.820^^148^1653^4
 ;;^UTILITY(U,$J,358.3,33459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33459,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,33459,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,33459,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,33460,0)
 ;;=Z62.891^^148^1653^6
 ;;^UTILITY(U,$J,358.3,33460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33460,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,33460,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,33460,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,33461,0)
 ;;=Z62.898^^148^1653^1
 ;;^UTILITY(U,$J,358.3,33461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33461,1,3,0)
 ;;=3^Child Affected by Parental Relationship Distress
