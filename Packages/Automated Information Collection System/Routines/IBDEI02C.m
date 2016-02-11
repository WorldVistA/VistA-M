IBDEI02C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,326,1,3,0)
 ;;=3^Paranoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,326,1,4,0)
 ;;=4^F60.0
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^5003635
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=F60.1^^3^42^11
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,327,1,3,0)
 ;;=3^Schizoid Personality Disorder
 ;;^UTILITY(U,$J,358.3,327,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=F21.^^3^42^12
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,328,1,3,0)
 ;;=3^Schizotypal Personality Disorder
 ;;^UTILITY(U,$J,358.3,328,1,4,0)
 ;;=4^F21.
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^5003477
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=F60.5^^3^42^7
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,329,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,329,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=F60.4^^3^42^5
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,330,1,3,0)
 ;;=3^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,330,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,330,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=F60.7^^3^42^4
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,331,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,331,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,331,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=F60.2^^3^42^1
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,332,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,332,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,332,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=F60.81^^3^42^6
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,333,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,333,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,333,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,334,0)
 ;;=F60.6^^3^42^2
 ;;^UTILITY(U,$J,358.3,334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,334,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,334,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,334,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,335,0)
 ;;=F60.3^^3^42^3
 ;;^UTILITY(U,$J,358.3,335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,335,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,335,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,335,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,336,0)
 ;;=F60.89^^3^42^9
 ;;^UTILITY(U,$J,358.3,336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,336,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,336,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,336,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=F60.9^^3^42^10
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,337,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,337,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=Z65.4^^3^43^4
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,338,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,338,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=Z65.0^^3^43^1
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,339,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,339,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=Z65.2^^3^43^3
