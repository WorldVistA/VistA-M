IBDEI07H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2926,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,in Remission
 ;;^UTILITY(U,$J,358.3,2926,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,2926,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,2927,0)
 ;;=F17.290^^28^244^25
 ;;^UTILITY(U,$J,358.3,2927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2927,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2927,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,2927,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,2928,0)
 ;;=F17.299^^28^244^26
 ;;^UTILITY(U,$J,358.3,2928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2928,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,2928,1,4,0)
 ;;=4^F17.299
 ;;^UTILITY(U,$J,358.3,2928,2)
 ;;=^5003379
 ;;^UTILITY(U,$J,358.3,2929,0)
 ;;=F17.293^^28^244^27
 ;;^UTILITY(U,$J,358.3,2929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2929,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,2929,1,4,0)
 ;;=4^F17.293
 ;;^UTILITY(U,$J,358.3,2929,2)
 ;;=^5003377
 ;;^UTILITY(U,$J,358.3,2930,0)
 ;;=F17.201^^28^244^31
 ;;^UTILITY(U,$J,358.3,2930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2930,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,in Remission
 ;;^UTILITY(U,$J,358.3,2930,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,2930,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,2931,0)
 ;;=F17.200^^28^244^30
 ;;^UTILITY(U,$J,358.3,2931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2931,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2931,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,2931,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,2932,0)
 ;;=F17.209^^28^244^28
 ;;^UTILITY(U,$J,358.3,2932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2932,1,3,0)
 ;;=3^Nicotine Dependence,Unspec w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,2932,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,2932,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,2933,0)
 ;;=F17.203^^28^244^29
 ;;^UTILITY(U,$J,358.3,2933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2933,1,3,0)
 ;;=3^Nicotine Dependence,Unspec w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,2933,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,2933,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,2934,0)
 ;;=F07.0^^28^244^35
 ;;^UTILITY(U,$J,358.3,2934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2934,1,3,0)
 ;;=3^Personality Changed d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2934,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,2934,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,2935,0)
 ;;=F20.0^^28^244^38
 ;;^UTILITY(U,$J,358.3,2935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2935,1,3,0)
 ;;=3^Schizophrenia,Paranoid
 ;;^UTILITY(U,$J,358.3,2935,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,2935,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,2936,0)
 ;;=R45.851^^28^244^40
 ;;^UTILITY(U,$J,358.3,2936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2936,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,2936,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,2936,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,2937,0)
 ;;=Z87.820^^28^244^34
 ;;^UTILITY(U,$J,358.3,2937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2937,1,3,0)
 ;;=3^Personal Hx of TBI
 ;;^UTILITY(U,$J,358.3,2937,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,2937,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,2938,0)
 ;;=R14.0^^28^245^1
 ;;^UTILITY(U,$J,358.3,2938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2938,1,3,0)
 ;;=3^Abdominal Distension
 ;;^UTILITY(U,$J,358.3,2938,1,4,0)
 ;;=4^R14.0
 ;;^UTILITY(U,$J,358.3,2938,2)
 ;;=^5019240
 ;;^UTILITY(U,$J,358.3,2939,0)
 ;;=Z90.81^^28^245^2
