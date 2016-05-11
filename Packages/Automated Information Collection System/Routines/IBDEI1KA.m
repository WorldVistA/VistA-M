IBDEI1KA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26495,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,26495,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,26495,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,26496,0)
 ;;=Z69.12^^100^1265^26
 ;;^UTILITY(U,$J,358.3,26496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26496,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,26496,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,26496,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,26497,0)
 ;;=T74.21XA^^100^1265^13
 ;;^UTILITY(U,$J,358.3,26497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26497,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,26497,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,26497,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,26498,0)
 ;;=T74.21XD^^100^1265^14
 ;;^UTILITY(U,$J,358.3,26498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26498,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26498,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,26498,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,26499,0)
 ;;=T76.21XA^^100^1265^15
 ;;^UTILITY(U,$J,358.3,26499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26499,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26499,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,26499,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,26500,0)
 ;;=T76.21XD^^100^1265^16
 ;;^UTILITY(U,$J,358.3,26500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26500,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,26500,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,26500,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,26501,0)
 ;;=Z69.81^^100^1265^27
 ;;^UTILITY(U,$J,358.3,26501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26501,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,26501,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,26501,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,26502,0)
 ;;=Z69.82^^100^1265^21
 ;;^UTILITY(U,$J,358.3,26502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26502,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,26502,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,26502,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,26503,0)
 ;;=T74.01XA^^100^1265^1
 ;;^UTILITY(U,$J,358.3,26503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26503,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,26503,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,26503,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,26504,0)
 ;;=T74.01XD^^100^1265^2
 ;;^UTILITY(U,$J,358.3,26504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26504,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26504,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,26504,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,26505,0)
 ;;=T76.01XA^^100^1265^3
 ;;^UTILITY(U,$J,358.3,26505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26505,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26505,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,26505,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,26506,0)
 ;;=T76.01XD^^100^1265^4
 ;;^UTILITY(U,$J,358.3,26506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26506,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,26506,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,26506,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,26507,0)
 ;;=Z91.412^^100^1265^31
