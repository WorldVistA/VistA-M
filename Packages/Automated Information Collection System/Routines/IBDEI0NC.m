IBDEI0NC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10513,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,10513,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,10513,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,10514,0)
 ;;=Z69.021^^42^469^18
 ;;^UTILITY(U,$J,358.3,10514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10514,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,10514,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,10514,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,10515,0)
 ;;=Z69.021^^42^469^19
 ;;^UTILITY(U,$J,358.3,10515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10515,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,10515,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,10515,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,10516,0)
 ;;=Z69.021^^42^469^20
 ;;^UTILITY(U,$J,358.3,10516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10516,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,10516,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,10516,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,10517,0)
 ;;=Z69.021^^42^469^21
 ;;^UTILITY(U,$J,358.3,10517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10517,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,10517,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,10517,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,10518,0)
 ;;=Z69.011^^42^469^23
 ;;^UTILITY(U,$J,358.3,10518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10518,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,10518,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,10518,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,10519,0)
 ;;=Z69.011^^42^469^24
 ;;^UTILITY(U,$J,358.3,10519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10519,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,10519,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,10519,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,10520,0)
 ;;=Z69.011^^42^469^25
 ;;^UTILITY(U,$J,358.3,10520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10520,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,10520,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,10520,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,10521,0)
 ;;=Z69.011^^42^469^26
 ;;^UTILITY(U,$J,358.3,10521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10521,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,10521,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,10521,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,10522,0)
 ;;=Z69.12^^42^469^17
 ;;^UTILITY(U,$J,358.3,10522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10522,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,10522,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,10522,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,10523,0)
 ;;=Z69.12^^42^469^28
 ;;^UTILITY(U,$J,358.3,10523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10523,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,10523,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,10523,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,10524,0)
 ;;=Z69.12^^42^469^29
 ;;^UTILITY(U,$J,358.3,10524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10524,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
