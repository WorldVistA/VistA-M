IBDEI194 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20926,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,20927,0)
 ;;=F21.^^99^1000^12
 ;;^UTILITY(U,$J,358.3,20927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20927,1,3,0)
 ;;=3^Schizotypal Personality Disorder
 ;;^UTILITY(U,$J,358.3,20927,1,4,0)
 ;;=4^F21.
 ;;^UTILITY(U,$J,358.3,20927,2)
 ;;=^5003477
 ;;^UTILITY(U,$J,358.3,20928,0)
 ;;=F60.5^^99^1000^7
 ;;^UTILITY(U,$J,358.3,20928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20928,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,20928,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,20928,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,20929,0)
 ;;=F60.4^^99^1000^5
 ;;^UTILITY(U,$J,358.3,20929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20929,1,3,0)
 ;;=3^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,20929,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,20929,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,20930,0)
 ;;=F60.7^^99^1000^4
 ;;^UTILITY(U,$J,358.3,20930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20930,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,20930,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,20930,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,20931,0)
 ;;=F60.2^^99^1000^1
 ;;^UTILITY(U,$J,358.3,20931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20931,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,20931,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,20931,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,20932,0)
 ;;=F60.81^^99^1000^6
 ;;^UTILITY(U,$J,358.3,20932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20932,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,20932,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,20932,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,20933,0)
 ;;=F60.6^^99^1000^2
 ;;^UTILITY(U,$J,358.3,20933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20933,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,20933,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,20933,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,20934,0)
 ;;=F60.3^^99^1000^3
 ;;^UTILITY(U,$J,358.3,20934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20934,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,20934,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,20934,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,20935,0)
 ;;=F60.89^^99^1000^9
 ;;^UTILITY(U,$J,358.3,20935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20935,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,20935,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,20935,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,20936,0)
 ;;=F60.9^^99^1000^10
 ;;^UTILITY(U,$J,358.3,20936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20936,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,20936,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,20936,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,20937,0)
 ;;=Z65.4^^99^1001^4
 ;;^UTILITY(U,$J,358.3,20937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20937,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,20937,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,20937,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,20938,0)
 ;;=Z65.0^^99^1001^1
 ;;^UTILITY(U,$J,358.3,20938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20938,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,20938,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,20938,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,20939,0)
 ;;=Z65.2^^99^1001^3
 ;;^UTILITY(U,$J,358.3,20939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20939,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,20939,1,4,0)
 ;;=4^Z65.2
