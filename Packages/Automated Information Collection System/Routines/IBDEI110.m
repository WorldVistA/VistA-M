IBDEI110 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18285,2)
 ;;=Avoidant Personality Disorder^265347
 ;;^UTILITY(U,$J,358.3,18286,0)
 ;;=301.83^^101^1050^3
 ;;^UTILITY(U,$J,358.3,18286,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18286,1,2,0)
 ;;=2^301.83
 ;;^UTILITY(U,$J,358.3,18286,1,5,0)
 ;;=5^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,18286,2)
 ;;=Borderline Personality Disorder^16372
 ;;^UTILITY(U,$J,358.3,18287,0)
 ;;=301.6^^101^1050^6
 ;;^UTILITY(U,$J,358.3,18287,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18287,1,2,0)
 ;;=2^301.6
 ;;^UTILITY(U,$J,358.3,18287,1,5,0)
 ;;=5^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,18287,2)
 ;;=Dependent Personality Disorder^32860
 ;;^UTILITY(U,$J,358.3,18288,0)
 ;;=301.50^^101^1050^8
 ;;^UTILITY(U,$J,358.3,18288,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18288,1,2,0)
 ;;=2^301.50
 ;;^UTILITY(U,$J,358.3,18288,1,5,0)
 ;;=5^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,18288,2)
 ;;=Histrionic Personality Disorder^57763
 ;;^UTILITY(U,$J,358.3,18289,0)
 ;;=301.81^^101^1050^11
 ;;^UTILITY(U,$J,358.3,18289,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18289,1,2,0)
 ;;=2^301.81
 ;;^UTILITY(U,$J,358.3,18289,1,5,0)
 ;;=5^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,18289,2)
 ;;=Narcissistic Personality Disorder^265353
 ;;^UTILITY(U,$J,358.3,18290,0)
 ;;=301.0^^101^1050^12
 ;;^UTILITY(U,$J,358.3,18290,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18290,1,2,0)
 ;;=2^301.0
 ;;^UTILITY(U,$J,358.3,18290,1,5,0)
 ;;=5^Paranoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,18290,2)
 ;;=Paranoid Personality Disorder^89982
 ;;^UTILITY(U,$J,358.3,18291,0)
 ;;=301.9^^101^1050^16
 ;;^UTILITY(U,$J,358.3,18291,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18291,1,2,0)
 ;;=2^301.9
 ;;^UTILITY(U,$J,358.3,18291,1,5,0)
 ;;=5^Unspecified Personality Disorder
 ;;^UTILITY(U,$J,358.3,18291,2)
 ;;=Unspecified Personality Disorder^92451
 ;;^UTILITY(U,$J,358.3,18292,0)
 ;;=301.20^^101^1050^14
 ;;^UTILITY(U,$J,358.3,18292,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18292,1,2,0)
 ;;=2^301.20
 ;;^UTILITY(U,$J,358.3,18292,1,5,0)
 ;;=5^Schizoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,18292,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,18293,0)
 ;;=301.22^^101^1050^15
 ;;^UTILITY(U,$J,358.3,18293,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18293,1,2,0)
 ;;=2^301.22
 ;;^UTILITY(U,$J,358.3,18293,1,5,0)
 ;;=5^Schizotypal Personality Disorder
 ;;^UTILITY(U,$J,358.3,18293,2)
 ;;=Schizotypal Personality Disorder^108367
 ;;^UTILITY(U,$J,358.3,18294,0)
 ;;=301.4^^101^1050^4
 ;;^UTILITY(U,$J,358.3,18294,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18294,1,2,0)
 ;;=2^301.4
 ;;^UTILITY(U,$J,358.3,18294,1,5,0)
 ;;=5^Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,18294,2)
 ;;=Compulsive Personality Disorder^27122
 ;;^UTILITY(U,$J,358.3,18295,0)
 ;;=301.84^^101^1050^13
 ;;^UTILITY(U,$J,358.3,18295,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18295,1,2,0)
 ;;=2^301.84
 ;;^UTILITY(U,$J,358.3,18295,1,5,0)
 ;;=5^Passive-Aggressive Personality Dis
 ;;^UTILITY(U,$J,358.3,18295,2)
 ;;=Passive-Aggressive Personality Dis^90602
 ;;^UTILITY(U,$J,358.3,18296,0)
 ;;=301.11^^101^1050^9
 ;;^UTILITY(U,$J,358.3,18296,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18296,1,2,0)
 ;;=2^301.11
 ;;^UTILITY(U,$J,358.3,18296,1,5,0)
 ;;=5^Hypomanic Personality D/O,Chr
 ;;^UTILITY(U,$J,358.3,18296,2)
 ;;=^268171
 ;;^UTILITY(U,$J,358.3,18297,0)
 ;;=301.12^^101^1050^7
 ;;^UTILITY(U,$J,358.3,18297,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18297,1,2,0)
 ;;=2^301.12
 ;;^UTILITY(U,$J,358.3,18297,1,5,0)
 ;;=5^Depressive Personality D/O,Chr
