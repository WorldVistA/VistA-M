IBDEI01A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,100,0)
 ;;=99343^^2^21^3
 ;;^UTILITY(U,$J,358.3,100,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,100,1,1,0)
 ;;=1^DETAILED HX & EXAM;LOW COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,100,1,2,0)
 ;;=2^99343
 ;;^UTILITY(U,$J,358.3,101,0)
 ;;=99344^^2^21^4
 ;;^UTILITY(U,$J,358.3,101,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,101,1,1,0)
 ;;=1^COMPREH HX & EXAM;MOD COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,101,1,2,0)
 ;;=2^99344
 ;;^UTILITY(U,$J,358.3,102,0)
 ;;=99345^^2^21^5
 ;;^UTILITY(U,$J,358.3,102,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,102,1,1,0)
 ;;=1^COMPREH HX & EXAM;HIGH COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,102,1,2,0)
 ;;=2^99345
 ;;^UTILITY(U,$J,358.3,103,0)
 ;;=99366^^2^22^1
 ;;^UTILITY(U,$J,358.3,103,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,103,1,1,0)
 ;;=1^Interdisc Tm Conf w/ Pt/Fam,30+min,Non-Phys
 ;;^UTILITY(U,$J,358.3,103,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,104,0)
 ;;=99367^^2^22^3
 ;;^UTILITY(U,$J,358.3,104,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,104,1,1,0)
 ;;=1^Interdisc Tm Conf w/o Pt/Fam,30+min,Physician
 ;;^UTILITY(U,$J,358.3,104,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,105,0)
 ;;=99368^^2^22^2
 ;;^UTILITY(U,$J,358.3,105,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,105,1,1,0)
 ;;=1^Interdisc Tm Conf w/o Pt/Fam,30+min,Non-Phys
 ;;^UTILITY(U,$J,358.3,105,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,106,0)
 ;;=T74.11XA^^3^23^5
 ;;^UTILITY(U,$J,358.3,106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,106,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,106,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,106,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,107,0)
 ;;=T74.11XD^^3^23^6
 ;;^UTILITY(U,$J,358.3,107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,107,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,107,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,107,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,108,0)
 ;;=T76.11XA^^3^23^7
 ;;^UTILITY(U,$J,358.3,108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,108,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,108,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,108,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,109,0)
 ;;=T76.11XD^^3^23^8
 ;;^UTILITY(U,$J,358.3,109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,109,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,109,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,109,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,110,0)
 ;;=Z69.11^^3^23^28
 ;;^UTILITY(U,$J,358.3,110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,110,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,110,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,110,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,111,0)
 ;;=Z91.410^^3^23^29
 ;;^UTILITY(U,$J,358.3,111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,111,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,111,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,111,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,112,0)
 ;;=Z69.12^^3^23^26
 ;;^UTILITY(U,$J,358.3,112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,112,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,112,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,112,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,113,0)
 ;;=T74.21XA^^3^23^13
 ;;^UTILITY(U,$J,358.3,113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,113,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,113,1,4,0)
 ;;=4^T74.21XA
