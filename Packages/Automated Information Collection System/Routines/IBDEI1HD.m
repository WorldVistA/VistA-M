IBDEI1HD ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23673,1,4,0)
 ;;=4^F13.11
 ;;^UTILITY(U,$J,358.3,23673,2)
 ;;=^331938
 ;;^UTILITY(U,$J,358.3,23674,0)
 ;;=F17.200^^105^1184^1
 ;;^UTILITY(U,$J,358.3,23674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23674,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,23674,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,23674,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,23675,0)
 ;;=F17.201^^105^1184^2
 ;;^UTILITY(U,$J,358.3,23675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23675,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,23675,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,23675,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,23676,0)
 ;;=F17.203^^105^1184^3
 ;;^UTILITY(U,$J,358.3,23676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23676,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,23676,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,23676,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,23677,0)
 ;;=F17.210^^105^1184^4
 ;;^UTILITY(U,$J,358.3,23677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23677,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23677,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,23677,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,23678,0)
 ;;=F17.211^^105^1184^5
 ;;^UTILITY(U,$J,358.3,23678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23678,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,23678,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,23678,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,23679,0)
 ;;=F17.220^^105^1184^6
 ;;^UTILITY(U,$J,358.3,23679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23679,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23679,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,23679,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,23680,0)
 ;;=F17.221^^105^1184^7
 ;;^UTILITY(U,$J,358.3,23680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23680,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,23680,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,23680,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,23681,0)
 ;;=F17.290^^105^1184^8
 ;;^UTILITY(U,$J,358.3,23681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23681,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,23681,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,23681,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,23682,0)
 ;;=F17.291^^105^1184^9
 ;;^UTILITY(U,$J,358.3,23682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23682,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,23682,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,23682,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,23683,0)
 ;;=E03.9^^105^1185^40
 ;;^UTILITY(U,$J,358.3,23683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23683,1,3,0)
 ;;=3^Hypothyroidism
 ;;^UTILITY(U,$J,358.3,23683,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,23683,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,23684,0)
 ;;=E05.90^^105^1185^48
 ;;^UTILITY(U,$J,358.3,23684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23684,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis or Storm
 ;;^UTILITY(U,$J,358.3,23684,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,23684,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,23685,0)
 ;;=E05.91^^105^1185^47
 ;;^UTILITY(U,$J,358.3,23685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23685,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/ Thyrotoxic Crisis or Storm
