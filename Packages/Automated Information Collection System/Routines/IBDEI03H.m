IBDEI03H ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1196,1,3,0)
 ;;=3^Caloric Vestibular Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1197,0)
 ;;=92534^^7^122^4^^^^1
 ;;^UTILITY(U,$J,358.3,1197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1197,1,2,0)
 ;;=2^92534
 ;;^UTILITY(U,$J,358.3,1197,1,3,0)
 ;;=3^Opokinetic Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1198,0)
 ;;=92626^^7^123^3^^^^1
 ;;^UTILITY(U,$J,358.3,1198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1198,1,2,0)
 ;;=2^92626
 ;;^UTILITY(U,$J,358.3,1198,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,1st Hr
 ;;^UTILITY(U,$J,358.3,1199,0)
 ;;=92627^^7^123^4^^^^1
 ;;^UTILITY(U,$J,358.3,1199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1199,1,2,0)
 ;;=2^92627
 ;;^UTILITY(U,$J,358.3,1199,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,1200,0)
 ;;=92630^^7^123^1^^^^1
 ;;^UTILITY(U,$J,358.3,1200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1200,1,2,0)
 ;;=2^92630
 ;;^UTILITY(U,$J,358.3,1200,1,3,0)
 ;;=3^Auditory Rehab;Prelingual Hearing Loss
 ;;^UTILITY(U,$J,358.3,1201,0)
 ;;=92633^^7^123^2^^^^1
 ;;^UTILITY(U,$J,358.3,1201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1201,1,2,0)
 ;;=2^92633
 ;;^UTILITY(U,$J,358.3,1201,1,3,0)
 ;;=3^Auditory Rehab;Postlingual Hearing Loss
 ;;^UTILITY(U,$J,358.3,1202,0)
 ;;=92625^^7^123^5^^^^1
 ;;^UTILITY(U,$J,358.3,1202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1202,1,2,0)
 ;;=2^92625
 ;;^UTILITY(U,$J,358.3,1202,1,3,0)
 ;;=3^Tinnitus Assessment
 ;;^UTILITY(U,$J,358.3,1203,0)
 ;;=99366^^7^124^1^^^^1
 ;;^UTILITY(U,$J,358.3,1203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1203,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,1203,1,3,0)
 ;;=3^Team Conf w/ Pt by HC Pro,30 Min
 ;;^UTILITY(U,$J,358.3,1204,0)
 ;;=99368^^7^124^2^^^^1
 ;;^UTILITY(U,$J,358.3,1204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1204,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,1204,1,3,0)
 ;;=3^Team Conf w/o Pt by HC Pro,30 Min
 ;;^UTILITY(U,$J,358.3,1205,0)
 ;;=99415^^7^125^1^^^^1
 ;;^UTILITY(U,$J,358.3,1205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1205,1,2,0)
 ;;=2^99415
 ;;^UTILITY(U,$J,358.3,1205,1,3,0)
 ;;=3^Prolonged Clin Staff Svc;1st hr
 ;;^UTILITY(U,$J,358.3,1206,0)
 ;;=99416^^7^125^2^^^^1
 ;;^UTILITY(U,$J,358.3,1206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1206,1,2,0)
 ;;=2^99416
 ;;^UTILITY(U,$J,358.3,1206,1,3,0)
 ;;=3^Prolonged Clin Staff Svc;Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,1207,0)
 ;;=S04.61XA^^8^126^4
 ;;^UTILITY(U,$J,358.3,1207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1207,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, initial encounter
 ;;^UTILITY(U,$J,358.3,1207,1,4,0)
 ;;=4^S04.61XA
 ;;^UTILITY(U,$J,358.3,1207,2)
 ;;=^5020540
 ;;^UTILITY(U,$J,358.3,1208,0)
 ;;=S04.61XD^^8^126^5
 ;;^UTILITY(U,$J,358.3,1208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1208,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1208,1,4,0)
 ;;=4^S04.61XD
 ;;^UTILITY(U,$J,358.3,1208,2)
 ;;=^5020541
 ;;^UTILITY(U,$J,358.3,1209,0)
 ;;=S04.61XS^^8^126^6
 ;;^UTILITY(U,$J,358.3,1209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1209,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, sequela
 ;;^UTILITY(U,$J,358.3,1209,1,4,0)
 ;;=4^S04.61XS
 ;;^UTILITY(U,$J,358.3,1209,2)
 ;;=^5020542
 ;;^UTILITY(U,$J,358.3,1210,0)
 ;;=S04.62XA^^8^126^1
 ;;^UTILITY(U,$J,358.3,1210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1210,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, initial encounter
 ;;^UTILITY(U,$J,358.3,1210,1,4,0)
 ;;=4^S04.62XA
 ;;^UTILITY(U,$J,358.3,1210,2)
 ;;=^5020543
 ;;^UTILITY(U,$J,358.3,1211,0)
 ;;=S04.62XD^^8^126^3
