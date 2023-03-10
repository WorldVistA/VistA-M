IBDEI0N6 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10431,1,2,0)
 ;;=2^Bamlanivimab Inf w/ Post Admin Monitoring
 ;;^UTILITY(U,$J,358.3,10431,1,3,0)
 ;;=3^M0245
 ;;^UTILITY(U,$J,358.3,10432,0)
 ;;=Q0245^^40^449^6^^^^1
 ;;^UTILITY(U,$J,358.3,10432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10432,1,2,0)
 ;;=2^Bamlanivivab 700mg 
 ;;^UTILITY(U,$J,358.3,10432,1,3,0)
 ;;=3^Q0245
 ;;^UTILITY(U,$J,358.3,10433,0)
 ;;=99490^^40^450^1^^^^1
 ;;^UTILITY(U,$J,358.3,10433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10433,1,2,0)
 ;;=2^Chr Care Mgmt Svc 1st 20 min per Month
 ;;^UTILITY(U,$J,358.3,10433,1,3,0)
 ;;=3^99490
 ;;^UTILITY(U,$J,358.3,10434,0)
 ;;=99491^^40^450^2^^^^1
 ;;^UTILITY(U,$J,358.3,10434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10434,1,2,0)
 ;;=2^Chr Care Mgmt Svc,30 min
 ;;^UTILITY(U,$J,358.3,10434,1,3,0)
 ;;=3^99491
 ;;^UTILITY(U,$J,358.3,10435,0)
 ;;=99437^^40^450^3^^^^1
 ;;^UTILITY(U,$J,358.3,10435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10435,1,2,0)
 ;;=2^Chr Care Mgmt Svc,Ea Addl 30 min,per Month
 ;;^UTILITY(U,$J,358.3,10435,1,3,0)
 ;;=3^99437
 ;;^UTILITY(U,$J,358.3,10436,0)
 ;;=G0438^^40^451^3^^^^1
 ;;^UTILITY(U,$J,358.3,10436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10436,1,2,0)
 ;;=2^Annual Wellness w/ PPPS,Init Visit
 ;;^UTILITY(U,$J,358.3,10436,1,3,0)
 ;;=3^G0438
 ;;^UTILITY(U,$J,358.3,10437,0)
 ;;=G0439^^40^451^4^^^^1
 ;;^UTILITY(U,$J,358.3,10437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10437,1,2,0)
 ;;=2^Annual Wellness w/ PPPS,Subsq Visit
 ;;^UTILITY(U,$J,358.3,10437,1,3,0)
 ;;=3^G0439
 ;;^UTILITY(U,$J,358.3,10438,0)
 ;;=G0442^^40^451^1^^^^1
 ;;^UTILITY(U,$J,358.3,10438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10438,1,2,0)
 ;;=2^Annual Alcohol Screen,15 min
 ;;^UTILITY(U,$J,358.3,10438,1,3,0)
 ;;=3^G0442
 ;;^UTILITY(U,$J,358.3,10439,0)
 ;;=G0444^^40^451^2^^^^1
 ;;^UTILITY(U,$J,358.3,10439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10439,1,2,0)
 ;;=2^Annual Depression Screen,15 min
 ;;^UTILITY(U,$J,358.3,10439,1,3,0)
 ;;=3^G0444
 ;;^UTILITY(U,$J,358.3,10440,0)
 ;;=99354^^40^452^1^^^^1
 ;;^UTILITY(U,$J,358.3,10440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10440,1,2,0)
 ;;=2^Prolong Svc O/P,1st hr
 ;;^UTILITY(U,$J,358.3,10440,1,3,0)
 ;;=3^99354
 ;;^UTILITY(U,$J,358.3,10441,0)
 ;;=99355^^40^452^2^^^^1
 ;;^UTILITY(U,$J,358.3,10441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10441,1,2,0)
 ;;=2^Prolong Svc O/P,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,10441,1,3,0)
 ;;=3^99355
 ;;^UTILITY(U,$J,358.3,10442,0)
 ;;=99358^^40^453^1^^^^1
 ;;^UTILITY(U,$J,358.3,10442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10442,1,2,0)
 ;;=2^Prolong Svc w/o Contact,1st hr
 ;;^UTILITY(U,$J,358.3,10442,1,3,0)
 ;;=3^99358
 ;;^UTILITY(U,$J,358.3,10443,0)
 ;;=99359^^40^453^2^^^^1
 ;;^UTILITY(U,$J,358.3,10443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10443,1,2,0)
 ;;=2^Prolong Svc w/o Contact,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,10443,1,3,0)
 ;;=3^99359
 ;;^UTILITY(U,$J,358.3,10444,0)
 ;;=99374^^40^454^1^^^^1
 ;;^UTILITY(U,$J,358.3,10444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10444,1,2,0)
 ;;=2^Home Health Supervision
 ;;^UTILITY(U,$J,358.3,10444,1,3,0)
 ;;=3^99374
 ;;^UTILITY(U,$J,358.3,10445,0)
 ;;=99375^^40^454^2^^^^1
 ;;^UTILITY(U,$J,358.3,10445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10445,1,2,0)
 ;;=2^Home Health Supervision,30 min
 ;;^UTILITY(U,$J,358.3,10445,1,3,0)
 ;;=3^99375
 ;;^UTILITY(U,$J,358.3,10446,0)
 ;;=99406^^40^455^1^^^^1
