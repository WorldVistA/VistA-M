IBDEI1XB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32206,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32206,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,32206,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,32207,0)
 ;;=F13.24^^141^1506^9
 ;;^UTILITY(U,$J,358.3,32207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32207,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,32207,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,32207,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,32208,0)
 ;;=F13.231^^141^1506^6
 ;;^UTILITY(U,$J,358.3,32208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32208,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,32208,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,32208,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,32209,0)
 ;;=F17.200^^141^1507^1
 ;;^UTILITY(U,$J,358.3,32209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32209,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32209,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,32209,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,32210,0)
 ;;=F17.201^^141^1507^2
 ;;^UTILITY(U,$J,358.3,32210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32210,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,32210,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,32210,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,32211,0)
 ;;=F17.203^^141^1507^3
 ;;^UTILITY(U,$J,358.3,32211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32211,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,32211,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,32211,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,32212,0)
 ;;=F17.210^^141^1507^4
 ;;^UTILITY(U,$J,358.3,32212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32212,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32212,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,32212,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,32213,0)
 ;;=F17.211^^141^1507^5
 ;;^UTILITY(U,$J,358.3,32213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32213,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,32213,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,32213,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,32214,0)
 ;;=F17.220^^141^1507^6
 ;;^UTILITY(U,$J,358.3,32214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32214,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32214,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,32214,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,32215,0)
 ;;=F17.221^^141^1507^7
 ;;^UTILITY(U,$J,358.3,32215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32215,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,32215,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,32215,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,32216,0)
 ;;=F17.290^^141^1507^8
 ;;^UTILITY(U,$J,358.3,32216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32216,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32216,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,32216,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,32217,0)
 ;;=F17.291^^141^1507^9
 ;;^UTILITY(U,$J,358.3,32217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32217,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,32217,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,32217,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,32218,0)
 ;;=F14.10^^141^1508^1
 ;;^UTILITY(U,$J,358.3,32218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32218,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
