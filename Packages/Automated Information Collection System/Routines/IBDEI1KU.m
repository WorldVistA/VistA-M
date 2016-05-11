IBDEI1KU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26749,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,26749,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,26750,0)
 ;;=F60.81^^100^1284^6
 ;;^UTILITY(U,$J,358.3,26750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26750,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,26750,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,26750,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,26751,0)
 ;;=F60.6^^100^1284^2
 ;;^UTILITY(U,$J,358.3,26751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26751,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,26751,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,26751,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,26752,0)
 ;;=F60.3^^100^1284^3
 ;;^UTILITY(U,$J,358.3,26752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26752,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,26752,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,26752,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,26753,0)
 ;;=F60.89^^100^1284^9
 ;;^UTILITY(U,$J,358.3,26753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26753,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,26753,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,26753,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,26754,0)
 ;;=F60.9^^100^1284^10
 ;;^UTILITY(U,$J,358.3,26754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26754,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26754,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,26754,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,26755,0)
 ;;=Z65.4^^100^1285^4
 ;;^UTILITY(U,$J,358.3,26755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26755,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,26755,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,26755,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,26756,0)
 ;;=Z65.0^^100^1285^1
 ;;^UTILITY(U,$J,358.3,26756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26756,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,26756,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,26756,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,26757,0)
 ;;=Z65.2^^100^1285^3
 ;;^UTILITY(U,$J,358.3,26757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26757,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,26757,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,26757,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,26758,0)
 ;;=Z65.3^^100^1285^2
 ;;^UTILITY(U,$J,358.3,26758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26758,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,26758,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,26758,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,26759,0)
 ;;=Z65.8^^100^1286^5
 ;;^UTILITY(U,$J,358.3,26759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26759,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,26759,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,26759,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,26760,0)
 ;;=Z64.0^^100^1286^4
 ;;^UTILITY(U,$J,358.3,26760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26760,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,26760,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,26760,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,26761,0)
 ;;=Z64.1^^100^1286^3
 ;;^UTILITY(U,$J,358.3,26761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26761,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,26761,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,26761,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,26762,0)
 ;;=Z64.4^^100^1286^1
 ;;^UTILITY(U,$J,358.3,26762,1,0)
 ;;=^358.31IA^4^2
