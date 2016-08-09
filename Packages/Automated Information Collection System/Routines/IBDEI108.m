IBDEI108 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36463,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,36463,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,36463,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,36464,0)
 ;;=T76.21XD^^135^1797^16
 ;;^UTILITY(U,$J,358.3,36464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36464,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,36464,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,36464,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,36465,0)
 ;;=Z69.81^^135^1797^30
 ;;^UTILITY(U,$J,358.3,36465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36465,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,36465,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,36465,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,36466,0)
 ;;=Z69.82^^135^1797^22
 ;;^UTILITY(U,$J,358.3,36466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36466,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,36466,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,36466,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,36467,0)
 ;;=T74.01XA^^135^1797^1
 ;;^UTILITY(U,$J,358.3,36467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36467,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,36467,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,36467,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,36468,0)
 ;;=T74.01XD^^135^1797^2
 ;;^UTILITY(U,$J,358.3,36468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36468,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,36468,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,36468,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,36469,0)
 ;;=T76.01XA^^135^1797^3
 ;;^UTILITY(U,$J,358.3,36469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36469,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,36469,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,36469,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,36470,0)
 ;;=T76.01XD^^135^1797^4
 ;;^UTILITY(U,$J,358.3,36470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36470,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,36470,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,36470,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,36471,0)
 ;;=Z91.412^^135^1797^40
 ;;^UTILITY(U,$J,358.3,36471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36471,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,36471,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,36471,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,36472,0)
 ;;=T74.31XA^^135^1797^9
 ;;^UTILITY(U,$J,358.3,36472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36472,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,36472,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,36472,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,36473,0)
 ;;=T74.31XD^^135^1797^10
 ;;^UTILITY(U,$J,358.3,36473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36473,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,36473,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,36473,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,36474,0)
 ;;=T76.31XA^^135^1797^11
 ;;^UTILITY(U,$J,358.3,36474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36474,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,36474,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,36474,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,36475,0)
 ;;=T76.31XD^^135^1797^12
 ;;^UTILITY(U,$J,358.3,36475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36475,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,36475,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,36475,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,36476,0)
 ;;=Z91.411^^135^1797^41
 ;;^UTILITY(U,$J,358.3,36476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36476,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,36476,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,36476,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,36477,0)
 ;;=Z69.021^^135^1797^18
 ;;^UTILITY(U,$J,358.3,36477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36477,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,36477,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,36477,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,36478,0)
 ;;=Z69.021^^135^1797^19
 ;;^UTILITY(U,$J,358.3,36478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36478,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,36478,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,36478,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,36479,0)
 ;;=Z69.021^^135^1797^20
 ;;^UTILITY(U,$J,358.3,36479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36479,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,36479,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,36479,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,36480,0)
 ;;=Z69.021^^135^1797^21
 ;;^UTILITY(U,$J,358.3,36480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36480,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,36480,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,36480,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,36481,0)
 ;;=Z69.011^^135^1797^23
 ;;^UTILITY(U,$J,358.3,36481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36481,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,36481,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,36481,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,36482,0)
 ;;=Z69.011^^135^1797^24
 ;;^UTILITY(U,$J,358.3,36482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36482,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,36482,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,36482,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,36483,0)
 ;;=Z69.011^^135^1797^25
 ;;^UTILITY(U,$J,358.3,36483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36483,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,36483,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,36483,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,36484,0)
 ;;=Z69.011^^135^1797^26
 ;;^UTILITY(U,$J,358.3,36484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36484,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,36484,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,36484,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,36485,0)
 ;;=Z69.12^^135^1797^17
 ;;^UTILITY(U,$J,358.3,36485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36485,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,36485,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,36485,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,36486,0)
 ;;=Z69.12^^135^1797^28
 ;;^UTILITY(U,$J,358.3,36486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36486,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,36486,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,36486,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,36487,0)
 ;;=Z69.12^^135^1797^29
 ;;^UTILITY(U,$J,358.3,36487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36487,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,36487,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,36487,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,36488,0)
 ;;=Z69.11^^135^1797^32
 ;;^UTILITY(U,$J,358.3,36488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36488,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,36488,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,36488,2)
 ;;=^5063232
