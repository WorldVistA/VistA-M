IBDEI1VN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31442,1,2,0)
 ;;=2^99342
 ;;^UTILITY(U,$J,358.3,31443,0)
 ;;=99343^^137^1424^3
 ;;^UTILITY(U,$J,358.3,31443,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31443,1,1,0)
 ;;=1^DETAILED HX & EXAM;LOW COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,31443,1,2,0)
 ;;=2^99343
 ;;^UTILITY(U,$J,358.3,31444,0)
 ;;=99344^^137^1424^4
 ;;^UTILITY(U,$J,358.3,31444,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31444,1,1,0)
 ;;=1^COMPREH HX & EXAM;MOD COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,31444,1,2,0)
 ;;=2^99344
 ;;^UTILITY(U,$J,358.3,31445,0)
 ;;=99345^^137^1424^5
 ;;^UTILITY(U,$J,358.3,31445,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,31445,1,1,0)
 ;;=1^COMPREH HX & EXAM;HIGH COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,31445,1,2,0)
 ;;=2^99345
 ;;^UTILITY(U,$J,358.3,31446,0)
 ;;=T74.11XA^^138^1425^8
 ;;^UTILITY(U,$J,358.3,31446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31446,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,31446,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,31446,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,31447,0)
 ;;=T74.11XD^^138^1425^9
 ;;^UTILITY(U,$J,358.3,31447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31447,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,31447,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,31447,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,31448,0)
 ;;=T76.11XA^^138^1425^10
 ;;^UTILITY(U,$J,358.3,31448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31448,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,31448,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,31448,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,31449,0)
 ;;=T76.11XD^^138^1425^11
 ;;^UTILITY(U,$J,358.3,31449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31449,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,31449,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,31449,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,31450,0)
 ;;=Z69.11^^138^1425^4
 ;;^UTILITY(U,$J,358.3,31450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31450,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,31450,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,31450,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,31451,0)
 ;;=Z91.410^^138^1425^5
 ;;^UTILITY(U,$J,358.3,31451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31451,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,31451,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,31451,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,31452,0)
 ;;=Z69.12^^138^1425^2
 ;;^UTILITY(U,$J,358.3,31452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31452,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,31452,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,31452,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,31453,0)
 ;;=T74.21XA^^138^1425^12
 ;;^UTILITY(U,$J,358.3,31453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31453,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,31453,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,31453,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,31454,0)
 ;;=T74.21XD^^138^1425^13
 ;;^UTILITY(U,$J,358.3,31454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31454,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
