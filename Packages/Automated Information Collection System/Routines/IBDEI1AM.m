IBDEI1AM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20679,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,20679,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,20680,0)
 ;;=Z69.011^^95^1020^23
 ;;^UTILITY(U,$J,358.3,20680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20680,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,20680,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,20680,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,20681,0)
 ;;=Z69.011^^95^1020^24
 ;;^UTILITY(U,$J,358.3,20681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20681,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,20681,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,20681,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,20682,0)
 ;;=Z69.011^^95^1020^25
 ;;^UTILITY(U,$J,358.3,20682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20682,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,20682,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,20682,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,20683,0)
 ;;=Z69.011^^95^1020^26
 ;;^UTILITY(U,$J,358.3,20683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20683,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,20683,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,20683,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,20684,0)
 ;;=Z69.12^^95^1020^17
 ;;^UTILITY(U,$J,358.3,20684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20684,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,20684,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,20684,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,20685,0)
 ;;=Z69.12^^95^1020^28
 ;;^UTILITY(U,$J,358.3,20685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20685,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,20685,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,20685,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,20686,0)
 ;;=Z69.12^^95^1020^29
 ;;^UTILITY(U,$J,358.3,20686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20686,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,20686,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,20686,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,20687,0)
 ;;=Z69.11^^95^1020^32
 ;;^UTILITY(U,$J,358.3,20687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20687,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,20687,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,20687,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,20688,0)
 ;;=Z69.11^^95^1020^33
 ;;^UTILITY(U,$J,358.3,20688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20688,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,20688,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,20688,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,20689,0)
 ;;=Z69.11^^95^1020^34
 ;;^UTILITY(U,$J,358.3,20689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20689,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,20689,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,20689,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,20690,0)
 ;;=Z62.812^^95^1020^36
 ;;^UTILITY(U,$J,358.3,20690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20690,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,20690,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,20690,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,20691,0)
 ;;=Z62.810^^95^1020^37
