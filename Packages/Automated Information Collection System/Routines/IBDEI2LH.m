IBDEI2LH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41426,1,3,0)
 ;;=3^J1200
 ;;^UTILITY(U,$J,358.3,41427,0)
 ;;=J0585^^154^2041^1^^^^1
 ;;^UTILITY(U,$J,358.3,41427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41427,1,2,0)
 ;;=2^Botulinum Toxin Type A,Botox,Dysport per unit
 ;;^UTILITY(U,$J,358.3,41427,1,3,0)
 ;;=3^J0585
 ;;^UTILITY(U,$J,358.3,41428,0)
 ;;=J0587^^154^2041^2^^^^1
 ;;^UTILITY(U,$J,358.3,41428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41428,1,2,0)
 ;;=2^Botulinum Toxin Type B,Myobloc per 100 units
 ;;^UTILITY(U,$J,358.3,41428,1,3,0)
 ;;=3^J0587
 ;;^UTILITY(U,$J,358.3,41429,0)
 ;;=97760^^154^2042^1^^^^1
 ;;^UTILITY(U,$J,358.3,41429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41429,1,2,0)
 ;;=2^Orthotic Mgmt and Training,ea 15min
 ;;^UTILITY(U,$J,358.3,41429,1,3,0)
 ;;=3^97760
 ;;^UTILITY(U,$J,358.3,41430,0)
 ;;=97761^^154^2042^2^^^^1
 ;;^UTILITY(U,$J,358.3,41430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41430,1,2,0)
 ;;=2^Prosthetic Training,ea 15min
 ;;^UTILITY(U,$J,358.3,41430,1,3,0)
 ;;=3^97761
 ;;^UTILITY(U,$J,358.3,41431,0)
 ;;=97763^^154^2042^3^^^^1
 ;;^UTILITY(U,$J,358.3,41431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41431,1,2,0)
 ;;=2^Prosthetic/Orthotic F/U Mgmt/Trng,Ea 15 min
 ;;^UTILITY(U,$J,358.3,41431,1,3,0)
 ;;=3^97763
 ;;^UTILITY(U,$J,358.3,41432,0)
 ;;=97110^^154^2043^7^^^^1
 ;;^UTILITY(U,$J,358.3,41432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41432,1,2,0)
 ;;=2^Therapeutic Exercises, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,41432,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,41433,0)
 ;;=97750^^154^2043^5^^^^1
 ;;^UTILITY(U,$J,358.3,41433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41433,1,2,0)
 ;;=2^Physical Perform Test, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,41433,1,3,0)
 ;;=3^97750
 ;;^UTILITY(U,$J,358.3,41434,0)
 ;;=97112^^154^2043^4^^^^1
 ;;^UTILITY(U,$J,358.3,41434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41434,1,2,0)
 ;;=2^Neuromuscular Reeduc,  Ea 15 Min
 ;;^UTILITY(U,$J,358.3,41434,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,41435,0)
 ;;=97113^^154^2043^1^^^^1
 ;;^UTILITY(U,$J,358.3,41435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41435,1,2,0)
 ;;=2^Aquatic Exercises,ea 15min
 ;;^UTILITY(U,$J,358.3,41435,1,3,0)
 ;;=3^97113
 ;;^UTILITY(U,$J,358.3,41436,0)
 ;;=97116^^154^2043^3^^^^1
 ;;^UTILITY(U,$J,358.3,41436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41436,1,2,0)
 ;;=2^Gait Training, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,41436,1,3,0)
 ;;=3^97116
 ;;^UTILITY(U,$J,358.3,41437,0)
 ;;=97150^^154^2043^8^^^^1
 ;;^UTILITY(U,$J,358.3,41437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41437,1,2,0)
 ;;=2^Therapeutic Proc, Group, 2+ Ind
 ;;^UTILITY(U,$J,358.3,41437,1,3,0)
 ;;=3^97150
 ;;^UTILITY(U,$J,358.3,41438,0)
 ;;=97530^^154^2043^6^^^^1
 ;;^UTILITY(U,$J,358.3,41438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41438,1,2,0)
 ;;=2^Therapeutic Dynamic Activity,1-1,ea 15min
 ;;^UTILITY(U,$J,358.3,41438,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,41439,0)
 ;;=97537^^154^2043^2^^^^1
 ;;^UTILITY(U,$J,358.3,41439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41439,1,2,0)
 ;;=2^Community/Work Reintegration, Ea 15 Min
 ;;^UTILITY(U,$J,358.3,41439,1,3,0)
 ;;=3^97537
 ;;^UTILITY(U,$J,358.3,41440,0)
 ;;=97542^^154^2043^9^^^^1
 ;;^UTILITY(U,$J,358.3,41440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41440,1,2,0)
 ;;=2^Wheelchair Training,ea 15 Min
 ;;^UTILITY(U,$J,358.3,41440,1,3,0)
 ;;=3^97542
 ;;^UTILITY(U,$J,358.3,41441,0)
 ;;=97750^^154^2044^11^^^^1
