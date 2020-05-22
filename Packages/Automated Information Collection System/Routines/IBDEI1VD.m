IBDEI1VD ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29863,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,29863,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,29863,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,29864,0)
 ;;=Z69.011^^120^1515^22
 ;;^UTILITY(U,$J,358.3,29864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29864,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,29864,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,29864,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,29865,0)
 ;;=Z69.12^^120^1515^19
 ;;^UTILITY(U,$J,358.3,29865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29865,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Abuse
 ;;^UTILITY(U,$J,358.3,29865,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,29865,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,29866,0)
 ;;=Z62.812^^120^1515^28
 ;;^UTILITY(U,$J,358.3,29866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29866,1,3,0)
 ;;=3^Personal Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,29866,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,29866,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,29867,0)
 ;;=Z62.810^^120^1515^29
 ;;^UTILITY(U,$J,358.3,29867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29867,1,3,0)
 ;;=3^Personal Hx of Childhood Physical & Sexual Abuse
 ;;^UTILITY(U,$J,358.3,29867,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,29867,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,29868,0)
 ;;=Z62.811^^120^1515^30
 ;;^UTILITY(U,$J,358.3,29868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29868,1,3,0)
 ;;=3^Personal Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,29868,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,29868,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,29869,0)
 ;;=T76.51XA^^120^1515^1
 ;;^UTILITY(U,$J,358.3,29869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29869,1,3,0)
 ;;=3^Adult Forced Sexual Exploitation,Suspected,Init Enctr
 ;;^UTILITY(U,$J,358.3,29869,1,4,0)
 ;;=4^T76.51XA
 ;;^UTILITY(U,$J,358.3,29869,2)
 ;;=^5157572
 ;;^UTILITY(U,$J,358.3,29870,0)
 ;;=T76.51XD^^120^1515^2
 ;;^UTILITY(U,$J,358.3,29870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29870,1,3,0)
 ;;=3^Adult Forced Sexual Exploitation,Suspected,Subs Enctr
 ;;^UTILITY(U,$J,358.3,29870,1,4,0)
 ;;=4^T76.51XD
 ;;^UTILITY(U,$J,358.3,29870,2)
 ;;=^5157573
 ;;^UTILITY(U,$J,358.3,29871,0)
 ;;=Z91.42^^120^1515^31
 ;;^UTILITY(U,$J,358.3,29871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29871,1,3,0)
 ;;=3^Personal Hx of Forced Labor/Sexual Exploitation
 ;;^UTILITY(U,$J,358.3,29871,1,4,0)
 ;;=4^Z91.42
 ;;^UTILITY(U,$J,358.3,29871,2)
 ;;=^5157633
 ;;^UTILITY(U,$J,358.3,29872,0)
 ;;=Z62.813^^120^1515^32
 ;;^UTILITY(U,$J,358.3,29872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29872,1,3,0)
 ;;=3^Personal Hx of Forced Labor/Sexual Exploitation in Childhood
 ;;^UTILITY(U,$J,358.3,29872,1,4,0)
 ;;=4^Z62.813
 ;;^UTILITY(U,$J,358.3,29872,2)
 ;;=^5157627
 ;;^UTILITY(U,$J,358.3,29873,0)
 ;;=F06.4^^120^1516^3
 ;;^UTILITY(U,$J,358.3,29873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29873,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,29873,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,29873,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,29874,0)
 ;;=F41.0^^120^1516^12
 ;;^UTILITY(U,$J,358.3,29874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29874,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,29874,1,4,0)
 ;;=4^F41.0
