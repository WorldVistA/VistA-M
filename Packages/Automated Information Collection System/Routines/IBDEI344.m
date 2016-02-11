IBDEI344 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52246,0)
 ;;=96153^^236^2585^6^^^^1
 ;;^UTILITY(U,$J,358.3,52246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52246,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,52246,1,3,0)
 ;;=3^Inter Hlth/Beh,Grp Ea 15min
 ;;^UTILITY(U,$J,358.3,52247,0)
 ;;=96154^^236^2585^5^^^^1
 ;;^UTILITY(U,$J,358.3,52247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52247,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,52247,1,3,0)
 ;;=3^Inter Hlth/Beh,Fam w/Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,52248,0)
 ;;=96155^^236^2585^4^^^^1
 ;;^UTILITY(U,$J,358.3,52248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52248,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,52248,1,3,0)
 ;;=3^Int Hlth/Beh Fam w/o Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,52249,0)
 ;;=99420^^236^2585^1^^^^1
 ;;^UTILITY(U,$J,358.3,52249,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52249,1,2,0)
 ;;=2^99420
 ;;^UTILITY(U,$J,358.3,52249,1,3,0)
 ;;=3^Admin/Int Hlth Risk Assess Tst
 ;;^UTILITY(U,$J,358.3,52250,0)
 ;;=S9445^^236^2586^3^^^^1
 ;;^UTILITY(U,$J,358.3,52250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52250,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,52250,1,3,0)
 ;;=3^Pt Educ,Individual,NOS
 ;;^UTILITY(U,$J,358.3,52251,0)
 ;;=S9446^^236^2586^2^^^^1
 ;;^UTILITY(U,$J,358.3,52251,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52251,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,52251,1,3,0)
 ;;=3^Pt Educ,Group,NOS
 ;;^UTILITY(U,$J,358.3,52252,0)
 ;;=G0177^^236^2586^1^^^^1
 ;;^UTILITY(U,$J,358.3,52252,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52252,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,52252,1,3,0)
 ;;=3^Train & Ed Svcs R/T Care & Tx of Disabling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,52253,0)
 ;;=S9454^^236^2586^4^^^^1
 ;;^UTILITY(U,$J,358.3,52253,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52253,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,52253,1,3,0)
 ;;=3^Stress Mgmt Class
 ;;^UTILITY(U,$J,358.3,52254,0)
 ;;=99366^^236^2587^1^^^^1
 ;;^UTILITY(U,$J,358.3,52254,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52254,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,52254,1,3,0)
 ;;=3^Non-Phy Team Conf w/ Pt &/or Fam,30 min+
 ;;^UTILITY(U,$J,358.3,52255,0)
 ;;=T74.11XA^^237^2588^8
 ;;^UTILITY(U,$J,358.3,52255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52255,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,52255,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,52255,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,52256,0)
 ;;=T74.11XD^^237^2588^9
 ;;^UTILITY(U,$J,358.3,52256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52256,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,52256,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,52256,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,52257,0)
 ;;=T76.11XA^^237^2588^10
 ;;^UTILITY(U,$J,358.3,52257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52257,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,52257,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,52257,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,52258,0)
 ;;=T76.11XD^^237^2588^11
 ;;^UTILITY(U,$J,358.3,52258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52258,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,52258,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,52258,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,52259,0)
 ;;=Z69.11^^237^2588^4
 ;;^UTILITY(U,$J,358.3,52259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52259,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
