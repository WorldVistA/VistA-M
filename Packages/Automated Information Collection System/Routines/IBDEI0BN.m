IBDEI0BN ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14779,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,14779,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,14780,0)
 ;;=T76.21XA^^45^654^15
 ;;^UTILITY(U,$J,358.3,14780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14780,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,14780,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,14780,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,14781,0)
 ;;=T76.21XD^^45^654^16
 ;;^UTILITY(U,$J,358.3,14781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14781,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,14781,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,14781,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,14782,0)
 ;;=Z69.81^^45^654^30
 ;;^UTILITY(U,$J,358.3,14782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14782,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,14782,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,14782,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,14783,0)
 ;;=Z69.82^^45^654^22
 ;;^UTILITY(U,$J,358.3,14783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14783,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,14783,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,14783,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,14784,0)
 ;;=T74.01XA^^45^654^1
 ;;^UTILITY(U,$J,358.3,14784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14784,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,14784,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,14784,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,14785,0)
 ;;=T74.01XD^^45^654^2
 ;;^UTILITY(U,$J,358.3,14785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14785,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,14785,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,14785,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,14786,0)
 ;;=T76.01XA^^45^654^3
 ;;^UTILITY(U,$J,358.3,14786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14786,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,14786,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,14786,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,14787,0)
 ;;=T76.01XD^^45^654^4
 ;;^UTILITY(U,$J,358.3,14787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14787,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,14787,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,14787,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,14788,0)
 ;;=Z91.412^^45^654^40
 ;;^UTILITY(U,$J,358.3,14788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14788,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,14788,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,14788,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,14789,0)
 ;;=T74.31XA^^45^654^9
 ;;^UTILITY(U,$J,358.3,14789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14789,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,14789,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,14789,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,14790,0)
 ;;=T74.31XD^^45^654^10
 ;;^UTILITY(U,$J,358.3,14790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14790,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,14790,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,14790,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,14791,0)
 ;;=T76.31XA^^45^654^11
 ;;^UTILITY(U,$J,358.3,14791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14791,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,14791,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,14791,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,14792,0)
 ;;=T76.31XD^^45^654^12
 ;;^UTILITY(U,$J,358.3,14792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14792,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,14792,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,14792,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,14793,0)
 ;;=Z91.411^^45^654^41
 ;;^UTILITY(U,$J,358.3,14793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14793,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,14793,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,14793,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,14794,0)
 ;;=Z69.021^^45^654^18
 ;;^UTILITY(U,$J,358.3,14794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14794,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,14794,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,14794,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,14795,0)
 ;;=Z69.021^^45^654^19
 ;;^UTILITY(U,$J,358.3,14795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14795,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,14795,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,14795,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,14796,0)
 ;;=Z69.021^^45^654^20
 ;;^UTILITY(U,$J,358.3,14796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14796,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,14796,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,14796,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,14797,0)
 ;;=Z69.021^^45^654^21
 ;;^UTILITY(U,$J,358.3,14797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14797,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,14797,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,14797,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,14798,0)
 ;;=Z69.011^^45^654^23
 ;;^UTILITY(U,$J,358.3,14798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14798,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,14798,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,14798,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,14799,0)
 ;;=Z69.011^^45^654^24
 ;;^UTILITY(U,$J,358.3,14799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14799,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,14799,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,14799,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,14800,0)
 ;;=Z69.011^^45^654^25
 ;;^UTILITY(U,$J,358.3,14800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14800,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,14800,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,14800,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,14801,0)
 ;;=Z69.011^^45^654^26
 ;;^UTILITY(U,$J,358.3,14801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14801,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,14801,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,14801,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,14802,0)
 ;;=Z69.12^^45^654^17
 ;;^UTILITY(U,$J,358.3,14802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14802,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,14802,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,14802,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,14803,0)
 ;;=Z69.12^^45^654^28
 ;;^UTILITY(U,$J,358.3,14803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14803,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,14803,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,14803,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,14804,0)
 ;;=Z69.12^^45^654^29
 ;;^UTILITY(U,$J,358.3,14804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14804,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,14804,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,14804,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,14805,0)
 ;;=Z69.11^^45^654^32
 ;;^UTILITY(U,$J,358.3,14805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14805,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,14805,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,14805,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,14806,0)
 ;;=Z69.11^^45^654^33
 ;;^UTILITY(U,$J,358.3,14806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14806,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,14806,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,14806,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,14807,0)
 ;;=Z69.11^^45^654^34
 ;;^UTILITY(U,$J,358.3,14807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14807,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,14807,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,14807,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,14808,0)
 ;;=Z62.812^^45^654^36
 ;;^UTILITY(U,$J,358.3,14808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14808,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,14808,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,14808,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,14809,0)
 ;;=Z62.810^^45^654^37
 ;;^UTILITY(U,$J,358.3,14809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14809,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,14809,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,14809,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,14810,0)
 ;;=Z62.810^^45^654^39
 ;;^UTILITY(U,$J,358.3,14810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14810,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,14810,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,14810,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,14811,0)
 ;;=Z62.811^^45^654^38
 ;;^UTILITY(U,$J,358.3,14811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14811,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,14811,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,14811,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,14812,0)
 ;;=Z91.410^^45^654^42
 ;;^UTILITY(U,$J,358.3,14812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14812,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
