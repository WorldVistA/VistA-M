IBDEI1B6 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21156,1,3,0)
 ;;=3^Nicotine Dependence,Unspec
 ;;^UTILITY(U,$J,358.3,21156,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,21156,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,21157,0)
 ;;=F17.201^^70^908^66
 ;;^UTILITY(U,$J,358.3,21157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21157,1,3,0)
 ;;=3^Nicotine Dependence In Remission
 ;;^UTILITY(U,$J,358.3,21157,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,21157,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,21158,0)
 ;;=F17.203^^70^908^68
 ;;^UTILITY(U,$J,358.3,21158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21158,1,3,0)
 ;;=3^Nicotine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,21158,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,21158,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,21159,0)
 ;;=F17.208^^70^908^67
 ;;^UTILITY(U,$J,358.3,21159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21159,1,3,0)
 ;;=3^Nicotine Dependence w/ Nicotine-Induced Disorders
 ;;^UTILITY(U,$J,358.3,21159,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,21159,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,21160,0)
 ;;=F17.210^^70^908^69
 ;;^UTILITY(U,$J,358.3,21160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21160,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes
 ;;^UTILITY(U,$J,358.3,21160,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,21160,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,21161,0)
 ;;=F17.211^^70^908^70
 ;;^UTILITY(U,$J,358.3,21161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21161,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes in Remission
 ;;^UTILITY(U,$J,358.3,21161,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,21161,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,21162,0)
 ;;=F17.213^^70^908^73
 ;;^UTILITY(U,$J,358.3,21162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21162,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,21162,1,4,0)
 ;;=4^F17.213
 ;;^UTILITY(U,$J,358.3,21162,2)
 ;;=^5003367
 ;;^UTILITY(U,$J,358.3,21163,0)
 ;;=F17.218^^70^908^72
 ;;^UTILITY(U,$J,358.3,21163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21163,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Other Disorders
 ;;^UTILITY(U,$J,358.3,21163,1,4,0)
 ;;=4^F17.218
 ;;^UTILITY(U,$J,358.3,21163,2)
 ;;=^5003368
 ;;^UTILITY(U,$J,358.3,21164,0)
 ;;=F17.219^^70^908^71
 ;;^UTILITY(U,$J,358.3,21164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21164,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes w/ Nicotine-Induced Disorders
 ;;^UTILITY(U,$J,358.3,21164,1,4,0)
 ;;=4^F17.219
 ;;^UTILITY(U,$J,358.3,21164,2)
 ;;=^5003369
 ;;^UTILITY(U,$J,358.3,21165,0)
 ;;=J98.09^^70^908^25
 ;;^UTILITY(U,$J,358.3,21165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21165,1,3,0)
 ;;=3^Bronchus Diseases NEC
 ;;^UTILITY(U,$J,358.3,21165,1,4,0)
 ;;=4^J98.09
 ;;^UTILITY(U,$J,358.3,21165,2)
 ;;=^5008359
 ;;^UTILITY(U,$J,358.3,21166,0)
 ;;=A15.0^^70^908^114
 ;;^UTILITY(U,$J,358.3,21166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21166,1,3,0)
 ;;=3^Tuberculosis of Lung
 ;;^UTILITY(U,$J,358.3,21166,1,4,0)
 ;;=4^A15.0
 ;;^UTILITY(U,$J,358.3,21166,2)
 ;;=^5000062
 ;;^UTILITY(U,$J,358.3,21167,0)
 ;;=J05.0^^70^908^48
 ;;^UTILITY(U,$J,358.3,21167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21167,1,3,0)
 ;;=3^Laryngitis,Obstructive,Acute
 ;;^UTILITY(U,$J,358.3,21167,1,4,0)
 ;;=4^J05.0
 ;;^UTILITY(U,$J,358.3,21167,2)
 ;;=^5008141
 ;;^UTILITY(U,$J,358.3,21168,0)
 ;;=J06.9^^70^908^104
 ;;^UTILITY(U,$J,358.3,21168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21168,1,3,0)
 ;;=3^Respiratory Infection,Upper,Acute
