IBDEI0JL ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24810,0)
 ;;=T76.21XA^^66^993^15
 ;;^UTILITY(U,$J,358.3,24810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24810,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24810,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,24810,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,24811,0)
 ;;=T76.21XD^^66^993^16
 ;;^UTILITY(U,$J,358.3,24811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24811,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24811,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,24811,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,24812,0)
 ;;=Z69.81^^66^993^30
 ;;^UTILITY(U,$J,358.3,24812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24812,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,24812,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,24812,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,24813,0)
 ;;=Z69.82^^66^993^22
 ;;^UTILITY(U,$J,358.3,24813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24813,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,24813,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,24813,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,24814,0)
 ;;=T74.01XA^^66^993^1
 ;;^UTILITY(U,$J,358.3,24814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24814,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24814,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,24814,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,24815,0)
 ;;=T74.01XD^^66^993^2
 ;;^UTILITY(U,$J,358.3,24815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24815,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24815,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,24815,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,24816,0)
 ;;=T76.01XA^^66^993^3
 ;;^UTILITY(U,$J,358.3,24816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24816,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24816,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,24816,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,24817,0)
 ;;=T76.01XD^^66^993^4
 ;;^UTILITY(U,$J,358.3,24817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24817,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24817,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,24817,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,24818,0)
 ;;=Z91.412^^66^993^40
 ;;^UTILITY(U,$J,358.3,24818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24818,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,24818,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,24818,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,24819,0)
 ;;=T74.31XA^^66^993^9
 ;;^UTILITY(U,$J,358.3,24819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24819,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24819,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,24819,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,24820,0)
 ;;=T74.31XD^^66^993^10
 ;;^UTILITY(U,$J,358.3,24820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24820,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24820,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,24820,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,24821,0)
 ;;=T76.31XA^^66^993^11
 ;;^UTILITY(U,$J,358.3,24821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24821,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24821,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,24821,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,24822,0)
 ;;=T76.31XD^^66^993^12
 ;;^UTILITY(U,$J,358.3,24822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24822,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24822,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,24822,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,24823,0)
 ;;=Z91.411^^66^993^41
 ;;^UTILITY(U,$J,358.3,24823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24823,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24823,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,24823,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,24824,0)
 ;;=Z69.021^^66^993^18
 ;;^UTILITY(U,$J,358.3,24824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24824,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,24824,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24824,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24825,0)
 ;;=Z69.021^^66^993^19
 ;;^UTILITY(U,$J,358.3,24825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24825,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,24825,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24825,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24826,0)
 ;;=Z69.021^^66^993^20
 ;;^UTILITY(U,$J,358.3,24826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24826,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24826,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24826,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24827,0)
 ;;=Z69.021^^66^993^21
 ;;^UTILITY(U,$J,358.3,24827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24827,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24827,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24827,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24828,0)
 ;;=Z69.011^^66^993^23
 ;;^UTILITY(U,$J,358.3,24828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24828,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,24828,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24828,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24829,0)
 ;;=Z69.011^^66^993^24
 ;;^UTILITY(U,$J,358.3,24829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24829,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,24829,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24829,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24830,0)
 ;;=Z69.011^^66^993^25
 ;;^UTILITY(U,$J,358.3,24830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24830,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24830,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24830,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24831,0)
 ;;=Z69.011^^66^993^26
 ;;^UTILITY(U,$J,358.3,24831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24831,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24831,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24831,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24832,0)
 ;;=Z69.12^^66^993^17
 ;;^UTILITY(U,$J,358.3,24832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24832,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,24832,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24832,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24833,0)
 ;;=Z69.12^^66^993^28
 ;;^UTILITY(U,$J,358.3,24833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24833,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24833,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24833,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24834,0)
 ;;=Z69.12^^66^993^29
 ;;^UTILITY(U,$J,358.3,24834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24834,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24834,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24834,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24835,0)
 ;;=Z69.11^^66^993^32
 ;;^UTILITY(U,$J,358.3,24835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24835,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24835,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24835,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24836,0)
 ;;=Z69.11^^66^993^33
 ;;^UTILITY(U,$J,358.3,24836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24836,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,24836,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24836,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24837,0)
 ;;=Z69.11^^66^993^34
 ;;^UTILITY(U,$J,358.3,24837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24837,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24837,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24837,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24838,0)
 ;;=Z62.812^^66^993^36
 ;;^UTILITY(U,$J,358.3,24838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24838,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,24838,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,24838,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,24839,0)
 ;;=Z62.810^^66^993^37
 ;;^UTILITY(U,$J,358.3,24839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24839,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,24839,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,24839,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,24840,0)
 ;;=Z62.810^^66^993^39
 ;;^UTILITY(U,$J,358.3,24840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24840,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24840,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,24840,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,24841,0)
 ;;=Z62.811^^66^993^38
 ;;^UTILITY(U,$J,358.3,24841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24841,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24841,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,24841,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,24842,0)
 ;;=Z91.410^^66^993^42
 ;;^UTILITY(U,$J,358.3,24842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24842,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24842,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,24842,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,24843,0)
 ;;=F06.4^^66^994^3
