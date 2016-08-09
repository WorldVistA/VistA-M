IBDEI0Z2 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35307,0)
 ;;=T76.11XA^^130^1696^7
 ;;^UTILITY(U,$J,358.3,35307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35307,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,35307,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,35307,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,35308,0)
 ;;=T76.11XD^^130^1696^8
 ;;^UTILITY(U,$J,358.3,35308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35308,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,35308,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,35308,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,35309,0)
 ;;=Z69.11^^130^1696^31
 ;;^UTILITY(U,$J,358.3,35309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35309,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,35309,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,35309,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,35310,0)
 ;;=Z91.410^^130^1696^35
 ;;^UTILITY(U,$J,358.3,35310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35310,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,35310,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,35310,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,35311,0)
 ;;=Z69.12^^130^1696^27
 ;;^UTILITY(U,$J,358.3,35311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35311,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,35311,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,35311,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,35312,0)
 ;;=T74.21XA^^130^1696^13
 ;;^UTILITY(U,$J,358.3,35312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35312,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,35312,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,35312,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,35313,0)
 ;;=T74.21XD^^130^1696^14
 ;;^UTILITY(U,$J,358.3,35313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35313,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,35313,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,35313,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,35314,0)
 ;;=T76.21XA^^130^1696^15
 ;;^UTILITY(U,$J,358.3,35314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35314,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,35314,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,35314,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,35315,0)
 ;;=T76.21XD^^130^1696^16
 ;;^UTILITY(U,$J,358.3,35315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35315,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,35315,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,35315,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,35316,0)
 ;;=Z69.81^^130^1696^30
 ;;^UTILITY(U,$J,358.3,35316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35316,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,35316,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,35316,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,35317,0)
 ;;=Z69.82^^130^1696^22
 ;;^UTILITY(U,$J,358.3,35317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35317,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,35317,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,35317,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,35318,0)
 ;;=T74.01XA^^130^1696^1
 ;;^UTILITY(U,$J,358.3,35318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35318,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,35318,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,35318,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,35319,0)
 ;;=T74.01XD^^130^1696^2
 ;;^UTILITY(U,$J,358.3,35319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35319,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,35319,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,35319,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,35320,0)
 ;;=T76.01XA^^130^1696^3
 ;;^UTILITY(U,$J,358.3,35320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35320,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,35320,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,35320,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,35321,0)
 ;;=T76.01XD^^130^1696^4
 ;;^UTILITY(U,$J,358.3,35321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35321,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,35321,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,35321,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,35322,0)
 ;;=Z91.412^^130^1696^40
 ;;^UTILITY(U,$J,358.3,35322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35322,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,35322,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,35322,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,35323,0)
 ;;=T74.31XA^^130^1696^9
 ;;^UTILITY(U,$J,358.3,35323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35323,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,35323,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,35323,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,35324,0)
 ;;=T74.31XD^^130^1696^10
 ;;^UTILITY(U,$J,358.3,35324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35324,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,35324,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,35324,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,35325,0)
 ;;=T76.31XA^^130^1696^11
 ;;^UTILITY(U,$J,358.3,35325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35325,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,35325,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,35325,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,35326,0)
 ;;=T76.31XD^^130^1696^12
 ;;^UTILITY(U,$J,358.3,35326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35326,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,35326,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,35326,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,35327,0)
 ;;=Z91.411^^130^1696^41
 ;;^UTILITY(U,$J,358.3,35327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35327,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,35327,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,35327,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,35328,0)
 ;;=Z69.021^^130^1696^18
 ;;^UTILITY(U,$J,358.3,35328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35328,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,35328,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,35328,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,35329,0)
 ;;=Z69.021^^130^1696^19
 ;;^UTILITY(U,$J,358.3,35329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35329,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,35329,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,35329,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,35330,0)
 ;;=Z69.021^^130^1696^20
 ;;^UTILITY(U,$J,358.3,35330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35330,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,35330,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,35330,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,35331,0)
 ;;=Z69.021^^130^1696^21
 ;;^UTILITY(U,$J,358.3,35331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35331,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,35331,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,35331,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,35332,0)
 ;;=Z69.011^^130^1696^23
 ;;^UTILITY(U,$J,358.3,35332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35332,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,35332,1,4,0)
 ;;=4^Z69.011
