IBDEI0X6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15565,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,15566,0)
 ;;=F60.2^^58^677^1
 ;;^UTILITY(U,$J,358.3,15566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15566,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,15566,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,15566,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,15567,0)
 ;;=F60.81^^58^677^6
 ;;^UTILITY(U,$J,358.3,15567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15567,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,15567,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,15567,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,15568,0)
 ;;=F60.6^^58^677^2
 ;;^UTILITY(U,$J,358.3,15568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15568,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,15568,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,15568,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,15569,0)
 ;;=F60.3^^58^677^3
 ;;^UTILITY(U,$J,358.3,15569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15569,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,15569,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,15569,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,15570,0)
 ;;=F60.89^^58^677^9
 ;;^UTILITY(U,$J,358.3,15570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15570,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,15570,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,15570,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,15571,0)
 ;;=F60.9^^58^677^10
 ;;^UTILITY(U,$J,358.3,15571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15571,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15571,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,15571,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,15572,0)
 ;;=Z65.4^^58^678^4
 ;;^UTILITY(U,$J,358.3,15572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15572,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,15572,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,15572,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,15573,0)
 ;;=Z65.0^^58^678^1
 ;;^UTILITY(U,$J,358.3,15573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15573,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,15573,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,15573,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,15574,0)
 ;;=Z65.2^^58^678^3
 ;;^UTILITY(U,$J,358.3,15574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15574,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,15574,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,15574,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,15575,0)
 ;;=Z65.3^^58^678^2
 ;;^UTILITY(U,$J,358.3,15575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15575,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,15575,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,15575,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,15576,0)
 ;;=Z65.8^^58^679^5
 ;;^UTILITY(U,$J,358.3,15576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15576,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,15576,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,15576,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,15577,0)
 ;;=Z64.0^^58^679^4
 ;;^UTILITY(U,$J,358.3,15577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15577,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,15577,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,15577,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,15578,0)
 ;;=Z64.1^^58^679^3
 ;;^UTILITY(U,$J,358.3,15578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15578,1,3,0)
 ;;=3^Problems Related to Multiparity
