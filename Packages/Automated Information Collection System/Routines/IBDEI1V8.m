IBDEI1V8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29796,1,3,0)
 ;;=3^Group Therapeutic Procedure (2+ Indiv)
 ;;^UTILITY(U,$J,358.3,29797,0)
 ;;=96112^^119^1506^7^^^^1
 ;;^UTILITY(U,$J,358.3,29797,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29797,1,2,0)
 ;;=2^96112
 ;;^UTILITY(U,$J,358.3,29797,1,3,0)
 ;;=3^Dvlpmnt Tst by PhD w/ Intrp & Rpt,1st hr
 ;;^UTILITY(U,$J,358.3,29798,0)
 ;;=96113^^119^1506^8^^^^1
 ;;^UTILITY(U,$J,358.3,29798,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29798,1,2,0)
 ;;=2^96113
 ;;^UTILITY(U,$J,358.3,29798,1,3,0)
 ;;=3^Dvlpmnt Tst by PhD w/ Intrp & Rpt,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,29799,0)
 ;;=97129^^119^1506^21^^^^1
 ;;^UTILITY(U,$J,358.3,29799,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29799,1,2,0)
 ;;=2^97129
 ;;^UTILITY(U,$J,358.3,29799,1,3,0)
 ;;=3^Therapeutic Intrvn,1st 15 min
 ;;^UTILITY(U,$J,358.3,29800,0)
 ;;=97130^^119^1506^22^^^^1
 ;;^UTILITY(U,$J,358.3,29800,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29800,1,2,0)
 ;;=2^97130
 ;;^UTILITY(U,$J,358.3,29800,1,3,0)
 ;;=3^Therapeutic Intrvn,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,29801,0)
 ;;=96156^^119^1507^1^^^^1
 ;;^UTILITY(U,$J,358.3,29801,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29801,1,2,0)
 ;;=2^96156
 ;;^UTILITY(U,$J,358.3,29801,1,3,0)
 ;;=3^Hlth/Behav Assess/Re-Assess
 ;;^UTILITY(U,$J,358.3,29802,0)
 ;;=96158^^119^1507^8^^^^1
 ;;^UTILITY(U,$J,358.3,29802,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29802,1,2,0)
 ;;=2^96158
 ;;^UTILITY(U,$J,358.3,29802,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,1st 30 min
 ;;^UTILITY(U,$J,358.3,29803,0)
 ;;=96159^^119^1507^9^^^^1
 ;;^UTILITY(U,$J,358.3,29803,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29803,1,2,0)
 ;;=2^96159
 ;;^UTILITY(U,$J,358.3,29803,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Ind,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,29804,0)
 ;;=96164^^119^1507^6^^^^1
 ;;^UTILITY(U,$J,358.3,29804,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29804,1,2,0)
 ;;=2^96164
 ;;^UTILITY(U,$J,358.3,29804,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,1st 30 min
 ;;^UTILITY(U,$J,358.3,29805,0)
 ;;=96165^^119^1507^7^^^^1
 ;;^UTILITY(U,$J,358.3,29805,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29805,1,2,0)
 ;;=2^96165
 ;;^UTILITY(U,$J,358.3,29805,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Grp,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,29806,0)
 ;;=96167^^119^1507^2^^^^1
 ;;^UTILITY(U,$J,358.3,29806,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29806,1,2,0)
 ;;=2^96167
 ;;^UTILITY(U,$J,358.3,29806,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,29807,0)
 ;;=96168^^119^1507^3^^^^1
 ;;^UTILITY(U,$J,358.3,29807,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29807,1,2,0)
 ;;=2^96168
 ;;^UTILITY(U,$J,358.3,29807,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/ Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,29808,0)
 ;;=96170^^119^1507^4^^^^1
 ;;^UTILITY(U,$J,358.3,29808,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29808,1,2,0)
 ;;=2^96170
 ;;^UTILITY(U,$J,358.3,29808,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,1st 30 min
 ;;^UTILITY(U,$J,358.3,29809,0)
 ;;=96171^^119^1507^5^^^^1
 ;;^UTILITY(U,$J,358.3,29809,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29809,1,2,0)
 ;;=2^96171
 ;;^UTILITY(U,$J,358.3,29809,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,29810,0)
 ;;=99368^^119^1508^2^^^^1
 ;;^UTILITY(U,$J,358.3,29810,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29810,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,29810,1,3,0)
 ;;=3^Non-Rx Prov Team Conf w/o Pt &/or Family,30+ min
