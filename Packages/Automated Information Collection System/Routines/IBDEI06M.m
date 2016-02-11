IBDEI06M ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2496,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,2496,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,2497,0)
 ;;=T82.847A^^19^205^7
 ;;^UTILITY(U,$J,358.3,2497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2497,1,3,0)
 ;;=3^Pain from Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2497,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,2497,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,2498,0)
 ;;=Z45.09^^19^205^1
 ;;^UTILITY(U,$J,358.3,2498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2498,1,3,0)
 ;;=3^Adjustment/Management of Cardiac Device
 ;;^UTILITY(U,$J,358.3,2498,1,4,0)
 ;;=4^Z45.09
 ;;^UTILITY(U,$J,358.3,2498,2)
 ;;=^5062997
 ;;^UTILITY(U,$J,358.3,2499,0)
 ;;=Z01.810^^19^205^8
 ;;^UTILITY(U,$J,358.3,2499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2499,1,3,0)
 ;;=3^Preporcedural Cardiovascular Examination
 ;;^UTILITY(U,$J,358.3,2499,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,2499,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,2500,0)
 ;;=G90.01^^19^206^1
 ;;^UTILITY(U,$J,358.3,2500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2500,1,3,0)
 ;;=3^Carotid Sinus Syncope
 ;;^UTILITY(U,$J,358.3,2500,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,2500,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,2501,0)
 ;;=R55.^^19^206^2
 ;;^UTILITY(U,$J,358.3,2501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2501,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,2501,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,2501,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,2502,0)
 ;;=99368^^20^207^1^^^^1
 ;;^UTILITY(U,$J,358.3,2502,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2502,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,2502,1,3,0)
 ;;=3^3+ HC Team Conf w/o Pt > 30min
 ;;^UTILITY(U,$J,358.3,2503,0)
 ;;=96150^^20^208^2^^^^1
 ;;^UTILITY(U,$J,358.3,2503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2503,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,2503,1,3,0)
 ;;=3^Assess Hlth/Beh,Init Ea 15min
 ;;^UTILITY(U,$J,358.3,2504,0)
 ;;=96151^^20^208^3^^^^1
 ;;^UTILITY(U,$J,358.3,2504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2504,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,2504,1,3,0)
 ;;=3^Assess Hlth/Beh,Subs Ea 15min
 ;;^UTILITY(U,$J,358.3,2505,0)
 ;;=96152^^20^208^7^^^^1
 ;;^UTILITY(U,$J,358.3,2505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2505,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,2505,1,3,0)
 ;;=3^Inter Hlth/Beh,Ind Ea 15min
 ;;^UTILITY(U,$J,358.3,2506,0)
 ;;=96153^^20^208^6^^^^1
 ;;^UTILITY(U,$J,358.3,2506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2506,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,2506,1,3,0)
 ;;=3^Inter Hlth/Beh,Grp Ea 15min
 ;;^UTILITY(U,$J,358.3,2507,0)
 ;;=96154^^20^208^5^^^^1
 ;;^UTILITY(U,$J,358.3,2507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2507,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,2507,1,3,0)
 ;;=3^Inter Hlth/Beh,Fam w/Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,2508,0)
 ;;=96155^^20^208^4^^^^1
 ;;^UTILITY(U,$J,358.3,2508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2508,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,2508,1,3,0)
 ;;=3^Int Hlth/Beh Fam w/o Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,2509,0)
 ;;=99420^^20^208^1^^^^1
 ;;^UTILITY(U,$J,358.3,2509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2509,1,2,0)
 ;;=2^99420
 ;;^UTILITY(U,$J,358.3,2509,1,3,0)
 ;;=3^Adm/Inter Hlth Risk Assess Tst
 ;;^UTILITY(U,$J,358.3,2510,0)
 ;;=S9445^^20^208^8^^^^1
 ;;^UTILITY(U,$J,358.3,2510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2510,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,2510,1,3,0)
 ;;=3^Pt Education NOC Individual
 ;;^UTILITY(U,$J,358.3,2511,0)
 ;;=90791^^20^209^1^^^^1
 ;;^UTILITY(U,$J,358.3,2511,1,0)
 ;;=^358.31IA^3^2
