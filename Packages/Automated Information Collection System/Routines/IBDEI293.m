IBDEI293 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38181,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,38181,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,38182,0)
 ;;=F60.3^^145^1847^3
 ;;^UTILITY(U,$J,358.3,38182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38182,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,38182,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,38182,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,38183,0)
 ;;=F60.89^^145^1847^9
 ;;^UTILITY(U,$J,358.3,38183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38183,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,38183,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,38183,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,38184,0)
 ;;=F60.9^^145^1847^10
 ;;^UTILITY(U,$J,358.3,38184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38184,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38184,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,38184,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,38185,0)
 ;;=Z65.4^^145^1848^4
 ;;^UTILITY(U,$J,358.3,38185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38185,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,38185,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,38185,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,38186,0)
 ;;=Z65.0^^145^1848^1
 ;;^UTILITY(U,$J,358.3,38186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38186,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,38186,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,38186,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,38187,0)
 ;;=Z65.2^^145^1848^3
 ;;^UTILITY(U,$J,358.3,38187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38187,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,38187,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,38187,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,38188,0)
 ;;=Z65.3^^145^1848^2
 ;;^UTILITY(U,$J,358.3,38188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38188,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,38188,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,38188,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,38189,0)
 ;;=Z65.8^^145^1849^5
 ;;^UTILITY(U,$J,358.3,38189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38189,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,38189,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,38189,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,38190,0)
 ;;=Z64.0^^145^1849^4
 ;;^UTILITY(U,$J,358.3,38190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38190,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,38190,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,38190,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,38191,0)
 ;;=Z64.1^^145^1849^3
 ;;^UTILITY(U,$J,358.3,38191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38191,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,38191,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,38191,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,38192,0)
 ;;=Z64.4^^145^1849^1
 ;;^UTILITY(U,$J,358.3,38192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38192,1,3,0)
 ;;=3^Discord w/ Social Service Provider,Including Probation Officer,Case Manager,Social Worker
 ;;^UTILITY(U,$J,358.3,38192,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,38192,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,38193,0)
 ;;=Z65.5^^145^1849^2
 ;;^UTILITY(U,$J,358.3,38193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38193,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,38193,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,38193,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,38194,0)
 ;;=Z62.820^^145^1850^4
