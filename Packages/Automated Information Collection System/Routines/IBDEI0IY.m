IBDEI0IY ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24025,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24025,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,24025,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,24026,0)
 ;;=T74.21XD^^64^947^14
 ;;^UTILITY(U,$J,358.3,24026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24026,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24026,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,24026,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,24027,0)
 ;;=T76.21XA^^64^947^15
 ;;^UTILITY(U,$J,358.3,24027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24027,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24027,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,24027,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,24028,0)
 ;;=T76.21XD^^64^947^16
 ;;^UTILITY(U,$J,358.3,24028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24028,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24028,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,24028,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,24029,0)
 ;;=Z69.81^^64^947^30
 ;;^UTILITY(U,$J,358.3,24029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24029,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,24029,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,24029,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,24030,0)
 ;;=Z69.82^^64^947^22
 ;;^UTILITY(U,$J,358.3,24030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24030,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,24030,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,24030,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,24031,0)
 ;;=T74.01XA^^64^947^1
 ;;^UTILITY(U,$J,358.3,24031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24031,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24031,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,24031,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,24032,0)
 ;;=T74.01XD^^64^947^2
 ;;^UTILITY(U,$J,358.3,24032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24032,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24032,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,24032,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,24033,0)
 ;;=T76.01XA^^64^947^3
 ;;^UTILITY(U,$J,358.3,24033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24033,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24033,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,24033,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,24034,0)
 ;;=T76.01XD^^64^947^4
 ;;^UTILITY(U,$J,358.3,24034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24034,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24034,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,24034,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,24035,0)
 ;;=Z91.412^^64^947^40
 ;;^UTILITY(U,$J,358.3,24035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24035,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,24035,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,24035,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,24036,0)
 ;;=T74.31XA^^64^947^9
 ;;^UTILITY(U,$J,358.3,24036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24036,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24036,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,24036,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,24037,0)
 ;;=T74.31XD^^64^947^10
 ;;^UTILITY(U,$J,358.3,24037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24037,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24037,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,24037,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,24038,0)
 ;;=T76.31XA^^64^947^11
 ;;^UTILITY(U,$J,358.3,24038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24038,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24038,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,24038,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,24039,0)
 ;;=T76.31XD^^64^947^12
 ;;^UTILITY(U,$J,358.3,24039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24039,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24039,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,24039,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,24040,0)
 ;;=Z91.411^^64^947^41
 ;;^UTILITY(U,$J,358.3,24040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24040,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24040,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,24040,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,24041,0)
 ;;=Z69.021^^64^947^18
 ;;^UTILITY(U,$J,358.3,24041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24041,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,24041,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24041,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24042,0)
 ;;=Z69.021^^64^947^19
 ;;^UTILITY(U,$J,358.3,24042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24042,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,24042,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24042,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24043,0)
 ;;=Z69.021^^64^947^20
 ;;^UTILITY(U,$J,358.3,24043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24043,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24043,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24043,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24044,0)
 ;;=Z69.021^^64^947^21
 ;;^UTILITY(U,$J,358.3,24044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24044,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24044,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24044,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24045,0)
 ;;=Z69.011^^64^947^23
 ;;^UTILITY(U,$J,358.3,24045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24045,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,24045,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24045,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24046,0)
 ;;=Z69.011^^64^947^24
 ;;^UTILITY(U,$J,358.3,24046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24046,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,24046,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24046,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24047,0)
 ;;=Z69.011^^64^947^25
 ;;^UTILITY(U,$J,358.3,24047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24047,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24047,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24047,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24048,0)
 ;;=Z69.011^^64^947^26
 ;;^UTILITY(U,$J,358.3,24048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24048,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24048,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,24048,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,24049,0)
 ;;=Z69.12^^64^947^17
 ;;^UTILITY(U,$J,358.3,24049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24049,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,24049,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24049,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24050,0)
 ;;=Z69.12^^64^947^28
 ;;^UTILITY(U,$J,358.3,24050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24050,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24050,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24050,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24051,0)
 ;;=Z69.12^^64^947^29
 ;;^UTILITY(U,$J,358.3,24051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24051,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24051,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24051,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24052,0)
 ;;=Z69.11^^64^947^32
 ;;^UTILITY(U,$J,358.3,24052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24052,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24052,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24052,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24053,0)
 ;;=Z69.11^^64^947^33
 ;;^UTILITY(U,$J,358.3,24053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24053,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,24053,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24053,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24054,0)
 ;;=Z69.11^^64^947^34
 ;;^UTILITY(U,$J,358.3,24054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24054,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,24054,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24054,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24055,0)
 ;;=Z62.812^^64^947^36
 ;;^UTILITY(U,$J,358.3,24055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24055,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,24055,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,24055,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,24056,0)
 ;;=Z62.810^^64^947^37
 ;;^UTILITY(U,$J,358.3,24056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24056,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,24056,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,24056,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,24057,0)
 ;;=Z62.810^^64^947^39
 ;;^UTILITY(U,$J,358.3,24057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24057,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,24057,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,24057,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,24058,0)
 ;;=Z62.811^^64^947^38
 ;;^UTILITY(U,$J,358.3,24058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24058,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
