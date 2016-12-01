IBDEI0OB ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,30839,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,30839,1,3,0)
 ;;=3^Self-Help/Peer Svc,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,30840,0)
 ;;=T74.11XA^^91^1334^5
 ;;^UTILITY(U,$J,358.3,30840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30840,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30840,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,30840,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,30841,0)
 ;;=T74.11XD^^91^1334^6
 ;;^UTILITY(U,$J,358.3,30841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30841,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30841,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,30841,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,30842,0)
 ;;=T76.11XA^^91^1334^7
 ;;^UTILITY(U,$J,358.3,30842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30842,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30842,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,30842,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,30843,0)
 ;;=T76.11XD^^91^1334^8
 ;;^UTILITY(U,$J,358.3,30843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30843,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,30843,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,30843,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,30844,0)
 ;;=Z69.11^^91^1334^31
 ;;^UTILITY(U,$J,358.3,30844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30844,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,30844,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,30844,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,30845,0)
 ;;=Z91.410^^91^1334^35
 ;;^UTILITY(U,$J,358.3,30845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30845,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,30845,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,30845,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,30846,0)
 ;;=Z69.12^^91^1334^27
 ;;^UTILITY(U,$J,358.3,30846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30846,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,30846,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,30846,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,30847,0)
 ;;=T74.21XA^^91^1334^13
 ;;^UTILITY(U,$J,358.3,30847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30847,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,30847,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,30847,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,30848,0)
 ;;=T74.21XD^^91^1334^14
 ;;^UTILITY(U,$J,358.3,30848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30848,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30848,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,30848,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,30849,0)
 ;;=T76.21XA^^91^1334^15
 ;;^UTILITY(U,$J,358.3,30849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30849,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30849,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,30849,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,30850,0)
 ;;=T76.21XD^^91^1334^16
 ;;^UTILITY(U,$J,358.3,30850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30850,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,30850,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,30850,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,30851,0)
 ;;=Z69.81^^91^1334^30
 ;;^UTILITY(U,$J,358.3,30851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30851,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,30851,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,30851,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,30852,0)
 ;;=Z69.82^^91^1334^22
 ;;^UTILITY(U,$J,358.3,30852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30852,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,30852,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,30852,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,30853,0)
 ;;=T74.01XA^^91^1334^1
 ;;^UTILITY(U,$J,358.3,30853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30853,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,30853,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,30853,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,30854,0)
 ;;=T74.01XD^^91^1334^2
 ;;^UTILITY(U,$J,358.3,30854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30854,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30854,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,30854,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,30855,0)
 ;;=T76.01XA^^91^1334^3
 ;;^UTILITY(U,$J,358.3,30855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30855,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30855,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,30855,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,30856,0)
 ;;=T76.01XD^^91^1334^4
 ;;^UTILITY(U,$J,358.3,30856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30856,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,30856,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,30856,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,30857,0)
 ;;=Z91.412^^91^1334^40
 ;;^UTILITY(U,$J,358.3,30857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30857,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,30857,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,30857,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,30858,0)
 ;;=T74.31XA^^91^1334^9
 ;;^UTILITY(U,$J,358.3,30858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30858,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30858,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,30858,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,30859,0)
 ;;=T74.31XD^^91^1334^10
 ;;^UTILITY(U,$J,358.3,30859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30859,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30859,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,30859,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,30860,0)
 ;;=T76.31XA^^91^1334^11
 ;;^UTILITY(U,$J,358.3,30860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30860,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,30860,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,30860,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,30861,0)
 ;;=T76.31XD^^91^1334^12
 ;;^UTILITY(U,$J,358.3,30861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30861,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30861,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,30861,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,30862,0)
 ;;=Z91.411^^91^1334^41
 ;;^UTILITY(U,$J,358.3,30862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30862,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,30862,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,30862,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,30863,0)
 ;;=Z69.021^^91^1334^18
 ;;^UTILITY(U,$J,358.3,30863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30863,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,30863,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,30863,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,30864,0)
 ;;=Z69.021^^91^1334^19
 ;;^UTILITY(U,$J,358.3,30864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30864,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,30864,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,30864,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,30865,0)
 ;;=Z69.021^^91^1334^20
 ;;^UTILITY(U,$J,358.3,30865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30865,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,30865,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,30865,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,30866,0)
 ;;=Z69.021^^91^1334^21
 ;;^UTILITY(U,$J,358.3,30866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30866,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,30866,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,30866,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,30867,0)
 ;;=Z69.011^^91^1334^23
 ;;^UTILITY(U,$J,358.3,30867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30867,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,30867,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,30867,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,30868,0)
 ;;=Z69.011^^91^1334^24
 ;;^UTILITY(U,$J,358.3,30868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30868,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,30868,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,30868,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,30869,0)
 ;;=Z69.011^^91^1334^25
 ;;^UTILITY(U,$J,358.3,30869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30869,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,30869,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,30869,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,30870,0)
 ;;=Z69.011^^91^1334^26
 ;;^UTILITY(U,$J,358.3,30870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30870,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,30870,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,30870,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,30871,0)
 ;;=Z69.12^^91^1334^17
 ;;^UTILITY(U,$J,358.3,30871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30871,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,30871,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,30871,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,30872,0)
 ;;=Z69.12^^91^1334^28
 ;;^UTILITY(U,$J,358.3,30872,1,0)
 ;;=^358.31IA^4^2
