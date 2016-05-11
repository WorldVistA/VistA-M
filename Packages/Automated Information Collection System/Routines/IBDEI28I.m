IBDEI28I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37914,0)
 ;;=99420^^144^1825^1^^^^1
 ;;^UTILITY(U,$J,358.3,37914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37914,1,2,0)
 ;;=2^99420
 ;;^UTILITY(U,$J,358.3,37914,1,3,0)
 ;;=3^Admin/Int Hlth Risk Assess Tst
 ;;^UTILITY(U,$J,358.3,37915,0)
 ;;=S9445^^144^1826^3^^^^1
 ;;^UTILITY(U,$J,358.3,37915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37915,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,37915,1,3,0)
 ;;=3^Pt Educ,Individual,NOS
 ;;^UTILITY(U,$J,358.3,37916,0)
 ;;=S9446^^144^1826^2^^^^1
 ;;^UTILITY(U,$J,358.3,37916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37916,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,37916,1,3,0)
 ;;=3^Pt Educ,Group,NOS
 ;;^UTILITY(U,$J,358.3,37917,0)
 ;;=G0177^^144^1826^1^^^^1
 ;;^UTILITY(U,$J,358.3,37917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37917,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,37917,1,3,0)
 ;;=3^Train & Ed Svcs R/T Care & Tx of Disabling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,37918,0)
 ;;=S9454^^144^1826^4^^^^1
 ;;^UTILITY(U,$J,358.3,37918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37918,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,37918,1,3,0)
 ;;=3^Stress Mgmt Class
 ;;^UTILITY(U,$J,358.3,37919,0)
 ;;=99366^^144^1827^1^^^^1
 ;;^UTILITY(U,$J,358.3,37919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37919,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,37919,1,3,0)
 ;;=3^Non-Phy Team Conf w/ Pt &/or Fam,30 min+
 ;;^UTILITY(U,$J,358.3,37920,0)
 ;;=T74.11XA^^145^1828^5
 ;;^UTILITY(U,$J,358.3,37920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37920,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,37920,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,37920,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,37921,0)
 ;;=T74.11XD^^145^1828^6
 ;;^UTILITY(U,$J,358.3,37921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37921,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,37921,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,37921,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,37922,0)
 ;;=T76.11XA^^145^1828^7
 ;;^UTILITY(U,$J,358.3,37922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37922,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,37922,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,37922,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,37923,0)
 ;;=T76.11XD^^145^1828^8
 ;;^UTILITY(U,$J,358.3,37923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37923,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,37923,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,37923,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,37924,0)
 ;;=Z69.11^^145^1828^28
 ;;^UTILITY(U,$J,358.3,37924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37924,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,37924,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,37924,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,37925,0)
 ;;=Z91.410^^145^1828^29
 ;;^UTILITY(U,$J,358.3,37925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37925,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,37925,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,37925,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,37926,0)
 ;;=Z69.12^^145^1828^26
 ;;^UTILITY(U,$J,358.3,37926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37926,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,37926,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,37926,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,37927,0)
 ;;=T74.21XA^^145^1828^13
