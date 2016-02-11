IBDEI07G ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2913,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2913,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,2913,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,2914,0)
 ;;=F32.9^^28^244^12
 ;;^UTILITY(U,$J,358.3,2914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2914,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,2914,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,2914,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,2915,0)
 ;;=R46.0^^28^244^10
 ;;^UTILITY(U,$J,358.3,2915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2915,1,3,0)
 ;;=3^Hygiene,Personal,Very Lowe Level
 ;;^UTILITY(U,$J,358.3,2915,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,2915,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,2916,0)
 ;;=F39.^^28^244^14
 ;;^UTILITY(U,$J,358.3,2916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2916,1,3,0)
 ;;=3^Mood Affective Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2916,1,4,0)
 ;;=4^F39.
 ;;^UTILITY(U,$J,358.3,2916,2)
 ;;=^5003541
 ;;^UTILITY(U,$J,358.3,2917,0)
 ;;=F06.30^^28^244^15
 ;;^UTILITY(U,$J,358.3,2917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2917,1,3,0)
 ;;=3^Mood Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2917,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,2917,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,2918,0)
 ;;=F17.221^^28^244^19
 ;;^UTILITY(U,$J,358.3,2918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2918,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,in Remission
 ;;^UTILITY(U,$J,358.3,2918,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,2918,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,2919,0)
 ;;=F17.220^^28^244^18
 ;;^UTILITY(U,$J,358.3,2919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2919,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2919,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,2919,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,2920,0)
 ;;=F17.229^^28^244^16
 ;;^UTILITY(U,$J,358.3,2920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2920,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,2920,1,4,0)
 ;;=4^F17.229
 ;;^UTILITY(U,$J,358.3,2920,2)
 ;;=^5003374
 ;;^UTILITY(U,$J,358.3,2921,0)
 ;;=F17.223^^28^244^17
 ;;^UTILITY(U,$J,358.3,2921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2921,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,2921,1,4,0)
 ;;=4^F17.223
 ;;^UTILITY(U,$J,358.3,2921,2)
 ;;=^5003372
 ;;^UTILITY(U,$J,358.3,2922,0)
 ;;=F17.211^^28^244^23
 ;;^UTILITY(U,$J,358.3,2922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2922,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,in Remission
 ;;^UTILITY(U,$J,358.3,2922,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,2922,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,2923,0)
 ;;=F17.210^^28^244^22
 ;;^UTILITY(U,$J,358.3,2923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2923,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2923,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,2923,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,2924,0)
 ;;=F17.219^^28^244^20
 ;;^UTILITY(U,$J,358.3,2924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2924,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,2924,1,4,0)
 ;;=4^F17.219
 ;;^UTILITY(U,$J,358.3,2924,2)
 ;;=^5003369
 ;;^UTILITY(U,$J,358.3,2925,0)
 ;;=F17.213^^28^244^21
 ;;^UTILITY(U,$J,358.3,2925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2925,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,2925,1,4,0)
 ;;=4^F17.213
 ;;^UTILITY(U,$J,358.3,2925,2)
 ;;=^5003367
 ;;^UTILITY(U,$J,358.3,2926,0)
 ;;=F17.291^^28^244^24
