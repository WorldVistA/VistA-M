IBDEI1GL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24784,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,24784,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,24785,0)
 ;;=F60.7^^93^1109^4
 ;;^UTILITY(U,$J,358.3,24785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24785,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,24785,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,24785,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,24786,0)
 ;;=F60.2^^93^1109^1
 ;;^UTILITY(U,$J,358.3,24786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24786,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,24786,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,24786,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,24787,0)
 ;;=F60.81^^93^1109^6
 ;;^UTILITY(U,$J,358.3,24787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24787,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,24787,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,24787,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,24788,0)
 ;;=F60.6^^93^1109^2
 ;;^UTILITY(U,$J,358.3,24788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24788,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,24788,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,24788,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,24789,0)
 ;;=F60.3^^93^1109^3
 ;;^UTILITY(U,$J,358.3,24789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24789,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,24789,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,24789,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,24790,0)
 ;;=F60.89^^93^1109^9
 ;;^UTILITY(U,$J,358.3,24790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24790,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,24790,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,24790,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,24791,0)
 ;;=F60.9^^93^1109^10
 ;;^UTILITY(U,$J,358.3,24791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24791,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24791,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,24791,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,24792,0)
 ;;=Z65.4^^93^1110^4
 ;;^UTILITY(U,$J,358.3,24792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24792,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,24792,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,24792,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,24793,0)
 ;;=Z65.0^^93^1110^1
 ;;^UTILITY(U,$J,358.3,24793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24793,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,24793,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,24793,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,24794,0)
 ;;=Z65.2^^93^1110^3
 ;;^UTILITY(U,$J,358.3,24794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24794,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,24794,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,24794,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,24795,0)
 ;;=Z65.3^^93^1110^2
 ;;^UTILITY(U,$J,358.3,24795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24795,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,24795,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,24795,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,24796,0)
 ;;=Z65.8^^93^1111^5
 ;;^UTILITY(U,$J,358.3,24796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24796,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,24796,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,24796,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,24797,0)
 ;;=Z64.0^^93^1111^4
 ;;^UTILITY(U,$J,358.3,24797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24797,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
