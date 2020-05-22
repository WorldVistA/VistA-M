IBDEI2R2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43859,1,3,0)
 ;;=3^Train & Ed Svcs R/T Care & Tx of Disabling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,43860,0)
 ;;=S9454^^163^2163^3^^^^1
 ;;^UTILITY(U,$J,358.3,43860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43860,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,43860,1,3,0)
 ;;=3^Stress Mgmt Class
 ;;^UTILITY(U,$J,358.3,43861,0)
 ;;=99366^^163^2164^1^^^^1
 ;;^UTILITY(U,$J,358.3,43861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43861,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,43861,1,3,0)
 ;;=3^Non-Phy Team Conf w/ Pt &/or Fam,30 min+
 ;;^UTILITY(U,$J,358.3,43862,0)
 ;;=99368^^163^2164^2^^^^1
 ;;^UTILITY(U,$J,358.3,43862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43862,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,43862,1,3,0)
 ;;=3^Non-Phy Team Conf w/o Pt Present,30 min+
 ;;^UTILITY(U,$J,358.3,43863,0)
 ;;=99367^^163^2164^55^^^^1
 ;;^UTILITY(U,$J,358.3,43863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43863,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,43863,1,3,0)
 ;;=3^Team Conf w/o Pt or Fam,MD Prim,30+ min
 ;;^UTILITY(U,$J,358.3,43864,0)
 ;;=G0396^^163^2165^6^^^^1
 ;;^UTILITY(U,$J,358.3,43864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43864,1,2,0)
 ;;=2^G0396
 ;;^UTILITY(U,$J,358.3,43864,1,3,0)
 ;;=3^Substance Use Intervention,15-30 min
 ;;^UTILITY(U,$J,358.3,43865,0)
 ;;=G0397^^163^2165^5^^^^1
 ;;^UTILITY(U,$J,358.3,43865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43865,1,2,0)
 ;;=2^G0397
 ;;^UTILITY(U,$J,358.3,43865,1,3,0)
 ;;=3^Substance Use Intervention > 30 min
 ;;^UTILITY(U,$J,358.3,43866,0)
 ;;=H0004^^163^2165^4^^^^1
 ;;^UTILITY(U,$J,358.3,43866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43866,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,43866,1,3,0)
 ;;=3^Behav Hlth Counseling/Tx,per 15 min
 ;;^UTILITY(U,$J,358.3,43867,0)
 ;;=H0001^^163^2165^1^^^^1
 ;;^UTILITY(U,$J,358.3,43867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43867,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,43867,1,3,0)
 ;;=3^Alcohol and/or Drug Assessment
 ;;^UTILITY(U,$J,358.3,43868,0)
 ;;=H0005^^163^2165^3^^^^1
 ;;^UTILITY(U,$J,358.3,43868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43868,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,43868,1,3,0)
 ;;=3^Alcohol/Drug Counseling,Group
 ;;^UTILITY(U,$J,358.3,43869,0)
 ;;=H0006^^163^2165^2^^^^1
 ;;^UTILITY(U,$J,358.3,43869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43869,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,43869,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,43870,0)
 ;;=T74.11XA^^164^2166^7
 ;;^UTILITY(U,$J,358.3,43870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43870,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Init Enctr
 ;;^UTILITY(U,$J,358.3,43870,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,43870,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,43871,0)
 ;;=T74.11XD^^164^2166^8
 ;;^UTILITY(U,$J,358.3,43871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43871,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subs Enctr
 ;;^UTILITY(U,$J,358.3,43871,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,43871,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,43872,0)
 ;;=T76.11XA^^164^2166^9
 ;;^UTILITY(U,$J,358.3,43872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43872,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Init Enctr
 ;;^UTILITY(U,$J,358.3,43872,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,43872,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,43873,0)
 ;;=T76.11XD^^164^2166^10
