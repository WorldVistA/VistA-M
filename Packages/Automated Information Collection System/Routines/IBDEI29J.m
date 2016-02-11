IBDEI29J ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38010,1,3,0)
 ;;=3^Respiratory Arrest
 ;;^UTILITY(U,$J,358.3,38010,1,4,0)
 ;;=4^R09.2
 ;;^UTILITY(U,$J,358.3,38010,2)
 ;;=^276886
 ;;^UTILITY(U,$J,358.3,38011,0)
 ;;=Z87.09^^175^1912^13
 ;;^UTILITY(U,$J,358.3,38011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38011,1,3,0)
 ;;=3^Personal Hx of Respiratory System Diseases
 ;;^UTILITY(U,$J,358.3,38011,1,4,0)
 ;;=4^Z87.09
 ;;^UTILITY(U,$J,358.3,38011,2)
 ;;=^5063481
 ;;^UTILITY(U,$J,358.3,38012,0)
 ;;=Z87.01^^175^1912^12
 ;;^UTILITY(U,$J,358.3,38012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38012,1,3,0)
 ;;=3^Personal Hx of Recurrent Pneumonia
 ;;^UTILITY(U,$J,358.3,38012,1,4,0)
 ;;=4^Z87.01
 ;;^UTILITY(U,$J,358.3,38012,2)
 ;;=^5063480
 ;;^UTILITY(U,$J,358.3,38013,0)
 ;;=H0038^^176^1913^1^^^^1
 ;;^UTILITY(U,$J,358.3,38013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38013,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,38013,1,3,0)
 ;;=3^Self-Help/Peer Svc,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,38014,0)
 ;;=T74.11XA^^177^1914^8
 ;;^UTILITY(U,$J,358.3,38014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38014,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,38014,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,38014,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,38015,0)
 ;;=T74.11XD^^177^1914^9
 ;;^UTILITY(U,$J,358.3,38015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38015,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,38015,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,38015,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,38016,0)
 ;;=T76.11XA^^177^1914^10
 ;;^UTILITY(U,$J,358.3,38016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38016,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,38016,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,38016,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,38017,0)
 ;;=T76.11XD^^177^1914^11
 ;;^UTILITY(U,$J,358.3,38017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38017,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,38017,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,38017,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,38018,0)
 ;;=Z69.11^^177^1914^4
 ;;^UTILITY(U,$J,358.3,38018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38018,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,38018,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,38018,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,38019,0)
 ;;=Z91.410^^177^1914^5
 ;;^UTILITY(U,$J,358.3,38019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38019,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,38019,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,38019,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,38020,0)
 ;;=Z69.12^^177^1914^2
 ;;^UTILITY(U,$J,358.3,38020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38020,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,38020,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,38020,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,38021,0)
 ;;=T74.21XA^^177^1914^12
 ;;^UTILITY(U,$J,358.3,38021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38021,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,38021,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,38021,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,38022,0)
 ;;=T74.21XD^^177^1914^13
