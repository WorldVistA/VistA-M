IBDEI0MW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10681,0)
 ;;=F39.^^47^519^14
 ;;^UTILITY(U,$J,358.3,10681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10681,1,3,0)
 ;;=3^Mood Affective Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10681,1,4,0)
 ;;=4^F39.
 ;;^UTILITY(U,$J,358.3,10681,2)
 ;;=^5003541
 ;;^UTILITY(U,$J,358.3,10682,0)
 ;;=F06.30^^47^519^15
 ;;^UTILITY(U,$J,358.3,10682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10682,1,3,0)
 ;;=3^Mood Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,10682,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,10682,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,10683,0)
 ;;=F17.221^^47^519^19
 ;;^UTILITY(U,$J,358.3,10683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10683,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,in Remission
 ;;^UTILITY(U,$J,358.3,10683,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,10683,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,10684,0)
 ;;=F17.220^^47^519^18
 ;;^UTILITY(U,$J,358.3,10684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10684,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10684,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,10684,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,10685,0)
 ;;=F17.229^^47^519^16
 ;;^UTILITY(U,$J,358.3,10685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10685,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,10685,1,4,0)
 ;;=4^F17.229
 ;;^UTILITY(U,$J,358.3,10685,2)
 ;;=^5003374
 ;;^UTILITY(U,$J,358.3,10686,0)
 ;;=F17.223^^47^519^17
 ;;^UTILITY(U,$J,358.3,10686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10686,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10686,1,4,0)
 ;;=4^F17.223
 ;;^UTILITY(U,$J,358.3,10686,2)
 ;;=^5003372
 ;;^UTILITY(U,$J,358.3,10687,0)
 ;;=F17.211^^47^519^23
 ;;^UTILITY(U,$J,358.3,10687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10687,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,in Remission
 ;;^UTILITY(U,$J,358.3,10687,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,10687,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,10688,0)
 ;;=F17.210^^47^519^22
 ;;^UTILITY(U,$J,358.3,10688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10688,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10688,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,10688,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,10689,0)
 ;;=F17.219^^47^519^20
 ;;^UTILITY(U,$J,358.3,10689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10689,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,10689,1,4,0)
 ;;=4^F17.219
 ;;^UTILITY(U,$J,358.3,10689,2)
 ;;=^5003369
 ;;^UTILITY(U,$J,358.3,10690,0)
 ;;=F17.213^^47^519^21
 ;;^UTILITY(U,$J,358.3,10690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10690,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10690,1,4,0)
 ;;=4^F17.213
 ;;^UTILITY(U,$J,358.3,10690,2)
 ;;=^5003367
 ;;^UTILITY(U,$J,358.3,10691,0)
 ;;=F17.291^^47^519^24
 ;;^UTILITY(U,$J,358.3,10691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10691,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,in Remission
 ;;^UTILITY(U,$J,358.3,10691,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,10691,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,10692,0)
 ;;=F17.290^^47^519^25
 ;;^UTILITY(U,$J,358.3,10692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10692,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,10692,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,10692,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,10693,0)
 ;;=F17.299^^47^519^26
 ;;^UTILITY(U,$J,358.3,10693,1,0)
 ;;=^358.31IA^4^2
