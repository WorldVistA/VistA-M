IBDEI34V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52586,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,52586,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,52586,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,52587,0)
 ;;=F13.24^^237^2620^9
 ;;^UTILITY(U,$J,358.3,52587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52587,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,52587,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,52587,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,52588,0)
 ;;=F13.231^^237^2620^6
 ;;^UTILITY(U,$J,358.3,52588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52588,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,52588,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,52588,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,52589,0)
 ;;=F17.200^^237^2621^1
 ;;^UTILITY(U,$J,358.3,52589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52589,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,52589,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,52589,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,52590,0)
 ;;=F17.201^^237^2621^2
 ;;^UTILITY(U,$J,358.3,52590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52590,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,52590,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,52590,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,52591,0)
 ;;=F17.203^^237^2621^3
 ;;^UTILITY(U,$J,358.3,52591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52591,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,52591,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,52591,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,52592,0)
 ;;=F17.210^^237^2621^4
 ;;^UTILITY(U,$J,358.3,52592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52592,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,52592,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,52592,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,52593,0)
 ;;=F17.211^^237^2621^5
 ;;^UTILITY(U,$J,358.3,52593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52593,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,52593,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,52593,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,52594,0)
 ;;=F17.220^^237^2621^6
 ;;^UTILITY(U,$J,358.3,52594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52594,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,52594,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,52594,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,52595,0)
 ;;=F17.221^^237^2621^7
 ;;^UTILITY(U,$J,358.3,52595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52595,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,52595,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,52595,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,52596,0)
 ;;=F17.290^^237^2621^8
 ;;^UTILITY(U,$J,358.3,52596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52596,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,52596,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,52596,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,52597,0)
 ;;=F17.291^^237^2621^9
 ;;^UTILITY(U,$J,358.3,52597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52597,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,52597,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,52597,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,52598,0)
 ;;=F14.10^^237^2622^1
 ;;^UTILITY(U,$J,358.3,52598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52598,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
