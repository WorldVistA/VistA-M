IBDEI1V5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29755,0)
 ;;=T43.206A^^118^1503^6
 ;;^UTILITY(U,$J,358.3,29755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29755,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
 ;;^UTILITY(U,$J,358.3,29755,1,4,0)
 ;;=4^T43.206A
 ;;^UTILITY(U,$J,358.3,29755,2)
 ;;=^5050543
 ;;^UTILITY(U,$J,358.3,29756,0)
 ;;=T43.206S^^118^1503^7
 ;;^UTILITY(U,$J,358.3,29756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29756,1,3,0)
 ;;=3^Underdosing of Antidepressants,Sequela
 ;;^UTILITY(U,$J,358.3,29756,1,4,0)
 ;;=4^T43.206S
 ;;^UTILITY(U,$J,358.3,29756,2)
 ;;=^5050545
 ;;^UTILITY(U,$J,358.3,29757,0)
 ;;=T43.206D^^118^1503^8
 ;;^UTILITY(U,$J,358.3,29757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29757,1,3,0)
 ;;=3^Underdosing of Antidepressants,Subs Encntr
 ;;^UTILITY(U,$J,358.3,29757,1,4,0)
 ;;=4^T43.206D
 ;;^UTILITY(U,$J,358.3,29757,2)
 ;;=^5050544
 ;;^UTILITY(U,$J,358.3,29758,0)
 ;;=T43.506A^^118^1503^12
 ;;^UTILITY(U,$J,358.3,29758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29758,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Init Encntr
 ;;^UTILITY(U,$J,358.3,29758,1,4,0)
 ;;=4^T43.506A
 ;;^UTILITY(U,$J,358.3,29758,2)
 ;;=^5050651
 ;;^UTILITY(U,$J,358.3,29759,0)
 ;;=T43.506S^^118^1503^13
 ;;^UTILITY(U,$J,358.3,29759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29759,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Sequela
 ;;^UTILITY(U,$J,358.3,29759,1,4,0)
 ;;=4^T43.506S
 ;;^UTILITY(U,$J,358.3,29759,2)
 ;;=^5050653
 ;;^UTILITY(U,$J,358.3,29760,0)
 ;;=T43.506D^^118^1503^14
 ;;^UTILITY(U,$J,358.3,29760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29760,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Subs Encntr
 ;;^UTILITY(U,$J,358.3,29760,1,4,0)
 ;;=4^T43.506D
 ;;^UTILITY(U,$J,358.3,29760,2)
 ;;=^5050652
 ;;^UTILITY(U,$J,358.3,29761,0)
 ;;=90832^^119^1504^7^^^^1
 ;;^UTILITY(U,$J,358.3,29761,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29761,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,29761,1,3,0)
 ;;=3^Psychotherapy 16-37 min
 ;;^UTILITY(U,$J,358.3,29762,0)
 ;;=90834^^119^1504^8^^^^1
 ;;^UTILITY(U,$J,358.3,29762,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29762,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,29762,1,3,0)
 ;;=3^Psychotherapy 38-52 min
 ;;^UTILITY(U,$J,358.3,29763,0)
 ;;=90837^^119^1504^9^^^^1
 ;;^UTILITY(U,$J,358.3,29763,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29763,1,2,0)
 ;;=2^90837
 ;;^UTILITY(U,$J,358.3,29763,1,3,0)
 ;;=3^Psychotherapy 53-89 min
 ;;^UTILITY(U,$J,358.3,29764,0)
 ;;=90853^^119^1504^3^^^^1
 ;;^UTILITY(U,$J,358.3,29764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29764,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,29764,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,29765,0)
 ;;=90846^^119^1504^2^^^^1
 ;;^UTILITY(U,$J,358.3,29765,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29765,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,29765,1,3,0)
 ;;=3^Family Psychotherapy w/o Pt
 ;;^UTILITY(U,$J,358.3,29766,0)
 ;;=90847^^119^1504^1^^^^1
 ;;^UTILITY(U,$J,358.3,29766,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29766,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,29766,1,3,0)
 ;;=3^Family Psychotherapy w/ Pt
 ;;^UTILITY(U,$J,358.3,29767,0)
 ;;=90875^^119^1504^4^^^^1
 ;;^UTILITY(U,$J,358.3,29767,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29767,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,29767,1,3,0)
 ;;=3^Ind Psychophysiological Tx w/ Biofeed,30 min
