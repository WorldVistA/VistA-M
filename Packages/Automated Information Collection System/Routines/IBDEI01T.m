IBDEI01T ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,355,1,4,0)
 ;;=4^F65.0
 ;;^UTILITY(U,$J,358.3,355,2)
 ;;=^5003651
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=F65.1^^3^41^9
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,356,1,3,0)
 ;;=3^Transvestic Disorder
 ;;^UTILITY(U,$J,358.3,356,1,4,0)
 ;;=4^F65.1
 ;;^UTILITY(U,$J,358.3,356,2)
 ;;=^5003652
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=F65.89^^3^41^4
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,357,1,3,0)
 ;;=3^Paraphilic Disorder NEC
 ;;^UTILITY(U,$J,358.3,357,1,4,0)
 ;;=4^F65.89
 ;;^UTILITY(U,$J,358.3,357,2)
 ;;=^5003660
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=F65.9^^3^41^5
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,358,1,3,0)
 ;;=3^Paraphilic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,358,1,4,0)
 ;;=4^F65.9
 ;;^UTILITY(U,$J,358.3,358,2)
 ;;=^5003661
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=F60.0^^3^42^8
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,359,1,3,0)
 ;;=3^Paranoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,359,1,4,0)
 ;;=4^F60.0
 ;;^UTILITY(U,$J,358.3,359,2)
 ;;=^5003635
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=F60.1^^3^42^11
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,360,1,3,0)
 ;;=3^Schizoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,360,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,360,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=F21.^^3^42^12
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,361,1,3,0)
 ;;=3^Schizotypal Personality Disorder
 ;;^UTILITY(U,$J,358.3,361,1,4,0)
 ;;=4^F21.
 ;;^UTILITY(U,$J,358.3,361,2)
 ;;=^5003477
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=F60.5^^3^42^7
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,362,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,362,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,362,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=F60.4^^3^42^5
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,363,1,3,0)
 ;;=3^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,363,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,363,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=F60.7^^3^42^4
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,364,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,364,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,364,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=F60.2^^3^42^1
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,365,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,365,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,365,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=F60.81^^3^42^6
 ;;^UTILITY(U,$J,358.3,366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,366,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,366,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,366,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,367,0)
 ;;=F60.6^^3^42^2
 ;;^UTILITY(U,$J,358.3,367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,367,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,367,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,367,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,368,0)
 ;;=F60.3^^3^42^3
 ;;^UTILITY(U,$J,358.3,368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,368,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,368,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,368,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,369,0)
 ;;=F60.89^^3^42^9
 ;;^UTILITY(U,$J,358.3,369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,369,1,3,0)
 ;;=3^Personality Disorder NEC
