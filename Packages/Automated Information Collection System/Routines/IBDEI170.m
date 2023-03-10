IBDEI170 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19365,1,2,0)
 ;;=2^Diphenhydramine/Benadryl up to 50 mg
 ;;^UTILITY(U,$J,358.3,19365,1,3,0)
 ;;=3^J1200
 ;;^UTILITY(U,$J,358.3,19366,0)
 ;;=J0585^^66^859^1^^^^1
 ;;^UTILITY(U,$J,358.3,19366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19366,1,2,0)
 ;;=2^Botulinum Toxin Type A,Botox,Dysport per unit
 ;;^UTILITY(U,$J,358.3,19366,1,3,0)
 ;;=3^J0585
 ;;^UTILITY(U,$J,358.3,19367,0)
 ;;=J0587^^66^859^2^^^^1
 ;;^UTILITY(U,$J,358.3,19367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19367,1,2,0)
 ;;=2^Botulinum Toxin Type B,Myobloc per 100 units
 ;;^UTILITY(U,$J,358.3,19367,1,3,0)
 ;;=3^J0587
 ;;^UTILITY(U,$J,358.3,19368,0)
 ;;=97760^^66^860^1^^^^1
 ;;^UTILITY(U,$J,358.3,19368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19368,1,2,0)
 ;;=2^Orthotic Mgmt and Training,ea 15min
 ;;^UTILITY(U,$J,358.3,19368,1,3,0)
 ;;=3^97760
 ;;^UTILITY(U,$J,358.3,19369,0)
 ;;=97761^^66^860^2^^^^1
 ;;^UTILITY(U,$J,358.3,19369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19369,1,2,0)
 ;;=2^Prosthetic Training,ea 15min
 ;;^UTILITY(U,$J,358.3,19369,1,3,0)
 ;;=3^97761
 ;;^UTILITY(U,$J,358.3,19370,0)
 ;;=97763^^66^860^3^^^^1
 ;;^UTILITY(U,$J,358.3,19370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19370,1,2,0)
 ;;=2^Prosthetic/Orthotic F/U Mgmt/Trng,Ea 15 min
 ;;^UTILITY(U,$J,358.3,19370,1,3,0)
 ;;=3^97763
 ;;^UTILITY(U,$J,358.3,19371,0)
 ;;=97110^^66^861^7^^^^1
 ;;^UTILITY(U,$J,358.3,19371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19371,1,2,0)
 ;;=2^Therapeutic Exercises, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,19371,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,19372,0)
 ;;=97750^^66^861^5^^^^1
 ;;^UTILITY(U,$J,358.3,19372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19372,1,2,0)
 ;;=2^Physical Perform Test, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,19372,1,3,0)
 ;;=3^97750
 ;;^UTILITY(U,$J,358.3,19373,0)
 ;;=97112^^66^861^4^^^^1
 ;;^UTILITY(U,$J,358.3,19373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19373,1,2,0)
 ;;=2^Neuromuscular Reeduc,  Ea 15 Min
 ;;^UTILITY(U,$J,358.3,19373,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,19374,0)
 ;;=97113^^66^861^1^^^^1
 ;;^UTILITY(U,$J,358.3,19374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19374,1,2,0)
 ;;=2^Aquatic Exercises,ea 15min
 ;;^UTILITY(U,$J,358.3,19374,1,3,0)
 ;;=3^97113
 ;;^UTILITY(U,$J,358.3,19375,0)
 ;;=97116^^66^861^3^^^^1
 ;;^UTILITY(U,$J,358.3,19375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19375,1,2,0)
 ;;=2^Gait Training, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,19375,1,3,0)
 ;;=3^97116
 ;;^UTILITY(U,$J,358.3,19376,0)
 ;;=97150^^66^861^8^^^^1
 ;;^UTILITY(U,$J,358.3,19376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19376,1,2,0)
 ;;=2^Therapeutic Proc, Group, 2+ Ind
 ;;^UTILITY(U,$J,358.3,19376,1,3,0)
 ;;=3^97150
 ;;^UTILITY(U,$J,358.3,19377,0)
 ;;=97530^^66^861^6^^^^1
 ;;^UTILITY(U,$J,358.3,19377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19377,1,2,0)
 ;;=2^Therapeutic Dynamic Activity,1-1,ea 15min
 ;;^UTILITY(U,$J,358.3,19377,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,19378,0)
 ;;=97537^^66^861^2^^^^1
 ;;^UTILITY(U,$J,358.3,19378,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19378,1,2,0)
 ;;=2^Community/Work Reintegration, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,19378,1,3,0)
 ;;=3^97537
 ;;^UTILITY(U,$J,358.3,19379,0)
 ;;=97542^^66^861^9^^^^1
 ;;^UTILITY(U,$J,358.3,19379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19379,1,2,0)
 ;;=2^Wheelchair Training,ea 15 Min
