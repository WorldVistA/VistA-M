IBDEI00J ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,132,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,132,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,133,0)
 ;;=T74.21XA^^3^23^13
 ;;^UTILITY(U,$J,358.3,133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,133,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,133,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,133,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,134,0)
 ;;=T74.21XD^^3^23^14
 ;;^UTILITY(U,$J,358.3,134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,134,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,134,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,134,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,135,0)
 ;;=T76.21XA^^3^23^15
 ;;^UTILITY(U,$J,358.3,135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,135,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,135,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,135,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,136,0)
 ;;=T76.21XD^^3^23^16
 ;;^UTILITY(U,$J,358.3,136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,136,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,136,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,136,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,137,0)
 ;;=Z69.81^^3^23^30
 ;;^UTILITY(U,$J,358.3,137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,137,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,137,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,137,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,138,0)
 ;;=Z69.82^^3^23^22
 ;;^UTILITY(U,$J,358.3,138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,138,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,138,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,138,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,139,0)
 ;;=T74.01XA^^3^23^1
 ;;^UTILITY(U,$J,358.3,139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,139,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,139,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,139,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,140,0)
 ;;=T74.01XD^^3^23^2
 ;;^UTILITY(U,$J,358.3,140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,140,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,140,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,140,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,141,0)
 ;;=T76.01XA^^3^23^3
 ;;^UTILITY(U,$J,358.3,141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,141,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,141,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,141,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,142,0)
 ;;=T76.01XD^^3^23^4
 ;;^UTILITY(U,$J,358.3,142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,142,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,142,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,142,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,143,0)
 ;;=Z91.412^^3^23^40
 ;;^UTILITY(U,$J,358.3,143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,143,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,143,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,143,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,144,0)
 ;;=T74.31XA^^3^23^9
 ;;^UTILITY(U,$J,358.3,144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,144,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,144,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,144,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,145,0)
 ;;=T74.31XD^^3^23^10
 ;;^UTILITY(U,$J,358.3,145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,145,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,145,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,145,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,146,0)
 ;;=T76.31XA^^3^23^11
 ;;^UTILITY(U,$J,358.3,146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,146,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,146,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,146,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,147,0)
 ;;=T76.31XD^^3^23^12
 ;;^UTILITY(U,$J,358.3,147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,147,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,147,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,147,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,148,0)
 ;;=Z91.411^^3^23^41
 ;;^UTILITY(U,$J,358.3,148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,148,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,148,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,148,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,149,0)
 ;;=Z69.021^^3^23^18
 ;;^UTILITY(U,$J,358.3,149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,149,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,149,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,149,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,150,0)
 ;;=Z69.021^^3^23^19
 ;;^UTILITY(U,$J,358.3,150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,150,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,150,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,150,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,151,0)
 ;;=Z69.021^^3^23^20
 ;;^UTILITY(U,$J,358.3,151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,151,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,151,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,151,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,152,0)
 ;;=Z69.021^^3^23^21
 ;;^UTILITY(U,$J,358.3,152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,152,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,152,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,152,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,153,0)
 ;;=Z69.011^^3^23^23
 ;;^UTILITY(U,$J,358.3,153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,153,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,153,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,153,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,154,0)
 ;;=Z69.011^^3^23^24
 ;;^UTILITY(U,$J,358.3,154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,154,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,154,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,154,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=Z69.011^^3^23^25
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,155,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,155,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,155,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=Z69.011^^3^23^26
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,156,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,156,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=Z69.12^^3^23^17
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,157,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,157,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=Z69.12^^3^23^28
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,158,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,158,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=Z69.12^^3^23^29
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,159,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,159,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=Z69.11^^3^23^32
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,160,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,160,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=Z69.11^^3^23^33
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,161,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,161,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=Z69.11^^3^23^34
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,162,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,162,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=Z62.812^^3^23^36
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,163,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,163,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=Z62.810^^3^23^37
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,164,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,164,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=Z62.810^^3^23^39
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,165,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,165,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=Z62.811^^3^23^38
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,166,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,166,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=Z91.410^^3^23^42
