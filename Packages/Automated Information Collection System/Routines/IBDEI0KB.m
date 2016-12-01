IBDEI0KB ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25718,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,25718,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,25719,0)
 ;;=Z69.12^^69^1060^27
 ;;^UTILITY(U,$J,358.3,25719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25719,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,25719,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,25719,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,25720,0)
 ;;=T74.21XA^^69^1060^13
 ;;^UTILITY(U,$J,358.3,25720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25720,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25720,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,25720,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,25721,0)
 ;;=T74.21XD^^69^1060^14
 ;;^UTILITY(U,$J,358.3,25721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25721,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25721,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,25721,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,25722,0)
 ;;=T76.21XA^^69^1060^15
 ;;^UTILITY(U,$J,358.3,25722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25722,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25722,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,25722,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,25723,0)
 ;;=T76.21XD^^69^1060^16
 ;;^UTILITY(U,$J,358.3,25723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25723,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25723,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,25723,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,25724,0)
 ;;=Z69.81^^69^1060^30
 ;;^UTILITY(U,$J,358.3,25724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25724,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,25724,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,25724,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,25725,0)
 ;;=Z69.82^^69^1060^22
 ;;^UTILITY(U,$J,358.3,25725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25725,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,25725,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,25725,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,25726,0)
 ;;=T74.01XA^^69^1060^1
 ;;^UTILITY(U,$J,358.3,25726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25726,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25726,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,25726,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,25727,0)
 ;;=T74.01XD^^69^1060^2
 ;;^UTILITY(U,$J,358.3,25727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25727,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25727,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,25727,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,25728,0)
 ;;=T76.01XA^^69^1060^3
 ;;^UTILITY(U,$J,358.3,25728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25728,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25728,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,25728,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,25729,0)
 ;;=T76.01XD^^69^1060^4
 ;;^UTILITY(U,$J,358.3,25729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25729,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25729,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,25729,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,25730,0)
 ;;=Z91.412^^69^1060^40
 ;;^UTILITY(U,$J,358.3,25730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25730,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,25730,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,25730,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,25731,0)
 ;;=T74.31XA^^69^1060^9
 ;;^UTILITY(U,$J,358.3,25731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25731,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25731,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,25731,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,25732,0)
 ;;=T74.31XD^^69^1060^10
 ;;^UTILITY(U,$J,358.3,25732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25732,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25732,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,25732,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,25733,0)
 ;;=T76.31XA^^69^1060^11
 ;;^UTILITY(U,$J,358.3,25733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25733,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25733,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,25733,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,25734,0)
 ;;=T76.31XD^^69^1060^12
 ;;^UTILITY(U,$J,358.3,25734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25734,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25734,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,25734,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,25735,0)
 ;;=Z91.411^^69^1060^41
 ;;^UTILITY(U,$J,358.3,25735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25735,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25735,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,25735,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,25736,0)
 ;;=Z69.021^^69^1060^18
 ;;^UTILITY(U,$J,358.3,25736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25736,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,25736,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25736,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25737,0)
 ;;=Z69.021^^69^1060^19
 ;;^UTILITY(U,$J,358.3,25737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25737,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,25737,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25737,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25738,0)
 ;;=Z69.021^^69^1060^20
 ;;^UTILITY(U,$J,358.3,25738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25738,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25738,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25738,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25739,0)
 ;;=Z69.021^^69^1060^21
 ;;^UTILITY(U,$J,358.3,25739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25739,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,25739,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25739,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25740,0)
 ;;=Z69.011^^69^1060^23
 ;;^UTILITY(U,$J,358.3,25740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25740,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,25740,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25740,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25741,0)
 ;;=Z69.011^^69^1060^24
 ;;^UTILITY(U,$J,358.3,25741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25741,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,25741,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25741,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25742,0)
 ;;=Z69.011^^69^1060^25
 ;;^UTILITY(U,$J,358.3,25742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25742,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25742,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25742,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25743,0)
 ;;=Z69.011^^69^1060^26
 ;;^UTILITY(U,$J,358.3,25743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25743,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,25743,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25743,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25744,0)
 ;;=Z69.12^^69^1060^17
 ;;^UTILITY(U,$J,358.3,25744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25744,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,25744,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,25744,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,25745,0)
 ;;=Z69.12^^69^1060^28
 ;;^UTILITY(U,$J,358.3,25745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25745,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25745,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,25745,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,25746,0)
 ;;=Z69.12^^69^1060^29
 ;;^UTILITY(U,$J,358.3,25746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25746,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,25746,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,25746,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,25747,0)
 ;;=Z69.11^^69^1060^32
 ;;^UTILITY(U,$J,358.3,25747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25747,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25747,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,25747,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,25748,0)
 ;;=Z69.11^^69^1060^33
 ;;^UTILITY(U,$J,358.3,25748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25748,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,25748,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,25748,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,25749,0)
 ;;=Z69.11^^69^1060^34
 ;;^UTILITY(U,$J,358.3,25749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25749,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,25749,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,25749,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,25750,0)
 ;;=Z62.812^^69^1060^36
 ;;^UTILITY(U,$J,358.3,25750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25750,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,25750,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,25750,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,25751,0)
 ;;=Z62.810^^69^1060^37
 ;;^UTILITY(U,$J,358.3,25751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25751,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
