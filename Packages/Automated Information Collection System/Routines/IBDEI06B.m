IBDEI06B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2624,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,2624,1,4,0)
 ;;=4^F17.229
 ;;^UTILITY(U,$J,358.3,2624,2)
 ;;=^5003374
 ;;^UTILITY(U,$J,358.3,2625,0)
 ;;=F17.223^^18^205^17
 ;;^UTILITY(U,$J,358.3,2625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2625,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,2625,1,4,0)
 ;;=4^F17.223
 ;;^UTILITY(U,$J,358.3,2625,2)
 ;;=^5003372
 ;;^UTILITY(U,$J,358.3,2626,0)
 ;;=F17.211^^18^205^23
 ;;^UTILITY(U,$J,358.3,2626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2626,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,in Remission
 ;;^UTILITY(U,$J,358.3,2626,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,2626,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,2627,0)
 ;;=F17.210^^18^205^22
 ;;^UTILITY(U,$J,358.3,2627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2627,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2627,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,2627,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,2628,0)
 ;;=F17.219^^18^205^20
 ;;^UTILITY(U,$J,358.3,2628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2628,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,2628,1,4,0)
 ;;=4^F17.219
 ;;^UTILITY(U,$J,358.3,2628,2)
 ;;=^5003369
 ;;^UTILITY(U,$J,358.3,2629,0)
 ;;=F17.213^^18^205^21
 ;;^UTILITY(U,$J,358.3,2629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2629,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,2629,1,4,0)
 ;;=4^F17.213
 ;;^UTILITY(U,$J,358.3,2629,2)
 ;;=^5003367
 ;;^UTILITY(U,$J,358.3,2630,0)
 ;;=F17.291^^18^205^24
 ;;^UTILITY(U,$J,358.3,2630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2630,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,in Remission
 ;;^UTILITY(U,$J,358.3,2630,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,2630,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,2631,0)
 ;;=F17.290^^18^205^25
 ;;^UTILITY(U,$J,358.3,2631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2631,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2631,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,2631,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,2632,0)
 ;;=F17.299^^18^205^26
 ;;^UTILITY(U,$J,358.3,2632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2632,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,2632,1,4,0)
 ;;=4^F17.299
 ;;^UTILITY(U,$J,358.3,2632,2)
 ;;=^5003379
 ;;^UTILITY(U,$J,358.3,2633,0)
 ;;=F17.293^^18^205^27
 ;;^UTILITY(U,$J,358.3,2633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2633,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,2633,1,4,0)
 ;;=4^F17.293
 ;;^UTILITY(U,$J,358.3,2633,2)
 ;;=^5003377
 ;;^UTILITY(U,$J,358.3,2634,0)
 ;;=F17.201^^18^205^31
 ;;^UTILITY(U,$J,358.3,2634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2634,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,in Remission
 ;;^UTILITY(U,$J,358.3,2634,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,2634,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,2635,0)
 ;;=F17.200^^18^205^30
 ;;^UTILITY(U,$J,358.3,2635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2635,1,3,0)
 ;;=3^Nicotine Dependence,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2635,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,2635,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,2636,0)
 ;;=F17.209^^18^205^28
 ;;^UTILITY(U,$J,358.3,2636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2636,1,3,0)
 ;;=3^Nicotine Dependence,Unspec w/ Unspec Disorders
