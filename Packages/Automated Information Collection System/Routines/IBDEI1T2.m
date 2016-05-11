IBDEI1T2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30680,0)
 ;;=T74.11XA^^123^1529^5
 ;;^UTILITY(U,$J,358.3,30680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30680,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30680,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,30680,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,30681,0)
 ;;=T74.11XD^^123^1529^6
 ;;^UTILITY(U,$J,358.3,30681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30681,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30681,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,30681,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,30682,0)
 ;;=T76.11XA^^123^1529^7
 ;;^UTILITY(U,$J,358.3,30682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30682,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30682,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,30682,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,30683,0)
 ;;=T76.11XD^^123^1529^8
 ;;^UTILITY(U,$J,358.3,30683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30683,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,30683,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,30683,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,30684,0)
 ;;=Z69.11^^123^1529^28
 ;;^UTILITY(U,$J,358.3,30684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30684,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,30684,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,30684,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,30685,0)
 ;;=Z91.410^^123^1529^29
 ;;^UTILITY(U,$J,358.3,30685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30685,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,30685,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,30685,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,30686,0)
 ;;=Z69.12^^123^1529^26
 ;;^UTILITY(U,$J,358.3,30686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30686,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,30686,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,30686,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,30687,0)
 ;;=T74.21XA^^123^1529^13
 ;;^UTILITY(U,$J,358.3,30687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30687,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,30687,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,30687,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,30688,0)
 ;;=T74.21XD^^123^1529^14
 ;;^UTILITY(U,$J,358.3,30688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30688,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30688,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,30688,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,30689,0)
 ;;=T76.21XA^^123^1529^15
 ;;^UTILITY(U,$J,358.3,30689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30689,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30689,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,30689,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,30690,0)
 ;;=T76.21XD^^123^1529^16
 ;;^UTILITY(U,$J,358.3,30690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30690,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,30690,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,30690,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,30691,0)
 ;;=Z69.81^^123^1529^27
 ;;^UTILITY(U,$J,358.3,30691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30691,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,30691,1,4,0)
 ;;=4^Z69.81
