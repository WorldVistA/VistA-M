IBDEI0P7 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25365,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,25365,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,25366,0)
 ;;=Z69.11^^97^1197^31
 ;;^UTILITY(U,$J,358.3,25366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25366,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,25366,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,25366,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,25367,0)
 ;;=Z91.410^^97^1197^35
 ;;^UTILITY(U,$J,358.3,25367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25367,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,25367,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,25367,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,25368,0)
 ;;=Z69.12^^97^1197^27
 ;;^UTILITY(U,$J,358.3,25368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25368,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,25368,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,25368,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,25369,0)
 ;;=T74.21XA^^97^1197^13
 ;;^UTILITY(U,$J,358.3,25369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25369,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25369,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,25369,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,25370,0)
 ;;=T74.21XD^^97^1197^14
 ;;^UTILITY(U,$J,358.3,25370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25370,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25370,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,25370,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,25371,0)
 ;;=T76.21XA^^97^1197^15
 ;;^UTILITY(U,$J,358.3,25371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25371,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25371,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,25371,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,25372,0)
 ;;=T76.21XD^^97^1197^16
 ;;^UTILITY(U,$J,358.3,25372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25372,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25372,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,25372,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,25373,0)
 ;;=Z69.81^^97^1197^30
 ;;^UTILITY(U,$J,358.3,25373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25373,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,25373,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,25373,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,25374,0)
 ;;=Z69.82^^97^1197^22
 ;;^UTILITY(U,$J,358.3,25374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25374,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,25374,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,25374,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,25375,0)
 ;;=T74.01XA^^97^1197^1
 ;;^UTILITY(U,$J,358.3,25375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25375,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25375,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,25375,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,25376,0)
 ;;=T74.01XD^^97^1197^2
 ;;^UTILITY(U,$J,358.3,25376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25376,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25376,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,25376,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,25377,0)
 ;;=T76.01XA^^97^1197^3
 ;;^UTILITY(U,$J,358.3,25377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25377,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25377,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,25377,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,25378,0)
 ;;=T76.01XD^^97^1197^4
 ;;^UTILITY(U,$J,358.3,25378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25378,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25378,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,25378,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,25379,0)
 ;;=Z91.412^^97^1197^40
 ;;^UTILITY(U,$J,358.3,25379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25379,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,25379,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,25379,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,25380,0)
 ;;=T74.31XA^^97^1197^9
 ;;^UTILITY(U,$J,358.3,25380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25380,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25380,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,25380,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,25381,0)
 ;;=T74.31XD^^97^1197^10
 ;;^UTILITY(U,$J,358.3,25381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25381,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25381,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,25381,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,25382,0)
 ;;=T76.31XA^^97^1197^11
 ;;^UTILITY(U,$J,358.3,25382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25382,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25382,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,25382,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,25383,0)
 ;;=T76.31XD^^97^1197^12
 ;;^UTILITY(U,$J,358.3,25383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25383,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25383,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,25383,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,25384,0)
 ;;=Z91.411^^97^1197^41
 ;;^UTILITY(U,$J,358.3,25384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25384,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25384,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,25384,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,25385,0)
 ;;=Z69.021^^97^1197^18
 ;;^UTILITY(U,$J,358.3,25385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25385,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,25385,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25385,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25386,0)
 ;;=Z69.021^^97^1197^19
 ;;^UTILITY(U,$J,358.3,25386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25386,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,25386,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25386,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25387,0)
 ;;=Z69.021^^97^1197^20
 ;;^UTILITY(U,$J,358.3,25387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25387,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25387,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25387,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25388,0)
 ;;=Z69.021^^97^1197^21
 ;;^UTILITY(U,$J,358.3,25388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25388,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,25388,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25388,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25389,0)
 ;;=Z69.011^^97^1197^23
 ;;^UTILITY(U,$J,358.3,25389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25389,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,25389,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25389,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25390,0)
 ;;=Z69.011^^97^1197^24
 ;;^UTILITY(U,$J,358.3,25390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25390,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,25390,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25390,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25391,0)
 ;;=Z69.011^^97^1197^25
 ;;^UTILITY(U,$J,358.3,25391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25391,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
