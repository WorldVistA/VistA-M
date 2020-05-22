IBDEI1U3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29301,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,29302,0)
 ;;=F60.9^^118^1477^11
 ;;^UTILITY(U,$J,358.3,29302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29302,1,3,0)
 ;;=3^Personality D/O,Unspec
 ;;^UTILITY(U,$J,358.3,29302,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,29302,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,29303,0)
 ;;=F07.0^^118^1477^9
 ;;^UTILITY(U,$J,358.3,29303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29303,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,29303,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,29303,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,29304,0)
 ;;=Z65.4^^118^1478^5
 ;;^UTILITY(U,$J,358.3,29304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29304,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,29304,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,29304,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,29305,0)
 ;;=Z65.0^^118^1478^1
 ;;^UTILITY(U,$J,358.3,29305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29305,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,29305,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,29305,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,29306,0)
 ;;=Z65.2^^118^1478^4
 ;;^UTILITY(U,$J,358.3,29306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29306,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,29306,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,29306,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,29307,0)
 ;;=Z65.3^^118^1478^3
 ;;^UTILITY(U,$J,358.3,29307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29307,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,29307,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,29307,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,29308,0)
 ;;=Z65.1^^118^1478^2
 ;;^UTILITY(U,$J,358.3,29308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29308,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,29308,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,29308,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,29309,0)
 ;;=Z64.0^^118^1479^6
 ;;^UTILITY(U,$J,358.3,29309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29309,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,29309,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,29309,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,29310,0)
 ;;=Z64.1^^118^1479^3
 ;;^UTILITY(U,$J,358.3,29310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29310,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,29310,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,29310,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,29311,0)
 ;;=Z64.4^^118^1479^1
 ;;^UTILITY(U,$J,358.3,29311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29311,1,3,0)
 ;;=3^Discord w/ Counselors
 ;;^UTILITY(U,$J,358.3,29311,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,29311,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,29312,0)
 ;;=Z65.5^^118^1479^2
 ;;^UTILITY(U,$J,358.3,29312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29312,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,29312,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,29312,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,29313,0)
 ;;=Z65.8^^118^1479^4
 ;;^UTILITY(U,$J,358.3,29313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29313,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,29313,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,29313,2)
 ;;=^5063185
