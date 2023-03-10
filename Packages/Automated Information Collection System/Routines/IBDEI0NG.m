IBDEI0NG ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10560,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,10561,0)
 ;;=F31.5^^42^471^16
 ;;^UTILITY(U,$J,358.3,10561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10561,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,10561,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,10561,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,10562,0)
 ;;=F31.75^^42^471^18
 ;;^UTILITY(U,$J,358.3,10562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10562,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,10562,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,10562,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,10563,0)
 ;;=F31.76^^42^471^17
 ;;^UTILITY(U,$J,358.3,10563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10563,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,10563,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,10563,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,10564,0)
 ;;=F31.81^^42^471^23
 ;;^UTILITY(U,$J,358.3,10564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10564,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,10564,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,10564,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,10565,0)
 ;;=F34.0^^42^471^24
 ;;^UTILITY(U,$J,358.3,10565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10565,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,10565,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,10565,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,10566,0)
 ;;=F31.0^^42^471^20
 ;;^UTILITY(U,$J,358.3,10566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10566,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,10566,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,10566,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,10567,0)
 ;;=F31.71^^42^471^22
 ;;^UTILITY(U,$J,358.3,10567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10567,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,10567,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,10567,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,10568,0)
 ;;=F31.72^^42^471^21
 ;;^UTILITY(U,$J,358.3,10568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10568,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,10568,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,10568,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,10569,0)
 ;;=F06.33^^42^471^3
 ;;^UTILITY(U,$J,358.3,10569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10569,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,10569,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,10569,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,10570,0)
 ;;=F31.9^^42^471^12
 ;;^UTILITY(U,$J,358.3,10570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10570,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,10570,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,10570,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,10571,0)
 ;;=F31.9^^42^471^19
 ;;^UTILITY(U,$J,358.3,10571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10571,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,10571,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,10571,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,10572,0)
 ;;=F31.89^^42^471^4
