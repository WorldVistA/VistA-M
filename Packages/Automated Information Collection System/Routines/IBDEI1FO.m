IBDEI1FO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24357,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,24357,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,24358,0)
 ;;=F13.182^^90^1067^8
 ;;^UTILITY(U,$J,358.3,24358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24358,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24358,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,24358,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,24359,0)
 ;;=F13.20^^90^1067^2
 ;;^UTILITY(U,$J,358.3,24359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24359,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24359,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,24359,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,24360,0)
 ;;=F13.21^^90^1067^3
 ;;^UTILITY(U,$J,358.3,24360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24360,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24360,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,24360,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,24361,0)
 ;;=F13.232^^90^1067^4
 ;;^UTILITY(U,$J,358.3,24361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24361,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24361,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,24361,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,24362,0)
 ;;=F13.239^^90^1067^5
 ;;^UTILITY(U,$J,358.3,24362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24362,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24362,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,24362,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,24363,0)
 ;;=F13.24^^90^1067^9
 ;;^UTILITY(U,$J,358.3,24363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24363,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,24363,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,24363,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,24364,0)
 ;;=F13.231^^90^1067^6
 ;;^UTILITY(U,$J,358.3,24364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24364,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,24364,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,24364,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,24365,0)
 ;;=F17.200^^90^1068^9
 ;;^UTILITY(U,$J,358.3,24365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24365,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24365,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,24365,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,24366,0)
 ;;=F17.201^^90^1068^10
 ;;^UTILITY(U,$J,358.3,24366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24366,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24366,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,24366,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,24367,0)
 ;;=F17.203^^90^1068^11
 ;;^UTILITY(U,$J,358.3,24367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24367,1,3,0)
 ;;=3^Nicotine Withdrawal
 ;;^UTILITY(U,$J,358.3,24367,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,24367,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,24368,0)
 ;;=F17.210^^90^1068^4
 ;;^UTILITY(U,$J,358.3,24368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24368,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24368,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,24368,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,24369,0)
 ;;=F17.211^^90^1068^3
 ;;^UTILITY(U,$J,358.3,24369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24369,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
