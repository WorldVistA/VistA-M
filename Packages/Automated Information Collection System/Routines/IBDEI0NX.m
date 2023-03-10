IBDEI0NX ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10766,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,10766,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,10766,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,10767,0)
 ;;=F60.3^^42^484^3
 ;;^UTILITY(U,$J,358.3,10767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10767,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,10767,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,10767,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,10768,0)
 ;;=F60.89^^42^484^10
 ;;^UTILITY(U,$J,358.3,10768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10768,1,3,0)
 ;;=3^Personality Disorder,Other
 ;;^UTILITY(U,$J,358.3,10768,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,10768,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,10769,0)
 ;;=F60.9^^42^484^11
 ;;^UTILITY(U,$J,358.3,10769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10769,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10769,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,10769,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,10770,0)
 ;;=F07.0^^42^484^9
 ;;^UTILITY(U,$J,358.3,10770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10770,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,10770,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,10770,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,10771,0)
 ;;=Z65.4^^42^485^5
 ;;^UTILITY(U,$J,358.3,10771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10771,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,10771,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,10771,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,10772,0)
 ;;=Z65.0^^42^485^1
 ;;^UTILITY(U,$J,358.3,10772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10772,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,10772,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,10772,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,10773,0)
 ;;=Z65.2^^42^485^4
 ;;^UTILITY(U,$J,358.3,10773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10773,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,10773,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,10773,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,10774,0)
 ;;=Z65.3^^42^485^3
 ;;^UTILITY(U,$J,358.3,10774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10774,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,10774,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,10774,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,10775,0)
 ;;=Z65.1^^42^485^2
 ;;^UTILITY(U,$J,358.3,10775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10775,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,10775,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,10775,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,10776,0)
 ;;=Z65.8^^42^486^7
 ;;^UTILITY(U,$J,358.3,10776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10776,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,10776,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,10776,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,10777,0)
 ;;=Z64.0^^42^486^6
 ;;^UTILITY(U,$J,358.3,10777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10777,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,10777,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,10777,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,10778,0)
 ;;=Z64.1^^42^486^4
 ;;^UTILITY(U,$J,358.3,10778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10778,1,3,0)
 ;;=3^Problems Related to Multiparity
