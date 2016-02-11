IBDEI1W5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31670,0)
 ;;=F60.4^^138^1444^5
 ;;^UTILITY(U,$J,358.3,31670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31670,1,3,0)
 ;;=3^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,31670,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,31670,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,31671,0)
 ;;=F60.7^^138^1444^4
 ;;^UTILITY(U,$J,358.3,31671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31671,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,31671,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,31671,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,31672,0)
 ;;=F60.2^^138^1444^1
 ;;^UTILITY(U,$J,358.3,31672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31672,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,31672,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,31672,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,31673,0)
 ;;=F60.81^^138^1444^6
 ;;^UTILITY(U,$J,358.3,31673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31673,1,3,0)
 ;;=3^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,31673,1,4,0)
 ;;=4^F60.81
 ;;^UTILITY(U,$J,358.3,31673,2)
 ;;=^331919
 ;;^UTILITY(U,$J,358.3,31674,0)
 ;;=F60.6^^138^1444^2
 ;;^UTILITY(U,$J,358.3,31674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31674,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,31674,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,31674,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,31675,0)
 ;;=F60.3^^138^1444^3
 ;;^UTILITY(U,$J,358.3,31675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31675,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,31675,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,31675,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,31676,0)
 ;;=F60.89^^138^1444^9
 ;;^UTILITY(U,$J,358.3,31676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31676,1,3,0)
 ;;=3^Personality Disorder NEC
 ;;^UTILITY(U,$J,358.3,31676,1,4,0)
 ;;=4^F60.89
 ;;^UTILITY(U,$J,358.3,31676,2)
 ;;=^5003638
 ;;^UTILITY(U,$J,358.3,31677,0)
 ;;=F60.9^^138^1444^10
 ;;^UTILITY(U,$J,358.3,31677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31677,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31677,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,31677,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,31678,0)
 ;;=Z65.4^^138^1445^4
 ;;^UTILITY(U,$J,358.3,31678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31678,1,3,0)
 ;;=3^Victim of Crime,Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,31678,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,31678,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,31679,0)
 ;;=Z65.0^^138^1445^1
 ;;^UTILITY(U,$J,358.3,31679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31679,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,31679,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,31679,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,31680,0)
 ;;=Z65.2^^138^1445^3
 ;;^UTILITY(U,$J,358.3,31680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31680,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,31680,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,31680,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,31681,0)
 ;;=Z65.3^^138^1445^2
 ;;^UTILITY(U,$J,358.3,31681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31681,1,3,0)
 ;;=3^Problems Related to Oth Legal Circumstances
 ;;^UTILITY(U,$J,358.3,31681,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,31681,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,31682,0)
 ;;=Z65.8^^138^1446^5
 ;;^UTILITY(U,$J,358.3,31682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31682,1,3,0)
 ;;=3^Religious/Spiritual Problem;Oth Problem Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,31682,1,4,0)
 ;;=4^Z65.8
