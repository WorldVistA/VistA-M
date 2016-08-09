IBDEI0OF ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24615,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,24615,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,24616,0)
 ;;=Z69.82^^95^1152^22
 ;;^UTILITY(U,$J,358.3,24616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24616,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,24616,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,24616,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,24617,0)
 ;;=T74.01XA^^95^1152^1
 ;;^UTILITY(U,$J,358.3,24617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24617,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24617,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,24617,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,24618,0)
 ;;=T74.01XD^^95^1152^2
 ;;^UTILITY(U,$J,358.3,24618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24618,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24618,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,24618,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,24619,0)
 ;;=T76.01XA^^95^1152^3
 ;;^UTILITY(U,$J,358.3,24619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24619,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24619,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,24619,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,24620,0)
 ;;=T76.01XD^^95^1152^4
 ;;^UTILITY(U,$J,358.3,24620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24620,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24620,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,24620,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,24621,0)
 ;;=Z91.412^^95^1152^40
 ;;^UTILITY(U,$J,358.3,24621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24621,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,24621,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,24621,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,24622,0)
 ;;=T74.31XA^^95^1152^9
 ;;^UTILITY(U,$J,358.3,24622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24622,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24622,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,24622,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,24623,0)
 ;;=T74.31XD^^95^1152^10
 ;;^UTILITY(U,$J,358.3,24623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24623,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24623,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,24623,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,24624,0)
 ;;=T76.31XA^^95^1152^11
 ;;^UTILITY(U,$J,358.3,24624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24624,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24624,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,24624,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,24625,0)
 ;;=T76.31XD^^95^1152^12
 ;;^UTILITY(U,$J,358.3,24625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24625,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24625,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,24625,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,24626,0)
 ;;=Z91.411^^95^1152^41
 ;;^UTILITY(U,$J,358.3,24626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24626,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24626,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,24626,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,24627,0)
 ;;=Z69.021^^95^1152^18
 ;;^UTILITY(U,$J,358.3,24627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24627,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,24627,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24627,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24628,0)
 ;;=Z69.021^^95^1152^19
 ;;^UTILITY(U,$J,358.3,24628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24628,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,24628,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24628,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24629,0)
 ;;=Z69.021^^95^1152^20
 ;;^UTILITY(U,$J,358.3,24629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24629,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24629,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24629,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24630,0)
 ;;=Z69.021^^95^1152^21
 ;;^UTILITY(U,$J,358.3,24630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24630,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24630,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24630,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24631,0)
 ;;=Z69.011^^95^1152^23
 ;;^UTILITY(U,$J,358.3,24631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24631,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,24631,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24631,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24632,0)
 ;;=Z69.011^^95^1152^24
 ;;^UTILITY(U,$J,358.3,24632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24632,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,24632,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24632,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24633,0)
 ;;=Z69.011^^95^1152^25
 ;;^UTILITY(U,$J,358.3,24633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24633,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24633,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24633,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24634,0)
 ;;=Z69.011^^95^1152^26
 ;;^UTILITY(U,$J,358.3,24634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24634,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24634,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24634,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24635,0)
 ;;=Z69.12^^95^1152^17
 ;;^UTILITY(U,$J,358.3,24635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24635,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,24635,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24635,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24636,0)
 ;;=Z69.12^^95^1152^28
 ;;^UTILITY(U,$J,358.3,24636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24636,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24636,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24636,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24637,0)
 ;;=Z69.12^^95^1152^29
 ;;^UTILITY(U,$J,358.3,24637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24637,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24637,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24637,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24638,0)
 ;;=Z69.11^^95^1152^32
 ;;^UTILITY(U,$J,358.3,24638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24638,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24638,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24638,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24639,0)
 ;;=Z69.11^^95^1152^33
 ;;^UTILITY(U,$J,358.3,24639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24639,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,24639,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24639,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24640,0)
 ;;=Z69.11^^95^1152^34
 ;;^UTILITY(U,$J,358.3,24640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24640,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24640,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24640,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24641,0)
 ;;=Z62.812^^95^1152^36
 ;;^UTILITY(U,$J,358.3,24641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24641,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
