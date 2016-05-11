IBDEI1F9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24173,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,24173,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,24173,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,24174,0)
 ;;=F60.9^^90^1054^10
 ;;^UTILITY(U,$J,358.3,24174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24174,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24174,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,24174,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,24175,0)
 ;;=Z65.4^^90^1055^4
 ;;^UTILITY(U,$J,358.3,24175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24175,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,24175,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,24175,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,24176,0)
 ;;=Z65.0^^90^1055^1
 ;;^UTILITY(U,$J,358.3,24176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24176,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,24176,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,24176,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,24177,0)
 ;;=Z65.2^^90^1055^3
 ;;^UTILITY(U,$J,358.3,24177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24177,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,24177,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,24177,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,24178,0)
 ;;=Z65.3^^90^1055^2
 ;;^UTILITY(U,$J,358.3,24178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24178,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,24178,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,24178,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,24179,0)
 ;;=Z65.8^^90^1056^5
 ;;^UTILITY(U,$J,358.3,24179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24179,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,24179,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,24179,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,24180,0)
 ;;=Z64.0^^90^1056^4
 ;;^UTILITY(U,$J,358.3,24180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24180,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,24180,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,24180,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,24181,0)
 ;;=Z64.1^^90^1056^3
 ;;^UTILITY(U,$J,358.3,24181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24181,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,24181,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,24181,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,24182,0)
 ;;=Z64.4^^90^1056^1
 ;;^UTILITY(U,$J,358.3,24182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24182,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,24182,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,24182,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,24183,0)
 ;;=Z65.5^^90^1056^2
 ;;^UTILITY(U,$J,358.3,24183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24183,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,24183,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,24183,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,24184,0)
 ;;=Z62.820^^90^1057^4
 ;;^UTILITY(U,$J,358.3,24184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24184,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,24184,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,24184,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,24185,0)
 ;;=Z62.891^^90^1057^6
 ;;^UTILITY(U,$J,358.3,24185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24185,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,24185,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,24185,2)
 ;;=^5063161
