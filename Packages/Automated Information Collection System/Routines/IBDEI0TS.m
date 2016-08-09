IBDEI0TS ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29964,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,29964,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,29964,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,29965,0)
 ;;=T74.11XD^^113^1441^6
 ;;^UTILITY(U,$J,358.3,29965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29965,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,29965,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,29965,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,29966,0)
 ;;=T76.11XA^^113^1441^7
 ;;^UTILITY(U,$J,358.3,29966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29966,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,29966,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,29966,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,29967,0)
 ;;=T76.11XD^^113^1441^8
 ;;^UTILITY(U,$J,358.3,29967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29967,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,29967,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,29967,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,29968,0)
 ;;=Z69.11^^113^1441^31
 ;;^UTILITY(U,$J,358.3,29968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29968,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,29968,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,29968,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,29969,0)
 ;;=Z91.410^^113^1441^35
 ;;^UTILITY(U,$J,358.3,29969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29969,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,29969,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,29969,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,29970,0)
 ;;=Z69.12^^113^1441^27
 ;;^UTILITY(U,$J,358.3,29970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29970,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,29970,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,29970,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,29971,0)
 ;;=T74.21XA^^113^1441^13
 ;;^UTILITY(U,$J,358.3,29971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29971,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,29971,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,29971,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,29972,0)
 ;;=T74.21XD^^113^1441^14
 ;;^UTILITY(U,$J,358.3,29972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29972,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,29972,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,29972,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,29973,0)
 ;;=T76.21XA^^113^1441^15
 ;;^UTILITY(U,$J,358.3,29973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29973,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,29973,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,29973,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,29974,0)
 ;;=T76.21XD^^113^1441^16
 ;;^UTILITY(U,$J,358.3,29974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29974,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,29974,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,29974,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,29975,0)
 ;;=Z69.81^^113^1441^30
 ;;^UTILITY(U,$J,358.3,29975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29975,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,29975,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,29975,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,29976,0)
 ;;=Z69.82^^113^1441^22
 ;;^UTILITY(U,$J,358.3,29976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29976,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,29976,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,29976,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,29977,0)
 ;;=T74.01XA^^113^1441^1
 ;;^UTILITY(U,$J,358.3,29977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29977,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,29977,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,29977,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,29978,0)
 ;;=T74.01XD^^113^1441^2
 ;;^UTILITY(U,$J,358.3,29978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29978,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,29978,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,29978,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,29979,0)
 ;;=T76.01XA^^113^1441^3
 ;;^UTILITY(U,$J,358.3,29979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29979,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,29979,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,29979,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,29980,0)
 ;;=T76.01XD^^113^1441^4
 ;;^UTILITY(U,$J,358.3,29980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29980,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,29980,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,29980,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,29981,0)
 ;;=Z91.412^^113^1441^40
 ;;^UTILITY(U,$J,358.3,29981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29981,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,29981,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,29981,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,29982,0)
 ;;=T74.31XA^^113^1441^9
 ;;^UTILITY(U,$J,358.3,29982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29982,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,29982,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,29982,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,29983,0)
 ;;=T74.31XD^^113^1441^10
 ;;^UTILITY(U,$J,358.3,29983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29983,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,29983,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,29983,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,29984,0)
 ;;=T76.31XA^^113^1441^11
 ;;^UTILITY(U,$J,358.3,29984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29984,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,29984,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,29984,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,29985,0)
 ;;=T76.31XD^^113^1441^12
 ;;^UTILITY(U,$J,358.3,29985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29985,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,29985,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,29985,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,29986,0)
 ;;=Z91.411^^113^1441^41
 ;;^UTILITY(U,$J,358.3,29986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29986,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,29986,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,29986,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,29987,0)
 ;;=Z69.021^^113^1441^18
 ;;^UTILITY(U,$J,358.3,29987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29987,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,29987,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,29987,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,29988,0)
 ;;=Z69.021^^113^1441^19
 ;;^UTILITY(U,$J,358.3,29988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29988,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,29988,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,29988,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,29989,0)
 ;;=Z69.021^^113^1441^20
 ;;^UTILITY(U,$J,358.3,29989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29989,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,29989,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,29989,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,29990,0)
 ;;=Z69.021^^113^1441^21
