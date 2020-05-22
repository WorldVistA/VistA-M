IBDEI0TM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13184,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,13184,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,13185,0)
 ;;=F32.9^^83^807^12
 ;;^UTILITY(U,$J,358.3,13185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13185,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,13185,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,13185,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,13186,0)
 ;;=R46.0^^83^807^10
 ;;^UTILITY(U,$J,358.3,13186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13186,1,3,0)
 ;;=3^Hygiene,Personal,Very Lowe Level
 ;;^UTILITY(U,$J,358.3,13186,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,13186,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,13187,0)
 ;;=F39.^^83^807^14
 ;;^UTILITY(U,$J,358.3,13187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13187,1,3,0)
 ;;=3^Mood Affective Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13187,1,4,0)
 ;;=4^F39.
 ;;^UTILITY(U,$J,358.3,13187,2)
 ;;=^5003541
 ;;^UTILITY(U,$J,358.3,13188,0)
 ;;=F06.30^^83^807^15
 ;;^UTILITY(U,$J,358.3,13188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13188,1,3,0)
 ;;=3^Mood Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,13188,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,13188,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,13189,0)
 ;;=F17.221^^83^807^19
 ;;^UTILITY(U,$J,358.3,13189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13189,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,in Remission
 ;;^UTILITY(U,$J,358.3,13189,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,13189,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,13190,0)
 ;;=F17.220^^83^807^18
 ;;^UTILITY(U,$J,358.3,13190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13190,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,13190,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,13190,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,13191,0)
 ;;=F17.229^^83^807^16
 ;;^UTILITY(U,$J,358.3,13191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13191,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,13191,1,4,0)
 ;;=4^F17.229
 ;;^UTILITY(U,$J,358.3,13191,2)
 ;;=^5003374
 ;;^UTILITY(U,$J,358.3,13192,0)
 ;;=F17.223^^83^807^17
 ;;^UTILITY(U,$J,358.3,13192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13192,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,13192,1,4,0)
 ;;=4^F17.223
 ;;^UTILITY(U,$J,358.3,13192,2)
 ;;=^5003372
 ;;^UTILITY(U,$J,358.3,13193,0)
 ;;=F17.211^^83^807^23
 ;;^UTILITY(U,$J,358.3,13193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13193,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,in Remission
 ;;^UTILITY(U,$J,358.3,13193,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,13193,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,13194,0)
 ;;=F17.210^^83^807^22
 ;;^UTILITY(U,$J,358.3,13194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13194,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,13194,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,13194,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,13195,0)
 ;;=F17.219^^83^807^20
 ;;^UTILITY(U,$J,358.3,13195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13195,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,13195,1,4,0)
 ;;=4^F17.219
 ;;^UTILITY(U,$J,358.3,13195,2)
 ;;=^5003369
 ;;^UTILITY(U,$J,358.3,13196,0)
 ;;=F17.213^^83^807^21
 ;;^UTILITY(U,$J,358.3,13196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13196,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Withdrawal
