IBDEI1G1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24529,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24529,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,24529,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,24530,0)
 ;;=T76.11XD^^93^1090^8
 ;;^UTILITY(U,$J,358.3,24530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24530,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24530,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,24530,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,24531,0)
 ;;=Z69.11^^93^1090^28
 ;;^UTILITY(U,$J,358.3,24531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24531,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,24531,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24531,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24532,0)
 ;;=Z91.410^^93^1090^29
 ;;^UTILITY(U,$J,358.3,24532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24532,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,24532,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,24532,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,24533,0)
 ;;=Z69.12^^93^1090^26
 ;;^UTILITY(U,$J,358.3,24533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24533,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,24533,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24533,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24534,0)
 ;;=T74.21XA^^93^1090^13
 ;;^UTILITY(U,$J,358.3,24534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24534,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24534,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,24534,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,24535,0)
 ;;=T74.21XD^^93^1090^14
 ;;^UTILITY(U,$J,358.3,24535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24535,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24535,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,24535,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,24536,0)
 ;;=T76.21XA^^93^1090^15
 ;;^UTILITY(U,$J,358.3,24536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24536,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24536,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,24536,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,24537,0)
 ;;=T76.21XD^^93^1090^16
 ;;^UTILITY(U,$J,358.3,24537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24537,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24537,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,24537,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,24538,0)
 ;;=Z69.81^^93^1090^27
 ;;^UTILITY(U,$J,358.3,24538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24538,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,24538,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,24538,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,24539,0)
 ;;=Z69.82^^93^1090^21
 ;;^UTILITY(U,$J,358.3,24539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24539,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,24539,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,24539,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,24540,0)
 ;;=T74.01XA^^93^1090^1
 ;;^UTILITY(U,$J,358.3,24540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24540,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24540,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,24540,2)
 ;;=^5054140
