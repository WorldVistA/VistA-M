IBDEI1Q1 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27512,1,3,0)
 ;;=3^Personal Hx of Adult Psychological Abuse
 ;;^UTILITY(U,$J,358.3,27512,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,27512,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,27513,0)
 ;;=Z69.021^^113^1337^20
 ;;^UTILITY(U,$J,358.3,27513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27513,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,27513,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,27513,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,27514,0)
 ;;=Z69.011^^113^1337^22
 ;;^UTILITY(U,$J,358.3,27514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27514,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,27514,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,27514,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,27515,0)
 ;;=Z69.12^^113^1337^19
 ;;^UTILITY(U,$J,358.3,27515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27515,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Abuse
 ;;^UTILITY(U,$J,358.3,27515,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,27515,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,27516,0)
 ;;=Z62.812^^113^1337^28
 ;;^UTILITY(U,$J,358.3,27516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27516,1,3,0)
 ;;=3^Personal Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,27516,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,27516,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,27517,0)
 ;;=Z62.810^^113^1337^29
 ;;^UTILITY(U,$J,358.3,27517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27517,1,3,0)
 ;;=3^Personal Hx of Childhood Physical & Sexual Abuse
 ;;^UTILITY(U,$J,358.3,27517,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,27517,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,27518,0)
 ;;=Z62.811^^113^1337^30
 ;;^UTILITY(U,$J,358.3,27518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27518,1,3,0)
 ;;=3^Personal Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,27518,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,27518,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,27519,0)
 ;;=T76.51XA^^113^1337^1
 ;;^UTILITY(U,$J,358.3,27519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27519,1,3,0)
 ;;=3^Adult Forced Sexual Exploitation,Suspected,Init Enctr
 ;;^UTILITY(U,$J,358.3,27519,1,4,0)
 ;;=4^T76.51XA
 ;;^UTILITY(U,$J,358.3,27519,2)
 ;;=^5157572
 ;;^UTILITY(U,$J,358.3,27520,0)
 ;;=T76.51XD^^113^1337^2
 ;;^UTILITY(U,$J,358.3,27520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27520,1,3,0)
 ;;=3^Adult Forced Sexual Exploitation,Suspected,Subs Enctr
 ;;^UTILITY(U,$J,358.3,27520,1,4,0)
 ;;=4^T76.51XD
 ;;^UTILITY(U,$J,358.3,27520,2)
 ;;=^5157573
 ;;^UTILITY(U,$J,358.3,27521,0)
 ;;=Z91.42^^113^1337^31
 ;;^UTILITY(U,$J,358.3,27521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27521,1,3,0)
 ;;=3^Personal Hx of Forced Labor/Sexual Exploitation
 ;;^UTILITY(U,$J,358.3,27521,1,4,0)
 ;;=4^Z91.42
 ;;^UTILITY(U,$J,358.3,27521,2)
 ;;=^5157633
 ;;^UTILITY(U,$J,358.3,27522,0)
 ;;=Z62.813^^113^1337^32
 ;;^UTILITY(U,$J,358.3,27522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27522,1,3,0)
 ;;=3^Personal Hx of Forced Labor/Sexual Exploitation in Childhood
 ;;^UTILITY(U,$J,358.3,27522,1,4,0)
 ;;=4^Z62.813
 ;;^UTILITY(U,$J,358.3,27522,2)
 ;;=^5157627
 ;;^UTILITY(U,$J,358.3,27523,0)
 ;;=F06.4^^113^1338^3
 ;;^UTILITY(U,$J,358.3,27523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27523,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,27523,1,4,0)
 ;;=4^F06.4
