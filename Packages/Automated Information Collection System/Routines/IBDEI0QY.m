IBDEI0QY ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27086,0)
 ;;=T76.21XA^^102^1315^15
 ;;^UTILITY(U,$J,358.3,27086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27086,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,27086,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,27086,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,27087,0)
 ;;=T76.21XD^^102^1315^16
 ;;^UTILITY(U,$J,358.3,27087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27087,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,27087,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,27087,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,27088,0)
 ;;=Z69.81^^102^1315^30
 ;;^UTILITY(U,$J,358.3,27088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27088,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,27088,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,27088,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,27089,0)
 ;;=Z69.82^^102^1315^22
 ;;^UTILITY(U,$J,358.3,27089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27089,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,27089,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,27089,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,27090,0)
 ;;=T74.01XA^^102^1315^1
 ;;^UTILITY(U,$J,358.3,27090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27090,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,27090,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,27090,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,27091,0)
 ;;=T74.01XD^^102^1315^2
 ;;^UTILITY(U,$J,358.3,27091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27091,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,27091,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,27091,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,27092,0)
 ;;=T76.01XA^^102^1315^3
 ;;^UTILITY(U,$J,358.3,27092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27092,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,27092,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,27092,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,27093,0)
 ;;=T76.01XD^^102^1315^4
 ;;^UTILITY(U,$J,358.3,27093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27093,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,27093,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,27093,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,27094,0)
 ;;=Z91.412^^102^1315^40
 ;;^UTILITY(U,$J,358.3,27094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27094,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,27094,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,27094,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,27095,0)
 ;;=T74.31XA^^102^1315^9
 ;;^UTILITY(U,$J,358.3,27095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27095,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,27095,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,27095,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,27096,0)
 ;;=T74.31XD^^102^1315^10
 ;;^UTILITY(U,$J,358.3,27096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27096,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,27096,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,27096,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,27097,0)
 ;;=T76.31XA^^102^1315^11
 ;;^UTILITY(U,$J,358.3,27097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27097,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,27097,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,27097,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,27098,0)
 ;;=T76.31XD^^102^1315^12
 ;;^UTILITY(U,$J,358.3,27098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27098,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,27098,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,27098,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,27099,0)
 ;;=Z91.411^^102^1315^41
 ;;^UTILITY(U,$J,358.3,27099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27099,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,27099,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,27099,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,27100,0)
 ;;=Z69.021^^102^1315^18
 ;;^UTILITY(U,$J,358.3,27100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27100,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,27100,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,27100,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,27101,0)
 ;;=Z69.021^^102^1315^19
 ;;^UTILITY(U,$J,358.3,27101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27101,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,27101,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,27101,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,27102,0)
 ;;=Z69.021^^102^1315^20
 ;;^UTILITY(U,$J,358.3,27102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27102,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,27102,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,27102,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,27103,0)
 ;;=Z69.021^^102^1315^21
 ;;^UTILITY(U,$J,358.3,27103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27103,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,27103,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,27103,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,27104,0)
 ;;=Z69.011^^102^1315^23
 ;;^UTILITY(U,$J,358.3,27104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27104,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,27104,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,27104,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,27105,0)
 ;;=Z69.011^^102^1315^24
 ;;^UTILITY(U,$J,358.3,27105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27105,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,27105,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,27105,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,27106,0)
 ;;=Z69.011^^102^1315^25
 ;;^UTILITY(U,$J,358.3,27106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27106,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,27106,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,27106,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,27107,0)
 ;;=Z69.011^^102^1315^26
 ;;^UTILITY(U,$J,358.3,27107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27107,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,27107,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,27107,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,27108,0)
 ;;=Z69.12^^102^1315^17
 ;;^UTILITY(U,$J,358.3,27108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27108,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,27108,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,27108,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,27109,0)
 ;;=Z69.12^^102^1315^28
 ;;^UTILITY(U,$J,358.3,27109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27109,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,27109,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,27109,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,27110,0)
 ;;=Z69.12^^102^1315^29
 ;;^UTILITY(U,$J,358.3,27110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27110,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,27110,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,27110,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,27111,0)
 ;;=Z69.11^^102^1315^32
 ;;^UTILITY(U,$J,358.3,27111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27111,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,27111,1,4,0)
 ;;=4^Z69.11
