IBDEI1VV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30084,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,30084,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,30084,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,30085,0)
 ;;=Z65.4^^120^1532^5
 ;;^UTILITY(U,$J,358.3,30085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30085,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,30085,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,30085,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,30086,0)
 ;;=Z65.0^^120^1532^1
 ;;^UTILITY(U,$J,358.3,30086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30086,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,30086,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,30086,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,30087,0)
 ;;=Z65.2^^120^1532^4
 ;;^UTILITY(U,$J,358.3,30087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30087,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,30087,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,30087,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,30088,0)
 ;;=Z65.3^^120^1532^3
 ;;^UTILITY(U,$J,358.3,30088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30088,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,30088,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,30088,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,30089,0)
 ;;=Z65.1^^120^1532^2
 ;;^UTILITY(U,$J,358.3,30089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30089,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,30089,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,30089,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,30090,0)
 ;;=Z64.0^^120^1533^6
 ;;^UTILITY(U,$J,358.3,30090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30090,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,30090,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,30090,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,30091,0)
 ;;=Z64.1^^120^1533^3
 ;;^UTILITY(U,$J,358.3,30091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30091,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,30091,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,30091,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,30092,0)
 ;;=Z64.4^^120^1533^1
 ;;^UTILITY(U,$J,358.3,30092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30092,1,3,0)
 ;;=3^Discord w/ Counselors
 ;;^UTILITY(U,$J,358.3,30092,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,30092,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,30093,0)
 ;;=Z65.5^^120^1533^2
 ;;^UTILITY(U,$J,358.3,30093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30093,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,30093,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,30093,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,30094,0)
 ;;=Z65.8^^120^1533^4
 ;;^UTILITY(U,$J,358.3,30094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30094,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,30094,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,30094,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,30095,0)
 ;;=Z65.9^^120^1533^5
 ;;^UTILITY(U,$J,358.3,30095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30095,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,30095,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,30095,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,30096,0)
 ;;=Z65.4^^120^1533^7
 ;;^UTILITY(U,$J,358.3,30096,1,0)
 ;;=^358.31IA^4^2
