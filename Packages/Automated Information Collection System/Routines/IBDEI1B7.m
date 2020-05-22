IBDEI1B7 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20932,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,20932,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,20933,0)
 ;;=F60.6^^95^1036^2
 ;;^UTILITY(U,$J,358.3,20933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20933,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,20933,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,20933,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,20934,0)
 ;;=F60.3^^95^1036^3
 ;;^UTILITY(U,$J,358.3,20934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20934,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,20934,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,20934,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,20935,0)
 ;;=F60.89^^95^1036^10
 ;;^UTILITY(U,$J,358.3,20935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20935,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,20935,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,20935,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,20936,0)
 ;;=F60.9^^95^1036^11
 ;;^UTILITY(U,$J,358.3,20936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20936,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,20936,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,20936,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,20937,0)
 ;;=F07.0^^95^1036^9
 ;;^UTILITY(U,$J,358.3,20937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20937,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,20937,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,20937,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,20938,0)
 ;;=Z65.4^^95^1037^5
 ;;^UTILITY(U,$J,358.3,20938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20938,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,20938,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,20938,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,20939,0)
 ;;=Z65.0^^95^1037^1
 ;;^UTILITY(U,$J,358.3,20939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20939,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,20939,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,20939,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,20940,0)
 ;;=Z65.2^^95^1037^4
 ;;^UTILITY(U,$J,358.3,20940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20940,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,20940,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,20940,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,20941,0)
 ;;=Z65.3^^95^1037^3
 ;;^UTILITY(U,$J,358.3,20941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20941,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,20941,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,20941,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,20942,0)
 ;;=Z65.1^^95^1037^2
 ;;^UTILITY(U,$J,358.3,20942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20942,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,20942,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,20942,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,20943,0)
 ;;=Z65.8^^95^1038^7
 ;;^UTILITY(U,$J,358.3,20943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20943,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,20943,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,20943,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,20944,0)
 ;;=Z64.0^^95^1038^6
 ;;^UTILITY(U,$J,358.3,20944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20944,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,20944,1,4,0)
 ;;=4^Z64.0
